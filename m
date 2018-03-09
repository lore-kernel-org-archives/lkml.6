Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932553AbeCISnF (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 13:43:05 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:40667 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932165AbeCISnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 13:43:00 -0500
X-Google-Smtp-Source: AG47ELu9kPk5jXlIQGynHyshIWmoOVhEXSz7+F0WPAcC1kdqKsStXL8FfNUA36eauDuuCKd0Tk7WVw==
From: John Stultz <john.stultz@linaro.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Miroslav Lichvar <mlichvar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Prarit Bhargava <prarit@redhat.com>,
        Stephen Boyd <stephen.boyd@linaro.org>,
        John Stultz <john.stultz@linaro.org>
Subject: [PATCH 2/4] timekeeping: Determine multiplier directly from NTP tick length
Date: Fri,  9 Mar 2018 10:42:48 -0800
Message-Id: <1520620971-9567-3-git-send-email-john.stultz@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520620971-9567-1-git-send-email-john.stultz@linaro.org>
References: <1520620971-9567-1-git-send-email-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miroslav Lichvar <mlichvar@redhat.com>

When the length of the NTP tick changes significantly, e.g. when an
NTP/PTP application is correcting the initial offset of the clock, a
large value may accumulate in the NTP error before the multiplier
converges to the correct value. It may then take a very long time (hours
or even days) before the error is corrected. This causes the clock to
have an unstable frequency offset, which has a negative impact on the
stability of synchronization with precise time sources (e.g. NTP/PTP
using hardware timestamping or the PTP KVM clock).

Use division to determine the correct multiplier directly from the NTP
tick length and replace the iterative approach. This removes the last
major source of the NTP error. The only remaining source is now limited
resolution of the multiplier, which is corrected by adding 1 to the
multiplier when the system clock is behind the NTP time.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Miroslav Lichvar <mlichvar@redhat.com>
Cc: Richard Cochran <richardcochran@gmail.com>
Cc: Prarit Bhargava <prarit@redhat.com>
Cc: Stephen Boyd <stephen.boyd@linaro.org>
Signed-off-by: Miroslav Lichvar <mlichvar@redhat.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 include/linux/timekeeper_internal.h |   2 +
 kernel/time/timekeeping.c           | 138 ++++++++++++------------------------
 2 files changed, 49 insertions(+), 91 deletions(-)

diff --git a/include/linux/timekeeper_internal.h b/include/linux/timekeeper_internal.h
index d315c3d..7acb953 100644
--- a/include/linux/timekeeper_internal.h
+++ b/include/linux/timekeeper_internal.h
@@ -117,6 +117,8 @@ struct timekeeper {
 	s64			ntp_error;
 	u32			ntp_error_shift;
 	u32			ntp_err_mult;
+	/* Flag used to avoid updating NTP twice with same second */
+	u32			skip_second_overflow;
 #ifdef CONFIG_DEBUG_TIMEKEEPING
 	long			last_warning;
 	/*
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index c1a0ac1..e1176012 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -332,6 +332,7 @@ static void tk_setup_internals(struct timekeeper *tk, struct clocksource *clock)
 	tk->tkr_mono.mult = clock->mult;
 	tk->tkr_raw.mult = clock->mult;
 	tk->ntp_err_mult = 0;
+	tk->skip_second_overflow = 0;
 }
 
 /* Timekeeper helper functions. */
@@ -1799,20 +1800,19 @@ device_initcall(timekeeping_init_ops);
  */
 static __always_inline void timekeeping_apply_adjustment(struct timekeeper *tk,
 							 s64 offset,
-							 bool negative,
-							 int adj_scale)
+							 s32 mult_adj)
 {
 	s64 interval = tk->cycle_interval;
-	s32 mult_adj = 1;
 
-	if (negative) {
-		mult_adj = -mult_adj;
+	if (mult_adj == 0) {
+		return;
+	} else if (mult_adj == -1) {
 		interval = -interval;
-		offset  = -offset;
+		offset = -offset;
+	} else if (mult_adj != 1) {
+		interval *= mult_adj;
+		offset *= mult_adj;
 	}
-	mult_adj <<= adj_scale;
-	interval <<= adj_scale;
-	offset <<= adj_scale;
 
 	/*
 	 * So the following can be confusing.
@@ -1873,85 +1873,35 @@ static __always_inline void timekeeping_apply_adjustment(struct timekeeper *tk,
 }
 
 /*
- * Calculate the multiplier adjustment needed to match the frequency
- * specified by NTP
+ * Adjust the timekeeper's multiplier to the correct frequency
+ * and also to reduce the accumulated error value.
  */
-static __always_inline void timekeeping_freqadjust(struct timekeeper *tk,
-							s64 offset)
+static void timekeeping_adjust(struct timekeeper *tk, s64 offset)
 {
-	s64 interval = tk->cycle_interval;
-	s64 xinterval = tk->xtime_interval;
-	u32 base = tk->tkr_mono.clock->mult;
-	u32 max = tk->tkr_mono.clock->maxadj;
-	u32 cur_adj = tk->tkr_mono.mult;
-	s64 tick_error;
-	bool negative;
-	u32 adj_scale;
-
-	/* Remove any current error adj from freq calculation */
-	if (tk->ntp_err_mult)
-		xinterval -= tk->cycle_interval;
-
-	tk->ntp_tick = ntp_tick_length();
-
-	/* Calculate current error per tick */
-	tick_error = ntp_tick_length() >> tk->ntp_error_shift;
-	tick_error -= (xinterval + tk->xtime_remainder);
-
-	/* Don't worry about correcting it if its small */
-	if (likely((tick_error >= 0) && (tick_error <= interval)))
-		return;
-
-	/* preserve the direction of correction */
-	negative = (tick_error < 0);
+	u32 mult;
 
-	/* If any adjustment would pass the max, just return */
-	if (negative && (cur_adj - 1) <= (base - max))
-		return;
-	if (!negative && (cur_adj + 1) >= (base + max))
-		return;
 	/*
-	 * Sort out the magnitude of the correction, but
-	 * avoid making so large a correction that we go
-	 * over the max adjustment.
+	 * Determine the multiplier from the current NTP tick length.
+	 * Avoid expensive division when the tick length doesn't change.
 	 */
-	adj_scale = 0;
-	tick_error = abs(tick_error);
-	while (tick_error > interval) {
-		u32 adj = 1 << (adj_scale + 1);
-
-		/* Check if adjustment gets us within 1 unit from the max */
-		if (negative && (cur_adj - adj) <= (base - max))
-			break;
-		if (!negative && (cur_adj + adj) >= (base + max))
-			break;
-
-		adj_scale++;
-		tick_error >>= 1;
+	if (likely(tk->ntp_tick == ntp_tick_length())) {
+		mult = tk->tkr_mono.mult - tk->ntp_err_mult;
+	} else {
+		tk->ntp_tick = ntp_tick_length();
+		mult = div64_u64((tk->ntp_tick >> tk->ntp_error_shift) -
+				 tk->xtime_remainder, tk->cycle_interval);
 	}
 
-	/* scale the corrections */
-	timekeeping_apply_adjustment(tk, offset, negative, adj_scale);
-}
+	/*
+	 * If the clock is behind the NTP time, increase the multiplier by 1
+	 * to catch up with it. If it's ahead and there was a remainder in the
+	 * tick division, the clock will slow down. Otherwise it will stay
+	 * ahead until the tick length changes to a non-divisible value.
+	 */
+	tk->ntp_err_mult = tk->ntp_error > 0 ? 1 : 0;
+	mult += tk->ntp_err_mult;
 
-/*
- * Adjust the timekeeper's multiplier to the correct frequency
- * and also to reduce the accumulated error value.
- */
-static void timekeeping_adjust(struct timekeeper *tk, s64 offset)
-{
-	/* Correct for the current frequency error */
-	timekeeping_freqadjust(tk, offset);
-
-	/* Next make a small adjustment to fix any cumulative error */
-	if (!tk->ntp_err_mult && (tk->ntp_error > 0)) {
-		tk->ntp_err_mult = 1;
-		timekeeping_apply_adjustment(tk, offset, 0, 0);
-	} else if (tk->ntp_err_mult && (tk->ntp_error <= 0)) {
-		/* Undo any existing error adjustment */
-		timekeeping_apply_adjustment(tk, offset, 1, 0);
-		tk->ntp_err_mult = 0;
-	}
+	timekeeping_apply_adjustment(tk, offset, mult - tk->tkr_mono.mult);
 
 	if (unlikely(tk->tkr_mono.clock->maxadj &&
 		(abs(tk->tkr_mono.mult - tk->tkr_mono.clock->mult)
@@ -1968,18 +1918,15 @@ static void timekeeping_adjust(struct timekeeper *tk, s64 offset)
 	 * in the code above, its possible the required corrective factor to
 	 * xtime_nsec could cause it to underflow.
 	 *
-	 * Now, since we already accumulated the second, cannot simply roll
-	 * the accumulated second back, since the NTP subsystem has been
-	 * notified via second_overflow. So instead we push xtime_nsec forward
-	 * by the amount we underflowed, and add that amount into the error.
-	 *
-	 * We'll correct this error next time through this function, when
-	 * xtime_nsec is not as small.
+	 * Now, since we have already accumulated the second and the NTP
+	 * subsystem has been notified via second_overflow(), we need to skip
+	 * the next update.
 	 */
 	if (unlikely((s64)tk->tkr_mono.xtime_nsec < 0)) {
-		s64 neg = -(s64)tk->tkr_mono.xtime_nsec;
-		tk->tkr_mono.xtime_nsec = 0;
-		tk->ntp_error += neg << tk->ntp_error_shift;
+		tk->tkr_mono.xtime_nsec += (u64)NSEC_PER_SEC <<
+							tk->tkr_mono.shift;
+		tk->xtime_sec--;
+		tk->skip_second_overflow = 1;
 	}
 }
 
@@ -2002,6 +1949,15 @@ static inline unsigned int accumulate_nsecs_to_secs(struct timekeeper *tk)
 		tk->tkr_mono.xtime_nsec -= nsecps;
 		tk->xtime_sec++;
 
+		/*
+		 * Skip NTP update if this second was accumulated before,
+		 * i.e. xtime_nsec underflowed in timekeeping_adjust()
+		 */
+		if (unlikely(tk->skip_second_overflow)) {
+			tk->skip_second_overflow = 0;
+			continue;
+		}
+
 		/* Figure out if its a leap sec and apply if needed */
 		leap = second_overflow(tk->xtime_sec);
 		if (unlikely(leap)) {
@@ -2118,7 +2074,7 @@ void update_wall_time(void)
 			shift--;
 	}
 
-	/* correct the clock when NTP error is too big */
+	/* Adjust the multiplier to correct NTP error */
 	timekeeping_adjust(tk, offset);
 
 	/*
-- 
2.7.4
