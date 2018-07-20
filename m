Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C3ACECDFBD
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 00:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5CDB20833
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 00:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HJ5o6R1J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5CDB20833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731095AbeGTBYj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 21:24:39 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35927 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729215AbeGTBYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 21:24:38 -0400
Received: by mail-pg1-f195.google.com with SMTP id s7-v6so1799645pgv.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 17:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PNbGX0T0xK8VL6GyXFrquqlsWfRX2fm1MYtj5XoLQh4=;
        b=HJ5o6R1J6bwN6SAK7MGHRVvvrS8OTnyTj55kzK2nQhFtAYjaYowCIm9UkARksw9c5U
         y+z4VJJ2m89Zz6J0Ls+7vvkw176sU0RnHk/jw6Ic1QJP8nCyiqgQKG51HH+sReSaFcZJ
         sXRDRJBrSqK2aNJsCr2iwMrmKxEPMWhIGKw8w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PNbGX0T0xK8VL6GyXFrquqlsWfRX2fm1MYtj5XoLQh4=;
        b=Kgo8N92RrO63LtvqBC7SBNMSfoF6gHh3HC8s/gIi/SNchnj4cvE1Z4geJQz7t7tIpH
         JUI8NzhCLsk2qHk0llOx3cnKp345PXatNWHl/YKzf3HuZJPFMDArNEqmPxc+3kiw1JIz
         +WHngL2aJY43Kb15bAOWd9SOAaD+B8B+brlD6NTSzM7imh/ShkK/Qi/Zv4UpXyBzEfrL
         lsGlEah1LFjL5flGNA5Ij4Ao+Z0nwYrXCUtVx1zZY1nBvh6GrCTcJX8UUL7ExuKUSOr3
         xnHKxl6n0B5ehYlkPAGhEpJsYhcy+1IWPFJzEgJKLUtY9tIgKvEIq60FQ8WQSlxdJvlH
         rR4Q==
X-Gm-Message-State: AOUpUlHlLOSk3arjilnKWDvrobyKfLlGuCG3EFB+hOOvg6oldU+oKlgY
        VMe6uhQsBDpQjkdNb8JgWu5dpfBzPUE=
X-Google-Smtp-Source: AAOMgpetcfkCb0ih6izY6kE6h6XUJfPgfp3mdnQrYfw97mTQ6u0xozwz04GiUuV8CibFCpr4dWPJbw==
X-Received: by 2002:a62:9b57:: with SMTP id r84-v6mr11582962pfd.6.1532047138553;
        Thu, 19 Jul 2018 17:38:58 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:600:5100:4e72:b9ff:fe99:466a])
        by smtp.gmail.com with ESMTPSA id x5-v6sm383881pfh.67.2018.07.19.17.38.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Jul 2018 17:38:57 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     Ondrej Mosnacek <omosnace@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Miroslav Lichvar <mlichvar@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Prarit Bhargava <prarit@redhat.com>,
        Stephen Boyd <sboyd@kernel.org>,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH 3/5] timekeeping/ntp: Constify some function arguments
Date:   Thu, 19 Jul 2018 17:38:45 -0700
Message-Id: <1532047127-26699-4-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532047127-26699-1-git-send-email-john.stultz@linaro.org>
References: <1532047127-26699-1-git-send-email-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Mosnacek <omosnace@redhat.com>

Add 'const' to some function arguments and variables to make it easier
to read the code.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Miroslav Lichvar <mlichvar@redhat.com>
Cc: Richard Cochran <richardcochran@gmail.com>
Cc: Prarit Bhargava <prarit@redhat.com>
Cc: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
[jstultz: Also fixup pre-existing checkpatch warnings for
 prototype arguments with no variable name]
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 include/linux/timekeeping.h        |  2 +-
 kernel/time/ntp.c                  |  6 +++---
 kernel/time/ntp_internal.h         |  4 ++--
 kernel/time/timekeeping.c          | 29 +++++++++++++++--------------
 kernel/time/timekeeping_debug.c    |  2 +-
 kernel/time/timekeeping_internal.h |  2 +-
 6 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index 86bc202..edace6b 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -177,7 +177,7 @@ static inline time64_t ktime_get_clocktai_seconds(void)
 extern bool timekeeping_rtc_skipsuspend(void);
 extern bool timekeeping_rtc_skipresume(void);
 
-extern void timekeeping_inject_sleeptime64(struct timespec64 *delta);
+extern void timekeeping_inject_sleeptime64(const struct timespec64 *delta);
 
 /*
  * struct system_time_snapshot - simultaneous raw/real time capture with
diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index a627cae..c5e0cba 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -642,7 +642,7 @@ void ntp_notify_cmos_timer(void)
 /*
  * Propagate a new txc->status value into the NTP state:
  */
-static inline void process_adj_status(struct timex *txc)
+static inline void process_adj_status(const struct timex *txc)
 {
 	if ((time_status & STA_PLL) && !(txc->status & STA_PLL)) {
 		time_state = TIME_OK;
@@ -665,7 +665,7 @@ static inline void process_adj_status(struct timex *txc)
 }
 
 
-static inline void process_adjtimex_modes(struct timex *txc, s32 *time_tai)
+static inline void process_adjtimex_modes(const struct timex *txc, s32 *time_tai)
 {
 	if (txc->modes & ADJ_STATUS)
 		process_adj_status(txc);
@@ -716,7 +716,7 @@ static inline void process_adjtimex_modes(struct timex *txc, s32 *time_tai)
  * adjtimex mainly allows reading (and writing, if superuser) of
  * kernel time-keeping variables. used by xntpd.
  */
-int __do_adjtimex(struct timex *txc, struct timespec64 *ts, s32 *time_tai)
+int __do_adjtimex(struct timex *txc, const struct timespec64 *ts, s32 *time_tai)
 {
 	int result;
 
diff --git a/kernel/time/ntp_internal.h b/kernel/time/ntp_internal.h
index 909bd1f..c24b0e1 100644
--- a/kernel/time/ntp_internal.h
+++ b/kernel/time/ntp_internal.h
@@ -8,6 +8,6 @@ extern void ntp_clear(void);
 extern u64 ntp_tick_length(void);
 extern ktime_t ntp_get_next_leap(void);
 extern int second_overflow(time64_t secs);
-extern int __do_adjtimex(struct timex *, struct timespec64 *, s32 *);
-extern void __hardpps(const struct timespec64 *, const struct timespec64 *);
+extern int __do_adjtimex(struct timex *txc, const struct timespec64 *ts, s32 *time_tai);
+extern void __hardpps(const struct timespec64 *phase_ts, const struct timespec64 *raw_ts);
 #endif /* _LINUX_NTP_INTERNAL_H */
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index ad779c2..7033ac1 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -105,7 +105,7 @@ static inline void tk_normalize_xtime(struct timekeeper *tk)
 	}
 }
 
-static inline struct timespec64 tk_xtime(struct timekeeper *tk)
+static inline struct timespec64 tk_xtime(const struct timekeeper *tk)
 {
 	struct timespec64 ts;
 
@@ -162,7 +162,7 @@ static inline void tk_update_sleep_time(struct timekeeper *tk, ktime_t delta)
  * a read of the fast-timekeeper tkrs (which is protected by its own locking
  * and update logic).
  */
-static inline u64 tk_clock_read(struct tk_read_base *tkr)
+static inline u64 tk_clock_read(const struct tk_read_base *tkr)
 {
 	struct clocksource *clock = READ_ONCE(tkr->clock);
 
@@ -211,7 +211,7 @@ static void timekeeping_check_update(struct timekeeper *tk, u64 offset)
 	}
 }
 
-static inline u64 timekeeping_get_delta(struct tk_read_base *tkr)
+static inline u64 timekeeping_get_delta(const struct tk_read_base *tkr)
 {
 	struct timekeeper *tk = &tk_core.timekeeper;
 	u64 now, last, mask, max, delta;
@@ -255,7 +255,7 @@ static inline u64 timekeeping_get_delta(struct tk_read_base *tkr)
 static inline void timekeeping_check_update(struct timekeeper *tk, u64 offset)
 {
 }
-static inline u64 timekeeping_get_delta(struct tk_read_base *tkr)
+static inline u64 timekeeping_get_delta(const struct tk_read_base *tkr)
 {
 	u64 cycle_now, delta;
 
@@ -352,7 +352,7 @@ u32 (*arch_gettimeoffset)(void) = default_arch_gettimeoffset;
 static inline u32 arch_gettimeoffset(void) { return 0; }
 #endif
 
-static inline u64 timekeeping_delta_to_ns(struct tk_read_base *tkr, u64 delta)
+static inline u64 timekeeping_delta_to_ns(const struct tk_read_base *tkr, u64 delta)
 {
 	u64 nsec;
 
@@ -363,7 +363,7 @@ static inline u64 timekeeping_delta_to_ns(struct tk_read_base *tkr, u64 delta)
 	return nsec + arch_gettimeoffset();
 }
 
-static inline u64 timekeeping_get_ns(struct tk_read_base *tkr)
+static inline u64 timekeeping_get_ns(const struct tk_read_base *tkr)
 {
 	u64 delta;
 
@@ -371,7 +371,7 @@ static inline u64 timekeeping_get_ns(struct tk_read_base *tkr)
 	return timekeeping_delta_to_ns(tkr, delta);
 }
 
-static inline u64 timekeeping_cycles_to_ns(struct tk_read_base *tkr, u64 cycles)
+static inline u64 timekeeping_cycles_to_ns(const struct tk_read_base *tkr, u64 cycles)
 {
 	u64 delta;
 
@@ -394,7 +394,8 @@ static inline u64 timekeeping_cycles_to_ns(struct tk_read_base *tkr, u64 cycles)
  * slightly wrong timestamp (a few nanoseconds). See
  * @ktime_get_mono_fast_ns.
  */
-static void update_fast_timekeeper(struct tk_read_base *tkr, struct tk_fast *tkf)
+static void update_fast_timekeeper(const struct tk_read_base *tkr,
+				   struct tk_fast *tkf)
 {
 	struct tk_read_base *base = tkf->base;
 
@@ -549,10 +550,10 @@ EXPORT_SYMBOL_GPL(ktime_get_real_fast_ns);
  * number of cycles every time until timekeeping is resumed at which time the
  * proper readout base for the fast timekeeper will be restored automatically.
  */
-static void halt_fast_timekeeper(struct timekeeper *tk)
+static void halt_fast_timekeeper(const struct timekeeper *tk)
 {
 	static struct tk_read_base tkr_dummy;
-	struct tk_read_base *tkr = &tk->tkr_mono;
+	const struct tk_read_base *tkr = &tk->tkr_mono;
 
 	memcpy(&tkr_dummy, tkr, sizeof(tkr_dummy));
 	cycles_at_suspend = tk_clock_read(tkr);
@@ -1277,7 +1278,7 @@ EXPORT_SYMBOL(do_settimeofday64);
  *
  * Adds or subtracts an offset value from the current time.
  */
-static int timekeeping_inject_offset(struct timespec64 *ts)
+static int timekeeping_inject_offset(const struct timespec64 *ts)
 {
 	struct timekeeper *tk = &tk_core.timekeeper;
 	unsigned long flags;
@@ -1585,7 +1586,7 @@ static struct timespec64 timekeeping_suspend_time;
  * adds the sleep offset to the timekeeping variables.
  */
 static void __timekeeping_inject_sleeptime(struct timekeeper *tk,
-					   struct timespec64 *delta)
+					   const struct timespec64 *delta)
 {
 	if (!timespec64_valid_strict(delta)) {
 		printk_deferred(KERN_WARNING
@@ -1646,7 +1647,7 @@ bool timekeeping_rtc_skipsuspend(void)
  * This function should only be called by rtc_resume(), and allows
  * a suspend offset to be injected into the timekeeping values.
  */
-void timekeeping_inject_sleeptime64(struct timespec64 *delta)
+void timekeeping_inject_sleeptime64(const struct timespec64 *delta)
 {
 	struct timekeeper *tk = &tk_core.timekeeper;
 	unsigned long flags;
@@ -2240,7 +2241,7 @@ ktime_t ktime_get_update_offsets_now(unsigned int *cwsseq, ktime_t *offs_real,
 /**
  * timekeeping_validate_timex - Ensures the timex is ok for use in do_adjtimex
  */
-static int timekeeping_validate_timex(struct timex *txc)
+static int timekeeping_validate_timex(const struct timex *txc)
 {
 	if (txc->modes & ADJ_ADJTIME) {
 		/* singleshot must not be used with any other mode bits */
diff --git a/kernel/time/timekeeping_debug.c b/kernel/time/timekeeping_debug.c
index 0754cad..238e4be 100644
--- a/kernel/time/timekeeping_debug.c
+++ b/kernel/time/timekeeping_debug.c
@@ -70,7 +70,7 @@ static int __init tk_debug_sleep_time_init(void)
 }
 late_initcall(tk_debug_sleep_time_init);
 
-void tk_debug_account_sleep_time(struct timespec64 *t)
+void tk_debug_account_sleep_time(const struct timespec64 *t)
 {
 	/* Cap bin index so we don't overflow the array */
 	int bin = min(fls(t->tv_sec), NUM_BINS-1);
diff --git a/kernel/time/timekeeping_internal.h b/kernel/time/timekeeping_internal.h
index cf5c082..bcbb52d 100644
--- a/kernel/time/timekeeping_internal.h
+++ b/kernel/time/timekeeping_internal.h
@@ -8,7 +8,7 @@
 #include <linux/time.h>
 
 #ifdef CONFIG_DEBUG_FS
-extern void tk_debug_account_sleep_time(struct timespec64 *t);
+extern void tk_debug_account_sleep_time(const struct timespec64 *t);
 #else
 #define tk_debug_account_sleep_time(x)
 #endif
-- 
2.7.4

