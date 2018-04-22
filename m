Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751685AbeDVKva (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 06:51:30 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:51409 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751234AbeDVKvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 06:51:25 -0400
Date: Sun, 22 Apr 2018 12:51:23 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: [GIT pull] timer fixes for 4.17
Message-ID: <alpine.DEB.2.21.1804221248320.6136@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest timers-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-for-linus

A small set of timer fixes:

 - Evaluate the -ETIME condition correctly in the imx tpm driver

 - Fix the evaluation order of a condition in posix cpu timers

 - Use pr_cont() in the clockevents code to prevent ugly message splitting

 - Remove __current_kernel_time() which is now unused to prevent that new
   users show up.

 - Remove a stale forward declaration

Thanks,

	tglx

------------------>
Anson Huang (1):
      clocksource/imx-tpm: Correct -ETIME return condition check

Baolin Wang (1):
      timekeeping: Remove __current_kernel_time()

Geert Uytterhoeven (1):
      clockevents: Fix kernel messages split across multiple lines

Laura Abbott (1):
      posix-cpu-timers: Ensure set_process_cpu_timer is always evaluated

Liu, Changcheng (1):
      timers: Remove stale struct tvec_base forward declaration


 drivers/clocksource/timer-imx-tpm.c |  2 +-
 include/linux/timekeeping32.h       |  3 ---
 include/linux/timer.h               |  2 --
 kernel/time/posix-cpu-timers.c      |  4 +++-
 kernel/time/tick-oneshot.c          | 11 +++++------
 kernel/time/timekeeping.c           |  7 -------
 6 files changed, 9 insertions(+), 20 deletions(-)

diff --git a/drivers/clocksource/timer-imx-tpm.c b/drivers/clocksource/timer-imx-tpm.c
index 05d97a6871d8..6c8318470b48 100644
--- a/drivers/clocksource/timer-imx-tpm.c
+++ b/drivers/clocksource/timer-imx-tpm.c
@@ -114,7 +114,7 @@ static int tpm_set_next_event(unsigned long delta,
 	 * of writing CNT registers which may cause the min_delta event got
 	 * missed, so we need add a ETIME check here in case it happened.
 	 */
-	return (int)((next - now) <= 0) ? -ETIME : 0;
+	return (int)(next - now) <= 0 ? -ETIME : 0;
 }
 
 static int tpm_set_state_oneshot(struct clock_event_device *evt)
diff --git a/include/linux/timekeeping32.h b/include/linux/timekeeping32.h
index af4114d5dc17..3616b4becb59 100644
--- a/include/linux/timekeeping32.h
+++ b/include/linux/timekeeping32.h
@@ -9,9 +9,6 @@
 extern void do_gettimeofday(struct timeval *tv);
 unsigned long get_seconds(void);
 
-/* does not take xtime_lock */
-struct timespec __current_kernel_time(void);
-
 static inline struct timespec current_kernel_time(void)
 {
 	struct timespec64 now = current_kernel_time64();
diff --git a/include/linux/timer.h b/include/linux/timer.h
index 2448f9cc48a3..7b066fd38248 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -8,8 +8,6 @@
 #include <linux/debugobjects.h>
 #include <linux/stringify.h>
 
-struct tvec_base;
-
 struct timer_list {
 	/*
 	 * All fields that change during normal runtime grouped to the
diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 2541bd89f20e..5a6251ac6f7a 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -1205,10 +1205,12 @@ void set_process_cpu_timer(struct task_struct *tsk, unsigned int clock_idx,
 			   u64 *newval, u64 *oldval)
 {
 	u64 now;
+	int ret;
 
 	WARN_ON_ONCE(clock_idx == CPUCLOCK_SCHED);
+	ret = cpu_timer_sample_group(clock_idx, tsk, &now);
 
-	if (oldval && cpu_timer_sample_group(clock_idx, tsk, &now) != -EINVAL) {
+	if (oldval && ret != -EINVAL) {
 		/*
 		 * We are setting itimer. The *oldval is absolute and we update
 		 * it to be relative, *newval argument is relative and we update
diff --git a/kernel/time/tick-oneshot.c b/kernel/time/tick-oneshot.c
index c1f518e7aa80..6fe615d57ebb 100644
--- a/kernel/time/tick-oneshot.c
+++ b/kernel/time/tick-oneshot.c
@@ -82,16 +82,15 @@ int tick_switch_to_oneshot(void (*handler)(struct clock_event_device *))
 	if (!dev || !(dev->features & CLOCK_EVT_FEAT_ONESHOT) ||
 		    !tick_device_is_functional(dev)) {
 
-		printk(KERN_INFO "Clockevents: "
-		       "could not switch to one-shot mode:");
+		pr_info("Clockevents: could not switch to one-shot mode:");
 		if (!dev) {
-			printk(" no tick device\n");
+			pr_cont(" no tick device\n");
 		} else {
 			if (!tick_device_is_functional(dev))
-				printk(" %s is not functional.\n", dev->name);
+				pr_cont(" %s is not functional.\n", dev->name);
 			else
-				printk(" %s does not support one-shot mode.\n",
-				       dev->name);
+				pr_cont(" %s does not support one-shot mode.\n",
+					dev->name);
 		}
 		return -EINVAL;
 	}
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index ca90219a1e73..dcf7f20fcd12 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2139,13 +2139,6 @@ unsigned long get_seconds(void)
 }
 EXPORT_SYMBOL(get_seconds);
 
-struct timespec __current_kernel_time(void)
-{
-	struct timekeeper *tk = &tk_core.timekeeper;
-
-	return timespec64_to_timespec(tk_xtime(tk));
-}
-
 struct timespec64 current_kernel_time64(void)
 {
 	struct timekeeper *tk = &tk_core.timekeeper;
