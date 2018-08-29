Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4994CC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0236920644
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:41:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0236920644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbeH3Ck0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 22:40:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34472 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727593AbeH3CiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 22:38:08 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7TMckjC102651
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:39:04 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2m615df8pe-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:39:04 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 29 Aug 2018 18:39:03 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 29 Aug 2018 18:38:58 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7TMcvw418743480
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Aug 2018 22:38:57 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2961AB2077;
        Wed, 29 Aug 2018 18:37:53 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0401DB206C;
        Wed, 29 Aug 2018 18:37:53 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 29 Aug 2018 18:37:52 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 334CF16C91C5; Wed, 29 Aug 2018 15:38:56 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 22/52] rcu: Remove rsp parameter from rcu_gp_kthread() and friends
Date:   Wed, 29 Aug 2018 15:38:24 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829223830.GA1800@linux.vnet.ibm.com>
References: <20180829223830.GA1800@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18082922-0040-0000-0000-000004675841
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009636; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01080744; UDB=6.00557497; IPR=6.00860730;
 MB=3.00023002; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-29 22:39:01
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082922-0041-0000-0000-0000086E721B
Message-Id: <20180829223854.4055-22-paulmck@linux.vnet.ibm.com>
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
rcu_gp_init(), rcu_gp_fqs_check_wake(), rcu_gp_fqs(), rcu_gp_cleanup(),
and rcu_gp_kthread().

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 751c28ddf5b1..b2d79570c70f 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1831,13 +1831,14 @@ static void rcu_gp_slow(int delay)
 /*
  * Initialize a new grace period.  Return false if no grace period required.
  */
-static bool rcu_gp_init(struct rcu_state *rsp)
+static bool rcu_gp_init(void)
 {
 	unsigned long flags;
 	unsigned long oldmask;
 	unsigned long mask;
 	struct rcu_data *rdp;
 	struct rcu_node *rnp = rcu_get_root();
+	struct rcu_state *rsp = &rcu_state;
 
 	WRITE_ONCE(rsp->gp_activity, jiffies);
 	raw_spin_lock_irq_rcu_node(rnp);
@@ -1962,12 +1963,12 @@ static bool rcu_gp_init(struct rcu_state *rsp)
  * Helper function for swait_event_idle_exclusive() wakeup at force-quiescent-state
  * time.
  */
-static bool rcu_gp_fqs_check_wake(struct rcu_state *rsp, int *gfp)
+static bool rcu_gp_fqs_check_wake(int *gfp)
 {
 	struct rcu_node *rnp = rcu_get_root();
 
 	/* Someone like call_rcu() requested a force-quiescent-state scan. */
-	*gfp = READ_ONCE(rsp->gp_flags);
+	*gfp = READ_ONCE(rcu_state.gp_flags);
 	if (*gfp & RCU_GP_FLAG_FQS)
 		return true;
 
@@ -1981,9 +1982,10 @@ static bool rcu_gp_fqs_check_wake(struct rcu_state *rsp, int *gfp)
 /*
  * Do one round of quiescent-state forcing.
  */
-static void rcu_gp_fqs(struct rcu_state *rsp, bool first_time)
+static void rcu_gp_fqs(bool first_time)
 {
 	struct rcu_node *rnp = rcu_get_root();
+	struct rcu_state *rsp = &rcu_state;
 
 	WRITE_ONCE(rsp->gp_activity, jiffies);
 	rsp->n_force_qs++;
@@ -2006,13 +2008,14 @@ static void rcu_gp_fqs(struct rcu_state *rsp, bool first_time)
 /*
  * Clean up after the old grace period.
  */
-static void rcu_gp_cleanup(struct rcu_state *rsp)
+static void rcu_gp_cleanup(void)
 {
 	unsigned long gp_duration;
 	bool needgp = false;
 	unsigned long new_gp_seq;
 	struct rcu_data *rdp;
 	struct rcu_node *rnp = rcu_get_root();
+	struct rcu_state *rsp = &rcu_state;
 	struct swait_queue_head *sq;
 
 	WRITE_ONCE(rsp->gp_activity, jiffies);
@@ -2089,13 +2092,13 @@ static void rcu_gp_cleanup(struct rcu_state *rsp)
 /*
  * Body of kthread that handles grace periods.
  */
-static int __noreturn rcu_gp_kthread(void *arg)
+static int __noreturn rcu_gp_kthread(void *unused)
 {
 	bool first_gp_fqs;
 	int gf;
 	unsigned long j;
 	int ret;
-	struct rcu_state *rsp = arg;
+	struct rcu_state *rsp = &rcu_state;
 	struct rcu_node *rnp = rcu_get_root();
 
 	rcu_bind_gp_kthread();
@@ -2111,7 +2114,7 @@ static int __noreturn rcu_gp_kthread(void *arg)
 						     RCU_GP_FLAG_INIT);
 			rsp->gp_state = RCU_GP_DONE_GPS;
 			/* Locking provides needed memory barrier. */
-			if (rcu_gp_init(rsp))
+			if (rcu_gp_init())
 				break;
 			cond_resched_tasks_rcu_qs();
 			WRITE_ONCE(rsp->gp_activity, jiffies);
@@ -2136,7 +2139,7 @@ static int __noreturn rcu_gp_kthread(void *arg)
 					       TPS("fqswait"));
 			rsp->gp_state = RCU_GP_WAIT_FQS;
 			ret = swait_event_idle_timeout_exclusive(rsp->gp_wq,
-					rcu_gp_fqs_check_wake(rsp, &gf), j);
+					rcu_gp_fqs_check_wake(&gf), j);
 			rsp->gp_state = RCU_GP_DOING_FQS;
 			/* Locking provides needed memory barriers. */
 			/* If grace period done, leave loop. */
@@ -2149,7 +2152,7 @@ static int __noreturn rcu_gp_kthread(void *arg)
 				trace_rcu_grace_period(rsp->name,
 						       READ_ONCE(rsp->gp_seq),
 						       TPS("fqsstart"));
-				rcu_gp_fqs(rsp, first_gp_fqs);
+				rcu_gp_fqs(first_gp_fqs);
 				first_gp_fqs = false;
 				trace_rcu_grace_period(rsp->name,
 						       READ_ONCE(rsp->gp_seq),
@@ -2177,7 +2180,7 @@ static int __noreturn rcu_gp_kthread(void *arg)
 
 		/* Handle grace-period end. */
 		rsp->gp_state = RCU_GP_CLEANUP;
-		rcu_gp_cleanup(rsp);
+		rcu_gp_cleanup();
 		rsp->gp_state = RCU_GP_CLEANED;
 	}
 }
@@ -3743,7 +3746,7 @@ static int __init rcu_spawn_gp_kthread(void)
 
 	rcu_scheduler_fully_active = 1;
 	for_each_rcu_flavor(rsp) {
-		t = kthread_create(rcu_gp_kthread, rsp, "%s", rsp->name);
+		t = kthread_create(rcu_gp_kthread, NULL, "%s", rsp->name);
 		BUG_ON(IS_ERR(t));
 		rnp = rcu_get_root();
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
-- 
2.17.1

