Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A92CC6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:51:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3400927C36
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:51:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ruI40RSt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3400927C36
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755602AbeF2Svx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 14:51:53 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35818 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753483AbeF2Svu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 14:51:50 -0400
Received: by mail-pf0-f194.google.com with SMTP id a24-v6so962106pfo.2;
        Fri, 29 Jun 2018 11:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/jcORsDlJj5odAZjHflLJVmmzfOyQY816PdynHEaDk4=;
        b=ruI40RStaWUcLxn0OIxhbKgxB2a9wbJ5crAlzu72voi1bGTpdRxmf6lfhSEOdNCBVp
         IaYIMdRRHfA6ExyPNfsoAu8AqAsAabyKWNyxQCvO2fXQfv8i8kbqnrwS1P6AbocuGYPO
         32Z4rm1pLXTFBtrU/Fk9JFvzGHtgnh/wydBcGVaCaiO1wX7isWucTo22czXNuwwr/fha
         4Z6xAWut69wzTO6VSbDnyVqPt2gH5D4YQWWEaRbWhNPtm1G9rP0+HW1DikqBwG+pzwUz
         693FrSYeJUs5u+PE3nU2iIiAgNAvOn5qfGm13pSUYThVhRb4a5wJD9mc28CY2kIYZEd5
         LCww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/jcORsDlJj5odAZjHflLJVmmzfOyQY816PdynHEaDk4=;
        b=keXFpWfx3UTcIsDLiXSSPYhzGZHXliXQZEQF+QxGylqJFwDbsZJf8W1oJe/Rw/3Rm7
         2117i6p+fnQQIsMV9WQlQ/fYb+uF29MbpzHuYCiya9m6pA8yio8IYqD3gzhrswXhf5bO
         UYpu+kqeAkgDJqgzYmodtyKRXvQlvJUEl/yT1EKb2/L+mt08iZ3tqhmLvWmgbooQW2Ud
         GZQKd8SyBfuwzQ0gxK2spvAzlfWo6p82GgMK6C0EkNsndIr6SoUcIruX4iAdgw895OVA
         rGk2g+z0jKsf99+BjeIp9i3IpvrasT8SIEQdD3JIGb5xZYl1/LlBo4EYUhCZn4+g9fXq
         8B7w==
X-Gm-Message-State: APt69E2hYBMCckF3PC4XqgdOMPnSIuzW6LDWfhkzqobvkQZXeTwN8yCZ
        4KGKkM42jmndoRzj0OV+pZHtOQ==
X-Google-Smtp-Source: AAOMgpeM8buXo1de0FWMc1R/X9uszDRE9vJfIsFqEoTsfNQrQ2lDeV0tcefZVRk9fyuAu7EHRoCmiw==
X-Received: by 2002:a62:9c9c:: with SMTP id u28-v6mr15792449pfk.90.1530298309419;
        Fri, 29 Jun 2018 11:51:49 -0700 (PDT)
Received: from mappy.world.mentorg.com ([2602:306:cc3b:f020:7cd8:9ad7:a375:e853])
        by smtp.googlemail.com with ESMTPSA id k13-v6sm27672308pfg.130.2018.06.29.11.51.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 29 Jun 2018 11:51:48 -0700 (PDT)
From:   Steve Longerbeam <slongerbeam@gmail.com>
X-Google-Original-From: Steve Longerbeam <steve_longerbeam@mentor.com>
To:     linux-media@vger.kernel.org
Cc:     Steve Longerbeam <steve_longerbeam@mentor.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 07/17] media: platform: video-mux: Register a subdev notifier
Date:   Fri, 29 Jun 2018 11:49:51 -0700
Message-Id: <1530298220-5097-8-git-send-email-steve_longerbeam@mentor.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530298220-5097-1-git-send-email-steve_longerbeam@mentor.com>
References: <1530298220-5097-1-git-send-email-steve_longerbeam@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Parse neighbor remote devices on the video muxes input ports, add them to a
subdev notifier, and register the subdev notifier for the video mux, by
calling v4l2_async_register_fwnode_subdev().

Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
---
Changes since v4:
- none
Changes since v3:
- pass num_pads - 1 (num_input_pads) to video_mux_async_register().
Changes since v2:
- none
Changes since v1:
- add #include <linux/slab.h> for kcalloc() declaration.
---
 drivers/media/platform/video-mux.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/video-mux.c b/drivers/media/platform/video-mux.c
index 1fb8872..e54a719 100644
--- a/drivers/media/platform/video-mux.c
+++ b/drivers/media/platform/video-mux.c
@@ -21,8 +21,10 @@
 #include <linux/of.h>
 #include <linux/of_graph.h>
 #include <linux/platform_device.h>
+#include <linux/slab.h>
 #include <media/v4l2-async.h>
 #include <media/v4l2-device.h>
+#include <media/v4l2-fwnode.h>
 #include <media/v4l2-subdev.h>
 
 struct video_mux {
@@ -207,6 +209,38 @@ static const struct v4l2_subdev_ops video_mux_subdev_ops = {
 	.video = &video_mux_subdev_video_ops,
 };
 
+static int video_mux_parse_endpoint(struct device *dev,
+				    struct v4l2_fwnode_endpoint *vep,
+				    struct v4l2_async_subdev *asd)
+{
+	/*
+	 * it's not an error if remote is missing on a video-mux
+	 * input port, return -ENOTCONN to skip this endpoint with
+	 * no error.
+	 */
+	return fwnode_device_is_available(asd->match.fwnode) ? 0 : -ENOTCONN;
+}
+
+static int video_mux_async_register(struct video_mux *vmux,
+				    unsigned int num_input_pads)
+{
+	unsigned int i, *ports;
+	int ret;
+
+	ports = kcalloc(num_input_pads, sizeof(*ports), GFP_KERNEL);
+	if (!ports)
+		return -ENOMEM;
+	for (i = 0; i < num_input_pads; i++)
+		ports[i] = i;
+
+	ret = v4l2_async_register_fwnode_subdev(
+		&vmux->subdev, sizeof(struct v4l2_async_subdev),
+		ports, num_input_pads, video_mux_parse_endpoint);
+
+	kfree(ports);
+	return ret;
+}
+
 static int video_mux_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -272,7 +306,7 @@ static int video_mux_probe(struct platform_device *pdev)
 
 	vmux->subdev.entity.ops = &video_mux_ops;
 
-	return v4l2_async_register_subdev(&vmux->subdev);
+	return video_mux_async_register(vmux, num_pads - 1);
 }
 
 static int video_mux_remove(struct platform_device *pdev)
-- 
2.7.4

