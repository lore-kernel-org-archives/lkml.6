Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10181C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A60A620644
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:43:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A60A620644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbeH3Cmh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 22:42:37 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39392 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727466AbeH3CiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 22:38:06 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7TMcijC062064
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:39:02 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m61x8d87r-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:39:02 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 29 Aug 2018 18:39:01 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 29 Aug 2018 18:38:56 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7TMct814784452
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Aug 2018 22:38:55 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 78E45B205F;
        Wed, 29 Aug 2018 18:37:51 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 514C4B2066;
        Wed, 29 Aug 2018 18:37:51 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 29 Aug 2018 18:37:51 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id CA56016C91C9; Wed, 29 Aug 2018 15:38:55 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 05/52] rcu: Remove rsp parameter from rcu_gp_in_progress()
Date:   Wed, 29 Aug 2018 15:38:07 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829223830.GA1800@linux.vnet.ibm.com>
References: <20180829223830.GA1800@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18082922-0072-0000-0000-0000039968A0
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009636; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01080744; UDB=6.00557498; IPR=6.00860730;
 MB=3.00023002; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-29 22:39:00
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082922-0073-0000-0000-0000493EB36D
Message-Id: <20180829223854.4055-5-paulmck@linux.vnet.ibm.com>
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
rcu_gp_in_progress().

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree.c        | 30 +++++++++++++++---------------
 kernel/rcu/tree_plugin.h |  2 +-
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 8977e37fcba3..605e1c990619 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -189,9 +189,9 @@ unsigned long rcu_rnp_online_cpus(struct rcu_node *rnp)
  * permit this function to be invoked without holding the root rcu_node
  * structure's ->lock, but of course results can be subject to change.
  */
-static int rcu_gp_in_progress(struct rcu_state *rsp)
+static int rcu_gp_in_progress(void)
 {
-	return rcu_seq_state(rcu_seq_current(&rsp->gp_seq));
+	return rcu_seq_state(rcu_seq_current(&rcu_state.gp_seq));
 }
 
 void rcu_softirq_qs(void)
@@ -1296,7 +1296,7 @@ static void rcu_stall_kick_kthreads(struct rcu_state *rsp)
 		return;
 	j = READ_ONCE(rsp->jiffies_kick_kthreads);
 	if (time_after(jiffies, j) && rsp->gp_kthread &&
-	    (rcu_gp_in_progress(rsp) || READ_ONCE(rsp->gp_flags))) {
+	    (rcu_gp_in_progress() || READ_ONCE(rsp->gp_flags))) {
 		WARN_ONCE(1, "Kicking %s grace-period kthread\n", rsp->name);
 		rcu_ftrace_dump(DUMP_ALL);
 		wake_up_process(rsp->gp_kthread);
@@ -1448,7 +1448,7 @@ static void check_cpu_stall(struct rcu_state *rsp, struct rcu_data *rdp)
 	struct rcu_node *rnp;
 
 	if ((rcu_cpu_stall_suppress && !rcu_kick_kthreads) ||
-	    !rcu_gp_in_progress(rsp))
+	    !rcu_gp_in_progress())
 		return;
 	rcu_stall_kick_kthreads(rsp);
 	j = jiffies;
@@ -1483,14 +1483,14 @@ static void check_cpu_stall(struct rcu_state *rsp, struct rcu_data *rdp)
 		return; /* No stall or GP completed since entering function. */
 	rnp = rdp->mynode;
 	jn = jiffies + 3 * rcu_jiffies_till_stall_check() + 3;
-	if (rcu_gp_in_progress(rsp) &&
+	if (rcu_gp_in_progress() &&
 	    (READ_ONCE(rnp->qsmask) & rdp->grpmask) &&
 	    cmpxchg(&rsp->jiffies_stall, js, jn) == js) {
 
 		/* We haven't checked in, so go dump stack. */
 		print_cpu_stall(rsp);
 
-	} else if (rcu_gp_in_progress(rsp) &&
+	} else if (rcu_gp_in_progress() &&
 		   ULONG_CMP_GE(j, js + RCU_STALL_RAT_DELAY) &&
 		   cmpxchg(&rsp->jiffies_stall, js, jn) == js) {
 
@@ -1588,7 +1588,7 @@ static bool rcu_start_this_gp(struct rcu_node *rnp_start, struct rcu_data *rdp,
 	}
 
 	/* If GP already in progress, just leave, otherwise start one. */
-	if (rcu_gp_in_progress(rsp)) {
+	if (rcu_gp_in_progress()) {
 		trace_rcu_this_gp(rnp, rdp, gp_seq_req, TPS("Startedleafroot"));
 		goto unlock_out;
 	}
@@ -1845,7 +1845,7 @@ static bool rcu_gp_init(struct rcu_state *rsp)
 	}
 	WRITE_ONCE(rsp->gp_flags, 0); /* Clear all flags: New grace period. */
 
-	if (WARN_ON_ONCE(rcu_gp_in_progress(rsp))) {
+	if (WARN_ON_ONCE(rcu_gp_in_progress())) {
 		/*
 		 * Grace period already in progress, don't start another.
 		 * Not supposed to be able to happen.
@@ -2194,7 +2194,7 @@ static void rcu_report_qs_rsp(unsigned long flags)
 	struct rcu_state *rsp = &rcu_state;
 
 	raw_lockdep_assert_held_rcu_node(rcu_get_root(rsp));
-	WARN_ON_ONCE(!rcu_gp_in_progress(rsp));
+	WARN_ON_ONCE(!rcu_gp_in_progress());
 	WRITE_ONCE(rsp->gp_flags, READ_ONCE(rsp->gp_flags) | RCU_GP_FLAG_FQS);
 	raw_spin_unlock_irqrestore_rcu_node(rcu_get_root(rsp), flags);
 	rcu_gp_kthread_wake(rsp);
@@ -2681,7 +2681,7 @@ rcu_check_gp_start_stall(struct rcu_state *rsp, struct rcu_node *rnp,
 	struct rcu_node *rnp_root = rcu_get_root(rsp);
 	static atomic_t warned = ATOMIC_INIT(0);
 
-	if (!IS_ENABLED(CONFIG_PROVE_RCU) || rcu_gp_in_progress(rsp) ||
+	if (!IS_ENABLED(CONFIG_PROVE_RCU) || rcu_gp_in_progress() ||
 	    ULONG_CMP_GE(rnp_root->gp_seq, rnp_root->gp_seq_needed))
 		return;
 	j = jiffies; /* Expensive access, and in common case don't get here. */
@@ -2692,7 +2692,7 @@ rcu_check_gp_start_stall(struct rcu_state *rsp, struct rcu_node *rnp,
 
 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
 	j = jiffies;
-	if (rcu_gp_in_progress(rsp) ||
+	if (rcu_gp_in_progress() ||
 	    ULONG_CMP_GE(rnp_root->gp_seq, rnp_root->gp_seq_needed) ||
 	    time_before(j, READ_ONCE(rsp->gp_req_activity) + gpssdelay) ||
 	    time_before(j, READ_ONCE(rsp->gp_activity) + gpssdelay) ||
@@ -2705,7 +2705,7 @@ rcu_check_gp_start_stall(struct rcu_state *rsp, struct rcu_node *rnp,
 	if (rnp_root != rnp)
 		raw_spin_lock_rcu_node(rnp_root); /* irqs already disabled. */
 	j = jiffies;
-	if (rcu_gp_in_progress(rsp) ||
+	if (rcu_gp_in_progress() ||
 	    ULONG_CMP_GE(rnp_root->gp_seq, rnp_root->gp_seq_needed) ||
 	    time_before(j, rsp->gp_req_activity + gpssdelay) ||
 	    time_before(j, rsp->gp_activity + gpssdelay) ||
@@ -2750,7 +2750,7 @@ __rcu_process_callbacks(struct rcu_state *rsp)
 	rcu_check_quiescent_state(rsp, rdp);
 
 	/* No grace period and unregistered callbacks? */
-	if (!rcu_gp_in_progress(rsp) &&
+	if (!rcu_gp_in_progress() &&
 	    rcu_segcblist_is_enabled(&rdp->cblist)) {
 		local_irq_save(flags);
 		if (!rcu_segcblist_restempty(&rdp->cblist, RCU_NEXT_READY_TAIL))
@@ -2840,7 +2840,7 @@ static void __call_rcu_core(struct rcu_state *rsp, struct rcu_data *rdp,
 		note_gp_changes(rsp, rdp);
 
 		/* Start a new grace period if one not already started. */
-		if (!rcu_gp_in_progress(rsp)) {
+		if (!rcu_gp_in_progress()) {
 			rcu_accelerate_cbs_unlocked(rsp, rdp->mynode, rdp);
 		} else {
 			/* Give the grace period a kick. */
@@ -3104,7 +3104,7 @@ static int __rcu_pending(struct rcu_state *rsp, struct rcu_data *rdp)
 		return 1;
 
 	/* Has RCU gone idle with this CPU needing another grace period? */
-	if (!rcu_gp_in_progress(rsp) &&
+	if (!rcu_gp_in_progress() &&
 	    rcu_segcblist_is_enabled(&rdp->cblist) &&
 	    !rcu_segcblist_restempty(&rdp->cblist, RCU_NEXT_READY_TAIL))
 		return 1;
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 566828ecaecb..99f517035a6e 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -2655,7 +2655,7 @@ static bool rcu_nohz_full_cpu(struct rcu_state *rsp)
 {
 #ifdef CONFIG_NO_HZ_FULL
 	if (tick_nohz_full_cpu(smp_processor_id()) &&
-	    (!rcu_gp_in_progress(rsp) ||
+	    (!rcu_gp_in_progress() ||
 	     ULONG_CMP_LT(jiffies, READ_ONCE(rsp->gp_start) + HZ)))
 		return true;
 #endif /* #ifdef CONFIG_NO_HZ_FULL */
-- 
2.17.1

