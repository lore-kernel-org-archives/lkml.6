Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C5EC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4444A20883
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 08:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LNKS5CV3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4444A20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbeGLIxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 04:53:37 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:40558 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeGLIxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 04:53:37 -0400
Received: by mail-pf0-f193.google.com with SMTP id e13-v6so6817372pff.7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 01:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=zFaCie2Frja+zTzIavMJRsXKeSi3+WJbCOfjDafXsco=;
        b=LNKS5CV3qjZR2PpC9V5q7CuAC9XGSPUbbUqsYkl9sZfG9T58NGRuq75quj/+ZfowBY
         7wYu0SuT6WiZd3pe/8fTpIGbB9AMHLTyFYg/q/+qQrGaWAE6/gDFxA0xB30XMT6AMKMb
         EajSjT6xtw77nImHtaGF9OlZcAAbNB20Gq6Hg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zFaCie2Frja+zTzIavMJRsXKeSi3+WJbCOfjDafXsco=;
        b=Vhk6pYSHxBJ5yvpq8BvIeZeL3ywPZgwfGqNdjN0O3D3KGTL4GpTpjphk7NvxbC978u
         O23m9tukE+d3xkZcnAEylqw4PKGfcCZqWIYnSYGVKOh+eqNC5pUZuS7qQSjqCNJag5Zp
         v897/o/Zv2FrqpVkqgFmw841C21aYsACmW5SnutjzgnMvg9wHz2B8H0nJ6gbkfigRTaJ
         oM58MFT00ZytowMtEo1NmaCSw38F2A1zI0hUQag1Z6Cr+EUFBn0BEZUlY+JjSu5qlWbM
         AzWh7Epw30FzkepuFWlvUfQbAM5BzN6x1bEds+zw9MPq/cjcZtN1CIvS0sAKJP7H6d5Z
         1qiQ==
X-Gm-Message-State: AOUpUlHgMEhxNg8V63aFSufmj0HuFT/IF0wMaO2IaTc9hRy/GO+yZbn+
        7oG85Tj4eR9Wl1QTbf/oSCTp2w==
X-Google-Smtp-Source: AAOMgpfDpHt6nT3ZNkiIWTy9OR9/tRiRLCLPb74MJYDULA9GI4MfE5rU7zwZ+5RJUvmnd4W9nGvkQw==
X-Received: by 2002:a65:6688:: with SMTP id b8-v6mr1306345pgw.24.1531385100539;
        Thu, 12 Jul 2018 01:45:00 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id v17-v6sm27184314pfn.177.2018.07.12.01.44.57
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Jul 2018 01:45:00 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     tglx@linutronix.de, john.stultz@linaro.org, sboyd@kernel.org,
        arnd@arndb.de, broonie@kernel.org, daniel.lezcano@linaro.org
Cc:     linux-kernel@vger.kernel.org, baolin.wang@linaro.org
Subject: [RFC PATCH 1/2] time: Introduce one suspend clocksource to compensate the suspend time
Date:   Thu, 12 Jul 2018 16:44:12 +0800
Message-Id: <4aa9a65166f7e10984bfcff59e72d86e37c369a1.1531384486.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some hardware with multiple clocksources, we have course grained
clocksources that support the CLOCK_SOURCE_SUSPEND_NONSTOP flag, but
which are less ideal for timekeeping then other clocksources which
halt in suspend.

Currently, the timekeeping core only supports timing suspend using
CLOCK_SOURCE_SUSPEND_NONSTOP clocksources if that clocksource is the
current clocksource for timekeeping.

As a result, some architectures try to implement read_persisitent_clock64()
using those non-stop clocksources, but isn't really ideal. Thus this
patch provides logic to allow a registered SUSPEND_NONSTOP clocksource,
which isn't the current clocksource, to be used to calculate the suspend
time.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 include/linux/clocksource.h |    3 +
 kernel/time/clocksource.c   |  152 +++++++++++++++++++++++++++++++++++++++++++
 kernel/time/timekeeping.c   |   22 ++++---
 3 files changed, 169 insertions(+), 8 deletions(-)

diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index 7dff196..3089189 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -194,6 +194,9 @@ static inline s64 clocksource_cyc2ns(u64 cycles, u32 mult, u32 shift)
 extern void clocksource_resume(void);
 extern struct clocksource * __init clocksource_default_clock(void);
 extern void clocksource_mark_unstable(struct clocksource *cs);
+extern void
+clocksource_start_suspend_timing(struct clocksource *cs, u64 start_cycles);
+extern u64 clocksource_stop_suspend_timing(struct clocksource *cs, u64 now);
 
 extern u64
 clocks_calc_max_nsecs(u32 mult, u32 shift, u32 maxadj, u64 mask, u64 *max_cycles);
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index f89a78e..7778eaa 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -94,6 +94,8 @@
 /*[Clocksource internal variables]---------
  * curr_clocksource:
  *	currently selected clocksource.
+ * suspend_clocksource:
+ *	used to calculate the suspend time.
  * clocksource_list:
  *	linked list with the registered clocksources
  * clocksource_mutex:
@@ -102,10 +104,12 @@
  *	Name of the user-specified clocksource.
  */
 static struct clocksource *curr_clocksource;
+static struct clocksource *suspend_clocksource;
 static LIST_HEAD(clocksource_list);
 static DEFINE_MUTEX(clocksource_mutex);
 static char override_name[CS_NAME_LEN];
 static int finished_booting;
+static u64 suspend_start;
 
 #ifdef CONFIG_CLOCKSOURCE_WATCHDOG
 static void clocksource_watchdog_work(struct work_struct *work);
@@ -447,6 +451,133 @@ static inline void clocksource_watchdog_unlock(unsigned long *flags) { }
 
 #endif /* CONFIG_CLOCKSOURCE_WATCHDOG */
 
+static bool clocksource_is_suspend(struct clocksource *cs)
+{
+	return cs == suspend_clocksource;
+}
+
+static void __clocksource_suspend_select(struct clocksource *cs)
+{
+	/*
+	 * Skip the clocksource which will be stopped in suspend state.
+	 */
+	if (!(cs->flags & CLOCK_SOURCE_SUSPEND_NONSTOP))
+		return;
+
+	/* Pick the best rating. */
+	if (!suspend_clocksource || cs->rating > suspend_clocksource->rating)
+		suspend_clocksource = cs;
+}
+
+/**
+ * clocksource_suspend_select - Select the best clocksource for suspend timing
+ * @fallback:	if select a fallback clocksource
+ */
+static void clocksource_suspend_select(bool fallback)
+{
+	struct clocksource *cs, *old_suspend;
+
+	old_suspend = suspend_clocksource;
+	if (fallback)
+		suspend_clocksource = NULL;
+
+	list_for_each_entry(cs, &clocksource_list, list) {
+		/* Skip current if we were requested for a fallback. */
+		if (fallback && cs == old_suspend)
+			continue;
+
+		__clocksource_suspend_select(cs);
+	}
+
+	/* If we failed to find a fallback restore the old one. */
+	if (!suspend_clocksource)
+		suspend_clocksource = old_suspend;
+}
+
+/**
+ * clocksource_start_suspend_timing - Start measuring the suspend timing
+ * @cs:			current clocksource from timekeeping
+ * @start_cycles:	current cycles from timekeeping
+ *
+ * This function will save the start cycle values of suspend timer to calculate
+ * the suspend time when resuming system.
+ *
+ * This function is called late in the suspend process from timekeeping_suspend(),
+ * that means processes are freezed, non-boot cpus and interrupts are disabled
+ * now. It is therefore possible to start the suspend timer without taking the
+ * clocksource mutex.
+ */
+void clocksource_start_suspend_timing(struct clocksource *cs, u64 start_cycles)
+{
+	if (!suspend_clocksource)
+		return;
+
+	/*
+	 * If current clocksource is the suspend timer, we should use the
+	 * tkr_mono.cycle_last value as suspend_start to avoid same reading
+	 * from suspend timer.
+	 */
+	if (clocksource_is_suspend(cs)) {
+		suspend_start = start_cycles;
+		return;
+	}
+
+	if (suspend_clocksource->enable &&
+	    WARN_ON_ONCE(suspend_clocksource->enable(suspend_clocksource))) {
+		pr_warn_once("Failed to enable the non-suspend-able clocksource.\n");
+		return;
+	}
+
+	suspend_start = suspend_clocksource->read(suspend_clocksource);
+}
+
+/**
+ * clocksource_stop_suspend_timing - Stop measuring the suspend timing
+ * @cs:		current clocksource from timekeeping
+ * @cycle_now:	current cycles from timekeeping
+ *
+ * This function will calculate the suspend time from suspend timer, and return
+ * nanoseconds since suspend started or 0 if no usable clocksource.
+ *
+ * This function is called early in the resume process from timekeeping_resume(),
+ * that means there is only one cpu, no processes are running and the interrupts
+ * are disabled. It is therefore possible to stop the suspend timer without
+ * taking the clocksource mutex.
+ */
+u64 clocksource_stop_suspend_timing(struct clocksource *cs, u64 cycle_now)
+{
+	u64 now, delta, nsec = 0;
+
+	if (!suspend_clocksource)
+		return 0;
+
+	/*
+	 * If current clocksource is the suspend timer, we should use the
+	 * tkr_mono.cycle_last value from timekeeping as current cycle to
+	 * avoid same reading from suspend timer.
+	 */
+	if (clocksource_is_suspend(cs))
+		now = cycle_now;
+	else
+		now = suspend_clocksource->read(suspend_clocksource);
+
+	if (now > suspend_start) {
+		delta = clocksource_delta(now, suspend_start,
+					  suspend_clocksource->mask);
+		nsec = mul_u64_u32_shr(delta, suspend_clocksource->mult,
+				       suspend_clocksource->shift);
+	}
+
+	/*
+	 * Disable the suspend timer to save power if current clocksource is
+	 * not the suspend timer.
+	 */
+	if (!clocksource_is_suspend(cs) && suspend_clocksource->disable)
+		suspend_clocksource->disable(suspend_clocksource);
+
+	return nsec;
+}
+
 /**
  * clocksource_suspend - suspend the clocksource(s)
  */
@@ -779,6 +910,16 @@ int __clocksource_register_scale(struct clocksource *cs, u32 scale, u32 freq)
 {
 	unsigned long flags;
 
+	/*
+	 * The nonstop clocksource can be selected as the suspend clocksource to
+	 * calculate the suspend time, so it should not supply suspend/resume
+	 * interfaces to suspend the nonstop clocksource when system suspends.
+	 */
+	if ((cs->flags & CLOCK_SOURCE_SUSPEND_NONSTOP) &&
+	    (cs->suspend || cs->resume))
+		pr_warn("Nonstop clocksource %s should not supply suspend/resume interfaces\n",
+			cs->name);
+
 	/* Initialize mult/shift and max_idle_ns */
 	__clocksource_update_freq_scale(cs, scale, freq);
 
@@ -792,6 +933,7 @@ int __clocksource_register_scale(struct clocksource *cs, u32 scale, u32 freq)
 
 	clocksource_select();
 	clocksource_select_watchdog(false);
+	__clocksource_suspend_select(cs);
 	mutex_unlock(&clocksource_mutex);
 	return 0;
 }
@@ -820,6 +962,7 @@ void clocksource_change_rating(struct clocksource *cs, int rating)
 
 	clocksource_select();
 	clocksource_select_watchdog(false);
+	clocksource_suspend_select(false);
 	mutex_unlock(&clocksource_mutex);
 }
 EXPORT_SYMBOL(clocksource_change_rating);
@@ -838,6 +981,15 @@ static int clocksource_unbind(struct clocksource *cs)
 			return -EBUSY;
 	}
 
+	if (clocksource_is_suspend(cs)) {
+		/*
+		 * Select and try to install a replacement suspend clocksource.
+		 */
+		clocksource_suspend_select(true);
+		if (clocksource_is_suspend(cs))
+			return -EBUSY;
+	}
+
 	if (cs == curr_clocksource) {
 		/* Select and try to install a replacement clock source */
 		clocksource_select_fallback();
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 4786df9..d80dba3 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1669,7 +1669,7 @@ void timekeeping_resume(void)
 	struct clocksource *clock = tk->tkr_mono.clock;
 	unsigned long flags;
 	struct timespec64 ts_new, ts_delta;
-	u64 cycle_now;
+	u64 cycle_now, nsec;
 
 	sleeptime_injected = false;
 	read_persistent_clock64(&ts_new);
@@ -1693,13 +1693,8 @@ void timekeeping_resume(void)
 	 * usable source. The rtc part is handled separately in rtc core code.
 	 */
 	cycle_now = tk_clock_read(&tk->tkr_mono);
-	if ((clock->flags & CLOCK_SOURCE_SUSPEND_NONSTOP) &&
-		cycle_now > tk->tkr_mono.cycle_last) {
-		u64 nsec, cyc_delta;
-
-		cyc_delta = clocksource_delta(cycle_now, tk->tkr_mono.cycle_last,
-					      tk->tkr_mono.mask);
-		nsec = mul_u64_u32_shr(cyc_delta, clock->mult, clock->shift);
+	nsec = clocksource_stop_suspend_timing(clock, cycle_now);
+	if (nsec > 0) {
 		ts_delta = ns_to_timespec64(nsec);
 		sleeptime_injected = true;
 	} else if (timespec64_compare(&ts_new, &timekeeping_suspend_time) > 0) {
@@ -1732,6 +1727,8 @@ int timekeeping_suspend(void)
 	unsigned long flags;
 	struct timespec64		delta, delta_delta;
 	static struct timespec64	old_delta;
+	struct clocksource *curr_clock;
+	u64 cycle_now;
 
 	read_persistent_clock64(&timekeeping_suspend_time);
 
@@ -1748,6 +1745,15 @@ int timekeeping_suspend(void)
 	timekeeping_forward_now(tk);
 	timekeeping_suspended = 1;
 
+	/*
+	 * Since we've called forward_now, cycle_last stores the value
+	 * just read from the current clocksource. Save this to potentially
+	 * use in suspend timing.
+	 */
+	curr_clock = tk->tkr_mono.clock;
+	cycle_now = tk->tkr_mono.cycle_last;
+	clocksource_start_suspend_timing(curr_clock, cycle_now);
+
 	if (persistent_clock_exists) {
 		/*
 		 * To avoid drift caused by repeated suspend/resumes,
-- 
1.7.9.5

