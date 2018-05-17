Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752386AbeEQUU7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 16:20:59 -0400
Received: from mail.bootlin.com ([62.4.15.54]:38538 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751626AbeEQUTQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 16:19:16 -0400
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 5/5] rtc: 88pm80x: convert to rtc_tm_to_time64/rtc_time64_to_tm
Date: Thu, 17 May 2018 22:19:00 +0200
Message-Id: <20180517201900.22055-5-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180517201900.22055-1-alexandre.belloni@bootlin.com>
References: <20180517201900.22055-1-alexandre.belloni@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the RTC range is properly checked, convert the driver to
rtc_tm_to_time64/rtc_time64_to_tm

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-88pm80x.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/rtc/rtc-88pm80x.c b/drivers/rtc/rtc-88pm80x.c
index 33b28b6117e9..cab293cb2bf0 100644
--- a/drivers/rtc/rtc-88pm80x.c
+++ b/drivers/rtc/rtc-88pm80x.c
@@ -98,13 +98,13 @@ static void rtc_next_alarm_time(struct rtc_time *next, struct rtc_time *now,
 	next->tm_min = alrm->tm_min;
 	next->tm_sec = alrm->tm_sec;
 
-	rtc_tm_to_time(now, &now_time);
-	rtc_tm_to_time(next, &next_time);
+	now_time = rtc_tm_to_time64(now);
+	next_time = rtc_tm_to_time64(next);
 
 	if (next_time < now_time) {
 		/* Advance one day */
 		next_time += 60 * 60 * 24;
-		rtc_time_to_tm(next_time, next);
+		rtc_time64_to_tm(next_time, next);
 	}
 }
 
@@ -123,7 +123,7 @@ static int pm80x_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	ticks = base + data;
 	dev_dbg(info->dev, "get base:0x%lx, RO count:0x%lx, ticks:0x%lx\n",
 		base, data, ticks);
-	rtc_time_to_tm(ticks, tm);
+	rtc_time64_to_tm(ticks, tm);
 	return 0;
 }
 
@@ -133,7 +133,7 @@ static int pm80x_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	unsigned char buf[4];
 	unsigned long ticks, base, data;
 
-	rtc_tm_to_time(tm, &ticks);
+	ticks = rtc_tm_to_time64(tm);
 
 	/* load 32-bit read-only counter */
 	regmap_raw_read(info->map, PM800_RTC_COUNTER1, buf, 4);
@@ -167,7 +167,7 @@ static int pm80x_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	dev_dbg(info->dev, "get base:0x%lx, RO count:0x%lx, ticks:0x%lx\n",
 		base, data, ticks);
 
-	rtc_time_to_tm(ticks, &alrm->time);
+	rtc_time64_to_tm(ticks, &alrm->time);
 	regmap_read(info->map, PM800_RTC_CONTROL, &ret);
 	alrm->enabled = (ret & PM800_ALARM1_EN) ? 1 : 0;
 	alrm->pending = (ret & (PM800_ALARM | PM800_ALARM_WAKEUP)) ? 1 : 0;
@@ -195,11 +195,11 @@ static int pm80x_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	dev_dbg(info->dev, "get base:0x%lx, RO count:0x%lx, ticks:0x%lx\n",
 		base, data, ticks);
 
-	rtc_time_to_tm(ticks, &now_tm);
+	rtc_time64_to_tm(ticks, &now_tm);
 	dev_dbg(info->dev, "%s, now time : %lu\n", __func__, ticks);
 	rtc_next_alarm_time(&alarm_tm, &now_tm, &alrm->time);
 	/* get new ticks for alarm in 24 hours */
-	rtc_tm_to_time(&alarm_tm, &ticks);
+	ticks = rtc_tm_to_time64(&alarm_tm);
 	dev_dbg(info->dev, "%s, alarm time: %lu\n", __func__, ticks);
 	data = ticks - base;
 
-- 
2.17.0
