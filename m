Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751778AbeEBOnJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 10:43:09 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54631 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751712AbeEBOnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 10:43:07 -0400
Date: Wed, 2 May 2018 07:42:46 -0700
From: tip-bot for Peter Zijlstra <tipbot@zytor.com>
Message-ID: <tip-7197e77abcb65a71d0b21d67beb24f153a96055e@git.kernel.org>
Cc: mingo@kernel.org, linux-kernel@vger.kernel.org,
        rafael.j.wysocki@intel.com, hpa@zytor.com, tglx@linutronix.de,
        peterz@infradead.org
Reply-To: mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, hpa@zytor.com, rafael.j.wysocki@intel.com
In-Reply-To: <20180430100344.713862818@infradead.org>
References: <20180430100344.713862818@infradead.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] clocksource: Remove kthread
Git-Commit-ID: 7197e77abcb65a71d0b21d67beb24f153a96055e
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

Commit-ID:  7197e77abcb65a71d0b21d67beb24f153a96055e
Gitweb:     https://git.kernel.org/tip/7197e77abcb65a71d0b21d67beb24f153a96055e
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Mon, 30 Apr 2018 12:00:15 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 2 May 2018 16:11:46 +0200

clocksource: Remove kthread

The clocksource watchdog uses a work to spawn a kthread to run the
watchdog. That is about as silly as it sounds, run the watchdog
directly from the work.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: len.brown@intel.com
Cc: rjw@rjwysocki.net
Cc: diego.viola@gmail.com
Cc: rui.zhang@intel.com
Link: https://lkml.kernel.org/r/20180430100344.713862818@infradead.org

---
 kernel/time/clocksource.c | 31 ++++++++++---------------------
 1 file changed, 10 insertions(+), 21 deletions(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index 84f37420fcf5..56fd2239674f 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -129,31 +129,19 @@ static void inline clocksource_watchdog_unlock(unsigned long *flags)
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
@@ -164,7 +152,7 @@ static void __clocksource_unstable(struct clocksource *cs)
 	if (cs->mark_unstable)
 		cs->mark_unstable(cs);
 
-	/* kick clocksource_watchdog_kthread() */
+	/* kick clocksource_watchdog_work() */
 	if (finished_booting)
 		schedule_work(&watchdog_work);
 }
@@ -174,7 +162,7 @@ static void __clocksource_unstable(struct clocksource *cs)
  * @cs:		clocksource to be marked unstable
  *
  * This function is called by the x86 TSC code to mark clocksources as unstable;
- * it defers demotion and re-selection to a kthread.
+ * it defers demotion and re-selection to a work.
  */
 void clocksource_mark_unstable(struct clocksource *cs)
 {
@@ -399,7 +387,9 @@ static void clocksource_dequeue_watchdog(struct clocksource *cs)
 	}
 }
 
-static int __clocksource_watchdog_kthread(void)
+static void __clocksource_change_rating(struct clocksource *cs, int rating);
+
+static int __clocksource_watchdog_work(void)
 {
 	struct clocksource *cs, *tmp;
 	unsigned long flags;
@@ -424,13 +414,12 @@ static int __clocksource_watchdog_kthread(void)
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
@@ -449,7 +438,7 @@ static void clocksource_enqueue_watchdog(struct clocksource *cs)
 static void clocksource_select_watchdog(bool fallback) { }
 static inline void clocksource_dequeue_watchdog(struct clocksource *cs) { }
 static inline void clocksource_resume_watchdog(void) { }
-static inline int __clocksource_watchdog_kthread(void) { return 0; }
+static inline int __clocksource_watchdog_work(void) { return 0; }
 static bool clocksource_is_watchdog(struct clocksource *cs) { return false; }
 void clocksource_mark_unstable(struct clocksource *cs) { }
 
@@ -683,7 +672,7 @@ static int __init clocksource_done_booting(void)
 	/*
 	 * Run the watchdog first to eliminate unstable clock sources
 	 */
-	__clocksource_watchdog_kthread();
+	__clocksource_watchdog_work();
 	clocksource_select();
 	mutex_unlock(&clocksource_mutex);
 	return 0;
