Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 761A6C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3057B26E5D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:12:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3057B26E5D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933139AbeFZRM3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 13:12:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48196 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932133AbeFZRIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 13:08:53 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5QH5dbx081817
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 13:08:53 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jurm431m1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 13:08:52 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 26 Jun 2018 13:08:51 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Jun 2018 13:08:46 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5QH8jpQ1311216
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Jun 2018 17:08:45 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6FBE9B206C;
        Tue, 26 Jun 2018 13:08:39 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4409BB2065;
        Tue, 26 Jun 2018 13:08:39 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 26 Jun 2018 13:08:39 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id C22E816CA0A7; Tue, 26 Jun 2018 10:10:49 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 12/22] rcu: Fix grace-period hangs from mid-init task resume
Date:   Tue, 26 Jun 2018 10:10:38 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626002052.GA24146@linux.vnet.ibm.com>
References: <20180626002052.GA24146@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062617-0068-0000-0000-0000030E8181
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009259; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052668; UDB=6.00539669; IPR=6.00830593;
 MB=3.00021864; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-26 17:08:50
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062617-0069-0000-0000-000044D130DC
Message-Id: <20180626171048.2181-12-paulmck@linux.vnet.ibm.com>
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

Without special fail-safe quiescent-state-propagation checks, grace-period
hangs can result from the following scenario:

1.	A task running on a given CPU is preempted in its RCU read-side
	critical section.

2.	That CPU goes offline, and there are now no online CPUs
	corresponding to that CPU's leaf rcu_node structure.

3.	The rcu_gp_init() function does the first phase of grace-period
	initialization, and sets the aforementioned leaf rcu_node
	structure's ->qsmaskinit field to all zeroes.  Because there
	is a blocked task, it does not propagate the zeroing of either
	->qsmaskinit or ->qsmaskinitnext up the rcu_node tree.

4.	The task resumes on some other CPU and exits its critical section.
	There is no grace period in progress, so the resulting quiescent
	state is not reported up the tree.

5.	The rcu_gp_init() function does the second phase of grace-period
	initialization, which results in the leaf rcu_node structure
	being initialized to expect no further quiescent states, but
	with that structure's parent expecting a quiescent-state report.

	The parent will never receive a quiescent state from this leaf
	rcu_node structure, so the grace period will hang, resulting in
	RCU CPU stall warnings.

It would be good to get rid of the special fail-safe quiescent-state
propagation checks.  This commit therefore checks the leaf rcu_node
structure's ->wait_blkd_tasks field during grace-period initialization.
If this flag is set, the rcu_report_qs_rnp() is invoked to immediately
report the possible quiescent state.  While in the neighborhood, this
commit also report quiescent states for any CPUs that went offline between
the two phases of grace-period initialization, thus reducing grace-period
delays and hopefully eventually allowing removal of offline-CPU checks
from the force-quiescent-state code path.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 006d6e407f96..2cfd5d3da4f8 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -154,6 +154,9 @@ EXPORT_SYMBOL_GPL(rcu_scheduler_active);
  */
 static int rcu_scheduler_fully_active __read_mostly;
 
+static void
+rcu_report_qs_rnp(unsigned long mask, struct rcu_state *rsp,
+		  struct rcu_node *rnp, unsigned long gps, unsigned long flags);
 static void rcu_init_new_rnp(struct rcu_node *rnp_leaf);
 static void rcu_cleanup_dead_rnp(struct rcu_node *rnp_leaf);
 static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp, int outgoingcpu);
@@ -1858,7 +1861,9 @@ static void rcu_gp_slow(struct rcu_state *rsp, int delay)
  */
 static bool rcu_gp_init(struct rcu_state *rsp)
 {
+	unsigned long flags;
 	unsigned long oldmask;
+	unsigned long mask;
 	struct rcu_data *rdp;
 	struct rcu_node *rnp = rcu_get_root(rsp);
 
@@ -1951,7 +1956,7 @@ static bool rcu_gp_init(struct rcu_state *rsp)
 	 */
 	rcu_for_each_node_breadth_first(rsp, rnp) {
 		rcu_gp_slow(rsp, gp_init_delay);
-		raw_spin_lock_irq_rcu_node(rnp);
+		raw_spin_lock_irqsave_rcu_node(rnp, flags);
 		rdp = this_cpu_ptr(rsp->rda);
 		rcu_preempt_check_blocked_tasks(rnp);
 		rnp->qsmask = rnp->qsmaskinit;
@@ -1962,7 +1967,12 @@ static bool rcu_gp_init(struct rcu_state *rsp)
 		trace_rcu_grace_period_init(rsp->name, rnp->gp_seq,
 					    rnp->level, rnp->grplo,
 					    rnp->grphi, rnp->qsmask);
-		raw_spin_unlock_irq_rcu_node(rnp);
+		/* Quiescent states for tasks on any now-offline CPUs. */
+		mask = rnp->qsmask & ~rnp->qsmaskinitnext;
+		if ((mask || rnp->wait_blkd_tasks) && rcu_is_leaf_node(rnp))
+			rcu_report_qs_rnp(mask, rsp, rnp, rnp->gp_seq, flags);
+		else
+			raw_spin_unlock_irq_rcu_node(rnp);
 		cond_resched_tasks_rcu_qs();
 		WRITE_ONCE(rsp->gp_activity, jiffies);
 	}
@@ -2233,6 +2243,10 @@ static void rcu_report_qs_rsp(struct rcu_state *rsp, unsigned long flags)
  * is the grace-period snapshot, which means that the quiescent states
  * are valid only if rnp->gp_seq is equal to gps.  That structure's lock
  * must be held upon entry, and it is released before return.
+ *
+ * As a special case, if mask is zero, the bit-already-cleared check is
+ * disabled.  This allows propagating quiescent state due to resumed tasks
+ * during grace-period initialization.
  */
 static void
 rcu_report_qs_rnp(unsigned long mask, struct rcu_state *rsp,
@@ -2246,7 +2260,7 @@ rcu_report_qs_rnp(unsigned long mask, struct rcu_state *rsp,
 
 	/* Walk up the rcu_node hierarchy. */
 	for (;;) {
-		if (!(rnp->qsmask & mask) || rnp->gp_seq != gps) {
+		if ((!(rnp->qsmask & mask) && mask) || rnp->gp_seq != gps) {
 
 			/*
 			 * Our bit has already been cleared, or the
-- 
2.17.1

