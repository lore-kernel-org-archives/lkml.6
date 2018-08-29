Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B64A2C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F47020661
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:39:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F47020661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbeH3CiN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 22:38:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48540 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727485AbeH3CiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 22:38:09 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7TMcidt081072
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:39:05 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2m62g7usqf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:39:05 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 29 Aug 2018 18:39:04 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 29 Aug 2018 18:38:59 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7TMcwi626869992
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Aug 2018 22:38:58 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 75416B2072;
        Wed, 29 Aug 2018 18:37:54 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4E746B205F;
        Wed, 29 Aug 2018 18:37:54 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 29 Aug 2018 18:37:54 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id CB78A16C91D6; Wed, 29 Aug 2018 15:38:56 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 49/52] rcu: Eliminate quiescent-state and grace-period-nonstart use of rsp
Date:   Wed, 29 Aug 2018 15:38:51 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829223830.GA1800@linux.vnet.ibm.com>
References: <20180829223830.GA1800@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18082922-0072-0000-0000-0000039968A8
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009636; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01080744; UDB=6.00557498; IPR=6.00860730;
 MB=3.00023002; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-29 22:39:03
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082922-0073-0000-0000-0000493EB37A
Message-Id: <20180829223854.4055-49-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-29_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=957 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808290220
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that there is only one rcu_state structure, there is less point in
maintaining a pointer to it.  This commit therefore replaces rsp with
&rcu_state in rcu_report_qs_rnp(), force_quiescent_state(), and
rcu_check_gp_start_stall().

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index e6f0d8b6bde3..962b75c9722a 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2197,7 +2197,6 @@ static void rcu_report_qs_rnp(unsigned long mask, struct rcu_node *rnp,
 {
 	unsigned long oldmask = 0;
 	struct rcu_node *rnp_c;
-	struct rcu_state __maybe_unused *rsp = &rcu_state;
 
 	raw_lockdep_assert_held_rcu_node(rnp);
 
@@ -2216,7 +2215,7 @@ static void rcu_report_qs_rnp(unsigned long mask, struct rcu_node *rnp,
 		WARN_ON_ONCE(!rcu_is_leaf_node(rnp) &&
 			     rcu_preempt_blocked_readers_cgp(rnp));
 		rnp->qsmask &= ~mask;
-		trace_rcu_quiescent_state_report(rsp->name, rnp->gp_seq,
+		trace_rcu_quiescent_state_report(rcu_state.name, rnp->gp_seq,
 						 mask, rnp->qsmask, rnp->level,
 						 rnp->grplo, rnp->grphi,
 						 !!rnp->gp_tasks);
@@ -2623,12 +2622,11 @@ static void force_quiescent_state(void)
 	bool ret;
 	struct rcu_node *rnp;
 	struct rcu_node *rnp_old = NULL;
-	struct rcu_state *rsp = &rcu_state;
 
 	/* Funnel through hierarchy to reduce memory contention. */
 	rnp = __this_cpu_read(rcu_data.mynode);
 	for (; rnp != NULL; rnp = rnp->parent) {
-		ret = (READ_ONCE(rsp->gp_flags) & RCU_GP_FLAG_FQS) ||
+		ret = (READ_ONCE(rcu_state.gp_flags) & RCU_GP_FLAG_FQS) ||
 		      !raw_spin_trylock(&rnp->fqslock);
 		if (rnp_old != NULL)
 			raw_spin_unlock(&rnp_old->fqslock);
@@ -2641,11 +2639,12 @@ static void force_quiescent_state(void)
 	/* Reached the root of the rcu_node tree, acquire lock. */
 	raw_spin_lock_irqsave_rcu_node(rnp_old, flags);
 	raw_spin_unlock(&rnp_old->fqslock);
-	if (READ_ONCE(rsp->gp_flags) & RCU_GP_FLAG_FQS) {
+	if (READ_ONCE(rcu_state.gp_flags) & RCU_GP_FLAG_FQS) {
 		raw_spin_unlock_irqrestore_rcu_node(rnp_old, flags);
 		return;  /* Someone beat us to it. */
 	}
-	WRITE_ONCE(rsp->gp_flags, READ_ONCE(rsp->gp_flags) | RCU_GP_FLAG_FQS);
+	WRITE_ONCE(rcu_state.gp_flags,
+		   READ_ONCE(rcu_state.gp_flags) | RCU_GP_FLAG_FQS);
 	raw_spin_unlock_irqrestore_rcu_node(rnp_old, flags);
 	rcu_gp_kthread_wake();
 }
@@ -2661,15 +2660,14 @@ rcu_check_gp_start_stall(struct rcu_node *rnp, struct rcu_data *rdp)
 	unsigned long flags;
 	unsigned long j;
 	struct rcu_node *rnp_root = rcu_get_root();
-	struct rcu_state *rsp = &rcu_state;
 	static atomic_t warned = ATOMIC_INIT(0);
 
 	if (!IS_ENABLED(CONFIG_PROVE_RCU) || rcu_gp_in_progress() ||
 	    ULONG_CMP_GE(rnp_root->gp_seq, rnp_root->gp_seq_needed))
 		return;
 	j = jiffies; /* Expensive access, and in common case don't get here. */
-	if (time_before(j, READ_ONCE(rsp->gp_req_activity) + gpssdelay) ||
-	    time_before(j, READ_ONCE(rsp->gp_activity) + gpssdelay) ||
+	if (time_before(j, READ_ONCE(rcu_state.gp_req_activity) + gpssdelay) ||
+	    time_before(j, READ_ONCE(rcu_state.gp_activity) + gpssdelay) ||
 	    atomic_read(&warned))
 		return;
 
@@ -2677,8 +2675,8 @@ rcu_check_gp_start_stall(struct rcu_node *rnp, struct rcu_data *rdp)
 	j = jiffies;
 	if (rcu_gp_in_progress() ||
 	    ULONG_CMP_GE(rnp_root->gp_seq, rnp_root->gp_seq_needed) ||
-	    time_before(j, READ_ONCE(rsp->gp_req_activity) + gpssdelay) ||
-	    time_before(j, READ_ONCE(rsp->gp_activity) + gpssdelay) ||
+	    time_before(j, READ_ONCE(rcu_state.gp_req_activity) + gpssdelay) ||
+	    time_before(j, READ_ONCE(rcu_state.gp_activity) + gpssdelay) ||
 	    atomic_read(&warned)) {
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 		return;
@@ -2690,19 +2688,19 @@ rcu_check_gp_start_stall(struct rcu_node *rnp, struct rcu_data *rdp)
 	j = jiffies;
 	if (rcu_gp_in_progress() ||
 	    ULONG_CMP_GE(rnp_root->gp_seq, rnp_root->gp_seq_needed) ||
-	    time_before(j, rsp->gp_req_activity + gpssdelay) ||
-	    time_before(j, rsp->gp_activity + gpssdelay) ||
+	    time_before(j, rcu_state.gp_req_activity + gpssdelay) ||
+	    time_before(j, rcu_state.gp_activity + gpssdelay) ||
 	    atomic_xchg(&warned, 1)) {
 		raw_spin_unlock_rcu_node(rnp_root); /* irqs remain disabled. */
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 		return;
 	}
 	pr_alert("%s: g%ld->%ld gar:%lu ga:%lu f%#x gs:%d %s->state:%#lx\n",
-		 __func__, (long)READ_ONCE(rsp->gp_seq),
+		 __func__, (long)READ_ONCE(rcu_state.gp_seq),
 		 (long)READ_ONCE(rnp_root->gp_seq_needed),
-		 j - rsp->gp_req_activity, j - rsp->gp_activity,
-		 rsp->gp_flags, rsp->gp_state, rsp->name,
-		 rsp->gp_kthread ? rsp->gp_kthread->state : 0x1ffffL);
+		 j - rcu_state.gp_req_activity, j - rcu_state.gp_activity,
+		 rcu_state.gp_flags, rcu_state.gp_state, rcu_state.name,
+		 rcu_state.gp_kthread ? rcu_state.gp_kthread->state : 0x1ffffL);
 	WARN_ON(1);
 	if (rnp_root != rnp)
 		raw_spin_unlock_rcu_node(rnp_root);
-- 
2.17.1

