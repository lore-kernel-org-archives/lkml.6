Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FFE9C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C005D26E5D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 17:12:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C005D26E5D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933043AbeFZRM0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 13:12:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48194 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932134AbeFZRIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 13:08:53 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5QH5dbi081841
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 13:08:53 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jurm431kr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 13:08:52 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Tue, 26 Jun 2018 13:08:51 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 26 Jun 2018 13:08:45 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5QH8iQd1311210
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Jun 2018 17:08:45 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 71A59B2068;
        Tue, 26 Jun 2018 13:08:38 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 44BE6B2067;
        Tue, 26 Jun 2018 13:08:38 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 26 Jun 2018 13:08:38 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id BCA6316CA0A6; Tue, 26 Jun 2018 10:10:49 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 11/22] rcu: Suppress false-positive splats from mid-init task resume
Date:   Tue, 26 Jun 2018 10:10:37 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626002052.GA24146@linux.vnet.ibm.com>
References: <20180626002052.GA24146@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062617-0068-0000-0000-0000030E8180
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009259; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052668; UDB=6.00539669; IPR=6.00830593;
 MB=3.00021864; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-26 17:08:49
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062617-0069-0000-0000-000044D130D9
Message-Id: <20180626171048.2181-11-paulmck@linux.vnet.ibm.com>
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

1.	All CPUs corresponding to a given leaf rcu_node structure are
	offline.

2.	The first phase of the rcu_gp_init() function's grace-period
	initialization runs, and sets that rcu_node structure's
	->qsmaskinit to zero, as it should.

3.	One of the CPUs corresponding to that rcu_node structure comes
	back online.  Note that because this CPU came online after the
	grace period started, this grace period can safely ignore this
	newly onlined CPU.

4.	A task running on the newly onlined CPU enters an RCU-preempt
	read-side critical section, and is then preempted.  Because
	the corresponding rcu_node structure's ->qsmask is zero,
	rcu_preempt_ctxt_queue() leaves the rcu_node structure's
	->gp_tasks field NULL, as it should.

5.	The rcu_gp_init() function continues running the second phase of
	grace-period initialization.  The ->qsmask field of the parent of
	the aforementioned leaf rcu_node structure is set to not expect
	a quiescent state from the leaf, as is only right and proper.

	However, when rcu_gp_init() reaches the leaf, it invokes
	rcu_preempt_check_blocked_tasks(), which sees that the leaf's
	->blkd_tasks list is non-empty, and therefore sets the leaf's
	->gp_tasks field to reference the first task on that list.

6.	The grace period ends before the preempted task resumes, which
	is perfectly fine, given that this grace period was under no
	obligation to wait for that task to exit its late-starting
	RCU-preempt read-side critical section.  Unfortunately, the
	leaf's ->gp_tasks field is non-NULL, so rcu_gp_cleanup() splats.
	After all, it appears to rcu_gp_cleanup() that the grace period
	failed to wait for a task that was supposed to be blocking that
	grace period.

This commit avoids this false-positive splat by adding a check of both
->qsmaskinit and ->wait_blkd_tasks to rcu_preempt_check_blocked_tasks().
If both ->qsmaskinit and ->wait_blkd_tasks are zero, then the task must
have entered its RCU-preempt read-side critical section late (after all,
the CPU that it is running on was not online at that time), which means
that the upper-level rcu_node structure won't be waiting for anything
on the leaf anyway.

If ->wait_blkd_tasks is non-zero, then there is at least one task on
ths rcu_node structure's ->blkd_tasks list whose RCU read-side
critical section predates the current grace period.  If ->qsmaskinit
is non-zero, there is at least one CPU that was online at the start
of the current grace period.  Thus, if both are zero, there is nothing
to wait for.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree_plugin.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 677b0c9f548d..1c9a836af5b6 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -703,7 +703,8 @@ static void rcu_preempt_check_blocked_tasks(struct rcu_node *rnp)
 	RCU_LOCKDEP_WARN(preemptible(), "rcu_preempt_check_blocked_tasks() invoked with preemption enabled!!!\n");
 	if (WARN_ON_ONCE(rcu_preempt_blocked_readers_cgp(rnp)))
 		dump_blkd_tasks(rnp, 10);
-	if (rcu_preempt_has_tasks(rnp)) {
+	if (rcu_preempt_has_tasks(rnp) &&
+	    (rnp->qsmaskinit || rnp->wait_blkd_tasks)) {
 		rnp->gp_tasks = rnp->blkd_tasks.next;
 		t = container_of(rnp->gp_tasks, struct task_struct,
 				 rcu_node_entry);
-- 
2.17.1

