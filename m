Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752145AbeBUVEb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 16:04:31 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:47086 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752021AbeBUU5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 15:57:55 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 090/100] rtc: rk808: fix possible race condition
Date: Wed, 21 Feb 2018 21:56:25 +0100
Message-Id: <20180221205635.31314-91-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180221205635.31314-1-alexandre.belloni@bootlin.com>
References: <20180221205635.31314-1-alexandre.belloni@bootlin.com>
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
 drivers/rtc/rtc-rk808.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/rtc/rtc-rk808.c b/drivers/rtc/rtc-rk808.c
index e40f35d1ced3..739c0d42e835 100644
--- a/drivers/rtc/rtc-rk808.c
+++ b/drivers/rtc/rtc-rk808.c
@@ -405,12 +405,11 @@ static int rk808_rtc_probe(struct platform_device *pdev)
 
 	device_init_wakeup(&pdev->dev, 1);
 
-	rk808_rtc->rtc = devm_rtc_device_register(&pdev->dev, "rk808-rtc",
-						  &rk808_rtc_ops, THIS_MODULE);
-	if (IS_ERR(rk808_rtc->rtc)) {
-		ret = PTR_ERR(rk808_rtc->rtc);
-		return ret;
-	}
+	rk808_rtc->rtc = devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(rk808_rtc->rtc))
+		return PTR_ERR(rk808_rtc->rtc);
+
+	rk808_rtc->rtc->ops = &rk808_rtc_ops;
 
 	rk808_rtc->irq = platform_get_irq(pdev, 0);
 	if (rk808_rtc->irq < 0) {
@@ -427,9 +426,10 @@ static int rk808_rtc_probe(struct platform_device *pdev)
 	if (ret) {
 		dev_err(&pdev->dev, "Failed to request alarm IRQ %d: %d\n",
 			rk808_rtc->irq, ret);
+		return ret;
 	}
 
-	return ret;
+	return rtc_register_device(rk808_rtc->rtc);
 }
 
 static struct platform_driver rk808_rtc_driver = {
-- 
2.16.1
