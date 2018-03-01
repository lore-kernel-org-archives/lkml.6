Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967911AbeCAMB3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 07:01:29 -0500
Received: from smtprelay0185.hostedemail.com ([216.40.44.185]:40621 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S967863AbeCAMB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 07:01:28 -0500
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::,RULES_HIT:41:69:355:379:541:800:960:968:973:988:989:1260:1345:1437:1534:1542:1711:1730:1747:1777:1792:2393:2559:2562:2743:3138:3139:3140:3141:3142:3354:3867:3868:4250:4321:5007:6261:10004:10848:11026:11473:11658:11914:12438:12555:12679:12895:12986:13095:13138:13231:14181:14394:14721:21080:21433:21451:21524:21627:30012:30054:30080,0,RBL:46.188.150.148:@perches.com:.lbl8.mailshell.net-62.8.110.190 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: scent75_63c14d4df6435
X-Filterd-Recvd-Size: 3243
From: Joe Perches <joe@perches.com>
To: linux-kernel@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Subject: [PATCH] media: tw9910: Miscellaneous neatening
Date: Thu,  1 Mar 2018 04:01:22 -0800
Message-Id: <45c4aeef9d2f00b95ba762ad80b4afc2fc60e846.1519905664.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yet more whitespace and style neatening

o Add blank lines before returns
o Reverse a logic test and return early on error
o Move formats to same line as dev_<level> calls
o Remove an unnecessary period from a logging message

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/media/i2c/tw9910.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/media/i2c/tw9910.c b/drivers/media/i2c/tw9910.c
index ab32cd81ebd0..cc648deb8123 100644
--- a/drivers/media/i2c/tw9910.c
+++ b/drivers/media/i2c/tw9910.c
@@ -752,6 +752,7 @@ static int tw9910_get_selection(struct v4l2_subdev *sd,
 		sel->r.width	= 768;
 		sel->r.height	= 576;
 	}
+
 	return 0;
 }
 
@@ -799,11 +800,13 @@ static int tw9910_s_fmt(struct v4l2_subdev *sd,
 	mf->colorspace = V4L2_COLORSPACE_SMPTE170M;
 
 	ret = tw9910_set_frame(sd, &width, &height);
-	if (!ret) {
-		mf->width	= width;
-		mf->height	= height;
-	}
-	return ret;
+	if (ret)
+		return ret;
+
+	mf->width	= width;
+	mf->height	= height;
+
+	return 0;
 }
 
 static int tw9910_set_fmt(struct v4l2_subdev *sd,
@@ -821,7 +824,7 @@ static int tw9910_set_fmt(struct v4l2_subdev *sd,
 	if (mf->field == V4L2_FIELD_ANY) {
 		mf->field = V4L2_FIELD_INTERLACED_BT;
 	} else if (mf->field != V4L2_FIELD_INTERLACED_BT) {
-		dev_err(&client->dev, "Field type %d invalid.\n", mf->field);
+		dev_err(&client->dev, "Field type %d invalid\n", mf->field);
 		return -EINVAL;
 	}
 
@@ -840,7 +843,9 @@ static int tw9910_set_fmt(struct v4l2_subdev *sd,
 
 	if (format->which == V4L2_SUBDEV_FORMAT_ACTIVE)
 		return tw9910_s_fmt(sd, mf);
+
 	cfg->try_fmt = *mf;
+
 	return 0;
 }
 
@@ -871,21 +876,21 @@ static int tw9910_video_probe(struct i2c_client *client)
 	id = GET_ID(id);
 
 	if (id != 0x0b || priv->revision > 0x01) {
-		dev_err(&client->dev,
-			"Product ID error %x:%x\n",
+		dev_err(&client->dev, "Product ID error %x:%x\n",
 			id, priv->revision);
 		ret = -ENODEV;
 		goto done;
 	}
 
-	dev_info(&client->dev,
-		 "tw9910 Product ID %0x:%0x\n", id, priv->revision);
+	dev_info(&client->dev, "tw9910 Product ID %0x:%0x\n",
+		 id, priv->revision);
 
 	priv->norm = V4L2_STD_NTSC;
 	priv->scale = &tw9910_ntsc_scales[0];
 
 done:
 	tw9910_s_power(&priv->subdev, 0);
+
 	return ret;
 }
 
@@ -905,12 +910,14 @@ static int tw9910_enum_mbus_code(struct v4l2_subdev *sd,
 		return -EINVAL;
 
 	code->code = MEDIA_BUS_FMT_UYVY8_2X8;
+
 	return 0;
 }
 
 static int tw9910_g_tvnorms(struct v4l2_subdev *sd, v4l2_std_id *norm)
 {
 	*norm = V4L2_STD_NTSC | V4L2_STD_PAL;
+
 	return 0;
 }
 
-- 
2.15.0
