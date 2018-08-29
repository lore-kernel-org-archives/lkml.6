Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 321B1C43334
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2CAE20644
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:39:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2CAE20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbeH3Ci5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 22:38:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39698 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727741AbeH3CiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 22:38:09 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7TMclQ5062267
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:39:05 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m61x8d8aj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:39:05 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 29 Aug 2018 18:39:04 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 29 Aug 2018 18:38:58 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7TMcvSV42533076
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Aug 2018 22:38:57 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A17A0B2077;
        Wed, 29 Aug 2018 18:37:53 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 701CCB2071;
        Wed, 29 Aug 2018 18:37:53 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 29 Aug 2018 18:37:53 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 9699516C91EB; Wed, 29 Aug 2018 15:38:56 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 40/52] rcu: Remove rsp parameter from rcu_node tree accessor macros
Date:   Wed, 29 Aug 2018 15:38:42 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829223830.GA1800@linux.vnet.ibm.com>
References: <20180829223830.GA1800@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18082922-0040-0000-0000-000004675845
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009636; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01080744; UDB=6.00557497; IPR=6.00860730;
 MB=3.00023002; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-29 22:39:02
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082922-0041-0000-0000-0000086E721E
Message-Id: <20180829223854.4055-40-paulmck@linux.vnet.ibm.com>
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

There now is only one rcu_state structure in a given build of the Linux
kernel, so there is no need to pass it as a parameter to RCU's rcu_node
tree's accessor macros.  This commit therefore removes the rsp parameter
from those macros in kernel/rcu/rcu.h, and removes some now-unused rsp
local variables while in the area.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 .../Data-Structures/Data-Structures.html      | 23 +++++----------
 kernel/rcu/rcu.h                              | 28 ++++++++-----------
 kernel/rcu/srcutree.c                         |  4 +--
 kernel/rcu/tree.c                             | 19 ++++++-------
 kernel/rcu/tree_exp.h                         | 18 ++++++------
 kernel/rcu/tree_plugin.h                      |  4 +--
 6 files changed, 40 insertions(+), 56 deletions(-)

diff --git a/Documentation/RCU/Design/Data-Structures/Data-Structures.html b/Documentation/RCU/Design/Data-Structures/Data-Structures.html
index f5120a00f511..772c26a3865a 100644
--- a/Documentation/RCU/Design/Data-Structures/Data-Structures.html
+++ b/Documentation/RCU/Design/Data-Structures/Data-Structures.html
@@ -1372,8 +1372,7 @@ that is, if the CPU is currently idle.
 Accessor Functions</a></h3>
 
 <p>The following listing shows the
-<tt>rcu_get_root()</tt>, <tt>rcu_for_each_node_breadth_first</tt>,
-<tt>rcu_for_each_nonleaf_node_breadth_first()</tt>, and
+<tt>rcu_get_root()</tt>, <tt>rcu_for_each_node_breadth_first</tt> and
 <tt>rcu_for_each_leaf_node()</tt> function and macros:
 
 <pre>
@@ -1386,13 +1385,9 @@ Accessor Functions</a></h3>
   7   for ((rnp) = &amp;(rsp)-&gt;node[0]; \
   8        (rnp) &lt; &amp;(rsp)-&gt;node[NUM_RCU_NODES]; (rnp)++)
   9
- 10 #define rcu_for_each_nonleaf_node_breadth_first(rsp, rnp) \
- 11   for ((rnp) = &amp;(rsp)-&gt;node[0]; \
- 12        (rnp) &lt; (rsp)-&gt;level[NUM_RCU_LVLS - 1]; (rnp)++)
- 13
- 14 #define rcu_for_each_leaf_node(rsp, rnp) \
- 15   for ((rnp) = (rsp)-&gt;level[NUM_RCU_LVLS - 1]; \
- 16        (rnp) &lt; &amp;(rsp)-&gt;node[NUM_RCU_NODES]; (rnp)++)
+ 10 #define rcu_for_each_leaf_node(rsp, rnp) \
+ 11   for ((rnp) = (rsp)-&gt;level[NUM_RCU_LVLS - 1]; \
+ 12        (rnp) &lt; &amp;(rsp)-&gt;node[NUM_RCU_NODES]; (rnp)++)
 </pre>
 
 <p>The <tt>rcu_get_root()</tt> simply returns a pointer to the
@@ -1405,10 +1400,7 @@ macro takes advantage of the layout of the <tt>rcu_node</tt>
 structures in the <tt>rcu_state</tt> structure's
 <tt>-&gt;node[]</tt> array, performing a breadth-first traversal by
 simply traversing the array in order.
-The <tt>rcu_for_each_nonleaf_node_breadth_first()</tt> macro operates
-similarly, but traverses only the first part of the array, thus excluding
-the leaf <tt>rcu_node</tt> structures.
-Finally, the <tt>rcu_for_each_leaf_node()</tt> macro traverses only
+Similarly, the <tt>rcu_for_each_leaf_node()</tt> macro traverses only
 the last part of the array, thus traversing only the leaf
 <tt>rcu_node</tt> structures.
 
@@ -1416,15 +1408,14 @@ the last part of the array, thus traversing only the leaf
 <tr><th>&nbsp;</th></tr>
 <tr><th align="left">Quick Quiz:</th></tr>
 <tr><td>
-	What do <tt>rcu_for_each_nonleaf_node_breadth_first()</tt> and
+	What does
 	<tt>rcu_for_each_leaf_node()</tt> do if the <tt>rcu_node</tt> tree
 	contains only a single node?
 </td></tr>
 <tr><th align="left">Answer:</th></tr>
 <tr><td bgcolor="#ffffff"><font color="ffffff">
 	In the single-node case,
-	<tt>rcu_for_each_nonleaf_node_breadth_first()</tt> is a no-op
-	and <tt>rcu_for_each_leaf_node()</tt> traverses the single node.
+	<tt>rcu_for_each_leaf_node()</tt> traverses the single node.
 </font></td></tr>
 <tr><td>&nbsp;</td></tr>
 </table>
diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 4d04683c31b2..2bb77fddc11f 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -329,29 +329,23 @@ static inline void rcu_init_levelspread(int *levelspread, const int *levelcnt)
 }
 
 /* Returns first leaf rcu_node of the specified RCU flavor. */
-#define rcu_first_leaf_node(rsp) ((rsp)->level[rcu_num_lvls - 1])
+#define rcu_first_leaf_node() (rcu_state.level[rcu_num_lvls - 1])
 
 /* Is this rcu_node a leaf? */
 #define rcu_is_leaf_node(rnp) ((rnp)->level == rcu_num_lvls - 1)
 
 /* Is this rcu_node the last leaf? */
-#define rcu_is_last_leaf_node(rsp, rnp) ((rnp) == &(rsp)->node[rcu_num_nodes - 1])
+#define rcu_is_last_leaf_node(rnp) ((rnp) == &rcu_state.node[rcu_num_nodes - 1])
 
 /*
- * Do a full breadth-first scan of the rcu_node structures for the
+ * Do a full breadth-first scan of the {s,}rcu_node structures for the
  * specified rcu_state structure.
  */
-#define rcu_for_each_node_breadth_first(rsp, rnp) \
-	for ((rnp) = &(rsp)->node[0]; \
-	     (rnp) < &(rsp)->node[rcu_num_nodes]; (rnp)++)
-
-/*
- * Do a breadth-first scan of the non-leaf rcu_node structures for the
- * specified rcu_state structure.  Note that if there is a singleton
- * rcu_node tree with but one rcu_node structure, this loop is a no-op.
- */
-#define rcu_for_each_nonleaf_node_breadth_first(rsp, rnp) \
-	for ((rnp) = &(rsp)->node[0]; !rcu_is_leaf_node(rsp, rnp); (rnp)++)
+#define srcu_for_each_node_breadth_first(sp, rnp) \
+	for ((rnp) = &(sp)->node[0]; \
+	     (rnp) < &(sp)->node[rcu_num_nodes]; (rnp)++)
+#define rcu_for_each_node_breadth_first(rnp) \
+	srcu_for_each_node_breadth_first(&rcu_state, rnp)
 
 /*
  * Scan the leaves of the rcu_node hierarchy for the specified rcu_state
@@ -359,9 +353,9 @@ static inline void rcu_init_levelspread(int *levelspread, const int *levelcnt)
  * one rcu_node structure, this loop -will- visit the rcu_node structure.
  * It is still a leaf node, even if it is also the root node.
  */
-#define rcu_for_each_leaf_node(rsp, rnp) \
-	for ((rnp) = rcu_first_leaf_node(rsp); \
-	     (rnp) < &(rsp)->node[rcu_num_nodes]; (rnp)++)
+#define rcu_for_each_leaf_node(rnp) \
+	for ((rnp) = rcu_first_leaf_node(); \
+	     (rnp) < &rcu_state.node[rcu_num_nodes]; (rnp)++)
 
 /*
  * Iterate over all possible CPUs in a leaf RCU node.
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 6c9866a854b1..2042080cd38b 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -105,7 +105,7 @@ static void init_srcu_struct_nodes(struct srcu_struct *sp, bool is_static)
 	rcu_init_levelspread(levelspread, num_rcu_lvl);
 
 	/* Each pass through this loop initializes one srcu_node structure. */
-	rcu_for_each_node_breadth_first(sp, snp) {
+	srcu_for_each_node_breadth_first(sp, snp) {
 		spin_lock_init(&ACCESS_PRIVATE(snp, lock));
 		WARN_ON_ONCE(ARRAY_SIZE(snp->srcu_have_cbs) !=
 			     ARRAY_SIZE(snp->srcu_data_have_cbs));
@@ -561,7 +561,7 @@ static void srcu_gp_end(struct srcu_struct *sp)
 
 	/* Initiate callback invocation as needed. */
 	idx = rcu_seq_ctr(gpseq) % ARRAY_SIZE(snp->srcu_have_cbs);
-	rcu_for_each_node_breadth_first(sp, snp) {
+	srcu_for_each_node_breadth_first(sp, snp) {
 		spin_lock_irq_rcu_node(snp);
 		cbs = false;
 		last_lvl = snp >= sp->level[rcu_num_lvls - 1];
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index c3031b566851..35b705c1da40 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -573,7 +573,7 @@ void show_rcu_gp_kthreads(void)
 	for_each_rcu_flavor(rsp) {
 		pr_info("%s: wait state: %d ->state: %#lx\n",
 			rsp->name, rsp->gp_state, rsp->gp_kthread->state);
-		rcu_for_each_node_breadth_first(rsp, rnp) {
+		rcu_for_each_node_breadth_first(rnp) {
 			if (ULONG_CMP_GE(rsp->gp_seq, rnp->gp_seq_needed))
 				continue;
 			pr_info("\trcu_node %d:%d ->gp_seq %lu ->gp_seq_needed %lu\n",
@@ -1275,7 +1275,7 @@ static void rcu_dump_cpu_stacks(void)
 	unsigned long flags;
 	struct rcu_node *rnp;
 
-	rcu_for_each_leaf_node(&rcu_state, rnp) {
+	rcu_for_each_leaf_node(rnp) {
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
 		for_each_leaf_node_possible_cpu(rnp, cpu)
 			if (rnp->qsmask & leaf_node_cpu_bit(rnp, cpu))
@@ -1335,7 +1335,7 @@ static void print_other_cpu_stall(unsigned long gp_seq)
 	 */
 	pr_err("INFO: %s detected stalls on CPUs/tasks:", rsp->name);
 	print_cpu_stall_info_begin();
-	rcu_for_each_leaf_node(rsp, rnp) {
+	rcu_for_each_leaf_node(rnp) {
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
 		ndetected += rcu_print_task_stall(rnp);
 		if (rnp->qsmask != 0) {
@@ -1872,7 +1872,7 @@ static bool rcu_gp_init(void)
 	 * will handle subsequent offline CPUs.
 	 */
 	rsp->gp_state = RCU_GP_ONOFF;
-	rcu_for_each_leaf_node(rsp, rnp) {
+	rcu_for_each_leaf_node(rnp) {
 		spin_lock(&rsp->ofl_lock);
 		raw_spin_lock_irq_rcu_node(rnp);
 		if (rnp->qsmaskinit == rnp->qsmaskinitnext &&
@@ -1932,7 +1932,7 @@ static bool rcu_gp_init(void)
 	 * process finishes, because this kthread handles both.
 	 */
 	rsp->gp_state = RCU_GP_INIT;
-	rcu_for_each_node_breadth_first(rsp, rnp) {
+	rcu_for_each_node_breadth_first(rnp) {
 		rcu_gp_slow(gp_init_delay);
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
 		rdp = this_cpu_ptr(&rcu_data);
@@ -2045,7 +2045,7 @@ static void rcu_gp_cleanup(void)
 	 */
 	new_gp_seq = rsp->gp_seq;
 	rcu_seq_end(&new_gp_seq);
-	rcu_for_each_node_breadth_first(rsp, rnp) {
+	rcu_for_each_node_breadth_first(rnp) {
 		raw_spin_lock_irq_rcu_node(rnp);
 		if (WARN_ON_ONCE(rcu_preempt_blocked_readers_cgp(rnp)))
 			dump_blkd_tasks(rnp, 10);
@@ -2605,9 +2605,8 @@ static void force_qs_rnp(int (*f)(struct rcu_data *rsp))
 	unsigned long flags;
 	unsigned long mask;
 	struct rcu_node *rnp;
-	struct rcu_state *rsp = &rcu_state;
 
-	rcu_for_each_leaf_node(rsp, rnp) {
+	rcu_for_each_leaf_node(rnp) {
 		cond_resched_tasks_rcu_qs();
 		mask = 0;
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
@@ -3777,7 +3776,7 @@ static void __init rcu_init_one(void)
 
 	init_swait_queue_head(&rsp->gp_wq);
 	init_swait_queue_head(&rsp->expedited_wq);
-	rnp = rcu_first_leaf_node(rsp);
+	rnp = rcu_first_leaf_node();
 	for_each_possible_cpu(i) {
 		while (i > rnp->grphi)
 			rnp++;
@@ -3877,7 +3876,7 @@ static void __init rcu_dump_rcu_node_tree(void)
 
 	pr_info("rcu_node tree layout dump\n");
 	pr_info(" ");
-	rcu_for_each_node_breadth_first(&rcu_state, rnp) {
+	rcu_for_each_node_breadth_first(rnp) {
 		if (rnp->level != level) {
 			pr_cont("\n");
 			pr_info(" ");
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index b6f7bc34ac49..060bdb45cd95 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -97,7 +97,7 @@ static void sync_exp_reset_tree_hotplug(void)
 	 * Each pass through the following loop propagates newly onlined
 	 * CPUs for the current rcu_node structure up the rcu_node tree.
 	 */
-	rcu_for_each_leaf_node(&rcu_state, rnp) {
+	rcu_for_each_leaf_node(rnp) {
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
 		if (rnp->expmaskinit == rnp->expmaskinitnext) {
 			raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
@@ -141,7 +141,7 @@ static void __maybe_unused sync_exp_reset_tree(void)
 	struct rcu_node *rnp;
 
 	sync_exp_reset_tree_hotplug();
-	rcu_for_each_node_breadth_first(&rcu_state, rnp) {
+	rcu_for_each_node_breadth_first(rnp) {
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
 		WARN_ON_ONCE(rnp->expmask);
 		rnp->expmask = rnp->expmaskinit;
@@ -438,14 +438,14 @@ static void sync_rcu_exp_select_cpus(smp_call_func_t func)
 	trace_rcu_exp_grace_period(rcu_state.name, rcu_exp_gp_seq_endval(), TPS("select"));
 
 	/* Schedule work for each leaf rcu_node structure. */
-	rcu_for_each_leaf_node(&rcu_state, rnp) {
+	rcu_for_each_leaf_node(rnp) {
 		rnp->exp_need_flush = false;
 		if (!READ_ONCE(rnp->expmask))
 			continue; /* Avoid early boot non-existent wq. */
 		rnp->rew.rew_func = func;
 		if (!READ_ONCE(rcu_par_gp_wq) ||
 		    rcu_scheduler_active != RCU_SCHEDULER_RUNNING ||
-		    rcu_is_last_leaf_node(&rcu_state, rnp)) {
+		    rcu_is_last_leaf_node(rnp)) {
 			/* No workqueues yet or last leaf, do direct call. */
 			sync_rcu_exp_select_node_cpus(&rnp->rew.rew_work);
 			continue;
@@ -462,7 +462,7 @@ static void sync_rcu_exp_select_cpus(smp_call_func_t func)
 	}
 
 	/* Wait for workqueue jobs (if any) to complete. */
-	rcu_for_each_leaf_node(&rcu_state, rnp)
+	rcu_for_each_leaf_node(rnp)
 		if (rnp->exp_need_flush)
 			flush_work(&rnp->rew.rew_work);
 }
@@ -496,7 +496,7 @@ static void synchronize_sched_expedited_wait(void)
 		pr_err("INFO: %s detected expedited stalls on CPUs/tasks: {",
 		       rcu_state.name);
 		ndetected = 0;
-		rcu_for_each_leaf_node(&rcu_state, rnp) {
+		rcu_for_each_leaf_node(rnp) {
 			ndetected += rcu_print_task_exp_stall(rnp);
 			for_each_leaf_node_possible_cpu(rnp, cpu) {
 				struct rcu_data *rdp;
@@ -517,7 +517,7 @@ static void synchronize_sched_expedited_wait(void)
 			rnp_root->expmask, ".T"[!!rnp_root->exp_tasks]);
 		if (ndetected) {
 			pr_err("blocking rcu_node structures:");
-			rcu_for_each_node_breadth_first(&rcu_state, rnp) {
+			rcu_for_each_node_breadth_first(rnp) {
 				if (rnp == rnp_root)
 					continue; /* printed unconditionally */
 				if (sync_rcu_preempt_exp_done_unlocked(rnp))
@@ -529,7 +529,7 @@ static void synchronize_sched_expedited_wait(void)
 			}
 			pr_cont("\n");
 		}
-		rcu_for_each_leaf_node(&rcu_state, rnp) {
+		rcu_for_each_leaf_node(rnp) {
 			for_each_leaf_node_possible_cpu(rnp, cpu) {
 				mask = leaf_node_cpu_bit(rnp, cpu);
 				if (!(rnp->expmask & mask))
@@ -561,7 +561,7 @@ static void rcu_exp_wait_wake(unsigned long s)
 	 */
 	mutex_lock(&rcu_state.exp_wake_mutex);
 
-	rcu_for_each_node_breadth_first(&rcu_state, rnp) {
+	rcu_for_each_node_breadth_first(rnp) {
 		if (ULONG_CMP_LT(READ_ONCE(rnp->exp_seq_rq), s)) {
 			spin_lock(&rnp->exp_lock);
 			/* Recheck, avoid hang in case someone just arrived. */
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index e6ec25e47d00..b60d3df92ff5 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -687,7 +687,7 @@ static void rcu_print_detail_task_stall(void)
 	struct rcu_node *rnp = rcu_get_root();
 
 	rcu_print_detail_task_stall_rnp(rnp);
-	rcu_for_each_leaf_node(&rcu_state, rnp)
+	rcu_for_each_leaf_node(rnp)
 		rcu_print_detail_task_stall_rnp(rnp);
 }
 
@@ -1427,7 +1427,7 @@ static void __init rcu_spawn_boost_kthreads(void)
 	for_each_possible_cpu(cpu)
 		per_cpu(rcu_cpu_has_work, cpu) = 0;
 	BUG_ON(smpboot_register_percpu_thread(&rcu_cpu_thread_spec));
-	rcu_for_each_leaf_node(&rcu_state, rnp)
+	rcu_for_each_leaf_node(rnp)
 		(void)rcu_spawn_one_boost_kthread(rnp);
 }
 
-- 
2.17.1

