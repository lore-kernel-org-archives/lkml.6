Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF766C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C60320644
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:40:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C60320644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbeH3Cjp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 22:39:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38400 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727634AbeH3CiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 22:38:08 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7TMciDE016547
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:39:04 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m64f000nc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:39:04 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 29 Aug 2018 18:39:03 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 29 Aug 2018 18:38:58 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7TMcvsk35651618
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Aug 2018 22:38:57 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BEBD8B2070;
        Wed, 29 Aug 2018 18:37:53 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 89D34B2072;
        Wed, 29 Aug 2018 18:37:53 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 29 Aug 2018 18:37:53 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id A826A16C91D1; Wed, 29 Aug 2018 15:38:56 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 43/52] rcu: Remove for_each_rcu_flavor() flavor-traversal macro
Date:   Wed, 29 Aug 2018 15:38:45 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829223830.GA1800@linux.vnet.ibm.com>
References: <20180829223830.GA1800@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18082922-0040-0000-0000-000004675843
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009636; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01080744; UDB=6.00557497; IPR=6.00860730;
 MB=3.00023002; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-29 22:39:02
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082922-0041-0000-0000-0000086E721C
Message-Id: <20180829223854.4055-43-paulmck@linux.vnet.ibm.com>
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

Now that there is only ever a single flavor of RCU in a given kernel
build, there isn't a whole lot of point in having a flavor-traversal
macro.  This commit therefore removes it and converts calls to it to
straightline code, inlining trivial functions as appropriate.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree.c        | 172 ++++++++++++++++-----------------------
 kernel/rcu/tree.h        |   7 --
 kernel/rcu/tree_plugin.h |  59 +++++---------
 3 files changed, 92 insertions(+), 146 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index bc52f8c16faf..cec025cc1f87 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -85,8 +85,6 @@ struct rcu_state rcu_state = {
 	.ofl_lock = __SPIN_LOCK_UNLOCKED(rcu_state.ofl_lock),
 };
 
-LIST_HEAD(rcu_struct_flavors);
-
 /* Dump rcu_node combining tree at boot to verify correct setup. */
 static bool dump_tree;
 module_param(dump_tree, bool, 0444);
@@ -568,31 +566,28 @@ void show_rcu_gp_kthreads(void)
 	int cpu;
 	struct rcu_data *rdp;
 	struct rcu_node *rnp;
-	struct rcu_state *rsp;
 
-	for_each_rcu_flavor(rsp) {
-		pr_info("%s: wait state: %d ->state: %#lx\n",
-			rsp->name, rsp->gp_state, rsp->gp_kthread->state);
-		rcu_for_each_node_breadth_first(rnp) {
-			if (ULONG_CMP_GE(rsp->gp_seq, rnp->gp_seq_needed))
-				continue;
-			pr_info("\trcu_node %d:%d ->gp_seq %lu ->gp_seq_needed %lu\n",
-				rnp->grplo, rnp->grphi, rnp->gp_seq,
-				rnp->gp_seq_needed);
-			if (!rcu_is_leaf_node(rnp))
+	pr_info("%s: wait state: %d ->state: %#lx\n", rcu_state.name,
+		rcu_state.gp_state, rcu_state.gp_kthread->state);
+	rcu_for_each_node_breadth_first(rnp) {
+		if (ULONG_CMP_GE(rcu_state.gp_seq, rnp->gp_seq_needed))
+			continue;
+		pr_info("\trcu_node %d:%d ->gp_seq %lu ->gp_seq_needed %lu\n",
+			rnp->grplo, rnp->grphi, rnp->gp_seq,
+			rnp->gp_seq_needed);
+		if (!rcu_is_leaf_node(rnp))
+			continue;
+		for_each_leaf_node_possible_cpu(rnp, cpu) {
+			rdp = per_cpu_ptr(&rcu_data, cpu);
+			if (rdp->gpwrap ||
+			    ULONG_CMP_GE(rcu_state.gp_seq,
+					 rdp->gp_seq_needed))
 				continue;
-			for_each_leaf_node_possible_cpu(rnp, cpu) {
-				rdp = per_cpu_ptr(&rcu_data, cpu);
-				if (rdp->gpwrap ||
-				    ULONG_CMP_GE(rsp->gp_seq,
-						 rdp->gp_seq_needed))
-					continue;
-				pr_info("\tcpu %d ->gp_seq_needed %lu\n",
-					cpu, rdp->gp_seq_needed);
-			}
+			pr_info("\tcpu %d ->gp_seq_needed %lu\n",
+				cpu, rdp->gp_seq_needed);
 		}
-		/* sched_show_task(rsp->gp_kthread); */
 	}
+	/* sched_show_task(rcu_state.gp_kthread); */
 }
 EXPORT_SYMBOL_GPL(show_rcu_gp_kthreads);
 
@@ -638,7 +633,6 @@ static struct rcu_node *rcu_get_root(void)
  */
 static void rcu_eqs_enter(bool user)
 {
-	struct rcu_state *rsp;
 	struct rcu_data *rdp;
 	struct rcu_dynticks *rdtp;
 
@@ -655,10 +649,8 @@ static void rcu_eqs_enter(bool user)
 	lockdep_assert_irqs_disabled();
 	trace_rcu_dyntick(TPS("Start"), rdtp->dynticks_nesting, 0, rdtp->dynticks);
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
-	for_each_rcu_flavor(rsp) {
-		rdp = this_cpu_ptr(&rcu_data);
-		do_nocb_deferred_wakeup(rdp);
-	}
+	rdp = this_cpu_ptr(&rcu_data);
+	do_nocb_deferred_wakeup(rdp);
 	rcu_prepare_for_idle();
 	rcu_preempt_deferred_qs(current);
 	WRITE_ONCE(rdtp->dynticks_nesting, 0); /* Avoid irq-access tearing. */
@@ -1023,21 +1015,17 @@ bool rcu_lockdep_current_cpu_online(void)
 {
 	struct rcu_data *rdp;
 	struct rcu_node *rnp;
-	struct rcu_state *rsp;
+	bool ret = false;
 
 	if (in_nmi() || !rcu_scheduler_fully_active)
 		return true;
 	preempt_disable();
-	for_each_rcu_flavor(rsp) {
-		rdp = this_cpu_ptr(&rcu_data);
-		rnp = rdp->mynode;
-		if (rdp->grpmask & rcu_rnp_online_cpus(rnp)) {
-			preempt_enable();
-			return true;
-		}
-	}
+	rdp = this_cpu_ptr(&rcu_data);
+	rnp = rdp->mynode;
+	if (rdp->grpmask & rcu_rnp_online_cpus(rnp))
+		ret = true;
 	preempt_enable();
-	return false;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(rcu_lockdep_current_cpu_online);
 
@@ -1515,10 +1503,7 @@ static void check_cpu_stall(struct rcu_data *rdp)
  */
 void rcu_cpu_stall_reset(void)
 {
-	struct rcu_state *rsp;
-
-	for_each_rcu_flavor(rsp)
-		WRITE_ONCE(rsp->jiffies_stall, jiffies + ULONG_MAX / 2);
+	WRITE_ONCE(rcu_state.jiffies_stall, jiffies + ULONG_MAX / 2);
 }
 
 /* Trace-event wrapper function for trace_rcu_future_grace_period.  */
@@ -3133,17 +3118,12 @@ static bool rcu_cpu_has_callbacks(bool *all_lazy)
 	bool al = true;
 	bool hc = false;
 	struct rcu_data *rdp;
-	struct rcu_state *rsp;
 
-	for_each_rcu_flavor(rsp) {
-		rdp = this_cpu_ptr(&rcu_data);
-		if (rcu_segcblist_empty(&rdp->cblist))
-			continue;
+	rdp = this_cpu_ptr(&rcu_data);
+	if (!rcu_segcblist_empty(&rdp->cblist)) {
 		hc = true;
-		if (rcu_segcblist_n_nonlazy_cbs(&rdp->cblist) || !all_lazy) {
+		if (rcu_segcblist_n_nonlazy_cbs(&rdp->cblist))
 			al = false;
-			break;
-		}
 	}
 	if (all_lazy)
 		*all_lazy = al;
@@ -3435,15 +3415,12 @@ int rcutree_online_cpu(unsigned int cpu)
 	unsigned long flags;
 	struct rcu_data *rdp;
 	struct rcu_node *rnp;
-	struct rcu_state *rsp;
 
-	for_each_rcu_flavor(rsp) {
-		rdp = per_cpu_ptr(&rcu_data, cpu);
-		rnp = rdp->mynode;
-		raw_spin_lock_irqsave_rcu_node(rnp, flags);
-		rnp->ffmask |= rdp->grpmask;
-		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
-	}
+	rdp = per_cpu_ptr(&rcu_data, cpu);
+	rnp = rdp->mynode;
+	raw_spin_lock_irqsave_rcu_node(rnp, flags);
+	rnp->ffmask |= rdp->grpmask;
+	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	if (IS_ENABLED(CONFIG_TREE_SRCU))
 		srcu_online_cpu(cpu);
 	if (rcu_scheduler_active == RCU_SCHEDULER_INACTIVE)
@@ -3462,15 +3439,12 @@ int rcutree_offline_cpu(unsigned int cpu)
 	unsigned long flags;
 	struct rcu_data *rdp;
 	struct rcu_node *rnp;
-	struct rcu_state *rsp;
 
-	for_each_rcu_flavor(rsp) {
-		rdp = per_cpu_ptr(&rcu_data, cpu);
-		rnp = rdp->mynode;
-		raw_spin_lock_irqsave_rcu_node(rnp, flags);
-		rnp->ffmask &= ~rdp->grpmask;
-		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
-	}
+	rdp = per_cpu_ptr(&rcu_data, cpu);
+	rnp = rdp->mynode;
+	raw_spin_lock_irqsave_rcu_node(rnp, flags);
+	rnp->ffmask &= ~rdp->grpmask;
+	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 
 	rcutree_affinity_setting(cpu, cpu);
 	if (IS_ENABLED(CONFIG_TREE_SRCU))
@@ -3499,34 +3473,32 @@ void rcu_cpu_starting(unsigned int cpu)
 	unsigned long oldmask;
 	struct rcu_data *rdp;
 	struct rcu_node *rnp;
-	struct rcu_state *rsp;
+	struct rcu_state *rsp = &rcu_state;
 
 	if (per_cpu(rcu_cpu_started, cpu))
 		return;
 
 	per_cpu(rcu_cpu_started, cpu) = 1;
 
-	for_each_rcu_flavor(rsp) {
-		rdp = per_cpu_ptr(&rcu_data, cpu);
-		rnp = rdp->mynode;
-		mask = rdp->grpmask;
-		raw_spin_lock_irqsave_rcu_node(rnp, flags);
-		rnp->qsmaskinitnext |= mask;
-		oldmask = rnp->expmaskinitnext;
-		rnp->expmaskinitnext |= mask;
-		oldmask ^= rnp->expmaskinitnext;
-		nbits = bitmap_weight(&oldmask, BITS_PER_LONG);
-		/* Allow lockless access for expedited grace periods. */
-		smp_store_release(&rsp->ncpus, rsp->ncpus + nbits); /* ^^^ */
-		rcu_gpnum_ovf(rnp, rdp); /* Offline-induced counter wrap? */
-		rdp->rcu_onl_gp_seq = READ_ONCE(rsp->gp_seq);
-		rdp->rcu_onl_gp_flags = READ_ONCE(rsp->gp_flags);
-		if (rnp->qsmask & mask) { /* RCU waiting on incoming CPU? */
-			/* Report QS -after- changing ->qsmaskinitnext! */
-			rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
-		} else {
-			raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
-		}
+	rdp = per_cpu_ptr(&rcu_data, cpu);
+	rnp = rdp->mynode;
+	mask = rdp->grpmask;
+	raw_spin_lock_irqsave_rcu_node(rnp, flags);
+	rnp->qsmaskinitnext |= mask;
+	oldmask = rnp->expmaskinitnext;
+	rnp->expmaskinitnext |= mask;
+	oldmask ^= rnp->expmaskinitnext;
+	nbits = bitmap_weight(&oldmask, BITS_PER_LONG);
+	/* Allow lockless access for expedited grace periods. */
+	smp_store_release(&rsp->ncpus, rsp->ncpus + nbits); /* ^^^ */
+	rcu_gpnum_ovf(rnp, rdp); /* Offline-induced counter wrap? */
+	rdp->rcu_onl_gp_seq = READ_ONCE(rsp->gp_seq);
+	rdp->rcu_onl_gp_flags = READ_ONCE(rsp->gp_flags);
+	if (rnp->qsmask & mask) { /* RCU waiting on incoming CPU? */
+		/* Report QS -after- changing ->qsmaskinitnext! */
+		rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
+	} else {
+		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	}
 	smp_mb(); /* Ensure RCU read-side usage follows above initialization. */
 }
@@ -3643,7 +3615,6 @@ static int __init rcu_spawn_gp_kthread(void)
 	unsigned long flags;
 	int kthread_prio_in = kthread_prio;
 	struct rcu_node *rnp;
-	struct rcu_state *rsp;
 	struct sched_param sp;
 	struct task_struct *t;
 
@@ -3663,19 +3634,17 @@ static int __init rcu_spawn_gp_kthread(void)
 			 kthread_prio, kthread_prio_in);
 
 	rcu_scheduler_fully_active = 1;
-	for_each_rcu_flavor(rsp) {
-		t = kthread_create(rcu_gp_kthread, NULL, "%s", rsp->name);
-		BUG_ON(IS_ERR(t));
-		rnp = rcu_get_root();
-		raw_spin_lock_irqsave_rcu_node(rnp, flags);
-		rsp->gp_kthread = t;
-		if (kthread_prio) {
-			sp.sched_priority = kthread_prio;
-			sched_setscheduler_nocheck(t, SCHED_FIFO, &sp);
-		}
-		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
-		wake_up_process(t);
+	t = kthread_create(rcu_gp_kthread, NULL, "%s", rcu_state.name);
+	BUG_ON(IS_ERR(t));
+	rnp = rcu_get_root();
+	raw_spin_lock_irqsave_rcu_node(rnp, flags);
+	rcu_state.gp_kthread = t;
+	if (kthread_prio) {
+		sp.sched_priority = kthread_prio;
+		sched_setscheduler_nocheck(t, SCHED_FIFO, &sp);
 	}
+	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
+	wake_up_process(t);
 	rcu_spawn_nocb_kthreads();
 	rcu_spawn_boost_kthreads();
 	return 0;
@@ -3781,7 +3750,6 @@ static void __init rcu_init_one(void)
 		per_cpu_ptr(&rcu_data, i)->mynode = rnp;
 		rcu_boot_init_percpu_data(i);
 	}
-	list_add(&rsp->flavors, &rcu_struct_flavors);
 }
 
 /*
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 6f1b1a3fc23d..8abc15c42d84 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -360,7 +360,6 @@ struct rcu_state {
 						/*  jiffies. */
 	const char *name;			/* Name of structure. */
 	char abbr;				/* Abbreviated name. */
-	struct list_head flavors;		/* List of RCU flavors. */
 
 	spinlock_t ofl_lock ____cacheline_internodealigned_in_smp;
 						/* Synchronize offline with */
@@ -417,12 +416,6 @@ static const char *tp_rcu_varname __used __tracepoint_string = rcu_name;
 #define RCU_NAME rcu_name
 #endif /* #else #ifdef CONFIG_TRACING */
 
-extern struct list_head rcu_struct_flavors;
-
-/* Sequence through rcu_state structures for each RCU flavor. */
-#define for_each_rcu_flavor(rsp) \
-	list_for_each_entry((rsp), &rcu_struct_flavors, flavors)
-
 /*
  * RCU implementation internal declarations:
  */
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 59d66ee26310..878a1d2cd465 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1561,31 +1561,28 @@ static bool __maybe_unused rcu_try_advance_all_cbs(void)
 	struct rcu_data *rdp;
 	struct rcu_dynticks *rdtp = this_cpu_ptr(&rcu_dynticks);
 	struct rcu_node *rnp;
-	struct rcu_state *rsp;
 
 	/* Exit early if we advanced recently. */
 	if (jiffies == rdtp->last_advance_all)
 		return false;
 	rdtp->last_advance_all = jiffies;
 
-	for_each_rcu_flavor(rsp) {
-		rdp = this_cpu_ptr(&rcu_data);
-		rnp = rdp->mynode;
+	rdp = this_cpu_ptr(&rcu_data);
+	rnp = rdp->mynode;
 
-		/*
-		 * Don't bother checking unless a grace period has
-		 * completed since we last checked and there are
-		 * callbacks not yet ready to invoke.
-		 */
-		if ((rcu_seq_completed_gp(rdp->gp_seq,
-					  rcu_seq_current(&rnp->gp_seq)) ||
-		     unlikely(READ_ONCE(rdp->gpwrap))) &&
-		    rcu_segcblist_pend_cbs(&rdp->cblist))
-			note_gp_changes(rdp);
-
-		if (rcu_segcblist_ready_cbs(&rdp->cblist))
-			cbs_ready = true;
-	}
+	/*
+	 * Don't bother checking unless a grace period has
+	 * completed since we last checked and there are
+	 * callbacks not yet ready to invoke.
+	 */
+	if ((rcu_seq_completed_gp(rdp->gp_seq,
+				  rcu_seq_current(&rnp->gp_seq)) ||
+	     unlikely(READ_ONCE(rdp->gpwrap))) &&
+	    rcu_segcblist_pend_cbs(&rdp->cblist))
+		note_gp_changes(rdp);
+
+	if (rcu_segcblist_ready_cbs(&rdp->cblist))
+		cbs_ready = true;
 	return cbs_ready;
 }
 
@@ -1648,7 +1645,6 @@ static void rcu_prepare_for_idle(void)
 	struct rcu_data *rdp;
 	struct rcu_dynticks *rdtp = this_cpu_ptr(&rcu_dynticks);
 	struct rcu_node *rnp;
-	struct rcu_state *rsp;
 	int tne;
 
 	lockdep_assert_irqs_disabled();
@@ -1686,10 +1682,8 @@ static void rcu_prepare_for_idle(void)
 	if (rdtp->last_accelerate == jiffies)
 		return;
 	rdtp->last_accelerate = jiffies;
-	for_each_rcu_flavor(rsp) {
-		rdp = this_cpu_ptr(&rcu_data);
-		if (!rcu_segcblist_pend_cbs(&rdp->cblist))
-			continue;
+	rdp = this_cpu_ptr(&rcu_data);
+	if (rcu_segcblist_pend_cbs(&rdp->cblist)) {
 		rnp = rdp->mynode;
 		raw_spin_lock_rcu_node(rnp); /* irqs already disabled. */
 		needwake = rcu_accelerate_cbs(rnp, rdp);
@@ -1824,10 +1818,7 @@ static void zero_cpu_stall_ticks(struct rcu_data *rdp)
 /* Increment ->ticks_this_gp for all flavors of RCU. */
 static void increment_cpu_stall_ticks(void)
 {
-	struct rcu_state *rsp;
-
-	for_each_rcu_flavor(rsp)
-		raw_cpu_inc(rcu_data.ticks_this_gp);
+	raw_cpu_inc(rcu_data.ticks_this_gp);
 }
 
 #ifdef CONFIG_RCU_NOCB_CPU
@@ -2384,7 +2375,6 @@ void __init rcu_init_nohz(void)
 {
 	int cpu;
 	bool need_rcu_nocb_mask = false;
-	struct rcu_state *rsp;
 
 #if defined(CONFIG_NO_HZ_FULL)
 	if (tick_nohz_full_running && cpumask_weight(tick_nohz_full_mask))
@@ -2418,11 +2408,9 @@ void __init rcu_init_nohz(void)
 	if (rcu_nocb_poll)
 		pr_info("\tPoll for callbacks from no-CBs CPUs.\n");
 
-	for_each_rcu_flavor(rsp) {
-		for_each_cpu(cpu, rcu_nocb_mask)
-			init_nocb_callback_list(per_cpu_ptr(&rcu_data, cpu));
-		rcu_organize_nocb_kthreads();
-	}
+	for_each_cpu(cpu, rcu_nocb_mask)
+		init_nocb_callback_list(per_cpu_ptr(&rcu_data, cpu));
+	rcu_organize_nocb_kthreads();
 }
 
 /* Initialize per-rcu_data variables for no-CBs CPUs. */
@@ -2489,11 +2477,8 @@ static void rcu_spawn_one_nocb_kthread(int cpu)
  */
 static void rcu_spawn_all_nocb_kthreads(int cpu)
 {
-	struct rcu_state *rsp;
-
 	if (rcu_scheduler_fully_active)
-		for_each_rcu_flavor(rsp)
-			rcu_spawn_one_nocb_kthread(cpu);
+		rcu_spawn_one_nocb_kthread(cpu);
 }
 
 /*
-- 
2.17.1

