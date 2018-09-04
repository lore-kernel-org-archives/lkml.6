Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D23C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 11:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B30C52086B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 11:30:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B30C52086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbeIDPzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 11:55:24 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40199 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbeIDPzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 11:55:15 -0400
Received: by mail-wr1-f66.google.com with SMTP id n2-v6so3584512wrw.7
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 04:30:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ekjtkfz0ZByOvaUsDMLCAVgEr6dYbCQ/222lp+g7Arc=;
        b=ktY/tAPKz2TLB82//r4K4KzBzPxolaaeOYN0SS4alzW38dHnTWxi+7vPUDoKgRXEhy
         BwPRaFYA103BbGKPfD181VJtcTINs+dATvcUV4ZJg8w/Vil3U6ahH72payTVG6AZSdwN
         PjCjhmvWlUJ1pzXkMkIil1VSAxfOd7LbSQAMBCciV0edVk/zyEqGJTbcX4s2x6Me8+pe
         D9B3Iaj2G2AXcrEdz0gsXxPa62I9XcBfwoo2+EtXTbQ4REtW6QEFZZI3uUKddCQ5IwfV
         6+QSpHHNuKow18OVaWNM951ev65uPJ91Q1npYyL5IQXlvKEMihxutKii8SjLcAA+gQxB
         HFtw==
X-Gm-Message-State: APzg51ClGAT9pQspmdy27NWq6EYFMJYT7zLbRTEgta9KJscu9IKgs2wV
        iVaeyOh1MWWKsQTxLbuieASDaZHFmNA=
X-Google-Smtp-Source: ANB0VdapWR4HEXGRnT38Tj2lIv2wr9eP7SYB2li8yTYKptaAK3fsptDQF0esIFNLFKjpB+Ec/sCMTA==
X-Received: by 2002:a5d:528f:: with SMTP id c15-v6mr22751385wrv.102.1536060630228;
        Tue, 04 Sep 2018 04:30:30 -0700 (PDT)
Received: from minerva.redhat.com ([90.168.169.92])
        by smtp.gmail.com with ESMTPSA id s13-v6sm22574155wrq.39.2018.09.04.04.30.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Sep 2018 04:30:29 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Tian Shu Qiu <tian.shu.qiu@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org
Subject: [PATCH 1/2] [media] v4l: allow to register dev nodes for individual v4l2 subdevs
Date:   Tue,  4 Sep 2018 13:30:17 +0200
Message-Id: <20180904113018.14428-2-javierm@redhat.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180904113018.14428-1-javierm@redhat.com>
References: <20180904113018.14428-1-javierm@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently there's only a function to register device nodes for all subdevs
of a v4l2 device that are marked with the V4L2_SUBDEV_FL_HAS_DEVNODE flag.

But drivers may want to register device nodes for individual subdevices,
so add a v4l2_device_register_subdev_node() for this purpose.

A use case for this function is for media device drivers to register the
device nodes in the v4l2 async notifier .bound callback instead of doing
a registration for all subdevices in the .complete callback.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 drivers/media/v4l2-core/v4l2-device.c | 90 ++++++++++++++++-----------
 include/media/v4l2-device.h           | 10 +++
 2 files changed, 63 insertions(+), 37 deletions(-)

diff --git a/drivers/media/v4l2-core/v4l2-device.c b/drivers/media/v4l2-core/v4l2-device.c
index 3940e55c72f1..e5fc51b6604c 100644
--- a/drivers/media/v4l2-core/v4l2-device.c
+++ b/drivers/media/v4l2-core/v4l2-device.c
@@ -222,9 +222,59 @@ static void v4l2_device_release_subdev_node(struct video_device *vdev)
 	kfree(vdev);
 }
 
-int v4l2_device_register_subdev_nodes(struct v4l2_device *v4l2_dev)
+int v4l2_device_register_subdev_node(struct v4l2_device *v4l2_dev,
+				     struct v4l2_subdev *sd)
 {
 	struct video_device *vdev;
+	int err;
+
+	if (!(sd->flags & V4L2_SUBDEV_FL_HAS_DEVNODE))
+		return -EINVAL;
+
+	vdev = kzalloc(sizeof(*vdev), GFP_KERNEL);
+	if (!vdev)
+		return -ENOMEM;
+
+	video_set_drvdata(vdev, sd);
+	strlcpy(vdev->name, sd->name, sizeof(vdev->name));
+	vdev->v4l2_dev = v4l2_dev;
+	vdev->fops = &v4l2_subdev_fops;
+	vdev->release = v4l2_device_release_subdev_node;
+	vdev->ctrl_handler = sd->ctrl_handler;
+	err = __video_register_device(vdev, VFL_TYPE_SUBDEV, -1, 1,
+				      sd->owner);
+	if (err < 0) {
+		kfree(vdev);
+		return err;
+	}
+	sd->devnode = vdev;
+#if defined(CONFIG_MEDIA_CONTROLLER)
+	sd->entity.info.dev.major = VIDEO_MAJOR;
+	sd->entity.info.dev.minor = vdev->minor;
+
+	/* Interface is created by __video_register_device() */
+	if (vdev->v4l2_dev->mdev) {
+		struct media_link *link;
+
+		link = media_create_intf_link(&sd->entity,
+					      &vdev->intf_devnode->intf,
+					      MEDIA_LNK_FL_ENABLED |
+					      MEDIA_LNK_FL_IMMUTABLE);
+		if (!link) {
+			err = -ENOMEM;
+			video_unregister_device(sd->devnode);
+			return err;
+		}
+	}
+#endif
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(v4l2_device_register_subdev_node);
+
+int v4l2_device_register_subdev_nodes(struct v4l2_device *v4l2_dev)
+{
+
 	struct v4l2_subdev *sd;
 	int err;
 
@@ -238,43 +288,9 @@ int v4l2_device_register_subdev_nodes(struct v4l2_device *v4l2_dev)
 		if (sd->devnode)
 			continue;
 
-		vdev = kzalloc(sizeof(*vdev), GFP_KERNEL);
-		if (!vdev) {
-			err = -ENOMEM;
-			goto clean_up;
-		}
-
-		video_set_drvdata(vdev, sd);
-		strlcpy(vdev->name, sd->name, sizeof(vdev->name));
-		vdev->v4l2_dev = v4l2_dev;
-		vdev->fops = &v4l2_subdev_fops;
-		vdev->release = v4l2_device_release_subdev_node;
-		vdev->ctrl_handler = sd->ctrl_handler;
-		err = __video_register_device(vdev, VFL_TYPE_SUBDEV, -1, 1,
-					      sd->owner);
-		if (err < 0) {
-			kfree(vdev);
+		err = v4l2_device_register_subdev_node(v4l2_dev, sd);
+		if (err)
 			goto clean_up;
-		}
-		sd->devnode = vdev;
-#if defined(CONFIG_MEDIA_CONTROLLER)
-		sd->entity.info.dev.major = VIDEO_MAJOR;
-		sd->entity.info.dev.minor = vdev->minor;
-
-		/* Interface is created by __video_register_device() */
-		if (vdev->v4l2_dev->mdev) {
-			struct media_link *link;
-
-			link = media_create_intf_link(&sd->entity,
-						      &vdev->intf_devnode->intf,
-						      MEDIA_LNK_FL_ENABLED |
-						      MEDIA_LNK_FL_IMMUTABLE);
-			if (!link) {
-				err = -ENOMEM;
-				goto clean_up;
-			}
-		}
-#endif
 	}
 	return 0;
 
diff --git a/include/media/v4l2-device.h b/include/media/v4l2-device.h
index b330e4a08a6b..bf25418a1ad6 100644
--- a/include/media/v4l2-device.h
+++ b/include/media/v4l2-device.h
@@ -185,6 +185,16 @@ int __must_check v4l2_device_register_subdev(struct v4l2_device *v4l2_dev,
  */
 void v4l2_device_unregister_subdev(struct v4l2_subdev *sd);
 
+/**
+ * v4l2_device_register_subdev_node - Registers a device node for a subdev
+ *	of the v4l2 device.
+ *
+ * @v4l2_dev: pointer to struct v4l2_device
+ * @sd: pointer to &struct v4l2_subdev
+ */
+int __must_check v4l2_device_register_subdev_node(struct v4l2_device *v4l2_dev,
+						  struct v4l2_subdev *sd);
+
 /**
  * v4l2_device_register_subdev_nodes - Registers device nodes for all subdevs
  *	of the v4l2 device that are marked with
-- 
2.17.1

