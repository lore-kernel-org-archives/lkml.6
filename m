Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965403AbeCSXsg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 19:48:36 -0400
Received: from mail.bootlin.com ([62.4.15.54]:54263 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964820AbeCSXsd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 19:48:33 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 2/6] rtc: mv: remove artificial limitation
Date: Tue, 20 Mar 2018 00:48:13 +0100
Message-Id: <20180319234817.16199-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319234817.16199-1-alexandre.belloni@bootlin.com>
References: <20180319234817.16199-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dates after 2038 actually fit on 32 bits. The counter will overflow in
2106. Also, it is bad practice to reset the RTC to a default value.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-mv.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/rtc/rtc-mv.c b/drivers/rtc/rtc-mv.c
index 944c5c0fadd0..bc52dbb0c0e2 100644
--- a/drivers/rtc/rtc-mv.c
+++ b/drivers/rtc/rtc-mv.c
@@ -223,7 +223,6 @@ static int __init mv_rtc_probe(struct platform_device *pdev)
 	struct resource *res;
 	struct rtc_plat_data *pdata;
 	u32 rtc_time;
-	u32 rtc_date;
 	int ret = 0;
 
 	pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
@@ -259,17 +258,6 @@ static int __init mv_rtc_probe(struct platform_device *pdev)
 		}
 	}
 
-	/*
-	 * A date after January 19th, 2038 does not fit on 32 bits and
-	 * will confuse the kernel and userspace. Reset to a sane date
-	 * (January 1st, 2013) if we're after 2038.
-	 */
-	rtc_date = readl(pdata->ioaddr + RTC_DATE_REG_OFFS);
-	if (bcd2bin((rtc_date >> RTC_YEAR_OFFS) & 0xff) >= 38) {
-		dev_info(&pdev->dev, "invalid RTC date, resetting to January 1st, 2013\n");
-		writel(0x130101, pdata->ioaddr + RTC_DATE_REG_OFFS);
-	}
-
 	pdata->irq = platform_get_irq(pdev, 0);
 
 	platform_set_drvdata(pdev, pdata);
-- 
2.16.2
