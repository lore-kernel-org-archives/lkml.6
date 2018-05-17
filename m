Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752129AbeEQU0i (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 16:26:38 -0400
Received: from mail.bootlin.com ([62.4.15.54]:38893 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751788AbeEQU0g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 16:26:36 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 2/3] rtc: tps65910: allow platform power up
Date: Thu, 17 May 2018 22:26:22 +0200
Message-Id: <20180517202623.23497-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180517202623.23497-1-alexandre.belloni@bootlin.com>
References: <20180517202623.23497-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the IRQs are disabled when the rtc driver is removed (e.g. when
shutting down the platform).
This means that the RTC will be unable to power up the platform.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-tps65910.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/rtc/rtc-tps65910.c b/drivers/rtc/rtc-tps65910.c
index a56b526db89a..819d2d0957b4 100644
--- a/drivers/rtc/rtc-tps65910.c
+++ b/drivers/rtc/rtc-tps65910.c
@@ -436,17 +436,6 @@ static int tps65910_rtc_probe(struct platform_device *pdev)
 	return 0;
 }
 
-/*
- * Disable tps65910 RTC interrupts.
- * Sets status flag to free.
- */
-static int tps65910_rtc_remove(struct platform_device *pdev)
-{
-	tps65910_rtc_alarm_irq_enable(&pdev->dev, 0);
-
-	return 0;
-}
-
 #ifdef CONFIG_PM_SLEEP
 static int tps65910_rtc_suspend(struct device *dev)
 {
@@ -472,7 +461,6 @@ static SIMPLE_DEV_PM_OPS(tps65910_rtc_pm_ops, tps65910_rtc_suspend,
 
 static struct platform_driver tps65910_rtc_driver = {
 	.probe		= tps65910_rtc_probe,
-	.remove		= tps65910_rtc_remove,
 	.driver		= {
 		.name	= "tps65910-rtc",
 		.pm	= &tps65910_rtc_pm_ops,
-- 
2.17.0
