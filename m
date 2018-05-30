Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753540AbeE3LpX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:45:23 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35390 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753153AbeE3LpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:45:20 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 659586060A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
From: Mukesh Ojha <mojha@codeaurora.org>
To: john.stultz@linaro.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Cc: neeraju@codeaurora.org, gkohli@codeaurora.org, cpandya@codeaurora.org,
        Mukesh Ojha <mojha@codeaurora.org>
Subject: [PATCH v2] time: Fix sleeptime injection for non-stop clocksource & persistent clock
Date: Wed, 30 May 2018 17:14:59 +0530
Message-Id: <1527680699-16068-1-git-send-email-mojha@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, for both non-stop clocksource and persistent clock
there is a corner case, when a driver failed to go suspend mode.
rtc_resume() injects the sleeptime as timekeeping_rtc_skipresume()
returned 'false'(sleeptime_injected=false) due to which we can
see mismatch in timestamps between system clock and other timers.

Fix this by updating sleeptime_injected=true for both non-stop
clocksource and persistent clock.

Success case:
------------
                                         {sleeptime_injected=true}
rtc_suspend() => timekeeping_suspend() => timekeeping_resume() =>
  rtc_resume()

Failure case:
------------
             {failure in sleep path} {sleeptime_injected=false}
rtc_suspend()          =>            rtc_resume()

Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
---
Changes in v2:
 * Updated the commit text.
 * Removed extra variable and used the earlier static
   variable 'sleeptime_injected'.

 kernel/time/timekeeping.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 49cbcee..2754c1b 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1610,6 +1610,17 @@ static void __timekeeping_inject_sleeptime(struct timekeeper *tk,
  */
 bool timekeeping_rtc_skipresume(void)
 {
+	struct timekeeper *tk = &tk_core.timekeeper;
+	/*
+	 * This is to ensure that we don't end up injecting
+	 * the sleeptime via rtc_resume() for non-stop clocksource
+	 * when we fail to sleep.
+	 */
+	if (!sleeptime_injected)
+		sleeptime_injected = ((tk->tkr_mono.clock->flags &
+			CLOCK_SOURCE_SUSPEND_NONSTOP) ||
+			(persistent_clock_exists)) ? true : false;
+
 	return sleeptime_injected;
 }
 
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project
