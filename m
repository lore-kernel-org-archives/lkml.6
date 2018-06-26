Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF4DC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:12:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DE6526E62
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:12:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DE6526E62
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933238AbeFZRMd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 13:12:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42608 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932126AbeFZRIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 13:08:53 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5QH4L0s119724
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 13:08:53 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2juqcpq597-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 13:08:52 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 26 Jun 2018 13:08:50 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Jun 2018 13:08:47 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5QH8kjM8126854
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Jun 2018 17:08:46 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BB612B206A;
        Tue, 26 Jun 2018 13:08:39 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 92B40B2071;
        Tue, 26 Jun 2018 13:08:39 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 26 Jun 2018 13:08:39 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id ED22716CA0AF; Tue, 26 Jun 2018 10:10:49 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 20/22] rcu: Add CPU online/offline state to dump_blkd_tasks()
Date:   Tue, 26 Jun 2018 10:10:46 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626002052.GA24146@linux.vnet.ibm.com>
References: <20180626002052.GA24146@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062617-0040-0000-0000-000004457965
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009259; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052668; UDB=6.00539669; IPR=6.00830592;
 MB=3.00021864; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-26 17:08:50
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062617-0041-0000-0000-0000084B8FC1
Message-Id: <20180626171048.2181-20-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-26_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806260192
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Interactions between CPU-hotplug operations and grace-period
initialization can result in dump_blkd_tasks().  One of the first
debugging actions in this case is to search back in dmesg to work
out which of the affected rcu_node structure's CPUs are online and to
determine the last CPU-hotplug operation affecting any of those CPUs.
This can be laborious and error-prone, especially when console output
is lost.

This commit therefore causes dump_blkd_tasks() to dump the state of
the affected rcu_node structure's CPUs and the last grace period during
which the last offline and online operation affected each of these CPUs.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree.c        | 12 ++++++++++--
 kernel/rcu/tree.h        | 12 +++++++++---
 kernel/rcu/tree_plugin.h | 25 ++++++++++++++++++++-----
 3 files changed, 39 insertions(+), 10 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index c698a595b932..1e87ff1154a5 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1954,7 +1954,7 @@ static bool rcu_gp_init(struct rcu_state *rsp)
 		rcu_gp_slow(rsp, gp_init_delay);
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
 		rdp = this_cpu_ptr(rsp->rda);
-		rcu_preempt_check_blocked_tasks(rnp);
+		rcu_preempt_check_blocked_tasks(rsp, rnp);
 		rnp->qsmask = rnp->qsmaskinit;
 		WRITE_ONCE(rnp->gp_seq, rsp->gp_seq);
 		if (rnp == rdp->mynode)
@@ -2063,7 +2063,7 @@ static void rcu_gp_cleanup(struct rcu_state *rsp)
 	rcu_for_each_node_breadth_first(rsp, rnp) {
 		raw_spin_lock_irq_rcu_node(rnp);
 		if (WARN_ON_ONCE(rcu_preempt_blocked_readers_cgp(rnp)))
-			dump_blkd_tasks(rnp, 10);
+			dump_blkd_tasks(rsp, rnp, 10);
 		WARN_ON_ONCE(rnp->qsmask);
 		WRITE_ONCE(rnp->gp_seq, new_gp_seq);
 		rdp = this_cpu_ptr(rsp->rda);
@@ -3514,6 +3514,10 @@ rcu_boot_init_percpu_data(int cpu, struct rcu_state *rsp)
 	rdp->dynticks = &per_cpu(rcu_dynticks, cpu);
 	WARN_ON_ONCE(rdp->dynticks->dynticks_nesting != 1);
 	WARN_ON_ONCE(rcu_dynticks_in_eqs(rcu_dynticks_snap(rdp->dynticks)));
+	rdp->rcu_ofl_gp_seq = rsp->gp_seq;
+	rdp->rcu_ofl_gp_flags = RCU_GP_CLEANED;
+	rdp->rcu_onl_gp_seq = rsp->gp_seq;
+	rdp->rcu_onl_gp_flags = RCU_GP_CLEANED;
 	rdp->cpu = cpu;
 	rdp->rsp = rsp;
 	rcu_boot_init_nocb_percpu_data(rdp);
@@ -3709,6 +3713,8 @@ void rcu_cpu_starting(unsigned int cpu)
 		/* Allow lockless access for expedited grace periods. */
 		smp_store_release(&rsp->ncpus, rsp->ncpus + nbits); /* ^^^ */
 		rcu_gpnum_ovf(rnp, rdp); /* Offline-induced counter wrap? */
+		rdp->rcu_onl_gp_seq = READ_ONCE(rsp->gp_seq);
+		rdp->rcu_onl_gp_flags = READ_ONCE(rsp->gp_flags);
 		if (rnp->qsmask & mask) { /* RCU waiting on incoming CPU? */
 			/* Report QS -after- changing ->qsmaskinitnext! */
 			rcu_report_qs_rnp(mask, rsp, rnp, rnp->gp_seq, flags);
@@ -3736,6 +3742,8 @@ static void rcu_cleanup_dying_idle_cpu(int cpu, struct rcu_state *rsp)
 	mask = rdp->grpmask;
 	spin_lock(&rsp->ofl_lock);
 	raw_spin_lock_irqsave_rcu_node(rnp, flags); /* Enforce GP memory-order guarantee. */
+	rdp->rcu_ofl_gp_seq = READ_ONCE(rsp->gp_seq);
+	rdp->rcu_ofl_gp_flags = READ_ONCE(rsp->gp_flags);
 	if (rnp->qsmask & mask) { /* RCU waiting on outgoing CPU? */
 		/* Report quiescent state -before- changing ->qsmaskinitnext! */
 		rcu_report_qs_rnp(mask, rsp, rnp, rnp->gp_seq, flags);
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 795d469c6f67..f52bc059bfec 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -255,12 +255,16 @@ struct rcu_data {
 					/* Leader CPU takes GP-end wakeups. */
 #endif /* #ifdef CONFIG_RCU_NOCB_CPU */
 
-	/* 7) RCU CPU stall data. */
+	/* 7) Diagnostic data, including RCU CPU stall warnings. */
 	unsigned int softirq_snap;	/* Snapshot of softirq activity. */
 	/* ->rcu_iw* fields protected by leaf rcu_node ->lock. */
 	struct irq_work rcu_iw;		/* Check for non-irq activity. */
 	bool rcu_iw_pending;		/* Is ->rcu_iw pending? */
 	unsigned long rcu_iw_gp_seq;	/* ->gp_seq associated with ->rcu_iw. */
+	unsigned long rcu_ofl_gp_seq;	/* ->gp_seq at last offline. */
+	short rcu_ofl_gp_flags;		/* ->gp_flags at last offline. */
+	unsigned long rcu_onl_gp_seq;	/* ->gp_seq at last online. */
+	short rcu_onl_gp_flags;		/* ->gp_flags at last online. */
 
 	int cpu;
 	struct rcu_state *rsp;
@@ -431,11 +435,13 @@ static bool rcu_preempt_has_tasks(struct rcu_node *rnp);
 static void rcu_print_detail_task_stall(struct rcu_state *rsp);
 static int rcu_print_task_stall(struct rcu_node *rnp);
 static int rcu_print_task_exp_stall(struct rcu_node *rnp);
-static void rcu_preempt_check_blocked_tasks(struct rcu_node *rnp);
+static void rcu_preempt_check_blocked_tasks(struct rcu_state *rsp,
+					    struct rcu_node *rnp);
 static void rcu_preempt_check_callbacks(void);
 void call_rcu(struct rcu_head *head, rcu_callback_t func);
 static void __init __rcu_init_preempt(void);
-static void dump_blkd_tasks(struct rcu_node *rnp, int ncheck);
+static void dump_blkd_tasks(struct rcu_state *rsp, struct rcu_node *rnp,
+			    int ncheck);
 static void rcu_initiate_boost(struct rcu_node *rnp, unsigned long flags);
 static void rcu_preempt_boost_start_gp(struct rcu_node *rnp);
 static void invoke_rcu_callbacks_kthread(void);
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index f45ff97b0d51..613372246a07 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -699,13 +699,14 @@ static int rcu_print_task_exp_stall(struct rcu_node *rnp)
  * Also, if there are blocked tasks on the list, they automatically
  * block the newly created grace period, so set up ->gp_tasks accordingly.
  */
-static void rcu_preempt_check_blocked_tasks(struct rcu_node *rnp)
+static void
+rcu_preempt_check_blocked_tasks(struct rcu_state *rsp, struct rcu_node *rnp)
 {
 	struct task_struct *t;
 
 	RCU_LOCKDEP_WARN(preemptible(), "rcu_preempt_check_blocked_tasks() invoked with preemption enabled!!!\n");
 	if (WARN_ON_ONCE(rcu_preempt_blocked_readers_cgp(rnp)))
-		dump_blkd_tasks(rnp, 10);
+		dump_blkd_tasks(rsp, rnp, 10);
 	if (rcu_preempt_has_tasks(rnp) &&
 	    (rnp->qsmaskinit || rnp->wait_blkd_tasks)) {
 		rnp->gp_tasks = rnp->blkd_tasks.next;
@@ -854,10 +855,14 @@ void exit_rcu(void)
  * Dump the blocked-tasks state, but limit the list dump to the
  * specified number of elements.
  */
-static void dump_blkd_tasks(struct rcu_node *rnp, int ncheck)
+static void
+dump_blkd_tasks(struct rcu_state *rsp, struct rcu_node *rnp, int ncheck)
 {
+	int cpu;
 	int i;
 	struct list_head *lhp;
+	bool onl;
+	struct rcu_data *rdp;
 	struct rcu_node *rnp1;
 
 	raw_lockdep_assert_held_rcu_node(rnp);
@@ -877,6 +882,14 @@ static void dump_blkd_tasks(struct rcu_node *rnp, int ncheck)
 			break;
 	}
 	pr_cont("\n");
+	for (cpu = rnp->grplo; cpu <= rnp->grphi; cpu++) {
+		rdp = per_cpu_ptr(rsp->rda, cpu);
+		onl = !!(rdp->grpmask & rcu_rnp_online_cpus(rnp));
+		pr_info("\t%d: %c online: %ld(%d) offline: %ld(%d)\n",
+			cpu, ".o"[onl],
+			(long)rdp->rcu_onl_gp_seq, rdp->rcu_onl_gp_flags,
+			(long)rdp->rcu_ofl_gp_seq, rdp->rcu_ofl_gp_flags);
+	}
 }
 
 #else /* #ifdef CONFIG_PREEMPT_RCU */
@@ -949,7 +962,8 @@ static int rcu_print_task_exp_stall(struct rcu_node *rnp)
  * so there is no need to check for blocked tasks.  So check only for
  * bogus qsmask values.
  */
-static void rcu_preempt_check_blocked_tasks(struct rcu_node *rnp)
+static void
+rcu_preempt_check_blocked_tasks(struct rcu_state *rsp, struct rcu_node *rnp)
 {
 	WARN_ON_ONCE(rnp->qsmask);
 }
@@ -990,7 +1004,8 @@ void exit_rcu(void)
 /*
  * Dump the guaranteed-empty blocked-tasks state.  Trust but verify.
  */
-static void dump_blkd_tasks(struct rcu_node *rnp, int ncheck)
+static void
+dump_blkd_tasks(struct rcu_state *rsp, struct rcu_node *rnp, int ncheck)
 {
 	WARN_ON_ONCE(!list_empty(&rnp->blkd_tasks));
 }
-- 
2.17.1

