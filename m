Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752759AbeBXAI7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 19:08:59 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:41702 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752172AbeBXAI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 19:08:56 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH] rtc: pcf85363: set time accurately
Date: Sat, 24 Feb 2018 01:08:51 +0100
Message-Id: <20180224000853.29365-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180224000853.29365-1-alexandre.belloni@bootlin.com>
References: <20180224000853.29365-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per 8.2.6 Setting and reading the time in RTC mode, first stop the clok,
then reset it before setting the date and time registers. Finally, start
the clock.

This uses register address wrap around from 0x2f to 0x00 for efficiency.

This allows to set the clock with a millisecond accuracy (drift is not
corrected in this example):

RTC        System
1325388767 1325388767.000029180
1325388768 1325388768.000018362
1325388769 1325388769.000006544
1325388770 1325388769.999992725
1325388771 1325388770.999974544

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-pcf85363.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-pcf85363.c b/drivers/rtc/rtc-pcf85363.c
index 3fa5bda59987..c04a1edcd571 100644
--- a/drivers/rtc/rtc-pcf85363.c
+++ b/drivers/rtc/rtc-pcf85363.c
@@ -106,6 +106,10 @@
 #define PIN_IO_INTA_OUT	2
 #define PIN_IO_INTA_HIZ	3
 
+#define STOP_EN_STOP	BIT(0)
+
+#define RESET_CPR	0xa4
+
 #define NVRAM_SIZE	0x40
 
 static struct i2c_driver pcf85363_driver;
@@ -148,8 +152,12 @@ static int pcf85363_rtc_read_time(struct device *dev, struct rtc_time *tm)
 static int pcf85363_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
 	struct pcf85363 *pcf85363 = dev_get_drvdata(dev);
-	unsigned char buf[DT_YEARS + 1];
-	int len = sizeof(buf);
+	unsigned char tmp[11];
+	unsigned char *buf = &tmp[2];
+	int ret;
+
+	tmp[0] = STOP_EN_STOP;
+	tmp[1] = RESET_CPR;
 
 	buf[DT_100THS] = 0;
 	buf[DT_SECS] = bin2bcd(tm->tm_sec);
@@ -160,8 +168,12 @@ static int pcf85363_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	buf[DT_MONTHS] = bin2bcd(tm->tm_mon + 1);
 	buf[DT_YEARS] = bin2bcd(tm->tm_year % 100);
 
-	return regmap_bulk_write(pcf85363->regmap, DT_100THS,
-				 buf, len);
+	ret = regmap_bulk_write(pcf85363->regmap, CTRL_STOP_EN,
+				tmp, sizeof(tmp));
+	if (ret)
+		return ret;
+
+	return regmap_write(pcf85363->regmap, CTRL_STOP_EN, 0);
 }
 
 static int pcf85363_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
-- 
2.16.1
