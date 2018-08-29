Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A296C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD8F220644
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:42:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD8F220644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbeH3Cly (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 22:41:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53212 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727523AbeH3CiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 22:38:07 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7TMcwsJ047017
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:39:03 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2m62u3k65g-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:39:03 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 29 Aug 2018 18:39:02 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 29 Aug 2018 18:38:58 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7TMcvGs37093616
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Aug 2018 22:38:57 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 40E8EB2070;
        Wed, 29 Aug 2018 18:37:53 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1ABDAB2073;
        Wed, 29 Aug 2018 18:37:53 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 29 Aug 2018 18:37:53 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 690A616C91E1; Wed, 29 Aug 2018 15:38:56 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 32/52] rcu: Remove rsp parameter from rcu_boot_init_percpu_data() and friends
Date:   Wed, 29 Aug 2018 15:38:34 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829223830.GA1800@linux.vnet.ibm.com>
References: <20180829223830.GA1800@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18082922-0064-0000-0000-00000344000B
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009636; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01080744; UDB=6.00557497; IPR=6.00860729;
 MB=3.00023002; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-29 22:39:02
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082922-0065-0000-0000-00003A7847CB
Message-Id: <20180829223854.4055-32-paulmck@linux.vnet.ibm.com>
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

There now is only one rcu_state structure in a given build of
the Linux kernel, so there is no need to pass it as a parameter
to RCU's functions.  This commit therefore removes the rsp
parameter from rcu_boot_init_percpu_data(), rcu_init_percpu_data(),
rcu_cleanup_dying_idle_cpu(), and rcu_migrate_callbacks().  While in
the neighborhood, line the last three into rcutree_prepare_cpu(),
rcu_report_dead() and rcutree_migrate_callbacks(), respectively.
This also gets rid of the for_each_rcu_flavor() calls that were in
those tree functions.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree.c | 102 ++++++++++++++++------------------------------
 1 file changed, 35 insertions(+), 67 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 8028936dc95d..3591633efc33 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3351,7 +3351,7 @@ static void rcu_init_new_rnp(struct rcu_node *rnp_leaf)
  * Do boot-time initialization of a CPU's per-CPU RCU data.
  */
 static void __init
-rcu_boot_init_percpu_data(int cpu, struct rcu_state *rsp)
+rcu_boot_init_percpu_data(int cpu)
 {
 	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
 
@@ -3360,23 +3360,25 @@ rcu_boot_init_percpu_data(int cpu, struct rcu_state *rsp)
 	rdp->dynticks = &per_cpu(rcu_dynticks, cpu);
 	WARN_ON_ONCE(rdp->dynticks->dynticks_nesting != 1);
 	WARN_ON_ONCE(rcu_dynticks_in_eqs(rcu_dynticks_snap(rdp->dynticks)));
-	rdp->rcu_ofl_gp_seq = rsp->gp_seq;
+	rdp->rcu_ofl_gp_seq = rcu_state.gp_seq;
 	rdp->rcu_ofl_gp_flags = RCU_GP_CLEANED;
-	rdp->rcu_onl_gp_seq = rsp->gp_seq;
+	rdp->rcu_onl_gp_seq = rcu_state.gp_seq;
 	rdp->rcu_onl_gp_flags = RCU_GP_CLEANED;
 	rdp->cpu = cpu;
-	rdp->rsp = rsp;
+	rdp->rsp = &rcu_state;
 	rcu_boot_init_nocb_percpu_data(rdp);
 }
 
 /*
- * Initialize a CPU's per-CPU RCU data.  Note that only one online or
+ * Invoked early in the CPU-online process, when pretty much all services
+ * are available.  The incoming CPU is not present.
+ *
+ * Initializes a CPU's per-CPU RCU data.  Note that only one online or
  * offline event can be happening at a given time.  Note also that we can
  * accept some slop in the rsp->gp_seq access due to the fact that this
  * CPU cannot possibly have any RCU callbacks in flight yet.
  */
-static void
-rcu_init_percpu_data(int cpu, struct rcu_state *rsp)
+int rcutree_prepare_cpu(unsigned int cpu)
 {
 	unsigned long flags;
 	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
@@ -3385,7 +3387,7 @@ rcu_init_percpu_data(int cpu, struct rcu_state *rsp)
 	/* Set up local state, ensuring consistent view of global state. */
 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
 	rdp->qlen_last_fqs_check = 0;
-	rdp->n_force_qs_snap = rsp->n_force_qs;
+	rdp->n_force_qs_snap = rcu_state.n_force_qs;
 	rdp->blimit = blimit;
 	if (rcu_segcblist_empty(&rdp->cblist) && /* No early-boot CBs? */
 	    !init_nocb_callback_list(rdp))
@@ -3409,21 +3411,8 @@ rcu_init_percpu_data(int cpu, struct rcu_state *rsp)
 	rdp->core_needs_qs = false;
 	rdp->rcu_iw_pending = false;
 	rdp->rcu_iw_gp_seq = rnp->gp_seq - 1;
-	trace_rcu_grace_period(rsp->name, rdp->gp_seq, TPS("cpuonl"));
+	trace_rcu_grace_period(rcu_state.name, rdp->gp_seq, TPS("cpuonl"));
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
-}
-
-/*
- * Invoked early in the CPU-online process, when pretty much all
- * services are available.  The incoming CPU is not present.
- */
-int rcutree_prepare_cpu(unsigned int cpu)
-{
-	struct rcu_state *rsp;
-
-	for_each_rcu_flavor(rsp)
-		rcu_init_percpu_data(cpu, rsp);
-
 	rcu_prepare_kthreads(cpu);
 	rcu_spawn_all_nocb_kthreads(cpu);
 
@@ -3547,23 +3536,32 @@ void rcu_cpu_starting(unsigned int cpu)
 
 #ifdef CONFIG_HOTPLUG_CPU
 /*
- * The CPU is exiting the idle loop into the arch_cpu_idle_dead()
- * function.  We now remove it from the rcu_node tree's ->qsmaskinitnext
- * bit masks.
+ * The outgoing function has no further need of RCU, so remove it from
+ * the rcu_node tree's ->qsmaskinitnext bit masks.
+ *
+ * Note that this function is special in that it is invoked directly
+ * from the outgoing CPU rather than from the cpuhp_step mechanism.
+ * This is because this function must be invoked at a precise location.
  */
-static void rcu_cleanup_dying_idle_cpu(int cpu, struct rcu_state *rsp)
+void rcu_report_dead(unsigned int cpu)
 {
 	unsigned long flags;
 	unsigned long mask;
 	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
 	struct rcu_node *rnp = rdp->mynode;  /* Outgoing CPU's rdp & rnp. */
 
+	/* QS for any half-done expedited RCU-sched GP. */
+	preempt_disable();
+	rcu_report_exp_rdp(&rcu_state, this_cpu_ptr(&rcu_data));
+	preempt_enable();
+	rcu_preempt_deferred_qs(current);
+
 	/* Remove outgoing CPU from mask in the leaf rcu_node structure. */
 	mask = rdp->grpmask;
-	spin_lock(&rsp->ofl_lock);
+	spin_lock(&rcu_state.ofl_lock);
 	raw_spin_lock_irqsave_rcu_node(rnp, flags); /* Enforce GP memory-order guarantee. */
-	rdp->rcu_ofl_gp_seq = READ_ONCE(rsp->gp_seq);
-	rdp->rcu_ofl_gp_flags = READ_ONCE(rsp->gp_flags);
+	rdp->rcu_ofl_gp_seq = READ_ONCE(rcu_state.gp_seq);
+	rdp->rcu_ofl_gp_flags = READ_ONCE(rcu_state.gp_flags);
 	if (rnp->qsmask & mask) { /* RCU waiting on outgoing CPU? */
 		/* Report quiescent state -before- changing ->qsmaskinitnext! */
 		rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
@@ -3571,34 +3569,17 @@ static void rcu_cleanup_dying_idle_cpu(int cpu, struct rcu_state *rsp)
 	}
 	rnp->qsmaskinitnext &= ~mask;
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
-	spin_unlock(&rsp->ofl_lock);
-}
-
-/*
- * The outgoing function has no further need of RCU, so remove it from
- * the list of CPUs that RCU must track.
- *
- * Note that this function is special in that it is invoked directly
- * from the outgoing CPU rather than from the cpuhp_step mechanism.
- * This is because this function must be invoked at a precise location.
- */
-void rcu_report_dead(unsigned int cpu)
-{
-	struct rcu_state *rsp;
-
-	/* QS for any half-done expedited RCU-sched GP. */
-	preempt_disable();
-	rcu_report_exp_rdp(&rcu_state, this_cpu_ptr(&rcu_data));
-	preempt_enable();
-	rcu_preempt_deferred_qs(current);
-	for_each_rcu_flavor(rsp)
-		rcu_cleanup_dying_idle_cpu(cpu, rsp);
+	spin_unlock(&rcu_state.ofl_lock);
 
 	per_cpu(rcu_cpu_started, cpu) = 0;
 }
 
-/* Migrate the dead CPU's callbacks to the current CPU. */
-static void rcu_migrate_callbacks(int cpu, struct rcu_state *rsp)
+/*
+ * The outgoing CPU has just passed through the dying-idle state, and we
+ * are being invoked from the CPU that was IPIed to continue the offline
+ * operation.  Migrate the outgoing CPU's callbacks to the current CPU.
+ */
+void rcutree_migrate_callbacks(int cpu)
 {
 	unsigned long flags;
 	struct rcu_data *my_rdp;
@@ -3631,19 +3612,6 @@ static void rcu_migrate_callbacks(int cpu, struct rcu_state *rsp)
 		  cpu, rcu_segcblist_n_cbs(&rdp->cblist),
 		  rcu_segcblist_first_cb(&rdp->cblist));
 }
-
-/*
- * The outgoing CPU has just passed through the dying-idle state,
- * and we are being invoked from the CPU that was IPIed to continue the
- * offline operation.  We need to migrate the outgoing CPU's callbacks.
- */
-void rcutree_migrate_callbacks(int cpu)
-{
-	struct rcu_state *rsp;
-
-	for_each_rcu_flavor(rsp)
-		rcu_migrate_callbacks(cpu, rsp);
-}
 #endif
 
 /*
@@ -3813,7 +3781,7 @@ static void __init rcu_init_one(struct rcu_state *rsp)
 		while (i > rnp->grphi)
 			rnp++;
 		per_cpu_ptr(&rcu_data, i)->mynode = rnp;
-		rcu_boot_init_percpu_data(i, rsp);
+		rcu_boot_init_percpu_data(i);
 	}
 	list_add(&rsp->flavors, &rcu_struct_flavors);
 }
-- 
2.17.1

