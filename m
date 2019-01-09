Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F2FC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B512A206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbfAIVTG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 16:19:06 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42162 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726659AbfAIVTB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 16:19:01 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x09LIhr3094008
        for <linux-kernel@vger.kernel.org>; Wed, 9 Jan 2019 16:19:00 -0500
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pwq4rme31-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 16:18:59 -0500
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 9 Jan 2019 21:18:58 -0000
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 9 Jan 2019 21:18:54 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x09LIreT24969284
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Jan 2019 21:18:53 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 19B69B2066;
        Wed,  9 Jan 2019 21:18:53 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DC503B206A;
        Wed,  9 Jan 2019 21:18:52 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.88])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  9 Jan 2019 21:18:52 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 6CDDF16C6416; Wed,  9 Jan 2019 13:18:52 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 09/12] rcu: Consolidate PREEMPT and !PREEMPT synchronize_rcu_expedited()
Date:   Wed,  9 Jan 2019 13:18:47 -0800
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190109211830.GA30595@linux.ibm.com>
References: <20190109211830.GA30595@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19010921-2213-0000-0000-000003399520
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010374; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000274; SDB=6.01144142; UDB=6.00595706; IPR=6.00924404;
 MB=3.00025056; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-09 21:18:58
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010921-2214-0000-0000-00005CE7F0F4
Message-Id: <20190109211850.31599-9-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-09_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=828 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901090170
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CONFIG_PREEMPT=n and CONFIG_PREEMPT=y implementations of
synchronize_rcu_expedited() are quite similar, and with small
modifications to rcu_blocking_is_gp() can be made identical.  This commit
therefore makes this change in order to save a few lines of code and to
reduce the amount of duplicate code.

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 kernel/rcu/tree_exp.h | 105 ++++++++++++++++++++----------------------
 1 file changed, 49 insertions(+), 56 deletions(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 7f5cb4228b59..b800bdfe74b3 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -643,6 +643,33 @@ static void _synchronize_rcu_expedited(void)
 	mutex_unlock(&rcu_state.exp_mutex);
 }
 
+/*
+ * During early boot, any blocking grace-period wait automatically
+ * implies a grace period.  Later on, this is never the case for PREEMPT.
+ *
+ * Howevr, because a context switch is a grace period for !PREEMPT, any
+ * blocking grace-period wait automatically implies a grace period if
+ * there is only one CPU online at any point time during execution of
+ * either synchronize_rcu() or synchronize_rcu_expedited().  It is OK to
+ * occasionally incorrectly indicate that there are multiple CPUs online
+ * when there was in fact only one the whole time, as this just adds some
+ * overhead: RCU still operates correctly.
+ */
+static int rcu_blocking_is_gp(void)
+{
+	int ret;
+
+	if (rcu_scheduler_active == RCU_SCHEDULER_INACTIVE)
+		return true;
+	if (IS_ENABLED(CONFIG_PREEMPT))
+		return false;
+	might_sleep();  /* Check for RCU read-side critical section. */
+	preempt_disable();
+	ret = num_online_cpus() <= 1;
+	preempt_enable();
+	return ret;
+}
+
 #ifdef CONFIG_PREEMPT_RCU
 
 /*
@@ -729,39 +756,6 @@ static void sync_sched_exp_online_cleanup(int cpu)
 {
 }
 
-/**
- * synchronize_rcu_expedited - Brute-force RCU grace period
- *
- * Wait for an RCU-preempt grace period, but expedite it.  The basic
- * idea is to IPI all non-idle non-nohz online CPUs.  The IPI handler
- * checks whether the CPU is in an RCU-preempt critical section, and
- * if so, it sets a flag that causes the outermost rcu_read_unlock()
- * to report the quiescent state.  On the other hand, if the CPU is
- * not in an RCU read-side critical section, the IPI handler reports
- * the quiescent state immediately.
- *
- * Although this is a greate improvement over previous expedited
- * implementations, it is still unfriendly to real-time workloads, so is
- * thus not recommended for any sort of common-case code.  In fact, if
- * you are using synchronize_rcu_expedited() in a loop, please restructure
- * your code to batch your updates, and then Use a single synchronize_rcu()
- * instead.
- *
- * This has the same semantics as (but is more brutal than) synchronize_rcu().
- */
-void synchronize_rcu_expedited(void)
-{
-	RCU_LOCKDEP_WARN(lock_is_held(&rcu_bh_lock_map) ||
-			 lock_is_held(&rcu_lock_map) ||
-			 lock_is_held(&rcu_sched_lock_map),
-			 "Illegal synchronize_rcu_expedited() in RCU read-side critical section");
-
-	if (rcu_scheduler_active == RCU_SCHEDULER_INACTIVE)
-		return;
-	_synchronize_rcu_expedited();
-}
-EXPORT_SYMBOL_GPL(synchronize_rcu_expedited);
-
 #else /* #ifdef CONFIG_PREEMPT_RCU */
 
 /* Invoked on each online non-idle CPU for expedited quiescent state. */
@@ -801,27 +795,28 @@ static void sync_sched_exp_online_cleanup(int cpu)
 	WARN_ON_ONCE(ret);
 }
 
-/*
- * Because a context switch is a grace period for !PREEMPT, any
- * blocking grace-period wait automatically implies a grace period if
- * there is only one CPU online at any point time during execution of
- * either synchronize_rcu() or synchronize_rcu_expedited().  It is OK to
- * occasionally incorrectly indicate that there are multiple CPUs online
- * when there was in fact only one the whole time, as this just adds some
- * overhead: RCU still operates correctly.
- */
-static int rcu_blocking_is_gp(void)
-{
-	int ret;
-
-	might_sleep();  /* Check for RCU read-side critical section. */
-	preempt_disable();
-	ret = num_online_cpus() <= 1;
-	preempt_enable();
-	return ret;
-}
+#endif /* #else #ifdef CONFIG_PREEMPT_RCU */
 
-/* PREEMPT=n implementation of synchronize_rcu_expedited(). */
+/**
+ * synchronize_rcu_expedited - Brute-force RCU grace period
+ *
+ * Wait for an RCU grace period, but expedite it.  The basic idea is to
+ * IPI all non-idle non-nohz online CPUs.  The IPI handler checks whether
+ * the CPU is in an RCU critical section, and if so, it sets a flag that
+ * causes the outermost rcu_read_unlock() to report the quiescent state
+ * for RCU-preempt or asks the scheduler for help for RCU-sched.  On the
+ * other hand, if the CPU is not in an RCU read-side critical section,
+ * the IPI handler reports the quiescent state immediately.
+ *
+ * Although this is a greate improvement over previous expedited
+ * implementations, it is still unfriendly to real-time workloads, so is
+ * thus not recommended for any sort of common-case code.  In fact, if
+ * you are using synchronize_rcu_expedited() in a loop, please restructure
+ * your code to batch your updates, and then Use a single synchronize_rcu()
+ * instead.
+ *
+ * This has the same semantics as (but is more brutal than) synchronize_rcu().
+ */
 void synchronize_rcu_expedited(void)
 {
 	RCU_LOCKDEP_WARN(lock_is_held(&rcu_bh_lock_map) ||
@@ -829,12 +824,10 @@ void synchronize_rcu_expedited(void)
 			 lock_is_held(&rcu_sched_lock_map),
 			 "Illegal synchronize_rcu_expedited() in RCU read-side critical section");
 
-	/* If only one CPU, this is automatically a grace period. */
+	/* Is the state is such that the call is a grace period? */
 	if (rcu_blocking_is_gp())
 		return;
 
 	_synchronize_rcu_expedited();
 }
 EXPORT_SYMBOL_GPL(synchronize_rcu_expedited);
-
-#endif /* #else #ifdef CONFIG_PREEMPT_RCU */
-- 
2.17.1

