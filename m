Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033329AbeCAQxe (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 11:53:34 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:51712 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033032AbeCAQwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 11:52:03 -0500
Message-Id: <20180301165150.062975504@linutronix.de>
User-Agent: quilt/0.63-1
Date: Thu, 01 Mar 2018 17:33:33 +0100
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
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC/RFT patch 2/7] timekeeping: Make clock MONOTONIC behave like
 clock BOOTTIME
References: <20180301163331.987775783@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline;
 filename=timekeeping--Make-monotonic-behave-like-boottime.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clock MONOTONIC is not fast forwarded by the time spent in suspend on
resume. This is only done for clock BOOTTIME. The reason why clock
MONOTONIC is not forwarded is historical. The original Linux implementation
was using jiffies as a base for clock MONOTONIC and jiffies have never been
advanced after resume.

At some point when timekeeping was unified in the core code, clock
MONONOTIC was advanced after resume which also advanced jiffies causing
interesting side effects. As a consequence the clock MONOTONIC forwarding
was disabled again and clock BOOTTIME was introduced, which allows to read
time since boot.

Back then it was not possible to completely distangle clock MONOTONIC and
jiffies because there were still interfaces which exposed clock MONOTONIC
behaviour based on the timer wheel and therefore jiffies.

As of today none of the clock MONONOTIC facilities depends on jiffies
anymore so the forwarding can be done seperately. This is achieved by
forwarding the variables which are used for the jiffies update after resume
before the tick is restarted,

In timekeeping resume, the change is rather simple. Instead of updating the
offset between clock MONOTONIC and clock REALTIME/BOOTTIME, advance the
time keeper base for the MONOTONIC and the MONOTONIC_RAW clock by the time
spent in suspend.

Clock MONOTONIC is now the same as clock BOOTTIME and the offset between
clock REALTIME and clock MONOTONIC is the same as before suspend.

There might be side effects in applications, which rely on the
(unfortunately) well documented behaviour of clock MONOTONIC, but the
downsides of the existing behaviour are probably worse.

There is one obvious issue. Up to now it was possible to retrieve the time
spent in suspend by observing the delta between clock MONOTONIC and clock
BOOTTIME. This is not longer available, but the previously introduced
mechanism to read the active nonsuspended monotonic time can mitigate that
in a detectable fashion.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Prarit Bhargava <prarit@redhat.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mark Salyzyn <salyzyn@android.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>

---
 kernel/time/tick-common.c   |   15 +++++++++++++++
 kernel/time/tick-internal.h |    6 ++++++
 kernel/time/tick-sched.c    |    9 +++++++++
 kernel/time/timekeeping.c   |    7 ++++---
 4 files changed, 34 insertions(+), 3 deletions(-)

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
--- a/kernel/time/tick-internal.h
+++ b/kernel/time/tick-internal.h
@@ -141,6 +141,12 @@ static inline void tick_check_oneshot_br
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
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -52,6 +52,15 @@ struct tick_sched *tick_get_tick_sched(i
 static ktime_t last_jiffies_update;
 
 /*
+ * Called after resume. Make sure that jiffies are not fast forwarded due to
+ * clock monotonic being forwarded by the suspended time.
+ */
+void tick_sched_forward_next_period(void)
+{
+	last_jiffies_update = tick_next_period;
+}
+
+/*
  * Must be called with interrupts disabled !
  */
 static void tick_do_update_jiffies64(ktime_t now)
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -138,7 +138,9 @@ static void tk_set_wall_to_mono(struct t
 
 static inline void tk_update_sleep_time(struct timekeeper *tk, ktime_t delta)
 {
-	tk->offs_boot = ktime_add(tk->offs_boot, delta);
+	/* Update both bases so mono and raw stay coupled. */
+	tk->tkr_mono.base += delta;
+	tk->tkr_raw.base += delta;
 
 	/* Accumulate time spent in suspend */
 	tk->time_suspended += delta;
@@ -1621,7 +1623,6 @@ static void __timekeeping_inject_sleepti
 		return;
 	}
 	tk_xtime_add(tk, delta);
-	tk_set_wall_to_mono(tk, timespec64_sub(tk->wall_to_monotonic, *delta));
 	tk_update_sleep_time(tk, timespec64_to_ktime(*delta));
 	tk_debug_account_sleep_time(delta);
 }
@@ -2202,7 +2203,7 @@ void update_wall_time(void)
 void getboottime64(struct timespec64 *ts)
 {
 	struct timekeeper *tk = &tk_core.timekeeper;
-	ktime_t t = ktime_sub(tk->offs_real, tk->offs_boot);
+	ktime_t t = ktime_sub(tk->offs_real, tk->time_suspended);
 
 	*ts = ktime_to_timespec64(t);
 }
