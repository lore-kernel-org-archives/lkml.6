Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86FE4C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49C36262F4
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:07:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49C36262F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935063AbeFZAHR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 20:07:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40562 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S934317AbeFZAHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 20:07:04 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5Q03kLd068862
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 20:07:03 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ju96qapms-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 20:07:03 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 25 Jun 2018 20:07:01 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Jun 2018 20:06:57 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5Q06uBs16515376
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Jun 2018 00:06:56 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A3647B2073;
        Mon, 25 Jun 2018 20:06:50 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7085BB2066;
        Mon, 25 Jun 2018 20:06:50 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 25 Jun 2018 20:06:50 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id E14C916CA092; Mon, 25 Jun 2018 17:09:00 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 01/40] rcu: Introduce grace-period sequence numbers
Date:   Mon, 25 Jun 2018 17:08:20 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626000841.GA15696@linux.vnet.ibm.com>
References: <20180626000841.GA15696@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062600-0064-0000-0000-000003202F8D
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009255; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052327; UDB=6.00539464; IPR=6.00830253;
 MB=3.00021855; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-26 00:07:00
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062600-0065-0000-0000-000039B74446
Message-Id: <20180626000859.23572-1-paulmck@linux.vnet.ibm.com>
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

This commit adds grace-period sequence numbers (->gp_seq) to the
rcu_state, rcu_node, and rcu_data structures, and updates them.
It also checks for consistency between rsp->gpnum and rsp->gp_seq.
These ->gp_seq counters will eventually replace the existing ->gpnum
and ->completed counters, allowing a single memory access to determine
whether or not a grace period is in progress and if so, which one.
This in turn will enable changes that will reduce ->lock contention on
the leaf rcu_node structures.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree.c | 16 +++++++++++++++-
 kernel/rcu/tree.h |  3 +++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 2db3475c2924..c50bb88dcab0 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -97,6 +97,7 @@ struct rcu_state sname##_state = { \
 	.gp_state = RCU_GP_IDLE, \
 	.gpnum = 0UL - 300UL, \
 	.completed = 0UL - 300UL, \
+	.gp_seq = (0UL - 300UL) << RCU_SEQ_CTR_SHIFT, \
 	.barrier_mutex = __MUTEX_INITIALIZER(sname##_state.barrier_mutex), \
 	.name = RCU_STATE_NAME(sname), \
 	.abbr = sabbr, \
@@ -1849,6 +1850,8 @@ static bool __note_gp_changes(struct rcu_state *rsp, struct rcu_node *rnp,
 		WRITE_ONCE(rdp->gpwrap, false);
 		rcu_gpnum_ovf(rnp, rdp);
 	}
+	if (rdp->gp_seq != rnp->gp_seq)
+		rdp->gp_seq = rnp->gp_seq;
 	return ret;
 }
 
@@ -1910,7 +1913,10 @@ static bool rcu_gp_init(struct rcu_state *rsp)
 	/* Advance to a new grace period and initialize state. */
 	record_gp_stall_check_time(rsp);
 	/* Record GP times before starting GP, hence smp_store_release(). */
+	WARN_ON_ONCE(rsp->gpnum << RCU_SEQ_CTR_SHIFT != rsp->gp_seq);
 	smp_store_release(&rsp->gpnum, rsp->gpnum + 1);
+	smp_mb(); /* Pairs with barriers in stall-warning code. */
+	rcu_seq_start(&rsp->gp_seq);
 	trace_rcu_grace_period(rsp->name, rsp->gpnum, TPS("start"));
 	raw_spin_unlock_irq_rcu_node(rnp);
 
@@ -1984,6 +1990,7 @@ static bool rcu_gp_init(struct rcu_state *rsp)
 		WRITE_ONCE(rnp->gpnum, rsp->gpnum);
 		if (WARN_ON_ONCE(rnp->completed != rsp->completed))
 			WRITE_ONCE(rnp->completed, rsp->completed);
+		WRITE_ONCE(rnp->gp_seq, rsp->gp_seq);
 		if (rnp == rdp->mynode)
 			(void)__note_gp_changes(rsp, rnp, rdp);
 		rcu_preempt_boost_start_gp(rnp);
@@ -2050,6 +2057,7 @@ static void rcu_gp_cleanup(struct rcu_state *rsp)
 {
 	unsigned long gp_duration;
 	bool needgp = false;
+	unsigned long new_gp_seq;
 	struct rcu_data *rdp;
 	struct rcu_node *rnp = rcu_get_root(rsp);
 	struct swait_queue_head *sq;
@@ -2079,12 +2087,15 @@ static void rcu_gp_cleanup(struct rcu_state *rsp)
 	 * all of the rcu_node structures before the beginning of the next
 	 * grace period is recorded in any of the rcu_node structures.
 	 */
+	new_gp_seq = rsp->gp_seq;
+	rcu_seq_end(&new_gp_seq);
 	rcu_for_each_node_breadth_first(rsp, rnp) {
 		raw_spin_lock_irq_rcu_node(rnp);
 		if (WARN_ON_ONCE(rcu_preempt_blocked_readers_cgp(rnp)))
 			dump_blkd_tasks(rnp, 10);
 		WARN_ON_ONCE(rnp->qsmask);
 		WRITE_ONCE(rnp->completed, rsp->gpnum);
+		WRITE_ONCE(rnp->gp_seq, new_gp_seq);
 		rdp = this_cpu_ptr(rsp->rda);
 		if (rnp == rdp->mynode)
 			needgp = __note_gp_changes(rsp, rnp, rdp) || needgp;
@@ -2098,10 +2109,11 @@ static void rcu_gp_cleanup(struct rcu_state *rsp)
 		rcu_gp_slow(rsp, gp_cleanup_delay);
 	}
 	rnp = rcu_get_root(rsp);
-	raw_spin_lock_irq_rcu_node(rnp); /* Order GP before ->completed update. */
+	raw_spin_lock_irq_rcu_node(rnp); /* GP before rsp->gp_seq update. */
 
 	/* Declare grace period done. */
 	WRITE_ONCE(rsp->completed, rsp->gpnum);
+	rcu_seq_end(&rsp->gp_seq);
 	trace_rcu_grace_period(rsp->name, rsp->completed, TPS("end"));
 	rsp->gp_state = RCU_GP_IDLE;
 	/* Check for GP requests since above loop. */
@@ -3609,6 +3621,7 @@ rcu_init_percpu_data(int cpu, struct rcu_state *rsp)
 	rdp->beenonline = true;	 /* We have now been online. */
 	rdp->gpnum = rnp->completed; /* Make CPU later note any new GP. */
 	rdp->completed = rnp->completed;
+	rdp->gp_seq = rnp->gp_seq;
 	rdp->cpu_no_qs.b.norm = true;
 	rdp->rcu_qs_ctr_snap = per_cpu(rcu_dynticks.rcu_qs_ctr, cpu);
 	rdp->core_needs_qs = false;
@@ -3988,6 +4001,7 @@ static void __init rcu_init_one(struct rcu_state *rsp)
 						   &rcu_fqs_class[i], fqs[i]);
 			rnp->gpnum = rsp->gpnum;
 			rnp->completed = rsp->completed;
+			rnp->gp_seq = rsp->gp_seq;
 			rnp->completedqs = rsp->completed;
 			rnp->qsmask = 0;
 			rnp->qsmaskinit = 0;
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 3c1942174c56..50a28d1cf5a1 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -87,6 +87,7 @@ struct rcu_node {
 	unsigned long completed; /* Last GP completed for this node. */
 				/*  This will either be equal to or one */
 				/*  behind the root rcu_node's gpnum. */
+	unsigned long gp_seq;	/* Track rsp->rcu_gp_seq. */
 	unsigned long completedqs; /* All QSes done for this node. */
 	unsigned long qsmask;	/* CPUs or groups that need to switch in */
 				/*  order for current grace period to proceed.*/
@@ -211,6 +212,7 @@ struct rcu_data {
 					/*  in order to detect GP end. */
 	unsigned long	gpnum;		/* Highest gp number that this CPU */
 					/*  is aware of having started. */
+	unsigned long	gp_seq;		/* Track rsp->rcu_gp_seq counter. */
 	unsigned long	rcu_qs_ctr_snap;/* Snapshot of rcu_qs_ctr to check */
 					/*  for rcu_all_qs() invocations. */
 	union rcu_noqs	cpu_no_qs;	/* No QSes yet for this CPU. */
@@ -343,6 +345,7 @@ struct rcu_state {
 						/* Subject to priority boost. */
 	unsigned long gpnum;			/* Current gp number. */
 	unsigned long completed;		/* # of last completed gp. */
+	unsigned long gp_seq;			/* Grace-period sequence #. */
 	struct task_struct *gp_kthread;		/* Task for grace periods. */
 	struct swait_queue_head gp_wq;		/* Where GP task waits. */
 	short gp_flags;				/* Commands for GP task. */
-- 
2.17.1

