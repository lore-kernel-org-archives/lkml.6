Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D446C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E21A20647
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:43:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E21A20647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbeH3Cmh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 22:42:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38220 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727522AbeH3CiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 22:38:06 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7TMci5f016487
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:39:03 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m64f000kp-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:39:02 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 29 Aug 2018 18:39:01 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 29 Aug 2018 18:38:57 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7TMcuU127328688
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Aug 2018 22:38:56 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D8E2FB205F;
        Wed, 29 Aug 2018 18:37:51 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A9E71B206A;
        Wed, 29 Aug 2018 18:37:51 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 29 Aug 2018 18:37:51 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id CFFE916C91CA; Wed, 29 Aug 2018 15:38:55 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 06/52] rcu: Remove rsp parameter from rcu_get_root()
Date:   Wed, 29 Aug 2018 15:38:08 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829223830.GA1800@linux.vnet.ibm.com>
References: <20180829223830.GA1800@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18082922-0052-0000-0000-0000032820C7
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009636; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01080744; UDB=6.00557498; IPR=6.00860730;
 MB=3.00023002; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-29 22:39:00
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082922-0053-0000-0000-00005DE5FB1C
Message-Id: <20180829223854.4055-6-paulmck@linux.vnet.ibm.com>
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

There now is only one rcu_state structure in a given build of the
Linux kernel, so there is no need to pass it as a parameter to RCU's
functions.  This commit therefore removes the rsp parameter from
rcu_get_root().

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree.c        | 38 +++++++++++++++++++-------------------
 kernel/rcu/tree_exp.h    |  6 +++---
 kernel/rcu/tree_plugin.h |  2 +-
 3 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 605e1c990619..9a40692f980d 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -623,9 +623,9 @@ EXPORT_SYMBOL_GPL(rcutorture_get_gp_data);
 /*
  * Return the root node of the specified rcu_state structure.
  */
-static struct rcu_node *rcu_get_root(struct rcu_state *rsp)
+static struct rcu_node *rcu_get_root(void)
 {
-	return &rsp->node[0];
+	return &rcu_state.node[0];
 }
 
 /*
@@ -1317,7 +1317,7 @@ static void print_other_cpu_stall(struct rcu_state *rsp, unsigned long gp_seq)
 	unsigned long gpa;
 	unsigned long j;
 	int ndetected = 0;
-	struct rcu_node *rnp = rcu_get_root(rsp);
+	struct rcu_node *rnp = rcu_get_root();
 	long totqlen = 0;
 
 	/* Kick and suppress, if so configured. */
@@ -1366,7 +1366,7 @@ static void print_other_cpu_stall(struct rcu_state *rsp, unsigned long gp_seq)
 			pr_err("All QSes seen, last %s kthread activity %ld (%ld-%ld), jiffies_till_next_fqs=%ld, root ->qsmask %#lx\n",
 			       rsp->name, j - gpa, j, gpa,
 			       jiffies_till_next_fqs,
-			       rcu_get_root(rsp)->qsmask);
+			       rcu_get_root()->qsmask);
 			/* In this case, the current CPU might be at fault. */
 			sched_show_task(current);
 		}
@@ -1388,7 +1388,7 @@ static void print_cpu_stall(struct rcu_state *rsp)
 	int cpu;
 	unsigned long flags;
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
-	struct rcu_node *rnp = rcu_get_root(rsp);
+	struct rcu_node *rnp = rcu_get_root();
 	long totqlen = 0;
 
 	/* Kick and suppress, if so configured. */
@@ -1834,7 +1834,7 @@ static bool rcu_gp_init(struct rcu_state *rsp)
 	unsigned long oldmask;
 	unsigned long mask;
 	struct rcu_data *rdp;
-	struct rcu_node *rnp = rcu_get_root(rsp);
+	struct rcu_node *rnp = rcu_get_root();
 
 	WRITE_ONCE(rsp->gp_activity, jiffies);
 	raw_spin_lock_irq_rcu_node(rnp);
@@ -1961,7 +1961,7 @@ static bool rcu_gp_init(struct rcu_state *rsp)
  */
 static bool rcu_gp_fqs_check_wake(struct rcu_state *rsp, int *gfp)
 {
-	struct rcu_node *rnp = rcu_get_root(rsp);
+	struct rcu_node *rnp = rcu_get_root();
 
 	/* Someone like call_rcu() requested a force-quiescent-state scan. */
 	*gfp = READ_ONCE(rsp->gp_flags);
@@ -1980,7 +1980,7 @@ static bool rcu_gp_fqs_check_wake(struct rcu_state *rsp, int *gfp)
  */
 static void rcu_gp_fqs(struct rcu_state *rsp, bool first_time)
 {
-	struct rcu_node *rnp = rcu_get_root(rsp);
+	struct rcu_node *rnp = rcu_get_root();
 
 	WRITE_ONCE(rsp->gp_activity, jiffies);
 	rsp->n_force_qs++;
@@ -2009,7 +2009,7 @@ static void rcu_gp_cleanup(struct rcu_state *rsp)
 	bool needgp = false;
 	unsigned long new_gp_seq;
 	struct rcu_data *rdp;
-	struct rcu_node *rnp = rcu_get_root(rsp);
+	struct rcu_node *rnp = rcu_get_root();
 	struct swait_queue_head *sq;
 
 	WRITE_ONCE(rsp->gp_activity, jiffies);
@@ -2057,7 +2057,7 @@ static void rcu_gp_cleanup(struct rcu_state *rsp)
 		WRITE_ONCE(rsp->gp_activity, jiffies);
 		rcu_gp_slow(rsp, gp_cleanup_delay);
 	}
-	rnp = rcu_get_root(rsp);
+	rnp = rcu_get_root();
 	raw_spin_lock_irq_rcu_node(rnp); /* GP before rsp->gp_seq update. */
 
 	/* Declare grace period done. */
@@ -2093,7 +2093,7 @@ static int __noreturn rcu_gp_kthread(void *arg)
 	unsigned long j;
 	int ret;
 	struct rcu_state *rsp = arg;
-	struct rcu_node *rnp = rcu_get_root(rsp);
+	struct rcu_node *rnp = rcu_get_root();
 
 	rcu_bind_gp_kthread();
 	for (;;) {
@@ -2189,14 +2189,14 @@ static int __noreturn rcu_gp_kthread(void *arg)
  * which is released before return.
  */
 static void rcu_report_qs_rsp(unsigned long flags)
-	__releases(rcu_get_root(rsp)->lock)
+	__releases(rcu_get_root()->lock)
 {
 	struct rcu_state *rsp = &rcu_state;
 
-	raw_lockdep_assert_held_rcu_node(rcu_get_root(rsp));
+	raw_lockdep_assert_held_rcu_node(rcu_get_root());
 	WARN_ON_ONCE(!rcu_gp_in_progress());
 	WRITE_ONCE(rsp->gp_flags, READ_ONCE(rsp->gp_flags) | RCU_GP_FLAG_FQS);
-	raw_spin_unlock_irqrestore_rcu_node(rcu_get_root(rsp), flags);
+	raw_spin_unlock_irqrestore_rcu_node(rcu_get_root(), flags);
 	rcu_gp_kthread_wake(rsp);
 }
 
@@ -2653,7 +2653,7 @@ static void force_quiescent_state(struct rcu_state *rsp)
 			return;
 		rnp_old = rnp;
 	}
-	/* rnp_old == rcu_get_root(rsp), rnp == NULL. */
+	/* rnp_old == rcu_get_root(), rnp == NULL. */
 
 	/* Reached the root of the rcu_node tree, acquire lock. */
 	raw_spin_lock_irqsave_rcu_node(rnp_old, flags);
@@ -2678,7 +2678,7 @@ rcu_check_gp_start_stall(struct rcu_state *rsp, struct rcu_node *rnp,
 	const unsigned long gpssdelay = rcu_jiffies_till_stall_check() * HZ;
 	unsigned long flags;
 	unsigned long j;
-	struct rcu_node *rnp_root = rcu_get_root(rsp);
+	struct rcu_node *rnp_root = rcu_get_root();
 	static atomic_t warned = ATOMIC_INIT(0);
 
 	if (!IS_ENABLED(CONFIG_PROVE_RCU) || rcu_gp_in_progress() ||
@@ -3396,7 +3396,7 @@ rcu_init_percpu_data(int cpu, struct rcu_state *rsp)
 {
 	unsigned long flags;
 	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
-	struct rcu_node *rnp = rcu_get_root(rsp);
+	struct rcu_node *rnp = rcu_get_root();
 
 	/* Set up local state, ensuring consistent view of global state. */
 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
@@ -3645,7 +3645,7 @@ static void rcu_migrate_callbacks(int cpu, struct rcu_state *rsp)
 	unsigned long flags;
 	struct rcu_data *my_rdp;
 	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
-	struct rcu_node *rnp_root = rcu_get_root(rdp->rsp);
+	struct rcu_node *rnp_root = rcu_get_root();
 	bool needwake;
 
 	if (rcu_is_nocb_cpu(cpu) || rcu_segcblist_empty(&rdp->cblist))
@@ -3743,7 +3743,7 @@ static int __init rcu_spawn_gp_kthread(void)
 	for_each_rcu_flavor(rsp) {
 		t = kthread_create(rcu_gp_kthread, rsp, "%s", rsp->name);
 		BUG_ON(IS_ERR(t));
-		rnp = rcu_get_root(rsp);
+		rnp = rcu_get_root();
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
 		rsp->gp_kthread = t;
 		if (kthread_prio) {
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 298a6904bbcd..0bcbb03c9702 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -288,7 +288,7 @@ static bool exp_funnel_lock(struct rcu_state *rsp, unsigned long s)
 {
 	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, raw_smp_processor_id());
 	struct rcu_node *rnp = rdp->mynode;
-	struct rcu_node *rnp_root = rcu_get_root(rsp);
+	struct rcu_node *rnp_root = rcu_get_root();
 
 	/* Low-contention fastpath. */
 	if (ULONG_CMP_LT(READ_ONCE(rnp->exp_seq_rq), s) &&
@@ -479,7 +479,7 @@ static void synchronize_sched_expedited_wait(struct rcu_state *rsp)
 	unsigned long mask;
 	int ndetected;
 	struct rcu_node *rnp;
-	struct rcu_node *rnp_root = rcu_get_root(rsp);
+	struct rcu_node *rnp_root = rcu_get_root();
 	int ret;
 
 	trace_rcu_exp_grace_period(rsp->name, rcu_exp_gp_seq_endval(rsp), TPS("startwait"));
@@ -643,7 +643,7 @@ static void _synchronize_rcu_expedited(struct rcu_state *rsp,
 
 	/* Wait for expedited grace period to complete. */
 	rdp = per_cpu_ptr(&rcu_data, raw_smp_processor_id());
-	rnp = rcu_get_root(rsp);
+	rnp = rcu_get_root();
 	wait_event(rnp->exp_wq[rcu_seq_ctr(s) & 0x3],
 		   sync_exp_work_done(rsp, s));
 	smp_mb(); /* Workqueue actions happen before return. */
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 99f517035a6e..545e4ac9422a 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -685,7 +685,7 @@ static void rcu_print_detail_task_stall_rnp(struct rcu_node *rnp)
  */
 static void rcu_print_detail_task_stall(struct rcu_state *rsp)
 {
-	struct rcu_node *rnp = rcu_get_root(rsp);
+	struct rcu_node *rnp = rcu_get_root();
 
 	rcu_print_detail_task_stall_rnp(rnp);
 	rcu_for_each_leaf_node(rsp, rnp)
-- 
2.17.1

