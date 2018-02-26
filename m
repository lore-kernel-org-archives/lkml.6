Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752662AbeBZIet (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 03:34:49 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:39182 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752607AbeBZIeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 03:34:36 -0500
X-Google-Smtp-Source: AH8x22696YJSbNlRtQA0+FnMQKqy4aIpSN/5z0wRvUcHtz0IDWJdQEObqRSvejeU05YgA4xx6m+L7w==
From: Baolin Wang <baolin.wang@linaro.org>
To: a.zummo@towertech.it, alexandre.belloni@bootlin.com
Cc: arnd@arndb.de, broonie@kernel.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, baolin.wang@linaro.org,
        alexandre.belloni@free-electrons.com
Subject: [RESEND PATCH 2/3] rtc: Factor out the RTC range validation into rtc_valid_range()
Date: Mon, 26 Feb 2018 16:33:57 +0800
Message-Id: <bd6f7e87742bb5d7896c36f7c62f78f08941bc8e.1519633350.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <b8a475beaa4739032e3346572af2e412ebccb787.1519633350.git.baolin.wang@linaro.org>
References: <b8a475beaa4739032e3346572af2e412ebccb787.1519633350.git.baolin.wang@linaro.org>
In-Reply-To: <b8a475beaa4739032e3346572af2e412ebccb787.1519633350.git.baolin.wang@linaro.org>
References: <b8a475beaa4739032e3346572af2e412ebccb787.1519633350.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RTC range validation code can be factored into rtc_valid_range()
function to avoid duplicate code.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/rtc/interface.c |   30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
index c068dae..25aebc5 100644
--- a/drivers/rtc/interface.c
+++ b/drivers/rtc/interface.c
@@ -23,6 +23,18 @@
 static int rtc_timer_enqueue(struct rtc_device *rtc, struct rtc_timer *timer);
 static void rtc_timer_remove(struct rtc_device *rtc, struct rtc_timer *timer);
 
+static int rtc_valid_range(struct rtc_device *rtc, struct rtc_time *tm)
+{
+	if (rtc->range_min != rtc->range_max) {
+		time64_t time = rtc_tm_to_time64(tm);
+
+		if (time < rtc->range_min || time > rtc->range_max)
+			return -ERANGE;
+	}
+
+	return 0;
+}
+
 static int __rtc_read_time(struct rtc_device *rtc, struct rtc_time *tm)
 {
 	int err;
@@ -70,12 +82,9 @@ int rtc_set_time(struct rtc_device *rtc, struct rtc_time *tm)
 	if (err != 0)
 		return err;
 
-	if (rtc->range_min != rtc->range_max) {
-		time64_t time = rtc_tm_to_time64(tm);
-
-		if (time < rtc->range_min || time > rtc->range_max)
-			return -ERANGE;
-	}
+	err = rtc_valid_range(rtc, tm);
+	if (err)
+		return err;
 
 	err = mutex_lock_interruptible(&rtc->ops_lock);
 	if (err)
@@ -381,12 +390,9 @@ int rtc_set_alarm(struct rtc_device *rtc, struct rtc_wkalrm *alarm)
 	if (err != 0)
 		return err;
 
-	if (rtc->range_min != rtc->range_max) {
-		time64_t time = rtc_tm_to_time64(&alarm->time);
-
-		if (time < rtc->range_min || time > rtc->range_max)
-			return -ERANGE;
-	}
+	err = rtc_valid_range(rtc, &alarm->time);
+	if (err)
+		return err;
 
 	err = mutex_lock_interruptible(&rtc->ops_lock);
 	if (err)
-- 
1.7.9.5
