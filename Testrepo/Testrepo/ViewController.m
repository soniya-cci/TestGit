//
//  ViewController.m
//  Testrepo
//
//  Created by Soniya Gadekar on 04/08/14.
//  Copyright (c) 2014 Soniya Gadekar. All rights reserved.
//

#import "ViewController.h"
#import <Parse/Parse.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"im in viewcontroller");
    
    // ========create post object=========//
    PFObject *post = [PFObject objectWithClassName:@"Post"];
    post[@"title"]=@"Food";
    post[@"content"]=@"Delicious food in India";
    
    [post saveInBackground];
    
    // ======fetching post object data and updating the values ======
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query getObjectInBackgroundWithId:@"xlbZ0Heop4" block:^(PFObject *object, NSError *error) {
    NSLog(@"object at 0 pos is %@",object[@"title"]);
    NSLog(@"object  %@",[object objectForKey:@"title"]);
        object[@"title"]=@"Delicious food";
        
    NSLog(@"updated object  %@",[object objectForKey:@"title"]);
    }];
    
    //========= create comment object
    
    PFObject *comment = [PFObject objectWithClassName:@"Comment"];
    
    comment[@"title"]=@"Indian cuisine";
    comment[@"content"]=@"mouthwatering delicacies of Goa";
    comment[@"parent"]=post;
    
    [comment saveInBackground];
    
    
    PFQuery *commentQuery =[PFQuery queryWithClassName:@"Comment"];
    [commentQuery getObjectInBackgroundWithId:@"WUyHSw1PGL" block:^(PFObject *object, NSError *error) {
        NSLog(@"get comments");
    }];
    
    
    PFUser *user = [PFUser currentUser];
    PFRelation *relation =[user relationForKey:@"likes"];
    [relation addObject:post];
    
    [user saveInBackground];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title = Food"];
    PFQuery *getQuery=[PFQuery queryWithClassName:@"Post" predicate:predicate];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
