Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752208AbeEQUds (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 16:33:48 -0400
Received: from mail.bootlin.com ([62.4.15.54]:39014 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751233AbeEQUdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 16:33:44 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 3/7] rtc: rx8581: let the core handle rtc range
Date: Thu, 17 May 2018 22:33:27 +0200
Message-Id: <20180517203331.24504-3-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180517203331.24504-1-alexandre.belloni@bootlin.com>
References: <20180517203331.24504-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let the core handle offsetting and windowing the RTC range.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-rx8581.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/rtc/rtc-rx8581.c b/drivers/rtc/rtc-rx8581.c
index c5ffd30ca672..171ee241bd2f 100644
--- a/drivers/rtc/rtc-rx8581.c
+++ b/drivers/rtc/rtc-rx8581.c
@@ -153,10 +153,7 @@ static int rx8581_get_datetime(struct i2c_client *client, struct rtc_time *tm)
 	tm->tm_wday = ilog2(date[RX8581_REG_DW] & 0x7F);
 	tm->tm_mday = bcd2bin(date[RX8581_REG_DM] & 0x3F);
 	tm->tm_mon = bcd2bin(date[RX8581_REG_MO] & 0x1F) - 1; /* rtc mn 1-12 */
-	tm->tm_year = bcd2bin(date[RX8581_REG_YR]);
-	if (tm->tm_year < 70)
-		tm->tm_year += 100;	/* assume we are in 1970...2069 */
-
+	tm->tm_year = bcd2bin(date[RX8581_REG_YR]) + 100;
 
 	dev_dbg(&client->dev, "%s: tm is secs=%d, mins=%d, hours=%d, "
 		"mday=%d, mon=%d, year=%d, wday=%d\n",
@@ -190,7 +187,7 @@ static int rx8581_set_datetime(struct i2c_client *client, struct rtc_time *tm)
 	buf[RX8581_REG_MO] = bin2bcd(tm->tm_mon + 1);
 
 	/* year and century */
-	buf[RX8581_REG_YR] = bin2bcd(tm->tm_year % 100);
+	buf[RX8581_REG_YR] = bin2bcd(tm->tm_year - 100);
 	buf[RX8581_REG_DW] = (0x1 << tm->tm_wday);
 
 	/* Stop the clock */
@@ -293,6 +290,8 @@ static int rx8581_probe(struct i2c_client *client,
 	rx8581->rtc->ops = &rx8581_rtc_ops;
 	rx8581->rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
 	rx8581->rtc->range_max = RTC_TIMESTAMP_END_2099;
+	rx8581->rtc->start_secs = 0;
+	rx8581->rtc->set_start_time = true;
 
 	return rtc_register_device(rx8581->rtc);
 }
-- 
2.17.0
