Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754507AbeEaJ51 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 05:57:27 -0400
Received: from mail.bootlin.com ([62.4.15.54]:44963 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754260AbeEaJ5S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 05:57:18 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 1/2] rtc: ds1685: fix possible race condition
Date: Thu, 31 May 2018 11:56:42 +0200
Message-Id: <20180531095643.8581-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IRQ is requested before the struct rtc is allocated and registered, but
this struct is used in the IRQ handler.

Switch to devm_rtc_allocate_device/rtc_register_device to allocate the rtc
before requesting the IRQ.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ds1685.c | 41 ++++++++++++++++++----------------------
 1 file changed, 18 insertions(+), 23 deletions(-)

diff --git a/drivers/rtc/rtc-ds1685.c b/drivers/rtc/rtc-ds1685.c
index f0f8011dce3d..e6390475380f 100644
--- a/drivers/rtc/rtc-ds1685.c
+++ b/drivers/rtc/rtc-ds1685.c
@@ -2037,6 +2037,22 @@ ds1685_rtc_probe(struct platform_device *pdev)
 	rtc->write(rtc, RTC_EXT_CTRL_4B,
 		   (rtc->read(rtc, RTC_EXT_CTRL_4B) | RTC_CTRL_4B_KSE));
 
+	rtc_dev = devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(rtc_dev))
+		return PTR_ERR(rtc_dev);
+
+	rtc_dev->ops = &ds1685_rtc_ops;
+
+	/* Maximum periodic rate is 8192Hz (0.122070ms). */
+	rtc_dev->max_user_freq = RTC_MAX_USER_FREQ;
+
+	/* See if the platform doesn't support UIE. */
+	if (pdata->uie_unsupported)
+		rtc_dev->uie_unsupported = 1;
+	rtc->uie_unsupported = pdata->uie_unsupported;
+
+	rtc->dev = rtc_dev;
+
 	/*
 	 * Fetch the IRQ and setup the interrupt handler.
 	 *
@@ -2069,32 +2085,13 @@ ds1685_rtc_probe(struct platform_device *pdev)
 	/* Setup complete. */
 	ds1685_rtc_switch_to_bank0(rtc);
 
-	/* Register the device as an RTC. */
-	rtc_dev = rtc_device_register(pdev->name, &pdev->dev,
-				      &ds1685_rtc_ops, THIS_MODULE);
-
-	/* Success? */
-	if (IS_ERR(rtc_dev))
-		return PTR_ERR(rtc_dev);
-
-	/* Maximum periodic rate is 8192Hz (0.122070ms). */
-	rtc_dev->max_user_freq = RTC_MAX_USER_FREQ;
-
-	/* See if the platform doesn't support UIE. */
-	if (pdata->uie_unsupported)
-		rtc_dev->uie_unsupported = 1;
-	rtc->uie_unsupported = pdata->uie_unsupported;
-
-	rtc->dev = rtc_dev;
-
 #ifdef CONFIG_SYSFS
 	ret = ds1685_rtc_sysfs_register(&pdev->dev);
 	if (ret)
-		rtc_device_unregister(rtc->dev);
+		return ret;
 #endif
 
-	/* Done! */
-	return ret;
+	return rtc_register_device(rtc_dev);
 }
 
 /**
@@ -2110,8 +2107,6 @@ ds1685_rtc_remove(struct platform_device *pdev)
 	ds1685_rtc_sysfs_unregister(&pdev->dev);
 #endif
 
-	rtc_device_unregister(rtc->dev);
-
 	/* Read Ctrl B and clear PIE/AIE/UIE. */
 	rtc->write(rtc, RTC_CTRL_B,
 		   (rtc->read(rtc, RTC_CTRL_B) &
-- 
2.17.0
