Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754114AbeCFXkP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 18:40:15 -0500
Received: from mx0a-00010702.pphosted.com ([148.163.156.75]:44716 "EHLO
        mx0b-00010702.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753923AbeCFXkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 18:40:10 -0500
From: Haris Okanovic <haris.okanovic@ni.com>
To: <linux-rt-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <haris.okanovic@ni.com>, <harisokn@gmail.com>, <bigeasy@linutronix.de>,
        <tglx@linutronix.de>, <julia.cartwright@ni.com>,
        <gratian.crisan@ni.com>, <anna-maria@linutronix.de>,
        <daniel@bristot.me>
Subject: [PATCH v4 2/2] timers: Don't search for expired timers while TIMER_SOFTIRQ is scheduled
Date: Tue, 6 Mar 2018 17:39:44 -0600
Message-ID: <20180306233944.11271-2-haris.okanovic@ni.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180306233944.11271-1-haris.okanovic@ni.com>
References: <alpine.DEB.2.20.1707182206110.2425@nanos>
 <20180306233944.11271-1-haris.okanovic@ni.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-06_13:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change avoid needlessly searching for more timers in
run_local_timers() (hard interrupt context) when they can't fire.
For example, when ktimersoftd/run_timer_softirq() is scheduled but
preempted due to cpu contention. When it runs, run_timer_softirq() will
discover newly expired timers up to current jiffies in addition to
firing previously expired timers.

However, this change also adds an edge case where non-hrtimer firing
is sometimes delayed by an additional tick. This is acceptable since we
don't make latency guarantees for non-hrtimers and would prefer to
minimize hard interrupt time instead.

Signed-off-by: Haris Okanovic <haris.okanovic@ni.com>
---
[PATCH v3]
 - Split block_softirq into separate commit
[PATCH v4]
 - Rebase onto v4.14.20-rt17

https://github.com/harisokanovic/linux/tree/dev/hokanovi/timer-peek-v6
---
 kernel/time/timer.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 98e952a6428d..5687e9bcf378 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -207,6 +207,7 @@ struct timer_base {
 	unsigned int		cpu;
 	bool			is_idle;
 	bool			must_forward_clk;
+	bool			block_softirq;
 	DECLARE_BITMAP(pending_map, WHEEL_SIZE);
 	struct hlist_head	vectors[WHEEL_SIZE];
 	struct hlist_head	expired_lists[LVL_DEPTH];
@@ -1404,9 +1405,11 @@ static int __collect_expired_timers(struct timer_base *base)
 
 	/*
 	 * expire_timers() must be called at least once before we can
-	 * collect more timers.
+	 * collect more timers. We should never hit this case unless
+	 * TIMER_SOFTIRQ got raised without expired timers.
 	 */
-	if (base->expired_levels)
+	if (WARN_ONCE(base->expired_levels,
+			"Must expire collected timers before collecting more"))
 		return base->expired_levels;
 
 	clk = base->clk;
@@ -1748,6 +1751,9 @@ static __latent_entropy void run_timer_softirq(struct softirq_action *h)
 	__run_timers(base);
 	if (IS_ENABLED(CONFIG_NO_HZ_COMMON))
 		__run_timers(this_cpu_ptr(&timer_bases[BASE_DEF]));
+
+	/* Allow new TIMER_SOFTIRQs to get scheduled by run_local_timers() */
+	base->block_softirq = false;
 }
 
 /*
@@ -1758,6 +1764,14 @@ void run_local_timers(void)
 	struct timer_base *base = this_cpu_ptr(&timer_bases[BASE_STD]);
 
 	hrtimer_run_queues();
+
+	/*
+	 * Skip if TIMER_SOFTIRQ is already running on this CPU, since it
+	 * will find and expire all timers up to current jiffies.
+	 */
+	if (base->block_softirq)
+		return;
+
 	/* Raise the softirq only if required. */
 	if (time_before(jiffies, base->clk) || !tick_find_expired(base)) {
 		if (!IS_ENABLED(CONFIG_NO_HZ_COMMON))
@@ -1766,7 +1780,10 @@ void run_local_timers(void)
 		base++;
 		if (time_before(jiffies, base->clk) || !tick_find_expired(base))
 			return;
+		base--;
 	}
+
+	base->block_softirq = true;
 	raise_softirq(TIMER_SOFTIRQ);
 }
 
-- 
2.15.1
