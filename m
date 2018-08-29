Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0905C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B86C20658
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 22:20:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B86C20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbeH3CTx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 22:19:53 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50800 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727104AbeH3CTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 22:19:53 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7TMIhVq094360
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:20:54 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2m627rc12r-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 18:20:54 -0400
Received: from localhost
        by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 29 Aug 2018 18:20:53 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e16.ny.us.ibm.com (146.89.104.203) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 29 Aug 2018 18:20:49 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w7TMKmr336831374
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Aug 2018 22:20:48 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B6D43B2073;
        Wed, 29 Aug 2018 18:19:44 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E17FB2065;
        Wed, 29 Aug 2018 18:19:44 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 29 Aug 2018 18:19:44 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 06A9716C91B7; Wed, 29 Aug 2018 15:20:49 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mingo@kernel.org, jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        Byungchul Park <byungchul.park@lge.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
Subject: [PATCH tip/core/rcu 01/19] rcu: Refactor rcu_{nmi,irq}_{enter,exit}()
Date:   Wed, 29 Aug 2018 15:20:29 -0700
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180829222021.GA29944@linux.vnet.ibm.com>
References: <20180829222021.GA29944@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 18082922-0072-0000-0000-000003996711
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009636; HX=3.00000242; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01080738; UDB=6.00557494; IPR=6.00860724;
 MB=3.00023001; MTD=3.00000008; XFM=3.00000015; UTC=2018-08-29 22:20:53
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18082922-0073-0000-0000-0000493EAB54
Message-Id: <20180829222047.319-1-paulmck@linux.vnet.ibm.com>
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

From: Byungchul Park <byungchul.park@lge.com>

When entering or exiting irq or NMI handlers, the current code uses
->dynticks_nmi_nesting to detect if it is in the outermost handler,
that is, the one interrupting or returning to an RCU-idle context (the
idle loop or nohz_full usermode execution).  When entering the outermost
handler via an interrupt (as opposed to NMI), it is necessary to invoke
rcu_dynticks_task_exit() just before the CPU is marked non-idle from an
RCU perspective and to invoke rcu_cleanup_after_idle() just after the
CPU is marked non-idle.  Similarly, when exiting the outermost handler
via an interrupt, it is necessary to invoke rcu_prepare_for_idle() just
before marking the CPU idle and to invoke rcu_dynticks_task_enter()
just after marking the CPU idle.

The decision to execute these four functions is currently taken in
rcu_irq_enter() and rcu_irq_exit() as follows:

   rcu_irq_enter()
      /* A conditional branch with ->dynticks_nmi_nesting */
      rcu_nmi_enter()
         /* A conditional branch with ->dynticks */
      /* A conditional branch with ->dynticks_nmi_nesting */

   rcu_irq_exit()
      /* A conditional branch with ->dynticks_nmi_nesting */
      rcu_nmi_exit()
         /* A conditional branch with ->dynticks_nmi_nesting */
      /* A conditional branch with ->dynticks_nmi_nesting */

   rcu_nmi_enter()
      /* A conditional branch with ->dynticks */

   rcu_nmi_exit()
      /* A conditional branch with ->dynticks_nmi_nesting */

This works, but the conditional branches in rcu_irq_enter() and
rcu_irq_exit() are redundant with those in rcu_nmi_enter() and
rcu_nmi_exit(), respectively.  Redundant branches are not something
we want in the to/from-idle fastpaths, so this commit refactors
rcu_{nmi,irq}_{enter,exit}() so they use a common inlined function passed
a constant argument as follows:

   rcu_irq_enter() inlining rcu_nmi_enter_common(irq=true)
      /* A conditional branch with ->dynticks */

   rcu_irq_exit() inlining rcu_nmi_exit_common(irq=true)
      /* A conditional branch with ->dynticks_nmi_nesting */

   rcu_nmi_enter() inlining rcu_nmi_enter_common(irq=false)
      /* A conditional branch with ->dynticks */

   rcu_nmi_exit() inlining rcu_nmi_exit_common(irq=false)
      /* A conditional branch with ->dynticks_nmi_nesting */

The combination of the constant function argument and the inlining allows
the compiler to discard the conditionals that previously controlled
execution of rcu_dynticks_task_exit(), rcu_cleanup_after_idle(),
rcu_prepare_for_idle(), and rcu_dynticks_task_enter().  This reduces both
the to-idle and from-idle path lengths by two conditional branches each,
and improves readability as well.

This commit also changes order of execution from this:

	rcu_dynticks_task_exit();
	rcu_dynticks_eqs_exit();
	trace_rcu_dyntick();
	rcu_cleanup_after_idle();

To this:

	rcu_dynticks_task_exit();
	rcu_dynticks_eqs_exit();
	rcu_cleanup_after_idle();
	trace_rcu_dyntick();

In other words, the calls to trace_rcu_dyntick() and trace_rcu_dyntick()
are reversed.  This has no functional effect because the real
concern is whether a given call is before or after the call to
rcu_dynticks_eqs_exit(), and this patch does not change that.  Before the
call to rcu_dynticks_eqs_exit(), RCU is not yet watching the current
CPU and after that call RCU is watching.

A similar switch in calling order happens on the idle-entry path, with
similar lack of effect for the same reasons.

Suggested-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Signed-off-by: Byungchul Park <byungchul.park@lge.com>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---
 kernel/rcu/tree.c | 61 +++++++++++++++++++++++++++++++----------------
 1 file changed, 41 insertions(+), 20 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 0b760c1369f7..0adf77923e8b 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -771,17 +771,18 @@ void rcu_user_enter(void)
 #endif /* CONFIG_NO_HZ_FULL */
 
 /**
- * rcu_nmi_exit - inform RCU of exit from NMI context
+ * rcu_nmi_exit_common - inform RCU of exit from NMI context
+ * @irq: Is this call from rcu_irq_exit?
  *
  * If we are returning from the outermost NMI handler that interrupted an
  * RCU-idle period, update rdtp->dynticks and rdtp->dynticks_nmi_nesting
  * to let the RCU grace-period handling know that the CPU is back to
  * being RCU-idle.
  *
- * If you add or remove a call to rcu_nmi_exit(), be sure to test
+ * If you add or remove a call to rcu_nmi_exit_common(), be sure to test
  * with CONFIG_RCU_EQS_DEBUG=y.
  */
-void rcu_nmi_exit(void)
+static __always_inline void rcu_nmi_exit_common(bool irq)
 {
 	struct rcu_dynticks *rdtp = this_cpu_ptr(&rcu_dynticks);
 
@@ -807,7 +808,22 @@ void rcu_nmi_exit(void)
 	/* This NMI interrupted an RCU-idle CPU, restore RCU-idleness. */
 	trace_rcu_dyntick(TPS("Startirq"), rdtp->dynticks_nmi_nesting, 0, rdtp->dynticks);
 	WRITE_ONCE(rdtp->dynticks_nmi_nesting, 0); /* Avoid store tearing. */
+
+	if (irq)
+		rcu_prepare_for_idle();
+
 	rcu_dynticks_eqs_enter();
+
+	if (irq)
+		rcu_dynticks_task_enter();
+}
+
+/**
+ * rcu_nmi_exit - inform RCU of exit from NMI context
+ */
+void rcu_nmi_exit(void)
+{
+	rcu_nmi_exit_common(false);
 }
 
 /**
@@ -831,14 +847,8 @@ void rcu_nmi_exit(void)
  */
 void rcu_irq_exit(void)
 {
-	struct rcu_dynticks *rdtp = this_cpu_ptr(&rcu_dynticks);
-
 	lockdep_assert_irqs_disabled();
-	if (rdtp->dynticks_nmi_nesting == 1)
-		rcu_prepare_for_idle();
-	rcu_nmi_exit();
-	if (rdtp->dynticks_nmi_nesting == 0)
-		rcu_dynticks_task_enter();
+	rcu_nmi_exit_common(true);
 }
 
 /*
@@ -921,7 +931,8 @@ void rcu_user_exit(void)
 #endif /* CONFIG_NO_HZ_FULL */
 
 /**
- * rcu_nmi_enter - inform RCU of entry to NMI context
+ * rcu_nmi_enter_common - inform RCU of entry to NMI context
+ * @irq: Is this call from rcu_irq_enter?
  *
  * If the CPU was idle from RCU's viewpoint, update rdtp->dynticks and
  * rdtp->dynticks_nmi_nesting to let the RCU grace-period handling know
@@ -929,10 +940,10 @@ void rcu_user_exit(void)
  * long as the nesting level does not overflow an int.  (You will probably
  * run out of stack space first.)
  *
- * If you add or remove a call to rcu_nmi_enter(), be sure to test
+ * If you add or remove a call to rcu_nmi_enter_common(), be sure to test
  * with CONFIG_RCU_EQS_DEBUG=y.
  */
-void rcu_nmi_enter(void)
+static __always_inline void rcu_nmi_enter_common(bool irq)
 {
 	struct rcu_dynticks *rdtp = this_cpu_ptr(&rcu_dynticks);
 	long incby = 2;
@@ -949,7 +960,15 @@ void rcu_nmi_enter(void)
 	 * period (observation due to Andy Lutomirski).
 	 */
 	if (rcu_dynticks_curr_cpu_in_eqs()) {
+
+		if (irq)
+			rcu_dynticks_task_exit();
+
 		rcu_dynticks_eqs_exit();
+
+		if (irq)
+			rcu_cleanup_after_idle();
+
 		incby = 1;
 	}
 	trace_rcu_dyntick(incby == 1 ? TPS("Endirq") : TPS("++="),
@@ -960,6 +979,14 @@ void rcu_nmi_enter(void)
 	barrier();
 }
 
+/**
+ * rcu_nmi_enter - inform RCU of entry to NMI context
+ */
+void rcu_nmi_enter(void)
+{
+	rcu_nmi_enter_common(false);
+}
+
 /**
  * rcu_irq_enter - inform RCU that current CPU is entering irq away from idle
  *
@@ -984,14 +1011,8 @@ void rcu_nmi_enter(void)
  */
 void rcu_irq_enter(void)
 {
-	struct rcu_dynticks *rdtp = this_cpu_ptr(&rcu_dynticks);
-
 	lockdep_assert_irqs_disabled();
-	if (rdtp->dynticks_nmi_nesting == 0)
-		rcu_dynticks_task_exit();
-	rcu_nmi_enter();
-	if (rdtp->dynticks_nmi_nesting == 1)
-		rcu_cleanup_after_idle();
+	rcu_nmi_enter_common(true);
 }
 
 /*
-- 
2.17.1

