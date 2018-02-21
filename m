Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752076AbeBUVNk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 16:13:40 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:47018 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751737AbeBUU5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 15:57:36 -0500
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 050/100] rtc: nuc900: stop validating rtc_time in .read_time
Date: Wed, 21 Feb 2018 21:55:45 +0100
Message-Id: <20180221205635.31314-51-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180221205635.31314-1-alexandre.belloni@bootlin.com>
References: <20180221205635.31314-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RTC core is always calling rtc_valid_tm after the read_time callback.
It is not necessary to call it before returning from the callback.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-nuc900.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/rtc/rtc-nuc900.c b/drivers/rtc/rtc-nuc900.c
index 4ed81117cf5f..7da664a77181 100644
--- a/drivers/rtc/rtc-nuc900.c
+++ b/drivers/rtc/rtc-nuc900.c
@@ -102,8 +102,8 @@ static int *check_rtc_access_enable(struct nuc900_rtc *nuc900_rtc)
 	return NULL;
 }
 
-static int nuc900_rtc_bcd2bin(unsigned int timereg,
-				unsigned int calreg, struct rtc_time *tm)
+static void nuc900_rtc_bcd2bin(unsigned int timereg,
+			       unsigned int calreg, struct rtc_time *tm)
 {
 	tm->tm_mday	= bcd2bin(calreg >> 0);
 	tm->tm_mon	= bcd2bin(calreg >> 8);
@@ -112,8 +112,6 @@ static int nuc900_rtc_bcd2bin(unsigned int timereg,
 	tm->tm_sec	= bcd2bin(timereg >> 0);
 	tm->tm_min	= bcd2bin(timereg >> 8);
 	tm->tm_hour	= bcd2bin(timereg >> 16);
-
-	return rtc_valid_tm(tm);
 }
 
 static void nuc900_rtc_bin2bcd(struct device *dev, struct rtc_time *settm,
@@ -156,7 +154,9 @@ static int nuc900_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	timeval = __raw_readl(rtc->rtc_reg + REG_RTC_TLR);
 	clrval	= __raw_readl(rtc->rtc_reg + REG_RTC_CLR);
 
-	return nuc900_rtc_bcd2bin(timeval, clrval, tm);
+	nuc900_rtc_bcd2bin(timeval, clrval, tm);
+
+	return 0;
 }
 
 static int nuc900_rtc_set_time(struct device *dev, struct rtc_time *tm)
@@ -189,7 +189,9 @@ static int nuc900_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	timeval = __raw_readl(rtc->rtc_reg + REG_RTC_TAR);
 	carval	= __raw_readl(rtc->rtc_reg + REG_RTC_CAR);
 
-	return nuc900_rtc_bcd2bin(timeval, carval, &alrm->time);
+	nuc900_rtc_bcd2bin(timeval, carval, &alrm->time);
+
+	return rtc_valid_tm(&alrm->time);
 }
 
 static int nuc900_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
-- 
2.16.1
