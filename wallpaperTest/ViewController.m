//
//  ViewController.m
//  wallpaperTest
//
//  Created by valiant on 2018/3/14.
//  Copyright © 2018年 valiant. All rights reserved.
//

#import "ViewController.h"
#import <Photos/Photos.h>
#import <PhotosUI/PhotosUI.h>

#define photoAssetCollectionName @"1234"

@interface ViewController ()

@property (nonatomic, strong) UIImageView *iv;
@property (nonatomic, strong) UIButton *button, *button2;
@property (nonatomic, strong) PHLivePhotoView *livePhotoView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.iv = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 150, 170)];
    self.iv.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.iv];
    
    self.livePhotoView = [[PHLivePhotoView alloc] initWithFrame:self.iv.frame];
    self.livePhotoView.contentMode = UIViewContentModeScaleAspectFill;
    self.livePhotoView.clipsToBounds = YES;
    [self.view addSubview:self.livePhotoView];
    
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button.frame = CGRectMake(100, 300, 100, 40);
    [self.button setTitle:@"download" forState:UIControlStateNormal];
    [self.button setBackgroundColor:[UIColor greenColor]];
    [self.view addSubview:self.button];
    [self.button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.button2.frame = CGRectMake(100, 400, 100, 40);
    [self.button2 setTitle:@"save" forState:UIControlStateNormal];
    [self.button2 setBackgroundColor:[UIColor greenColor]];
    [self.view addSubview:self.button2];
    [self.button2 addTarget:self action:@selector(button2Action) forControlEvents:UIControlEventTouchUpInside];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)buttonAction{
//    self.iv.image = [UIImage imageNamed:@"wp1.JPG"];
    
    [PHLivePhoto requestLivePhotoWithResourceFileURLs:@[[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"IMB_rz9Xy4" ofType:@"JPG"]], [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"IMB_rz9Xy4" ofType:@"mov"]]] placeholderImage:[UIImage imageNamed:@"IMB_rz9Xy4.JPG"] targetSize:self.livePhotoView.bounds.size contentMode:PHImageContentModeAspectFill resultHandler:^(PHLivePhoto * _Nullable livePhoto, NSDictionary * _Nonnull info) {
        self.livePhotoView.livePhoto = livePhoto;
    }];
}
- (void)button2Action{
//    [self save2WithPhotoUrl:[[NSBundle mainBundle] pathForResource:@"wp1" ofType:@"JPG"] videoUrl:[[NSBundle mainBundle] pathForResource:@"wp1" ofType:@"MOV"]];
//    [self save2WithPhotoUrl:[[NSBundle mainBundle] pathForResource:@"np" ofType:@"JPG"] videoUrl:[[NSBundle mainBundle] pathForResource:@"wp" ofType:@"MOV"]];
    [self save2WithPhotoUrl:[[NSBundle mainBundle] pathForResource:@"IMB_rz9Xy4" ofType:@"JPG"] videoUrl:[[NSBundle mainBundle] pathForResource:@"IMB_rz9Xy4" ofType:@"mov"]];
}



- (void)save2WithPhotoUrl:(NSString *)photoURLstring videoUrl:(NSString *)videoURLstring{
    NSURL *photoURL = [NSURL fileURLWithPath:photoURLstring];//@"...picture.jpg"
    NSURL *videoURL = [NSURL fileURLWithPath:videoURLstring];//@"...video.mov"
    
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        PHAssetCreationRequest *request = [PHAssetCreationRequest creationRequestForAsset];
        [request addResourceWithType:PHAssetResourceTypePhoto
                             fileURL:photoURL
                             options:nil];
        [request addResourceWithType:PHAssetResourceTypePairedVideo
                             fileURL:videoURL
                             options:nil];
        
    } completionHandler:^(BOOL success,
                          NSError * _Nullable error) {
        if (success) {
            NSLog(@"save success");
        } else {
            NSLog(@"error: %@",error);
        }
    }];
}





@end
