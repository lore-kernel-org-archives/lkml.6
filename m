Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B7DAECDFBE
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 00:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4710320652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 00:39:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kZa21Kgl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4710320652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731178AbeGTBYk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 21:24:40 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:41037 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731031AbeGTBYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 21:24:39 -0400
Received: by mail-pg1-f193.google.com with SMTP id z8-v6so5226955pgu.8
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 17:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cl8QC7cI0N14M5eI441ZKx5bQCWuSElbitp4+Wv2+PI=;
        b=kZa21KglaWxEqM0xlsSMhBsjKtDHjIsjIc/dubcPVir2DW9U8llDy+eAreRtz+VPh+
         cWqO76umVmOZFcOntsn9yeFCXsieBUOlICtJmqyK4xT1B3x8JL9CdZ1wZMtvebl3ocmh
         nno1CBnc/UsIQhPmKYV654C4AWkvueafBp0mA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cl8QC7cI0N14M5eI441ZKx5bQCWuSElbitp4+Wv2+PI=;
        b=nUdDoN0sTwsm7sTS9RzPEv2j6s8VekjX9PfzB61mSlWSCI4Gx/7j0emokli7dNuWbn
         7nGZ/ciTdu7p1EnRg30K3eujer443gS2m/DADTbzW/AEHBVHiX5xerjuMGMejQ2noPMl
         l9VFZS76reZ3xEINZFE1tpqrvsCu7Y6PhOLjK0xQtg0ovzT2U+5jI4h4oWUdyxLT4vr6
         nRYrZY7MyNw19ex+29iIh3nf3tAUlDnJECmsgWJToL7vu3ce9/hCziwBRD6sm7x4FL6/
         MVRbbxuYj7tm3Oq2Uu/LV+AyeUcZDnUDsDHXLhvJZaiiCrVI4Y2AbuoQGWs78//kmkJv
         vwhA==
X-Gm-Message-State: AOUpUlG8+v8C0eTL8rAMKut666ibaHHw3bkqlP7yX0QosA9gseVGYPt2
        RBbDrVrE2Hk8Cic8/nOVMLc95mDWRnQ=
X-Google-Smtp-Source: AAOMgpdZMCHoelfAac2uKmtq5tf76cMfbWlEC4ja5MThwTlFypp2jexX82UyVQu999XmIONGF03Dqw==
X-Received: by 2002:a62:864a:: with SMTP id x71-v6mr11744256pfd.252.1532047140290;
        Thu, 19 Jul 2018 17:39:00 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:600:5100:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id x5-v6sm383881pfh.67.2018.07.19.17.38.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Jul 2018 17:38:59 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Mukesh Ojha <mojha@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Miroslav Lichvar <mlichvar@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Prarit Bhargava <prarit@redhat.com>,
        Stephen Boyd <sboyd@kernel.org>,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH 4/5] time: Fix extra sleeptime injection when suspend fails
Date:   Thu, 19 Jul 2018 17:38:46 -0700
Message-Id: <1532047127-26699-5-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532047127-26699-1-git-send-email-john.stultz@linaro.org>
References: <1532047127-26699-1-git-send-email-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mukesh Ojha <mojha@codeaurora.org>

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

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Miroslav Lichvar <mlichvar@redhat.com>
Cc: Richard Cochran <richardcochran@gmail.com>
Cc: Prarit Bhargava <prarit@redhat.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Originally-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 kernel/time/timekeeping.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 7033ac1..19414b1 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1519,8 +1519,20 @@ void __weak read_boot_clock64(struct timespec64 *ts)
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
@@ -1619,7 +1631,7 @@ static void __timekeeping_inject_sleeptime(struct timekeeper *tk,
  */
 bool timekeeping_rtc_skipresume(void)
 {
-	return sleeptime_injected;
+	return !suspend_timing_needed;
 }
 
 /**
@@ -1655,6 +1667,8 @@ void timekeeping_inject_sleeptime64(const struct timespec64 *delta)
 	raw_spin_lock_irqsave(&timekeeper_lock, flags);
 	write_seqcount_begin(&tk_core.seq);
 
+	suspend_timing_needed = false;
+
 	timekeeping_forward_now(tk);
 
 	__timekeeping_inject_sleeptime(tk, delta);
@@ -1679,8 +1693,8 @@ void timekeeping_resume(void)
 	unsigned long flags;
 	struct timespec64 ts_new, ts_delta;
 	u64 cycle_now;
+	bool inject_sleeptime = false;
 
-	sleeptime_injected = false;
 	read_persistent_clock64(&ts_new);
 
 	clockevents_resume();
@@ -1710,14 +1724,16 @@ void timekeeping_resume(void)
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
@@ -1752,6 +1768,8 @@ int timekeeping_suspend(void)
 	if (timekeeping_suspend_time.tv_sec || timekeeping_suspend_time.tv_nsec)
 		persistent_clock_exists = true;
 
+	suspend_timing_needed = true;
+
 	raw_spin_lock_irqsave(&timekeeper_lock, flags);
 	write_seqcount_begin(&tk_core.seq);
 	timekeeping_forward_now(tk);
-- 
2.7.4

