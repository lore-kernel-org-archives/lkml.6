Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752276AbeEQUTU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 16:19:20 -0400
Received: from mail.bootlin.com ([62.4.15.54]:38536 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751543AbeEQUTQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 16:19:16 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 4/5] rtc: 88pm80x: let the core handle the RTC range
Date: Thu, 17 May 2018 22:18:59 +0200
Message-Id: <20180517201900.22055-4-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180517201900.22055-1-alexandre.belloni@bootlin.com>
References: <20180517201900.22055-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 88pm80x RTC is storing the time as a 32bit offset from a 32bit counter
so it can handle dates from 0 to U32_MAX.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-88pm80x.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-88pm80x.c b/drivers/rtc/rtc-88pm80x.c
index dae527f8c58e..33b28b6117e9 100644
--- a/drivers/rtc/rtc-88pm80x.c
+++ b/drivers/rtc/rtc-88pm80x.c
@@ -132,12 +132,7 @@ static int pm80x_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	struct pm80x_rtc_info *info = dev_get_drvdata(dev);
 	unsigned char buf[4];
 	unsigned long ticks, base, data;
-	if (tm->tm_year > 206) {
-		dev_dbg(info->dev,
-			"Set time %d out of range. Please set time between 1970 to 2106.\n",
-			1900 + tm->tm_year);
-		return -EINVAL;
-	}
+
 	rtc_tm_to_time(tm, &ticks);
 
 	/* load 32-bit read-only counter */
@@ -303,6 +298,7 @@ static int pm80x_rtc_probe(struct platform_device *pdev)
 	}
 
 	info->rtc_dev->ops = &pm80x_rtc_ops;
+	info->rtc_dev->range_max = U32_MAX;
 
 	ret = rtc_register_device(info->rtc_dev);
 	if (ret) {
-- 
2.17.0
