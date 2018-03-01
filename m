Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033184AbeCAQwE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 11:52:04 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:51702 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032990AbeCAQwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 11:52:02 -0500
Message-Id: <20180301165149.965235774@linutronix.de>
User-Agent: quilt/0.63-1
Date: Thu, 01 Mar 2018 17:33:32 +0100
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Stultz <john.stultz@linaro.org>, Petr Mladek <pmladek@suse.com>,
        Mark Salyzyn <salyzyn@android.com>,
        Prarit Bhargava <prarit@redhat.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Kevin Easton <kevin@guarana.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [RFC/RFT patch 1/7] timekeeping: Provide CLOCK_MONOTONIC_ACTIVE
References: <20180301163331.987775783@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline;
 filename=timekeeping--Provide-CLOCK_MONOTONIC_ACTIVE.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The planned change to unify the behaviour of clock MONOTONIC and clock
BOOTTIME vs. suspend removes the ability to retrieve the active
nonsuspended time of a system.

Provide CLOCK_MONOTONIC_ACTIVE which return the active non suspended time
of the system via clock_gettime(). This is the behaviour of CLOCK_MONOTONIC
bevor the BOOTTIME/MONOTONIC unification.

It also allows applications to detect programmatically that clock MONOTONIC
and clock BOOTTIME are identical.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/timekeeper_internal.h |    2 ++
 include/linux/timekeeping.h         |    1 +
 include/uapi/linux/time.h           |    1 +
 kernel/time/posix-stubs.c           |    2 ++
 kernel/time/posix-timers.c          |   13 +++++++++++++
 kernel/time/timekeeping.c           |   36 ++++++++++++++++++++++++++++++++++++
 6 files changed, 55 insertions(+)

--- a/include/linux/timekeeper_internal.h
+++ b/include/linux/timekeeper_internal.h
@@ -52,6 +52,7 @@ struct tk_read_base {
  * @offs_real:		Offset clock monotonic -> clock realtime
  * @offs_boot:		Offset clock monotonic -> clock boottime
  * @offs_tai:		Offset clock monotonic -> clock tai
+ * @time_suspended:	Accumulated suspend time
  * @tai_offset:		The current UTC to TAI offset in seconds
  * @clock_was_set_seq:	The sequence number of clock was set events
  * @cs_was_changed_seq:	The sequence number of clocksource change events
@@ -94,6 +95,7 @@ struct timekeeper {
 	ktime_t			offs_real;
 	ktime_t			offs_boot;
 	ktime_t			offs_tai;
+	ktime_t			time_suspended;
 	s32			tai_offset;
 	unsigned int		clock_was_set_seq;
 	u8			cs_was_changed_seq;
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -32,6 +32,7 @@ extern void getrawmonotonic64(struct tim
 extern void ktime_get_ts64(struct timespec64 *ts);
 extern time64_t ktime_get_seconds(void);
 extern time64_t ktime_get_real_seconds(void);
+extern void ktime_get_active_ts64(struct timespec64 *ts);
 
 extern int __getnstimeofday64(struct timespec64 *tv);
 extern void getnstimeofday64(struct timespec64 *tv);
--- a/include/uapi/linux/time.h
+++ b/include/uapi/linux/time.h
@@ -61,6 +61,7 @@ struct itimerval {
  */
 #define CLOCK_SGI_CYCLE			10
 #define CLOCK_TAI			11
+#define CLOCK_MONOTONIC_ACTIVE		12
 
 #define MAX_CLOCKS			16
 #define CLOCKS_MASK			(CLOCK_REALTIME | CLOCK_MONOTONIC)
--- a/kernel/time/posix-stubs.c
+++ b/kernel/time/posix-stubs.c
@@ -73,6 +73,8 @@ int do_clock_gettime(clockid_t which_clo
 	case CLOCK_BOOTTIME:
 		get_monotonic_boottime64(tp);
 		break;
+	case CLOCK_MONOTONIC_ACTIVE:
+		ktime_get_active_ts64(tp);
 	default:
 		return -EINVAL;
 	}
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -263,6 +263,13 @@ static int posix_get_tai(clockid_t which
 	return 0;
 }
 
+static int posix_get_monotonic_active(clockid_t which_clock,
+				      struct timespec64 *tp)
+{
+	ktime_get_active_ts64(tp);
+	return 0;
+}
+
 static int posix_get_hrtimer_res(clockid_t which_clock, struct timespec64 *tp)
 {
 	tp->tv_sec = 0;
@@ -1330,6 +1337,11 @@ static const struct k_clock clock_bootti
 	.timer_arm		= common_hrtimer_arm,
 };
 
+static const struct k_clock clock_monotonic_active = {
+	.clock_getres		= posix_get_hrtimer_res,
+	.clock_get		= posix_get_monotonic_active,
+};
+
 static const struct k_clock * const posix_clocks[] = {
 	[CLOCK_REALTIME]		= &clock_realtime,
 	[CLOCK_MONOTONIC]		= &clock_monotonic,
@@ -1342,6 +1354,7 @@ static const struct k_clock * const posi
 	[CLOCK_REALTIME_ALARM]		= &alarm_clock,
 	[CLOCK_BOOTTIME_ALARM]		= &alarm_clock,
 	[CLOCK_TAI]			= &clock_tai,
+	[CLOCK_MONOTONIC_ACTIVE]	= &clock_monotonic_active,
 };
 
 static const struct k_clock *clockid_to_kclock(const clockid_t id)
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -139,6 +139,9 @@ static void tk_set_wall_to_mono(struct t
 static inline void tk_update_sleep_time(struct timekeeper *tk, ktime_t delta)
 {
 	tk->offs_boot = ktime_add(tk->offs_boot, delta);
+
+	/* Accumulate time spent in suspend */
+	tk->time_suspended += delta;
 }
 
 /*
@@ -886,6 +889,39 @@ void ktime_get_ts64(struct timespec64 *t
 EXPORT_SYMBOL_GPL(ktime_get_ts64);
 
 /**
+ * ktime_get_active_ts64 - Get the active nonsuspended monotonic clock
+ * @ts:		pointer to timespec variable
+ *
+ * The function calculates the monotonic clock from the realtime clock and
+ * the wall_to_monotonic offset, subtracts the accumulated suspend time and
+ * stores the result in normalized timespec64 format in the variable
+ * pointed to by @ts.
+ */
+void ktime_get_active_ts64(struct timespec64 *ts)
+{
+	struct timekeeper *tk = &tk_core.timekeeper;
+	struct timespec64 tomono, tsusp;
+	u64 nsec, nssusp;
+	unsigned int seq;
+
+	WARN_ON(timekeeping_suspended);
+
+	do {
+		seq = read_seqcount_begin(&tk_core.seq);
+		ts->tv_sec = tk->xtime_sec;
+		nsec = timekeeping_get_ns(&tk->tkr_mono);
+		tomono = tk->wall_to_monotonic;
+		nssusp = tk->time_suspended;
+	} while (read_seqcount_retry(&tk_core.seq, seq));
+
+	ts->tv_sec += tomono.tv_sec;
+	ts->tv_nsec = 0;
+	timespec64_add_ns(ts, nsec + tomono.tv_nsec);
+	tsusp = ns_to_timespec64(nssusp);
+	*ts = timespec64_sub(*ts, tsusp);
+}
+
+/**
  * ktime_get_seconds - Get the seconds portion of CLOCK_MONOTONIC
  *
  * Returns the seconds portion of CLOCK_MONOTONIC with a single non
