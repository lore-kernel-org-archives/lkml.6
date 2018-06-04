Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753816AbeFDOQi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 10:16:38 -0400
Received: from mail.bootlin.com ([62.4.15.54]:51381 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753720AbeFDOPz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 10:15:55 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 2/3] rtc: ftrtc010: handle dates after 2106
Date: Mon,  4 Jun 2018 16:15:27 +0200
Message-Id: <20180604141528.15635-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180604141528.15635-1-alexandre.belloni@bootlin.com>
References: <20180604141528.15635-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use correct types for offset and time and use
rtc_time64_to_tm/rtc_tm_to_time64 to handle dates after 2106 properly.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ftrtc010.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-ftrtc010.c b/drivers/rtc/rtc-ftrtc010.c
index 165d0b62db00..2cdc78ffeb17 100644
--- a/drivers/rtc/rtc-ftrtc010.c
+++ b/drivers/rtc/rtc-ftrtc010.c
@@ -73,8 +73,8 @@ static int ftrtc010_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
 	struct ftrtc010_rtc *rtc = dev_get_drvdata(dev);
 
-	unsigned int  days, hour, min, sec;
-	unsigned long offset, time;
+	u32 days, hour, min, sec, offset;
+	timeu64_t time;
 
 	sec  = readl(rtc->rtc_base + FTRTC010_RTC_SECOND);
 	min  = readl(rtc->rtc_base + FTRTC010_RTC_MINUTE);
@@ -84,7 +84,7 @@ static int ftrtc010_rtc_read_time(struct device *dev, struct rtc_time *tm)
 
 	time = offset + days * 86400 + hour * 3600 + min * 60 + sec;
 
-	rtc_time_to_tm(time, tm);
+	rtc_time64_to_tm(time, tm);
 
 	return 0;
 }
@@ -92,13 +92,13 @@ static int ftrtc010_rtc_read_time(struct device *dev, struct rtc_time *tm)
 static int ftrtc010_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
 	struct ftrtc010_rtc *rtc = dev_get_drvdata(dev);
-	unsigned int sec, min, hour, day;
-	unsigned long offset, time;
+	u32 sec, min, hour, day, offset;
+	timeu64_t time;
 
 	if (tm->tm_year >= 2148)	/* EPOCH Year + 179 */
 		return -EINVAL;
 
-	rtc_tm_to_time(tm, &time);
+	time = rtc_tm_to_time64(tm);
 
 	sec = readl(rtc->rtc_base + FTRTC010_RTC_SECOND);
 	min = readl(rtc->rtc_base + FTRTC010_RTC_MINUTE);
-- 
2.17.1
