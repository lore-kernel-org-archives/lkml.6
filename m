Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51EDBC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0399D26316
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:12:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0399D26316
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935101AbeFZAKb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 20:10:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48720 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934562AbeFZAHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 20:07:05 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5Q04j3x029959
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 20:07:05 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ju975ar92-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 20:07:05 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 25 Jun 2018 20:07:03 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Jun 2018 20:06:59 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5Q06v8O7799120
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Jun 2018 00:06:58 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7E44DB2080;
        Mon, 25 Jun 2018 20:06:52 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5713AB2067;
        Mon, 25 Jun 2018 20:06:52 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 25 Jun 2018 20:06:52 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 8BE4016CA095; Mon, 25 Jun 2018 17:09:01 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 28/40] rcu: Make simple callback acceleration refer to rdp->gp_seq_needed
Date:   Mon, 25 Jun 2018 17:08:47 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626000841.GA15696@linux.vnet.ibm.com>
References: <20180626000841.GA15696@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062600-0068-0000-0000-0000030E182D
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009255; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052328; UDB=6.00539464; IPR=6.00830253;
 MB=3.00021855; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-26 00:07:03
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062600-0069-0000-0000-000044CF08A3
Message-Id: <20180626000859.23572-28-paulmck@linux.vnet.ibm.com>
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

Now that the rcu_data structure contains ->gp_seq_needed, create an
rcu_accelerate_cbs_unlocked() helper function that locklessly checks to
see if new callbacks' required grace period has already been requested.
If so, update the callback list locally and again locklessly.  (Though
interrupts must be and are disabled to avoid racing with conflicting
updates in interrupt handlers.)

Otherwise, call rcu_accelerate_cbs() as before.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree.c | 51 +++++++++++++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 19 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 2b66da93cf5b..fe986771c5cf 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1701,6 +1701,34 @@ static bool rcu_accelerate_cbs(struct rcu_state *rsp, struct rcu_node *rnp,
 	return ret;
 }
 
+/*
+ * Similar to rcu_accelerate_cbs(), but does not require that the leaf
+ * rcu_node structure's ->lock be held.  It consults the cached value
+ * of ->gp_seq_needed in the rcu_data structure, and if that indicates
+ * that a new grace-period request be made, invokes rcu_accelerate_cbs()
+ * while holding the leaf rcu_node structure's ->lock.
+ */
+static void rcu_accelerate_cbs_unlocked(struct rcu_state *rsp,
+					struct rcu_node *rnp,
+					struct rcu_data *rdp)
+{
+	unsigned long c;
+	bool needwake;
+
+	lockdep_assert_irqs_disabled();
+	c = rcu_seq_snap(&rsp->gp_seq);
+	if (!rdp->gpwrap && ULONG_CMP_GE(rdp->gp_seq_needed, c)) {
+		/* Old request still live, so mark recent callbacks. */
+		(void)rcu_segcblist_accelerate(&rdp->cblist, c);
+		return;
+	}
+	raw_spin_lock_rcu_node(rnp); /* irqs already disabled. */
+	needwake = rcu_accelerate_cbs(rsp, rnp, rdp);
+	raw_spin_unlock_rcu_node(rnp); /* irqs remain disabled. */
+	if (needwake)
+		rcu_gp_kthread_wake(rsp);
+}
+
 /*
  * Move any callbacks whose grace period has completed to the
  * RCU_DONE_TAIL sublist, then compact the remaining sublists and
@@ -2737,7 +2765,6 @@ static void
 __rcu_process_callbacks(struct rcu_state *rsp)
 {
 	unsigned long flags;
-	bool needwake;
 	struct rcu_data *rdp = raw_cpu_ptr(rsp->rda);
 	struct rcu_node *rnp = rdp->mynode;
 
@@ -2750,15 +2777,9 @@ __rcu_process_callbacks(struct rcu_state *rsp)
 	if (!rcu_gp_in_progress(rsp) &&
 	    rcu_segcblist_is_enabled(&rdp->cblist)) {
 		local_irq_save(flags);
-		if (rcu_segcblist_restempty(&rdp->cblist, RCU_NEXT_READY_TAIL)) {
-			local_irq_restore(flags);
-		} else {
-			raw_spin_lock_rcu_node(rnp); /* irqs disabled. */
-			needwake = rcu_accelerate_cbs(rsp, rnp, rdp);
-			raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
-			if (needwake)
-				rcu_gp_kthread_wake(rsp);
-		}
+		if (!rcu_segcblist_restempty(&rdp->cblist, RCU_NEXT_READY_TAIL))
+			rcu_accelerate_cbs_unlocked(rsp, rnp, rdp);
+		local_irq_restore(flags);
 	}
 
 	rcu_check_gp_start_stall(rsp, rnp, rdp);
@@ -2816,8 +2837,6 @@ static void invoke_rcu_core(void)
 static void __call_rcu_core(struct rcu_state *rsp, struct rcu_data *rdp,
 			    struct rcu_head *head, unsigned long flags)
 {
-	bool needwake;
-
 	/*
 	 * If called from an extended quiescent state, invoke the RCU
 	 * core in order to force a re-evaluation of RCU's idleness.
@@ -2844,13 +2863,7 @@ static void __call_rcu_core(struct rcu_state *rsp, struct rcu_data *rdp,
 
 		/* Start a new grace period if one not already started. */
 		if (!rcu_gp_in_progress(rsp)) {
-			struct rcu_node *rnp = rdp->mynode;
-
-			raw_spin_lock_rcu_node(rnp);
-			needwake = rcu_accelerate_cbs(rsp, rnp, rdp);
-			raw_spin_unlock_rcu_node(rnp);
-			if (needwake)
-				rcu_gp_kthread_wake(rsp);
+			rcu_accelerate_cbs_unlocked(rsp, rdp->mynode, rdp);
 		} else {
 			/* Give the grace period a kick. */
 			rdp->blimit = LONG_MAX;
-- 
2.17.1

