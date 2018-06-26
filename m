Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 911AFC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5098826331
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:15:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5098826331
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934945AbeFZAMo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 20:12:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43920 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934448AbeFZAHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 20:07:04 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5Q03laa028090
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 20:07:04 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ju96utt74-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 20:07:04 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 25 Jun 2018 20:07:01 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Jun 2018 20:06:57 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5Q06uOQ65798350
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Jun 2018 00:06:56 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3C6EDB2064;
        Mon, 25 Jun 2018 20:06:51 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 144E6B2075;
        Mon, 25 Jun 2018 20:06:51 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 25 Jun 2018 20:06:51 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 3493516CA09F; Mon, 25 Jun 2018 17:09:01 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 13/40] rcu: Convert ->rcu_iw_gpnum to ->gp_seq
Date:   Mon, 25 Jun 2018 17:08:32 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626000841.GA15696@linux.vnet.ibm.com>
References: <20180626000841.GA15696@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062600-0068-0000-0000-0000030E1823
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009255; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052328; UDB=6.00539464; IPR=6.00830253;
 MB=3.00021855; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-26 00:07:01
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062600-0069-0000-0000-000044CF0897
Message-Id: <20180626000859.23572-13-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-25_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=975 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806260000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit switches the interrupt-disabled detection mechanism to
->gp_seq.  This mechanism is used as part of RCU CPU stall warnings,
and detects cases where the stall is due to a CPU having interrupts
disabled.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree.c        | 12 ++++++------
 kernel/rcu/tree.h        |  2 +-
 kernel/rcu/tree_plugin.h |  2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index fc889c58964c..e42510dd0b1f 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1099,8 +1099,8 @@ static void rcu_gpnum_ovf(struct rcu_node *rnp, struct rcu_data *rdp)
 	if (ULONG_CMP_LT(rcu_seq_current(&rdp->gp_seq) + ULONG_MAX / 4,
 			 rnp->gp_seq))
 		WRITE_ONCE(rdp->gpwrap, true);
-	if (ULONG_CMP_LT(rdp->rcu_iw_gpnum + ULONG_MAX / 4, rnp->gpnum))
-		rdp->rcu_iw_gpnum = rnp->gpnum + ULONG_MAX / 4;
+	if (ULONG_CMP_LT(rdp->rcu_iw_gp_seq + ULONG_MAX / 4, rnp->gp_seq))
+		rdp->rcu_iw_gp_seq = rnp->gp_seq + ULONG_MAX / 4;
 }
 
 /*
@@ -1134,7 +1134,7 @@ static void rcu_iw_handler(struct irq_work *iwp)
 	rnp = rdp->mynode;
 	raw_spin_lock_rcu_node(rnp);
 	if (!WARN_ON_ONCE(!rdp->rcu_iw_pending)) {
-		rdp->rcu_iw_gpnum = rnp->gpnum;
+		rdp->rcu_iw_gp_seq = rnp->gp_seq;
 		rdp->rcu_iw_pending = false;
 	}
 	raw_spin_unlock_rcu_node(rnp);
@@ -1231,11 +1231,11 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
 	if (jiffies - rdp->rsp->gp_start > rcu_jiffies_till_stall_check() / 2) {
 		resched_cpu(rdp->cpu);
 		if (IS_ENABLED(CONFIG_IRQ_WORK) &&
-		    !rdp->rcu_iw_pending && rdp->rcu_iw_gpnum != rnp->gpnum &&
+		    !rdp->rcu_iw_pending && rdp->rcu_iw_gp_seq != rnp->gp_seq &&
 		    (rnp->ffmask & rdp->grpmask)) {
 			init_irq_work(&rdp->rcu_iw, rcu_iw_handler);
 			rdp->rcu_iw_pending = true;
-			rdp->rcu_iw_gpnum = rnp->gpnum;
+			rdp->rcu_iw_gp_seq = rnp->gp_seq;
 			irq_work_queue_on(&rdp->rcu_iw, rdp->cpu);
 		}
 	}
@@ -3572,7 +3572,7 @@ rcu_init_percpu_data(int cpu, struct rcu_state *rsp)
 	rdp->rcu_qs_ctr_snap = per_cpu(rcu_dynticks.rcu_qs_ctr, cpu);
 	rdp->core_needs_qs = false;
 	rdp->rcu_iw_pending = false;
-	rdp->rcu_iw_gpnum = rnp->gpnum - 1;
+	rdp->rcu_iw_gp_seq = rnp->gp_seq - 1;
 	trace_rcu_grace_period(rsp->name, rdp->gpnum, TPS("cpuonl"));
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 }
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 50a28d1cf5a1..6d6cbc8b3a9c 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -286,7 +286,7 @@ struct rcu_data {
 	/* ->rcu_iw* fields protected by leaf rcu_node ->lock. */
 	struct irq_work rcu_iw;		/* Check for non-irq activity. */
 	bool rcu_iw_pending;		/* Is ->rcu_iw pending? */
-	unsigned long rcu_iw_gpnum;	/* ->gpnum associated with ->rcu_iw. */
+	unsigned long rcu_iw_gp_seq;	/* ->gp_seq associated with ->rcu_iw. */
 
 	int cpu;
 	struct rcu_state *rsp;
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 5b10904669c5..bc32e1f434a6 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1763,7 +1763,7 @@ static void print_cpu_stall_info(struct rcu_state *rsp, int cpu)
 		ticks_value = rsp->gpnum - rdp->gpnum;
 	}
 	print_cpu_stall_fast_no_hz(fast_no_hz, cpu);
-	delta = rdp->mynode->gpnum - rdp->rcu_iw_gpnum;
+	delta = rcu_seq_ctr(rdp->mynode->gp_seq - rdp->rcu_iw_gp_seq);
 	pr_err("\t%d-%c%c%c%c: (%lu %s) idle=%03x/%ld/%ld softirq=%u/%u fqs=%ld %s\n",
 	       cpu,
 	       "O."[!!cpu_online(cpu)],
-- 
2.17.1

