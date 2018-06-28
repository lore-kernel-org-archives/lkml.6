Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD95C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 16:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD3012767F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 16:41:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD3012767F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ni.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935655AbeF1QlM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 12:41:12 -0400
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:44608 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S935611AbeF1QlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 12:41:10 -0400
Received: from pps.filterd (m0098781.ppops.net [127.0.0.1])
        by mx0a-00010702.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5SGZuhL029674;
        Thu, 28 Jun 2018 11:40:47 -0500
Received: from ni.com (skprod2.natinst.com [130.164.80.23])
        by mx0a-00010702.pphosted.com with ESMTP id 2jw1pr8d6v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Jun 2018 11:40:47 -0500
Received: from us-aus-exch1.ni.corp.natinst.com (us-aus-exch1.ni.corp.natinst.com [130.164.68.11])
        by us-aus-skprod2.natinst.com (8.16.0.22/8.16.0.22) with ESMTPS id w5SGekuP018127
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 28 Jun 2018 11:40:46 -0500
Received: from us-aus-exhub1.ni.corp.natinst.com (130.164.68.41) by
 us-aus-exch1.ni.corp.natinst.com (130.164.68.11) with Microsoft SMTP Server
 (TLS) id 15.0.1156.6; Thu, 28 Jun 2018 11:40:46 -0500
Received: from harisdt.amer.corp.natinst.com (130.164.49.7) by
 us-aus-exhub1.ni.corp.natinst.com (130.164.68.41) with Microsoft SMTP Server
 id 15.0.1156.6 via Frontend Transport; Thu, 28 Jun 2018 11:40:46 -0500
From:   Haris Okanovic <haris.okanovic@ni.com>
To:     <linux-rt-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <haris.okanovic@ni.com>, <harisokn@gmail.com>,
        <bigeasy@linutronix.de>, <tglx@linutronix.de>,
        <julia.cartwright@ni.com>, <gratian.crisan@ni.com>,
        <anna-maria@linutronix.de>, <daniel@bristot.me>, <efault@gmx.de>
Subject: [PATCH v5 1/2] timers: Don't wake ktimersoftd on every tick
Date:   Thu, 28 Jun 2018 11:40:35 -0500
Message-ID: <20180628164036.27378-1-haris.okanovic@ni.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <7d21ff63-3dce-b8ea-a0f1-81d53617747d@ni.com>
References: <7d21ff63-3dce-b8ea-a0f1-81d53617747d@ni.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-28_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Collect expired timers in interrupt context to avoid overhead of waking
ktimersoftd on every scheduler tick.

This is implemented by storing lists of expired timers in the timer_base
struct, which is updated by the interrupt routing on each tick in
run_local_timers(). TIMER softirq (ktimersoftd) is then raised only when
one or more expired timers are collected.

Performance impact on a 2core Intel Atom E3825 system:
 * reduction in small latency spikes measured by cyclictest
 * ~30% fewer context-switches measured by perf
 * run_local_timers() execution time increases by 0.2 measured by TSC

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
[PATCH v5]
 - Fix hang when timer is rearmed with 0 offset in it's callback
 - Rewrite description

https://github.com/harisokanovic/linux/tree/dev/hokanovi/timer-peek-v7
---
 kernel/time/timer.c | 111 ++++++++++++++++++++++++++++++++------------
 1 file changed, 82 insertions(+), 29 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 96fd01c9f6b1..dd67c18c16d0 100644
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
+	int expired_levels = 0;
+
+	while (time_after_eq(end_clk, base->clk) && !expired_levels) {
+		expired_levels = collect_expired_timers(base);
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
2.17.1

