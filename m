Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27538C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDF8D2064E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:21:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDF8D2064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbeH3CUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 22:20:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36416 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727385AbeH3CTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 22:19:55 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7TMIlQe084358
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:20:56 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2m629duw3a-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:20:56 -0400
Received: from localhost
        by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 29 Aug 2018 18:20:56 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (9.57.198.27)
        by e14.ny.us.ibm.com (146.89.104.201) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 29 Aug 2018 18:20:50 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7TMKnIT20447440
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Aug 2018 22:20:49 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 50C5BB2078;
        Wed, 29 Aug 2018 18:19:45 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 27956B2074;
        Wed, 29 Aug 2018 18:19:45 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 29 Aug 2018 18:19:45 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 54EB216C91D5; Wed, 29 Aug 2018 15:20:49 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 14/19] rcu: Express Tiny RCU updates in terms of RCU rather than RCU-sched
Date:   Wed, 29 Aug 2018 15:20:42 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829222021.GA29944@linux.vnet.ibm.com>
References: <20180829222021.GA29944@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18082922-0052-0000-0000-000003281F38
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009636; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01080738; UDB=6.00557494; IPR=6.00860723;
 MB=3.00023001; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-29 22:20:54
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082922-0053-0000-0000-00005DE5F2E9
Message-Id: <20180829222047.319-14-paulmck@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-08-29_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1808290217
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit renames Tiny RCU functions so that the lowest level of
functionality is RCU (e.g., synchronize_rcu()) rather than RCU-sched
(e.g., synchronize_sched()).  This provides greater naming compatibility
with Tree RCU, which will in turn permit more LoC removal once
the RCU-sched and RCU-bh update-side API is removed.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
[ paulmck: Fix Tiny call_rcu()'s EXPORT_SYMBOL() in response to a bug
  report from kbuild test robot. ]
---
 include/linux/rcupdate.h | 12 +++++-----
 include/linux/rcutiny.h  | 34 +++++++++++++++-------------
 include/linux/rcutree.h  |  1 -
 kernel/rcu/tiny.c        | 48 ++++++++++++++++++++--------------------
 4 files changed, 48 insertions(+), 47 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 94474bb6b5c4..1207c6c9bd8b 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -49,15 +49,14 @@
 
 /* Exported common interfaces */
 
-#ifdef CONFIG_TINY_RCU
-#define	call_rcu	call_rcu_sched
-#else
-void call_rcu(struct rcu_head *head, rcu_callback_t func);
+#ifndef CONFIG_TINY_RCU
+void synchronize_sched(void);
+void call_rcu_sched(struct rcu_head *head, rcu_callback_t func);
 #endif
 
-void call_rcu_sched(struct rcu_head *head, rcu_callback_t func);
-void synchronize_sched(void);
+void call_rcu(struct rcu_head *head, rcu_callback_t func);
 void rcu_barrier_tasks(void);
+void synchronize_rcu(void);
 
 static inline void call_rcu_bh(struct rcu_head *head, rcu_callback_t func)
 {
@@ -68,7 +67,6 @@ static inline void call_rcu_bh(struct rcu_head *head, rcu_callback_t func)
 
 void __rcu_read_lock(void);
 void __rcu_read_unlock(void);
-void synchronize_rcu(void);
 
 /*
  * Defined as a macro as it is a very low level header included from
diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index df2c0895c5e7..e66fb8bc2127 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -36,9 +36,9 @@ static inline int rcu_dynticks_snap(struct rcu_dynticks *rdtp)
 /* Never flag non-existent other CPUs! */
 static inline bool rcu_eqs_special_set(int cpu) { return false; }
 
-static inline void synchronize_rcu(void)
+static inline void synchronize_sched(void)
 {
-	synchronize_sched();
+	synchronize_rcu();
 }
 
 static inline unsigned long get_state_synchronize_rcu(void)
@@ -61,16 +61,11 @@ static inline void cond_synchronize_sched(unsigned long oldstate)
 	might_sleep();
 }
 
-static inline void synchronize_rcu_expedited(void)
-{
-	synchronize_sched();	/* Only one CPU, so pretty fast anyway!!! */
-}
+extern void rcu_barrier(void);
 
-extern void rcu_barrier_sched(void);
-
-static inline void rcu_barrier(void)
+static inline void rcu_barrier_sched(void)
 {
-	rcu_barrier_sched();  /* Only one CPU, so only one list of callbacks! */
+	rcu_barrier();  /* Only one CPU, so only one list of callbacks! */
 }
 
 static inline void rcu_barrier_bh(void)
@@ -88,27 +83,36 @@ static inline void synchronize_rcu_bh_expedited(void)
 	synchronize_sched();
 }
 
+static inline void synchronize_rcu_expedited(void)
+{
+	synchronize_sched();
+}
+
 static inline void synchronize_sched_expedited(void)
 {
 	synchronize_sched();
 }
 
-static inline void kfree_call_rcu(struct rcu_head *head,
-				  rcu_callback_t func)
+static inline void call_rcu_sched(struct rcu_head *head, rcu_callback_t func)
+{
+	call_rcu(head, func);
+}
+
+static inline void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 {
 	call_rcu(head, func);
 }
 
-void rcu_sched_qs(void);
+void rcu_qs(void);
 
 static inline void rcu_softirq_qs(void)
 {
-	rcu_sched_qs();
+	rcu_qs();
 }
 
 #define rcu_note_context_switch(preempt) \
 	do { \
-		rcu_sched_qs(); \
+		rcu_qs(); \
 		rcu_tasks_qs(current); \
 	} while (0)
 
diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index 0c44720f0e84..6d30a0809300 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -45,7 +45,6 @@ static inline void rcu_virt_note_context_switch(int cpu)
 	rcu_note_context_switch(false);
 }
 
-void synchronize_rcu(void);
 static inline void synchronize_rcu_bh(void)
 {
 	synchronize_rcu();
diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
index cadcf63c4889..30826fb6e438 100644
--- a/kernel/rcu/tiny.c
+++ b/kernel/rcu/tiny.c
@@ -46,25 +46,25 @@ struct rcu_ctrlblk {
 };
 
 /* Definition for rcupdate control block. */
-static struct rcu_ctrlblk rcu_sched_ctrlblk = {
-	.donetail	= &rcu_sched_ctrlblk.rcucblist,
-	.curtail	= &rcu_sched_ctrlblk.rcucblist,
+static struct rcu_ctrlblk rcu_ctrlblk = {
+	.donetail	= &rcu_ctrlblk.rcucblist,
+	.curtail	= &rcu_ctrlblk.rcucblist,
 };
 
-void rcu_barrier_sched(void)
+void rcu_barrier(void)
 {
-	wait_rcu_gp(call_rcu_sched);
+	wait_rcu_gp(call_rcu);
 }
-EXPORT_SYMBOL(rcu_barrier_sched);
+EXPORT_SYMBOL(rcu_barrier);
 
 /* Record an rcu quiescent state.  */
-void rcu_sched_qs(void)
+void rcu_qs(void)
 {
 	unsigned long flags;
 
 	local_irq_save(flags);
-	if (rcu_sched_ctrlblk.donetail != rcu_sched_ctrlblk.curtail) {
-		rcu_sched_ctrlblk.donetail = rcu_sched_ctrlblk.curtail;
+	if (rcu_ctrlblk.donetail != rcu_ctrlblk.curtail) {
+		rcu_ctrlblk.donetail = rcu_ctrlblk.curtail;
 		raise_softirq(RCU_SOFTIRQ);
 	}
 	local_irq_restore(flags);
@@ -79,7 +79,7 @@ void rcu_sched_qs(void)
 void rcu_check_callbacks(int user)
 {
 	if (user)
-		rcu_sched_qs();
+		rcu_qs();
 }
 
 /* Invoke the RCU callbacks whose grace period has elapsed.  */
@@ -90,17 +90,17 @@ static __latent_entropy void rcu_process_callbacks(struct softirq_action *unused
 
 	/* Move the ready-to-invoke callbacks to a local list. */
 	local_irq_save(flags);
-	if (rcu_sched_ctrlblk.donetail == &rcu_sched_ctrlblk.rcucblist) {
+	if (rcu_ctrlblk.donetail == &rcu_ctrlblk.rcucblist) {
 		/* No callbacks ready, so just leave. */
 		local_irq_restore(flags);
 		return;
 	}
-	list = rcu_sched_ctrlblk.rcucblist;
-	rcu_sched_ctrlblk.rcucblist = *rcu_sched_ctrlblk.donetail;
-	*rcu_sched_ctrlblk.donetail = NULL;
-	if (rcu_sched_ctrlblk.curtail == rcu_sched_ctrlblk.donetail)
-		rcu_sched_ctrlblk.curtail = &rcu_sched_ctrlblk.rcucblist;
-	rcu_sched_ctrlblk.donetail = &rcu_sched_ctrlblk.rcucblist;
+	list = rcu_ctrlblk.rcucblist;
+	rcu_ctrlblk.rcucblist = *rcu_ctrlblk.donetail;
+	*rcu_ctrlblk.donetail = NULL;
+	if (rcu_ctrlblk.curtail == rcu_ctrlblk.donetail)
+		rcu_ctrlblk.curtail = &rcu_ctrlblk.rcucblist;
+	rcu_ctrlblk.donetail = &rcu_ctrlblk.rcucblist;
 	local_irq_restore(flags);
 
 	/* Invoke the callbacks on the local list. */
@@ -125,21 +125,21 @@ static __latent_entropy void rcu_process_callbacks(struct softirq_action *unused
  *
  * Cool, huh?  (Due to Josh Triplett.)
  */
-void synchronize_sched(void)
+void synchronize_rcu(void)
 {
 	RCU_LOCKDEP_WARN(lock_is_held(&rcu_bh_lock_map) ||
 			 lock_is_held(&rcu_lock_map) ||
 			 lock_is_held(&rcu_sched_lock_map),
 			 "Illegal synchronize_sched() in RCU read-side critical section");
 }
-EXPORT_SYMBOL_GPL(synchronize_sched);
+EXPORT_SYMBOL_GPL(synchronize_rcu);
 
 /*
  * Post an RCU callback to be invoked after the end of an RCU-sched grace
  * period.  But since we have but one CPU, that would be after any
  * quiescent state.
  */
-void call_rcu_sched(struct rcu_head *head, rcu_callback_t func)
+void call_rcu(struct rcu_head *head, rcu_callback_t func)
 {
 	unsigned long flags;
 
@@ -148,16 +148,16 @@ void call_rcu_sched(struct rcu_head *head, rcu_callback_t func)
 	head->next = NULL;
 
 	local_irq_save(flags);
-	*rcu_sched_ctrlblk.curtail = head;
-	rcu_sched_ctrlblk.curtail = &head->next;
+	*rcu_ctrlblk.curtail = head;
+	rcu_ctrlblk.curtail = &head->next;
 	local_irq_restore(flags);
 
 	if (unlikely(is_idle_task(current))) {
-		/* force scheduling for rcu_sched_qs() */
+		/* force scheduling for rcu_qs() */
 		resched_cpu(0);
 	}
 }
-EXPORT_SYMBOL_GPL(call_rcu_sched);
+EXPORT_SYMBOL_GPL(call_rcu);
 
 void __init rcu_init(void)
 {
-- 
2.17.1

