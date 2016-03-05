//
//  ViewController.m
//  ImageScrollEffect
//
//  Created by Danny Ho on 3/3/16.
//  Copyright © 2016 thanksdanny. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIScrollViewDelegate>
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation ViewController
#pragma mark - lazy
- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Steve"]];
    }
    return _imageView;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame]; //CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    }
    return _scrollView;
}

// 去除状态栏
- (BOOL)prefersStatusBarHidden{
    return YES;
}

#pragma mark - 抽取viewdidload里的方法
- (void)setUpScrollView {
    [self.scrollView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
    self.scrollView.contentSize = self.imageView.bounds.size;
    
    [self.scrollView addSubview:self.imageView]; // 嵌套进imageView
    [self.view addSubview:self.scrollView];
    NSLog(@"setUpScrollView");
}

- (void)setZoomScaleFor:(CGSize)scrollViewSize {
    CGSize  imageSize    = self.imageView.bounds.size;
    CGFloat widthScal    = scrollViewSize.width  / imageSize.width;
    CGFloat heightScal   = scrollViewSize.height / imageSize.height;
    CGFloat minimunScale = MIN(widthScal, heightScal); // 确实用MIN?
    
    self.scrollView.minimumZoomScale = minimunScale;
    self.scrollView.maximumZoomScale = 3.0;
    NSLog(@"setZoomScaleFor");
}

- (void)recenterImage {
    CGSize scrollViewSize = self.scrollView.bounds.size;
    CGSize imageViewSize = self.imageView.frame.size;
    CGFloat horizontalSpace = (imageViewSize.width < scrollViewSize.width) ? (scrollViewSize.width - imageViewSize.width) / 2.0 : 0;
    CGFloat verticalSpace = (imageViewSize.height < scrollViewSize.height) ? (scrollViewSize.height - imageViewSize.width) / 2.0 : 0;
    self.scrollView.contentInset = UIEdgeInsetsMake(verticalSpace, horizontalSpace, verticalSpace, horizontalSpace);
    NSLog(@"recenterImage");
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    NSLog(@"viewForZoomingInScrollView");
    return self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    NSLog(@"scrollViewDidZoom");
    [self recenterImage];
}

#pragma mark - view
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpScrollView];
    self.scrollView.delegate = self;
    
    [self setZoomScaleFor:self.scrollView.bounds.size];
    self.scrollView.zoomScale = self.scrollView.minimumZoomScale;
    
    [self recenterImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
