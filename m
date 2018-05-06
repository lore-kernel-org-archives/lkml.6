Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751617AbeEFH7b (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 03:59:31 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:47162 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750872AbeEFH7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 03:59:30 -0400
Date: Sun, 6 May 2018 09:59:28 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>
Subject: [GIT pull] clocksource fixes for 4.17
Message-ID: <alpine.DEB.2.21.1805060955020.1685@nanos.tec.linutronix.de>
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

The recent addition of the early TSC clocksource breaks on machines which
have an unstable TSC because in case that TSC is disabled, then the
clocksource selection logic falls back to the early TSC which is obviously
bogus. That also unearthed a few robustness issues in the clocksource
derating code which are addressed as well.

Thanks,

	tglx

------------------>
Peter Zijlstra (6):
      x86/tsc: Always unregister clocksource_tsc_early
      clocksource: Allow clocksource_mark_unstable() on unregistered clocksources
      clocksource: Initialize cs->wd_list
      x86/tsc: Fix mark_tsc_unstable()
      clocksource: Consistent de-rate when marking unstable
      clocksource: Rework stale comment


 arch/x86/kernel/tsc.c     | 22 ++++++++---------
 kernel/time/clocksource.c | 63 +++++++++++++++++++++++++++++++++--------------
 2 files changed, 55 insertions(+), 30 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 91e6da48cbb6..74392d9d51e0 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1067,6 +1067,7 @@ static struct clocksource clocksource_tsc_early = {
 	.resume			= tsc_resume,
 	.mark_unstable		= tsc_cs_mark_unstable,
 	.tick_stable		= tsc_cs_tick_stable,
+	.list			= LIST_HEAD_INIT(clocksource_tsc_early.list),
 };
 
 /*
@@ -1086,6 +1087,7 @@ static struct clocksource clocksource_tsc = {
 	.resume			= tsc_resume,
 	.mark_unstable		= tsc_cs_mark_unstable,
 	.tick_stable		= tsc_cs_tick_stable,
+	.list			= LIST_HEAD_INIT(clocksource_tsc.list),
 };
 
 void mark_tsc_unstable(char *reason)
@@ -1098,13 +1100,9 @@ void mark_tsc_unstable(char *reason)
 		clear_sched_clock_stable();
 	disable_sched_clock_irqtime();
 	pr_info("Marking TSC unstable due to %s\n", reason);
-	/* Change only the rating, when not registered */
-	if (clocksource_tsc.mult) {
-		clocksource_mark_unstable(&clocksource_tsc);
-	} else {
-		clocksource_tsc.flags |= CLOCK_SOURCE_UNSTABLE;
-		clocksource_tsc.rating = 0;
-	}
+
+	clocksource_mark_unstable(&clocksource_tsc_early);
+	clocksource_mark_unstable(&clocksource_tsc);
 }
 
 EXPORT_SYMBOL_GPL(mark_tsc_unstable);
@@ -1244,7 +1242,7 @@ static void tsc_refine_calibration_work(struct work_struct *work)
 
 	/* Don't bother refining TSC on unstable systems */
 	if (tsc_unstable)
-		return;
+		goto unreg;
 
 	/*
 	 * Since the work is started early in boot, we may be
@@ -1297,11 +1295,12 @@ static void tsc_refine_calibration_work(struct work_struct *work)
 
 out:
 	if (tsc_unstable)
-		return;
+		goto unreg;
 
 	if (boot_cpu_has(X86_FEATURE_ART))
 		art_related_clocksource = &clocksource_tsc;
 	clocksource_register_khz(&clocksource_tsc, tsc_khz);
+unreg:
 	clocksource_unregister(&clocksource_tsc_early);
 }
 
@@ -1311,8 +1310,8 @@ static int __init init_tsc_clocksource(void)
 	if (!boot_cpu_has(X86_FEATURE_TSC) || tsc_disabled > 0 || !tsc_khz)
 		return 0;
 
-	if (check_tsc_unstable())
-		return 0;
+	if (tsc_unstable)
+		goto unreg;
 
 	if (tsc_clocksource_reliable)
 		clocksource_tsc.flags &= ~CLOCK_SOURCE_MUST_VERIFY;
@@ -1328,6 +1327,7 @@ static int __init init_tsc_clocksource(void)
 		if (boot_cpu_has(X86_FEATURE_ART))
 			art_related_clocksource = &clocksource_tsc;
 		clocksource_register_khz(&clocksource_tsc, tsc_khz);
+unreg:
 		clocksource_unregister(&clocksource_tsc_early);
 		return 0;
 	}
diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 0e974cface0b..84f37420fcf5 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -119,6 +119,16 @@ static DEFINE_SPINLOCK(watchdog_lock);
 static int watchdog_running;
 static atomic_t watchdog_reset_pending;
 
+static void inline clocksource_watchdog_lock(unsigned long *flags)
+{
+	spin_lock_irqsave(&watchdog_lock, *flags);
+}
+
+static void inline clocksource_watchdog_unlock(unsigned long *flags)
+{
+	spin_unlock_irqrestore(&watchdog_lock, *flags);
+}
+
 static int clocksource_watchdog_kthread(void *data);
 static void __clocksource_change_rating(struct clocksource *cs, int rating);
 
@@ -142,9 +152,19 @@ static void __clocksource_unstable(struct clocksource *cs)
 	cs->flags &= ~(CLOCK_SOURCE_VALID_FOR_HRES | CLOCK_SOURCE_WATCHDOG);
 	cs->flags |= CLOCK_SOURCE_UNSTABLE;
 
+	/*
+	 * If the clocksource is registered clocksource_watchdog_kthread() will
+	 * re-rate and re-select.
+	 */
+	if (list_empty(&cs->list)) {
+		cs->rating = 0;
+		return;
+	}
+
 	if (cs->mark_unstable)
 		cs->mark_unstable(cs);
 
+	/* kick clocksource_watchdog_kthread() */
 	if (finished_booting)
 		schedule_work(&watchdog_work);
 }
@@ -153,10 +173,8 @@ static void __clocksource_unstable(struct clocksource *cs)
  * clocksource_mark_unstable - mark clocksource unstable via watchdog
  * @cs:		clocksource to be marked unstable
  *
- * This function is called instead of clocksource_change_rating from
- * cpu hotplug code to avoid a deadlock between the clocksource mutex
- * and the cpu hotplug mutex. It defers the update of the clocksource
- * to the watchdog thread.
+ * This function is called by the x86 TSC code to mark clocksources as unstable;
+ * it defers demotion and re-selection to a kthread.
  */
 void clocksource_mark_unstable(struct clocksource *cs)
 {
@@ -164,7 +182,7 @@ void clocksource_mark_unstable(struct clocksource *cs)
 
 	spin_lock_irqsave(&watchdog_lock, flags);
 	if (!(cs->flags & CLOCK_SOURCE_UNSTABLE)) {
-		if (list_empty(&cs->wd_list))
+		if (!list_empty(&cs->list) && list_empty(&cs->wd_list))
 			list_add(&cs->wd_list, &watchdog_list);
 		__clocksource_unstable(cs);
 	}
@@ -319,9 +337,8 @@ static void clocksource_resume_watchdog(void)
 
 static void clocksource_enqueue_watchdog(struct clocksource *cs)
 {
-	unsigned long flags;
+	INIT_LIST_HEAD(&cs->wd_list);
 
-	spin_lock_irqsave(&watchdog_lock, flags);
 	if (cs->flags & CLOCK_SOURCE_MUST_VERIFY) {
 		/* cs is a clocksource to be watched. */
 		list_add(&cs->wd_list, &watchdog_list);
@@ -331,7 +348,6 @@ static void clocksource_enqueue_watchdog(struct clocksource *cs)
 		if (cs->flags & CLOCK_SOURCE_IS_CONTINUOUS)
 			cs->flags |= CLOCK_SOURCE_VALID_FOR_HRES;
 	}
-	spin_unlock_irqrestore(&watchdog_lock, flags);
 }
 
 static void clocksource_select_watchdog(bool fallback)
@@ -373,9 +389,6 @@ static void clocksource_select_watchdog(bool fallback)
 
 static void clocksource_dequeue_watchdog(struct clocksource *cs)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&watchdog_lock, flags);
 	if (cs != watchdog) {
 		if (cs->flags & CLOCK_SOURCE_MUST_VERIFY) {
 			/* cs is a watched clocksource. */
@@ -384,21 +397,19 @@ static void clocksource_dequeue_watchdog(struct clocksource *cs)
 			clocksource_stop_watchdog();
 		}
 	}
-	spin_unlock_irqrestore(&watchdog_lock, flags);
 }
 
 static int __clocksource_watchdog_kthread(void)
 {
 	struct clocksource *cs, *tmp;
 	unsigned long flags;
-	LIST_HEAD(unstable);
 	int select = 0;
 
 	spin_lock_irqsave(&watchdog_lock, flags);
 	list_for_each_entry_safe(cs, tmp, &watchdog_list, wd_list) {
 		if (cs->flags & CLOCK_SOURCE_UNSTABLE) {
 			list_del_init(&cs->wd_list);
-			list_add(&cs->wd_list, &unstable);
+			__clocksource_change_rating(cs, 0);
 			select = 1;
 		}
 		if (cs->flags & CLOCK_SOURCE_RESELECT) {
@@ -410,11 +421,6 @@ static int __clocksource_watchdog_kthread(void)
 	clocksource_stop_watchdog();
 	spin_unlock_irqrestore(&watchdog_lock, flags);
 
-	/* Needs to be done outside of watchdog lock */
-	list_for_each_entry_safe(cs, tmp, &unstable, wd_list) {
-		list_del_init(&cs->wd_list);
-		__clocksource_change_rating(cs, 0);
-	}
 	return select;
 }
 
@@ -447,6 +453,9 @@ static inline int __clocksource_watchdog_kthread(void) { return 0; }
 static bool clocksource_is_watchdog(struct clocksource *cs) { return false; }
 void clocksource_mark_unstable(struct clocksource *cs) { }
 
+static void inline clocksource_watchdog_lock(unsigned long *flags) { }
+static void inline clocksource_watchdog_unlock(unsigned long *flags) { }
+
 #endif /* CONFIG_CLOCKSOURCE_WATCHDOG */
 
 /**
@@ -779,14 +788,19 @@ EXPORT_SYMBOL_GPL(__clocksource_update_freq_scale);
  */
 int __clocksource_register_scale(struct clocksource *cs, u32 scale, u32 freq)
 {
+	unsigned long flags;
 
 	/* Initialize mult/shift and max_idle_ns */
 	__clocksource_update_freq_scale(cs, scale, freq);
 
 	/* Add clocksource to the clocksource list */
 	mutex_lock(&clocksource_mutex);
+
+	clocksource_watchdog_lock(&flags);
 	clocksource_enqueue(cs);
 	clocksource_enqueue_watchdog(cs);
+	clocksource_watchdog_unlock(&flags);
+
 	clocksource_select();
 	clocksource_select_watchdog(false);
 	mutex_unlock(&clocksource_mutex);
@@ -808,8 +822,13 @@ static void __clocksource_change_rating(struct clocksource *cs, int rating)
  */
 void clocksource_change_rating(struct clocksource *cs, int rating)
 {
+	unsigned long flags;
+
 	mutex_lock(&clocksource_mutex);
+	clocksource_watchdog_lock(&flags);
 	__clocksource_change_rating(cs, rating);
+	clocksource_watchdog_unlock(&flags);
+
 	clocksource_select();
 	clocksource_select_watchdog(false);
 	mutex_unlock(&clocksource_mutex);
@@ -821,6 +840,8 @@ EXPORT_SYMBOL(clocksource_change_rating);
  */
 static int clocksource_unbind(struct clocksource *cs)
 {
+	unsigned long flags;
+
 	if (clocksource_is_watchdog(cs)) {
 		/* Select and try to install a replacement watchdog. */
 		clocksource_select_watchdog(true);
@@ -834,8 +855,12 @@ static int clocksource_unbind(struct clocksource *cs)
 		if (curr_clocksource == cs)
 			return -EBUSY;
 	}
+
+	clocksource_watchdog_lock(&flags);
 	clocksource_dequeue_watchdog(cs);
 	list_del_init(&cs->list);
+	clocksource_watchdog_unlock(&flags);
+
 	return 0;
 }
 
