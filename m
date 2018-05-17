Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752488AbeEQUVP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 16:21:15 -0400
Received: from mail.bootlin.com ([62.4.15.54]:38640 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752326AbeEQUVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 16:21:12 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 2/2] rtc: ab-b5ze-s3: let the core handle the RTC range
Date: Thu, 17 May 2018 22:20:40 +0200
Message-Id: <20180517202040.22292-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180517202040.22292-1-alexandre.belloni@bootlin.com>
References: <20180517202040.22292-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ab-b5ze-s3 RTC is storing the year in an 8bit bcd coded register so it
can handle dates from year 2000 to year 2099.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ab-b5ze-s3.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/rtc/rtc-ab-b5ze-s3.c b/drivers/rtc/rtc-ab-b5ze-s3.c
index f486912577e7..2233601761ac 100644
--- a/drivers/rtc/rtc-ab-b5ze-s3.c
+++ b/drivers/rtc/rtc-ab-b5ze-s3.c
@@ -265,15 +265,6 @@ static int abb5zes3_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	u8 regs[ABB5ZES3_REG_RTC_SC + ABB5ZES3_RTC_SEC_LEN];
 	int ret;
 
-	/*
-	 * Year register is 8-bit wide and bcd-coded, i.e records values
-	 * between 0 and 99. tm_year is an offset from 1900 and we are
-	 * interested in the 2000-2099 range, so any value less than 100
-	 * is invalid.
-	 */
-	if (tm->tm_year < 100)
-		return -EINVAL;
-
 	regs[ABB5ZES3_REG_RTC_SC] = bin2bcd(tm->tm_sec); /* MSB=0 clears OSC */
 	regs[ABB5ZES3_REG_RTC_MN] = bin2bcd(tm->tm_min);
 	regs[ABB5ZES3_REG_RTC_HR] = bin2bcd(tm->tm_hour); /* 24-hour format */
@@ -951,6 +942,8 @@ static int abb5zes3_probe(struct i2c_client *client,
 	}
 
 	data->rtc->ops = &rtc_ops;
+	data->rtc->range_min = RTC_TIMESTAMP_BEGIN_2000;
+	data->rtc->range_max = RTC_TIMESTAMP_END_2099;
 
 	/* Enable battery low detection interrupt if battery not already low */
 	if (!data->battery_low && data->irq) {
-- 
2.17.0
