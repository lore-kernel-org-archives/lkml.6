Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0823C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5669226300
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:08:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5669226300
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934804AbeFZAHJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 20:07:09 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59302 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934290AbeFZAHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 20:07:03 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5Q03k28066939
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 20:07:03 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ju96ptthc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 20:07:02 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 25 Jun 2018 20:07:01 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Jun 2018 20:06:57 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5Q06u5l65208328
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Jun 2018 00:06:56 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 16BBAB2076;
        Mon, 25 Jun 2018 20:06:51 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E3AEAB205F;
        Mon, 25 Jun 2018 20:06:50 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 25 Jun 2018 20:06:50 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 165FF16CA099; Mon, 25 Jun 2018 17:09:01 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 07/40] rcu: Move RCU's grace-period-change code to ->gp_seq
Date:   Mon, 25 Jun 2018 17:08:26 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626000841.GA15696@linux.vnet.ibm.com>
References: <20180626000841.GA15696@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062600-0052-0000-0000-00000303F3CC
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009255; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052328; UDB=6.00539464; IPR=6.00830253;
 MB=3.00021855; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-26 00:07:01
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062600-0053-0000-0000-00005D23BCCB
Message-Id: <20180626000859.23572-7-paulmck@linux.vnet.ibm.com>
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

This commit moves __note_gp_changes(), note_gp_changes(), and
__rcu_pending() to ->gp_seq, creating new rcu_seq_completed_gp() and
rcu_seq_new_gp() functions for this purpose.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
[ paulmck: Reinstate "cpuend: trace as suggested by Joel Fernandes. ]
---
 kernel/rcu/rcu.h  | 17 +++++++++++++++++
 kernel/rcu/tree.c | 39 ++++++++++++++++-----------------------
 2 files changed, 33 insertions(+), 23 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index f0907f9f6cd0..7568a3fd0815 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -116,6 +116,23 @@ static inline bool rcu_seq_done(unsigned long *sp, unsigned long s)
 	return ULONG_CMP_GE(READ_ONCE(*sp), s);
 }
 
+/*
+ * Has a grace period completed since the time the old gp_seq was collected?
+ */
+static inline bool rcu_seq_completed_gp(unsigned long old, unsigned long new)
+{
+	return ULONG_CMP_LT(old, new & ~RCU_SEQ_STATE_MASK);
+}
+
+/*
+ * Has a grace period started since the time the old gp_seq was collected?
+ */
+static inline bool rcu_seq_new_gp(unsigned long old, unsigned long new)
+{
+	return ULONG_CMP_LT((old + RCU_SEQ_STATE_MASK) & ~RCU_SEQ_STATE_MASK,
+			    new);
+}
+
 /*
  * debug_rcu_head_queue()/debug_rcu_head_unqueue() are used internally
  * by call_rcu() and rcu callback execution, and are therefore not part of the
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 1a3a7d402a20..a8c19363c979 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1790,24 +1790,23 @@ static bool __note_gp_changes(struct rcu_state *rsp, struct rcu_node *rnp,
 
 	raw_lockdep_assert_held_rcu_node(rnp);
 
-	/* Handle the ends of any preceding grace periods first. */
-	if (rdp->completed == rnp->completed &&
-	    !unlikely(READ_ONCE(rdp->gpwrap))) {
-
-		/* No grace period end, so just accelerate recent callbacks. */
-		ret = rcu_accelerate_cbs(rsp, rnp, rdp);
-
-	} else {
-
-		/* Advance callbacks. */
-		ret = rcu_advance_cbs(rsp, rnp, rdp);
+	if (rdp->gp_seq == rnp->gp_seq)
+		return false; /* Nothing to do. */
 
+	/* Handle the ends of any preceding grace periods first. */
+	if (rcu_seq_completed_gp(rdp->gp_seq, rnp->gp_seq) ||
+	    unlikely(READ_ONCE(rdp->gpwrap))) {
+		ret = rcu_advance_cbs(rsp, rnp, rdp); /* Advance callbacks. */
 		/* Remember that we saw this grace-period completion. */
 		rdp->completed = rnp->completed;
-		trace_rcu_grace_period(rsp->name, rdp->gpnum, TPS("cpuend"));
+		trace_rcu_grace_period(rsp->name, rdp->gp_seq, TPS("cpuend"));
+	} else {
+		ret = rcu_accelerate_cbs(rsp, rnp, rdp); /* Recent callbacks. */
 	}
 
-	if (rdp->gpnum != rnp->gpnum || unlikely(READ_ONCE(rdp->gpwrap))) {
+	/* Now handle the beginnings of any new-to-this-CPU grace periods. */
+	if (rcu_seq_new_gp(rdp->gp_seq, rnp->gp_seq) ||
+	    unlikely(READ_ONCE(rdp->gpwrap))) {
 		/*
 		 * If the current grace period is waiting for this CPU,
 		 * set up to detect a quiescent state, otherwise don't
@@ -1823,8 +1822,7 @@ static bool __note_gp_changes(struct rcu_state *rsp, struct rcu_node *rnp,
 		WRITE_ONCE(rdp->gpwrap, false);
 		rcu_gpnum_ovf(rnp, rdp);
 	}
-	if (rdp->gp_seq != rnp->gp_seq)
-		rdp->gp_seq = rnp->gp_seq;
+	rdp->gp_seq = rnp->gp_seq;  /* Remember new grace-period state. */
 	return ret;
 }
 
@@ -1836,8 +1834,7 @@ static void note_gp_changes(struct rcu_state *rsp, struct rcu_data *rdp)
 
 	local_irq_save(flags);
 	rnp = rdp->mynode;
-	if ((rdp->gpnum == READ_ONCE(rnp->gpnum) &&
-	     rdp->completed == READ_ONCE(rnp->completed) &&
+	if ((rdp->gp_seq == rcu_seq_current(&rnp->gp_seq) &&
 	     !unlikely(READ_ONCE(rdp->gpwrap))) || /* w/out lock. */
 	    !raw_spin_trylock_rcu_node(rnp)) { /* irqs already off, so later. */
 		local_irq_restore(flags);
@@ -3283,12 +3280,8 @@ static int __rcu_pending(struct rcu_state *rsp, struct rcu_data *rdp)
 	    !rcu_segcblist_restempty(&rdp->cblist, RCU_NEXT_READY_TAIL))
 		return 1;
 
-	/* Has another RCU grace period completed?  */
-	if (READ_ONCE(rnp->completed) != rdp->completed) /* outside lock */
-		return 1;
-
-	/* Has a new RCU grace period started? */
-	if (READ_ONCE(rnp->gpnum) != rdp->gpnum ||
+	/* Have RCU grace period completed or started?  */
+	if (rcu_seq_current(&rnp->gp_seq) != rdp->gp_seq ||
 	    unlikely(READ_ONCE(rdp->gpwrap))) /* outside lock */
 		return 1;
 
-- 
2.17.1

