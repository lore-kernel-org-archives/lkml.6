Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBBBECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 07:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F15320877
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 07:56:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kkQfPye5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F15320877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729374AbeGQI1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 04:27:18 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34429 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728304AbeGQI1S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 04:27:18 -0400
Received: by mail-pg1-f194.google.com with SMTP id y5-v6so105899pgv.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jul 2018 00:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=E0mnadssdjVjf6nRNuw6JDCxZa6FDV2U8DYIRl4P7Ok=;
        b=kkQfPye5s61MQfYHMs0legbXaFczqUjNpXhfDVfhj4nvv25OXUxMzCkdAlx2Odoc4A
         YFLQ5FFjz6rixyFwgh+vQDj7Bq66TU0mFgve0hv2R3l6lLeFnp202nWlS0zgw1kzmd0H
         n9LP5G31HcNvoQS6HChAn60DIgRY/NYFFpVlg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=E0mnadssdjVjf6nRNuw6JDCxZa6FDV2U8DYIRl4P7Ok=;
        b=e+zC2UqOwY1sb2qD6Xjou0ztrdRQo5dT3+FiRDRlx8EiDeNv7FmC262499926BcxCJ
         fZV3mZEh6rQk+q+qugaWbSC7BhUgTWdna2f7gRIFWjsMd5IyMxGTBSXTbzXnEsxR8iYi
         V8dlgd9yPgcTtekHJ9v9HxNMK2nJ8XYn2Bgw8THk95xiu5gGHhgv+IdFgc+C5qI30g05
         fsmy7MJ23MBa0Syat0WiL2xmMSUzVg42ZQgxW+wbmiyyvMbsL3UMuvoozfx0FgvC1k7c
         8xMERnRS00s4QbIQHgPm/DZsZhTOwn3V0QC9vhVsLJT9BfnvCxtqrvRBaSQi9hwboWm5
         ERBA==
X-Gm-Message-State: AOUpUlGVZnBzR9icFQPD7Opom9P+vHxU4BP7hTKwLhb9s5nz9nwDk2gk
        8hC4Uq5jF++o9Uh7Xyw/ikmkgg==
X-Google-Smtp-Source: AAOMgpdh/7nEWBL2whGiIW8Vns0CkbfVJyaMTf3k35WjA6qKuC3Q+5UIZqpWclPsxWxITZOJwNolQw==
X-Received: by 2002:a62:8a4f:: with SMTP id y76-v6mr589561pfd.233.1531814159144;
        Tue, 17 Jul 2018 00:55:59 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id j75-v6sm1462012pfj.102.2018.07.17.00.55.56
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Jul 2018 00:55:58 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     tglx@linutronix.de, john.stultz@linaro.org, sboyd@kernel.org,
        arnd@arndb.de, broonie@kernel.org, daniel.lezcano@linaro.org
Cc:     linux-kernel@vger.kernel.org, baolin.wang@linaro.org
Subject: [PATCH 1/2] time: Introduce one suspend clocksource to compensate the suspend time
Date:   Tue, 17 Jul 2018 15:55:16 +0800
Message-Id: <c233469f487d9e187de3fdaf79db4e1a7ca7486d.1531812082.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some hardware with multiple clocksources, we have coarse grained
clocksources that support the CLOCK_SOURCE_SUSPEND_NONSTOP flag, but
which are less than ideal for timekeeping whereas other clocksources
can be better candidates but halt on suspend.

Currently, the timekeeping core only supports timing suspend using
CLOCK_SOURCE_SUSPEND_NONSTOP clocksources if that clocksource is the
current clocksource for timekeeping.

As a result, some architectures try to implement read_persistent_clock64()
using those non-stop clocksources, but isn't really ideal, which will
introduce more duplicate code. To fix this, provide logic to allow a
registered SUSPEND_NONSTOP clocksource, which isn't the current
clocksource, to be used to calculate the suspend time.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
Changes from RFC v1:
 - Improve commit message.
 - Remove the WARN_ON_ONCE().
 - Fix some coding style issues.
 - Do not force to select a replacement suspend clocksource.
---
 include/linux/clocksource.h |    3 +
 kernel/time/clocksource.c   |  149 +++++++++++++++++++++++++++++++++++++++++++
 kernel/time/timekeeping.c   |   22 ++++---
 3 files changed, 166 insertions(+), 8 deletions(-)

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
index f89a78e..f74fb00 100644
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
@@ -447,6 +451,140 @@ static inline void clocksource_watchdog_unlock(unsigned long *flags) { }
 
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
+	/*
+	 * The nonstop clocksource can be selected as the suspend clocksource to
+	 * calculate the suspend time, so it should not supply suspend/resume
+	 * interfaces to suspend the nonstop clocksource when system suspends.
+	 */
+	if (cs->suspend || cs->resume) {
+		pr_warn("Nonstop clocksource %s should not supply suspend/resume interfaces\n",
+			cs->name);
+	}
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
+	    suspend_clocksource->enable(suspend_clocksource)) {
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
+ * This function will calculate the suspend time from suspend timer.
+ *
+ * Returns nanoseconds since suspend started, 0 if no usable suspend clocksource.
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
@@ -792,6 +930,7 @@ int __clocksource_register_scale(struct clocksource *cs, u32 scale, u32 freq)
 
 	clocksource_select();
 	clocksource_select_watchdog(false);
+	__clocksource_suspend_select(cs);
 	mutex_unlock(&clocksource_mutex);
 	return 0;
 }
@@ -820,6 +959,7 @@ void clocksource_change_rating(struct clocksource *cs, int rating)
 
 	clocksource_select();
 	clocksource_select_watchdog(false);
+	clocksource_suspend_select(false);
 	mutex_unlock(&clocksource_mutex);
 }
 EXPORT_SYMBOL(clocksource_change_rating);
@@ -845,6 +985,15 @@ static int clocksource_unbind(struct clocksource *cs)
 			return -EBUSY;
 	}
 
+	if (clocksource_is_suspend(cs)) {
+		/*
+		 * Select and try to install a replacement suspend clocksource.
+		 * If no replacement suspend clocksource, we will just let the
+		 * clocksource go and have no suspend clocksource.
+		 */
+		clocksource_suspend_select(true);
+	}
+
 	clocksource_watchdog_lock(&flags);
 	clocksource_dequeue_watchdog(cs);
 	list_del_init(&cs->list);
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

