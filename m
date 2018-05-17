Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752201AbeEQUTS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 16:19:18 -0400
Received: from mail.bootlin.com ([62.4.15.54]:38530 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751047AbeEQUTP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 16:19:15 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 1/5] rtc: 88pm80x: stop setting a default time
Date: Thu, 17 May 2018 22:18:56 +0200
Message-Id: <20180517201900.22055-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It doesn't make sense to set the RTC to a default value at probe time. Let
the core handle invalid date and time.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-88pm80x.c | 22 ----------------------
 1 file changed, 22 deletions(-)

diff --git a/drivers/rtc/rtc-88pm80x.c b/drivers/rtc/rtc-88pm80x.c
index 6cbafefa80a2..76df274f3e1a 100644
--- a/drivers/rtc/rtc-88pm80x.c
+++ b/drivers/rtc/rtc-88pm80x.c
@@ -254,8 +254,6 @@ static int pm80x_rtc_probe(struct platform_device *pdev)
 	struct pm80x_rtc_pdata *pdata = dev_get_platdata(&pdev->dev);
 	struct pm80x_rtc_info *info;
 	struct device_node *node = pdev->dev.of_node;
-	struct rtc_time tm;
-	unsigned long ticks = 0;
 	int ret;
 
 	if (!pdata && !node) {
@@ -302,26 +300,6 @@ static int pm80x_rtc_probe(struct platform_device *pdev)
 		goto out;
 	}
 
-	ret = pm80x_rtc_read_time(&pdev->dev, &tm);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Failed to read initial time.\n");
-		goto out_rtc;
-	}
-	if ((tm.tm_year < 70) || (tm.tm_year > 138)) {
-		tm.tm_year = 70;
-		tm.tm_mon = 0;
-		tm.tm_mday = 1;
-		tm.tm_hour = 0;
-		tm.tm_min = 0;
-		tm.tm_sec = 0;
-		ret = pm80x_rtc_set_time(&pdev->dev, &tm);
-		if (ret < 0) {
-			dev_err(&pdev->dev, "Failed to set initial time.\n");
-			goto out_rtc;
-		}
-	}
-	rtc_tm_to_time(&tm, &ticks);
-
 	info->rtc_dev = devm_rtc_device_register(&pdev->dev, "88pm80x-rtc",
 					    &pm80x_rtc_ops, THIS_MODULE);
 	if (IS_ERR(info->rtc_dev)) {
-- 
2.17.0
