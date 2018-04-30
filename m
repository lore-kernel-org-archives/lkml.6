Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753258AbeD3KE5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 06:04:57 -0400
Received: from merlin.infradead.org ([205.233.59.134]:60118 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751420AbeD3KEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 06:04:49 -0400
Message-Id: <20180430100344.713862818@infradead.org>
User-Agent: quilt/0.63-1
Date: Mon, 30 Apr 2018 12:00:15 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org,
        diego.viola@gmail.com, len.brown@intel.com, rjw@rjwysocki.net,
        rui.zhang@intel.com
Subject: [PATCH v2 7/7] clocksource: Remove kthread
References: <20180430100008.503783478@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-tsc-early-fix-8.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clocksource watchdog uses a work to spawn a kthread to run the
watchdog. That is about as silly as it sounds, run the watchdog
directly from the work.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/time/clocksource.c |   31 ++++++++++---------------------
 1 file changed, 10 insertions(+), 21 deletions(-)

--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -129,31 +129,19 @@ static void inline clocksource_watchdog_
 	spin_unlock_irqrestore(&watchdog_lock, *flags);
 }
 
-static int clocksource_watchdog_kthread(void *data);
-static void __clocksource_change_rating(struct clocksource *cs, int rating);
-
 /*
  * Interval: 0.5sec Threshold: 0.0625s
  */
 #define WATCHDOG_INTERVAL (HZ >> 1)
 #define WATCHDOG_THRESHOLD (NSEC_PER_SEC >> 4)
 
-static void clocksource_watchdog_work(struct work_struct *work)
-{
-	/*
-	 * If kthread_run fails the next watchdog scan over the
-	 * watchdog_list will find the unstable clock again.
-	 */
-	kthread_run(clocksource_watchdog_kthread, NULL, "kwatchdog");
-}
-
 static void __clocksource_unstable(struct clocksource *cs)
 {
 	cs->flags &= ~(CLOCK_SOURCE_VALID_FOR_HRES | CLOCK_SOURCE_WATCHDOG);
 	cs->flags |= CLOCK_SOURCE_UNSTABLE;
 
 	/*
-	 * If the clocksource is registered clocksource_watchdog_kthread() will
+	 * If the clocksource is registered clocksource_watchdog_work() will
 	 * re-rate and re-select.
 	 */
 	if (list_empty(&cs->list)) {
@@ -164,7 +152,7 @@ static void __clocksource_unstable(struc
 	if (cs->mark_unstable)
 		cs->mark_unstable(cs);
 
-	/* kick clocksource_watchdog_kthread() */
+	/* kick clocksource_watchdog_work() */
 	if (finished_booting)
 		schedule_work(&watchdog_work);
 }
@@ -174,7 +162,7 @@ static void __clocksource_unstable(struc
  * @cs:		clocksource to be marked unstable
  *
  * This function is called by the x86 TSC code to mark clocksources as unstable;
- * it defers demotion and re-selection to a kthread.
+ * it defers demotion and re-selection to a work.
  */
 void clocksource_mark_unstable(struct clocksource *cs)
 {
@@ -399,7 +387,9 @@ static void clocksource_dequeue_watchdog
 	}
 }
 
-static int __clocksource_watchdog_kthread(void)
+static void __clocksource_change_rating(struct clocksource *cs, int rating);
+
+static int __clocksource_watchdog_work(void)
 {
 	struct clocksource *cs, *tmp;
 	unsigned long flags;
@@ -424,13 +414,12 @@ static int __clocksource_watchdog_kthrea
 	return select;
 }
 
-static int clocksource_watchdog_kthread(void *data)
+static void clocksource_watchdog_work(struct work_struct *work)
 {
 	mutex_lock(&clocksource_mutex);
-	if (__clocksource_watchdog_kthread())
+	if (__clocksource_watchdog_work())
 		clocksource_select();
 	mutex_unlock(&clocksource_mutex);
-	return 0;
 }
 
 static bool clocksource_is_watchdog(struct clocksource *cs)
@@ -449,7 +438,7 @@ static void clocksource_enqueue_watchdog
 static void clocksource_select_watchdog(bool fallback) { }
 static inline void clocksource_dequeue_watchdog(struct clocksource *cs) { }
 static inline void clocksource_resume_watchdog(void) { }
-static inline int __clocksource_watchdog_kthread(void) { return 0; }
+static inline int __clocksource_watchdog_work(void) { return 0; }
 static bool clocksource_is_watchdog(struct clocksource *cs) { return false; }
 void clocksource_mark_unstable(struct clocksource *cs) { }
 
@@ -680,7 +669,7 @@ static int __init clocksource_done_booti
 	/*
 	 * Run the watchdog first to eliminate unstable clock sources
 	 */
-	__clocksource_watchdog_kthread();
+	__clocksource_watchdog_work();
 	clocksource_select();
 	mutex_unlock(&clocksource_mutex);
 	return 0;
