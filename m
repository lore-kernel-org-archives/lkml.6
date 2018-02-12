Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933111AbeBLWxe (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 17:53:34 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:37590 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933043AbeBLWsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 17:48:46 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 35/45] rtc: rp5c01: fix possible race condition
Date: Mon, 12 Feb 2018 23:47:49 +0100
Message-Id: <20180212224759.15999-36-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180212224759.15999-1-alexandre.belloni@bootlin.com>
References: <20180212224759.15999-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The probe function is not allowed to fail after registering the RTC because
the following may happen:

CPU0:                                CPU1:
sys_load_module()
 do_init_module()
  do_one_initcall()
   cmos_do_probe()
    rtc_device_register()
     __register_chrdev()
     cdev->owner = struct module*
                                     open("/dev/rtc0")
    rtc_device_unregister()
  module_put()
  free_module()
   module_free(mod->module_core)
   /* struct module *module is now
      freed */
                                      chrdev_open()
                                       spin_lock(cdev_lock)
                                       cdev_get()
                                        try_module_get()
                                         module_is_live()
                                         /* dereferences already
                                            freed struct module* */

Switch to devm_rtc_allocate_device/rtc_register_device to register the rtc
as late as possible.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-rp5c01.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-rp5c01.c b/drivers/rtc/rtc-rp5c01.c
index 026035373ae6..38a12435b5a0 100644
--- a/drivers/rtc/rtc-rp5c01.c
+++ b/drivers/rtc/rtc-rp5c01.c
@@ -249,16 +249,24 @@ static int __init rp5c01_rtc_probe(struct platform_device *dev)
 
 	platform_set_drvdata(dev, priv);
 
-	rtc = devm_rtc_device_register(&dev->dev, "rtc-rp5c01", &rp5c01_rtc_ops,
-				  THIS_MODULE);
+	rtc = devm_rtc_allocate_device(&dev->dev);
 	if (IS_ERR(rtc))
 		return PTR_ERR(rtc);
+
+	rtc->ops = &rp5c01_rtc_ops;
+
 	priv->rtc = rtc;
 
 	error = sysfs_create_bin_file(&dev->dev.kobj, &priv->nvram_attr);
 	if (error)
 		return error;
 
+	error = rtc_register_device(rtc);
+	if (error) {
+		sysfs_remove_bin_file(&dev->dev.kobj, &priv->nvram_attr);
+		return error;
+	}
+
 	return 0;
 }
 
-- 
2.16.1
