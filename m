Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751971AbeCMHHj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 03:07:39 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46143 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751852AbeCMHHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 03:07:35 -0400
Date: Tue, 13 Mar 2018 00:06:48 -0700
From: tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-72199320d49dbafa1a99f94f1cd60dc90035c154@git.kernel.org>
Cc: pmladek@suse.com, linux-kernel@vger.kernel.org, rostedt@goodmis.org,
        john.stultz@linaro.org, mingo@kernel.org, corbet@lwn.net,
        peterz@infradead.org, salyzyn@android.com, dmitry.torokhov@gmail.com,
        hpa@zytor.com, torvalds@linux-foundation.org, prarit@redhat.com,
        kevin@guarana.org, sergey.senozhatsky@gmail.com,
        mtk.manpages@gmail.com, tglx@linutronix.de
Reply-To: mingo@kernel.org, corbet@lwn.net, peterz@infradead.org,
        salyzyn@android.com, john.stultz@linaro.org, rostedt@goodmis.org,
        pmladek@suse.com, linux-kernel@vger.kernel.org,
        dmitry.torokhov@gmail.com, prarit@redhat.com,
        torvalds@linux-foundation.org, hpa@zytor.com, mtk.manpages@gmail.com,
        tglx@linutronix.de, sergey.senozhatsky@gmail.com, kevin@guarana.org
In-Reply-To: <20180301165149.965235774@linutronix.de>
References: <20180301165149.965235774@linutronix.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] timekeeping: Add the new CLOCK_MONOTONIC_ACTIVE
 clock
Git-Commit-ID: 72199320d49dbafa1a99f94f1cd60dc90035c154
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  72199320d49dbafa1a99f94f1cd60dc90035c154
Gitweb:     https://git.kernel.org/tip/72199320d49dbafa1a99f94f1cd60dc90035c154
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Thu, 1 Mar 2018 17:33:32 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 13 Mar 2018 07:34:21 +0100

timekeeping: Add the new CLOCK_MONOTONIC_ACTIVE clock

The planned change to unify the behaviour of the MONOTONIC and BOOTTIME
clocks vs. suspend removes the ability to retrieve the active
non-suspended time of a system.

Provide a new CLOCK_MONOTONIC_ACTIVE clock which returns the active
non-suspended time of the system via clock_gettime().

This preserves the old behaviour of CLOCK_MONOTONIC before the
BOOTTIME/MONOTONIC unification.

This new clock also allows applications to detect programmatically that
the MONOTONIC and BOOTTIME clocks are identical.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Kevin Easton <kevin@guarana.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark Salyzyn <salyzyn@android.com>
Cc: Michael Kerrisk <mtk.manpages@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Prarit Bhargava <prarit@redhat.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Link: http://lkml.kernel.org/r/20180301165149.965235774@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/timekeeper_internal.h |  2 ++
 include/linux/timekeeping.h         |  1 +
 include/uapi/linux/time.h           |  1 +
 kernel/time/posix-stubs.c           |  2 ++
 kernel/time/posix-timers.c          | 13 +++++++++++++
 kernel/time/timekeeping.c           | 36 ++++++++++++++++++++++++++++++++++++
 6 files changed, 55 insertions(+)

diff --git a/include/linux/timekeeper_internal.h b/include/linux/timekeeper_internal.h
index 7acb953298a7..4b3dca173e89 100644
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
diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index b17bcce58bc4..440b1935d3a5 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -32,6 +32,7 @@ extern void getrawmonotonic64(struct timespec64 *ts);
 extern void ktime_get_ts64(struct timespec64 *ts);
 extern time64_t ktime_get_seconds(void);
 extern time64_t ktime_get_real_seconds(void);
+extern void ktime_get_active_ts64(struct timespec64 *ts);
 
 extern int __getnstimeofday64(struct timespec64 *tv);
 extern void getnstimeofday64(struct timespec64 *tv);
diff --git a/include/uapi/linux/time.h b/include/uapi/linux/time.h
index 53f8dd84beb5..61a187df8da2 100644
--- a/include/uapi/linux/time.h
+++ b/include/uapi/linux/time.h
@@ -61,6 +61,7 @@ struct itimerval {
  */
 #define CLOCK_SGI_CYCLE			10
 #define CLOCK_TAI			11
+#define CLOCK_MONOTONIC_ACTIVE		12
 
 #define MAX_CLOCKS			16
 #define CLOCKS_MASK			(CLOCK_REALTIME | CLOCK_MONOTONIC)
diff --git a/kernel/time/posix-stubs.c b/kernel/time/posix-stubs.c
index b258bee13b02..6259dbc0191a 100644
--- a/kernel/time/posix-stubs.c
+++ b/kernel/time/posix-stubs.c
@@ -73,6 +73,8 @@ int do_clock_gettime(clockid_t which_clock, struct timespec64 *tp)
 	case CLOCK_BOOTTIME:
 		get_monotonic_boottime64(tp);
 		break;
+	case CLOCK_MONOTONIC_ACTIVE:
+		ktime_get_active_ts64(tp);
 	default:
 		return -EINVAL;
 	}
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 75043046914e..556fe02a47a4 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -263,6 +263,13 @@ static int posix_get_tai(clockid_t which_clock, struct timespec64 *tp)
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
@@ -1330,6 +1337,11 @@ static const struct k_clock clock_boottime = {
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
@@ -1342,6 +1354,7 @@ static const struct k_clock * const posix_clocks[] = {
 	[CLOCK_REALTIME_ALARM]		= &alarm_clock,
 	[CLOCK_BOOTTIME_ALARM]		= &alarm_clock,
 	[CLOCK_TAI]			= &clock_tai,
+	[CLOCK_MONOTONIC_ACTIVE]	= &clock_monotonic_active,
 };
 
 static const struct k_clock *clockid_to_kclock(const clockid_t id)
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index e11760121cb2..a2b7f583e64e 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -139,6 +139,9 @@ static void tk_set_wall_to_mono(struct timekeeper *tk, struct timespec64 wtm)
 static inline void tk_update_sleep_time(struct timekeeper *tk, ktime_t delta)
 {
 	tk->offs_boot = ktime_add(tk->offs_boot, delta);
+
+	/* Accumulate time spent in suspend */
+	tk->time_suspended += delta;
 }
 
 /*
@@ -886,6 +889,39 @@ void ktime_get_ts64(struct timespec64 *ts)
 }
 EXPORT_SYMBOL_GPL(ktime_get_ts64);
 
+/**
+ * ktime_get_active_ts64 - Get the active non-suspended monotonic clock
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
 /**
  * ktime_get_seconds - Get the seconds portion of CLOCK_MONOTONIC
  *
