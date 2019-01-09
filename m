Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9455BC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6081A20685
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:29:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbfAIV2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 16:28:46 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40170 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725681AbfAIV2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 16:28:43 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x09LSaC1139638
        for <linux-kernel@vger.kernel.org>; Wed, 9 Jan 2019 16:28:42 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2pwnq7gk0g-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 16:28:41 -0500
Received: from localhost
        by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 9 Jan 2019 21:28:41 -0000
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e17.ny.us.ibm.com (146.89.104.204) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 9 Jan 2019 21:28:36 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x09LSZEA22609948
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Jan 2019 21:28:35 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9E66BB2065;
        Wed,  9 Jan 2019 21:28:35 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 87C81B2068;
        Wed,  9 Jan 2019 21:28:35 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.88])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  9 Jan 2019 21:28:35 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 5B3CC16C63E4; Wed,  9 Jan 2019 13:28:35 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 02/12] rcu: Move rcu_cpu_kthread_task to rcu_data structure
Date:   Wed,  9 Jan 2019 13:28:24 -0800
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190109212816.GA32282@linux.ibm.com>
References: <20190109212816.GA32282@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19010921-0040-0000-0000-000004AF3680
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010375; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000274; SDB=6.01144145; UDB=6.00593882; IPR=6.00924407;
 MB=3.00025056; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-09 21:28:40
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010921-0041-0000-0000-000008BA3B0B
Message-Id: <20190109212834.1257-2-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-09_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901090171
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Given that RCU has a perfectly good per-CPU rcu_data structure, most
per-CPU quantities should be stored there.

This commit therefore moves the rcu_cpu_kthread_task per-CPU variable to
the rcu_data structure.  This also makes this variable unconditionally
present, which should be acceptable given the memory reduction due to the
RCU flavor consolidation and also due to simplifications this will enable.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 kernel/rcu/tree.h        |  6 +++++-
 kernel/rcu/tree_plugin.h | 11 +++++------
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index d90b02b53c0e..ef517ba25192 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -234,7 +234,11 @@ struct rcu_data {
 					/* Leader CPU takes GP-end wakeups. */
 #endif /* #ifdef CONFIG_RCU_NOCB_CPU */
 
-	/* 6) Diagnostic data, including RCU CPU stall warnings. */
+	/* 6) RCU priority boosting. */
+	struct task_struct *rcu_cpu_kthread_task;
+					/* rcuc per-CPU kthread or NULL. */
+
+	/* 7) Diagnostic data, including RCU CPU stall warnings. */
 	unsigned int softirq_snap;	/* Snapshot of softirq activity. */
 	/* ->rcu_iw* fields protected by leaf rcu_node ->lock. */
 	struct irq_work rcu_iw;		/* Check for non-irq activity. */
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 1b3dd2fc0cd6..359bf1f6f8e0 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -40,7 +40,6 @@
 /*
  * Control variables for per-CPU and per-rcu_node kthreads.
  */
-static DEFINE_PER_CPU(struct task_struct *, rcu_cpu_kthread_task);
 DEFINE_PER_CPU(unsigned int, rcu_cpu_kthread_status);
 DEFINE_PER_CPU(unsigned int, rcu_cpu_kthread_loops);
 DEFINE_PER_CPU(char, rcu_cpu_has_work);
@@ -1308,9 +1307,9 @@ static void invoke_rcu_callbacks_kthread(void)
 
 	local_irq_save(flags);
 	__this_cpu_write(rcu_cpu_has_work, 1);
-	if (__this_cpu_read(rcu_cpu_kthread_task) != NULL &&
-	    current != __this_cpu_read(rcu_cpu_kthread_task)) {
-		rcu_wake_cond(__this_cpu_read(rcu_cpu_kthread_task),
+	if (__this_cpu_read(rcu_data.rcu_cpu_kthread_task) != NULL &&
+	    current != __this_cpu_read(rcu_data.rcu_cpu_kthread_task)) {
+		rcu_wake_cond(__this_cpu_read(rcu_data.rcu_cpu_kthread_task),
 			      __this_cpu_read(rcu_cpu_kthread_status));
 	}
 	local_irq_restore(flags);
@@ -1322,7 +1321,7 @@ static void invoke_rcu_callbacks_kthread(void)
  */
 static bool rcu_is_callbacks_kthread(void)
 {
-	return __this_cpu_read(rcu_cpu_kthread_task) == current;
+	return __this_cpu_read(rcu_data.rcu_cpu_kthread_task) == current;
 }
 
 #define RCU_BOOST_DELAY_JIFFIES DIV_ROUND_UP(CONFIG_RCU_BOOST_DELAY * HZ, 1000)
@@ -1459,7 +1458,7 @@ static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp, int outgoingcpu)
 }
 
 static struct smp_hotplug_thread rcu_cpu_thread_spec = {
-	.store			= &rcu_cpu_kthread_task,
+	.store			= &rcu_data.rcu_cpu_kthread_task,
 	.thread_should_run	= rcu_cpu_kthread_should_run,
 	.thread_fn		= rcu_cpu_kthread,
 	.thread_comm		= "rcuc/%u",
-- 
2.17.1

