Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6711EC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F67F20644
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:42:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F67F20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbeH3CiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 22:38:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48198 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727477AbeH3CiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 22:38:06 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7TMclk8118534
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:39:02 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m61jbx66s-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:39:02 -0400
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 29 Aug 2018 18:39:01 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (9.57.198.24)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 29 Aug 2018 18:38:56 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7TMctam3735934
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Aug 2018 22:38:55 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5F8C7B2067;
        Wed, 29 Aug 2018 18:37:51 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3E693B2071;
        Wed, 29 Aug 2018 18:37:51 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 29 Aug 2018 18:37:51 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id B7F3F16C91C5; Wed, 29 Aug 2018 15:38:55 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 02/52] rcu: Remove rsp parameter from rcu_report_qs_rsp()
Date:   Wed, 29 Aug 2018 15:38:04 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829223830.GA1800@linux.vnet.ibm.com>
References: <20180829223830.GA1800@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18082922-0068-0000-0000-00000331B94F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009636; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01080744; UDB=6.00557497; IPR=6.00860730;
 MB=3.00023002; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-29 22:38:59
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082922-0069-0000-0000-0000458F160B
Message-Id: <20180829223854.4055-2-paulmck@linux.vnet.ibm.com>
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
rcu_report_qs_rsp().

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index c9f4d7f3de91..73dde7c661e7 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -138,7 +138,7 @@ static void rcu_init_new_rnp(struct rcu_node *rnp_leaf);
 static void rcu_cleanup_dead_rnp(struct rcu_node *rnp_leaf);
 static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp, int outgoingcpu);
 static void invoke_rcu_core(void);
-static void invoke_rcu_callbacks(struct rcu_state *rsp, struct rcu_data *rdp);
+static void invoke_rcu_callbacks(struct rcu_data *rdp);
 static void rcu_report_exp_rdp(struct rcu_state *rsp, struct rcu_data *rdp);
 static void sync_sched_exp_online_cleanup(int cpu);
 
@@ -2188,9 +2188,11 @@ static int __noreturn rcu_gp_kthread(void *arg)
  * just-completed grace period.  Note that the caller must hold rnp->lock,
  * which is released before return.
  */
-static void rcu_report_qs_rsp(struct rcu_state *rsp, unsigned long flags)
+static void rcu_report_qs_rsp(unsigned long flags)
 	__releases(rcu_get_root(rsp)->lock)
 {
+	struct rcu_state *rsp = &rcu_state;
+
 	raw_lockdep_assert_held_rcu_node(rcu_get_root(rsp));
 	WARN_ON_ONCE(!rcu_gp_in_progress(rsp));
 	WRITE_ONCE(rsp->gp_flags, READ_ONCE(rsp->gp_flags) | RCU_GP_FLAG_FQS);
@@ -2267,7 +2269,7 @@ static void rcu_report_qs_rnp(unsigned long mask, struct rcu_node *rnp,
 	 * state for this grace period.  Invoke rcu_report_qs_rsp()
 	 * to clean up and start the next grace period if one is needed.
 	 */
-	rcu_report_qs_rsp(rsp, flags); /* releases rnp->lock. */
+	rcu_report_qs_rsp(flags); /* releases rnp->lock. */
 }
 
 /*
@@ -2301,7 +2303,7 @@ rcu_report_unblock_qs_rnp(struct rcu_state *rsp,
 		 * Only one rcu_node structure in the tree, so don't
 		 * try to report up to its nonexistent parent!
 		 */
-		rcu_report_qs_rsp(rsp, flags);
+		rcu_report_qs_rsp(flags);
 		return;
 	}
 
@@ -2760,7 +2762,7 @@ __rcu_process_callbacks(struct rcu_state *rsp)
 
 	/* If there are callbacks ready, invoke them. */
 	if (rcu_segcblist_ready_cbs(&rdp->cblist))
-		invoke_rcu_callbacks(rsp, rdp);
+		invoke_rcu_callbacks(rdp);
 
 	/* Do any needed deferred wakeups of rcuo kthreads. */
 	do_nocb_deferred_wakeup(rdp);
@@ -2788,8 +2790,10 @@ static __latent_entropy void rcu_process_callbacks(struct softirq_action *unused
  * are running on the current CPU with softirqs disabled, the
  * rcu_cpu_kthread_task cannot disappear out from under us.
  */
-static void invoke_rcu_callbacks(struct rcu_state *rsp, struct rcu_data *rdp)
+static void invoke_rcu_callbacks(struct rcu_data *rdp)
 {
+	struct rcu_state *rsp = &rcu_state;
+
 	if (unlikely(!READ_ONCE(rcu_scheduler_fully_active)))
 		return;
 	if (likely(!rsp->boost)) {
-- 
2.17.1

