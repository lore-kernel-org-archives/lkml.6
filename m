Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A805EECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BA8F2098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:49:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BA8F2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387496AbeIXUvp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:51:45 -0400
Received: from mail.bootlin.com ([62.4.15.54]:42303 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733159AbeIXUvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:51:41 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 7F59820723; Mon, 24 Sep 2018 16:49:08 +0200 (CEST)
Received: from localhost (unknown [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 5104C20725;
        Mon, 24 Sep 2018 16:49:08 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 2/3] rtc: ab8500: let the core handle range
Date:   Mon, 24 Sep 2018 16:49:01 +0200
Message-Id: <20180924144902.607-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924144902.607-1-alexandre.belloni@bootlin.com>
References: <20180924144902.607-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let the core handle offsetting and windowing the RTC range.
The RTC has a 24 bit counter for minutes plus a seconds counter.
Keep the epoch at the beginning of 2000.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-ab8500.c | 53 +++-------------------------------------
 1 file changed, 4 insertions(+), 49 deletions(-)

diff --git a/drivers/rtc/rtc-ab8500.c b/drivers/rtc/rtc-ab8500.c
index e97015e5c63e..2e2671b84ab0 100644
--- a/drivers/rtc/rtc-ab8500.c
+++ b/drivers/rtc/rtc-ab8500.c
@@ -46,7 +46,6 @@
 #define RTC_STATUS_DATA			0x01
 
 #define COUNTS_PER_SEC			(0xF000 / 60)
-#define AB8500_RTC_EPOCH		2000
 
 static const u8 ab8500_rtc_time_regs[] = {
 	AB8500_RTC_WATCH_TMIN_HI_REG, AB8500_RTC_WATCH_TMIN_MID_REG,
@@ -59,23 +58,6 @@ static const u8 ab8500_rtc_alarm_regs[] = {
 	AB8500_RTC_ALRM_MIN_LOW_REG
 };
 
-/* Calculate the seconds from 1970 to 01-01-2000 00:00:00 */
-static unsigned long get_elapsed_seconds(int year)
-{
-	unsigned long secs;
-	struct rtc_time tm = {
-		.tm_year = year - 1900,
-		.tm_mday = 1,
-	};
-
-	/*
-	 * This function calculates secs from 1970 and not from
-	 * 1900, even if we supply the offset from year 1900.
-	 */
-	rtc_tm_to_time(&tm, &secs);
-	return secs;
-}
-
 static int ab8500_rtc_read_time(struct device *dev, struct rtc_time *tm)
 {
 	unsigned long timeout = jiffies + HZ;
@@ -118,9 +100,6 @@ static int ab8500_rtc_read_time(struct device *dev, struct rtc_time *tm)
 	secs =	secs / COUNTS_PER_SEC;
 	secs =	secs + (mins * 60);
 
-	/* Add back the initially subtracted number of seconds */
-	secs += get_elapsed_seconds(AB8500_RTC_EPOCH);
-
 	rtc_time_to_tm(secs, tm);
 	return 0;
 }
@@ -131,21 +110,8 @@ static int ab8500_rtc_set_time(struct device *dev, struct rtc_time *tm)
 	unsigned char buf[ARRAY_SIZE(ab8500_rtc_time_regs)];
 	unsigned long no_secs, no_mins, secs = 0;
 
-	if (tm->tm_year < (AB8500_RTC_EPOCH - 1900)) {
-		dev_dbg(dev, "year should be equal to or greater than %d\n",
-				AB8500_RTC_EPOCH);
-		return -EINVAL;
-	}
-
-	/* Get the number of seconds since 1970 */
 	rtc_tm_to_time(tm, &secs);
 
-	/*
-	 * Convert it to the number of seconds since 01-01-2000 00:00:00, since
-	 * we only have a small counter in the RTC.
-	 */
-	secs -= get_elapsed_seconds(AB8500_RTC_EPOCH);
-
 	no_mins = secs / 60;
 
 	no_secs = secs % 60;
@@ -202,9 +168,6 @@ static int ab8500_rtc_read_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 	mins = (buf[0] << 16) | (buf[1] << 8) | (buf[2]);
 	secs = mins * 60;
 
-	/* Add back the initially subtracted number of seconds */
-	secs += get_elapsed_seconds(AB8500_RTC_EPOCH);
-
 	rtc_time_to_tm(secs, &alarm->time);
 
 	return rtc_valid_tm(&alarm->time);
@@ -224,12 +187,6 @@ static int ab8500_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 	unsigned long mins, secs = 0, cursec = 0;
 	struct rtc_time curtm;
 
-	if (alarm->time.tm_year < (AB8500_RTC_EPOCH - 1900)) {
-		dev_dbg(dev, "year should be equal to or greater than %d\n",
-				AB8500_RTC_EPOCH);
-		return -EINVAL;
-	}
-
 	/* Get the number of seconds since 1970 */
 	rtc_tm_to_time(&alarm->time, &secs);
 
@@ -245,12 +202,6 @@ static int ab8500_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alarm)
 		return -EINVAL;
 	}
 
-	/*
-	 * Convert it to the number of seconds since 01-01-2000 00:00:00, since
-	 * we only have a small counter in the RTC.
-	 */
-	secs -= get_elapsed_seconds(AB8500_RTC_EPOCH);
-
 	mins = secs / 60;
 
 	buf[2] = mins & 0xFF;
@@ -445,6 +396,10 @@ static int ab8500_rtc_probe(struct platform_device *pdev)
 
 	rtc->uie_unsupported = 1;
 
+	rtc->range_max = (1ULL << 24) * 60 - 1; // 24-bit minutes + 59 secs
+	rtc->start_secs = RTC_TIMESTAMP_BEGIN_2000;
+	rtc->set_start_time = true;
+
 	err = rtc_add_group(rtc, &ab8500_rtc_sysfs_files);
 	if (err)
 		return err;
-- 
2.19.0

