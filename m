Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49897C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 11:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 092822089B
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 11:52:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 092822089B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732619AbeG0NOH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 09:14:07 -0400
Received: from bran.ispras.ru ([83.149.199.196]:19599 "EHLO smtp.ispras.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730126AbeG0NOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 09:14:06 -0400
Received: from myklebust.intra.ispras.ru (unknown [10.10.2.207])
        by smtp.ispras.ru (Postfix) with ESMTP id 872C4203B2;
        Fri, 27 Jul 2018 14:52:31 +0300 (MSK)
From:   Anton Vasilyev <vasilyev@ispras.ru>
To:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc:     Anton Vasilyev <vasilyev@ispras.ru>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: [PATCH] media: davinci: vpif_display: Mix memory leak on probe error path
Date:   Fri, 27 Jul 2018 14:52:20 +0300
Message-Id: <20180727115220.10991-1-vasilyev@ispras.ru>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If vpif_probe() fails on v4l2_device_register() then memory allocated
at initialize_vpif() for global vpif_obj.dev[i] become unreleased.

The patch adds deallocation of vpif_obj.dev[i] on the error path and
removes duplicated check on platform_data presence.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
---
 drivers/media/platform/davinci/vpif_display.c | 24 ++++++++++++-------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/media/platform/davinci/vpif_display.c b/drivers/media/platform/davinci/vpif_display.c
index 7be636237acf..0f324055cc9f 100644
--- a/drivers/media/platform/davinci/vpif_display.c
+++ b/drivers/media/platform/davinci/vpif_display.c
@@ -1114,6 +1114,14 @@ static int initialize_vpif(void)
 	return err;
 }
 
+static void free_vpif_objs(void)
+{
+	int i;
+
+	for (i = 0; i < VPIF_DISPLAY_MAX_DEVICES; i++)
+		kfree(vpif_obj.dev[i]);
+}
+
 static int vpif_async_bound(struct v4l2_async_notifier *notifier,
 			    struct v4l2_subdev *subdev,
 			    struct v4l2_async_subdev *asd)
@@ -1255,11 +1263,6 @@ static __init int vpif_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	if (!pdev->dev.platform_data) {
-		dev_warn(&pdev->dev, "Missing platform data.  Giving up.\n");
-		return -EINVAL;
-	}
-
 	vpif_dev = &pdev->dev;
 	err = initialize_vpif();
 
@@ -1271,7 +1274,7 @@ static __init int vpif_probe(struct platform_device *pdev)
 	err = v4l2_device_register(vpif_dev, &vpif_obj.v4l2_dev);
 	if (err) {
 		v4l2_err(vpif_dev->driver, "Error registering v4l2 device\n");
-		return err;
+		goto vpif_free;
 	}
 
 	while ((res = platform_get_resource(pdev, IORESOURCE_IRQ, res_idx))) {
@@ -1314,7 +1317,10 @@ static __init int vpif_probe(struct platform_device *pdev)
 			if (vpif_obj.sd[i])
 				vpif_obj.sd[i]->grp_id = 1 << i;
 		}
-		vpif_probe_complete();
+		err = vpif_probe_complete();
+		if (err) {
+			goto probe_subdev_out;
+		}
 	} else {
 		vpif_obj.notifier.subdevs = vpif_obj.config->asd;
 		vpif_obj.notifier.num_subdevs = vpif_obj.config->asd_sizes[0];
@@ -1334,6 +1340,8 @@ static __init int vpif_probe(struct platform_device *pdev)
 	kfree(vpif_obj.sd);
 vpif_unregister:
 	v4l2_device_unregister(&vpif_obj.v4l2_dev);
+vpif_free:
+	free_vpif_objs();
 
 	return err;
 }
@@ -1355,8 +1363,8 @@ static int vpif_remove(struct platform_device *device)
 		ch = vpif_obj.dev[i];
 		/* Unregister video device */
 		video_unregister_device(&ch->video_dev);
-		kfree(vpif_obj.dev[i]);
 	}
+	free_vpif_objs();
 
 	return 0;
 }
-- 
2.18.0

