Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933075AbeBLWsr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 17:48:47 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:37585 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932963AbeBLWsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 17:48:39 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 31/45] rtc: cmos: fix possible race condition
Date: Mon, 12 Feb 2018 23:47:45 +0100
Message-Id: <20180212224759.15999-32-alexandre.belloni@bootlin.com>
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
 drivers/rtc/rtc-cmos.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index 9dca53df3584..e6393e784d0c 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -751,8 +751,7 @@ cmos_do_probe(struct device *dev, struct resource *ports, int rtc_irq)
 	cmos_rtc.dev = dev;
 	dev_set_drvdata(dev, &cmos_rtc);
 
-	cmos_rtc.rtc = rtc_device_register(driver_name, dev,
-				&cmos_rtc_ops, THIS_MODULE);
+	cmos_rtc.rtc = devm_rtc_allocate_device(dev);
 	if (IS_ERR(cmos_rtc.rtc)) {
 		retval = PTR_ERR(cmos_rtc.rtc);
 		goto cleanup0;
@@ -822,6 +821,11 @@ cmos_do_probe(struct device *dev, struct resource *ports, int rtc_irq)
 		goto cleanup2;
 	}
 
+	cmos_rtc.rtc->ops = &cmos_rtc_ops;
+	retval = rtc_register_device(cmos_rtc.rtc);
+	if (retval)
+		goto cleanup3;
+
 	dev_info(dev, "%s%s, %zd bytes nvram%s\n",
 		!is_valid_irq(rtc_irq) ? "no alarms" :
 			cmos_rtc.mon_alrm ? "alarms up to one year" :
@@ -833,12 +837,13 @@ cmos_do_probe(struct device *dev, struct resource *ports, int rtc_irq)
 
 	return 0;
 
+cleanup3:
+	sysfs_remove_bin_file(&dev->kobj, &nvram);
 cleanup2:
 	if (is_valid_irq(rtc_irq))
 		free_irq(rtc_irq, cmos_rtc.rtc);
 cleanup1:
 	cmos_rtc.dev = NULL;
-	rtc_device_unregister(cmos_rtc.rtc);
 cleanup0:
 	if (RTC_IOMAPPED)
 		release_region(ports->start, resource_size(ports));
@@ -869,7 +874,6 @@ static void cmos_do_remove(struct device *dev)
 		hpet_unregister_irq_handler(cmos_interrupt);
 	}
 
-	rtc_device_unregister(cmos->rtc);
 	cmos->rtc = NULL;
 
 	ports = cmos->iomem;
-- 
2.16.1
