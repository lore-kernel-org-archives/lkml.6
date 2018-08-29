Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 782E0C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 23:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BAB420647
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 23:08:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BAB420647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727700AbeH3DG4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 23:06:56 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53370 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727336AbeH3DG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 23:06:56 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7TN3l0C015213
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 19:07:44 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m61rcxeem-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 19:07:44 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 29 Aug 2018 19:07:42 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 29 Aug 2018 19:07:38 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7TN7bJg54132794
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Aug 2018 23:07:37 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2AAB5B206A;
        Wed, 29 Aug 2018 19:06:33 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0A483B2067;
        Wed, 29 Aug 2018 19:06:33 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 29 Aug 2018 19:06:32 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 4970216C2B70; Wed, 29 Aug 2018 16:07:37 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 09/10] rcu: Remove obsolete ->dynticks_fqs and ->cond_resched_completed
Date:   Wed, 29 Aug 2018 16:07:34 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829230715.GA9431@linux.vnet.ibm.com>
References: <20180829230715.GA9431@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18082923-0068-0000-0000-00000331BB64
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009636; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01080754; UDB=6.00557503; IPR=6.00860739;
 MB=3.00023002; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-29 23:07:41
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082923-0069-0000-0000-0000458F24E9
Message-Id: <20180829230735.10256-9-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-29_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808290225
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rcu_data structure's ->dynticks_fqs is incremented but never
accesses.  Its ->cond_resched_completed field isn't used at all.
This commit therefore removes both fields.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree.c |  1 -
 kernel/rcu/tree.h | 12 +++---------
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index ad09707d99ee..65b6e03ae6f5 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1038,7 +1038,6 @@ static int rcu_implicit_dynticks_qs(struct rcu_data *rdp)
 	 */
 	if (rcu_dynticks_in_eqs_since(rdp, rdp->dynticks_snap)) {
 		trace_rcu_fqs(rcu_state.name, rdp->gp_seq, rdp->cpu, TPS("dti"));
-		rdp->dynticks_fqs++;
 		rcu_gpnum_ovf(rnp, rdp);
 		return 1;
 	}
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index af8681fec23b..bfbf97a1c29d 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -203,17 +203,11 @@ struct rcu_data {
 	int tick_nohz_enabled_snap;	/* Previously seen value from sysfs. */
 #endif /* #ifdef CONFIG_RCU_FAST_NO_HZ */
 
-	/* 4) reasons this CPU needed to be kicked by force_quiescent_state */
-	unsigned long dynticks_fqs;	/* Kicked due to dynticks idle. */
-	unsigned long cond_resched_completed;
-					/* Grace period that needs help */
-					/*  from cond_resched(). */
-
-	/* 5) rcu_barrier(), OOM callbacks, and expediting. */
+	/* 4) rcu_barrier(), OOM callbacks, and expediting. */
 	struct rcu_head barrier_head;
 	int exp_dynticks_snap;		/* Double-check need for IPI. */
 
-	/* 6) Callback offloading. */
+	/* 5) Callback offloading. */
 #ifdef CONFIG_RCU_NOCB_CPU
 	struct rcu_head *nocb_head;	/* CBs waiting for kthread. */
 	struct rcu_head **nocb_tail;
@@ -240,7 +234,7 @@ struct rcu_data {
 					/* Leader CPU takes GP-end wakeups. */
 #endif /* #ifdef CONFIG_RCU_NOCB_CPU */
 
-	/* 7) Diagnostic data, including RCU CPU stall warnings. */
+	/* 6) Diagnostic data, including RCU CPU stall warnings. */
 	unsigned int softirq_snap;	/* Snapshot of softirq activity. */
 	/* ->rcu_iw* fields protected by leaf rcu_node ->lock. */
 	struct irq_work rcu_iw;		/* Check for non-irq activity. */
-- 
2.17.1

