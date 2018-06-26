Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A78C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A54B326320
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:12:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A54B326320
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935331AbeFZAMw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 20:12:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42736 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S934420AbeFZAHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 20:07:04 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5Q03l7G079307
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 20:07:03 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ju96rakt7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 20:07:03 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 25 Jun 2018 20:07:03 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Jun 2018 20:06:57 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5Q06vY91769890
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Jun 2018 00:06:57 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7D39BB2070;
        Mon, 25 Jun 2018 20:06:51 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5EEACB2065;
        Mon, 25 Jun 2018 20:06:51 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 25 Jun 2018 20:06:51 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 59E2D16CA0A5; Mon, 25 Jun 2018 17:09:01 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 19/40] rcu: Make rcu_nocb_wait_gp() check if GP already requested
Date:   Mon, 25 Jun 2018 17:08:38 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626000841.GA15696@linux.vnet.ibm.com>
References: <20180626000841.GA15696@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062600-0040-0000-0000-000004451314
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009255; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052327; UDB=6.00539464; IPR=6.00830253;
 MB=3.00021855; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-26 00:07:01
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062600-0041-0000-0000-0000084B28C9
Message-Id: <20180626000859.23572-19-paulmck@linux.vnet.ibm.com>
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

This commit makes rcu_nocb_wait_gp() check rdp->gp_seq_needed to see
if the current CPU already knows about the needed grace period having
already been requested.  If so, it avoids acquiring the corresponding
leaf rcu_node structure's ->lock, thus decreasing contention.  This
optimization is intended for cases where either multiple leader rcuo
kthreads are running on the same CPU or these kthreads are running on
a non-offloaded (e.g., housekeeping) CPU.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
[ paulmck: Move lock release past "if" as suggested by Joel Fernandes. ]
[ paulmck: Fix caching of furthest-future requested grace period. ]
---
 kernel/rcu/tree.c        |  5 +++++
 kernel/rcu/tree_plugin.h | 15 ++++++++++-----
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index e5d1369e099f..0da0db1128d0 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1618,6 +1618,11 @@ static bool rcu_start_this_gp(struct rcu_node *rnp, struct rcu_data *rdp,
 	trace_rcu_grace_period(rsp->name, READ_ONCE(rsp->gpnum), TPS("newreq"));
 	ret = true;  /* Caller must wake GP kthread. */
 unlock_out:
+	/* Push furthest requested GP to leaf node and rcu_data structure. */
+	if (ULONG_CMP_LT(c, rnp_root->gp_seq_needed)) {
+		rnp->gp_seq_needed = rnp_root->gp_seq_needed;
+		rdp->gp_seq_needed = rnp_root->gp_seq_needed;
+	}
 	if (rnp != rnp_root)
 		raw_spin_unlock_rcu_node(rnp_root);
 	return ret;
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index f4a88e3c388d..ca73931f7b30 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -2104,12 +2104,17 @@ static void rcu_nocb_wait_gp(struct rcu_data *rdp)
 	bool needwake;
 	struct rcu_node *rnp = rdp->mynode;
 
-	raw_spin_lock_irqsave_rcu_node(rnp, flags);
+	local_irq_save(flags);
 	c = rcu_seq_snap(&rdp->rsp->gp_seq);
-	needwake = rcu_start_this_gp(rnp, rdp, c);
-	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
-	if (needwake)
-		rcu_gp_kthread_wake(rdp->rsp);
+	if (!rdp->gpwrap && ULONG_CMP_GE(rdp->gp_seq_needed, c)) {
+		local_irq_restore(flags);
+	} else {
+		raw_spin_lock_rcu_node(rnp); /* irqs already disabled. */
+		needwake = rcu_start_this_gp(rnp, rdp, c);
+		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
+		if (needwake)
+			rcu_gp_kthread_wake(rdp->rsp);
+	}
 
 	/*
 	 * Wait for the grace period.  Do so interruptibly to avoid messing
-- 
2.17.1

