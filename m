Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751528AbeDDIzf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 04:55:35 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:55147 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751339AbeDDIxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 04:53:04 -0400
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
Subject: [PATCH v9 07/10] time: hrtimer: Introduce hrtimer_next_event_without()
Date: Wed, 04 Apr 2018 10:45:39 +0200
Message-ID: <101528364.6nGUqP0EsC@aspire.rjw.lan>
In-Reply-To: <1736751.LdhZHb50jq@aspire.rjw.lan>
References: <1736751.LdhZHb50jq@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The next set of changes will need to compute the time to the next
hrtimer event over all hrtimers except for the scheduler tick one.

To that end introduce a new helper function,
hrtimer_next_event_without(), for computing the time until the next
hrtimer event over all timers except for one and modify the underlying
code in __hrtimer_next_event_base() to prepare it for being called by
that new function.

No intentional changes in functionality.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v8 -> v9:
 * Make fewer changes to the existing code.
 * Add a new helper function for the handling of the use case at hand.

---
 include/linux/hrtimer.h |    1 
 kernel/time/hrtimer.c   |   55 ++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 54 insertions(+), 2 deletions(-)

Index: linux-pm/include/linux/hrtimer.h
===================================================================
--- linux-pm.orig/include/linux/hrtimer.h
+++ linux-pm/include/linux/hrtimer.h
@@ -426,6 +426,7 @@ static inline ktime_t hrtimer_get_remain
 }
 
 extern u64 hrtimer_get_next_event(void);
+extern u64 hrtimer_next_event_without(const struct hrtimer *exclude);
 
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
@@ -548,7 +564,8 @@ __hrtimer_get_next_event(struct hrtimer_
 	if (!cpu_base->softirq_activated && (active_mask & HRTIMER_ACTIVE_SOFT)) {
 		active = cpu_base->active_bases & HRTIMER_ACTIVE_SOFT;
 		cpu_base->softirq_next_timer = NULL;
-		expires_next = __hrtimer_next_event_base(cpu_base, active, KTIME_MAX);
+		expires_next = __hrtimer_next_event_base(cpu_base, NULL,
+							 active, KTIME_MAX);
 
 		next_timer = cpu_base->softirq_next_timer;
 	}
@@ -556,7 +573,8 @@ __hrtimer_get_next_event(struct hrtimer_
 	if (active_mask & HRTIMER_ACTIVE_HARD) {
 		active = cpu_base->active_bases & HRTIMER_ACTIVE_HARD;
 		cpu_base->next_timer = next_timer;
-		expires_next = __hrtimer_next_event_base(cpu_base, active, expires_next);
+		expires_next = __hrtimer_next_event_base(cpu_base, NULL, active,
+							 expires_next);
 	}
 
 	return expires_next;
@@ -1200,6 +1218,39 @@ u64 hrtimer_get_next_event(void)
 
 	raw_spin_unlock_irqrestore(&cpu_base->lock, flags);
 
+	return expires;
+}
+
+/**
+ * hrtimer_next_event_without - time until next expiry event w/o one timer
+ * @exclude:	timer to exclude
+ *
+ * Returns the next expiry time over all timers except for the @exclude one or
+ * KTIME_MAX if none of them is pending.
+ */
+u64 hrtimer_next_event_without(const struct hrtimer *exclude)
+{
+	struct hrtimer_cpu_base *cpu_base = this_cpu_ptr(&hrtimer_bases);
+	u64 expires = KTIME_MAX;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&cpu_base->lock, flags);
+
+	if (__hrtimer_hres_active(cpu_base)) {
+		unsigned int active;
+
+		if (!cpu_base->softirq_activated) {
+			active = cpu_base->active_bases & HRTIMER_ACTIVE_SOFT;
+			expires = __hrtimer_next_event_base(cpu_base, exclude,
+							    active, KTIME_MAX);
+		}
+		active = cpu_base->active_bases & HRTIMER_ACTIVE_HARD;
+		expires = __hrtimer_next_event_base(cpu_base, exclude, active,
+						    expires);
+	}
+
+	raw_spin_unlock_irqrestore(&cpu_base->lock, flags);
+
 	return expires;
 }
 #endif
