Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C68A6C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 23:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C6D820647
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 23:08:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C6D820647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbeH3DHX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 23:07:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36088 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727576AbeH3DG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 23:06:56 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7TN3rtI119670
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 19:07:44 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m61x8e1d8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 19:07:44 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 29 Aug 2018 19:07:43 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 29 Aug 2018 19:07:38 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7TN7bW226935538
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Aug 2018 23:07:37 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3728FB2067;
        Wed, 29 Aug 2018 19:06:33 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0E8B0B2068;
        Wed, 29 Aug 2018 19:06:33 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 29 Aug 2018 19:06:33 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 4F9B916C91D1; Wed, 29 Aug 2018 16:07:37 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Mike Galbraith <efault@gmx.de>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH tip/core/rcu 10/10] rcu: Convert rcu_state.ofl_lock to raw_spinlock_t
Date:   Wed, 29 Aug 2018 16:07:35 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829230715.GA9431@linux.vnet.ibm.com>
References: <20180829230715.GA9431@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18082923-0040-0000-0000-000004675A3A
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009636; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01080754; UDB=6.00557503; IPR=6.00860739;
 MB=3.00023002; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-29 23:07:42
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082923-0041-0000-0000-0000086E7418
Message-Id: <20180829230735.10256-10-paulmck@linux.vnet.ibm.com>
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

From: Mike Galbraith <efault@gmx.de>

1e64b15a4b10 ("rcu: Fix grace-period hangs due to race with CPU offline")
added spinlock_t ofl_lock to the rcu_state structure, then takes it with
preemption disabled during CPU offline, which gives the -rt patchset's
sleeping spinlock heartburn.

This commit therefore converts ->ofl_lock to raw_spinlock_t.

Signed-off-by: Mike Galbraith <efault@gmx.de>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/rcu/tree.c | 12 ++++++------
 kernel/rcu/tree.h |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 65b6e03ae6f5..0ce4702ce09f 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -97,7 +97,7 @@ struct rcu_state rcu_state = {
 	.abbr = RCU_ABBR,
 	.exp_mutex = __MUTEX_INITIALIZER(rcu_state.exp_mutex),
 	.exp_wake_mutex = __MUTEX_INITIALIZER(rcu_state.exp_wake_mutex),
-	.ofl_lock = __SPIN_LOCK_UNLOCKED(rcu_state.ofl_lock),
+	.ofl_lock = __RAW_SPIN_LOCK_UNLOCKED(rcu_state.ofl_lock),
 };
 
 /* Dump rcu_node combining tree at boot to verify correct setup. */
@@ -1775,13 +1775,13 @@ static bool rcu_gp_init(void)
 	 */
 	rcu_state.gp_state = RCU_GP_ONOFF;
 	rcu_for_each_leaf_node(rnp) {
-		spin_lock(&rcu_state.ofl_lock);
+		raw_spin_lock(&rcu_state.ofl_lock);
 		raw_spin_lock_irq_rcu_node(rnp);
 		if (rnp->qsmaskinit == rnp->qsmaskinitnext &&
 		    !rnp->wait_blkd_tasks) {
 			/* Nothing to do on this leaf rcu_node structure. */
 			raw_spin_unlock_irq_rcu_node(rnp);
-			spin_unlock(&rcu_state.ofl_lock);
+			raw_spin_unlock(&rcu_state.ofl_lock);
 			continue;
 		}
 
@@ -1817,7 +1817,7 @@ static bool rcu_gp_init(void)
 		}
 
 		raw_spin_unlock_irq_rcu_node(rnp);
-		spin_unlock(&rcu_state.ofl_lock);
+		raw_spin_unlock(&rcu_state.ofl_lock);
 	}
 	rcu_gp_slow(gp_preinit_delay); /* Races with CPU hotplug. */
 
@@ -3376,7 +3376,7 @@ void rcu_report_dead(unsigned int cpu)
 
 	/* Remove outgoing CPU from mask in the leaf rcu_node structure. */
 	mask = rdp->grpmask;
-	spin_lock(&rcu_state.ofl_lock);
+	raw_spin_lock(&rcu_state.ofl_lock);
 	raw_spin_lock_irqsave_rcu_node(rnp, flags); /* Enforce GP memory-order guarantee. */
 	rdp->rcu_ofl_gp_seq = READ_ONCE(rcu_state.gp_seq);
 	rdp->rcu_ofl_gp_flags = READ_ONCE(rcu_state.gp_flags);
@@ -3387,7 +3387,7 @@ void rcu_report_dead(unsigned int cpu)
 	}
 	rnp->qsmaskinitnext &= ~mask;
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
-	spin_unlock(&rcu_state.ofl_lock);
+	raw_spin_unlock(&rcu_state.ofl_lock);
 
 	per_cpu(rcu_cpu_started, cpu) = 0;
 }
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index bfbf97a1c29d..703e19ff532d 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -343,7 +343,7 @@ struct rcu_state {
 	const char *name;			/* Name of structure. */
 	char abbr;				/* Abbreviated name. */
 
-	spinlock_t ofl_lock ____cacheline_internodealigned_in_smp;
+	raw_spinlock_t ofl_lock ____cacheline_internodealigned_in_smp;
 						/* Synchronize offline with */
 						/*  GP pre-initialization. */
 };
-- 
2.17.1

