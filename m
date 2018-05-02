Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751441AbeEBNx1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 09:53:27 -0400
Received: from merlin.infradead.org ([205.233.59.134]:56254 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751036AbeEBNxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 09:53:24 -0400
Date: Wed, 2 May 2018 15:53:12 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, diego.viola@gmail.com,
        len.brown@intel.com, rjw@rjwysocki.net, rui.zhang@intel.com,
        stable@kernel.org
Subject: Re: [PATCH v2 2/7] clocksource: Allow clocksource_mark_unstable() on
 unregisered clocksources
Message-ID: <20180502135312.GS12217@hirez.programming.kicks-ass.net>
References: <20180430100008.503783478@infradead.org>
 <20180430100344.412078717@infradead.org>
 <alpine.DEB.2.21.1805021534250.1560@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1805021534250.1560@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 02, 2018 at 03:35:53PM +0200, Thomas Gleixner wrote:
> On Mon, 30 Apr 2018, Peter Zijlstra wrote:
> > --- a/kernel/time/clocksource.c
> > +++ b/kernel/time/clocksource.c
> > @@ -119,6 +119,16 @@ static DEFINE_SPINLOCK(watchdog_lock);
> >  static int watchdog_running;
> >  static atomic_t watchdog_reset_pending;
> >  
> > +static void inline clocksource_watchdog_lock(unsigned long *flags)
> > +{
> > +	spin_lock_irqsave(&watchdog_lock, *flags);
> > +}
> > +
> > +static void inline clocksource_watchdog_unlock(unsigned long *flags)
> > +{
> > +	spin_unlock_irqrestore(&watchdog_lock, *flags);
> > +}
> 
> I can see why you made that wrapper, but where are the stubs for
> !CONFIG_CLOCKSOURCE_WATCHDOG?

Whoops ;-)

---
Subject: clocksource: Allow clocksource_mark_unstable() on unregisered clocksources
From: Peter Zijlstra <peterz@infradead.org>
Date: Mon Apr 23 17:28:55 CEST 2018

Because of how the code flips between tsc-early and tsc clocksources
it might need to mark one or both unstable. The current code in
mark_tsc_unstable() only worked because previously it registered the
tsc clocksource once and then never touched it.

Since it now unregisters the tsc-early clocksource, it needs to know
if a clocksource got unregistered and the current cs->mult test
doesn't work for that. Instead use list_empty(&cs->list) to test for
registration.

Furthermore, since clocksource_mark_unstable() needs to place the cs
on the wd_list, it links the cs->list and cs->wd_list serialization.
It must not see a clocsource registered (!empty cs->list) but already
past dequeue_watchdog(). So place {en,de}queue{,_watchdog}() under the
same lock.

Provided cs->list is initialized to empty, this then allows us to
unconditionally use clocksource_mark_unstable(), regardless of the
registration state.

Cc: stable@kernel.org
Tested-by: Diego Viola <diego.viola@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/time/clocksource.c |   50 +++++++++++++++++++++++++++++++---------------
 1 file changed, 34 insertions(+), 16 deletions(-)

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
@@ -384,21 +390,19 @@ static void clocksource_dequeue_watchdog
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
@@ -410,11 +414,6 @@ static int __clocksource_watchdog_kthrea
 	clocksource_stop_watchdog();
 	spin_unlock_irqrestore(&watchdog_lock, flags);
 
-	/* Needs to be done outside of watchdog lock */
-	list_for_each_entry_safe(cs, tmp, &unstable, wd_list) {
-		list_del_init(&cs->wd_list);
-		__clocksource_change_rating(cs, 0);
-	}
 	return select;
 }
 
@@ -447,6 +446,9 @@ static inline int __clocksource_watchdog
 static bool clocksource_is_watchdog(struct clocksource *cs) { return false; }
 void clocksource_mark_unstable(struct clocksource *cs) { }
 
+static void inline clocksource_watchdog_lock(unsigned long *flags) { }
+static void inline clocksource_watchdog_unlock(unsigned long *flags) { }
+
 #endif /* CONFIG_CLOCKSOURCE_WATCHDOG */
 
 /**
@@ -779,14 +781,19 @@ EXPORT_SYMBOL_GPL(__clocksource_update_f
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
@@ -808,8 +815,13 @@ static void __clocksource_change_rating(
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
@@ -821,6 +833,8 @@ EXPORT_SYMBOL(clocksource_change_rating)
  */
 static int clocksource_unbind(struct clocksource *cs)
 {
+	unsigned long flags;
+
 	if (clocksource_is_watchdog(cs)) {
 		/* Select and try to install a replacement watchdog. */
 		clocksource_select_watchdog(true);
@@ -834,8 +848,12 @@ static int clocksource_unbind(struct clo
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
 
