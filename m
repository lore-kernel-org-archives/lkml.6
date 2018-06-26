Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F86C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5015C26326
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:13:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5015C26326
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935466AbeFZANE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 20:13:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40564 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S934338AbeFZAHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 20:07:04 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5Q03kZ2068840
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 20:07:03 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ju96qapmk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 20:07:03 -0400
Received: from localhost
        by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 25 Jun 2018 20:07:01 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e13.ny.us.ibm.com (146.89.104.200) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Jun 2018 20:06:58 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5Q06ub98454556
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Jun 2018 00:06:57 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 90512B2065;
        Mon, 25 Jun 2018 20:06:51 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5E1C0B205F;
        Mon, 25 Jun 2018 20:06:51 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 25 Jun 2018 20:06:51 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 54DA116CA0A4; Mon, 25 Jun 2018 17:09:01 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 18/40] rcu: Move from ->need_future_gp[] to ->gp_seq_needed
Date:   Mon, 25 Jun 2018 17:08:37 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626000841.GA15696@linux.vnet.ibm.com>
References: <20180626000841.GA15696@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062600-0064-0000-0000-000003202F95
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009255; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052327; UDB=6.00539464; IPR=6.00830253;
 MB=3.00021855; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-26 00:07:01
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062600-0065-0000-0000-000039B7444C
Message-Id: <20180626000859.23572-18-paulmck@linux.vnet.ibm.com>
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

One problem with the ->need_future_gp[] array is that the grace-period
assignment of each element changes as the grace periods complete.
This means that it is necessary to hold a lock when checking this
array to learn if a given grace period has already been requested.
This increase lock contention, which is the opposite of helpful.
This commit therefore replaces the ->need_future_gp[] with a single
->gp_seq_needed value and keeps it updated in the rcu_data structure.

This will enable reliable lockless checking of whether or not a given
grace period has already been requested.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree.c | 33 ++++++++++++++++++---------------
 kernel/rcu/tree.h | 19 ++-----------------
 2 files changed, 20 insertions(+), 32 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 779db9644177..e5d1369e099f 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1560,7 +1560,7 @@ static void trace_rcu_this_gp(struct rcu_node *rnp, struct rcu_data *rdp,
 /*
  * Start the specified grace period, as needed to handle newly arrived
  * callbacks.  The required future grace periods are recorded in each
- * rcu_node structure's ->need_future_gp[] field.  Returns true if there
+ * rcu_node structure's ->gp_seq_needed field.  Returns true if there
  * is reason to awaken the grace-period kthread.
  *
  * The caller must hold the specified rcu_node structure's ->lock, which
@@ -1589,14 +1589,14 @@ static bool rcu_start_this_gp(struct rcu_node *rnp, struct rcu_data *rdp,
 	for (rnp_root = rnp; 1; rnp_root = rnp_root->parent) {
 		if (rnp_root != rnp)
 			raw_spin_lock_rcu_node(rnp_root);
-		if (need_future_gp_element(rnp_root, c) ||
+		if (ULONG_CMP_GE(rnp_root->gp_seq_needed, c) ||
 		    rcu_seq_done(&rnp_root->gp_seq, c) ||
 		    (rnp != rnp_root &&
 		     rcu_seq_state(rcu_seq_current(&rnp_root->gp_seq)))) {
 			trace_rcu_this_gp(rnp_root, rdp, c, TPS("Prestarted"));
 			goto unlock_out;
 		}
-		need_future_gp_element(rnp_root, c) = true;
+		rnp_root->gp_seq_needed = c;
 		if (rnp_root != rnp && rnp_root->parent != NULL)
 			raw_spin_unlock_rcu_node(rnp_root);
 		if (!rnp_root->parent)
@@ -1633,8 +1633,9 @@ static bool rcu_future_gp_cleanup(struct rcu_state *rsp, struct rcu_node *rnp)
 	bool needmore;
 	struct rcu_data *rdp = this_cpu_ptr(rsp->rda);
 
-	need_future_gp_element(rnp, c) = false;
-	needmore = need_any_future_gp(rnp);
+	needmore = ULONG_CMP_LT(rnp->gp_seq, rnp->gp_seq_needed);
+	if (!needmore)
+		rnp->gp_seq_needed = rnp->gp_seq; /* Avoid counter wrap. */
 	trace_rcu_this_gp(rnp, rdp, c,
 			  needmore ? TPS("CleanupMore") : TPS("Cleanup"));
 	return needmore;
@@ -2046,7 +2047,7 @@ static void rcu_gp_cleanup(struct rcu_state *rsp)
 	rsp->gp_state = RCU_GP_IDLE;
 	/* Check for GP requests since above loop. */
 	rdp = this_cpu_ptr(rsp->rda);
-	if (need_any_future_gp(rnp)) {
+	if (ULONG_CMP_LT(rnp->gp_seq, rnp->gp_seq_needed)) {
 		trace_rcu_this_gp(rnp, rdp, rsp->completed - 1,
 				  TPS("CleanupMore"));
 		needgp = true;
@@ -2700,7 +2701,8 @@ rcu_check_gp_start_stall(struct rcu_state *rsp, struct rcu_node *rnp,
 	struct rcu_node *rnp_root = rcu_get_root(rsp);
 	static atomic_t warned = ATOMIC_INIT(0);
 
-	if (rcu_gp_in_progress(rsp) || !need_any_future_gp(rcu_get_root(rsp)))
+	if (rcu_gp_in_progress(rsp) ||
+	    ULONG_CMP_GE(rnp_root->gp_seq, rnp_root->gp_seq_needed))
 		return;
 	j = jiffies; /* Expensive access, and in common case don't get here. */
 	if (time_before(j, READ_ONCE(rsp->gp_req_activity) + HZ) ||
@@ -2710,7 +2712,8 @@ rcu_check_gp_start_stall(struct rcu_state *rsp, struct rcu_node *rnp,
 
 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
 	j = jiffies;
-	if (rcu_gp_in_progress(rsp) || !need_any_future_gp(rcu_get_root(rsp)) ||
+	if (rcu_gp_in_progress(rsp) ||
+	    ULONG_CMP_GE(rnp_root->gp_seq, rnp_root->gp_seq_needed) ||
 	    time_before(j, READ_ONCE(rsp->gp_req_activity) + HZ) ||
 	    time_before(j, READ_ONCE(rsp->gp_activity) + HZ) ||
 	    atomic_read(&warned)) {
@@ -2721,7 +2724,8 @@ rcu_check_gp_start_stall(struct rcu_state *rsp, struct rcu_node *rnp,
 
 	raw_spin_lock_rcu_node(rnp_root); /* irqs already disabled. */
 	j = jiffies;
-	if (rcu_gp_in_progress(rsp) || !need_any_future_gp(rcu_get_root(rsp)) ||
+	if (rcu_gp_in_progress(rsp) ||
+	    ULONG_CMP_GE(rnp_root->gp_seq, rnp_root->gp_seq_needed) ||
 	    time_before(j, rsp->gp_req_activity + HZ) ||
 	    time_before(j, rsp->gp_activity + HZ) ||
 	    atomic_xchg(&warned, 1)) {
@@ -2729,12 +2733,9 @@ rcu_check_gp_start_stall(struct rcu_state *rsp, struct rcu_node *rnp,
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 		return;
 	}
-	pr_alert("%s: g%lu %d%d%d%d gar:%lu ga:%lu f%#x %s->state:%#lx\n",
-		 __func__, READ_ONCE(rsp->gpnum),
-		 need_future_gp_element(rcu_get_root(rsp), 0),
-		 need_future_gp_element(rcu_get_root(rsp), 1),
-		 need_future_gp_element(rcu_get_root(rsp), 2),
-		 need_future_gp_element(rcu_get_root(rsp), 3),
+	pr_alert("%s: g%ld->%ld gar:%lu ga:%lu f%#x %s->state:%#lx\n",
+		 __func__, (long)READ_ONCE(rsp->gp_seq),
+		 (long)READ_ONCE(rnp_root->gp_seq_needed),
 		 j - rsp->gp_req_activity, j - rsp->gp_activity,
 		 rsp->gp_flags, rsp->name,
 		 rsp->gp_kthread ? rsp->gp_kthread->state : 0x1ffffL);
@@ -3524,6 +3525,7 @@ rcu_init_percpu_data(int cpu, struct rcu_state *rsp)
 	rdp->gpnum = rnp->completed; /* Make CPU later note any new GP. */
 	rdp->completed = rnp->completed;
 	rdp->gp_seq = rnp->gp_seq;
+	rdp->gp_seq_needed = rnp->gp_seq;
 	rdp->cpu_no_qs.b.norm = true;
 	rdp->rcu_qs_ctr_snap = per_cpu(rcu_dynticks.rcu_qs_ctr, cpu);
 	rdp->core_needs_qs = false;
@@ -3904,6 +3906,7 @@ static void __init rcu_init_one(struct rcu_state *rsp)
 			rnp->gpnum = rsp->gpnum;
 			rnp->completed = rsp->completed;
 			rnp->gp_seq = rsp->gp_seq;
+			rnp->gp_seq_needed = rsp->gp_seq;
 			rnp->completedqs = rsp->gp_seq;
 			rnp->qsmask = 0;
 			rnp->qsmaskinit = 0;
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index a21d403a6010..9329c1ff695f 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -88,6 +88,7 @@ struct rcu_node {
 				/*  This will either be equal to or one */
 				/*  behind the root rcu_node's gpnum. */
 	unsigned long gp_seq;	/* Track rsp->rcu_gp_seq. */
+	unsigned long gp_seq_needed; /* Track rsp->rcu_gp_seq_needed. */
 	unsigned long completedqs; /* All QSes done for this node. */
 	unsigned long qsmask;	/* CPUs or groups that need to switch in */
 				/*  order for current grace period to proceed.*/
@@ -160,7 +161,6 @@ struct rcu_node {
 	struct swait_queue_head nocb_gp_wq[2];
 				/* Place for rcu_nocb_kthread() to wait GP. */
 #endif /* #ifdef CONFIG_RCU_NOCB_CPU */
-	u8 need_future_gp[4];	/* Counts of upcoming GP requests. */
 	raw_spinlock_t fqslock ____cacheline_internodealigned_in_smp;
 
 	spinlock_t exp_lock ____cacheline_internodealigned_in_smp;
@@ -170,22 +170,6 @@ struct rcu_node {
 	bool exp_need_flush;	/* Need to flush workitem? */
 } ____cacheline_internodealigned_in_smp;
 
-/* Accessors for ->need_future_gp[] array. */
-#define need_future_gp_mask() \
-	(ARRAY_SIZE(((struct rcu_node *)NULL)->need_future_gp) - 1)
-#define need_future_gp_element(rnp, c) \
-	((rnp)->need_future_gp[(c >> RCU_SEQ_CTR_SHIFT) & need_future_gp_mask()])
-#define need_any_future_gp(rnp)						\
-({									\
-	int __i;							\
-	bool __nonzero = false;						\
-									\
-	for (__i = 0; __i < ARRAY_SIZE((rnp)->need_future_gp); __i++)	\
-		__nonzero = __nonzero ||				\
-			    READ_ONCE((rnp)->need_future_gp[__i]);	\
-	__nonzero;							\
-})
-
 /*
  * Bitmasks in an rcu_node cover the interval [grplo, grphi] of CPU IDs, and
  * are indexed relative to this interval rather than the global CPU ID space.
@@ -213,6 +197,7 @@ struct rcu_data {
 	unsigned long	gpnum;		/* Highest gp number that this CPU */
 					/*  is aware of having started. */
 	unsigned long	gp_seq;		/* Track rsp->rcu_gp_seq counter. */
+	unsigned long	gp_seq_needed;	/* Track rsp->rcu_gp_seq_needed ctr. */
 	unsigned long	rcu_qs_ctr_snap;/* Snapshot of rcu_qs_ctr to check */
 					/*  for rcu_all_qs() invocations. */
 	union rcu_noqs	cpu_no_qs;	/* No QSes yet for this CPU. */
-- 
2.17.1

