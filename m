Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38247ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 06:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBB4E208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 06:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Q95yKrYR";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ZLgreuFD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBB4E208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729672AbeGQHCk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 03:02:40 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:41850 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727832AbeGQHCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 03:02:39 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 95FB3607C6; Tue, 17 Jul 2018 06:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531809099;
        bh=NTPPltkDieS8xz+vDM2Lqdc6t6XUgZV9zVVSyldykfE=;
        h=From:To:Cc:Subject:Date:From;
        b=Q95yKrYRFf10l8B8/fUpdEmkPqn3waja7EWkZhiqgJhmyNsN7PNw6obGI9LANUiVy
         gdaT0S5aJ2QiNfv/VexuUJk/+1NqYEQ5qQERkn/jz/ovtUNKmHV1xsSiIlytgDZHBe
         hTnhMWoa1xc7keO/Jmz/FrJLcxWi7WHUxWzl3TqU=
Received: from mojha-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7FC846060A;
        Tue, 17 Jul 2018 06:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531809098;
        bh=NTPPltkDieS8xz+vDM2Lqdc6t6XUgZV9zVVSyldykfE=;
        h=From:To:Cc:Subject:Date:From;
        b=ZLgreuFDvdDzxOpbgIoM3mbE198n03xMF7ZK/5H7jK64Rpf7uvEKikNTIZZPXncK5
         Y2nO8oSKF2MJQhyPQY3Cixp2VItz6Wud1Eu0JPcBGGZZ/tt8/BARAg7Kysgpc/GG0p
         Ul8TrT0fH15eyZUijYgNDSROOvBM5W7FBWn5GYRY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7FC846060A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
From:   Mukesh Ojha <mojha@codeaurora.org>
To:     john.stultz@linaro.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Cc:     gkohli@codeaurora.org, cpandya@codeaurora.org,
        neeraju@codeaurora.org, Mukesh Ojha <mojha@codeaurora.org>
Subject: [PATCH v5] time: Fix extra sleeptime injection when suspend fails
Date:   Tue, 17 Jul 2018 12:01:29 +0530
Message-Id: <1531809089-8927-1-git-send-email-mojha@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, there exists a corner case assuming when there is
only one clocksource e.g RTC, and system failed to go to
suspend mode. While resume rtc_resume() injects the sleeptime
as timekeeping_rtc_skipresume() returned 'false' (default value
of sleeptime_injected) due to which we can see mismatch in
timestamps.

This issue can also come in a system where more than one
clocksource are present and very first suspend fails.

Success case:
------------
                                        {sleeptime_injected=false}
rtc_suspend() => timekeeping_suspend() => timekeeping_resume() =>

(sleeptime injected)
 rtc_resume()

Failure case:
------------
         {failure in sleep path} {sleeptime_injected=false}
rtc_suspend()     =>          rtc_resume()

{sleeptime injected again which was not required as the suspend failed}

Fix this by handling the boolean logic properly.

Originally-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
---
Changes in V5:
 * Took extra variable `inject_sleeptime` to take care of injecting sleeptime
   inside timekeeping_resume().
 * Inverted the return logic inside timekeeping_skipresume() instead of doing
   it in rtc_resume().
 * Updated commit description.
Changes in V4:
 * Changes as suggested by John
    - Changed the variable name from sleeptime_injected to suspend_timing_needed
    - Changed the boolean logic.
Changes in v3:
 * Updated commit subject and description.
 * Updated the patch as per the fix given by Thomas Gleixner.

Changes in v2:
 * Updated the commit text.
 * Removed extra variable and used the earlier static
   variable 'sleeptime_injected'.

 kernel/time/timekeeping.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 4786df9..380a93f 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1510,8 +1510,20 @@ void __weak read_boot_clock64(struct timespec64 *ts)
 	ts->tv_nsec = 0;
 }
 
-/* Flag for if timekeeping_resume() has injected sleeptime */
-static bool sleeptime_injected;
+/*
+ * Flag reflecting whether timekeeping_resume() has injected sleeptime.
+ *
+ * The flag starts of false and is only set when a suspend reaches
+ * timekeeping_suspend(), timekeeping_resume() sets it to false when the
+ * timekeeper clocksource is not stopping across suspend and has been
+ * used to update sleep time. If the timekeeper clocksource has stopped
+ * then the flag stays true and is used by the RTC resume code to decide
+ * whether sleeptime must be injected and if so the flag gets false then.
+ *
+ * If a suspend fails before reaching timekeeping_resume() then the flag
+ * stays false and prevents erroneous sleeptime injection.
+ */
+static bool suspend_timing_needed;
 
 /* Flag for if there is a persistent clock on this platform */
 static bool persistent_clock_exists;
@@ -1610,7 +1622,7 @@ static void __timekeeping_inject_sleeptime(struct timekeeper *tk,
  */
 bool timekeeping_rtc_skipresume(void)
 {
-	return sleeptime_injected;
+	return !suspend_timing_needed;
 }
 
 /**
@@ -1646,6 +1658,8 @@ void timekeeping_inject_sleeptime64(struct timespec64 *delta)
 	raw_spin_lock_irqsave(&timekeeper_lock, flags);
 	write_seqcount_begin(&tk_core.seq);
 
+	suspend_timing_needed = false;
+
 	timekeeping_forward_now(tk);
 
 	__timekeeping_inject_sleeptime(tk, delta);
@@ -1670,8 +1684,8 @@ void timekeeping_resume(void)
 	unsigned long flags;
 	struct timespec64 ts_new, ts_delta;
 	u64 cycle_now;
+	bool inject_sleeptime = false;
 
-	sleeptime_injected = false;
 	read_persistent_clock64(&ts_new);
 
 	clockevents_resume();
@@ -1701,14 +1715,16 @@ void timekeeping_resume(void)
 					      tk->tkr_mono.mask);
 		nsec = mul_u64_u32_shr(cyc_delta, clock->mult, clock->shift);
 		ts_delta = ns_to_timespec64(nsec);
-		sleeptime_injected = true;
+		inject_sleeptime = true;
 	} else if (timespec64_compare(&ts_new, &timekeeping_suspend_time) > 0) {
 		ts_delta = timespec64_sub(ts_new, timekeeping_suspend_time);
-		sleeptime_injected = true;
+		inject_sleeptime = true;
 	}
 
-	if (sleeptime_injected)
+	if (inject_sleeptime) {
+		suspend_timing_needed = false;
 		__timekeeping_inject_sleeptime(tk, &ts_delta);
+	}
 
 	/* Re-base the last cycle value */
 	tk->tkr_mono.cycle_last = cycle_now;
@@ -1743,6 +1759,8 @@ int timekeeping_suspend(void)
 	if (timekeeping_suspend_time.tv_sec || timekeeping_suspend_time.tv_nsec)
 		persistent_clock_exists = true;
 
+	suspend_timing_needed = true;
+
 	raw_spin_lock_irqsave(&timekeeper_lock, flags);
 	write_seqcount_begin(&tk_core.seq);
 	timekeeping_forward_now(tk);
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project

