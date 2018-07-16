Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA75ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 20:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA39020846
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 20:41:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="ibsZRQEb";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="PrlVHa2j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA39020846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730375AbeGPVKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 17:10:06 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:36476 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728075AbeGPVKG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 17:10:06 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 10AF5606DB; Mon, 16 Jul 2018 20:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531773660;
        bh=KgL+wIxQK5AMHv2P4Rxxaxd9VaZ2aa+8yRz7fDg4om0=;
        h=From:To:Cc:Subject:Date:From;
        b=ibsZRQEb6sVkKKHIaVT2qpivoLOdmggNSkT/I1kvO53Tg48KmeMGb6e5eEDPUygWK
         SPGNNqReIYpEMazswx7XyXvPQ5RHgka5uIi0WfgRB7RkYCNWZOMlZCn9NHCYYQKQ3H
         kiWOQf/q2JrwaCLsjXlo4Sc0cuI0NeNB3EtyeiUI=
Received: from mojha-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 756A060541;
        Mon, 16 Jul 2018 20:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531773659;
        bh=KgL+wIxQK5AMHv2P4Rxxaxd9VaZ2aa+8yRz7fDg4om0=;
        h=From:To:Cc:Subject:Date:From;
        b=PrlVHa2jn7AL4cjxIo4H/M96eMv0wb+DaSGSBtJn7b0LowfiWo7DQlE3BBQQ5gjKL
         KrSJMgiFNcuWwRCtgVHZFShjoaAwrkH4yxfTKo5YIX9LYZiogI2CCHFXeXy2y8g+DT
         HoFI79CQa48680iY6gCVDRuiqUD/JEx0zBn/SmoI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 756A060541
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
From:   Mukesh Ojha <mojha@codeaurora.org>
To:     john.stultz@linaro.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Cc:     gkohli@codeaurora.org, cpandya@codeaurora.org,
        neeraju@codeaurora.org, Mukesh Ojha <mojha@codeaurora.org>
Subject: [PATCH v4] time: Fix extra sleeptime injection when suspend fails
Date:   Tue, 17 Jul 2018 02:10:50 +0530
Message-Id: <1531773650-30424-1-git-send-email-mojha@codeaurora.org>
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

Fix this by handling the sleeptime_injected flag properly.

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

sleeptime injected again which was not required as the suspend failed)

Originally-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
---
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
 drivers/rtc/class.c       |  2 +-
 kernel/time/timekeeping.c | 29 ++++++++++++++++++++++-------
 2 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/rtc/class.c b/drivers/rtc/class.c
index d37588f..ee455cc 100644
--- a/drivers/rtc/class.c
+++ b/drivers/rtc/class.c
@@ -102,7 +102,7 @@ static int rtc_resume(struct device *dev)
 	struct timespec64	sleep_time;
 	int err;
 
-	if (timekeeping_rtc_skipresume())
+	if (!timekeeping_rtc_skipresume())
 		return 0;
 
 	rtc_hctosys_ret = -ENODEV;
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 4786df9..b25f771 100644
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
+	return suspend_timing_needed;
 }
 
 /**
@@ -1646,6 +1658,8 @@ void timekeeping_inject_sleeptime64(struct timespec64 *delta)
 	raw_spin_lock_irqsave(&timekeeper_lock, flags);
 	write_seqcount_begin(&tk_core.seq);
 
+	suspend_timing_needed = false;
+
 	timekeeping_forward_now(tk);
 
 	__timekeeping_inject_sleeptime(tk, delta);
@@ -1671,7 +1685,6 @@ void timekeeping_resume(void)
 	struct timespec64 ts_new, ts_delta;
 	u64 cycle_now;
 
-	sleeptime_injected = false;
 	read_persistent_clock64(&ts_new);
 
 	clockevents_resume();
@@ -1701,13 +1714,13 @@ void timekeeping_resume(void)
 					      tk->tkr_mono.mask);
 		nsec = mul_u64_u32_shr(cyc_delta, clock->mult, clock->shift);
 		ts_delta = ns_to_timespec64(nsec);
-		sleeptime_injected = true;
+		suspend_timing_needed = false;
 	} else if (timespec64_compare(&ts_new, &timekeeping_suspend_time) > 0) {
 		ts_delta = timespec64_sub(ts_new, timekeeping_suspend_time);
-		sleeptime_injected = true;
+		suspend_timing_needed = false;
 	}
 
-	if (sleeptime_injected)
+	if (!suspend_timing_needed)
 		__timekeeping_inject_sleeptime(tk, &ts_delta);
 
 	/* Re-base the last cycle value */
@@ -1743,6 +1756,8 @@ int timekeeping_suspend(void)
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

