Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752464AbeEQUVO (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 16:21:14 -0400
Received: from mail.bootlin.com ([62.4.15.54]:38638 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752319AbeEQUVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 16:21:12 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 1/2] rtc: ab-b5ze-s3: fix possible race conditions
Date: Thu, 17 May 2018 22:20:39 +0200
Message-Id: <20180517202040.22292-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IRQ is requested before the struct rtc is allocated and registered, but
this struct is used in the IRQ handler. This may lead to a NULL pointer
dereference.

Also, the probe function is not allowed to fail after the RTC is registered
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

Switch to devm_rtc_allocate_device/rtc_register_device to allocate the rtc
before requesting the IRQ and register the RTC as late as possible.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ab-b5ze-s3.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/rtc/rtc-ab-b5ze-s3.c b/drivers/rtc/rtc-ab-b5ze-s3.c
index 8dc451932446..f486912577e7 100644
--- a/drivers/rtc/rtc-ab-b5ze-s3.c
+++ b/drivers/rtc/rtc-ab-b5ze-s3.c
@@ -925,6 +925,14 @@ static int abb5zes3_probe(struct i2c_client *client,
 	if (ret)
 		goto err;
 
+	data->rtc = devm_rtc_allocate_device(dev);
+	ret = PTR_ERR_OR_ZERO(data->rtc);
+	if (ret) {
+		dev_err(dev, "%s: unable to allocate RTC device (%d)\n",
+			__func__, ret);
+		goto err;
+	}
+
 	if (client->irq > 0) {
 		ret = devm_request_threaded_irq(dev, client->irq, NULL,
 						_abb5zes3_rtc_interrupt,
@@ -942,14 +950,7 @@ static int abb5zes3_probe(struct i2c_client *client,
 		}
 	}
 
-	data->rtc = devm_rtc_device_register(dev, DRV_NAME, &rtc_ops,
-					     THIS_MODULE);
-	ret = PTR_ERR_OR_ZERO(data->rtc);
-	if (ret) {
-		dev_err(dev, "%s: unable to register RTC device (%d)\n",
-			__func__, ret);
-		goto err;
-	}
+	data->rtc->ops = &rtc_ops;
 
 	/* Enable battery low detection interrupt if battery not already low */
 	if (!data->battery_low && data->irq) {
@@ -961,6 +962,8 @@ static int abb5zes3_probe(struct i2c_client *client,
 		}
 	}
 
+	ret = rtc_register_device(data->rtc);
+
 err:
 	if (ret && data && data->irq)
 		device_init_wakeup(dev, false);
-- 
2.17.0
