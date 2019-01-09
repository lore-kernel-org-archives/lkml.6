Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCBACC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89591206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbfAIVTE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 16:19:04 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41866 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726072AbfAIVTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 16:19:01 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x09LIt2L067412
        for <linux-kernel@vger.kernel.org>; Wed, 9 Jan 2019 16:19:00 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2pwrq804gt-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 16:18:59 -0500
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 9 Jan 2019 21:18:59 -0000
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 9 Jan 2019 21:18:54 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x09LIrk815138974
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Jan 2019 21:18:53 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 26210B206E;
        Wed,  9 Jan 2019 21:18:53 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E5181B206B;
        Wed,  9 Jan 2019 21:18:52 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.88])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  9 Jan 2019 21:18:52 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 7DFC716C63FC; Wed,  9 Jan 2019 13:18:52 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 12/12] rcu: Discard separate per-CPU callback counts
Date:   Wed,  9 Jan 2019 13:18:50 -0800
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190109211830.GA30595@linux.ibm.com>
References: <20190109211830.GA30595@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19010921-0068-0000-0000-000003800514
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010374; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000274; SDB=6.01144142; UDB=6.00595706; IPR=6.00924404;
 MB=3.00025056; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-09 21:18:58
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010921-0069-0000-0000-000047121E1C
Message-Id: <20190109211850.31599-12-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-09_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901090170
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Back when there were multiple flavors of RCU, it was necessary to
separately count lazy and non-lazy callbacks for each CPU.  These counts
were used in CONFIG_RCU_FAST_NO_HZ kernels to determine how long a newly
idle CPU should be allowed to sleep before handling its RCU callbacks.
But now that there is only one flavor, the callback counts for a given
CPU's sole rcu_data structure are the counts for that CPU.

This commit therefore removes the rcu_data structure's ->nonlazy_posted
and ->nonlazy_posted_snap fields, the rcu_idle_count_callbacks_posted()
and rcu_cpu_has_callbacks() functions, repurposes the rcu_data structure's
->all_lazy field to record the laziness state at the beginning of the
latest idle sojourn, and modifies CONFIG_RCU_FAST_NO_HZ RCU CPU stall
warnings accordingly.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 Documentation/RCU/stallwarn.txt | 15 +++++-----
 kernel/rcu/tree.c               | 25 -----------------
 kernel/rcu/tree.h               |  6 +---
 kernel/rcu/tree_plugin.h        | 50 ++++++++-------------------------
 4 files changed, 21 insertions(+), 75 deletions(-)

diff --git a/Documentation/RCU/stallwarn.txt b/Documentation/RCU/stallwarn.txt
index 073dbc12d1ea..1ab70c37921f 100644
--- a/Documentation/RCU/stallwarn.txt
+++ b/Documentation/RCU/stallwarn.txt
@@ -219,17 +219,18 @@ an estimate of the total number of RCU callbacks queued across all CPUs
 In kernels with CONFIG_RCU_FAST_NO_HZ, more information is printed
 for each CPU:
 
-	0: (64628 ticks this GP) idle=dd5/3fffffffffffffff/0 softirq=82/543 last_accelerate: a345/d342 nonlazy_posted: 25 .D
+	0: (64628 ticks this GP) idle=dd5/3fffffffffffffff/0 softirq=82/543 last_accelerate: a345/d342 Nonlazy posted: ..D
 
 The "last_accelerate:" prints the low-order 16 bits (in hex) of the
 jiffies counter when this CPU last invoked rcu_try_advance_all_cbs()
 from rcu_needs_cpu() or last invoked rcu_accelerate_cbs() from
-rcu_prepare_for_idle().  The "nonlazy_posted:" prints the number
-of non-lazy callbacks posted since the last call to rcu_needs_cpu().
-Finally, an "L" indicates that there are currently no non-lazy callbacks
-("." is printed otherwise, as shown above) and "D" indicates that
-dyntick-idle processing is enabled ("." is printed otherwise, for example,
-if disabled via the "nohz=" kernel boot parameter).
+rcu_prepare_for_idle().  The "Nonlazy posted:" indicates lazy-callback
+status, so that an "l" indicates that all callbacks were lazy at the start
+of the last idle period and an "L" indicates that there are currently
+no non-lazy callbacks (in both cases, "." is printed otherwise, as
+shown above) and "D" indicates that dyntick-idle processing is enabled
+("." is printed otherwise, for example, if disabled via the "nohz="
+kernel boot parameter).
 
 If the grace period ends just as the stall warning starts printing,
 there will be a spurious stall-warning message, which will include
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index e2bd42b2b563..e53a586b397b 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2878,9 +2878,6 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func, int cpu, bool lazy)
 			rcu_segcblist_init(&rdp->cblist);
 	}
 	rcu_segcblist_enqueue(&rdp->cblist, head, lazy);
-	if (!lazy)
-		rcu_idle_count_callbacks_posted();
-
 	if (__is_kfree_rcu_offset((unsigned long)func))
 		trace_rcu_kfree_callback(rcu_state.name, head,
 					 (unsigned long)func,
@@ -3110,28 +3107,6 @@ static int rcu_pending(void)
 	return 0;
 }
 
-/*
- * Return true if the specified CPU has any callback.  If all_lazy is
- * non-NULL, store an indication of whether all callbacks are lazy.
- * (If there are no callbacks, all of them are deemed to be lazy.)
- */
-static bool rcu_cpu_has_callbacks(bool *all_lazy)
-{
-	bool al = true;
-	bool hc = false;
-	struct rcu_data *rdp;
-
-	rdp = this_cpu_ptr(&rcu_data);
-	if (!rcu_segcblist_empty(&rdp->cblist)) {
-		hc = true;
-		if (rcu_segcblist_n_nonlazy_cbs(&rdp->cblist))
-			al = false;
-	}
-	if (all_lazy)
-		*all_lazy = al;
-	return hc;
-}
-
 /*
  * Helper function for rcu_barrier() tracing.  If tracing is disabled,
  * the compiler is expected to optimize this away.
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 50bb41cdc5fb..20feecbb0ab6 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -193,10 +193,7 @@ struct rcu_data {
 	bool rcu_need_heavy_qs;		/* GP old, so heavy quiescent state! */
 	bool rcu_urgent_qs;		/* GP old need light quiescent state. */
 #ifdef CONFIG_RCU_FAST_NO_HZ
-	bool all_lazy;			/* Are all CPU's CBs lazy? */
-	unsigned long nonlazy_posted;	/* # times non-lazy CB posted to CPU. */
-	unsigned long nonlazy_posted_snap;
-					/* Nonlazy_posted snapshot. */
+	bool all_lazy;			/* All CPU's CBs lazy at idle start? */
 	unsigned long last_accelerate;	/* Last jiffy CBs were accelerated. */
 	unsigned long last_advance_all;	/* Last jiffy CBs were all advanced. */
 	int tick_nohz_enabled_snap;	/* Previously seen value from sysfs. */
@@ -430,7 +427,6 @@ static void __init rcu_spawn_boost_kthreads(void);
 static void rcu_prepare_kthreads(int cpu);
 static void rcu_cleanup_after_idle(void);
 static void rcu_prepare_for_idle(void);
-static void rcu_idle_count_callbacks_posted(void);
 static bool rcu_preempt_has_tasks(struct rcu_node *rnp);
 static bool rcu_preempt_need_deferred_qs(struct task_struct *t);
 static void rcu_preempt_deferred_qs(struct task_struct *t);
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 43f3f2ee9d63..abd238c70900 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1474,7 +1474,7 @@ static void rcu_prepare_kthreads(int cpu)
 int rcu_needs_cpu(u64 basemono, u64 *nextevt)
 {
 	*nextevt = KTIME_MAX;
-	return rcu_cpu_has_callbacks(NULL);
+	return !rcu_segcblist_empty(&this_cpu_ptr(&rcu_data)->cblist);
 }
 
 /*
@@ -1493,14 +1493,6 @@ static void rcu_prepare_for_idle(void)
 {
 }
 
-/*
- * Don't bother keeping a running count of the number of RCU callbacks
- * posted because CONFIG_RCU_FAST_NO_HZ=n.
- */
-static void rcu_idle_count_callbacks_posted(void)
-{
-}
-
 #else /* #if !defined(CONFIG_RCU_FAST_NO_HZ) */
 
 /*
@@ -1583,11 +1575,8 @@ int rcu_needs_cpu(u64 basemono, u64 *nextevt)
 
 	lockdep_assert_irqs_disabled();
 
-	/* Snapshot to detect later posting of non-lazy callback. */
-	rdp->nonlazy_posted_snap = rdp->nonlazy_posted;
-
 	/* If no callbacks, RCU doesn't need the CPU. */
-	if (!rcu_cpu_has_callbacks(&rdp->all_lazy)) {
+	if (rcu_segcblist_empty(&rdp->cblist)) {
 		*nextevt = KTIME_MAX;
 		return 0;
 	}
@@ -1601,11 +1590,12 @@ int rcu_needs_cpu(u64 basemono, u64 *nextevt)
 	rdp->last_accelerate = jiffies;
 
 	/* Request timer delay depending on laziness, and round. */
-	if (!rdp->all_lazy) {
+	rdp->all_lazy = !rcu_segcblist_n_nonlazy_cbs(&rdp->cblist);
+	if (rdp->all_lazy) {
+		dj = round_jiffies(rcu_idle_lazy_gp_delay + jiffies) - jiffies;
+	} else {
 		dj = round_up(rcu_idle_gp_delay + jiffies,
 			       rcu_idle_gp_delay) - jiffies;
-	} else {
-		dj = round_jiffies(rcu_idle_lazy_gp_delay + jiffies) - jiffies;
 	}
 	*nextevt = basemono + dj * TICK_NSEC;
 	return 0;
@@ -1635,7 +1625,7 @@ static void rcu_prepare_for_idle(void)
 	/* Handle nohz enablement switches conservatively. */
 	tne = READ_ONCE(tick_nohz_active);
 	if (tne != rdp->tick_nohz_enabled_snap) {
-		if (rcu_cpu_has_callbacks(NULL))
+		if (!rcu_segcblist_empty(&rdp->cblist))
 			invoke_rcu_core(); /* force nohz to see update. */
 		rdp->tick_nohz_enabled_snap = tne;
 		return;
@@ -1648,10 +1638,8 @@ static void rcu_prepare_for_idle(void)
 	 * callbacks, invoke RCU core for the side-effect of recalculating
 	 * idle duration on re-entry to idle.
 	 */
-	if (rdp->all_lazy &&
-	    rdp->nonlazy_posted != rdp->nonlazy_posted_snap) {
+	if (rdp->all_lazy && rcu_segcblist_n_nonlazy_cbs(&rdp->cblist)) {
 		rdp->all_lazy = false;
-		rdp->nonlazy_posted_snap = rdp->nonlazy_posted;
 		invoke_rcu_core();
 		return;
 	}
@@ -1687,19 +1675,6 @@ static void rcu_cleanup_after_idle(void)
 		invoke_rcu_core();
 }
 
-/*
- * Keep a running count of the number of non-lazy callbacks posted
- * on this CPU.  This running counter (which is never decremented) allows
- * rcu_prepare_for_idle() to detect when something out of the idle loop
- * posts a callback, even if an equal number of callbacks are invoked.
- * Of course, callbacks should only be posted from within a trace event
- * designed to be called from idle or from within RCU_NONIDLE().
- */
-static void rcu_idle_count_callbacks_posted(void)
-{
-	__this_cpu_add(rcu_data.nonlazy_posted, 1);
-}
-
 #endif /* #else #if !defined(CONFIG_RCU_FAST_NO_HZ) */
 
 #ifdef CONFIG_RCU_FAST_NO_HZ
@@ -1707,13 +1682,12 @@ static void rcu_idle_count_callbacks_posted(void)
 static void print_cpu_stall_fast_no_hz(char *cp, int cpu)
 {
 	struct rcu_data *rdp = &per_cpu(rcu_data, cpu);
-	unsigned long nlpd = rdp->nonlazy_posted - rdp->nonlazy_posted_snap;
 
-	sprintf(cp, "last_accelerate: %04lx/%04lx, nonlazy_posted: %ld, %c%c",
+	sprintf(cp, "last_accelerate: %04lx/%04lx, Nonlazy posted: %c%c%c",
 		rdp->last_accelerate & 0xffff, jiffies & 0xffff,
-		ulong2long(nlpd),
-		rdp->all_lazy ? 'L' : '.',
-		rdp->tick_nohz_enabled_snap ? '.' : 'D');
+		".l"[rdp->all_lazy],
+		".L"[!rcu_segcblist_n_nonlazy_cbs(&rdp->cblist)],
+		".D"[!rdp->tick_nohz_enabled_snap]);
 }
 
 #else /* #ifdef CONFIG_RCU_FAST_NO_HZ */
-- 
2.17.1

