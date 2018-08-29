Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 945B9C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3655A20647
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:54:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3655A20647
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbeH3Cx0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 22:53:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51064 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727578AbeH3CxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 22:53:23 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7TMsCZL000695
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:54:15 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2m60r18mr0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:54:14 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 29 Aug 2018 18:54:13 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 29 Aug 2018 18:54:08 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7TMs7SQ28115106
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Aug 2018 22:54:07 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1E7E7B2065;
        Wed, 29 Aug 2018 18:53:03 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D4C7DB2068;
        Wed, 29 Aug 2018 18:53:02 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 29 Aug 2018 18:53:02 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 5ED3416C91C7; Wed, 29 Aug 2018 15:54:07 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 04/24] rcu: Consolidate RCU-sched update-side function definitions
Date:   Wed, 29 Aug 2018 15:53:45 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829225340.GA7019@linux.vnet.ibm.com>
References: <20180829225340.GA7019@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18082922-0072-0000-0000-0000039969A6
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009636; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01080749; UDB=6.00557500; IPR=6.00860734;
 MB=3.00023002; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-29 22:54:11
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082922-0073-0000-0000-0000493EB97C
Message-Id: <20180829225405.7275-4-paulmck@linux.vnet.ibm.com>
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

This commit saves a few lines by consolidating the RCU-sched function
definitions at the end of include/linux/rcupdate.h.  This consolidation
also makes it easier to remove them all when the time comes.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 include/linux/rcupdate.h | 38 +++++++++++++++++++++-----
 include/linux/rcutiny.h  | 32 +---------------------
 include/linux/rcutree.h  |  9 -------
 kernel/rcu/tree.c        | 58 ----------------------------------------
 4 files changed, 32 insertions(+), 105 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index e530f5739033..12103e1bbe67 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -48,12 +48,6 @@
 #define ulong2long(a)		(*(long *)(&(a)))
 
 /* Exported common interfaces */
-
-#ifndef CONFIG_TINY_RCU
-void synchronize_sched(void);
-void call_rcu_sched(struct rcu_head *head, rcu_callback_t func);
-#endif
-
 void call_rcu(struct rcu_head *head, rcu_callback_t func);
 void rcu_barrier_tasks(void);
 void synchronize_rcu(void);
@@ -170,7 +164,7 @@ void exit_tasks_rcu_finish(void);
 #define rcu_tasks_qs(t)	do { } while (0)
 #define rcu_note_voluntary_context_switch(t)		rcu_all_qs()
 #define call_rcu_tasks call_rcu_sched
-#define synchronize_rcu_tasks synchronize_sched
+#define synchronize_rcu_tasks synchronize_rcu
 static inline void exit_tasks_rcu_start(void) { }
 static inline void exit_tasks_rcu_finish(void) { }
 #endif /* #else #ifdef CONFIG_TASKS_RCU */
@@ -892,4 +886,34 @@ static inline void rcu_barrier_bh(void)
 	rcu_barrier();
 }
 
+static inline void synchronize_sched(void)
+{
+	synchronize_rcu();
+}
+
+static inline void synchronize_sched_expedited(void)
+{
+	synchronize_rcu_expedited();
+}
+
+static inline void call_rcu_sched(struct rcu_head *head, rcu_callback_t func)
+{
+	call_rcu(head, func);
+}
+
+static inline void rcu_barrier_sched(void)
+{
+	rcu_barrier();
+}
+
+static inline unsigned long get_state_synchronize_sched(void)
+{
+	return get_state_synchronize_rcu();
+}
+
+static inline void cond_synchronize_sched(unsigned long oldstate)
+{
+	cond_synchronize_rcu(oldstate);
+}
+
 #endif /* __LINUX_RCUPDATE_H */
diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index df82bada9b19..7fa4fb9e899e 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -36,11 +36,6 @@ static inline int rcu_dynticks_snap(struct rcu_dynticks *rdtp)
 /* Never flag non-existent other CPUs! */
 static inline bool rcu_eqs_special_set(int cpu) { return false; }
 
-static inline void synchronize_sched(void)
-{
-	synchronize_rcu();
-}
-
 static inline unsigned long get_state_synchronize_rcu(void)
 {
 	return 0;
@@ -51,36 +46,11 @@ static inline void cond_synchronize_rcu(unsigned long oldstate)
 	might_sleep();
 }
 
-static inline unsigned long get_state_synchronize_sched(void)
-{
-	return 0;
-}
-
-static inline void cond_synchronize_sched(unsigned long oldstate)
-{
-	might_sleep();
-}
-
 extern void rcu_barrier(void);
 
-static inline void rcu_barrier_sched(void)
-{
-	rcu_barrier();  /* Only one CPU, so only one list of callbacks! */
-}
-
 static inline void synchronize_rcu_expedited(void)
 {
-	synchronize_sched();
-}
-
-static inline void synchronize_sched_expedited(void)
-{
-	synchronize_sched();
-}
-
-static inline void call_rcu_sched(struct rcu_head *head, rcu_callback_t func)
-{
-	call_rcu(head, func);
+	synchronize_rcu();
 }
 
 static inline void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index 94820156aa62..d09a9abe9440 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -46,21 +46,12 @@ static inline void rcu_virt_note_context_switch(int cpu)
 }
 
 void synchronize_rcu_expedited(void);
-
-static inline void synchronize_sched_expedited(void)
-{
-	synchronize_rcu_expedited();
-}
-
 void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func);
 
 void rcu_barrier(void);
-void rcu_barrier_sched(void);
 bool rcu_eqs_special_set(int cpu);
 unsigned long get_state_synchronize_rcu(void);
 void cond_synchronize_rcu(unsigned long oldstate);
-unsigned long get_state_synchronize_sched(void);
-void cond_synchronize_sched(unsigned long oldstate);
 
 void rcu_idle_enter(void);
 void rcu_idle_exit(void);
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index f1e8a4431ebd..b2ebdd01c8a2 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2949,19 +2949,6 @@ void call_rcu(struct rcu_head *head, rcu_callback_t func)
 }
 EXPORT_SYMBOL_GPL(call_rcu);
 
-/**
- * call_rcu_sched() - Queue an RCU for invocation after sched grace period.
- * @head: structure to be used for queueing the RCU updates.
- * @func: actual callback function to be invoked after the grace period
- *
- * This is transitional.
- */
-void call_rcu_sched(struct rcu_head *head, rcu_callback_t func)
-{
-	call_rcu(head, func);
-}
-EXPORT_SYMBOL_GPL(call_rcu_sched);
-
 /*
  * Queue an RCU callback for lazy invocation after a grace period.
  * This will likely be later named something like "call_rcu_lazy()",
@@ -2975,17 +2962,6 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 }
 EXPORT_SYMBOL_GPL(kfree_call_rcu);
 
-/**
- * synchronize_sched - wait until an rcu-sched grace period has elapsed.
- *
- * This is transitional.
- */
-void synchronize_sched(void)
-{
-	synchronize_rcu();
-}
-EXPORT_SYMBOL_GPL(synchronize_sched);
-
 /**
  * get_state_synchronize_rcu - Snapshot current RCU state
  *
@@ -3027,29 +3003,6 @@ void cond_synchronize_rcu(unsigned long oldstate)
 }
 EXPORT_SYMBOL_GPL(cond_synchronize_rcu);
 
-/**
- * get_state_synchronize_sched - Snapshot current RCU-sched state
- *
- * This is transitional, and only used by rcutorture.
- */
-unsigned long get_state_synchronize_sched(void)
-{
-	return get_state_synchronize_rcu();
-}
-EXPORT_SYMBOL_GPL(get_state_synchronize_sched);
-
-/**
- * cond_synchronize_sched - Conditionally wait for an RCU-sched grace period
- * @oldstate: return value from earlier call to get_state_synchronize_sched()
- *
- * This is transitional and only used by rcutorture.
- */
-void cond_synchronize_sched(unsigned long oldstate)
-{
-	cond_synchronize_rcu(oldstate);
-}
-EXPORT_SYMBOL_GPL(cond_synchronize_sched);
-
 /*
  * Check to see if there is any immediate RCU-related work to be done by
  * the current CPU, for the specified type of RCU, returning 1 if so and
@@ -3265,17 +3218,6 @@ void rcu_barrier(void)
 }
 EXPORT_SYMBOL_GPL(rcu_barrier);
 
-/**
- * rcu_barrier_sched - Wait for in-flight call_rcu_sched() callbacks.
- *
- * This is transitional.
- */
-void rcu_barrier_sched(void)
-{
-	rcu_barrier();
-}
-EXPORT_SYMBOL_GPL(rcu_barrier_sched);
-
 /*
  * Propagate ->qsinitmask bits up the rcu_node tree to account for the
  * first CPU in a given leaf rcu_node structure coming online.  The caller
-- 
2.17.1

