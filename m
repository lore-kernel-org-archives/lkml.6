Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752265AbeEQUsZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 16:48:25 -0400
Received: from mail.bootlin.com ([62.4.15.54]:39364 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751907AbeEQUsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 16:48:23 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 1/2] rtc: tps6586x: fix possible race condition
Date: Thu, 17 May 2018 22:48:17 +0200
Message-Id: <20180517204818.28593-1-alexandre.belloni@bootlin.com>
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
 drivers/rtc/rtc-tps6586x.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-tps6586x.c b/drivers/rtc/rtc-tps6586x.c
index 46a19adf9a96..9b741143f131 100644
--- a/drivers/rtc/rtc-tps6586x.c
+++ b/drivers/rtc/rtc-tps6586x.c
@@ -276,14 +276,15 @@ static int tps6586x_rtc_probe(struct platform_device *pdev)
 	device_init_wakeup(&pdev->dev, 1);
 
 	platform_set_drvdata(pdev, rtc);
-	rtc->rtc = devm_rtc_device_register(&pdev->dev, dev_name(&pdev->dev),
-				       &tps6586x_rtc_ops, THIS_MODULE);
+	rtc->rtc = devm_rtc_allocate_device(&pdev->dev);
 	if (IS_ERR(rtc->rtc)) {
 		ret = PTR_ERR(rtc->rtc);
-		dev_err(&pdev->dev, "RTC device register: ret %d\n", ret);
+		dev_err(&pdev->dev, "RTC allocate device: ret %d\n", ret);
 		goto fail_rtc_register;
 	}
 
+	rtc->rtc->ops = &tps6586x_rtc_ops;
+
 	ret = devm_request_threaded_irq(&pdev->dev, rtc->irq, NULL,
 				tps6586x_rtc_irq,
 				IRQF_ONESHOT,
@@ -294,6 +295,13 @@ static int tps6586x_rtc_probe(struct platform_device *pdev)
 		goto fail_rtc_register;
 	}
 	disable_irq(rtc->irq);
+
+	ret = rtc_register_device(rtc->rtc);
+	if (ret) {
+		dev_err(&pdev->dev, "RTC device register: ret %d\n", ret);
+		goto fail_rtc_register;
+	}
+
 	return 0;
 
 fail_rtc_register:
-- 
2.17.0
