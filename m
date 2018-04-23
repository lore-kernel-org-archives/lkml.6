Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755705AbeDWQ3m (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 12:29:42 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51066 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755547AbeDWQ3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 12:29:37 -0400
Message-Id: <20180423162642.059848458@infradead.org>
User-Agent: quilt/0.63-1
Date: Mon, 23 Apr 2018 18:16:50 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org,
        diego.viola@gmail.com, len.brown@intel.com, rjw@rjwysocki.net,
        rui.zhang@intel.com
Subject: [PATCH 2/5] clocksource: Allow clocksource_mark_unstable() on unregisered clocksources
References: <20180423161648.622657048@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=peterz-tsc-early-fix-2.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because of how we flip between tsc-early and tsc clocksources we might
need to mark one or both unstable. The current code in
mark_tsc_unstable() only worked because we registered the tsc
clocksource once and then never touched it.

Since we now unregister the tsc-early clocksource, we need to know if
a clocksource got unregistered and the current cs->mult test doesn't
work for that. Instead use list_empty(&cs->list) to test for
registration.

Furthermore, since clocksource_mark_unstable() needs to place the cs
on the wd_list, it links the cs->list and cs->wd_list serialization.
We must not see a clocsource registered (!empty cs->list) but already
past dequeue_watchdog(). So place {en,de}queue{,_watchdog}() under the
same lock.

This then allows us to unconditionally use
clocksource_mark_unstable(), regardless of the registration state.

Tested-by: Diego Viola <diego.viola@gmail.com>
Cc: stable@kernel.org
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/time/clocksource.c |   39 ++++++++++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 9 deletions(-)

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
 
@@ -142,6 +152,9 @@ static void __clocksource_unstable(struc
 	cs->flags &= ~(CLOCK_SOURCE_VALID_FOR_HRES | CLOCK_SOURCE_WATCHDOG);
 	cs->flags |= CLOCK_SOURCE_UNSTABLE;
 
+	if (list_empty(&cs->list))
+		return;
+
 	if (cs->mark_unstable)
 		cs->mark_unstable(cs);
 
@@ -164,7 +177,7 @@ void clocksource_mark_unstable(struct cl
 
 	spin_lock_irqsave(&watchdog_lock, flags);
 	if (!(cs->flags & CLOCK_SOURCE_UNSTABLE)) {
-		if (list_empty(&cs->wd_list))
+		if (!list_empty(&cs->list) && list_empty(&cs->wd_list))
 			list_add(&cs->wd_list, &watchdog_list);
 		__clocksource_unstable(cs);
 	}
@@ -319,9 +332,6 @@ static void clocksource_resume_watchdog(
 
 static void clocksource_enqueue_watchdog(struct clocksource *cs)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&watchdog_lock, flags);
 	if (cs->flags & CLOCK_SOURCE_MUST_VERIFY) {
 		/* cs is a clocksource to be watched. */
 		list_add(&cs->wd_list, &watchdog_list);
@@ -331,7 +341,6 @@ static void clocksource_enqueue_watchdog
 		if (cs->flags & CLOCK_SOURCE_IS_CONTINUOUS)
 			cs->flags |= CLOCK_SOURCE_VALID_FOR_HRES;
 	}
-	spin_unlock_irqrestore(&watchdog_lock, flags);
 }
 
 static void clocksource_select_watchdog(bool fallback)
@@ -373,9 +382,6 @@ static void clocksource_select_watchdog(
 
 static void clocksource_dequeue_watchdog(struct clocksource *cs)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&watchdog_lock, flags);
 	if (cs != watchdog) {
 		if (cs->flags & CLOCK_SOURCE_MUST_VERIFY) {
 			/* cs is a watched clocksource. */
@@ -384,7 +390,6 @@ static void clocksource_dequeue_watchdog
 			clocksource_stop_watchdog();
 		}
 	}
-	spin_unlock_irqrestore(&watchdog_lock, flags);
 }
 
 static int __clocksource_watchdog_kthread(void)
@@ -779,14 +784,19 @@ EXPORT_SYMBOL_GPL(__clocksource_update_f
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
@@ -808,8 +818,13 @@ static void __clocksource_change_rating(
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
@@ -821,6 +836,8 @@ EXPORT_SYMBOL(clocksource_change_rating)
  */
 static int clocksource_unbind(struct clocksource *cs)
 {
+	unsigned long flags;
+
 	if (clocksource_is_watchdog(cs)) {
 		/* Select and try to install a replacement watchdog. */
 		clocksource_select_watchdog(true);
@@ -834,8 +851,12 @@ static int clocksource_unbind(struct clo
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
 
