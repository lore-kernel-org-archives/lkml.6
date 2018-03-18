Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754169AbeCRPvW (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 11:51:22 -0400
Received: from smtprelay0238.hostedemail.com ([216.40.44.238]:60454 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753381AbeCRPvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 11:51:19 -0400
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::,RULES_HIT:2:41:69:355:379:541:599:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1535:1593:1594:1605:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3622:3865:3866:3867:3868:4031:4051:4120:4321:4605:5007:6119:7903:8957:9592:10004:10848:11026:11232:11233:11473:11658:11914:12043:12438:12555:12683:12740:12760:12895:12986:13439:14659:21060:21080:21627:21740:21773:30012:30054:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.14.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: sleep01_2852a1cdd3b4a
X-Filterd-Recvd-Size: 9566
Message-ID: <1521388275.27411.6.camel@perches.com>
Subject: Re: [PATCH] Staging: xgifb: XGI_main_26.c: Fixed over 80 column
 characters
From: Joe Perches <joe@perches.com>
To: Pratik Jain <pratik.jain0509@gmail.com>, arnaud.patard@rtp-net.org
Cc: trivial@kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 18 Mar 2018 08:51:15 -0700
In-Reply-To: <20180318110606.27753-1-pratik.jain0509@gmail.com>
References: <20180318110606.27753-1-pratik.jain0509@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-03-18 at 16:36 +0530, Pratik Jain wrote:
> Fixed coding style issues detected by checkpatch.pl

Hi.  Rather than just following what checkpatch says,
try to look for opportunities to improve the code a bit.

Instead of wrapping, try unwrapping by unindenting blocks.

> diff --git a/drivers/staging/xgifb/XGI_main_26.c b/drivers/staging/xgifb/XGI_main_26.c

> []
> @@ -770,7 +770,9 @@ static void XGIfb_post_setmode(struct xgifb_video_info *xgifb_info)
>  				xgifb_reg_and(vb->Part2Port, 0x3a, 0x1f);
>  
>  				if (xgifb_info->TV_plug == TVPLUG_SVIDEO) {
> -					xgifb_reg_and(vb->Part2Port, 0x30, 0xdf);
> +					xgifb_reg_and(vb->Part2Port,
> +							0x30,
> +							0xdf);
>  
>  				} else if (xgifb_info->TV_plug
>  						== TVPLUG_COMPOSITE) {

For instance, these tests could return early and
so unindent the blocks and could be:
---
 drivers/staging/xgifb/XGI_main_26.c | 225 ++++++++++++++----------------------
 1 file changed, 86 insertions(+), 139 deletions(-)

diff --git a/drivers/staging/xgifb/XGI_main_26.c b/drivers/staging/xgifb/XGI_main_26.c
index 10107de0119a..73e389b8156f 100644
--- a/drivers/staging/xgifb/XGI_main_26.c
+++ b/drivers/staging/xgifb/XGI_main_26.c
@@ -697,6 +697,7 @@ static void XGIfb_post_setmode(struct xgifb_video_info *xgifb_info)
 	struct vb_device_info *vb = &xgifb_info->dev_info;
 	u8 reg;
 	unsigned char doit = 1;
+	int filter_tb;
 
 	if (xgifb_info->video_bpp == 8) {
 		/*
@@ -735,162 +736,108 @@ static void XGIfb_post_setmode(struct xgifb_video_info *xgifb_info)
 
 	xgifb_reg_and(vb->P3c4, IND_SIS_RAMDAC_CONTROL, ~0x04);
 
-	if (xgifb_info->display2 == XGIFB_DISP_TV &&
-	    xgifb_info->hasVB == HASVB_301) {
-		reg = xgifb_reg_get(vb->Part4Port, 0x01);
+	if (xgifb_info->display2 != XGIFB_DISP_TV ||
+	    xgifb_info->hasVB != HASVB_301)
+		return;
 
-		if (reg < 0xB0) { /* Set filter for XGI301 */
-			int filter_tb;
+	reg = xgifb_reg_get(vb->Part4Port, 0x01);
+	if (reg >= 0xB0)
+		return;
+
+	/* Set filter for XGI301 */
+
+	switch (xgifb_info->video_width) {
+	case 320:
+		filter_tb = (xgifb_info->TV_type == TVMODE_NTSC) ? 4 : 12;
+		break;
+	case 640:
+		filter_tb = (xgifb_info->TV_type == TVMODE_NTSC) ? 5 : 13;
+		break;
+	case 720:
+		filter_tb = (xgifb_info->TV_type == TVMODE_NTSC) ? 6 : 14;
+		break;
+	case 800:
+		filter_tb = (xgifb_info->TV_type == TVMODE_NTSC) ? 7 : 15;
+		break;
+	default:
+		filter_tb = 0;
+		filter = -1;
+		break;
+	}
+	xgifb_reg_or(vb->Part1Port, SIS_CRT2_WENABLE_315, 0x01);
+
+	if (xgifb_info->TV_type == TVMODE_NTSC) {
+		xgifb_reg_and(vb->Part2Port, 0x3a, 0x1f);
+
+		if (xgifb_info->TV_plug == TVPLUG_SVIDEO) {
+			xgifb_reg_and(vb->Part2Port, 0x30, 0xdf);
+
+		} else if (xgifb_info->TV_plug == TVPLUG_COMPOSITE) {
+			xgifb_reg_or(vb->Part2Port, 0x30, 0x20);
 
 			switch (xgifb_info->video_width) {
-			case 320:
-				filter_tb = (xgifb_info->TV_type ==
-					     TVMODE_NTSC) ? 4 : 12;
-				break;
 			case 640:
-				filter_tb = (xgifb_info->TV_type ==
-					     TVMODE_NTSC) ? 5 : 13;
+				xgifb_reg_set(vb->Part2Port, 0x35, 0xEB);
+				xgifb_reg_set(vb->Part2Port, 0x36, 0x04);
+				xgifb_reg_set(vb->Part2Port, 0x37, 0x25);
+				xgifb_reg_set(vb->Part2Port, 0x38, 0x18);
 				break;
 			case 720:
-				filter_tb = (xgifb_info->TV_type ==
-					     TVMODE_NTSC) ? 6 : 14;
+				xgifb_reg_set(vb->Part2Port, 0x35, 0xEE);
+				xgifb_reg_set(vb->Part2Port, 0x36, 0x0C);
+				xgifb_reg_set(vb->Part2Port, 0x37, 0x22);
+				xgifb_reg_set(vb->Part2Port, 0x38, 0x08);
 				break;
 			case 800:
-				filter_tb = (xgifb_info->TV_type ==
-					     TVMODE_NTSC) ? 7 : 15;
-				break;
-			default:
-				filter_tb = 0;
-				filter = -1;
+				xgifb_reg_set(vb->Part2Port, 0x35, 0xEB);
+				xgifb_reg_set(vb->Part2Port, 0x36, 0x15);
+				xgifb_reg_set(vb->Part2Port, 0x37, 0x25);
+				xgifb_reg_set(vb->Part2Port, 0x38, 0xF6);
 				break;
 			}
-			xgifb_reg_or(vb->Part1Port, SIS_CRT2_WENABLE_315, 0x01);
+		}
 
-			if (xgifb_info->TV_type == TVMODE_NTSC) {
-				xgifb_reg_and(vb->Part2Port, 0x3a, 0x1f);
-
-				if (xgifb_info->TV_plug == TVPLUG_SVIDEO) {
-					xgifb_reg_and(vb->Part2Port, 0x30, 0xdf);
-
-				} else if (xgifb_info->TV_plug
-						== TVPLUG_COMPOSITE) {
-					xgifb_reg_or(vb->Part2Port, 0x30, 0x20);
-
-					switch (xgifb_info->video_width) {
-					case 640:
-						xgifb_reg_set(vb->Part2Port,
-							      0x35,
-							      0xEB);
-						xgifb_reg_set(vb->Part2Port,
-							      0x36,
-							      0x04);
-						xgifb_reg_set(vb->Part2Port,
-							      0x37,
-							      0x25);
-						xgifb_reg_set(vb->Part2Port,
-							      0x38,
-							      0x18);
-						break;
-					case 720:
-						xgifb_reg_set(vb->Part2Port,
-							      0x35,
-							      0xEE);
-						xgifb_reg_set(vb->Part2Port,
-							      0x36,
-							      0x0C);
-						xgifb_reg_set(vb->Part2Port,
-							      0x37,
-							      0x22);
-						xgifb_reg_set(vb->Part2Port,
-							      0x38,
-							      0x08);
-						break;
-					case 800:
-						xgifb_reg_set(vb->Part2Port,
-							      0x35,
-							      0xEB);
-						xgifb_reg_set(vb->Part2Port,
-							      0x36,
-							      0x15);
-						xgifb_reg_set(vb->Part2Port,
-							      0x37,
-							      0x25);
-						xgifb_reg_set(vb->Part2Port,
-							      0x38,
-							      0xF6);
-						break;
-					}
-				}
+	} else if (xgifb_info->TV_type == TVMODE_PAL) {
+		xgifb_reg_and(vb->Part2Port, 0x3A, 0x1F);
 
-			} else if (xgifb_info->TV_type == TVMODE_PAL) {
-				xgifb_reg_and(vb->Part2Port, 0x3A, 0x1F);
-
-				if (xgifb_info->TV_plug == TVPLUG_SVIDEO) {
-					xgifb_reg_and(vb->Part2Port, 0x30, 0xDF);
-
-				} else if (xgifb_info->TV_plug
-						== TVPLUG_COMPOSITE) {
-					xgifb_reg_or(vb->Part2Port, 0x30, 0x20);
-
-					switch (xgifb_info->video_width) {
-					case 640:
-						xgifb_reg_set(vb->Part2Port,
-							      0x35,
-							      0xF1);
-						xgifb_reg_set(vb->Part2Port,
-							      0x36,
-							      0xF7);
-						xgifb_reg_set(vb->Part2Port,
-							      0x37,
-							      0x1F);
-						xgifb_reg_set(vb->Part2Port,
-							      0x38,
-							      0x32);
-						break;
-					case 720:
-						xgifb_reg_set(vb->Part2Port,
-							      0x35,
-							      0xF3);
-						xgifb_reg_set(vb->Part2Port,
-							      0x36,
-							      0x00);
-						xgifb_reg_set(vb->Part2Port,
-							      0x37,
-							      0x1D);
-						xgifb_reg_set(vb->Part2Port,
-							      0x38,
-							      0x20);
-						break;
-					case 800:
-						xgifb_reg_set(vb->Part2Port,
-							      0x35,
-							      0xFC);
-						xgifb_reg_set(vb->Part2Port,
-							      0x36,
-							      0xFB);
-						xgifb_reg_set(vb->Part2Port,
-							      0x37,
-							      0x14);
-						xgifb_reg_set(vb->Part2Port,
-							      0x38,
-							      0x2A);
-						break;
-					}
-				}
-			}
+		if (xgifb_info->TV_plug == TVPLUG_SVIDEO) {
+			xgifb_reg_and(vb->Part2Port, 0x30, 0xDF);
 
-			if ((filter >= 0) && (filter <= 7)) {
-				const u8 *f = XGI_TV_filter[filter_tb].filter[filter];
+		} else if (xgifb_info->TV_plug == TVPLUG_COMPOSITE) {
+			xgifb_reg_or(vb->Part2Port, 0x30, 0x20);
 
-				pr_debug("FilterTable[%d]-%d: %*ph\n",
-					 filter_tb, filter, 4, f);
-				xgifb_reg_set(vb->Part2Port, 0x35, f[0]);
-				xgifb_reg_set(vb->Part2Port, 0x36, f[1]);
-				xgifb_reg_set(vb->Part2Port, 0x37, f[2]);
-				xgifb_reg_set(vb->Part2Port, 0x38, f[3]);
+			switch (xgifb_info->video_width) {
+			case 640:
+				xgifb_reg_set(vb->Part2Port, 0x35, 0xF1);
+				xgifb_reg_set(vb->Part2Port, 0x36, 0xF7);
+				xgifb_reg_set(vb->Part2Port, 0x37, 0x1F);
+				xgifb_reg_set(vb->Part2Port, 0x38, 0x32);
+				break;
+			case 720:
+				xgifb_reg_set(vb->Part2Port, 0x35, 0xF3);
+				xgifb_reg_set(vb->Part2Port, 0x36, 0x00);
+				xgifb_reg_set(vb->Part2Port, 0x37, 0x1D);
+				xgifb_reg_set(vb->Part2Port, 0x38, 0x20);
+				break;
+			case 800:
+				xgifb_reg_set(vb->Part2Port, 0x35, 0xFC);
+				xgifb_reg_set(vb->Part2Port, 0x36, 0xFB);
+				xgifb_reg_set(vb->Part2Port, 0x37, 0x14);
+				xgifb_reg_set(vb->Part2Port, 0x38, 0x2A);
+				break;
 			}
 		}
 	}
+
+	if ((filter >= 0) && (filter <= 7)) {
+		const u8 *f = XGI_TV_filter[filter_tb].filter[filter];
+
+		pr_debug("FilterTable[%d]-%d: %*ph\n", filter_tb, filter, 4, f);
+		xgifb_reg_set(vb->Part2Port, 0x35, f[0]);
+		xgifb_reg_set(vb->Part2Port, 0x36, f[1]);
+		xgifb_reg_set(vb->Part2Port, 0x37, f[2]);
+		xgifb_reg_set(vb->Part2Port, 0x38, f[3]);
+	}
 }
 
 static int XGIfb_do_set_var(struct fb_var_screeninfo *var, int isactive,
