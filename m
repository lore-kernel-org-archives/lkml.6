Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 976ECC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EC8A26E53
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:11:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EC8A26E53
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932205AbeFZRI7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 13:08:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33124 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753014AbeFZRIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 13:08:51 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5QH5RXG119016
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 13:08:50 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jus3ysbmk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 13:08:50 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 26 Jun 2018 13:08:49 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (9.57.198.25)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Jun 2018 13:08:45 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5QH8icU5833402
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Jun 2018 17:08:44 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EF06BB2072;
        Tue, 26 Jun 2018 13:08:37 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B1AC7B2066;
        Tue, 26 Jun 2018 13:08:37 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 26 Jun 2018 13:08:37 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 8D7FA16C5DDD; Tue, 26 Jun 2018 10:10:49 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 01/22] rcu: Clean up handling of tasks blocked across full-rcu_node offline
Date:   Tue, 26 Jun 2018 10:10:27 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626002052.GA24146@linux.vnet.ibm.com>
References: <20180626002052.GA24146@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062617-0068-0000-0000-0000030E817C
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009259; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052668; UDB=6.00539669; IPR=6.00830593;
 MB=3.00021864; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-26 17:08:48
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062617-0069-0000-0000-000044D130D3
Message-Id: <20180626171048.2181-1-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-26_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806260192
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 0aa04b055e71 ("rcu: Process offlining and onlining only at
grace-period start") deferred handling of CPU-hotplug events until the
start of the next grace period, but consider the following sequence
of events:

1.	A task is preempted within an RCU-preempt read-side critical
	section.

2.	The CPU that this task was running on goes offline, along with all
	other CPUs sharing the corresponding leaf rcu_node structure.

3.	The task resumes execution.

4.	One of those CPUs comes back online before a new grace period starts.

In step 2, the code in the next rcu_gp_init() invocation will (correctly)
defer removing the leaf rcu_node structure from the upper-level bitmasks,
and will (correctly) set that structure's ->wait_blkd_tasks field.  During
the ensuing interval, RCU will (correctly) track the tasks preempted on
that structure because they must block any subsequent grace period.

In step 3, the code in rcu_read_unlock_special() will (correctly) remove
the task from the leaf rcu_node structure.  From this point forward, RCU
need not pay attention to this structure, at least not until one of the
corresponding CPUs comes back online.

In step 4, the code in the next rcu_gp_init() invocation will
(incorrectly) inovke rcu_init_new_rnp().  This is incorrect because
the corresponding rcu_cleanup_dead_rnp() was never invoked.  This is
nevertheless harmless because the upper-level bits are still set.
So, no harm, no foul, right?

At least, all is well until a little further into rcu_gp_init()
invocation, which will notice that there are no longer any tasks blocked
on the leaf rcu_node structure, conclude that there is no longer anything
left over from step 2's offline operation, and will therefore invoke
rcu_cleanup_dead_rnp().  But this invocation of rcu_cleanup_dead_rnp()
is for the beginning of the earlier offline interval, and the previous
invocation of rcu_init_new_rnp() is for the end of that same interval.
That is right, they are invoked out of order.

That cannot be good, can it?

It turns out that this is not a (correctness!) problem because
rcu_cleanup_dead_rnp() checks to see if any of the corresponding CPUs
are online, and refuses to do anything if so.  In other words, in the
case where rcu_init_new_rnp() and rcu_cleanup_dead_rnp() execute out of
order, they both have no effect.

But this is at best an accident waiting to happen.

This commit therefore adds logic to rcu_gp_init() so that
rcu_init_new_rnp() and rcu_cleanup_dead_rnp() are always invoked in
order, and so that neither are invoked at all in cases where RCU had to
pay attention to the leaf rcu_node structure during the entire time that
all corresponding CPUs were offline.

And, while in the area, this commit reduces confusion by using formal
parameters rather than local variables that just happen to have the same
value at that particular point in the code.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 73298a27620f..bde895507335 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1909,12 +1909,14 @@ static bool rcu_gp_init(struct rcu_state *rsp)
 
 		/* If zero-ness of ->qsmaskinit changed, propagate up tree. */
 		if (!oldmask != !rnp->qsmaskinit) {
-			if (!oldmask) /* First online CPU for this rcu_node. */
-				rcu_init_new_rnp(rnp);
-			else if (rcu_preempt_has_tasks(rnp)) /* blocked tasks */
-				rnp->wait_blkd_tasks = true;
-			else /* Last offline CPU and can propagate. */
+			if (!oldmask) { /* First online CPU for rcu_node. */
+				if (!rnp->wait_blkd_tasks) /* Ever offline? */
+					rcu_init_new_rnp(rnp);
+			} else if (rcu_preempt_has_tasks(rnp)) {
+				rnp->wait_blkd_tasks = true; /* blocked tasks */
+			} else { /* Last offline CPU and can propagate. */
 				rcu_cleanup_dead_rnp(rnp);
+			}
 		}
 
 		/*
@@ -1923,14 +1925,13 @@ static bool rcu_gp_init(struct rcu_state *rsp)
 		 * still offline, propagate up the rcu_node tree and
 		 * clear ->wait_blkd_tasks.  Otherwise, if one of this
 		 * rcu_node structure's CPUs has since come back online,
-		 * simply clear ->wait_blkd_tasks (but rcu_cleanup_dead_rnp()
-		 * checks for this, so just call it unconditionally).
+		 * simply clear ->wait_blkd_tasks.
 		 */
 		if (rnp->wait_blkd_tasks &&
-		    (!rcu_preempt_has_tasks(rnp) ||
-		     rnp->qsmaskinit)) {
+		    (!rcu_preempt_has_tasks(rnp) || rnp->qsmaskinit)) {
 			rnp->wait_blkd_tasks = false;
-			rcu_cleanup_dead_rnp(rnp);
+			if (!rnp->qsmaskinit)
+				rcu_cleanup_dead_rnp(rnp);
 		}
 
 		raw_spin_unlock_irq_rcu_node(rnp);
@@ -2450,9 +2451,10 @@ static void rcu_cleanup_dead_rnp(struct rcu_node *rnp_leaf)
 	long mask;
 	struct rcu_node *rnp = rnp_leaf;
 
-	raw_lockdep_assert_held_rcu_node(rnp);
+	raw_lockdep_assert_held_rcu_node(rnp_leaf);
 	if (!IS_ENABLED(CONFIG_HOTPLUG_CPU) ||
-	    rnp->qsmaskinit || rcu_preempt_has_tasks(rnp))
+	    WARN_ON_ONCE(rnp_leaf->qsmaskinit) ||
+	    WARN_ON_ONCE(rcu_preempt_has_tasks(rnp_leaf)))
 		return;
 	for (;;) {
 		mask = rnp->grpmask;
@@ -2461,7 +2463,8 @@ static void rcu_cleanup_dead_rnp(struct rcu_node *rnp_leaf)
 			break;
 		raw_spin_lock_rcu_node(rnp); /* irqs already disabled. */
 		rnp->qsmaskinit &= ~mask;
-		rnp->qsmask &= ~mask;
+		/* Between grace periods, so better already be zero! */
+		WARN_ON_ONCE(rnp->qsmask);
 		if (rnp->qsmaskinit) {
 			raw_spin_unlock_rcu_node(rnp);
 			/* irqs remain disabled. */
@@ -3477,6 +3480,7 @@ static void rcu_init_new_rnp(struct rcu_node *rnp_leaf)
 	struct rcu_node *rnp = rnp_leaf;
 
 	raw_lockdep_assert_held_rcu_node(rnp);
+	WARN_ON_ONCE(rnp->wait_blkd_tasks);
 	for (;;) {
 		mask = rnp->grpmask;
 		rnp = rnp->parent;
-- 
2.17.1

