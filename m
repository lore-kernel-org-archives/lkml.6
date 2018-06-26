Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEF15C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A68D02632A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:13:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A68D02632A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935428AbeFZAM7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 20:12:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50774 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S934339AbeFZAHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 20:07:04 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5Q03kb3079107
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 20:07:03 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ju96qagjs-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 20:07:03 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 25 Jun 2018 20:07:01 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Jun 2018 20:06:58 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5Q06vQW61997094
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Jun 2018 00:06:57 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 94600B206B;
        Mon, 25 Jun 2018 20:06:51 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6D52EB206E;
        Mon, 25 Jun 2018 20:06:51 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 25 Jun 2018 20:06:51 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 8636016CA0AA; Mon, 25 Jun 2018 17:09:01 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 27/40] rcu: Remove ->gpnum and ->completed
Date:   Mon, 25 Jun 2018 17:08:46 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626000841.GA15696@linux.vnet.ibm.com>
References: <20180626000841.GA15696@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062600-0064-0000-0000-000003202F94
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009255; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052327; UDB=6.00539464; IPR=6.00830253;
 MB=3.00021855; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-26 00:07:01
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062600-0065-0000-0000-000039B7444D
Message-Id: <20180626000859.23572-27-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-25_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806260000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that everything has been converted to use ->gp_seq instead of
->gpnum and ->completed, this commit removes ->gpnum and ->completed.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree.c        | 45 ++++++++++------------------------------
 kernel/rcu/tree.h        | 14 +------------
 kernel/rcu/tree_plugin.h |  2 +-
 3 files changed, 13 insertions(+), 48 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 43ba06abf081..2b66da93cf5b 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -95,8 +95,6 @@ struct rcu_state sname##_state = { \
 	.rda = &sname##_data, \
 	.call = cr, \
 	.gp_state = RCU_GP_IDLE, \
-	.gpnum = 0UL - 300UL, \
-	.completed = 0UL - 300UL, \
 	.gp_seq = (0UL - 300UL) << RCU_SEQ_CTR_SHIFT, \
 	.barrier_mutex = __MUTEX_INITIALIZER(sname##_state.barrier_mutex), \
 	.name = RCU_STATE_NAME(sname), \
@@ -1349,8 +1347,6 @@ static void print_other_cpu_stall(struct rcu_state *rsp, unsigned long gp_seq)
 	struct rcu_node *rnp = rcu_get_root(rsp);
 	long totqlen = 0;
 
-	WARN_ON_ONCE(gp_seq & 0x2); /* Remove when ->gpnum removed. */
-
 	/* Kick and suppress, if so configured. */
 	rcu_stall_kick_kthreads(rsp);
 	if (rcu_cpu_stall_suppress)
@@ -1582,8 +1578,6 @@ static bool rcu_start_this_gp(struct rcu_node *rnp, struct rcu_data *rdp,
 	 * not be released.
 	 */
 	raw_lockdep_assert_held_rcu_node(rnp);
-	WARN_ON_ONCE(c & 0x2); /* Catch any lingering use of ->gpnum. */
-	WARN_ON_ONCE(((rnp->completed << RCU_SEQ_CTR_SHIFT) >> RCU_SEQ_CTR_SHIFT) != rcu_seq_ctr(rnp->gp_seq)); /* Catch any ->completed/->gp_seq mismatches. */
 	trace_rcu_this_gp(rnp, rdp, c, TPS("Startleaf"));
 	for (rnp_root = rnp; 1; rnp_root = rnp_root->parent) {
 		if (rnp_root != rnp)
@@ -1757,8 +1751,6 @@ static bool __note_gp_changes(struct rcu_state *rsp, struct rcu_node *rnp,
 	if (rcu_seq_completed_gp(rdp->gp_seq, rnp->gp_seq) ||
 	    unlikely(READ_ONCE(rdp->gpwrap))) {
 		ret = rcu_advance_cbs(rsp, rnp, rdp); /* Advance callbacks. */
-		/* Remember that we saw this grace-period completion. */
-		rdp->completed = rnp->completed;
 		trace_rcu_grace_period(rsp->name, rdp->gp_seq, TPS("cpuend"));
 	} else {
 		ret = rcu_accelerate_cbs(rsp, rnp, rdp); /* Recent callbacks. */
@@ -1772,7 +1764,6 @@ static bool __note_gp_changes(struct rcu_state *rsp, struct rcu_node *rnp,
 		 * set up to detect a quiescent state, otherwise don't
 		 * go looking for one.
 		 */
-		rdp->gpnum = rnp->gpnum;
 		trace_rcu_grace_period(rsp->name, rdp->gp_seq, TPS("cpustart"));
 		need_gp = !!(rnp->qsmask & rdp->grpmask);
 		rdp->cpu_no_qs.b.norm = need_gp;
@@ -1843,13 +1834,8 @@ static bool rcu_gp_init(struct rcu_state *rsp)
 
 	/* Advance to a new grace period and initialize state. */
 	record_gp_stall_check_time(rsp);
-	/* Record GP times before starting GP, hence smp_store_release(). */
-	WARN_ON_ONCE(rsp->gpnum << RCU_SEQ_CTR_SHIFT != rsp->gp_seq);
-	smp_store_release(&rsp->gpnum, rsp->gpnum + 1);
-	smp_mb(); /* Pairs with barriers in stall-warning code. */
+	/* Record GP times before starting GP, hence rcu_seq_start(). */
 	rcu_seq_start(&rsp->gp_seq);
-	if (WARN_ON_ONCE(((rnp->completed << RCU_SEQ_CTR_SHIFT) >> RCU_SEQ_CTR_SHIFT) != rcu_seq_ctr(rnp->gp_seq))) /* Catch any ->completed/->gp_seq mismatches. */
-		pr_info("%s ->completed: %#lx (%#lx) ->gp_seq %#lx (%#lx)\n", __func__, rnp->completed, (rnp->completed << RCU_SEQ_CTR_SHIFT) >> RCU_SEQ_CTR_SHIFT, rnp->gp_seq, rcu_seq_ctr(rnp->gp_seq));
 	trace_rcu_grace_period(rsp->name, rsp->gp_seq, TPS("start"));
 	raw_spin_unlock_irq_rcu_node(rnp);
 
@@ -1920,9 +1906,6 @@ static bool rcu_gp_init(struct rcu_state *rsp)
 		rdp = this_cpu_ptr(rsp->rda);
 		rcu_preempt_check_blocked_tasks(rnp);
 		rnp->qsmask = rnp->qsmaskinit;
-		WRITE_ONCE(rnp->gpnum, rsp->gpnum);
-		if (WARN_ON_ONCE(rnp->completed != rsp->completed))
-			WRITE_ONCE(rnp->completed, rsp->completed);
 		WRITE_ONCE(rnp->gp_seq, rsp->gp_seq);
 		if (rnp == rdp->mynode)
 			(void)__note_gp_changes(rsp, rnp, rdp);
@@ -2012,13 +1995,13 @@ static void rcu_gp_cleanup(struct rcu_state *rsp)
 	raw_spin_unlock_irq_rcu_node(rnp);
 
 	/*
-	 * Propagate new ->completed value to rcu_node structures so
-	 * that other CPUs don't have to wait until the start of the next
-	 * grace period to process their callbacks.  This also avoids
-	 * some nasty RCU grace-period initialization races by forcing
-	 * the end of the current grace period to be completely recorded in
-	 * all of the rcu_node structures before the beginning of the next
-	 * grace period is recorded in any of the rcu_node structures.
+	 * Propagate new ->gp_seq value to rcu_node structures so that
+	 * other CPUs don't have to wait until the start of the next grace
+	 * period to process their callbacks.  This also avoids some nasty
+	 * RCU grace-period initialization races by forcing the end of
+	 * the current grace period to be completely recorded in all of
+	 * the rcu_node structures before the beginning of the next grace
+	 * period is recorded in any of the rcu_node structures.
 	 */
 	new_gp_seq = rsp->gp_seq;
 	rcu_seq_end(&new_gp_seq);
@@ -2027,7 +2010,6 @@ static void rcu_gp_cleanup(struct rcu_state *rsp)
 		if (WARN_ON_ONCE(rcu_preempt_blocked_readers_cgp(rnp)))
 			dump_blkd_tasks(rnp, 10);
 		WARN_ON_ONCE(rnp->qsmask);
-		WRITE_ONCE(rnp->completed, rsp->gpnum);
 		WRITE_ONCE(rnp->gp_seq, new_gp_seq);
 		rdp = this_cpu_ptr(rsp->rda);
 		if (rnp == rdp->mynode)
@@ -2045,7 +2027,6 @@ static void rcu_gp_cleanup(struct rcu_state *rsp)
 	raw_spin_lock_irq_rcu_node(rnp); /* GP before rsp->gp_seq update. */
 
 	/* Declare grace period done. */
-	WRITE_ONCE(rsp->completed, rsp->gpnum);
 	rcu_seq_end(&rsp->gp_seq);
 	trace_rcu_grace_period(rsp->name, rsp->gp_seq, TPS("end"));
 	rsp->gp_state = RCU_GP_IDLE;
@@ -3494,9 +3475,9 @@ rcu_boot_init_percpu_data(int cpu, struct rcu_state *rsp)
 
 /*
  * Initialize a CPU's per-CPU RCU data.  Note that only one online or
- * offline event can be happening at a given time.  Note also that we
- * can accept some slop in the rsp->completed access due to the fact
- * that this CPU cannot possibly have any RCU callbacks in flight yet.
+ * offline event can be happening at a given time.  Note also that we can
+ * accept some slop in the rsp->gp_seq access due to the fact that this
+ * CPU cannot possibly have any RCU callbacks in flight yet.
  */
 static void
 rcu_init_percpu_data(int cpu, struct rcu_state *rsp)
@@ -3525,8 +3506,6 @@ rcu_init_percpu_data(int cpu, struct rcu_state *rsp)
 	rnp = rdp->mynode;
 	raw_spin_lock_rcu_node(rnp);		/* irqs already disabled. */
 	rdp->beenonline = true;	 /* We have now been online. */
-	rdp->gpnum = rnp->completed; /* Make CPU later note any new GP. */
-	rdp->completed = rnp->completed;
 	rdp->gp_seq = rnp->gp_seq;
 	rdp->gp_seq_needed = rnp->gp_seq;
 	rdp->cpu_no_qs.b.norm = true;
@@ -3906,8 +3885,6 @@ static void __init rcu_init_one(struct rcu_state *rsp)
 			raw_spin_lock_init(&rnp->fqslock);
 			lockdep_set_class_and_name(&rnp->fqslock,
 						   &rcu_fqs_class[i], fqs[i]);
-			rnp->gpnum = rsp->gpnum;
-			rnp->completed = rsp->completed;
 			rnp->gp_seq = rsp->gp_seq;
 			rnp->gp_seq_needed = rsp->gp_seq;
 			rnp->completedqs = rsp->gp_seq;
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 9329c1ff695f..3def94fc9c74 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -81,12 +81,6 @@ struct rcu_node {
 	raw_spinlock_t __private lock;	/* Root rcu_node's lock protects */
 					/*  some rcu_state fields as well as */
 					/*  following. */
-	unsigned long gpnum;	/* Current grace period for this node. */
-				/*  This will either be equal to or one */
-				/*  behind the root rcu_node's gpnum. */
-	unsigned long completed; /* Last GP completed for this node. */
-				/*  This will either be equal to or one */
-				/*  behind the root rcu_node's gpnum. */
 	unsigned long gp_seq;	/* Track rsp->rcu_gp_seq. */
 	unsigned long gp_seq_needed; /* Track rsp->rcu_gp_seq_needed. */
 	unsigned long completedqs; /* All QSes done for this node. */
@@ -192,10 +186,6 @@ union rcu_noqs {
 /* Per-CPU data for read-copy update. */
 struct rcu_data {
 	/* 1) quiescent-state and grace-period handling : */
-	unsigned long	completed;	/* Track rsp->completed gp number */
-					/*  in order to detect GP end. */
-	unsigned long	gpnum;		/* Highest gp number that this CPU */
-					/*  is aware of having started. */
 	unsigned long	gp_seq;		/* Track rsp->rcu_gp_seq counter. */
 	unsigned long	gp_seq_needed;	/* Track rsp->rcu_gp_seq_needed ctr. */
 	unsigned long	rcu_qs_ctr_snap;/* Snapshot of rcu_qs_ctr to check */
@@ -203,7 +193,7 @@ struct rcu_data {
 	union rcu_noqs	cpu_no_qs;	/* No QSes yet for this CPU. */
 	bool		core_needs_qs;	/* Core waits for quiesc state. */
 	bool		beenonline;	/* CPU online at least once. */
-	bool		gpwrap;		/* Possible gpnum/completed wrap. */
+	bool		gpwrap;		/* Possible ->gp_seq wrap. */
 	struct rcu_node *mynode;	/* This CPU's leaf of hierarchy */
 	unsigned long grpmask;		/* Mask to apply to leaf qsmask. */
 	unsigned long	ticks_this_gp;	/* The number of scheduling-clock */
@@ -328,8 +318,6 @@ struct rcu_state {
 
 	u8	boost ____cacheline_internodealigned_in_smp;
 						/* Subject to priority boost. */
-	unsigned long gpnum;			/* Current gp number. */
-	unsigned long completed;		/* # of last completed gp. */
 	unsigned long gp_seq;			/* Grace-period sequence #. */
 	struct task_struct *gp_kthread;		/* Task for grace periods. */
 	struct swait_queue_head gp_wq;		/* Where GP task waits. */
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index c8a2c7760121..3a6e04103de1 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -690,7 +690,7 @@ static int rcu_print_task_exp_stall(struct rcu_node *rnp)
  * Check that the list of blocked tasks for the newly completed grace
  * period is in fact empty.  It is a serious bug to complete a grace
  * period that still has RCU readers blocked!  This function must be
- * invoked -before- updating this rnp's ->gpnum, and the rnp's ->lock
+ * invoked -before- updating this rnp's ->gp_seq, and the rnp's ->lock
  * must be held by the caller.
  *
  * Also, if there are blocked tasks on the list, they automatically
-- 
2.17.1

