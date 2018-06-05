Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752710AbeFEVR6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 17:17:58 -0400
Received: from mail.bootlin.com ([62.4.15.54]:58380 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751698AbeFEVRy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 17:17:54 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 1/3] rtc: test: convert to devm_rtc_allocate_device
Date: Tue,  5 Jun 2018 23:09:12 +0200
Message-Id: <20180605210914.8054-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows further improvement of the driver.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-test.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-test.c b/drivers/rtc/rtc-test.c
index 70d4ab1d2769..6a6bc1f2a14d 100644
--- a/drivers/rtc/rtc-test.c
+++ b/drivers/rtc/rtc-test.c
@@ -120,15 +120,16 @@ static int test_probe(struct platform_device *plat_dev)
 
 	platform_set_drvdata(plat_dev, rtd);
 
-	rtd->rtc = devm_rtc_device_register(&plat_dev->dev, "test",
-					    &test_rtc_ops, THIS_MODULE);
+	rtd->rtc = devm_rtc_allocate_device(&plat_dev->dev);
 	if (IS_ERR(rtd->rtc))
 		return PTR_ERR(rtd->rtc);
 
+	rtd->rtc->ops = &test_rtc_ops;
+
 	timer_setup(&rtd->alarm, test_rtc_alarm_handler, 0);
 	rtd->alarm.expires = 0;
 
-	return 0;
+	return rtc_register_device(rtd->rtc);
 }
 
 static struct platform_driver test_driver = {
-- 
2.17.1
