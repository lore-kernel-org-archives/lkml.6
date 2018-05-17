Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752219AbeEQUrN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 16:47:13 -0400
Received: from mail.bootlin.com ([62.4.15.54]:39325 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751017AbeEQUrJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 16:47:09 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 1/2] rtc: vr41xx: fix possible race condition
Date: Thu, 17 May 2018 22:47:05 +0200
Message-Id: <20180517204706.28192-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The probe function is not allowed to fail after the RTC is registered
because the following may happen:

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

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-vr41xx.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/rtc/rtc-vr41xx.c b/drivers/rtc/rtc-vr41xx.c
index 480cffe8d321..2f1212a25f7e 100644
--- a/drivers/rtc/rtc-vr41xx.c
+++ b/drivers/rtc/rtc-vr41xx.c
@@ -292,13 +292,14 @@ static int rtc_probe(struct platform_device *pdev)
 		goto err_rtc1_iounmap;
 	}
 
-	rtc = devm_rtc_device_register(&pdev->dev, rtc_name, &vr41xx_rtc_ops,
-					THIS_MODULE);
+	rtc = devm_rtc_allocate_device(&pdev->dev);
 	if (IS_ERR(rtc)) {
 		retval = PTR_ERR(rtc);
 		goto err_iounmap_all;
 	}
 
+	rtc->ops = &vr41xx_rtc_ops;
+
 	rtc->max_user_freq = MAX_PERIODIC_RATE;
 
 	spin_lock_irq(&rtc_lock);
@@ -340,6 +341,10 @@ static int rtc_probe(struct platform_device *pdev)
 
 	dev_info(&pdev->dev, "Real Time Clock of NEC VR4100 series\n");
 
+	retval = rtc_register_device(rtc);
+	if (retval)
+		goto err_iounmap_all;
+
 	return 0;
 
 err_iounmap_all:
-- 
2.17.0
