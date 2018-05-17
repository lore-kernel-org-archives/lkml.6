Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752297AbeEQUsZ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 16:48:25 -0400
Received: from mail.bootlin.com ([62.4.15.54]:39366 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751976AbeEQUsY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 16:48:24 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 2/2] rtc: tps6586x: let the core handle rtc range
Date: Thu, 17 May 2018 22:48:18 +0200
Message-Id: <20180517204818.28593-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180517204818.28593-1-alexandre.belloni@bootlin.com>
References: <20180517204818.28593-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let the core handle offsetting and windowing the RTC range.

The RTC has a 40-bit counter counting at 1024 Hz. So its maximum value is
2^(40-10) - 1. Also, let the core handle the offset instead of coding it in
the callbacks. Keep the default epoch at the beginning of 2009 (this will
fail in 2043).

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-tps6586x.c | 27 +++++----------------------
 1 file changed, 5 insertions(+), 22 deletions(-)

diff --git a/drivers/rtc/rtc-tps6586x.c b/drivers/rtc/rtc-tps6586x.c
index 9b741143f131..d6434e514a52 100644
--- a/drivers/rtc/rtc-tps6586x.c
+++ b/drivers/rtc/rtc-tps6586x.c
@@ -58,7 +58,6 @@ struct tps6586x_rtc {
 	struct rtc_device	*rtc;
 	int			irq;
 	bool			irq_en;
-	time64_t		epoch_start;
 };
 
 static inline struct device *to_tps6586x_dev(struct device *dev)
@@ -68,7 +67,6 @@ static inline struct device *to_tps6586x_dev(struct device *dev)
 
 static int tps6586x_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
-	struct tps6586x_rtc *rtc = dev_get_drvdata(dev);
 	struct device *tps_dev = to_tps6586x_dev(dev);
 	unsigned long long ticks = 0;
 	time64_t seconds;
@@ -88,14 +86,13 @@ static int tps6586x_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	}
 
 	seconds = ticks >> 10;
-	seconds += rtc->epoch_start;
-	rtc_time_to_tm(seconds, tm);
+	rtc_time64_to_tm(seconds, tm);
+
 	return 0;
 }
 
 static int tps6586x_rtc_set_time(struct device *dev, struct rtc_time *tm)
 {
-	struct tps6586x_rtc *rtc = dev_get_drvdata(dev);
 	struct device *tps_dev = to_tps6586x_dev(dev);
 	unsigned long long ticks;
 	time64_t seconds;
@@ -103,11 +100,6 @@ static int tps6586x_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	int ret;
 
 	seconds = rtc_tm_to_time64(tm);
-	if (seconds < rtc->epoch_start) {
-		dev_err(dev, "requested time unsupported\n");
-		return -EINVAL;
-	}
-	seconds -= rtc->epoch_start;
 
 	ticks = (unsigned long long)seconds << 10;
 	buff[0] = (ticks >> 32) & 0xff;
@@ -155,7 +147,6 @@ static int tps6586x_rtc_alarm_irq_enable(struct device *dev,
 
 static int tps6586x_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
-	struct tps6586x_rtc *rtc = dev_get_drvdata(dev);
 	struct device *tps_dev = to_tps6586x_dev(dev);
 	time64_t seconds;
 	unsigned long ticks;
@@ -168,18 +159,12 @@ static int tps6586x_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 
 	seconds = rtc_tm_to_time64(&alrm->time);
 
-	if (alrm->enabled && (seconds < rtc->epoch_start)) {
-		dev_err(dev, "can't set alarm to requested time\n");
-		return -EINVAL;
-	}
-
 	ret = tps6586x_rtc_alarm_irq_enable(dev, alrm->enabled);
 	if (ret < 0) {
 		dev_err(dev, "can't set alarm irq, err %d\n", ret);
 		return ret;
 	}
 
-	seconds -= rtc->epoch_start;
 	ret = tps6586x_reads(tps_dev, RTC_COUNT4_DUMMYREAD,
 			sizeof(rbuff), rbuff);
 	if (ret < 0) {
@@ -210,7 +195,6 @@ static int tps6586x_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 
 static int tps6586x_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 {
-	struct tps6586x_rtc *rtc = dev_get_drvdata(dev);
 	struct device *tps_dev = to_tps6586x_dev(dev);
 	unsigned long ticks;
 	time64_t seconds;
@@ -225,7 +209,6 @@ static int tps6586x_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 
 	ticks = (buff[0] << 16) | (buff[1] << 8) | buff[2];
 	seconds = ticks >> 10;
-	seconds += rtc->epoch_start;
 
 	rtc_time64_to_tm(seconds, &alrm->time);
 	return 0;
@@ -260,9 +243,6 @@ static int tps6586x_rtc_probe(struct platform_device *pdev)
 	rtc->dev = &pdev->dev;
 	rtc->irq = platform_get_irq(pdev, 0);
 
-	/* Set epoch start as 00:00:00:01:01:2009 */
-	rtc->epoch_start = mktime64(2009, 1, 1, 0, 0, 0);
-
 	/* 1 kHz tick mode, enable tick counting */
 	ret = tps6586x_update(tps_dev, RTC_CTRL,
 		RTC_ENABLE | OSC_SRC_SEL |
@@ -284,6 +264,9 @@ static int tps6586x_rtc_probe(struct platform_device *pdev)
 	}
 
 	rtc->rtc->ops = &tps6586x_rtc_ops;
+	rtc->rtc->range_max = (1ULL << 30) - 1; /* 30-bit seconds */
+	rtc->rtc->start_secs = mktime64(2009, 1, 1, 0, 0, 0);
+	rtc->rtc->set_start_time = true;
 
 	ret = devm_request_threaded_irq(&pdev->dev, rtc->irq, NULL,
 				tps6586x_rtc_irq,
-- 
2.17.0
