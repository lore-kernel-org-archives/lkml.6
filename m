Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13870C07E85
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 13:00:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEC3122360
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 13:00:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEC3122360
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733077AbeKNXDu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 18:03:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:44726 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732933AbeKNXDe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 18:03:34 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1DB5AB0F3;
        Wed, 14 Nov 2018 13:00:24 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     stefan.wahren@i2se.com, eric@anholt.net,
        dave.stevenson@raspberrypi.org
Cc:     linux-rpi-kernel@lists.infradead.org, gregkh@linuxfoundation.org,
        linux-arm-kernel@lists.infradead.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: [PATCH 14/16] staging: vchiq_arm: rework probe and init functions
Date:   Wed, 14 Nov 2018 13:59:40 +0100
Message-Id: <20181114125942.25163-15-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181114125942.25163-1-nsaenzjulienne@suse.de>
References: <20181114125942.25163-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Moves the allocation of a chardev region and class creation to the init
function of the driver since those functions are meant to be run on a
per driver basis, as opposed to the code run in the probe function which
is run in a per device basis.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../interface/vchiq_arm/vchiq_arm.c           | 71 ++++++++++++-------
 1 file changed, 45 insertions(+), 26 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 383013a92939..a7dcced79980 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -166,7 +166,6 @@ static struct cdev    vchiq_cdev;
 static dev_t          vchiq_devid;
 static VCHIQ_STATE_T g_state;
 static struct class  *vchiq_class;
-static struct device *vchiq_dev;
 static DEFINE_SPINLOCK(msg_queue_spinlock);
 static struct platform_device *bcm2835_camera;
 
@@ -3552,34 +3551,19 @@ static int vchiq_probe(struct platform_device *pdev)
 	if (err != 0)
 		goto failed_platform_init;
 
-	err = alloc_chrdev_region(&vchiq_devid, VCHIQ_MINOR, 1, DEVICE_NAME);
-	if (err != 0) {
-		vchiq_log_error(vchiq_arm_log_level,
-			"Unable to allocate device number");
-		goto failed_platform_init;
-	}
 	cdev_init(&vchiq_cdev, &vchiq_fops);
 	vchiq_cdev.owner = THIS_MODULE;
 	err = cdev_add(&vchiq_cdev, vchiq_devid, 1);
 	if (err != 0) {
 		vchiq_log_error(vchiq_arm_log_level,
 			"Unable to register device");
-		goto failed_cdev_add;
+		goto failed_platform_init;
 	}
 
-	/* create sysfs entries */
-	vchiq_class = class_create(THIS_MODULE, DEVICE_NAME);
-	err = PTR_ERR(vchiq_class);
-	if (IS_ERR(vchiq_class))
-		goto failed_class_create;
-
-	vchiq_dev = device_create(vchiq_class, NULL,
-		vchiq_devid, NULL, "vchiq");
-	err = PTR_ERR(vchiq_dev);
-	if (IS_ERR(vchiq_dev))
+	if (IS_ERR(device_create(vchiq_class, &pdev->dev, vchiq_devid,
+				 NULL, "vchiq")))
 		goto failed_device_create;
 
-	/* create debugfs entries */
 	vchiq_debugfs_init();
 
 	vchiq_log_info(vchiq_arm_log_level,
@@ -3594,11 +3578,7 @@ static int vchiq_probe(struct platform_device *pdev)
 	return 0;
 
 failed_device_create:
-	class_destroy(vchiq_class);
-failed_class_create:
 	cdev_del(&vchiq_cdev);
-failed_cdev_add:
-	unregister_chrdev_region(vchiq_devid, 1);
 failed_platform_init:
 	vchiq_log_warning(vchiq_arm_log_level, "could not load vchiq");
 	return err;
@@ -3609,9 +3589,7 @@ static int vchiq_remove(struct platform_device *pdev)
 	platform_device_unregister(bcm2835_camera);
 	vchiq_debugfs_deinit();
 	device_destroy(vchiq_class, vchiq_devid);
-	class_destroy(vchiq_class);
 	cdev_del(&vchiq_cdev);
-	unregister_chrdev_region(vchiq_devid, 1);
 
 	return 0;
 }
@@ -3624,7 +3602,48 @@ static struct platform_driver vchiq_driver = {
 	.probe = vchiq_probe,
 	.remove = vchiq_remove,
 };
-module_platform_driver(vchiq_driver);
+
+static int __init vchiq_driver_init(void)
+{
+	int ret;
+
+	vchiq_class = class_create(THIS_MODULE, DEVICE_NAME);
+	if (IS_ERR(vchiq_class)) {
+		pr_err("Failed to create vchiq class\n");
+		return PTR_ERR(vchiq_class);
+	}
+
+	ret = alloc_chrdev_region(&vchiq_devid, VCHIQ_MINOR, 1, DEVICE_NAME);
+	if (ret) {
+		pr_err("Failed to allocate vchiq's chrdev region\n");
+		goto class_destroy;
+	}
+
+	ret = platform_driver_register(&vchiq_driver);
+	if (ret) {
+		pr_err("Failed to register vchiq driver\n");
+		goto region_unregister;
+	}
+
+	return 0;
+
+region_unregister:
+	platform_driver_unregister(&vchiq_driver);
+
+class_destroy:
+	class_destroy(vchiq_class);
+
+	return ret;
+}
+module_init(vchiq_driver_init);
+
+static void __exit vchiq_driver_exit(void)
+{
+	platform_driver_unregister(&vchiq_driver);
+	unregister_chrdev_region(vchiq_devid, 1);
+	class_destroy(vchiq_class);
+}
+module_exit(vchiq_driver_exit);
 
 MODULE_LICENSE("Dual BSD/GPL");
 MODULE_DESCRIPTION("Videocore VCHIQ driver");
-- 
2.19.1

