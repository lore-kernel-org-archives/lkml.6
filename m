Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752041AbeCMHIA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 03:08:00 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38895 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752003AbeCMHH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 03:07:58 -0400
Date: Tue, 13 Mar 2018 00:07:16 -0700
From: tip-bot for Thomas Gleixner <tipbot@zytor.com>
Message-ID: <tip-d6ed449afdb38f89a7b38ec50e367559e1b8f71f@git.kernel.org>
Cc: dmitry.torokhov@gmail.com, mingo@kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, rostedt@goodmis.org, prarit@redhat.com,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        sergey.senozhatsky@gmail.com, hpa@zytor.com, tglx@linutronix.de,
        pmladek@suse.com, kevin@guarana.org, corbet@lwn.net,
        john.stultz@linaro.org, salyzyn@android.com, mtk.manpages@gmail.com
Reply-To: rostedt@goodmis.org, prarit@redhat.com, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, dmitry.torokhov@gmail.com,
        mingo@kernel.org, peterz@infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, pmladek@suse.com, kevin@guarana.org,
        corbet@lwn.net, john.stultz@linaro.org, salyzyn@android.com,
        mtk.manpages@gmail.com, sergey.senozhatsky@gmail.com, hpa@zytor.com
In-Reply-To: <20180301165150.062975504@linutronix.de>
References: <20180301165150.062975504@linutronix.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] timekeeping: Make the MONOTONIC clock behave like
 the BOOTTIME clock
Git-Commit-ID: d6ed449afdb38f89a7b38ec50e367559e1b8f71f
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

Commit-ID:  d6ed449afdb38f89a7b38ec50e367559e1b8f71f
Gitweb:     https://git.kernel.org/tip/d6ed449afdb38f89a7b38ec50e367559e1b8f71f
Author:     Thomas Gleixner <tglx@linutronix.de>
AuthorDate: Thu, 1 Mar 2018 17:33:33 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 13 Mar 2018 07:34:22 +0100

timekeeping: Make the MONOTONIC clock behave like the BOOTTIME clock

The MONOTONIC clock is not fast forwarded by the time spent in suspend on
resume. This is only done for the BOOTTIME clock. The reason why the
MONOTONIC clock is not forwarded is historical: the original Linux
implementation was using jiffies as a base for the MONOTONIC clock and
jiffies have never been advanced after resume.

At some point when timekeeping was unified in the core code, the
MONONOTIC clock was advanced after resume which also advanced jiffies causing
interesting side effects. As a consequence the the MONOTONIC clock forwarding
was disabled again and the BOOTTIME clock was introduced, which allows to read
time since boot.

Back then it was not possible to completely distangle the MONOTONIC clock and
jiffies because there were still interfaces which exposed the MONOTONIC clock
behaviour based on the timer wheel and therefore jiffies.

As of today none of the MONOTONIC clock facilities depends on jiffies
anymore so the forwarding can be done seperately. This is achieved by
forwarding the variables which are used for the jiffies update after resume
before the tick is restarted,

In timekeeping resume, the change is rather simple. Instead of updating the
offset between the MONOTONIC clock and the REALTIME/BOOTTIME clocks, advance the
time keeper base for the MONOTONIC and the MONOTONIC_RAW clocks by the time
spent in suspend.

The MONOTONIC clock is now the same as the BOOTTIME clock and the offset between
the REALTIME and the MONOTONIC clocks is the same as before suspend.

There might be side effects in applications, which rely on the
(unfortunately) well documented behaviour of the MONOTONIC clock, but the
downsides of the existing behaviour are probably worse.

There is one obvious issue. Up to now it was possible to retrieve the time
spent in suspend by observing the delta between the MONOTONIC clock and the
BOOTTIME clock. This is not longer available, but the previously introduced
mechanism to read the active non-suspended monotonic time can mitigate that
in a detectable fashion.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
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
Link: http://lkml.kernel.org/r/20180301165150.062975504@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/time/tick-common.c   | 15 +++++++++++++++
 kernel/time/tick-internal.h |  6 ++++++
 kernel/time/tick-sched.c    |  9 +++++++++
 kernel/time/timekeeping.c   |  7 ++++---
 4 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index 49edc1c4f3e6..099572ca4a8f 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -419,6 +419,19 @@ void tick_suspend_local(void)
 	clockevents_shutdown(td->evtdev);
 }
 
+static void tick_forward_next_period(void)
+{
+	ktime_t delta, now = ktime_get();
+	u64 n;
+
+	delta = ktime_sub(now, tick_next_period);
+	n = ktime_divns(delta, tick_period);
+	tick_next_period += n * tick_period;
+	if (tick_next_period < now)
+		tick_next_period += tick_period;
+	tick_sched_forward_next_period();
+}
+
 /**
  * tick_resume_local - Resume the local tick device
  *
@@ -431,6 +444,8 @@ void tick_resume_local(void)
 	struct tick_device *td = this_cpu_ptr(&tick_cpu_device);
 	bool broadcast = tick_resume_check_broadcast();
 
+	tick_forward_next_period();
+
 	clockevents_tick_resume(td->evtdev);
 	if (!broadcast) {
 		if (td->mode == TICKDEV_MODE_PERIODIC)
diff --git a/kernel/time/tick-internal.h b/kernel/time/tick-internal.h
index e277284c2831..21efab7485ca 100644
--- a/kernel/time/tick-internal.h
+++ b/kernel/time/tick-internal.h
@@ -141,6 +141,12 @@ static inline void tick_check_oneshot_broadcast_this_cpu(void) { }
 static inline bool tick_broadcast_oneshot_available(void) { return tick_oneshot_possible(); }
 #endif /* !(BROADCAST && ONESHOT) */
 
+#if defined(CONFIG_NO_HZ_COMMON) || defined(CONFIG_HIGH_RES_TIMERS)
+extern void tick_sched_forward_next_period(void);
+#else
+static inline void tick_sched_forward_next_period(void) { }
+#endif
+
 /* NO_HZ_FULL internal */
 #ifdef CONFIG_NO_HZ_FULL
 extern void tick_nohz_init(void);
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 29a5733eff83..f53e37b5d248 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -51,6 +51,15 @@ struct tick_sched *tick_get_tick_sched(int cpu)
  */
 static ktime_t last_jiffies_update;
 
+/*
+ * Called after resume. Make sure that jiffies are not fast forwarded due to
+ * clock monotonic being forwarded by the suspended time.
+ */
+void tick_sched_forward_next_period(void)
+{
+	last_jiffies_update = tick_next_period;
+}
+
 /*
  * Must be called with interrupts disabled !
  */
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index a2b7f583e64e..b509fe7acd64 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -138,7 +138,9 @@ static void tk_set_wall_to_mono(struct timekeeper *tk, struct timespec64 wtm)
 
 static inline void tk_update_sleep_time(struct timekeeper *tk, ktime_t delta)
 {
-	tk->offs_boot = ktime_add(tk->offs_boot, delta);
+	/* Update both bases so mono and raw stay coupled. */
+	tk->tkr_mono.base += delta;
+	tk->tkr_raw.base += delta;
 
 	/* Accumulate time spent in suspend */
 	tk->time_suspended += delta;
@@ -1622,7 +1624,6 @@ static void __timekeeping_inject_sleeptime(struct timekeeper *tk,
 		return;
 	}
 	tk_xtime_add(tk, delta);
-	tk_set_wall_to_mono(tk, timespec64_sub(tk->wall_to_monotonic, *delta));
 	tk_update_sleep_time(tk, timespec64_to_ktime(*delta));
 	tk_debug_account_sleep_time(delta);
 }
@@ -2155,7 +2156,7 @@ out:
 void getboottime64(struct timespec64 *ts)
 {
 	struct timekeeper *tk = &tk_core.timekeeper;
-	ktime_t t = ktime_sub(tk->offs_real, tk->offs_boot);
+	ktime_t t = ktime_sub(tk->offs_real, tk->time_suspended);
 
 	*ts = ktime_to_timespec64(t);
 }
