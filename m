Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD7EC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B6F2206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:19:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbfAIVTW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 16:19:22 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44666 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727083AbfAIVTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 16:19:15 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id x09LJBhf089805
        for <linux-kernel@vger.kernel.org>; Wed, 9 Jan 2019 16:19:13 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pwnf7s1hq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 16:19:11 -0500
Received: from localhost
        by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 9 Jan 2019 21:18:58 -0000
Received: from b01cxnp22033.gho.pok.ibm.com (9.57.198.23)
        by e15.ny.us.ibm.com (146.89.104.202) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 9 Jan 2019 21:18:54 -0000
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x09LIrUW17694966
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Jan 2019 21:18:53 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 19B89B2067;
        Wed,  9 Jan 2019 21:18:53 +0000 (GMT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DDB50B2070;
        Wed,  9 Jan 2019 21:18:52 +0000 (GMT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.88])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed,  9 Jan 2019 21:18:52 +0000 (GMT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 73F8516C6419; Wed,  9 Jan 2019 13:18:52 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.ibm.com>
Subject: [PATCH tip/core/rcu 10/12] rcu: Consolidate PREEMPT and !PREEMPT synchronize_rcu()
Date:   Wed,  9 Jan 2019 13:18:48 -0800
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190109211830.GA30595@linux.ibm.com>
References: <20190109211830.GA30595@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19010921-0068-0000-0000-000003800517
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00010374; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000274; SDB=6.01144142; UDB=6.00595706; IPR=6.00924404;
 MB=3.00025056; MTD=3.00000008; XFM=3.00000015; UTC=2019-01-09 21:18:58
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19010921-0069-0000-0000-000047121E1D
Message-Id: <20190109211850.31599-10-paulmck@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-09_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=943 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901090170
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that rcu_blocking_is_gp() makes the correct immediate-return
decision for both PREEMPT and !PREEMPT, a single implementation of
synchronize_rcu() will work correctly under both configurations.
This commit therefore eliminates a few lines of code by consolidating
the two implementations of synchronize_rcu().

Signed-off-by: Paul E. McKenney <paulmck@linux.ibm.com>
---
 kernel/rcu/tree.c        | 73 ++++++++++++++++++++++++++++++++++++++++
 kernel/rcu/tree_exp.h    | 27 ---------------
 kernel/rcu/tree_plugin.h | 64 -----------------------------------
 3 files changed, 73 insertions(+), 91 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index fc37bec32731..e2bd42b2b563 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2950,6 +2950,79 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 }
 EXPORT_SYMBOL_GPL(kfree_call_rcu);
 
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
+	if (IS_ENABLED(CONFIG_PREEMPT))
+		return rcu_scheduler_active == RCU_SCHEDULER_INACTIVE;
+	might_sleep();  /* Check for RCU read-side critical section. */
+	preempt_disable();
+	ret = num_online_cpus() <= 1;
+	preempt_enable();
+	return ret;
+}
+
+/**
+ * synchronize_rcu - wait until a grace period has elapsed.
+ *
+ * Control will return to the caller some time after a full grace
+ * period has elapsed, in other words after all currently executing RCU
+ * read-side critical sections have completed.  Note, however, that
+ * upon return from synchronize_rcu(), the caller might well be executing
+ * concurrently with new RCU read-side critical sections that began while
+ * synchronize_rcu() was waiting.  RCU read-side critical sections are
+ * delimited by rcu_read_lock() and rcu_read_unlock(), and may be nested.
+ * In addition, regions of code across which interrupts, preemption, or
+ * softirqs have been disabled also serve as RCU read-side critical
+ * sections.  This includes hardware interrupt handlers, softirq handlers,
+ * and NMI handlers.
+ *
+ * Note that this guarantee implies further memory-ordering guarantees.
+ * On systems with more than one CPU, when synchronize_rcu() returns,
+ * each CPU is guaranteed to have executed a full memory barrier since
+ * the end of its last RCU read-side critical section whose beginning
+ * preceded the call to synchronize_rcu().  In addition, each CPU having
+ * an RCU read-side critical section that extends beyond the return from
+ * synchronize_rcu() is guaranteed to have executed a full memory barrier
+ * after the beginning of synchronize_rcu() and before the beginning of
+ * that RCU read-side critical section.  Note that these guarantees include
+ * CPUs that are offline, idle, or executing in user mode, as well as CPUs
+ * that are executing in the kernel.
+ *
+ * Furthermore, if CPU A invoked synchronize_rcu(), which returned
+ * to its caller on CPU B, then both CPU A and CPU B are guaranteed
+ * to have executed a full memory barrier during the execution of
+ * synchronize_rcu() -- even if CPU A and CPU B are the same CPU (but
+ * again only if the system has more than one CPU).
+ */
+void synchronize_rcu(void)
+{
+	RCU_LOCKDEP_WARN(lock_is_held(&rcu_bh_lock_map) ||
+			 lock_is_held(&rcu_lock_map) ||
+			 lock_is_held(&rcu_sched_lock_map),
+			 "Illegal synchronize_rcu() in RCU read-side critical section");
+	if (rcu_blocking_is_gp())
+		return;
+	if (rcu_gp_is_expedited())
+		synchronize_rcu_expedited();
+	else
+		wait_rcu_gp(call_rcu);
+}
+EXPORT_SYMBOL_GPL(synchronize_rcu);
+
 /**
  * get_state_synchronize_rcu - Snapshot current RCU state
  *
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index b800bdfe74b3..353d113c0cd4 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -643,33 +643,6 @@ static void _synchronize_rcu_expedited(void)
 	mutex_unlock(&rcu_state.exp_mutex);
 }
 
-/*
- * During early boot, any blocking grace-period wait automatically
- * implies a grace period.  Later on, this is never the case for PREEMPT.
- *
- * Howevr, because a context switch is a grace period for !PREEMPT, any
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
-	if (rcu_scheduler_active == RCU_SCHEDULER_INACTIVE)
-		return true;
-	if (IS_ENABLED(CONFIG_PREEMPT))
-		return false;
-	might_sleep();  /* Check for RCU read-side critical section. */
-	preempt_disable();
-	ret = num_online_cpus() <= 1;
-	preempt_enable();
-	return ret;
-}
-
 #ifdef CONFIG_PREEMPT_RCU
 
 /*
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index bcf3e7366a28..43f3f2ee9d63 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -825,54 +825,6 @@ static void rcu_flavor_check_callbacks(int user)
 		t->rcu_read_unlock_special.b.need_qs = true;
 }
 
-/**
- * synchronize_rcu - wait until a grace period has elapsed.
- *
- * Control will return to the caller some time after a full grace
- * period has elapsed, in other words after all currently executing RCU
- * read-side critical sections have completed.  Note, however, that
- * upon return from synchronize_rcu(), the caller might well be executing
- * concurrently with new RCU read-side critical sections that began while
- * synchronize_rcu() was waiting.  RCU read-side critical sections are
- * delimited by rcu_read_lock() and rcu_read_unlock(), and may be nested.
- * In addition, regions of code across which interrupts, preemption, or
- * softirqs have been disabled also serve as RCU read-side critical
- * sections.  This includes hardware interrupt handlers, softirq handlers,
- * and NMI handlers.
- *
- * Note that this guarantee implies further memory-ordering guarantees.
- * On systems with more than one CPU, when synchronize_rcu() returns,
- * each CPU is guaranteed to have executed a full memory barrier since
- * the end of its last RCU read-side critical section whose beginning
- * preceded the call to synchronize_rcu().  In addition, each CPU having
- * an RCU read-side critical section that extends beyond the return from
- * synchronize_rcu() is guaranteed to have executed a full memory barrier
- * after the beginning of synchronize_rcu() and before the beginning of
- * that RCU read-side critical section.  Note that these guarantees include
- * CPUs that are offline, idle, or executing in user mode, as well as CPUs
- * that are executing in the kernel.
- *
- * Furthermore, if CPU A invoked synchronize_rcu(), which returned
- * to its caller on CPU B, then both CPU A and CPU B are guaranteed
- * to have executed a full memory barrier during the execution of
- * synchronize_rcu() -- even if CPU A and CPU B are the same CPU (but
- * again only if the system has more than one CPU).
- */
-void synchronize_rcu(void)
-{
-	RCU_LOCKDEP_WARN(lock_is_held(&rcu_bh_lock_map) ||
-			 lock_is_held(&rcu_lock_map) ||
-			 lock_is_held(&rcu_sched_lock_map),
-			 "Illegal synchronize_rcu() in RCU read-side critical section");
-	if (rcu_scheduler_active == RCU_SCHEDULER_INACTIVE)
-		return;
-	if (rcu_gp_is_expedited())
-		synchronize_rcu_expedited();
-	else
-		wait_rcu_gp(call_rcu);
-}
-EXPORT_SYMBOL_GPL(synchronize_rcu);
-
 /*
  * Check for a task exiting while in a preemptible-RCU read-side
  * critical section, clean up if so.  No need to issue warnings,
@@ -1115,22 +1067,6 @@ static void rcu_flavor_check_callbacks(int user)
 	}
 }
 
-/* PREEMPT=n implementation of synchronize_rcu(). */
-void synchronize_rcu(void)
-{
-	RCU_LOCKDEP_WARN(lock_is_held(&rcu_bh_lock_map) ||
-			 lock_is_held(&rcu_lock_map) ||
-			 lock_is_held(&rcu_sched_lock_map),
-			 "Illegal synchronize_rcu() in RCU read-side critical section");
-	if (rcu_blocking_is_gp())
-		return;
-	if (rcu_gp_is_expedited())
-		synchronize_rcu_expedited();
-	else
-		wait_rcu_gp(call_rcu);
-}
-EXPORT_SYMBOL_GPL(synchronize_rcu);
-
 /*
  * Because preemptible RCU does not exist, tasks cannot possibly exit
  * while in preemptible RCU read-side critical sections.
-- 
2.17.1

