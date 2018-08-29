Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED28DC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F3BC2064E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:21:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F3BC2064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbeH3CUP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 22:20:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60092 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727395AbeH3CT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 22:19:57 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7TMIjhm075528
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:20:57 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2m60r17uvk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:20:56 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 29 Aug 2018 18:20:56 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 29 Aug 2018 18:20:51 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7TMKoZD44695682
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Aug 2018 22:20:50 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8652BB206C;
        Wed, 29 Aug 2018 18:19:46 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 54F7FB2067;
        Wed, 29 Aug 2018 18:19:46 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 29 Aug 2018 18:19:46 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 61CBE16C91D8; Wed, 29 Aug 2018 15:20:49 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 17/19] rcu: Remove rcu_state structure's ->rda field
Date:   Wed, 29 Aug 2018 15:20:45 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829222021.GA29944@linux.vnet.ibm.com>
References: <20180829222021.GA29944@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18082922-2213-0000-0000-000002E50744
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009636; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01080738; UDB=6.00557494; IPR=6.00860724;
 MB=3.00023001; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-29 22:20:54
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082922-2214-0000-0000-00005B60259C
Message-Id: <20180829222047.319-17-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-29_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808290217
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rcu_state structure's ->rda field was used to find the per-CPU
rcu_data structures corresponding to that rcu_state structure.  But now
there is only one rcu_state structure (creatively named "rcu_state")
and one set of per-CPU rcu_data structures (creatively named "rcu_data").
Therefore, uses of the ->rda field can always be replaced by "rcu_data,
and this commit makes that change and removes the ->rda field.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree.c        | 67 ++++++++++++++++++++--------------------
 kernel/rcu/tree.h        |  1 -
 kernel/rcu/tree_exp.h    | 19 ++++++------
 kernel/rcu/tree_plugin.h | 24 +++++++-------
 4 files changed, 54 insertions(+), 57 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 0c736e078fe6..1dd8086ee90d 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -75,7 +75,6 @@
 static DEFINE_PER_CPU_SHARED_ALIGNED(struct rcu_data, rcu_data);
 struct rcu_state rcu_state = {
 	.level = { &rcu_state.node[0] },
-	.rda = &rcu_data,
 	.gp_state = RCU_GP_IDLE,
 	.gp_seq = (0UL - 300UL) << RCU_SEQ_CTR_SHIFT,
 	.barrier_mutex = __MUTEX_INITIALIZER(rcu_state.barrier_mutex),
@@ -586,7 +585,7 @@ void show_rcu_gp_kthreads(void)
 			if (!rcu_is_leaf_node(rnp))
 				continue;
 			for_each_leaf_node_possible_cpu(rnp, cpu) {
-				rdp = per_cpu_ptr(rsp->rda, cpu);
+				rdp = per_cpu_ptr(&rcu_data, cpu);
 				if (rdp->gpwrap ||
 				    ULONG_CMP_GE(rsp->gp_seq,
 						 rdp->gp_seq_needed))
@@ -660,7 +659,7 @@ static void rcu_eqs_enter(bool user)
 	trace_rcu_dyntick(TPS("Start"), rdtp->dynticks_nesting, 0, rdtp->dynticks);
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
 	for_each_rcu_flavor(rsp) {
-		rdp = this_cpu_ptr(rsp->rda);
+		rdp = this_cpu_ptr(&rcu_data);
 		do_nocb_deferred_wakeup(rdp);
 	}
 	rcu_prepare_for_idle();
@@ -1033,7 +1032,7 @@ bool rcu_lockdep_current_cpu_online(void)
 		return true;
 	preempt_disable();
 	for_each_rcu_flavor(rsp) {
-		rdp = this_cpu_ptr(rsp->rda);
+		rdp = this_cpu_ptr(&rcu_data);
 		rnp = rdp->mynode;
 		if (rdp->grpmask & rcu_rnp_online_cpus(rnp)) {
 			preempt_enable();
@@ -1351,7 +1350,7 @@ static void print_other_cpu_stall(struct rcu_state *rsp, unsigned long gp_seq)
 
 	print_cpu_stall_info_end();
 	for_each_possible_cpu(cpu)
-		totqlen += rcu_segcblist_n_cbs(&per_cpu_ptr(rsp->rda,
+		totqlen += rcu_segcblist_n_cbs(&per_cpu_ptr(&rcu_data,
 							    cpu)->cblist);
 	pr_cont("(detected by %d, t=%ld jiffies, g=%ld, q=%lu)\n",
 	       smp_processor_id(), (long)(jiffies - rsp->gp_start),
@@ -1391,7 +1390,7 @@ static void print_cpu_stall(struct rcu_state *rsp)
 {
 	int cpu;
 	unsigned long flags;
-	struct rcu_data *rdp = this_cpu_ptr(rsp->rda);
+	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 	struct rcu_node *rnp = rcu_get_root(rsp);
 	long totqlen = 0;
 
@@ -1412,7 +1411,7 @@ static void print_cpu_stall(struct rcu_state *rsp)
 	raw_spin_unlock_irqrestore_rcu_node(rdp->mynode, flags);
 	print_cpu_stall_info_end();
 	for_each_possible_cpu(cpu)
-		totqlen += rcu_segcblist_n_cbs(&per_cpu_ptr(rsp->rda,
+		totqlen += rcu_segcblist_n_cbs(&per_cpu_ptr(&rcu_data,
 							    cpu)->cblist);
 	pr_cont(" (t=%lu jiffies g=%ld q=%lu)\n",
 		jiffies - rsp->gp_start,
@@ -1623,7 +1622,7 @@ static bool rcu_start_this_gp(struct rcu_node *rnp_start, struct rcu_data *rdp,
 static bool rcu_future_gp_cleanup(struct rcu_state *rsp, struct rcu_node *rnp)
 {
 	bool needmore;
-	struct rcu_data *rdp = this_cpu_ptr(rsp->rda);
+	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 
 	needmore = ULONG_CMP_LT(rnp->gp_seq, rnp->gp_seq_needed);
 	if (!needmore)
@@ -1935,7 +1934,7 @@ static bool rcu_gp_init(struct rcu_state *rsp)
 	rcu_for_each_node_breadth_first(rsp, rnp) {
 		rcu_gp_slow(rsp, gp_init_delay);
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
-		rdp = this_cpu_ptr(rsp->rda);
+		rdp = this_cpu_ptr(&rcu_data);
 		rcu_preempt_check_blocked_tasks(rsp, rnp);
 		rnp->qsmask = rnp->qsmaskinit;
 		WRITE_ONCE(rnp->gp_seq, rsp->gp_seq);
@@ -2049,7 +2048,7 @@ static void rcu_gp_cleanup(struct rcu_state *rsp)
 			dump_blkd_tasks(rsp, rnp, 10);
 		WARN_ON_ONCE(rnp->qsmask);
 		WRITE_ONCE(rnp->gp_seq, new_gp_seq);
-		rdp = this_cpu_ptr(rsp->rda);
+		rdp = this_cpu_ptr(&rcu_data);
 		if (rnp == rdp->mynode)
 			needgp = __note_gp_changes(rsp, rnp, rdp) || needgp;
 		/* smp_mb() provided by prior unlock-lock pair. */
@@ -2069,7 +2068,7 @@ static void rcu_gp_cleanup(struct rcu_state *rsp)
 	trace_rcu_grace_period(rsp->name, rsp->gp_seq, TPS("end"));
 	rsp->gp_state = RCU_GP_IDLE;
 	/* Check for GP requests since above loop. */
-	rdp = this_cpu_ptr(rsp->rda);
+	rdp = this_cpu_ptr(&rcu_data);
 	if (!needgp && ULONG_CMP_LT(rnp->gp_seq, rnp->gp_seq_needed)) {
 		trace_rcu_this_gp(rnp, rdp, rnp->gp_seq_needed,
 				  TPS("CleanupMore"));
@@ -2404,7 +2403,7 @@ rcu_check_quiescent_state(struct rcu_state *rsp, struct rcu_data *rdp)
 static void rcu_cleanup_dying_cpu(struct rcu_state *rsp)
 {
 	RCU_TRACE(bool blkd;)
-	RCU_TRACE(struct rcu_data *rdp = this_cpu_ptr(rsp->rda);)
+	RCU_TRACE(struct rcu_data *rdp = this_cpu_ptr(&rcu_data);)
 	RCU_TRACE(struct rcu_node *rnp = rdp->mynode;)
 
 	if (!IS_ENABLED(CONFIG_HOTPLUG_CPU))
@@ -2468,7 +2467,7 @@ static void rcu_cleanup_dead_rnp(struct rcu_node *rnp_leaf)
  */
 static void rcu_cleanup_dead_cpu(int cpu, struct rcu_state *rsp)
 {
-	struct rcu_data *rdp = per_cpu_ptr(rsp->rda, cpu);
+	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
 	struct rcu_node *rnp = rdp->mynode;  /* Outgoing CPU's rdp & rnp. */
 
 	if (!IS_ENABLED(CONFIG_HOTPLUG_CPU))
@@ -2621,7 +2620,7 @@ static void force_qs_rnp(struct rcu_state *rsp, int (*f)(struct rcu_data *rsp))
 		for_each_leaf_node_possible_cpu(rnp, cpu) {
 			unsigned long bit = leaf_node_cpu_bit(rnp, cpu);
 			if ((rnp->qsmask & bit) != 0) {
-				if (f(per_cpu_ptr(rsp->rda, cpu)))
+				if (f(per_cpu_ptr(&rcu_data, cpu)))
 					mask |= bit;
 			}
 		}
@@ -2647,7 +2646,7 @@ static void force_quiescent_state(struct rcu_state *rsp)
 	struct rcu_node *rnp_old = NULL;
 
 	/* Funnel through hierarchy to reduce memory contention. */
-	rnp = __this_cpu_read(rsp->rda->mynode);
+	rnp = __this_cpu_read(rcu_data.mynode);
 	for (; rnp != NULL; rnp = rnp->parent) {
 		ret = (READ_ONCE(rsp->gp_flags) & RCU_GP_FLAG_FQS) ||
 		      !raw_spin_trylock(&rnp->fqslock);
@@ -2739,7 +2738,7 @@ static void
 __rcu_process_callbacks(struct rcu_state *rsp)
 {
 	unsigned long flags;
-	struct rcu_data *rdp = raw_cpu_ptr(rsp->rda);
+	struct rcu_data *rdp = raw_cpu_ptr(&rcu_data);
 	struct rcu_node *rnp = rdp->mynode;
 
 	WARN_ON_ONCE(!rdp->beenonline);
@@ -2893,14 +2892,14 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func,
 	head->func = func;
 	head->next = NULL;
 	local_irq_save(flags);
-	rdp = this_cpu_ptr(rsp->rda);
+	rdp = this_cpu_ptr(&rcu_data);
 
 	/* Add the callback to our list. */
 	if (unlikely(!rcu_segcblist_is_enabled(&rdp->cblist)) || cpu != -1) {
 		int offline;
 
 		if (cpu != -1)
-			rdp = per_cpu_ptr(rsp->rda, cpu);
+			rdp = per_cpu_ptr(&rcu_data, cpu);
 		if (likely(rdp->mynode)) {
 			/* Post-boot, so this should be for a no-CBs CPU. */
 			offline = !__call_rcu_nocb(rdp, head, lazy, flags);
@@ -3134,7 +3133,7 @@ static int rcu_pending(void)
 	struct rcu_state *rsp;
 
 	for_each_rcu_flavor(rsp)
-		if (__rcu_pending(rsp, this_cpu_ptr(rsp->rda)))
+		if (__rcu_pending(rsp, this_cpu_ptr(&rcu_data)))
 			return 1;
 	return 0;
 }
@@ -3152,7 +3151,7 @@ static bool rcu_cpu_has_callbacks(bool *all_lazy)
 	struct rcu_state *rsp;
 
 	for_each_rcu_flavor(rsp) {
-		rdp = this_cpu_ptr(rsp->rda);
+		rdp = this_cpu_ptr(&rcu_data);
 		if (rcu_segcblist_empty(&rdp->cblist))
 			continue;
 		hc = true;
@@ -3201,7 +3200,7 @@ static void rcu_barrier_callback(struct rcu_head *rhp)
 static void rcu_barrier_func(void *type)
 {
 	struct rcu_state *rsp = type;
-	struct rcu_data *rdp = raw_cpu_ptr(rsp->rda);
+	struct rcu_data *rdp = raw_cpu_ptr(&rcu_data);
 
 	_rcu_barrier_trace(rsp, TPS("IRQ"), -1, rsp->barrier_sequence);
 	rdp->barrier_head.func = rcu_barrier_callback;
@@ -3261,7 +3260,7 @@ static void _rcu_barrier(struct rcu_state *rsp)
 	for_each_possible_cpu(cpu) {
 		if (!cpu_online(cpu) && !rcu_is_nocb_cpu(cpu))
 			continue;
-		rdp = per_cpu_ptr(rsp->rda, cpu);
+		rdp = per_cpu_ptr(&rcu_data, cpu);
 		if (rcu_is_nocb_cpu(cpu)) {
 			if (!rcu_nocb_cpu_needs_barrier(rsp, cpu)) {
 				_rcu_barrier_trace(rsp, TPS("OfflineNoCB"), cpu,
@@ -3371,7 +3370,7 @@ static void rcu_init_new_rnp(struct rcu_node *rnp_leaf)
 static void __init
 rcu_boot_init_percpu_data(int cpu, struct rcu_state *rsp)
 {
-	struct rcu_data *rdp = per_cpu_ptr(rsp->rda, cpu);
+	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
 
 	/* Set up local state, ensuring consistent view of global state. */
 	rdp->grpmask = leaf_node_cpu_bit(rdp->mynode, cpu);
@@ -3397,7 +3396,7 @@ static void
 rcu_init_percpu_data(int cpu, struct rcu_state *rsp)
 {
 	unsigned long flags;
-	struct rcu_data *rdp = per_cpu_ptr(rsp->rda, cpu);
+	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
 	struct rcu_node *rnp = rcu_get_root(rsp);
 
 	/* Set up local state, ensuring consistent view of global state. */
@@ -3453,7 +3452,7 @@ int rcutree_prepare_cpu(unsigned int cpu)
  */
 static void rcutree_affinity_setting(unsigned int cpu, int outgoing)
 {
-	struct rcu_data *rdp = per_cpu_ptr(rcu_state_p->rda, cpu);
+	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
 
 	rcu_boost_kthread_setaffinity(rdp->mynode, outgoing);
 }
@@ -3470,7 +3469,7 @@ int rcutree_online_cpu(unsigned int cpu)
 	struct rcu_state *rsp;
 
 	for_each_rcu_flavor(rsp) {
-		rdp = per_cpu_ptr(rsp->rda, cpu);
+		rdp = per_cpu_ptr(&rcu_data, cpu);
 		rnp = rdp->mynode;
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
 		rnp->ffmask |= rdp->grpmask;
@@ -3497,7 +3496,7 @@ int rcutree_offline_cpu(unsigned int cpu)
 	struct rcu_state *rsp;
 
 	for_each_rcu_flavor(rsp) {
-		rdp = per_cpu_ptr(rsp->rda, cpu);
+		rdp = per_cpu_ptr(&rcu_data, cpu);
 		rnp = rdp->mynode;
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
 		rnp->ffmask &= ~rdp->grpmask;
@@ -3531,7 +3530,7 @@ int rcutree_dead_cpu(unsigned int cpu)
 
 	for_each_rcu_flavor(rsp) {
 		rcu_cleanup_dead_cpu(cpu, rsp);
-		do_nocb_deferred_wakeup(per_cpu_ptr(rsp->rda, cpu));
+		do_nocb_deferred_wakeup(per_cpu_ptr(&rcu_data, cpu));
 	}
 	return 0;
 }
@@ -3565,7 +3564,7 @@ void rcu_cpu_starting(unsigned int cpu)
 	per_cpu(rcu_cpu_started, cpu) = 1;
 
 	for_each_rcu_flavor(rsp) {
-		rdp = per_cpu_ptr(rsp->rda, cpu);
+		rdp = per_cpu_ptr(&rcu_data, cpu);
 		rnp = rdp->mynode;
 		mask = rdp->grpmask;
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
@@ -3599,7 +3598,7 @@ static void rcu_cleanup_dying_idle_cpu(int cpu, struct rcu_state *rsp)
 {
 	unsigned long flags;
 	unsigned long mask;
-	struct rcu_data *rdp = per_cpu_ptr(rsp->rda, cpu);
+	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
 	struct rcu_node *rnp = rdp->mynode;  /* Outgoing CPU's rdp & rnp. */
 
 	/* Remove outgoing CPU from mask in the leaf rcu_node structure. */
@@ -3632,7 +3631,7 @@ void rcu_report_dead(unsigned int cpu)
 
 	/* QS for any half-done expedited RCU-sched GP. */
 	preempt_disable();
-	rcu_report_exp_rdp(&rcu_state, this_cpu_ptr(rcu_state.rda));
+	rcu_report_exp_rdp(&rcu_state, this_cpu_ptr(&rcu_data));
 	preempt_enable();
 	rcu_preempt_deferred_qs(current);
 	for_each_rcu_flavor(rsp)
@@ -3646,7 +3645,7 @@ static void rcu_migrate_callbacks(int cpu, struct rcu_state *rsp)
 {
 	unsigned long flags;
 	struct rcu_data *my_rdp;
-	struct rcu_data *rdp = per_cpu_ptr(rsp->rda, cpu);
+	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
 	struct rcu_node *rnp_root = rcu_get_root(rdp->rsp);
 	bool needwake;
 
@@ -3654,7 +3653,7 @@ static void rcu_migrate_callbacks(int cpu, struct rcu_state *rsp)
 		return;  /* No callbacks to migrate. */
 
 	local_irq_save(flags);
-	my_rdp = this_cpu_ptr(rsp->rda);
+	my_rdp = this_cpu_ptr(&rcu_data);
 	if (rcu_nocb_adopt_orphan_cbs(my_rdp, rdp, flags)) {
 		local_irq_restore(flags);
 		return;
@@ -3856,7 +3855,7 @@ static void __init rcu_init_one(struct rcu_state *rsp)
 	for_each_possible_cpu(i) {
 		while (i > rnp->grphi)
 			rnp++;
-		per_cpu_ptr(rsp->rda, i)->mynode = rnp;
+		per_cpu_ptr(&rcu_data, i)->mynode = rnp;
 		rcu_boot_init_percpu_data(i, rsp);
 	}
 	list_add(&rsp->flavors, &rcu_struct_flavors);
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index c50060567146..d60304f1ef56 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -312,7 +312,6 @@ struct rcu_state {
 	struct rcu_node *level[RCU_NUM_LVLS + 1];
 						/* Hierarchy levels (+1 to */
 						/*  shut bogus gcc warning) */
-	struct rcu_data __percpu *rda;		/* pointer of percu rcu_data. */
 	int ncpus;				/* # CPUs seen so far. */
 
 	/* The following fields are guarded by the root rcu_node's lock. */
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 224f05f0c0c9..3a8a582d9958 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -286,7 +286,7 @@ static bool sync_exp_work_done(struct rcu_state *rsp, unsigned long s)
  */
 static bool exp_funnel_lock(struct rcu_state *rsp, unsigned long s)
 {
-	struct rcu_data *rdp = per_cpu_ptr(rsp->rda, raw_smp_processor_id());
+	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, raw_smp_processor_id());
 	struct rcu_node *rnp = rdp->mynode;
 	struct rcu_node *rnp_root = rcu_get_root(rsp);
 
@@ -361,7 +361,7 @@ static void sync_rcu_exp_select_node_cpus(struct work_struct *wp)
 	mask_ofl_test = 0;
 	for_each_leaf_node_cpu_mask(rnp, cpu, rnp->expmask) {
 		unsigned long mask = leaf_node_cpu_bit(rnp, cpu);
-		struct rcu_data *rdp = per_cpu_ptr(rsp->rda, cpu);
+		struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
 		struct rcu_dynticks *rdtp = per_cpu_ptr(&rcu_dynticks, cpu);
 		int snap;
 
@@ -390,7 +390,7 @@ static void sync_rcu_exp_select_node_cpus(struct work_struct *wp)
 	/* IPI the remaining CPUs for expedited quiescent state. */
 	for_each_leaf_node_cpu_mask(rnp, cpu, rnp->expmask) {
 		unsigned long mask = leaf_node_cpu_bit(rnp, cpu);
-		struct rcu_data *rdp = per_cpu_ptr(rsp->rda, cpu);
+		struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
 
 		if (!(mask_ofl_ipi & mask))
 			continue;
@@ -509,7 +509,7 @@ static void synchronize_sched_expedited_wait(struct rcu_state *rsp)
 				if (!(rnp->expmask & mask))
 					continue;
 				ndetected++;
-				rdp = per_cpu_ptr(rsp->rda, cpu);
+				rdp = per_cpu_ptr(&rcu_data, cpu);
 				pr_cont(" %d-%c%c%c", cpu,
 					"O."[!!cpu_online(cpu)],
 					"o."[!!(rdp->grpmask & rnp->expmaskinit)],
@@ -642,7 +642,7 @@ static void _synchronize_rcu_expedited(struct rcu_state *rsp,
 	}
 
 	/* Wait for expedited grace period to complete. */
-	rdp = per_cpu_ptr(rsp->rda, raw_smp_processor_id());
+	rdp = per_cpu_ptr(&rcu_data, raw_smp_processor_id());
 	rnp = rcu_get_root(rsp);
 	wait_event(rnp->exp_wq[rcu_seq_ctr(s) & 0x3],
 		   sync_exp_work_done(rsp, s));
@@ -665,7 +665,7 @@ static void sync_rcu_exp_handler(void *info)
 {
 	unsigned long flags;
 	struct rcu_state *rsp = info;
-	struct rcu_data *rdp = this_cpu_ptr(rsp->rda);
+	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 	struct rcu_node *rnp = rdp->mynode;
 	struct task_struct *t = current;
 
@@ -772,13 +772,12 @@ EXPORT_SYMBOL_GPL(synchronize_rcu_expedited);
 #else /* #ifdef CONFIG_PREEMPT_RCU */
 
 /* Invoked on each online non-idle CPU for expedited quiescent state. */
-static void sync_sched_exp_handler(void *data)
+static void sync_sched_exp_handler(void *unused)
 {
 	struct rcu_data *rdp;
 	struct rcu_node *rnp;
-	struct rcu_state *rsp = data;
 
-	rdp = this_cpu_ptr(rsp->rda);
+	rdp = this_cpu_ptr(&rcu_data);
 	rnp = rdp->mynode;
 	if (!(READ_ONCE(rnp->expmask) & rdp->grpmask) ||
 	    __this_cpu_read(rcu_data.cpu_no_qs.b.exp))
@@ -801,7 +800,7 @@ static void sync_sched_exp_online_cleanup(int cpu)
 	struct rcu_node *rnp;
 	struct rcu_state *rsp = &rcu_state;
 
-	rdp = per_cpu_ptr(rsp->rda, cpu);
+	rdp = per_cpu_ptr(&rcu_data, cpu);
 	rnp = rdp->mynode;
 	if (!(READ_ONCE(rnp->expmask) & rdp->grpmask))
 		return;
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 2c81f8dd63b4..b7a99a6e64b6 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -328,7 +328,7 @@ static void rcu_qs(void)
 void rcu_note_context_switch(bool preempt)
 {
 	struct task_struct *t = current;
-	struct rcu_data *rdp = this_cpu_ptr(rcu_state_p->rda);
+	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 	struct rcu_node *rnp;
 
 	barrier(); /* Avoid RCU read-side critical sections leaking down. */
@@ -488,7 +488,7 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
 	 * t->rcu_read_unlock_special cannot change.
 	 */
 	special = t->rcu_read_unlock_special;
-	rdp = this_cpu_ptr(rcu_state_p->rda);
+	rdp = this_cpu_ptr(&rcu_data);
 	if (!special.s && !rdp->deferred_qs) {
 		local_irq_restore(flags);
 		return;
@@ -911,7 +911,7 @@ dump_blkd_tasks(struct rcu_state *rsp, struct rcu_node *rnp, int ncheck)
 	}
 	pr_cont("\n");
 	for (cpu = rnp->grplo; cpu <= rnp->grphi; cpu++) {
-		rdp = per_cpu_ptr(rsp->rda, cpu);
+		rdp = per_cpu_ptr(&rcu_data, cpu);
 		onl = !!(rdp->grpmask & rcu_rnp_online_cpus(rnp));
 		pr_info("\t%d: %c online: %ld(%d) offline: %ld(%d)\n",
 			cpu, ".o"[onl],
@@ -1437,7 +1437,7 @@ static void __init rcu_spawn_boost_kthreads(void)
 
 static void rcu_prepare_kthreads(int cpu)
 {
-	struct rcu_data *rdp = per_cpu_ptr(rcu_state_p->rda, cpu);
+	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
 	struct rcu_node *rnp = rdp->mynode;
 
 	/* Fire up the incoming CPU's kthread and leaf rcu_node kthread. */
@@ -1574,7 +1574,7 @@ static bool __maybe_unused rcu_try_advance_all_cbs(void)
 	rdtp->last_advance_all = jiffies;
 
 	for_each_rcu_flavor(rsp) {
-		rdp = this_cpu_ptr(rsp->rda);
+		rdp = this_cpu_ptr(&rcu_data);
 		rnp = rdp->mynode;
 
 		/*
@@ -1692,7 +1692,7 @@ static void rcu_prepare_for_idle(void)
 		return;
 	rdtp->last_accelerate = jiffies;
 	for_each_rcu_flavor(rsp) {
-		rdp = this_cpu_ptr(rsp->rda);
+		rdp = this_cpu_ptr(&rcu_data);
 		if (!rcu_segcblist_pend_cbs(&rdp->cblist))
 			continue;
 		rnp = rdp->mynode;
@@ -1778,7 +1778,7 @@ static void print_cpu_stall_info(struct rcu_state *rsp, int cpu)
 {
 	unsigned long delta;
 	char fast_no_hz[72];
-	struct rcu_data *rdp = per_cpu_ptr(rsp->rda, cpu);
+	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
 	struct rcu_dynticks *rdtp = rdp->dynticks;
 	char *ticks_title;
 	unsigned long ticks_value;
@@ -1833,7 +1833,7 @@ static void increment_cpu_stall_ticks(void)
 	struct rcu_state *rsp;
 
 	for_each_rcu_flavor(rsp)
-		raw_cpu_inc(rsp->rda->ticks_this_gp);
+		raw_cpu_inc(rcu_data.ticks_this_gp);
 }
 
 #ifdef CONFIG_RCU_NOCB_CPU
@@ -1965,7 +1965,7 @@ static void wake_nocb_leader_defer(struct rcu_data *rdp, int waketype,
  */
 static bool rcu_nocb_cpu_needs_barrier(struct rcu_state *rsp, int cpu)
 {
-	struct rcu_data *rdp = per_cpu_ptr(rsp->rda, cpu);
+	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
 	unsigned long ret;
 #ifdef CONFIG_PROVE_RCU
 	struct rcu_head *rhp;
@@ -2426,7 +2426,7 @@ void __init rcu_init_nohz(void)
 
 	for_each_rcu_flavor(rsp) {
 		for_each_cpu(cpu, rcu_nocb_mask)
-			init_nocb_callback_list(per_cpu_ptr(rsp->rda, cpu));
+			init_nocb_callback_list(per_cpu_ptr(&rcu_data, cpu));
 		rcu_organize_nocb_kthreads(rsp);
 	}
 }
@@ -2452,7 +2452,7 @@ static void rcu_spawn_one_nocb_kthread(struct rcu_state *rsp, int cpu)
 	struct rcu_data *rdp;
 	struct rcu_data *rdp_last;
 	struct rcu_data *rdp_old_leader;
-	struct rcu_data *rdp_spawn = per_cpu_ptr(rsp->rda, cpu);
+	struct rcu_data *rdp_spawn = per_cpu_ptr(&rcu_data, cpu);
 	struct task_struct *t;
 
 	/*
@@ -2545,7 +2545,7 @@ static void __init rcu_organize_nocb_kthreads(struct rcu_state *rsp)
 	 * we will spawn the needed set of rcu_nocb_kthread() kthreads.
 	 */
 	for_each_cpu(cpu, rcu_nocb_mask) {
-		rdp = per_cpu_ptr(rsp->rda, cpu);
+		rdp = per_cpu_ptr(&rcu_data, cpu);
 		if (rdp->cpu >= nl) {
 			/* New leader, set up for followers & next leader. */
 			nl = DIV_ROUND_UP(rdp->cpu + 1, ls) * ls;
-- 
2.17.1

