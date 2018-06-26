Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AACFC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2B762171F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:08:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2B762171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932179AbeFZRIz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 13:08:55 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40116 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752368AbeFZRIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 13:08:50 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5QH4LlX027262
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 13:08:50 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jup7c1v6u-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 13:08:50 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 26 Jun 2018 13:08:49 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Jun 2018 13:08:45 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5QH8i9h16974106
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Jun 2018 17:08:45 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 72605B2075;
        Tue, 26 Jun 2018 13:08:38 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3F0CFB206C;
        Tue, 26 Jun 2018 13:08:38 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 26 Jun 2018 13:08:38 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id B7E3516CA0A5; Tue, 26 Jun 2018 10:10:49 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 10/22] rcu: Suppress more involved false-positive preempted-task splats
Date:   Tue, 26 Jun 2018 10:10:36 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626002052.GA24146@linux.vnet.ibm.com>
References: <20180626002052.GA24146@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062617-0072-0000-0000-00000374C871
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009259; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052668; UDB=6.00539668; IPR=6.00830593;
 MB=3.00021864; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-26 17:08:49
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062617-0073-0000-0000-0000487E75F2
Message-Id: <20180626171048.2181-10-paulmck@linux.vnet.ibm.com>
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

Consider the following sequence of events in a PREEMPT=y kernel:

1.	All but one of the CPUs corresponding to a given leaf rcu_node
	structure go offline.  Each of these CPUs clears its bit in that
	structure's ->qsmaskinitnext field.

2.	A new grace period starts, and rcu_gp_init() scans the leaf
	rcu_node structures, applying CPU-hotplug changes since the
	start of the previous grace period, including those changes in
	#1 above.  This copies each leaf structure's ->qsmaskinitnext
	to its ->qsmask field, which represents the CPUs that this new
	grace period will wait on.  Each copy operation is done holding
	the corresponding leaf rcu_node structure's ->lock, and at the
	end of this scan, rcu_gp_init() holds no locks.

3.	The last CPU corresponding to #1's leaf rcu_node structure goes
	offline, clearing its bit in that structure's ->qsmaskinitnext
	field, but not touching the ->qsmaskinit field.  Note that
	rcu_gp_init() is not currently holding any locks!  This CPU does
	-not- report a quiescent state because the grace period has not
	yet initialized itself sufficiently to have set any bits in any
	of the leaf rcu_node structures' ->qsmask fields.

4.	The rcu_gp_init() function continues initializing the new grace
	period, copying each leaf rcu_node structure's ->qsmaskinit
	field to its ->qsmask field while holding the corresponding ->lock.
	This sets the ->qsmask bit corresponding to #3's CPU.

5.	Before the grace period ends, #3's CPU comes back online.
	Because te grace period has not yet done any force-quiescent-state
	scans (which would report a quiescent state on behalf of any
	offline CPUs), this CPU's ->qsmask bit is still set.

6.	A task running on the newly onlined CPU is preempted while in
	an RCU read-side critical section.  Because this CPU's ->qsmask
	bit is net, not only does this task queue itself on the leaf
	rcu_node structure's ->blkd_tasks list, it also sets that
	structure's ->gp_tasks pointer to reference it.

7.	The grace period started in #1 above comes to an end.  This
	results in rcu_gp_cleanup() being invoked, which, among other
	things, checks to make sure that there are no tasks blocking the
	just-ended grace period, that is, that all ->gp_tasks pointers
	are NULL.  The ->gp_tasks pointer corresponding to the task
	preempted in #3 above is non-NULL, which results in a splat.

This splat is a false positive.  The task's RCU read-side critical
section cannot have begun before the just-ended grace period because
this would mean either: (1) The CPU came online before the grace period
started, which cannot have happened because the grace period started
before that CPU went offline, or (2) The task started its RCU read-side
critical section on some other CPU, but then it would have had to have
been preempted before migrating to this CPU, which would mean that it
would have instead queued itself on that other CPU's rcu_node structure.
RCU's grace periods thus are working correctly.  Or, more accurately,
that remaining bugs in RCU's grace periods are elsewhere.

This commit eliminates this false positive by adding code to the end
of rcu_cpu_starting() that reports a quiescent state to RCU, which has
the side-effect of clearing that CPU's ->qsmask bit, preventing the
above scenario.  This approach has the added benefit of more promptly
reporting quiescent states corresponding to offline CPUs.  Nevertheless,
this commit does -not- remove the need for the force-quiescent-state
scans to check for offline CPUs, given that a CPU might remain offline
indefinitely.  And without the checks in the force-quiescent-state scans,
the grace period would also persist indefinitely, which could result in
hangs or memory exhaustion.

Note well that the call to rcu_report_qs_rnp() reporting the quiescent
state must come -after- the setting of this CPU's bit in the leaf rcu_node
structure's ->qsmaskinitnext field.  Otherwise, lockdep-RCU will complain
bitterly about quiescent states coming from an offline CPU.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 58ca69b5656b..006d6e407f96 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3708,7 +3708,12 @@ void rcu_cpu_starting(unsigned int cpu)
 		nbits = bitmap_weight(&oldmask, BITS_PER_LONG);
 		/* Allow lockless access for expedited grace periods. */
 		smp_store_release(&rsp->ncpus, rsp->ncpus + nbits); /* ^^^ */
-		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
+		if (rnp->qsmask & mask) { /* RCU waiting on incoming CPU? */
+			/* Report QS -after- changing ->qsmaskinitnext! */
+			rcu_report_qs_rnp(mask, rsp, rnp, rnp->gp_seq, flags);
+		} else {
+			raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
+		}
 	}
 	smp_mb(); /* Ensure RCU read-side usage follows above initialization. */
 }
-- 
2.17.1

