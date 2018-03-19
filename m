Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965762AbeCSXsr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 19:48:47 -0400
Received: from mail.bootlin.com ([62.4.15.54]:54265 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964848AbeCSXse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 19:48:34 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 4/6] rtc: st-lpc: remove artificial limitation
Date: Tue, 20 Mar 2018 00:48:15 +0100
Message-Id: <20180319234817.16199-4-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319234817.16199-1-alexandre.belloni@bootlin.com>
References: <20180319234817.16199-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LPC RTC supports dates way beyond 2038, don't limit it artificially as
the kernel handles dates after 2038 properly.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-st-lpc.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/rtc/rtc-st-lpc.c b/drivers/rtc/rtc-st-lpc.c
index 82b0af159a28..dcdd2b0a58f7 100644
--- a/drivers/rtc/rtc-st-lpc.c
+++ b/drivers/rtc/rtc-st-lpc.c
@@ -254,21 +254,6 @@ static int st_rtc_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, rtc);
 
-	/*
-	 * The RTC-LPC is able to manage date.year > 2038
-	 * but currently the kernel can not manage this date!
-	 * If the RTC-LPC has a date.year > 2038 then
-	 * it's set to the epoch "Jan 1st 2000"
-	 */
-	st_rtc_read_time(&pdev->dev, &tm_check);
-
-	if (tm_check.tm_year >=  (2038 - 1900)) {
-		memset(&tm_check, 0, sizeof(tm_check));
-		tm_check.tm_year = 100;
-		tm_check.tm_mday = 1;
-		st_rtc_set_time(&pdev->dev, &tm_check);
-	}
-
 	rtc->rtc_dev = rtc_device_register("st-lpc-rtc", &pdev->dev,
 					   &st_rtc_ops, THIS_MODULE);
 	if (IS_ERR(rtc->rtc_dev)) {
-- 
2.16.2
