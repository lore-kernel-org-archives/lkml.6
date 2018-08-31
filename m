Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18418C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1A8E20661
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 15:20:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1A8E20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbeHaT2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 15:28:55 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45613 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727303AbeHaT2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 15:28:54 -0400
Received: by mail-wr1-f65.google.com with SMTP id 20-v6so11553115wrb.12
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 08:20:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TyoCTa8EMpKGM+YX+iYdLQKMVHxr1N7PsqhbZhZaE4w=;
        b=lT5tEUw4m3GDsG1ztELmpNtB2Ppzm3+LUcLWBHmiPkFidfzDqnlpveGmJaFktuUgpJ
         j7iKknUdQcCuftcwiOGwVNKD8OqAb1uOrojmG30qxNtthqvpOpEi878Fzu/s9TFKlqRV
         fytrDHOKpt1RAFBzTf0cHDXVJNefD5sR2zDbaHRyF/0Qs9qw4+XCd9YVVoI0mq2dJHWP
         UtrilQdTVniKm+OmlyMbdEs5/XEyATVQ8Dem3uHjS+Rxrklcm7MpG7a/3oetfMbGRH8s
         KEJo2NPhcYilD4NoF44I2VEu7SmV1KgcL1UeoFgasQWjkXtYwekzJI8f85pxerRUjrDr
         cXVg==
X-Gm-Message-State: APzg51AImCstVsbGXqO/BVe/rSTR+X5xNDyzLmI7RYBXY8AqBn+iHn9Q
        Fbbeooz/JkzbzUjs3eZ971DHEIDGR60=
X-Google-Smtp-Source: ANB0VdZNBbbkCHtbaSU563YBTO7Kqko/IbAlJvt3QHZcZeAU6RKYnOhDG4LPaQ0YFfXCk7ZHpQ+Udg==
X-Received: by 2002:a5d:428a:: with SMTP id k10-v6mr305354wrq.225.1535728854562;
        Fri, 31 Aug 2018 08:20:54 -0700 (PDT)
Received: from minerva.redhat.com ([90.168.169.92])
        by smtp.gmail.com with ESMTPSA id n17-v6sm3244923wmc.13.2018.08.31.08.20.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Aug 2018 08:20:53 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tian Shu Qiu <tian.shu.qiu@intel.com>,
        Jian Xu Zheng <jian.xu.zheng@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Yong Zhi <yong.zhi@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>, linux-media@vger.kernel.org
Subject: [PATCH] media: intel-ipu3: cio2: register the mdev on v4l2 async notifier complete
Date:   Fri, 31 Aug 2018 17:20:45 +0200
Message-Id: <20180831152045.9957-1-javierm@redhat.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 9832e155f1ed ("[media] media-device: split media initialization and
registration") split the media_device_register() function in two, to avoid
a race condition that can happen when the media device node is accessed by
userpace before the pending subdevices have been asynchronously registered.

But the ipu3-cio2 driver calls the media_device_register() function right
after calling media_device_init() which defeats the purpose of having two
separate functions.

In that case, userspace could have a partial view of the media device if
it opened the media device node before all the pending devices have been
bound. So instead, only register the media device once all pending v4l2
subdevices have been registered.

Fixes: 9832e155f1ed ("media: intel-ipu3: cio2: add new MIPI-CSI2 driver")
Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/media/pci/intel/ipu3/ipu3-cio2.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/media/pci/intel/ipu3/ipu3-cio2.c b/drivers/media/pci/intel/ipu3/ipu3-cio2.c
index 29027159eced..d936f3426c4e 100644
--- a/drivers/media/pci/intel/ipu3/ipu3-cio2.c
+++ b/drivers/media/pci/intel/ipu3/ipu3-cio2.c
@@ -1468,7 +1468,14 @@ static int cio2_notifier_complete(struct v4l2_async_notifier *notifier)
 		}
 	}
 
-	return v4l2_device_register_subdev_nodes(&cio2->v4l2_dev);
+	ret = v4l2_device_register_subdev_nodes(&cio2->v4l2_dev);
+	if (ret) {
+		dev_err(&cio2->pci_dev->dev,
+			"failed to register V4L2 subdev nodes (%d)\n", ret);
+		return ret;
+	}
+
+	return media_device_register(&cio2->media_dev);
 }
 
 static const struct v4l2_async_notifier_operations cio2_async_ops = {
@@ -1792,16 +1799,12 @@ static int cio2_pci_probe(struct pci_dev *pci_dev,
 	cio2->media_dev.hw_revision = 0;
 
 	media_device_init(&cio2->media_dev);
-	r = media_device_register(&cio2->media_dev);
-	if (r < 0)
-		goto fail_mutex_destroy;
-
 	cio2->v4l2_dev.mdev = &cio2->media_dev;
 	r = v4l2_device_register(&pci_dev->dev, &cio2->v4l2_dev);
 	if (r) {
 		dev_err(&pci_dev->dev,
 			"failed to register V4L2 device (%d)\n", r);
-		goto fail_media_device_unregister;
+		goto fail_media_device_cleanup;
 	}
 
 	r = cio2_queues_init(cio2);
@@ -1831,10 +1834,8 @@ static int cio2_pci_probe(struct pci_dev *pci_dev,
 	cio2_queues_exit(cio2);
 fail_v4l2_device_unregister:
 	v4l2_device_unregister(&cio2->v4l2_dev);
-fail_media_device_unregister:
-	media_device_unregister(&cio2->media_dev);
+fail_media_device_cleanup:
 	media_device_cleanup(&cio2->media_dev);
-fail_mutex_destroy:
 	mutex_destroy(&cio2->lock);
 	cio2_fbpt_exit_dummy(cio2);
 
-- 
2.17.1

