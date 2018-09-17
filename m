Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2175EECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5A9E2146F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:01:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5A9E2146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729854AbeIREac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:30:32 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48192 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727559AbeIREab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:30:31 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 510DDC77;
        Mon, 17 Sep 2018 23:01:03 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anton Vasilyev <vasilyev@ispras.ru>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 029/126] media: davinci: vpif_display: Mix memory leak on probe error path
Date:   Tue, 18 Sep 2018 00:41:17 +0200
Message-Id: <20180917211706.702657391@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211703.481236999@linuxfoundation.org>
References: <20180917211703.481236999@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Anton Vasilyev <vasilyev@ispras.ru>

[ Upstream commit 61e641f36ed81ae473177c085f0bfd83ad3b55ed ]

If vpif_probe() fails on v4l2_device_register() then memory allocated
at initialize_vpif() for global vpif_obj.dev[i] become unreleased.

The patch adds deallocation of vpif_obj.dev[i] on the error path and
removes duplicated check on platform_data presence.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/platform/davinci/vpif_display.c |   24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

--- a/drivers/media/platform/davinci/vpif_display.c
+++ b/drivers/media/platform/davinci/vpif_display.c
@@ -1114,6 +1114,14 @@ vpif_init_free_channel_objects:
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
@@ -1250,11 +1258,6 @@ static __init int vpif_probe(struct plat
 		return -EINVAL;
 	}
 
-	if (!pdev->dev.platform_data) {
-		dev_warn(&pdev->dev, "Missing platform data.  Giving up.\n");
-		return -EINVAL;
-	}
-
 	vpif_dev = &pdev->dev;
 	err = initialize_vpif();
 
@@ -1266,7 +1269,7 @@ static __init int vpif_probe(struct plat
 	err = v4l2_device_register(vpif_dev, &vpif_obj.v4l2_dev);
 	if (err) {
 		v4l2_err(vpif_dev->driver, "Error registering v4l2 device\n");
-		return err;
+		goto vpif_free;
 	}
 
 	while ((res = platform_get_resource(pdev, IORESOURCE_IRQ, res_idx))) {
@@ -1309,7 +1312,10 @@ static __init int vpif_probe(struct plat
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
@@ -1330,6 +1336,8 @@ probe_subdev_out:
 	kfree(vpif_obj.sd);
 vpif_unregister:
 	v4l2_device_unregister(&vpif_obj.v4l2_dev);
+vpif_free:
+	free_vpif_objs();
 
 	return err;
 }
@@ -1351,8 +1359,8 @@ static int vpif_remove(struct platform_d
 		ch = vpif_obj.dev[i];
 		/* Unregister video device */
 		video_unregister_device(&ch->video_dev);
-		kfree(vpif_obj.dev[i]);
 	}
+	free_vpif_objs();
 
 	return 0;
 }


