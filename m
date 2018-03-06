Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754001AbeCFXkI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 18:40:08 -0500
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:44686 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753504AbeCFXkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 18:40:06 -0500
From: Haris Okanovic <haris.okanovic@ni.com>
To: <linux-rt-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <haris.okanovic@ni.com>, <harisokn@gmail.com>, <bigeasy@linutronix.de>,
        <tglx@linutronix.de>, <julia.cartwright@ni.com>,
        <gratian.crisan@ni.com>, <anna-maria@linutronix.de>,
        <daniel@bristot.me>
Subject: [PATCH v4 1/2] timers: Don't wake ktimersoftd on every tick
Date: Tue, 6 Mar 2018 17:39:43 -0600
Message-ID: <20180306233944.11271-1-haris.okanovic@ni.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <alpine.DEB.2.20.1707182206110.2425@nanos>
References: <alpine.DEB.2.20.1707182206110.2425@nanos>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-06_13:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We recently upgraded from 4.1 to 4.6 and noticed a minor latency
regression caused by an additional thread wakeup (ktimersoftd) in
interrupt context on every tick. The wakeups are from
run_local_timers() raising TIMER_SOFTIRQ. Both TIMER and SCHED softirq
coalesced into one ksoftirqd wakeup prior to Sebastian's change to split
timers into their own thread.

There's already logic in run_local_timers() to avoid some unnecessary
wakeups of ksoftirqd, but it doesn't seems to catch them all. In
particular, I've seen many unnecessary wakeups when jiffies increments
prior to run_local_timers().

Change the way timers are collected per Julia and Thomas'
recommendation: Expired timers are now collected in interrupt context
and fired in ktimersoftd to avoid double-walk of `pending_map`.

Collect expired timers in interrupt context to avoid overhead of waking
ktimersoftd on every tick. ktimersoftd now wakes only when one or more
timers are ready, which yields a minor reduction in small latency
spikes measure by cyclictest.

Execution time of run_local_timers() increases by 0.2us to 2.5us as
measured by TSC on a 2core Intel Atom E3825 system.

This is implemented by storing lists of expired timers in timer_base,
updated on each tick. Any addition to the lists wakes ktimersoftd
(softirq) to process those timers.

Signed-off-by: Haris Okanovic <haris.okanovic@ni.com>
---
[PATCH v2] Applied Thomas Gleixner's suggestions:
 - Fix expired_count race
 - Remove unneeded base->clk lookahead
 - Return expired_count in collect_expired_timers()
 - Add block_softirq
 - Rebase to v4.11.8-rt5
[PATCH v3]
 - Fix cosmetic issues
 - Rename "count" to "levels" in timer_base and various functions
 - Move expired_levels and block_softirq to fill holes in timer_base
 - Remove READ_ONCE/WRITE_ONCE around block_softirq
[PATCH v4]
 - Rebase onto v4.14.20-rt17

https://github.com/harisokanovic/linux/tree/dev/hokanovi/timer-peek-v6
---
 kernel/time/timer.c | 111 ++++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 82 insertions(+), 29 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 96fd01c9f6b1..98e952a6428d 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -197,6 +197,7 @@ EXPORT_SYMBOL(jiffies_64);
 
 struct timer_base {
 	raw_spinlock_t		lock;
+	int					expired_levels;
 	struct timer_list	*running_timer;
 #ifdef CONFIG_PREEMPT_RT_FULL
 	struct swait_queue_head	wait_for_running_timer;
@@ -208,6 +209,7 @@ struct timer_base {
 	bool			must_forward_clk;
 	DECLARE_BITMAP(pending_map, WHEEL_SIZE);
 	struct hlist_head	vectors[WHEEL_SIZE];
+	struct hlist_head	expired_lists[LVL_DEPTH];
 } ____cacheline_aligned;
 
 static DEFINE_PER_CPU(struct timer_base, timer_bases[NR_BASES]);
@@ -1342,7 +1344,8 @@ static void call_timer_fn(struct timer_list *timer, void (*fn)(unsigned long),
 	}
 }
 
-static void expire_timers(struct timer_base *base, struct hlist_head *head)
+static void __expire_timers(struct timer_base *base,
+				   struct hlist_head *head)
 {
 	while (!hlist_empty(head)) {
 		struct timer_list *timer;
@@ -1372,21 +1375,49 @@ static void expire_timers(struct timer_base *base, struct hlist_head *head)
 	}
 }
 
-static int __collect_expired_timers(struct timer_base *base,
-				    struct hlist_head *heads)
+static void expire_timers(struct timer_base *base)
+{
+	struct hlist_head *head;
+	int levels = base->expired_levels;
+
+	while (levels--) {
+		head = base->expired_lists + levels;
+		__expire_timers(base, head);
+	}
+
+	/*
+	 * Zero base->expired_levels after processing all base->expired_lists
+	 * to signal it's ready to get re-populated. Otherwise, we race with
+	 * tick_find_expired() when base->lock is temporarily dropped in
+	 * __expire_timers()
+	 */
+	base->expired_levels = 0;
+}
+
+static int __collect_expired_timers(struct timer_base *base)
 {
-	unsigned long clk = base->clk;
 	struct hlist_head *vec;
-	int i, levels = 0;
+	struct hlist_head *expired_list = base->expired_lists;
+	unsigned long clk;
+	int i;
 	unsigned int idx;
 
+	/*
+	 * expire_timers() must be called at least once before we can
+	 * collect more timers.
+	 */
+	if (base->expired_levels)
+		return base->expired_levels;
+
+	clk = base->clk;
 	for (i = 0; i < LVL_DEPTH; i++) {
 		idx = (clk & LVL_MASK) + i * LVL_SIZE;
 
 		if (__test_and_clear_bit(idx, base->pending_map)) {
 			vec = base->vectors + idx;
-			hlist_move_list(vec, heads++);
-			levels++;
+			hlist_move_list(vec, expired_list);
+			base->expired_levels++;
+			expired_list++;
 		}
 		/* Is it time to look at the next level? */
 		if (clk & LVL_CLK_MASK)
@@ -1394,7 +1425,8 @@ static int __collect_expired_timers(struct timer_base *base,
 		/* Shift clock for the next level granularity */
 		clk >>= LVL_CLK_SHIFT;
 	}
-	return levels;
+
+	return base->expired_levels;
 }
 
 #ifdef CONFIG_NO_HZ_COMMON
@@ -1593,8 +1625,7 @@ void timer_clear_idle(void)
 	base->is_idle = false;
 }
 
-static int collect_expired_timers(struct timer_base *base,
-				  struct hlist_head *heads)
+static int collect_expired_timers(struct timer_base *base)
 {
 	/*
 	 * NOHZ optimization. After a long idle sleep we need to forward the
@@ -1615,16 +1646,47 @@ static int collect_expired_timers(struct timer_base *base,
 		}
 		base->clk = next;
 	}
-	return __collect_expired_timers(base, heads);
+	return __collect_expired_timers(base);
 }
 #else
-static inline int collect_expired_timers(struct timer_base *base,
-					 struct hlist_head *heads)
+static inline int collect_expired_timers(struct timer_base *base)
 {
-	return __collect_expired_timers(base, heads);
+	return __collect_expired_timers(base);
 }
 #endif
 
+/*
+ * Increments timer_base to current jiffies or until first expired
+ * timer is found. Return number of expired levels.
+ */
+static int find_expired_timers(struct timer_base *base)
+{
+	unsigned long int end_clk = jiffies;
+	int expired_levels;
+
+	while (!(expired_levels = collect_expired_timers(base)) &&
+			time_after_eq(end_clk, base->clk)) {
+		base->clk++;
+	}
+
+	return expired_levels;
+}
+
+/*
+ * Called from CPU tick routine to collect expired timers up to current
+ * jiffies. Return number of expired levels.
+ */
+static int tick_find_expired(struct timer_base *base)
+{
+	int levels;
+
+	raw_spin_lock(&base->lock);
+	levels = find_expired_timers(base);
+	raw_spin_unlock(&base->lock);
+
+	return levels;
+}
+
 /*
  * Called from the timer interrupt handler to charge one tick to the current
  * process.  user_tick is 1 if the tick is user time, 0 for system.
@@ -1652,22 +1714,12 @@ void update_process_times(int user_tick)
  */
 static inline void __run_timers(struct timer_base *base)
 {
-	struct hlist_head heads[LVL_DEPTH];
-	int levels;
-
-	if (!time_after_eq(jiffies, base->clk))
-		return;
-
 	raw_spin_lock_irq(&base->lock);
 
-	while (time_after_eq(jiffies, base->clk)) {
+	do {
+		expire_timers(base);
+	} while (find_expired_timers(base));
 
-		levels = collect_expired_timers(base, heads);
-		base->clk++;
-
-		while (levels--)
-			expire_timers(base, heads + levels);
-	}
 	raw_spin_unlock_irq(&base->lock);
 	wakeup_timer_waiters(base);
 }
@@ -1707,12 +1759,12 @@ void run_local_timers(void)
 
 	hrtimer_run_queues();
 	/* Raise the softirq only if required. */
-	if (time_before(jiffies, base->clk)) {
+	if (time_before(jiffies, base->clk) || !tick_find_expired(base)) {
 		if (!IS_ENABLED(CONFIG_NO_HZ_COMMON))
 			return;
 		/* CPU is awake, so check the deferrable base. */
 		base++;
-		if (time_before(jiffies, base->clk))
+		if (time_before(jiffies, base->clk) || !tick_find_expired(base))
 			return;
 	}
 	raise_softirq(TIMER_SOFTIRQ);
@@ -1887,6 +1939,7 @@ int timers_dead_cpu(unsigned int cpu)
 		raw_spin_lock_nested(&old_base->lock, SINGLE_DEPTH_NESTING);
 
 		BUG_ON(old_base->running_timer);
+		BUG_ON(old_base->expired_levels);
 
 		for (i = 0; i < WHEEL_SIZE; i++)
 			migrate_timer_list(new_base, old_base->vectors + i);
-- 
2.15.1
