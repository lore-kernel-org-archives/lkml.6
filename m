Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752008AbeEQU0h (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 16:26:37 -0400
Received: from mail.bootlin.com ([62.4.15.54]:38892 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751698AbeEQU0g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 16:26:36 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 1/3] rtc: tps65910: fix possible race condition
Date: Thu, 17 May 2018 22:26:21 +0200
Message-Id: <20180517202623.23497-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IRQ is requested before the struct rtc is allocated and registered, but
this struct is used in the IRQ handler. This may lead to a NULL pointer
dereference.

Switch to devm_rtc_allocate_device/rtc_register_device to allocate the rtc
before requesting the IRQ.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-tps65910.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-tps65910.c b/drivers/rtc/rtc-tps65910.c
index d0244d7979fc..a56b526db89a 100644
--- a/drivers/rtc/rtc-tps65910.c
+++ b/drivers/rtc/rtc-tps65910.c
@@ -380,6 +380,10 @@ static int tps65910_rtc_probe(struct platform_device *pdev)
 	if (!tps_rtc)
 		return -ENOMEM;
 
+	tps_rtc->rtc = devm_rtc_allocate_device(&pdev->dev);
+	if (IS_ERR(tps_rtc->rtc))
+		return PTR_ERR(tps_rtc->rtc);
+
 	/* Clear pending interrupts */
 	ret = regmap_read(tps65910->regmap, TPS65910_RTC_STATUS, &rtc_reg);
 	if (ret < 0)
@@ -421,10 +425,10 @@ static int tps65910_rtc_probe(struct platform_device *pdev)
 	tps_rtc->irq = irq;
 	device_set_wakeup_capable(&pdev->dev, 1);
 
-	tps_rtc->rtc = devm_rtc_device_register(&pdev->dev, pdev->name,
-		&tps65910_rtc_ops, THIS_MODULE);
-	if (IS_ERR(tps_rtc->rtc)) {
-		ret = PTR_ERR(tps_rtc->rtc);
+	tps_rtc->rtc->ops = &tps65910_rtc_ops;
+
+	ret = rtc_register_device(tps_rtc->rtc);
+	if (ret) {
 		dev_err(&pdev->dev, "RTC device register: err %d\n", ret);
 		return ret;
 	}
-- 
2.17.0
