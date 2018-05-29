Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932232AbeE2IPh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 04:15:37 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51452 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754919AbeE2IPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 04:15:31 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B16B56028C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
From: Mukesh Ojha <mojha@codeaurora.org>
To: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Mukesh Ojha <mojha@codeaurora.org>
Subject: [PATCH] time: Fix sleeptime injection for non-stop clocksource & persistent clock
Date: Tue, 29 May 2018 13:45:18 +0530
Message-Id: <1527581718-5624-1-git-send-email-mojha@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, for both non-stop clocksource and persistent clock
there is a corner case, when a driver failed to go suspend mode
rtc_resume injects the sleeptime as timekeeping_rtc_skipresume
returned 'false' due to which we can see mismatch in time with
system clock.

Success case:
                                         {sleeptime_injected=true}
rtc_suspend() => timekeeping_suspend() => timekeeping_resume() => rtc_resume()

Failure case:
             {failure in sleep path} {sleeptime_injected=false}
rtc_suspend()       =>             rtc_resume()

Change-Id: I98928761c98cec21a3033a55d3e10fb34138f38c
Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
---
 kernel/time/timekeeping.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 427e33d..c022d82 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1511,9 +1511,6 @@ void __weak read_boot_clock64(struct timespec64 *ts)
 	ts->tv_nsec = 0;
 }
 
-/* Flag for if timekeeping_resume() has injected sleeptime */
-static bool sleeptime_injected;
-
 /* Flag for if there is a persistent clock on this platform */
 static bool persistent_clock_exists;
 
@@ -1611,7 +1608,14 @@ static void __timekeeping_inject_sleeptime(struct timekeeper *tk,
  */
 bool timekeeping_rtc_skipresume(void)
 {
-	return sleeptime_injected;
+	struct timekeeper *tk = &tk_core.timekeeper;
+	bool skip_rtc_resume = false;
+
+	skip_rtc_resume = ((tk->tkr_mono.clock->flags &
+			CLOCK_SOURCE_SUSPEND_NONSTOP) ||
+			(persistent_clock_exists)) ? true : false;
+
+	return skip_rtc_resume;
 }
 
 /**
@@ -1671,8 +1675,8 @@ void timekeeping_resume(void)
 	unsigned long flags;
 	struct timespec64 ts_new, ts_delta;
 	cycle_t cycle_now, cycle_delta;
+	bool sleeptime_injected = false;
 
-	sleeptime_injected = false;
 	read_persistent_clock64(&ts_new);
 
 	clockevents_resume();
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project
