Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752428AbeBUVFW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 16:05:22 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:47077 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752006AbeBUU5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 15:57:54 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 082/100] rtc: spear: stop validating rtc_time in .set_time and .set_alarm
Date: Wed, 21 Feb 2018 21:56:17 +0100
Message-Id: <20180221205635.31314-83-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180221205635.31314-1-alexandre.belloni@bootlin.com>
References: <20180221205635.31314-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RTC core is always validating the rtc_time struct before calling
.set_time or .set_alarm. It is not necessary to do it again.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-spear.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/rtc/rtc-spear.c b/drivers/rtc/rtc-spear.c
index e377f42abae7..0567944fd4f8 100644
--- a/drivers/rtc/rtc-spear.c
+++ b/drivers/rtc/rtc-spear.c
@@ -170,18 +170,14 @@ static irqreturn_t spear_rtc_irq(int irq, void *dev_id)
 
 }
 
-static int tm2bcd(struct rtc_time *tm)
+static void tm2bcd(struct rtc_time *tm)
 {
-	if (rtc_valid_tm(tm) != 0)
-		return -EINVAL;
 	tm->tm_sec = bin2bcd(tm->tm_sec);
 	tm->tm_min = bin2bcd(tm->tm_min);
 	tm->tm_hour = bin2bcd(tm->tm_hour);
 	tm->tm_mday = bin2bcd(tm->tm_mday);
 	tm->tm_mon = bin2bcd(tm->tm_mon + 1);
 	tm->tm_year = bin2bcd(tm->tm_year);
-
-	return 0;
 }
 
 static void bcd2tm(struct rtc_time *tm)
@@ -237,8 +233,7 @@ static int spear_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	struct spear_rtc_config *config = dev_get_drvdata(dev);
 	unsigned int time, date;
 
-	if (tm2bcd(tm) < 0)
-		return -EINVAL;
+	tm2bcd(tm);
 
 	rtc_wait_not_busy(config);
 	time = (tm->tm_sec << SECOND_SHIFT) | (tm->tm_min << MINUTE_SHIFT) |
@@ -295,8 +290,7 @@ static int spear_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
 	unsigned int time, date;
 	int err;
 
-	if (tm2bcd(&alm->time) < 0)
-		return -EINVAL;
+	tm2bcd(&alm->time);
 
 	rtc_wait_not_busy(config);
 
-- 
2.16.1
