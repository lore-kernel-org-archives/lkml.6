Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8159C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BFDE20644
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:39:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BFDE20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbeH3CiM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 22:38:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36360 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727749AbeH3CiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 22:38:10 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7TMcj9o108193
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:39:05 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m61rcwq57-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:39:05 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 29 Aug 2018 18:39:04 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 29 Aug 2018 18:38:59 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7TMcvgF14286942
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Aug 2018 22:38:57 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9ED12B2076;
        Wed, 29 Aug 2018 18:37:53 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6CEC0B206B;
        Wed, 29 Aug 2018 18:37:53 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 29 Aug 2018 18:37:53 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 90DB116C91EA; Wed, 29 Aug 2018 15:38:56 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 39/52] rcu: Remove rsp parameter from expedited grace-period functions
Date:   Wed, 29 Aug 2018 15:38:41 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829223830.GA1800@linux.vnet.ibm.com>
References: <20180829223830.GA1800@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18082922-0068-0000-0000-00000331B958
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009636; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01080744; UDB=6.00557497; IPR=6.00860730;
 MB=3.00023002; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-29 22:39:02
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082922-0069-0000-0000-0000458F161D
Message-Id: <20180829223854.4055-39-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-29_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808290220
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There now is only one rcu_state structure in a given build of the
Linux kernel, so there is no need to pass it as a parameter to
RCU's functions.  This commit therefore removes the rsp parameter
from the code in kernel/rcu/tree_exp.h, and removes all of the
rsp local variables while in the area.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree.c        |   4 +-
 kernel/rcu/tree.h        |   1 -
 kernel/rcu/tree_exp.h    | 185 ++++++++++++++++++---------------------
 kernel/rcu/tree_plugin.h |  13 ++-
 4 files changed, 94 insertions(+), 109 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 6d8e4a4d8019..c3031b566851 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -139,7 +139,7 @@ static void rcu_cleanup_dead_rnp(struct rcu_node *rnp_leaf);
 static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp, int outgoingcpu);
 static void invoke_rcu_core(void);
 static void invoke_rcu_callbacks(struct rcu_data *rdp);
-static void rcu_report_exp_rdp(struct rcu_state *rsp, struct rcu_data *rdp);
+static void rcu_report_exp_rdp(struct rcu_data *rdp);
 static void sync_sched_exp_online_cleanup(int cpu);
 
 /* rcuc/rcub kthread realtime priority */
@@ -3552,7 +3552,7 @@ void rcu_report_dead(unsigned int cpu)
 
 	/* QS for any half-done expedited RCU-sched GP. */
 	preempt_disable();
-	rcu_report_exp_rdp(&rcu_state, this_cpu_ptr(&rcu_data));
+	rcu_report_exp_rdp(this_cpu_ptr(&rcu_data));
 	preempt_enable();
 	rcu_preempt_deferred_qs(current);
 
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 7c6033d71e9d..b21d79bdab23 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -61,7 +61,6 @@ struct rcu_dynticks {
 /* Communicate arguments to a workqueue handler. */
 struct rcu_exp_work {
 	smp_call_func_t rew_func;
-	struct rcu_state *rew_rsp;
 	unsigned long rew_s;
 	struct work_struct rew_work;
 };
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 0bcbb03c9702..b6f7bc34ac49 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -25,39 +25,39 @@
 /*
  * Record the start of an expedited grace period.
  */
-static void rcu_exp_gp_seq_start(struct rcu_state *rsp)
+static void rcu_exp_gp_seq_start(void)
 {
-	rcu_seq_start(&rsp->expedited_sequence);
+	rcu_seq_start(&rcu_state.expedited_sequence);
 }
 
 /*
  * Return then value that expedited-grace-period counter will have
  * at the end of the current grace period.
  */
-static __maybe_unused unsigned long rcu_exp_gp_seq_endval(struct rcu_state *rsp)
+static __maybe_unused unsigned long rcu_exp_gp_seq_endval(void)
 {
-	return rcu_seq_endval(&rsp->expedited_sequence);
+	return rcu_seq_endval(&rcu_state.expedited_sequence);
 }
 
 /*
  * Record the end of an expedited grace period.
  */
-static void rcu_exp_gp_seq_end(struct rcu_state *rsp)
+static void rcu_exp_gp_seq_end(void)
 {
-	rcu_seq_end(&rsp->expedited_sequence);
+	rcu_seq_end(&rcu_state.expedited_sequence);
 	smp_mb(); /* Ensure that consecutive grace periods serialize. */
 }
 
 /*
  * Take a snapshot of the expedited-grace-period counter.
  */
-static unsigned long rcu_exp_gp_seq_snap(struct rcu_state *rsp)
+static unsigned long rcu_exp_gp_seq_snap(void)
 {
 	unsigned long s;
 
 	smp_mb(); /* Caller's modifications seen first by other CPUs. */
-	s = rcu_seq_snap(&rsp->expedited_sequence);
-	trace_rcu_exp_grace_period(rsp->name, s, TPS("snap"));
+	s = rcu_seq_snap(&rcu_state.expedited_sequence);
+	trace_rcu_exp_grace_period(rcu_state.name, s, TPS("snap"));
 	return s;
 }
 
@@ -66,9 +66,9 @@ static unsigned long rcu_exp_gp_seq_snap(struct rcu_state *rsp)
  * if a full expedited grace period has elapsed since that snapshot
  * was taken.
  */
-static bool rcu_exp_gp_seq_done(struct rcu_state *rsp, unsigned long s)
+static bool rcu_exp_gp_seq_done(unsigned long s)
 {
-	return rcu_seq_done(&rsp->expedited_sequence, s);
+	return rcu_seq_done(&rcu_state.expedited_sequence, s);
 }
 
 /*
@@ -78,26 +78,26 @@ static bool rcu_exp_gp_seq_done(struct rcu_state *rsp, unsigned long s)
  * ever been online.  This means that this function normally takes its
  * no-work-to-do fastpath.
  */
-static void sync_exp_reset_tree_hotplug(struct rcu_state *rsp)
+static void sync_exp_reset_tree_hotplug(void)
 {
 	bool done;
 	unsigned long flags;
 	unsigned long mask;
 	unsigned long oldmask;
-	int ncpus = smp_load_acquire(&rsp->ncpus); /* Order against locking. */
+	int ncpus = smp_load_acquire(&rcu_state.ncpus); /* Order vs. locking. */
 	struct rcu_node *rnp;
 	struct rcu_node *rnp_up;
 
 	/* If no new CPUs onlined since last time, nothing to do. */
-	if (likely(ncpus == rsp->ncpus_snap))
+	if (likely(ncpus == rcu_state.ncpus_snap))
 		return;
-	rsp->ncpus_snap = ncpus;
+	rcu_state.ncpus_snap = ncpus;
 
 	/*
 	 * Each pass through the following loop propagates newly onlined
 	 * CPUs for the current rcu_node structure up the rcu_node tree.
 	 */
-	rcu_for_each_leaf_node(rsp, rnp) {
+	rcu_for_each_leaf_node(&rcu_state, rnp) {
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
 		if (rnp->expmaskinit == rnp->expmaskinitnext) {
 			raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
@@ -135,13 +135,13 @@ static void sync_exp_reset_tree_hotplug(struct rcu_state *rsp)
  * Reset the ->expmask values in the rcu_node tree in preparation for
  * a new expedited grace period.
  */
-static void __maybe_unused sync_exp_reset_tree(struct rcu_state *rsp)
+static void __maybe_unused sync_exp_reset_tree(void)
 {
 	unsigned long flags;
 	struct rcu_node *rnp;
 
-	sync_exp_reset_tree_hotplug(rsp);
-	rcu_for_each_node_breadth_first(rsp, rnp) {
+	sync_exp_reset_tree_hotplug();
+	rcu_for_each_node_breadth_first(&rcu_state, rnp) {
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
 		WARN_ON_ONCE(rnp->expmask);
 		rnp->expmask = rnp->expmaskinit;
@@ -194,7 +194,7 @@ static bool sync_rcu_preempt_exp_done_unlocked(struct rcu_node *rnp)
  *
  * Caller must hold the specified rcu_node structure's ->lock.
  */
-static void __rcu_report_exp_rnp(struct rcu_state *rsp, struct rcu_node *rnp,
+static void __rcu_report_exp_rnp(struct rcu_node *rnp,
 				 bool wake, unsigned long flags)
 	__releases(rnp->lock)
 {
@@ -212,7 +212,7 @@ static void __rcu_report_exp_rnp(struct rcu_state *rsp, struct rcu_node *rnp,
 			raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 			if (wake) {
 				smp_mb(); /* EGP done before wake_up(). */
-				swake_up_one(&rsp->expedited_wq);
+				swake_up_one(&rcu_state.expedited_wq);
 			}
 			break;
 		}
@@ -229,20 +229,19 @@ static void __rcu_report_exp_rnp(struct rcu_state *rsp, struct rcu_node *rnp,
  * Report expedited quiescent state for specified node.  This is a
  * lock-acquisition wrapper function for __rcu_report_exp_rnp().
  */
-static void __maybe_unused rcu_report_exp_rnp(struct rcu_state *rsp,
-					      struct rcu_node *rnp, bool wake)
+static void __maybe_unused rcu_report_exp_rnp(struct rcu_node *rnp, bool wake)
 {
 	unsigned long flags;
 
 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
-	__rcu_report_exp_rnp(rsp, rnp, wake, flags);
+	__rcu_report_exp_rnp(rnp, wake, flags);
 }
 
 /*
  * Report expedited quiescent state for multiple CPUs, all covered by the
  * specified leaf rcu_node structure.
  */
-static void rcu_report_exp_cpu_mult(struct rcu_state *rsp, struct rcu_node *rnp,
+static void rcu_report_exp_cpu_mult(struct rcu_node *rnp,
 				    unsigned long mask, bool wake)
 {
 	unsigned long flags;
@@ -253,23 +252,23 @@ static void rcu_report_exp_cpu_mult(struct rcu_state *rsp, struct rcu_node *rnp,
 		return;
 	}
 	rnp->expmask &= ~mask;
-	__rcu_report_exp_rnp(rsp, rnp, wake, flags); /* Releases rnp->lock. */
+	__rcu_report_exp_rnp(rnp, wake, flags); /* Releases rnp->lock. */
 }
 
 /*
  * Report expedited quiescent state for specified rcu_data (CPU).
  */
-static void rcu_report_exp_rdp(struct rcu_state *rsp, struct rcu_data *rdp)
+static void rcu_report_exp_rdp(struct rcu_data *rdp)
 {
 	WRITE_ONCE(rdp->deferred_qs, false);
-	rcu_report_exp_cpu_mult(rsp, rdp->mynode, rdp->grpmask, true);
+	rcu_report_exp_cpu_mult(rdp->mynode, rdp->grpmask, true);
 }
 
 /* Common code for work-done checking. */
-static bool sync_exp_work_done(struct rcu_state *rsp, unsigned long s)
+static bool sync_exp_work_done(unsigned long s)
 {
-	if (rcu_exp_gp_seq_done(rsp, s)) {
-		trace_rcu_exp_grace_period(rsp->name, s, TPS("done"));
+	if (rcu_exp_gp_seq_done(s)) {
+		trace_rcu_exp_grace_period(rcu_state.name, s, TPS("done"));
 		/* Ensure test happens before caller kfree(). */
 		smp_mb__before_atomic(); /* ^^^ */
 		return true;
@@ -284,7 +283,7 @@ static bool sync_exp_work_done(struct rcu_state *rsp, unsigned long s)
  * with the mutex held, indicating that the caller must actually do the
  * expedited grace period.
  */
-static bool exp_funnel_lock(struct rcu_state *rsp, unsigned long s)
+static bool exp_funnel_lock(unsigned long s)
 {
 	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, raw_smp_processor_id());
 	struct rcu_node *rnp = rdp->mynode;
@@ -294,18 +293,18 @@ static bool exp_funnel_lock(struct rcu_state *rsp, unsigned long s)
 	if (ULONG_CMP_LT(READ_ONCE(rnp->exp_seq_rq), s) &&
 	    (rnp == rnp_root ||
 	     ULONG_CMP_LT(READ_ONCE(rnp_root->exp_seq_rq), s)) &&
-	    mutex_trylock(&rsp->exp_mutex))
+	    mutex_trylock(&rcu_state.exp_mutex))
 		goto fastpath;
 
 	/*
 	 * Each pass through the following loop works its way up
 	 * the rcu_node tree, returning if others have done the work or
-	 * otherwise falls through to acquire rsp->exp_mutex.  The mapping
+	 * otherwise falls through to acquire ->exp_mutex.  The mapping
 	 * from CPU to rcu_node structure can be inexact, as it is just
 	 * promoting locality and is not strictly needed for correctness.
 	 */
 	for (; rnp != NULL; rnp = rnp->parent) {
-		if (sync_exp_work_done(rsp, s))
+		if (sync_exp_work_done(s))
 			return true;
 
 		/* Work not done, either wait here or go up. */
@@ -314,26 +313,26 @@ static bool exp_funnel_lock(struct rcu_state *rsp, unsigned long s)
 
 			/* Someone else doing GP, so wait for them. */
 			spin_unlock(&rnp->exp_lock);
-			trace_rcu_exp_funnel_lock(rsp->name, rnp->level,
+			trace_rcu_exp_funnel_lock(rcu_state.name, rnp->level,
 						  rnp->grplo, rnp->grphi,
 						  TPS("wait"));
 			wait_event(rnp->exp_wq[rcu_seq_ctr(s) & 0x3],
-				   sync_exp_work_done(rsp, s));
+				   sync_exp_work_done(s));
 			return true;
 		}
 		rnp->exp_seq_rq = s; /* Followers can wait on us. */
 		spin_unlock(&rnp->exp_lock);
-		trace_rcu_exp_funnel_lock(rsp->name, rnp->level, rnp->grplo,
-					  rnp->grphi, TPS("nxtlvl"));
+		trace_rcu_exp_funnel_lock(rcu_state.name, rnp->level,
+					  rnp->grplo, rnp->grphi, TPS("nxtlvl"));
 	}
-	mutex_lock(&rsp->exp_mutex);
+	mutex_lock(&rcu_state.exp_mutex);
 fastpath:
-	if (sync_exp_work_done(rsp, s)) {
-		mutex_unlock(&rsp->exp_mutex);
+	if (sync_exp_work_done(s)) {
+		mutex_unlock(&rcu_state.exp_mutex);
 		return true;
 	}
-	rcu_exp_gp_seq_start(rsp);
-	trace_rcu_exp_grace_period(rsp->name, s, TPS("start"));
+	rcu_exp_gp_seq_start();
+	trace_rcu_exp_grace_period(rcu_state.name, s, TPS("start"));
 	return false;
 }
 
@@ -352,7 +351,6 @@ static void sync_rcu_exp_select_node_cpus(struct work_struct *wp)
 	struct rcu_exp_work *rewp =
 		container_of(wp, struct rcu_exp_work, rew_work);
 	struct rcu_node *rnp = container_of(rewp, struct rcu_node, rew);
-	struct rcu_state *rsp = rewp->rew_rsp;
 
 	func = rewp->rew_func;
 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
@@ -400,7 +398,7 @@ static void sync_rcu_exp_select_node_cpus(struct work_struct *wp)
 			mask_ofl_test |= mask;
 			continue;
 		}
-		ret = smp_call_function_single(cpu, func, rsp, 0);
+		ret = smp_call_function_single(cpu, func, NULL, 0);
 		if (!ret) {
 			mask_ofl_ipi &= ~mask;
 			continue;
@@ -411,7 +409,7 @@ static void sync_rcu_exp_select_node_cpus(struct work_struct *wp)
 		    (rnp->expmask & mask)) {
 			/* Online, so delay for a bit and try again. */
 			raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
-			trace_rcu_exp_grace_period(rsp->name, rcu_exp_gp_seq_endval(rsp), TPS("selectofl"));
+			trace_rcu_exp_grace_period(rcu_state.name, rcu_exp_gp_seq_endval(), TPS("selectofl"));
 			schedule_timeout_uninterruptible(1);
 			goto retry_ipi;
 		}
@@ -423,33 +421,31 @@ static void sync_rcu_exp_select_node_cpus(struct work_struct *wp)
 	/* Report quiescent states for those that went offline. */
 	mask_ofl_test |= mask_ofl_ipi;
 	if (mask_ofl_test)
-		rcu_report_exp_cpu_mult(rsp, rnp, mask_ofl_test, false);
+		rcu_report_exp_cpu_mult(rnp, mask_ofl_test, false);
 }
 
 /*
  * Select the nodes that the upcoming expedited grace period needs
  * to wait for.
  */
-static void sync_rcu_exp_select_cpus(struct rcu_state *rsp,
-				     smp_call_func_t func)
+static void sync_rcu_exp_select_cpus(smp_call_func_t func)
 {
 	int cpu;
 	struct rcu_node *rnp;
 
-	trace_rcu_exp_grace_period(rsp->name, rcu_exp_gp_seq_endval(rsp), TPS("reset"));
-	sync_exp_reset_tree(rsp);
-	trace_rcu_exp_grace_period(rsp->name, rcu_exp_gp_seq_endval(rsp), TPS("select"));
+	trace_rcu_exp_grace_period(rcu_state.name, rcu_exp_gp_seq_endval(), TPS("reset"));
+	sync_exp_reset_tree();
+	trace_rcu_exp_grace_period(rcu_state.name, rcu_exp_gp_seq_endval(), TPS("select"));
 
 	/* Schedule work for each leaf rcu_node structure. */
-	rcu_for_each_leaf_node(rsp, rnp) {
+	rcu_for_each_leaf_node(&rcu_state, rnp) {
 		rnp->exp_need_flush = false;
 		if (!READ_ONCE(rnp->expmask))
 			continue; /* Avoid early boot non-existent wq. */
 		rnp->rew.rew_func = func;
-		rnp->rew.rew_rsp = rsp;
 		if (!READ_ONCE(rcu_par_gp_wq) ||
 		    rcu_scheduler_active != RCU_SCHEDULER_RUNNING ||
-		    rcu_is_last_leaf_node(rsp, rnp)) {
+		    rcu_is_last_leaf_node(&rcu_state, rnp)) {
 			/* No workqueues yet or last leaf, do direct call. */
 			sync_rcu_exp_select_node_cpus(&rnp->rew.rew_work);
 			continue;
@@ -466,12 +462,12 @@ static void sync_rcu_exp_select_cpus(struct rcu_state *rsp,
 	}
 
 	/* Wait for workqueue jobs (if any) to complete. */
-	rcu_for_each_leaf_node(rsp, rnp)
+	rcu_for_each_leaf_node(&rcu_state, rnp)
 		if (rnp->exp_need_flush)
 			flush_work(&rnp->rew.rew_work);
 }
 
-static void synchronize_sched_expedited_wait(struct rcu_state *rsp)
+static void synchronize_sched_expedited_wait(void)
 {
 	int cpu;
 	unsigned long jiffies_stall;
@@ -482,13 +478,13 @@ static void synchronize_sched_expedited_wait(struct rcu_state *rsp)
 	struct rcu_node *rnp_root = rcu_get_root();
 	int ret;
 
-	trace_rcu_exp_grace_period(rsp->name, rcu_exp_gp_seq_endval(rsp), TPS("startwait"));
+	trace_rcu_exp_grace_period(rcu_state.name, rcu_exp_gp_seq_endval(), TPS("startwait"));
 	jiffies_stall = rcu_jiffies_till_stall_check();
 	jiffies_start = jiffies;
 
 	for (;;) {
 		ret = swait_event_timeout_exclusive(
-				rsp->expedited_wq,
+				rcu_state.expedited_wq,
 				sync_rcu_preempt_exp_done_unlocked(rnp_root),
 				jiffies_stall);
 		if (ret > 0 || sync_rcu_preempt_exp_done_unlocked(rnp_root))
@@ -498,9 +494,9 @@ static void synchronize_sched_expedited_wait(struct rcu_state *rsp)
 			continue;
 		panic_on_rcu_stall();
 		pr_err("INFO: %s detected expedited stalls on CPUs/tasks: {",
-		       rsp->name);
+		       rcu_state.name);
 		ndetected = 0;
-		rcu_for_each_leaf_node(rsp, rnp) {
+		rcu_for_each_leaf_node(&rcu_state, rnp) {
 			ndetected += rcu_print_task_exp_stall(rnp);
 			for_each_leaf_node_possible_cpu(rnp, cpu) {
 				struct rcu_data *rdp;
@@ -517,11 +513,11 @@ static void synchronize_sched_expedited_wait(struct rcu_state *rsp)
 			}
 		}
 		pr_cont(" } %lu jiffies s: %lu root: %#lx/%c\n",
-			jiffies - jiffies_start, rsp->expedited_sequence,
+			jiffies - jiffies_start, rcu_state.expedited_sequence,
 			rnp_root->expmask, ".T"[!!rnp_root->exp_tasks]);
 		if (ndetected) {
 			pr_err("blocking rcu_node structures:");
-			rcu_for_each_node_breadth_first(rsp, rnp) {
+			rcu_for_each_node_breadth_first(&rcu_state, rnp) {
 				if (rnp == rnp_root)
 					continue; /* printed unconditionally */
 				if (sync_rcu_preempt_exp_done_unlocked(rnp))
@@ -533,7 +529,7 @@ static void synchronize_sched_expedited_wait(struct rcu_state *rsp)
 			}
 			pr_cont("\n");
 		}
-		rcu_for_each_leaf_node(rsp, rnp) {
+		rcu_for_each_leaf_node(&rcu_state, rnp) {
 			for_each_leaf_node_possible_cpu(rnp, cpu) {
 				mask = leaf_node_cpu_bit(rnp, cpu);
 				if (!(rnp->expmask & mask))
@@ -551,21 +547,21 @@ static void synchronize_sched_expedited_wait(struct rcu_state *rsp)
  * grace period.  Also update all the ->exp_seq_rq counters as needed
  * in order to avoid counter-wrap problems.
  */
-static void rcu_exp_wait_wake(struct rcu_state *rsp, unsigned long s)
+static void rcu_exp_wait_wake(unsigned long s)
 {
 	struct rcu_node *rnp;
 
-	synchronize_sched_expedited_wait(rsp);
-	rcu_exp_gp_seq_end(rsp);
-	trace_rcu_exp_grace_period(rsp->name, s, TPS("end"));
+	synchronize_sched_expedited_wait();
+	rcu_exp_gp_seq_end();
+	trace_rcu_exp_grace_period(rcu_state.name, s, TPS("end"));
 
 	/*
 	 * Switch over to wakeup mode, allowing the next GP, but -only- the
 	 * next GP, to proceed.
 	 */
-	mutex_lock(&rsp->exp_wake_mutex);
+	mutex_lock(&rcu_state.exp_wake_mutex);
 
-	rcu_for_each_node_breadth_first(rsp, rnp) {
+	rcu_for_each_node_breadth_first(&rcu_state, rnp) {
 		if (ULONG_CMP_LT(READ_ONCE(rnp->exp_seq_rq), s)) {
 			spin_lock(&rnp->exp_lock);
 			/* Recheck, avoid hang in case someone just arrived. */
@@ -574,24 +570,23 @@ static void rcu_exp_wait_wake(struct rcu_state *rsp, unsigned long s)
 			spin_unlock(&rnp->exp_lock);
 		}
 		smp_mb(); /* All above changes before wakeup. */
-		wake_up_all(&rnp->exp_wq[rcu_seq_ctr(rsp->expedited_sequence) & 0x3]);
+		wake_up_all(&rnp->exp_wq[rcu_seq_ctr(rcu_state.expedited_sequence) & 0x3]);
 	}
-	trace_rcu_exp_grace_period(rsp->name, s, TPS("endwake"));
-	mutex_unlock(&rsp->exp_wake_mutex);
+	trace_rcu_exp_grace_period(rcu_state.name, s, TPS("endwake"));
+	mutex_unlock(&rcu_state.exp_wake_mutex);
 }
 
 /*
  * Common code to drive an expedited grace period forward, used by
  * workqueues and mid-boot-time tasks.
  */
-static void rcu_exp_sel_wait_wake(struct rcu_state *rsp,
-				  smp_call_func_t func, unsigned long s)
+static void rcu_exp_sel_wait_wake(smp_call_func_t func, unsigned long s)
 {
 	/* Initialize the rcu_node tree in preparation for the wait. */
-	sync_rcu_exp_select_cpus(rsp, func);
+	sync_rcu_exp_select_cpus(func);
 
 	/* Wait and clean up, including waking everyone. */
-	rcu_exp_wait_wake(rsp, s);
+	rcu_exp_wait_wake(s);
 }
 
 /*
@@ -602,15 +597,14 @@ static void wait_rcu_exp_gp(struct work_struct *wp)
 	struct rcu_exp_work *rewp;
 
 	rewp = container_of(wp, struct rcu_exp_work, rew_work);
-	rcu_exp_sel_wait_wake(rewp->rew_rsp, rewp->rew_func, rewp->rew_s);
+	rcu_exp_sel_wait_wake(rewp->rew_func, rewp->rew_s);
 }
 
 /*
  * Given an rcu_state pointer and a smp_call_function() handler, kick
  * off the specified flavor of expedited grace period.
  */
-static void _synchronize_rcu_expedited(struct rcu_state *rsp,
-				       smp_call_func_t func)
+static void _synchronize_rcu_expedited(smp_call_func_t func)
 {
 	struct rcu_data *rdp;
 	struct rcu_exp_work rew;
@@ -624,18 +618,17 @@ static void _synchronize_rcu_expedited(struct rcu_state *rsp,
 	}
 
 	/* Take a snapshot of the sequence number.  */
-	s = rcu_exp_gp_seq_snap(rsp);
-	if (exp_funnel_lock(rsp, s))
+	s = rcu_exp_gp_seq_snap();
+	if (exp_funnel_lock(s))
 		return;  /* Someone else did our work for us. */
 
 	/* Ensure that load happens before action based on it. */
 	if (unlikely(rcu_scheduler_active == RCU_SCHEDULER_INIT)) {
 		/* Direct call during scheduler init and early_initcalls(). */
-		rcu_exp_sel_wait_wake(rsp, func, s);
+		rcu_exp_sel_wait_wake(func, s);
 	} else {
 		/* Marshall arguments & schedule the expedited grace period. */
 		rew.rew_func = func;
-		rew.rew_rsp = rsp;
 		rew.rew_s = s;
 		INIT_WORK_ONSTACK(&rew.rew_work, wait_rcu_exp_gp);
 		queue_work(rcu_gp_wq, &rew.rew_work);
@@ -645,11 +638,11 @@ static void _synchronize_rcu_expedited(struct rcu_state *rsp,
 	rdp = per_cpu_ptr(&rcu_data, raw_smp_processor_id());
 	rnp = rcu_get_root();
 	wait_event(rnp->exp_wq[rcu_seq_ctr(s) & 0x3],
-		   sync_exp_work_done(rsp, s));
+		   sync_exp_work_done(s));
 	smp_mb(); /* Workqueue actions happen before return. */
 
 	/* Let the next expedited grace period start. */
-	mutex_unlock(&rsp->exp_mutex);
+	mutex_unlock(&rcu_state.exp_mutex);
 }
 
 #ifdef CONFIG_PREEMPT_RCU
@@ -661,10 +654,9 @@ static void _synchronize_rcu_expedited(struct rcu_state *rsp,
  * ->expmask fields in the rcu_node tree.  Otherwise, immediately
  * report the quiescent state.
  */
-static void sync_rcu_exp_handler(void *info)
+static void sync_rcu_exp_handler(void *unused)
 {
 	unsigned long flags;
-	struct rcu_state *rsp = info;
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 	struct rcu_node *rnp = rdp->mynode;
 	struct task_struct *t = current;
@@ -677,7 +669,7 @@ static void sync_rcu_exp_handler(void *info)
 	if (!t->rcu_read_lock_nesting) {
 		if (!(preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK)) ||
 		    rcu_dynticks_curr_cpu_in_eqs()) {
-			rcu_report_exp_rdp(rsp, rdp);
+			rcu_report_exp_rdp(rdp);
 		} else {
 			rdp->deferred_qs = true;
 			resched_cpu(rdp->cpu);
@@ -756,8 +748,6 @@ static void sync_sched_exp_online_cleanup(int cpu)
  */
 void synchronize_rcu_expedited(void)
 {
-	struct rcu_state *rsp = &rcu_state;
-
 	RCU_LOCKDEP_WARN(lock_is_held(&rcu_bh_lock_map) ||
 			 lock_is_held(&rcu_lock_map) ||
 			 lock_is_held(&rcu_sched_lock_map),
@@ -765,7 +755,7 @@ void synchronize_rcu_expedited(void)
 
 	if (rcu_scheduler_active == RCU_SCHEDULER_INACTIVE)
 		return;
-	_synchronize_rcu_expedited(rsp, sync_rcu_exp_handler);
+	_synchronize_rcu_expedited(sync_rcu_exp_handler);
 }
 EXPORT_SYMBOL_GPL(synchronize_rcu_expedited);
 
@@ -783,7 +773,7 @@ static void sync_sched_exp_handler(void *unused)
 	    __this_cpu_read(rcu_data.cpu_no_qs.b.exp))
 		return;
 	if (rcu_is_cpu_rrupt_from_idle()) {
-		rcu_report_exp_rdp(&rcu_state, this_cpu_ptr(&rcu_data));
+		rcu_report_exp_rdp(this_cpu_ptr(&rcu_data));
 		return;
 	}
 	__this_cpu_write(rcu_data.cpu_no_qs.b.exp, true);
@@ -798,13 +788,12 @@ static void sync_sched_exp_online_cleanup(int cpu)
 	struct rcu_data *rdp;
 	int ret;
 	struct rcu_node *rnp;
-	struct rcu_state *rsp = &rcu_state;
 
 	rdp = per_cpu_ptr(&rcu_data, cpu);
 	rnp = rdp->mynode;
 	if (!(READ_ONCE(rnp->expmask) & rdp->grpmask))
 		return;
-	ret = smp_call_function_single(cpu, sync_sched_exp_handler, rsp, 0);
+	ret = smp_call_function_single(cpu, sync_sched_exp_handler, NULL, 0);
 	WARN_ON_ONCE(ret);
 }
 
@@ -831,8 +820,6 @@ static int rcu_blocking_is_gp(void)
 /* PREEMPT=n implementation of synchronize_rcu_expedited(). */
 void synchronize_rcu_expedited(void)
 {
-	struct rcu_state *rsp = &rcu_state;
-
 	RCU_LOCKDEP_WARN(lock_is_held(&rcu_bh_lock_map) ||
 			 lock_is_held(&rcu_lock_map) ||
 			 lock_is_held(&rcu_sched_lock_map),
@@ -842,7 +829,7 @@ void synchronize_rcu_expedited(void)
 	if (rcu_blocking_is_gp())
 		return;
 
-	_synchronize_rcu_expedited(rsp, sync_sched_exp_handler);
+	_synchronize_rcu_expedited(sync_sched_exp_handler);
 }
 EXPORT_SYMBOL_GPL(synchronize_rcu_expedited);
 
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 69705ec13527..e6ec25e47d00 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -123,8 +123,7 @@ static void __init rcu_bootup_announce_oddness(void)
 
 #ifdef CONFIG_PREEMPT_RCU
 
-static void rcu_report_exp_rnp(struct rcu_state *rsp, struct rcu_node *rnp,
-			       bool wake);
+static void rcu_report_exp_rnp(struct rcu_node *rnp, bool wake);
 static void rcu_read_unlock_special(struct task_struct *t);
 
 /*
@@ -281,7 +280,7 @@ static void rcu_preempt_ctxt_queue(struct rcu_node *rnp, struct rcu_data *rdp)
 	 * still in a quiescent state in any case.)
 	 */
 	if (blkd_state & RCU_EXP_BLKD && rdp->deferred_qs)
-		rcu_report_exp_rdp(rdp->rsp, rdp);
+		rcu_report_exp_rdp(rdp);
 	else
 		WARN_ON_ONCE(rdp->deferred_qs);
 }
@@ -381,7 +380,7 @@ void rcu_note_context_switch(bool preempt)
 	 */
 	rcu_qs();
 	if (rdp->deferred_qs)
-		rcu_report_exp_rdp(&rcu_state, rdp);
+		rcu_report_exp_rdp(rdp);
 	trace_rcu_utilization(TPS("End context switch"));
 	barrier(); /* Avoid RCU read-side critical sections leaking up. */
 }
@@ -509,7 +508,7 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
 	 * blocked-tasks list below.
 	 */
 	if (rdp->deferred_qs) {
-		rcu_report_exp_rdp(&rcu_state, rdp);
+		rcu_report_exp_rdp(rdp);
 		if (!t->rcu_read_unlock_special.s) {
 			local_irq_restore(flags);
 			return;
@@ -580,7 +579,7 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
 		 * then we need to report up the rcu_node hierarchy.
 		 */
 		if (!empty_exp && empty_exp_now)
-			rcu_report_exp_rnp(&rcu_state, rnp, true);
+			rcu_report_exp_rnp(rnp, true);
 	} else {
 		local_irq_restore(flags);
 	}
@@ -947,7 +946,7 @@ static void rcu_qs(void)
 	if (!__this_cpu_read(rcu_data.cpu_no_qs.b.exp))
 		return;
 	__this_cpu_write(rcu_data.cpu_no_qs.b.exp, false);
-	rcu_report_exp_rdp(&rcu_state, this_cpu_ptr(&rcu_data));
+	rcu_report_exp_rdp(this_cpu_ptr(&rcu_data));
 }
 
 /*
-- 
2.17.1

