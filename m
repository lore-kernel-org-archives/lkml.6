Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDCFC43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 23:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2265B2627B
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 23:03:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2265B2627B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934543AbeFYXD1 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 19:03:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49898 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754824AbeFYXCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 19:02:30 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5PMwsFc117684
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 19:02:30 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ju96p12cu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 19:02:30 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 25 Jun 2018 19:02:29 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Jun 2018 19:02:25 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5PN2OlY2818422
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 25 Jun 2018 23:02:24 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B2F95B2066;
        Mon, 25 Jun 2018 19:02:18 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8B74AB206E;
        Mon, 25 Jun 2018 19:02:18 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 25 Jun 2018 19:02:18 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id DF96B16CA094; Mon, 25 Jun 2018 16:04:28 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 1/5] rcu: Add debugging info to assertion
Date:   Mon, 25 Jun 2018 16:04:23 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180625230410.GA13250@linux.vnet.ibm.com>
References: <20180625230410.GA13250@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062523-2213-0000-0000-000002BFD920
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009255; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052306; UDB=6.00539451; IPR=6.00830231;
 MB=3.00021855; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-25 23:02:28
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062523-2214-0000-0000-00005A9B7393
Message-Id: <20180625230427.13877-1-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-25_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806250260
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The WARN_ON_ONCE(rcu_preempt_blocked_readers_cgp()) in
rcu_gp_cleanup() triggers (inexplicably, of course) every so often.
This commit therefore extracts more information.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree.c        |  5 ++++-
 kernel/rcu/tree.h        |  2 ++
 kernel/rcu/tree_plugin.h | 38 ++++++++++++++++++++++++++++++++++++--
 3 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index aa7cade1b9f3..79c7fe978b17 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2084,7 +2084,8 @@ static void rcu_gp_cleanup(struct rcu_state *rsp)
 	 */
 	rcu_for_each_node_breadth_first(rsp, rnp) {
 		raw_spin_lock_irq_rcu_node(rnp);
-		WARN_ON_ONCE(rcu_preempt_blocked_readers_cgp(rnp));
+		if (WARN_ON_ONCE(rcu_preempt_blocked_readers_cgp(rnp)))
+			dump_blkd_tasks(rnp, 10);
 		WARN_ON_ONCE(rnp->qsmask);
 		WRITE_ONCE(rnp->completed, rsp->gpnum);
 		rdp = this_cpu_ptr(rsp->rda);
@@ -2294,6 +2295,7 @@ rcu_report_qs_rnp(unsigned long mask, struct rcu_state *rsp,
 			raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 			return;
 		}
+		rnp->completedqs = rnp->gpnum;
 		mask = rnp->grpmask;
 		if (rnp->parent == NULL) {
 
@@ -3930,6 +3932,7 @@ static void __init rcu_init_one(struct rcu_state *rsp)
 						   &rcu_fqs_class[i], fqs[i]);
 			rnp->gpnum = rsp->gpnum;
 			rnp->completed = rsp->completed;
+			rnp->completedqs = rsp->completed;
 			rnp->qsmask = 0;
 			rnp->qsmaskinit = 0;
 			rnp->grplo = j * cpustride;
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 78e051dffc5b..7365ac53fdd9 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -87,6 +87,7 @@ struct rcu_node {
 	unsigned long completed; /* Last GP completed for this node. */
 				/*  This will either be equal to or one */
 				/*  behind the root rcu_node's gpnum. */
+	unsigned long completedqs; /* All QSes done for this node. */
 	unsigned long qsmask;	/* CPUs or groups that need to switch in */
 				/*  order for current grace period to proceed.*/
 				/*  In leaf rcu_node, each bit corresponds to */
@@ -453,6 +454,7 @@ static void rcu_preempt_check_blocked_tasks(struct rcu_node *rnp);
 static void rcu_preempt_check_callbacks(void);
 void call_rcu(struct rcu_head *head, rcu_callback_t func);
 static void __init __rcu_init_preempt(void);
+static void dump_blkd_tasks(struct rcu_node *rnp, int ncheck);
 static void rcu_initiate_boost(struct rcu_node *rnp, unsigned long flags);
 static void rcu_preempt_boost_start_gp(struct rcu_node *rnp);
 static void invoke_rcu_callbacks_kthread(void);
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 7fd12039e512..17b67ecf7dff 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -260,8 +260,10 @@ static void rcu_preempt_ctxt_queue(struct rcu_node *rnp, struct rcu_data *rdp)
 	 * ->exp_tasks pointers, respectively, to reference the newly
 	 * blocked tasks.
 	 */
-	if (!rnp->gp_tasks && (blkd_state & RCU_GP_BLKD))
+	if (!rnp->gp_tasks && (blkd_state & RCU_GP_BLKD)) {
 		rnp->gp_tasks = &t->rcu_node_entry;
+		WARN_ON_ONCE(rnp->completedqs == rnp->gpnum);
+	}
 	if (!rnp->exp_tasks && (blkd_state & RCU_EXP_BLKD))
 		rnp->exp_tasks = &t->rcu_node_entry;
 	WARN_ON_ONCE(!(blkd_state & RCU_GP_BLKD) !=
@@ -535,6 +537,8 @@ void rcu_read_unlock_special(struct task_struct *t)
 		WARN_ON_ONCE(rnp != t->rcu_blocked_node);
 		WARN_ON_ONCE(!rcu_is_leaf_node(rnp));
 		empty_norm = !rcu_preempt_blocked_readers_cgp(rnp);
+		WARN_ON_ONCE(rnp->completedqs == rnp->gpnum &&
+			     (!empty_norm || rnp->qsmask));
 		empty_exp = sync_rcu_preempt_exp_done(rnp);
 		smp_mb(); /* ensure expedited fastpath sees end of RCU c-s. */
 		np = rcu_next_node_entry(t, rnp);
@@ -697,7 +701,8 @@ static void rcu_preempt_check_blocked_tasks(struct rcu_node *rnp)
 	struct task_struct *t;
 
 	RCU_LOCKDEP_WARN(preemptible(), "rcu_preempt_check_blocked_tasks() invoked with preemption enabled!!!\n");
-	WARN_ON_ONCE(rcu_preempt_blocked_readers_cgp(rnp));
+	if (WARN_ON_ONCE(rcu_preempt_blocked_readers_cgp(rnp)))
+		dump_blkd_tasks(rnp, 10);
 	if (rcu_preempt_has_tasks(rnp)) {
 		rnp->gp_tasks = rnp->blkd_tasks.next;
 		t = container_of(rnp->gp_tasks, struct task_struct,
@@ -841,6 +846,27 @@ void exit_rcu(void)
 	__rcu_read_unlock();
 }
 
+/*
+ * Dump the blocked-tasks state, but limit the list dump to the
+ * specified number of elements.
+ */
+static void dump_blkd_tasks(struct rcu_node *rnp, int ncheck)
+{
+	int i;
+	struct list_head *lhp;
+
+	lockdep_assert_held(&rnp->lock);
+	pr_info("%s: grp: %d-%d level: %d ->qamask %#lx ->gp_tasks %p ->boost_tasks %p ->exp_tasks %p &->blkd_tasks: %p offset: %u\n", __func__, rnp->grplo, rnp->grphi, rnp->level, rnp->qsmask, rnp->gp_tasks, rnp->boost_tasks, rnp->exp_tasks, &rnp->blkd_tasks, (unsigned int)offsetof(typeof(*rnp), blkd_tasks));
+	pr_cont("\t->blkd_tasks");
+	i = 0;
+	list_for_each(lhp, &rnp->blkd_tasks) {
+		pr_cont(" %p", lhp);
+		if (++i >= 10)
+			break;
+	}
+	pr_cont("\n");
+}
+
 #else /* #ifdef CONFIG_PREEMPT_RCU */
 
 static struct rcu_state *const rcu_state_p = &rcu_sched_state;
@@ -949,6 +975,14 @@ void exit_rcu(void)
 {
 }
 
+/*
+ * Dump the guaranteed-empty blocked-tasks state.  Trust but verify.
+ */
+static void dump_blkd_tasks(struct rcu_node *rnp, int ncheck)
+{
+	WARN_ON_ONCE(!list_empty(&rnp->blkd_tasks));
+}
+
 #endif /* #else #ifdef CONFIG_PREEMPT_RCU */
 
 #ifdef CONFIG_RCU_BOOST
-- 
2.17.1

