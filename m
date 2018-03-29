Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752655AbeC2MXH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 08:23:07 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:63779 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752489AbeC2MXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 08:23:04 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Thomas Ilsche <thomas.ilsche@tu-dresden.de>,
        Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@surriel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Mike Galbraith <mgalbraith@suse.de>,
        LKML <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>
Subject: [PATCH v8 07/10] time: hrtimer: Timer exclusion support for hrtimer_get_next_event()
Date: Thu, 29 Mar 2018 14:12:55 +0200
Message-ID: <3236595.CEefXZ6hJ9@aspire.rjw.lan>
In-Reply-To: <40092860.XNQZrLjKDd@aspire.rjw.lan>
References: <40092860.XNQZrLjKDd@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The next set of changes will need to compute the time to the next
hrtimer event over all hrtimers except for the scheduler tick one.

To prepare for that, modify hrtimer_get_next_event() so that it can
take a pointer to the timer to exclude from the next event check
and change the underlying code to handle that.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v7 -> v8: New patch.

---
 include/linux/hrtimer.h |    2 -
 kernel/time/hrtimer.c   |   56 ++++++++++++++++++++++++++++++++++++------------
 kernel/time/timer.c     |    4 +--
 3 files changed, 46 insertions(+), 16 deletions(-)

Index: linux-pm/include/linux/hrtimer.h
===================================================================
--- linux-pm.orig/include/linux/hrtimer.h
+++ linux-pm/include/linux/hrtimer.h
@@ -425,7 +425,7 @@ static inline ktime_t hrtimer_get_remain
 	return __hrtimer_get_remaining(timer, false);
 }
 
-extern u64 hrtimer_get_next_event(void);
+extern u64 hrtimer_get_next_event(const struct hrtimer *exclude);
 
 extern bool hrtimer_active(const struct hrtimer *timer);
 
Index: linux-pm/kernel/time/hrtimer.c
===================================================================
--- linux-pm.orig/kernel/time/hrtimer.c
+++ linux-pm/kernel/time/hrtimer.c
@@ -490,6 +490,7 @@ __next_base(struct hrtimer_cpu_base *cpu
 	while ((base = __next_base((cpu_base), &(active))))
 
 static ktime_t __hrtimer_next_event_base(struct hrtimer_cpu_base *cpu_base,
+					 const struct hrtimer *exclude,
 					 unsigned int active,
 					 ktime_t expires_next)
 {
@@ -502,9 +503,24 @@ static ktime_t __hrtimer_next_event_base
 
 		next = timerqueue_getnext(&base->active);
 		timer = container_of(next, struct hrtimer, node);
+		if (timer == exclude) {
+			/* Get to the next timer in the queue. */
+			struct rb_node *rbn = rb_next(&next->node);
+
+			next = rb_entry_safe(rbn, struct timerqueue_node, node);
+			if (!next)
+				continue;
+
+			timer = container_of(next, struct hrtimer, node);
+		}
 		expires = ktime_sub(hrtimer_get_expires(timer), base->offset);
 		if (expires < expires_next) {
 			expires_next = expires;
+
+			/* Skip cpu_base update if a timer is being excluded. */
+			if (exclude)
+				continue;
+
 			if (timer->is_soft)
 				cpu_base->softirq_next_timer = timer;
 			else
@@ -538,8 +554,9 @@ static ktime_t __hrtimer_next_event_base
  *  - HRTIMER_ACTIVE_SOFT, or
  *  - HRTIMER_ACTIVE_HARD.
  */
-static ktime_t
-__hrtimer_get_next_event(struct hrtimer_cpu_base *cpu_base, unsigned int active_mask)
+static ktime_t __hrtimer_get_next_event(struct hrtimer_cpu_base *cpu_base,
+					const struct hrtimer *exclude,
+					unsigned int active_mask)
 {
 	unsigned int active;
 	struct hrtimer *next_timer = NULL;
@@ -547,16 +564,22 @@ __hrtimer_get_next_event(struct hrtimer_
 
 	if (!cpu_base->softirq_activated && (active_mask & HRTIMER_ACTIVE_SOFT)) {
 		active = cpu_base->active_bases & HRTIMER_ACTIVE_SOFT;
-		cpu_base->softirq_next_timer = NULL;
-		expires_next = __hrtimer_next_event_base(cpu_base, active, KTIME_MAX);
+		if (!exclude)
+			cpu_base->softirq_next_timer = NULL;
+
+		expires_next = __hrtimer_next_event_base(cpu_base, exclude,
+							 active, KTIME_MAX);
 
 		next_timer = cpu_base->softirq_next_timer;
 	}
 
 	if (active_mask & HRTIMER_ACTIVE_HARD) {
 		active = cpu_base->active_bases & HRTIMER_ACTIVE_HARD;
-		cpu_base->next_timer = next_timer;
-		expires_next = __hrtimer_next_event_base(cpu_base, active, expires_next);
+		if (!exclude)
+			cpu_base->next_timer = next_timer;
+
+		expires_next = __hrtimer_next_event_base(cpu_base, exclude,
+							 active, expires_next);
 	}
 
 	return expires_next;
@@ -605,7 +628,7 @@ hrtimer_force_reprogram(struct hrtimer_c
 	/*
 	 * Find the current next expiration time.
 	 */
-	expires_next = __hrtimer_get_next_event(cpu_base, HRTIMER_ACTIVE_ALL);
+	expires_next = __hrtimer_get_next_event(cpu_base, NULL, HRTIMER_ACTIVE_ALL);
 
 	if (cpu_base->next_timer && cpu_base->next_timer->is_soft) {
 		/*
@@ -614,7 +637,7 @@ hrtimer_force_reprogram(struct hrtimer_c
 		 * timer interrupt could occur too late.
 		 */
 		if (cpu_base->softirq_activated)
-			expires_next = __hrtimer_get_next_event(cpu_base,
+			expires_next = __hrtimer_get_next_event(cpu_base, NULL,
 								HRTIMER_ACTIVE_HARD);
 		else
 			cpu_base->softirq_expires_next = expires_next;
@@ -1034,7 +1057,7 @@ hrtimer_update_softirq_timer(struct hrti
 	/*
 	 * Find the next SOFT expiration.
 	 */
-	expires = __hrtimer_get_next_event(cpu_base, HRTIMER_ACTIVE_SOFT);
+	expires = __hrtimer_get_next_event(cpu_base, NULL, HRTIMER_ACTIVE_SOFT);
 
 	/*
 	 * reprogramming needs to be triggered, even if the next soft
@@ -1184,19 +1207,26 @@ EXPORT_SYMBOL_GPL(__hrtimer_get_remainin
 #ifdef CONFIG_NO_HZ_COMMON
 /**
  * hrtimer_get_next_event - get the time until next expiry event
+ * @exclude:	timer to exclude from the check
  *
  * Returns the next expiry time or KTIME_MAX if no timer is pending.
+ *
+ * KTIME_MAX is also returned if the @exclude timer pointer is not NULL and high
+ * resolution timers are not enabled.
  */
-u64 hrtimer_get_next_event(void)
+u64 hrtimer_get_next_event(const struct hrtimer *exclude)
 {
 	struct hrtimer_cpu_base *cpu_base = this_cpu_ptr(&hrtimer_bases);
 	u64 expires = KTIME_MAX;
 	unsigned long flags;
+	bool hres_active;
 
 	raw_spin_lock_irqsave(&cpu_base->lock, flags);
 
-	if (!__hrtimer_hres_active(cpu_base))
-		expires = __hrtimer_get_next_event(cpu_base, HRTIMER_ACTIVE_ALL);
+	hres_active = __hrtimer_hres_active(cpu_base);
+	if ((!exclude && !hres_active) || (exclude && hres_active))
+		expires = __hrtimer_get_next_event(cpu_base, exclude,
+						   HRTIMER_ACTIVE_ALL);
 
 	raw_spin_unlock_irqrestore(&cpu_base->lock, flags);
 
@@ -1469,7 +1499,7 @@ retry:
 	__hrtimer_run_queues(cpu_base, now, flags, HRTIMER_ACTIVE_HARD);
 
 	/* Reevaluate the clock bases for the next expiry */
-	expires_next = __hrtimer_get_next_event(cpu_base, HRTIMER_ACTIVE_ALL);
+	expires_next = __hrtimer_get_next_event(cpu_base, NULL, HRTIMER_ACTIVE_ALL);
 	/*
 	 * Store the new expiry value so the migration code can verify
 	 * against it.
Index: linux-pm/kernel/time/timer.c
===================================================================
--- linux-pm.orig/kernel/time/timer.c
+++ linux-pm/kernel/time/timer.c
@@ -1481,11 +1481,11 @@ static unsigned long __next_timer_interr
  */
 static u64 cmp_next_hrtimer_event(u64 basem, u64 expires)
 {
-	u64 nextevt = hrtimer_get_next_event();
+	u64 nextevt = hrtimer_get_next_event(NULL);
 
 	/*
 	 * If high resolution timers are enabled
-	 * hrtimer_get_next_event() returns KTIME_MAX.
+	 * hrtimer_get_next_event(NULL) returns KTIME_MAX.
 	 */
 	if (expires <= nextevt)
 		return expires;
