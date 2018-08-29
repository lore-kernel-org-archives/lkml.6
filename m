Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40892C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D74292064E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:21:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D74292064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbeH3CUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 22:20:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42260 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727378AbeH3CTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 22:19:55 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7TMJBa9117160
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:20:56 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m637yhts1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:20:56 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 29 Aug 2018 18:20:55 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 29 Aug 2018 18:20:50 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7TMKnmL39977132
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Aug 2018 22:20:49 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A340BB2064;
        Wed, 29 Aug 2018 18:19:45 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7C592B2068;
        Wed, 29 Aug 2018 18:19:45 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 29 Aug 2018 18:19:45 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 6652C16C91D9; Wed, 29 Aug 2018 15:20:49 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 18/19] rcu: Remove rcu_state_p pointer to default rcu_state structure
Date:   Wed, 29 Aug 2018 15:20:46 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829222021.GA29944@linux.vnet.ibm.com>
References: <20180829222021.GA29944@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18082922-0068-0000-0000-00000331B7B7
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009636; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01080738; UDB=6.00557494; IPR=6.00860723;
 MB=3.00023001; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-29 22:20:55
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082922-0069-0000-0000-0000458F0E12
Message-Id: <20180829222047.319-18-paulmck@linux.vnet.ibm.com>
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

The rcu_state_p pointer references the default rcu_state structure,
that is, the one that call_rcu() uses, as opposed to call_rcu_bh()
and sometimes call_rcu_sched().  But there is now only one rcu_state
structure, so that one structure is by definition the default, which
means that the rcu_state_p pointer no longer serves any useful purpose.
This commit therefore removes it.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree.c        | 27 ++++++++++++---------------
 kernel/rcu/tree_exp.h    |  2 +-
 kernel/rcu/tree_plugin.h | 16 ++++++++--------
 3 files changed, 21 insertions(+), 24 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 1dd8086ee90d..a3bcf08ad596 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -85,7 +85,6 @@ struct rcu_state rcu_state = {
 	.ofl_lock = __SPIN_LOCK_UNLOCKED(rcu_state.ofl_lock),
 };
 
-static struct rcu_state *const rcu_state_p = &rcu_state;
 static struct rcu_data __percpu *const rcu_data_p = &rcu_data;
 LIST_HEAD(rcu_struct_flavors);
 
@@ -491,7 +490,7 @@ static int rcu_pending(void);
  */
 unsigned long rcu_get_gp_seq(void)
 {
-	return READ_ONCE(rcu_state_p->gp_seq);
+	return READ_ONCE(rcu_state.gp_seq);
 }
 EXPORT_SYMBOL_GPL(rcu_get_gp_seq);
 
@@ -510,7 +509,7 @@ EXPORT_SYMBOL_GPL(rcu_sched_get_gp_seq);
  */
 unsigned long rcu_bh_get_gp_seq(void)
 {
-	return READ_ONCE(rcu_state_p->gp_seq);
+	return READ_ONCE(rcu_state.gp_seq);
 }
 EXPORT_SYMBOL_GPL(rcu_bh_get_gp_seq);
 
@@ -522,7 +521,7 @@ EXPORT_SYMBOL_GPL(rcu_bh_get_gp_seq);
  */
 unsigned long rcu_exp_batches_completed(void)
 {
-	return rcu_state_p->expedited_sequence;
+	return rcu_state.expedited_sequence;
 }
 EXPORT_SYMBOL_GPL(rcu_exp_batches_completed);
 
@@ -541,7 +540,7 @@ EXPORT_SYMBOL_GPL(rcu_exp_batches_completed_sched);
  */
 void rcu_force_quiescent_state(void)
 {
-	force_quiescent_state(rcu_state_p);
+	force_quiescent_state(&rcu_state);
 }
 EXPORT_SYMBOL_GPL(rcu_force_quiescent_state);
 
@@ -550,7 +549,7 @@ EXPORT_SYMBOL_GPL(rcu_force_quiescent_state);
  */
 void rcu_bh_force_quiescent_state(void)
 {
-	force_quiescent_state(rcu_state_p);
+	force_quiescent_state(&rcu_state);
 }
 EXPORT_SYMBOL_GPL(rcu_bh_force_quiescent_state);
 
@@ -611,7 +610,7 @@ void rcutorture_get_gp_data(enum rcutorture_type test_type, int *flags,
 	case RCU_FLAVOR:
 	case RCU_BH_FLAVOR:
 	case RCU_SCHED_FLAVOR:
-		rsp = rcu_state_p;
+		rsp = &rcu_state;
 		break;
 	default:
 		break;
@@ -2291,7 +2290,6 @@ rcu_report_unblock_qs_rnp(struct rcu_state *rsp,
 
 	raw_lockdep_assert_held_rcu_node(rnp);
 	if (WARN_ON_ONCE(!IS_ENABLED(CONFIG_PREEMPT)) ||
-	    WARN_ON_ONCE(rsp != rcu_state_p) ||
 	    WARN_ON_ONCE(rcu_preempt_blocked_readers_cgp(rnp)) ||
 	    rnp->qsmask != 0) {
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
@@ -2603,7 +2601,6 @@ static void force_qs_rnp(struct rcu_state *rsp, int (*f)(struct rcu_data *rsp))
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
 		if (rnp->qsmask == 0) {
 			if (!IS_ENABLED(CONFIG_PREEMPT) ||
-			    rsp != rcu_state_p ||
 			    rcu_preempt_blocked_readers_cgp(rnp)) {
 				/*
 				 * No point in scanning bits because they
@@ -2972,7 +2969,7 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func,
  */
 void call_rcu(struct rcu_head *head, rcu_callback_t func)
 {
-	__call_rcu(head, func, rcu_state_p, -1, 0);
+	__call_rcu(head, func, &rcu_state, -1, 0);
 }
 EXPORT_SYMBOL_GPL(call_rcu);
 
@@ -2999,7 +2996,7 @@ EXPORT_SYMBOL_GPL(call_rcu_sched);
 void kfree_call_rcu(struct rcu_head *head,
 		    rcu_callback_t func)
 {
-	__call_rcu(head, func, rcu_state_p, -1, 1);
+	__call_rcu(head, func, &rcu_state, -1, 1);
 }
 EXPORT_SYMBOL_GPL(kfree_call_rcu);
 
@@ -3028,7 +3025,7 @@ unsigned long get_state_synchronize_rcu(void)
 	 * before the load from ->gp_seq.
 	 */
 	smp_mb();  /* ^^^ */
-	return rcu_seq_snap(&rcu_state_p->gp_seq);
+	return rcu_seq_snap(&rcu_state.gp_seq);
 }
 EXPORT_SYMBOL_GPL(get_state_synchronize_rcu);
 
@@ -3048,7 +3045,7 @@ EXPORT_SYMBOL_GPL(get_state_synchronize_rcu);
  */
 void cond_synchronize_rcu(unsigned long oldstate)
 {
-	if (!rcu_seq_done(&rcu_state_p->gp_seq, oldstate))
+	if (!rcu_seq_done(&rcu_state.gp_seq, oldstate))
 		synchronize_rcu();
 	else
 		smp_mb(); /* Ensure GP ends before subsequent accesses. */
@@ -3307,7 +3304,7 @@ static void _rcu_barrier(struct rcu_state *rsp)
  */
 void rcu_barrier_bh(void)
 {
-	_rcu_barrier(rcu_state_p);
+	_rcu_barrier(&rcu_state);
 }
 EXPORT_SYMBOL_GPL(rcu_barrier_bh);
 
@@ -3321,7 +3318,7 @@ EXPORT_SYMBOL_GPL(rcu_barrier_bh);
  */
 void rcu_barrier(void)
 {
-	_rcu_barrier(rcu_state_p);
+	_rcu_barrier(&rcu_state);
 }
 EXPORT_SYMBOL_GPL(rcu_barrier);
 
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 3a8a582d9958..298a6904bbcd 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -756,7 +756,7 @@ static void sync_sched_exp_online_cleanup(int cpu)
  */
 void synchronize_rcu_expedited(void)
 {
-	struct rcu_state *rsp = rcu_state_p;
+	struct rcu_state *rsp = &rcu_state;
 
 	RCU_LOCKDEP_WARN(lock_is_held(&rcu_bh_lock_map) ||
 			 lock_is_held(&rcu_lock_map) ||
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index b7a99a6e64b6..329d5802d899 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -381,7 +381,7 @@ void rcu_note_context_switch(bool preempt)
 	 */
 	rcu_qs();
 	if (rdp->deferred_qs)
-		rcu_report_exp_rdp(rcu_state_p, rdp);
+		rcu_report_exp_rdp(&rcu_state, rdp);
 	trace_rcu_utilization(TPS("End context switch"));
 	barrier(); /* Avoid RCU read-side critical sections leaking up. */
 }
@@ -509,7 +509,7 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
 	 * blocked-tasks list below.
 	 */
 	if (rdp->deferred_qs) {
-		rcu_report_exp_rdp(rcu_state_p, rdp);
+		rcu_report_exp_rdp(&rcu_state, rdp);
 		if (!t->rcu_read_unlock_special.s) {
 			local_irq_restore(flags);
 			return;
@@ -566,7 +566,7 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
 							 rnp->grplo,
 							 rnp->grphi,
 							 !!rnp->gp_tasks);
-			rcu_report_unblock_qs_rnp(rcu_state_p, rnp, flags);
+			rcu_report_unblock_qs_rnp(&rcu_state, rnp, flags);
 		} else {
 			raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 		}
@@ -580,7 +580,7 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
 		 * then we need to report up the rcu_node hierarchy.
 		 */
 		if (!empty_exp && empty_exp_now)
-			rcu_report_exp_rnp(rcu_state_p, rnp, true);
+			rcu_report_exp_rnp(&rcu_state, rnp, true);
 	} else {
 		local_irq_restore(flags);
 	}
@@ -1300,7 +1300,7 @@ static int rcu_spawn_one_boost_kthread(struct rcu_state *rsp,
 	struct sched_param sp;
 	struct task_struct *t;
 
-	if (rcu_state_p != rsp)
+	if (&rcu_state != rsp)
 		return 0;
 
 	if (!rcu_scheduler_fully_active || rcu_rnp_online_cpus(rnp) == 0)
@@ -1431,8 +1431,8 @@ static void __init rcu_spawn_boost_kthreads(void)
 	for_each_possible_cpu(cpu)
 		per_cpu(rcu_cpu_has_work, cpu) = 0;
 	BUG_ON(smpboot_register_percpu_thread(&rcu_cpu_thread_spec));
-	rcu_for_each_leaf_node(rcu_state_p, rnp)
-		(void)rcu_spawn_one_boost_kthread(rcu_state_p, rnp);
+	rcu_for_each_leaf_node(&rcu_state, rnp)
+		(void)rcu_spawn_one_boost_kthread(&rcu_state, rnp);
 }
 
 static void rcu_prepare_kthreads(int cpu)
@@ -1442,7 +1442,7 @@ static void rcu_prepare_kthreads(int cpu)
 
 	/* Fire up the incoming CPU's kthread and leaf rcu_node kthread. */
 	if (rcu_scheduler_fully_active)
-		(void)rcu_spawn_one_boost_kthread(rcu_state_p, rnp);
+		(void)rcu_spawn_one_boost_kthread(&rcu_state, rnp);
 }
 
 #else /* #ifdef CONFIG_RCU_BOOST */
-- 
2.17.1

