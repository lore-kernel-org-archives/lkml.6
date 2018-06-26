Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1132C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93DB826323
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:13:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93DB826323
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935479AbeFZANG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 20:13:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48542 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934306AbeFZAHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 20:07:04 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5Q04ixi029824
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 20:07:03 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ju975ar6q-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 20:07:02 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 25 Jun 2018 20:07:01 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Jun 2018 20:06:57 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5Q06ucp61997090
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Jun 2018 00:06:56 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4072DB2066;
        Mon, 25 Jun 2018 20:06:51 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 19C7AB2078;
        Mon, 25 Jun 2018 20:06:51 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 25 Jun 2018 20:06:51 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 3FBA916CA0A1; Mon, 25 Jun 2018 17:09:01 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 15/40] rcu: Convert grace-period requests to ->gp_seq
Date:   Mon, 25 Jun 2018 17:08:34 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626000841.GA15696@linux.vnet.ibm.com>
References: <20180626000841.GA15696@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062600-2213-0000-0000-000002BFDEBE
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009255; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052327; UDB=6.00539464; IPR=6.00830253;
 MB=3.00021855; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-26 00:07:00
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062600-2214-0000-0000-00005A9B9536
Message-Id: <20180626000859.23572-15-paulmck@linux.vnet.ibm.com>
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

This commit converts the grace-period request code paths from ->completed
and ->gpnum to ->gp_seq.  The need_future_gp_element() macro encapsulates
the shift operation required to use ->gp_seq as an index to the
->need_future_gp[] array.  The rcu_cbs_completed() function is removed
in favor of the rcu_seq_snap() function.  The rcu_start_this_gp()
gets some temporary consistency checks and uses rcu_seq_done(),
rcu_seq_current(), rcu_seq_state(), and rcu_gp_in_progress() in place
of the earlier open-coded comparisons of ->gpnum and ->completed.
The rcu_future_gp_cleanup() function replaces use of ->completed
with ->gp_seq.  The rcu_accelerate_cbs() function replaces a call to
rcu_cbs_completed() with one to rcu_seq_snap().  The rcu_advance_cbs()
function replaces an access to >completed with one to ->gp_seq and adds
some temporary warnings.  The rcu_nocb_wait_gp() function replaces a
call to rcu_cbs_completed() with one to rcu_seq_snap() and an open-coded
comparison with rcu_seq_done().

The temporary warnings will be removed when the various ->gpnum and
->completed fields are removed.  Their purpose is to locate code who
might still be using ->gpnum and ->completed.  (Much easier that way
than trying to trace down the causes of too-short grace periods and
grace-period hangs!)

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree.c        | 84 ++++++++++------------------------------
 kernel/rcu/tree.h        |  2 +-
 kernel/rcu/tree_plugin.h |  6 +--
 3 files changed, 24 insertions(+), 68 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 85d14ae49ffc..6f9a564e82d3 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1548,52 +1548,6 @@ void rcu_cpu_stall_reset(void)
 		WRITE_ONCE(rsp->jiffies_stall, jiffies + ULONG_MAX / 2);
 }
 
-/*
- * Determine the value that ->completed will have at the end of the
- * next subsequent grace period.  This is used to tag callbacks so that
- * a CPU can invoke callbacks in a timely fashion even if that CPU has
- * been dyntick-idle for an extended period with callbacks under the
- * influence of RCU_FAST_NO_HZ.
- *
- * The caller must hold rnp->lock with interrupts disabled.
- */
-static unsigned long rcu_cbs_completed(struct rcu_state *rsp,
-				       struct rcu_node *rnp)
-{
-	raw_lockdep_assert_held_rcu_node(rnp);
-
-	/*
-	 * If RCU is idle, we just wait for the next grace period.
-	 * But we can only be sure that RCU is idle if we are looking
-	 * at the root rcu_node structure -- otherwise, a new grace
-	 * period might have started, but just not yet gotten around
-	 * to initializing the current non-root rcu_node structure.
-	 */
-	if (rcu_get_root(rsp) == rnp && rnp->gpnum == rnp->completed)
-		return rnp->completed + 1;
-
-	/*
-	 * If the current rcu_node structure believes that RCU is
-	 * idle, and if the rcu_state structure does not yet reflect
-	 * the start of a new grace period, then the next grace period
-	 * will suffice.  The memory barrier is needed to accurately
-	 * sample the rsp->gpnum, and pairs with the second lock
-	 * acquisition in rcu_gp_init(), which is augmented with
-	 * smp_mb__after_unlock_lock() for this purpose.
-	 */
-	if (rnp->gpnum == rnp->completed) {
-		smp_mb(); /* See above block comment. */
-		if (READ_ONCE(rsp->gpnum) == rnp->completed)
-			return rnp->completed + 1;
-	}
-
-	/*
-	 * Otherwise, wait for a possible partial grace period and
-	 * then the subsequent full grace period.
-	 */
-	return rnp->completed + 2;
-}
-
 /* Trace-event wrapper function for trace_rcu_future_grace_period.  */
 static void trace_rcu_this_gp(struct rcu_node *rnp, struct rcu_data *rdp,
 			      unsigned long c, const char *s)
@@ -1629,16 +1583,16 @@ static bool rcu_start_this_gp(struct rcu_node *rnp, struct rcu_data *rdp,
 	 * not be released.
 	 */
 	raw_lockdep_assert_held_rcu_node(rnp);
+	WARN_ON_ONCE(c & 0x2); /* Catch any lingering use of ->gpnum. */
+	WARN_ON_ONCE(((rnp->completed << RCU_SEQ_CTR_SHIFT) >> RCU_SEQ_CTR_SHIFT) != rcu_seq_ctr(rnp->gp_seq)); /* Catch any ->completed/->gp_seq mismatches. */
 	trace_rcu_this_gp(rnp, rdp, c, TPS("Startleaf"));
 	for (rnp_root = rnp; 1; rnp_root = rnp_root->parent) {
 		if (rnp_root != rnp)
 			raw_spin_lock_rcu_node(rnp_root);
-		WARN_ON_ONCE(ULONG_CMP_LT(rnp_root->gpnum +
-					  need_future_gp_mask(), c));
 		if (need_future_gp_element(rnp_root, c) ||
-		    ULONG_CMP_GE(rnp_root->gpnum, c) ||
+		    rcu_seq_done(&rnp_root->gp_seq, c) ||
 		    (rnp != rnp_root &&
-		     rnp_root->gpnum != rnp_root->completed)) {
+		     rcu_seq_state(rcu_seq_current(&rnp_root->gp_seq)))) {
 			trace_rcu_this_gp(rnp_root, rdp, c, TPS("Prestarted"));
 			goto unlock_out;
 		}
@@ -1650,7 +1604,7 @@ static bool rcu_start_this_gp(struct rcu_node *rnp, struct rcu_data *rdp,
 	}
 
 	/* If GP already in progress, just leave, otherwise start one. */
-	if (rnp_root->gpnum != rnp_root->completed) {
+	if (rcu_gp_in_progress(rsp)) {
 		trace_rcu_this_gp(rnp_root, rdp, c, TPS("Startedleafroot"));
 		goto unlock_out;
 	}
@@ -1675,7 +1629,7 @@ static bool rcu_start_this_gp(struct rcu_node *rnp, struct rcu_data *rdp,
  */
 static bool rcu_future_gp_cleanup(struct rcu_state *rsp, struct rcu_node *rnp)
 {
-	unsigned long c = rnp->completed;
+	unsigned long c = rnp->gp_seq;
 	bool needmore;
 	struct rcu_data *rdp = this_cpu_ptr(rsp->rda);
 
@@ -1703,14 +1657,14 @@ static void rcu_gp_kthread_wake(struct rcu_state *rsp)
 }
 
 /*
- * If there is room, assign a ->completed number to any callbacks on
- * this CPU that have not already been assigned.  Also accelerate any
- * callbacks that were previously assigned a ->completed number that has
- * since proven to be too conservative, which can happen if callbacks get
- * assigned a ->completed number while RCU is idle, but with reference to
- * a non-root rcu_node structure.  This function is idempotent, so it does
- * not hurt to call it repeatedly.  Returns an flag saying that we should
- * awaken the RCU grace-period kthread.
+ * If there is room, assign a ->gp_seq number to any callbacks on this
+ * CPU that have not already been assigned.  Also accelerate any callbacks
+ * that were previously assigned a ->gp_seq number that has since proven
+ * to be too conservative, which can happen if callbacks get assigned a
+ * ->gp_seq number while RCU is idle, but with reference to a non-root
+ * rcu_node structure.  This function is idempotent, so it does not hurt
+ * to call it repeatedly.  Returns an flag saying that we should awaken
+ * the RCU grace-period kthread.
  *
  * The caller must hold rnp->lock with interrupts disabled.
  */
@@ -1736,7 +1690,7 @@ static bool rcu_accelerate_cbs(struct rcu_state *rsp, struct rcu_node *rnp,
 	 * accelerating callback invocation to an earlier grace-period
 	 * number.
 	 */
-	c = rcu_cbs_completed(rsp, rnp);
+	c = rcu_seq_snap(&rsp->gp_seq);
 	if (rcu_segcblist_accelerate(&rdp->cblist, c))
 		ret = rcu_start_this_gp(rnp, rdp, c);
 
@@ -1751,7 +1705,7 @@ static bool rcu_accelerate_cbs(struct rcu_state *rsp, struct rcu_node *rnp,
 /*
  * Move any callbacks whose grace period has completed to the
  * RCU_DONE_TAIL sublist, then compact the remaining sublists and
- * assign ->completed numbers to any callbacks in the RCU_NEXT_TAIL
+ * assign ->gp_seq numbers to any callbacks in the RCU_NEXT_TAIL
  * sublist.  This function is idempotent, so it does not hurt to
  * invoke it repeatedly.  As long as it is not invoked -too- often...
  * Returns true if the RCU grace-period kthread needs to be awakened.
@@ -1768,10 +1722,10 @@ static bool rcu_advance_cbs(struct rcu_state *rsp, struct rcu_node *rnp,
 		return false;
 
 	/*
-	 * Find all callbacks whose ->completed numbers indicate that they
+	 * Find all callbacks whose ->gp_seq numbers indicate that they
 	 * are ready to invoke, and put them into the RCU_DONE_TAIL sublist.
 	 */
-	rcu_segcblist_advance(&rdp->cblist, rnp->completed);
+	rcu_segcblist_advance(&rdp->cblist, rnp->gp_seq);
 
 	/* Classify any remaining callbacks. */
 	return rcu_accelerate_cbs(rsp, rnp, rdp);
@@ -1889,6 +1843,8 @@ static bool rcu_gp_init(struct rcu_state *rsp)
 	smp_store_release(&rsp->gpnum, rsp->gpnum + 1);
 	smp_mb(); /* Pairs with barriers in stall-warning code. */
 	rcu_seq_start(&rsp->gp_seq);
+	if (WARN_ON_ONCE(((rnp->completed << RCU_SEQ_CTR_SHIFT) >> RCU_SEQ_CTR_SHIFT) != rcu_seq_ctr(rnp->gp_seq))) /* Catch any ->completed/->gp_seq mismatches. */
+		pr_info("%s ->completed: %#lx (%#lx) ->gp_seq %#lx (%#lx)\n", __func__, rnp->completed, (rnp->completed << RCU_SEQ_CTR_SHIFT) >> RCU_SEQ_CTR_SHIFT, rnp->gp_seq, rcu_seq_ctr(rnp->gp_seq));
 	trace_rcu_grace_period(rsp->name, rsp->gpnum, TPS("start"));
 	raw_spin_unlock_irq_rcu_node(rnp);
 
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 6d6cbc8b3a9c..a21d403a6010 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -174,7 +174,7 @@ struct rcu_node {
 #define need_future_gp_mask() \
 	(ARRAY_SIZE(((struct rcu_node *)NULL)->need_future_gp) - 1)
 #define need_future_gp_element(rnp, c) \
-	((rnp)->need_future_gp[(c) & need_future_gp_mask()])
+	((rnp)->need_future_gp[(c >> RCU_SEQ_CTR_SHIFT) & need_future_gp_mask()])
 #define need_any_future_gp(rnp)						\
 ({									\
 	int __i;							\
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 2a81d243521f..2036dc7426ac 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -2105,7 +2105,7 @@ static void rcu_nocb_wait_gp(struct rcu_data *rdp)
 	struct rcu_node *rnp = rdp->mynode;
 
 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
-	c = rcu_cbs_completed(rdp->rsp, rnp);
+	c = rcu_seq_snap(&rdp->rsp->gp_seq);
 	needwake = rcu_start_this_gp(rnp, rdp, c);
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	if (needwake)
@@ -2118,8 +2118,8 @@ static void rcu_nocb_wait_gp(struct rcu_data *rdp)
 	trace_rcu_this_gp(rnp, rdp, c, TPS("StartWait"));
 	for (;;) {
 		swait_event_interruptible(
-			rnp->nocb_gp_wq[c & 0x1],
-			(d = ULONG_CMP_GE(READ_ONCE(rnp->completed), c)));
+			rnp->nocb_gp_wq[rcu_seq_ctr(c) & 0x1],
+			(d = rcu_seq_done(&rnp->gp_seq, c)));
 		if (likely(d))
 			break;
 		WARN_ON(signal_pending(current));
-- 
2.17.1

