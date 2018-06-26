Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 201D9C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:51:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C26572638B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 00:51:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C26572638B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965117AbeFZAvy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 20:51:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43270 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S934808AbeFZAuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 20:50:32 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5Q0n1OV091007
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 20:50:31 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2ju96qks61-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 20:50:31 -0400
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Mon, 25 Jun 2018 20:50:31 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (9.57.198.28)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Jun 2018 20:50:25 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5Q0oO2K9503202
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Jun 2018 00:50:24 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6155AB2065;
        Mon, 25 Jun 2018 20:50:19 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3710BB2070;
        Mon, 25 Jun 2018 20:50:19 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 25 Jun 2018 20:50:19 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 7850B16CA09F; Mon, 25 Jun 2018 17:52:29 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 12/13] rcutorture: Add support to detect if boost kthread prio is too low
Date:   Mon, 25 Jun 2018 17:52:26 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180626005205.GA28179@linux.vnet.ibm.com>
References: <20180626005205.GA28179@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18062600-0040-0000-0000-00000445293D
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009255; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01052342; UDB=6.00539473; IPR=6.00830268;
 MB=3.00021856; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-26 00:50:29
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062600-0041-0000-0000-0000084B3F02
Message-Id: <20180626005227.30660-12-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-25_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806260008
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

When rcutorture is built in to the kernel, an earlier patch detects
that and raises the priority of RCU's kthreads to allow rcutorture's
RCU priority boosting tests to succeed.

However, if rcutorture is built as a module, those priorities must be
raised manually via the rcutree.kthread_prio kernel boot parameter.
If this manual step is not taken, rcutorture's RCU priority boosting
tests will fail due to kthread starvation.  One approach would be to
raise the default priority, but that risks breaking existing users.
Another approach would be to allow runtime adjustment of RCU's kthread
priorities, but that introduces numerous "interesting" race conditions.
This patch therefore instead detects too-low priorities, and prints a
message and disables the RCU priority boosting tests in that case.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/rcu.h        |  2 ++
 kernel/rcu/rcutorture.c | 32 ++++++++++++++++++++++++++++----
 kernel/rcu/tree.c       |  7 +++++++
 3 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 0453a7d12b3f..bee070979970 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -502,6 +502,7 @@ static inline void rcu_force_quiescent_state(void) { }
 static inline void rcu_bh_force_quiescent_state(void) { }
 static inline void rcu_sched_force_quiescent_state(void) { }
 static inline void show_rcu_gp_kthreads(void) { }
+static inline int rcu_get_gp_kthreads_prio(void) { return 0; }
 #else /* #ifdef CONFIG_TINY_RCU */
 unsigned long rcu_get_gp_seq(void);
 unsigned long rcu_bh_get_gp_seq(void);
@@ -510,6 +511,7 @@ unsigned long rcu_exp_batches_completed(void);
 unsigned long rcu_exp_batches_completed_sched(void);
 unsigned long srcu_batches_completed(struct srcu_struct *sp);
 void show_rcu_gp_kthreads(void);
+int rcu_get_gp_kthreads_prio(void);
 void rcu_force_quiescent_state(void);
 void rcu_bh_force_quiescent_state(void);
 void rcu_sched_force_quiescent_state(void);
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 049b3735dba8..e3d2d4f1d928 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1787,6 +1787,32 @@ static void rcu_torture_barrier_cleanup(void)
 	}
 }
 
+static bool rcu_torture_can_boost(void)
+{
+	static int boost_warn_once;
+	int prio;
+
+	if (!(test_boost == 1 && cur_ops->can_boost) && test_boost != 2)
+		return false;
+
+	prio = rcu_get_gp_kthreads_prio();
+	if (!prio)
+		return false;
+
+	if (prio < 2) {
+		if (boost_warn_once  == 1)
+			return false;
+
+		pr_alert("%s: WARN: RCU kthread priority too low to test boosting. "
+			 "Skipping RCU boost test. Try passing rcutree.kthread_prio > 1 "
+			 "on the kernel command line.\n", KBUILD_MODNAME);
+		boost_warn_once = 1;
+		return false;
+	}
+
+	return true;
+}
+
 static enum cpuhp_state rcutor_hp;
 
 static void
@@ -1831,8 +1857,7 @@ rcu_torture_cleanup(void)
 	torture_stop_kthread(rcu_torture_fqs, fqs_task);
 	for (i = 0; i < ncbflooders; i++)
 		torture_stop_kthread(rcu_torture_cbflood, cbflood_task[i]);
-	if ((test_boost == 1 && cur_ops->can_boost) ||
-	    test_boost == 2)
+	if (rcu_torture_can_boost())
 		cpuhp_remove_state(rcutor_hp);
 
 	/*
@@ -2056,8 +2081,7 @@ rcu_torture_init(void)
 		test_boost_interval = 1;
 	if (test_boost_duration < 2)
 		test_boost_duration = 2;
-	if ((test_boost == 1 && cur_ops->can_boost) ||
-	    test_boost == 2) {
+	if (rcu_torture_can_boost()) {
 
 		boost_starttime = jiffies + test_boost_interval * HZ;
 
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 21878aada657..a24735cc97d9 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -180,6 +180,13 @@ module_param(gp_init_delay, int, 0444);
 static int gp_cleanup_delay;
 module_param(gp_cleanup_delay, int, 0444);
 
+/* Retreive RCU kthreads priority for rcutorture */
+int rcu_get_gp_kthreads_prio(void)
+{
+	return kthread_prio;
+}
+EXPORT_SYMBOL_GPL(rcu_get_gp_kthreads_prio);
+
 /*
  * Number of grace periods between delays, normalized by the duration of
  * the delay.  The longer the delay, the more the grace periods between
-- 
2.17.1

