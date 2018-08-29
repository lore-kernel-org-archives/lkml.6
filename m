Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87B49C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CF3B20644
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:41:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CF3B20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbeH3Cks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 22:40:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38340 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727591AbeH3CiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 22:38:07 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7TMcikv016526
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:39:04 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m64f000mx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:39:03 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 29 Aug 2018 18:39:02 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 29 Aug 2018 18:38:58 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7TMcvMo18284764
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Aug 2018 22:38:57 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 21004B2074;
        Wed, 29 Aug 2018 18:37:53 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EF72BB2067;
        Wed, 29 Aug 2018 18:37:52 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 29 Aug 2018 18:37:52 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 1651416C91D7; Wed, 29 Aug 2018 15:38:56 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 16/52] rcu: Remove rsp parameter from rcu_accelerate_cbs()
Date:   Wed, 29 Aug 2018 15:38:18 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829223830.GA1800@linux.vnet.ibm.com>
References: <20180829223830.GA1800@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18082922-0068-0000-0000-00000331B953
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009636; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01080744; UDB=6.00557497; IPR=6.00860730;
 MB=3.00023002; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-29 22:39:01
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082922-0069-0000-0000-0000458F1619
Message-Id: <20180829223854.4055-16-paulmck@linux.vnet.ibm.com>
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
rcu_accelerate_cbs().

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree.c        | 15 +++++++--------
 kernel/rcu/tree_plugin.h |  2 +-
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index d3150943db9f..2c1d457e8cc2 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1662,11 +1662,11 @@ static void rcu_gp_kthread_wake(void)
  *
  * The caller must hold rnp->lock with interrupts disabled.
  */
-static bool rcu_accelerate_cbs(struct rcu_state *rsp, struct rcu_node *rnp,
-			       struct rcu_data *rdp)
+static bool rcu_accelerate_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
 {
 	unsigned long gp_seq_req;
 	bool ret = false;
+	struct rcu_state *rsp = &rcu_state;
 
 	raw_lockdep_assert_held_rcu_node(rnp);
 
@@ -1718,7 +1718,7 @@ static void rcu_accelerate_cbs_unlocked(struct rcu_state *rsp,
 		return;
 	}
 	raw_spin_lock_rcu_node(rnp); /* irqs already disabled. */
-	needwake = rcu_accelerate_cbs(rsp, rnp, rdp);
+	needwake = rcu_accelerate_cbs(rnp, rdp);
 	raw_spin_unlock_rcu_node(rnp); /* irqs remain disabled. */
 	if (needwake)
 		rcu_gp_kthread_wake();
@@ -1750,7 +1750,7 @@ static bool rcu_advance_cbs(struct rcu_state *rsp, struct rcu_node *rnp,
 	rcu_segcblist_advance(&rdp->cblist, rnp->gp_seq);
 
 	/* Classify any remaining callbacks. */
-	return rcu_accelerate_cbs(rsp, rnp, rdp);
+	return rcu_accelerate_cbs(rnp, rdp);
 }
 
 /*
@@ -1776,7 +1776,7 @@ static bool __note_gp_changes(struct rcu_state *rsp, struct rcu_node *rnp,
 		ret = rcu_advance_cbs(rsp, rnp, rdp); /* Advance callbacks. */
 		trace_rcu_grace_period(rsp->name, rdp->gp_seq, TPS("cpuend"));
 	} else {
-		ret = rcu_accelerate_cbs(rsp, rnp, rdp); /* Recent callbacks. */
+		ret = rcu_accelerate_cbs(rnp, rdp); /* Recent callbacks. */
 	}
 
 	/* Now handle the beginnings of any new-to-this-CPU grace periods. */
@@ -2077,7 +2077,7 @@ static void rcu_gp_cleanup(struct rcu_state *rsp)
 		needgp = true;
 	}
 	/* Advance CBs to reduce false positives below. */
-	if (!rcu_accelerate_cbs(rsp, rnp, rdp) && needgp) {
+	if (!rcu_accelerate_cbs(rnp, rdp) && needgp) {
 		WRITE_ONCE(rsp->gp_flags, RCU_GP_FLAG_INIT);
 		rsp->gp_req_activity = jiffies;
 		trace_rcu_grace_period(rsp->name, READ_ONCE(rsp->gp_seq),
@@ -2330,7 +2330,6 @@ rcu_report_qs_rdp(int cpu, struct rcu_data *rdp)
 	unsigned long mask;
 	bool needwake;
 	struct rcu_node *rnp;
-	struct rcu_state *rsp = &rcu_state;
 
 	rnp = rdp->mynode;
 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
@@ -2358,7 +2357,7 @@ rcu_report_qs_rdp(int cpu, struct rcu_data *rdp)
 		 * This GP can't end until cpu checks in, so all of our
 		 * callbacks can be processed during the next GP.
 		 */
-		needwake = rcu_accelerate_cbs(rsp, rnp, rdp);
+		needwake = rcu_accelerate_cbs(rnp, rdp);
 
 		rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
 		/* ^^^ Released rnp->lock */
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 50ca000ad9f2..0c59c3987c60 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1697,7 +1697,7 @@ static void rcu_prepare_for_idle(void)
 			continue;
 		rnp = rdp->mynode;
 		raw_spin_lock_rcu_node(rnp); /* irqs already disabled. */
-		needwake = rcu_accelerate_cbs(rsp, rnp, rdp);
+		needwake = rcu_accelerate_cbs(rnp, rdp);
 		raw_spin_unlock_rcu_node(rnp); /* irqs remain disabled. */
 		if (needwake)
 			rcu_gp_kthread_wake();
-- 
2.17.1

