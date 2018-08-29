Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29108C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1F1820644
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:54:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1F1820644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbeH3Cx0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 22:53:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52796 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727607AbeH3CxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 22:53:24 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7TMs1fe122229
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:54:15 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m64a28kqf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:54:15 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 29 Aug 2018 18:54:13 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 29 Aug 2018 18:54:08 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7TMs7tp26542276
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Aug 2018 22:54:07 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0B843B205F;
        Wed, 29 Aug 2018 18:53:03 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CCB30B2065;
        Wed, 29 Aug 2018 18:53:02 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 29 Aug 2018 18:53:02 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 541FF16C91C5; Wed, 29 Aug 2018 15:54:07 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 02/24] rcu: Pull rcu_gp_kthread() FQS loop into separate function
Date:   Wed, 29 Aug 2018 15:53:43 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829225340.GA7019@linux.vnet.ibm.com>
References: <20180829225340.GA7019@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18082922-0052-0000-0000-0000032821BA
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009636; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01080749; UDB=6.00557500; IPR=6.00860734;
 MB=3.00023002; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-29 22:54:12
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082922-0053-0000-0000-00005DE600FD
Message-Id: <20180829225405.7275-2-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-29_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808290223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rcu_gp_kthread() function is long and deeply indented, so this
commit pulls the loop that repeatedly invokes rcu_gp_fqs() into a new
rcu_gp_fqs_loop() function.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree.c | 125 ++++++++++++++++++++++++----------------------
 1 file changed, 66 insertions(+), 59 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 35a4346c7cce..bfb6b15bc27c 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1975,6 +1975,71 @@ static void rcu_gp_fqs(bool first_time)
 	}
 }
 
+/*
+ * Loop doing repeated quiescent-state forcing until the grace period ends.
+ */
+static void rcu_gp_fqs_loop(void)
+{
+	bool first_gp_fqs;
+	int gf;
+	unsigned long j;
+	int ret;
+	struct rcu_node *rnp = rcu_get_root();
+
+	first_gp_fqs = true;
+	j = jiffies_till_first_fqs;
+	ret = 0;
+	for (;;) {
+		if (!ret) {
+			rcu_state.jiffies_force_qs = jiffies + j;
+			WRITE_ONCE(rcu_state.jiffies_kick_kthreads,
+				   jiffies + 3 * j);
+		}
+		trace_rcu_grace_period(rcu_state.name,
+				       READ_ONCE(rcu_state.gp_seq),
+				       TPS("fqswait"));
+		rcu_state.gp_state = RCU_GP_WAIT_FQS;
+		ret = swait_event_idle_timeout_exclusive(
+				rcu_state.gp_wq, rcu_gp_fqs_check_wake(&gf), j);
+		rcu_state.gp_state = RCU_GP_DOING_FQS;
+		/* Locking provides needed memory barriers. */
+		/* If grace period done, leave loop. */
+		if (!READ_ONCE(rnp->qsmask) &&
+		    !rcu_preempt_blocked_readers_cgp(rnp))
+			break;
+		/* If time for quiescent-state forcing, do it. */
+		if (ULONG_CMP_GE(jiffies, rcu_state.jiffies_force_qs) ||
+		    (gf & RCU_GP_FLAG_FQS)) {
+			trace_rcu_grace_period(rcu_state.name,
+					       READ_ONCE(rcu_state.gp_seq),
+					       TPS("fqsstart"));
+			rcu_gp_fqs(first_gp_fqs);
+			first_gp_fqs = false;
+			trace_rcu_grace_period(rcu_state.name,
+					       READ_ONCE(rcu_state.gp_seq),
+					       TPS("fqsend"));
+			cond_resched_tasks_rcu_qs();
+			WRITE_ONCE(rcu_state.gp_activity, jiffies);
+			ret = 0; /* Force full wait till next FQS. */
+			j = jiffies_till_next_fqs;
+		} else {
+			/* Deal with stray signal. */
+			cond_resched_tasks_rcu_qs();
+			WRITE_ONCE(rcu_state.gp_activity, jiffies);
+			WARN_ON(signal_pending(current));
+			trace_rcu_grace_period(rcu_state.name,
+					       READ_ONCE(rcu_state.gp_seq),
+					       TPS("fqswaitsig"));
+			ret = 1; /* Keep old FQS timing. */
+			j = jiffies;
+			if (time_after(jiffies, rcu_state.jiffies_force_qs))
+				j = 1;
+			else
+				j = rcu_state.jiffies_force_qs - j;
+		}
+	}
+}
+
 /*
  * Clean up after the old grace period.
  */
@@ -2065,12 +2130,6 @@ static void rcu_gp_cleanup(void)
  */
 static int __noreturn rcu_gp_kthread(void *unused)
 {
-	bool first_gp_fqs;
-	int gf;
-	unsigned long j;
-	int ret;
-	struct rcu_node *rnp = rcu_get_root();
-
 	rcu_bind_gp_kthread();
 	for (;;) {
 
@@ -2096,59 +2155,7 @@ static int __noreturn rcu_gp_kthread(void *unused)
 		}
 
 		/* Handle quiescent-state forcing. */
-		first_gp_fqs = true;
-		j = jiffies_till_first_fqs;
-		ret = 0;
-		for (;;) {
-			if (!ret) {
-				rcu_state.jiffies_force_qs = jiffies + j;
-				WRITE_ONCE(rcu_state.jiffies_kick_kthreads,
-					   jiffies + 3 * j);
-			}
-			trace_rcu_grace_period(rcu_state.name,
-					       READ_ONCE(rcu_state.gp_seq),
-					       TPS("fqswait"));
-			rcu_state.gp_state = RCU_GP_WAIT_FQS;
-			ret = swait_event_idle_timeout_exclusive(rcu_state.gp_wq,
-					rcu_gp_fqs_check_wake(&gf), j);
-			rcu_state.gp_state = RCU_GP_DOING_FQS;
-			/* Locking provides needed memory barriers. */
-			/* If grace period done, leave loop. */
-			if (!READ_ONCE(rnp->qsmask) &&
-			    !rcu_preempt_blocked_readers_cgp(rnp))
-				break;
-			/* If time for quiescent-state forcing, do it. */
-			if (ULONG_CMP_GE(jiffies, rcu_state.jiffies_force_qs) ||
-			    (gf & RCU_GP_FLAG_FQS)) {
-				trace_rcu_grace_period(rcu_state.name,
-						       READ_ONCE(rcu_state.gp_seq),
-						       TPS("fqsstart"));
-				rcu_gp_fqs(first_gp_fqs);
-				first_gp_fqs = false;
-				trace_rcu_grace_period(rcu_state.name,
-						       READ_ONCE(rcu_state.gp_seq),
-						       TPS("fqsend"));
-				cond_resched_tasks_rcu_qs();
-				WRITE_ONCE(rcu_state.gp_activity, jiffies);
-				ret = 0; /* Force full wait till next FQS. */
-				j = jiffies_till_next_fqs;
-			} else {
-				/* Deal with stray signal. */
-				cond_resched_tasks_rcu_qs();
-				WRITE_ONCE(rcu_state.gp_activity, jiffies);
-				WARN_ON(signal_pending(current));
-				trace_rcu_grace_period(rcu_state.name,
-						       READ_ONCE(rcu_state.gp_seq),
-						       TPS("fqswaitsig"));
-				ret = 1; /* Keep old FQS timing. */
-				j = jiffies;
-				if (time_after(jiffies,
-					       rcu_state.jiffies_force_qs))
-					j = 1;
-				else
-					j = rcu_state.jiffies_force_qs - j;
-			}
-		}
+		rcu_gp_fqs_loop();
 
 		/* Handle grace-period end. */
 		rcu_state.gp_state = RCU_GP_CLEANUP;
-- 
2.17.1

