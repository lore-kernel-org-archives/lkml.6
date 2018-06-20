Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E8DC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBAB920846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:48:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBAB920846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lge.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754733AbeFTIsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:48:04 -0400
Received: from lgeamrelo11.lge.com ([156.147.23.51]:34372 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932727AbeFTIrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:47:24 -0400
Received: from unknown (HELO lgeamrelo02.lge.com) (156.147.1.126)
        by 156.147.23.51 with ESMTP; 20 Jun 2018 17:47:22 +0900
X-Original-SENDERIP: 156.147.1.126
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO localhost.localdomain) (10.177.222.33)
        by 156.147.1.126 with ESMTP; 20 Jun 2018 17:47:22 +0900
X-Original-SENDERIP: 10.177.222.33
X-Original-MAILFROM: byungchul.park@lge.com
From:   Byungchul Park <byungchul.park@lge.com>
To:     jiangshanlai@gmail.com, paulmck@linux.vnet.ibm.com,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com
Cc:     linux-kernel@vger.kernel.org, kernel-team@lge.com,
        joel@joelfernandes.org
Subject: [RFC 2/2] rcu: Remove ->dynticks_nmi_nesting from struct rcu_dynticks
Date:   Wed, 20 Jun 2018 17:47:20 +0900
Message-Id: <1529484440-20634-2-git-send-email-byungchul.park@lge.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1529484440-20634-1-git-send-email-byungchul.park@lge.com>
References: <1529484440-20634-1-git-send-email-byungchul.park@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello folks,

I'm careful in saying that ->dynticks_nmi_nesting can be removed but I
think it's possible since the only thing we are interested in with
regard to ->dynticks_nesting or ->dynticks_nmi_nesting is whether rcu is
idle or not.

And I'm also afraid if the assumption is correct for every archs which I
based on, that is, an assignment operation on a single aligned word is
atomic in terms of instruction.

Thoughs?

----->8-----
From 84970b33eb06c3bb1bebbb1754db405c0fc50fbe Mon Sep 17 00:00:00 2001
From: Byungchul Park <byungchul.park@lge.com>
Date: Wed, 20 Jun 2018 16:01:20 +0900
Subject: [RFC 2/2] rcu: Remove ->dynticks_nmi_nesting from struct rcu_dynticks

The only thing we are interested in with regard to ->dynticks_nesting or
->dynticks_nmi_nesting is whether rcu is idle or not, which can be
handled only using ->dynticks_nesting though. ->dynticks_nmi_nesting is
unnecessary but to make the code more complicated.

This patch makes both rcu_eqs_{enter,exit}() and rcu_nmi_{enter,exit}()
count up and down a single variable, ->dynticks_nesting to keep how many
rcu non-idle sections have been nested.

As a result, no matter who made the variable be non-zero, it's anyway
non-idle, and it can be considered as just having been idle once the
variable is equal to zero. So tricky code can be removed.

In addition, it was assumed that an assignment operation on a single
aligned word is atomic so that ->dynticks_nesting can be safely assigned
within both nmi context and others concurrently.

Signed-off-by: Byungchul Park <byungchul.park@lge.com>
---
 kernel/rcu/tree.c        | 76 ++++++++++++++++++++----------------------------
 kernel/rcu/tree.h        |  4 +--
 kernel/rcu/tree_plugin.h |  4 +--
 3 files changed, 35 insertions(+), 49 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 59ae94e..61f203a 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -260,7 +260,6 @@ void rcu_bh_qs(void)
 
 static DEFINE_PER_CPU(struct rcu_dynticks, rcu_dynticks) = {
 	.dynticks_nesting = 1,
-	.dynticks_nmi_nesting = DYNTICK_IRQ_NONIDLE,
 	.dynticks = ATOMIC_INIT(RCU_DYNTICK_CTRL_CTR),
 };
 
@@ -694,10 +693,6 @@ static struct rcu_node *rcu_get_root(struct rcu_state *rsp)
 /*
  * Enter an RCU extended quiescent state, which can be either the
  * idle loop or adaptive-tickless usermode execution.
- *
- * We crowbar the ->dynticks_nmi_nesting field to zero to allow for
- * the possibility of usermode upcalls having messed up our count
- * of interrupt nesting level during the prior busy period.
  */
 static void rcu_eqs_enter(bool user)
 {
@@ -706,11 +701,11 @@ static void rcu_eqs_enter(bool user)
 	struct rcu_dynticks *rdtp;
 
 	rdtp = this_cpu_ptr(&rcu_dynticks);
-	WRITE_ONCE(rdtp->dynticks_nmi_nesting, 0);
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) &&
 		     rdtp->dynticks_nesting == 0);
 	if (rdtp->dynticks_nesting != 1) {
-		rdtp->dynticks_nesting--;
+		WRITE_ONCE(rdtp->dynticks_nesting, /* No store tearing. */
+			   rdtp->dynticks_nesting - 1);
 		return;
 	}
 
@@ -767,7 +762,7 @@ void rcu_user_enter(void)
  * rcu_nmi_exit - inform RCU of exit from NMI context
  *
  * If we are returning from the outermost NMI handler that interrupted an
- * RCU-idle period, update rdtp->dynticks and rdtp->dynticks_nmi_nesting
+ * RCU-idle period, update rdtp->dynticks and rdtp->dynticks_nesting
  * to let the RCU grace-period handling know that the CPU is back to
  * being RCU-idle.
  *
@@ -779,21 +774,21 @@ void rcu_nmi_exit(void)
 	struct rcu_dynticks *rdtp = this_cpu_ptr(&rcu_dynticks);
 
 	/*
-	 * Check for ->dynticks_nmi_nesting underflow and bad ->dynticks.
+	 * Check for ->dynticks_nesting underflow and bad ->dynticks.
 	 * (We are exiting an NMI handler, so RCU better be paying attention
 	 * to us!)
 	 */
-	WARN_ON_ONCE(rdtp->dynticks_nmi_nesting <= 0);
+	WARN_ON_ONCE(rdtp->dynticks_nesting <= 0);
 	WARN_ON_ONCE(rcu_dynticks_curr_cpu_in_eqs());
 
 	/*
 	 * If the nesting level is not 1, the CPU wasn't RCU-idle, so
 	 * leave it in non-RCU-idle state.
 	 */
-	if (rdtp->dynticks_nmi_nesting != 1) {
-		trace_rcu_dyntick(TPS("--="), rdtp->dynticks_nmi_nesting, rdtp->dynticks_nmi_nesting - 2, rdtp->dynticks);
-		WRITE_ONCE(rdtp->dynticks_nmi_nesting, /* No store tearing. */
-			   rdtp->dynticks_nmi_nesting - 2);
+	if (rdtp->dynticks_nesting != 1) {
+		trace_rcu_dyntick(TPS("--="), rdtp->dynticks_nesting, rdtp->dynticks_nesting - 1, rdtp->dynticks);
+		WRITE_ONCE(rdtp->dynticks_nesting, /* No store tearing. */
+			   rdtp->dynticks_nesting - 1);
 		return;
 	}
 
@@ -803,8 +798,8 @@ void rcu_nmi_exit(void)
 	}
 
 	/* This NMI interrupted an RCU-idle CPU, restore RCU-idleness. */
-	trace_rcu_dyntick(TPS("Startirq"), rdtp->dynticks_nmi_nesting, 0, rdtp->dynticks);
-	WRITE_ONCE(rdtp->dynticks_nmi_nesting, 0); /* Avoid store tearing. */
+	trace_rcu_dyntick(TPS("Startirq"), rdtp->dynticks_nesting, 0, rdtp->dynticks);
+	WRITE_ONCE(rdtp->dynticks_nesting, 0); /* Avoid store tearing. */
 	rcu_dynticks_eqs_enter();
 }
 
@@ -851,10 +846,6 @@ void rcu_irq_exit_irqson(void)
 /*
  * Exit an RCU extended quiescent state, which can be either the
  * idle loop or adaptive-tickless usermode execution.
- *
- * We crowbar the ->dynticks_nmi_nesting field to DYNTICK_IRQ_NONIDLE to
- * allow for the possibility of usermode upcalls messing up our count of
- * interrupt nesting level during the busy period that is just now starting.
  */
 static void rcu_eqs_exit(bool user)
 {
@@ -866,7 +857,8 @@ static void rcu_eqs_exit(bool user)
 	oldval = rdtp->dynticks_nesting;
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && oldval < 0);
 	if (oldval) {
-		rdtp->dynticks_nesting++;
+		WRITE_ONCE(rdtp->dynticks_nesting, /* No store tearing. */
+			   rdtp->dynticks_nesting + 1);
 		return;
 	}
 	rcu_dynticks_task_exit();
@@ -875,7 +867,6 @@ static void rcu_eqs_exit(bool user)
 	trace_rcu_dyntick(TPS("End"), rdtp->dynticks_nesting, 1, rdtp->dynticks);
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
 	WRITE_ONCE(rdtp->dynticks_nesting, 1);
-	WRITE_ONCE(rdtp->dynticks_nmi_nesting, DYNTICK_IRQ_NONIDLE);
 }
 
 /**
@@ -915,11 +906,11 @@ void rcu_user_exit(void)
 /**
  * rcu_nmi_enter - inform RCU of entry to NMI context
  *
- * If the CPU was idle from RCU's viewpoint, update rdtp->dynticks and
- * rdtp->dynticks_nmi_nesting to let the RCU grace-period handling know
- * that the CPU is active.  This implementation permits nested NMIs, as
- * long as the nesting level does not overflow an int.  (You will probably
- * run out of stack space first.)
+ * If the CPU was idle from RCU's viewpoint, update rdtp->dynticks. And
+ * then update rdtp->dynticks_nesting to let the RCU grace-period handling
+ * know that the CPU is active.  This implementation permits nested NMIs,
+ * as long as the nesting level does not overflow an int.  (You will
+ * probably run out of stack space first.)
  *
  * If you add or remove a call to rcu_nmi_enter(), be sure to test
  * with CONFIG_RCU_EQS_DEBUG=y.
@@ -927,33 +918,29 @@ void rcu_user_exit(void)
 void rcu_nmi_enter(void)
 {
 	struct rcu_dynticks *rdtp = this_cpu_ptr(&rcu_dynticks);
-	long incby = 2;
 
 	/* Complain about underflow. */
-	WARN_ON_ONCE(rdtp->dynticks_nmi_nesting < 0);
+	WARN_ON_ONCE(rdtp->dynticks_nesting < 0);
 
-	/*
-	 * If idle from RCU viewpoint, atomically increment ->dynticks
-	 * to mark non-idle and increment ->dynticks_nmi_nesting by one.
-	 * Otherwise, increment ->dynticks_nmi_nesting by two.  This means
-	 * if ->dynticks_nmi_nesting is equal to one, we are guaranteed
-	 * to be in the outermost NMI handler that interrupted an RCU-idle
-	 * period (observation due to Andy Lutomirski).
-	 */
 	if (rcu_dynticks_curr_cpu_in_eqs()) {
 		rcu_dynticks_eqs_exit();
-		incby = 1;
 
 		if (!in_nmi()) {
 			rcu_dynticks_task_exit();
 			rcu_cleanup_after_idle();
 		}
 	}
-	trace_rcu_dyntick(incby == 1 ? TPS("Endirq") : TPS("++="),
-			  rdtp->dynticks_nmi_nesting,
-			  rdtp->dynticks_nmi_nesting + incby, rdtp->dynticks);
-	WRITE_ONCE(rdtp->dynticks_nmi_nesting, /* Prevent store tearing. */
-		   rdtp->dynticks_nmi_nesting + incby);
+
+	trace_rcu_dyntick(rdtp->dynticks_nesting ? TPS("++=") : TPS("Endirq"),
+			  rdtp->dynticks_nesting,
+			  rdtp->dynticks_nesting + 1, rdtp->dynticks);
+	/*
+	 * If ->dynticks_nesting is equal to one on rcu_nmi_exit(), we are
+	 * guaranteed to be in the outermost NMI handler that interrupted
+	 * an RCU-idle period (observation due to Andy Lutomirski).
+	 */
+	WRITE_ONCE(rdtp->dynticks_nesting, /* Prevent store tearing. */
+		   rdtp->dynticks_nesting + 1);
 	barrier();
 }
 
@@ -1089,8 +1076,7 @@ bool rcu_lockdep_current_cpu_online(void)
  */
 static int rcu_is_cpu_rrupt_from_idle(void)
 {
-	return __this_cpu_read(rcu_dynticks.dynticks_nesting) <= 0 &&
-	       __this_cpu_read(rcu_dynticks.dynticks_nmi_nesting) <= 1;
+	return __this_cpu_read(rcu_dynticks.dynticks_nesting) <= 1;
 }
 
 /*
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 4e74df7..071afe4 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -38,8 +38,8 @@
  * Dynticks per-CPU state.
  */
 struct rcu_dynticks {
-	long dynticks_nesting;      /* Track process nesting level. */
-	long dynticks_nmi_nesting;  /* Track irq/NMI nesting level. */
+	long dynticks_nesting __attribute__((aligned(sizeof(long))));
+				    /* Track process nesting level. */
 	atomic_t dynticks;	    /* Even value for idle, else odd. */
 	bool rcu_need_heavy_qs;     /* GP old, need heavy quiescent state. */
 	unsigned long rcu_qs_ctr;   /* Light universal quiescent state ctr. */
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index c1b17f5..0c57e50 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1801,7 +1801,7 @@ static void print_cpu_stall_info(struct rcu_state *rsp, int cpu)
 	}
 	print_cpu_stall_fast_no_hz(fast_no_hz, cpu);
 	delta = rcu_seq_ctr(rdp->mynode->gp_seq - rdp->rcu_iw_gp_seq);
-	pr_err("\t%d-%c%c%c%c: (%lu %s) idle=%03x/%ld/%#lx softirq=%u/%u fqs=%ld %s\n",
+	pr_err("\t%d-%c%c%c%c: (%lu %s) idle=%03x/%ld softirq=%u/%u fqs=%ld %s\n",
 	       cpu,
 	       "O."[!!cpu_online(cpu)],
 	       "o."[!!(rdp->grpmask & rdp->mynode->qsmaskinit)],
@@ -1811,7 +1811,7 @@ static void print_cpu_stall_info(struct rcu_state *rsp, int cpu)
 				"!."[!delta],
 	       ticks_value, ticks_title,
 	       rcu_dynticks_snap(rdtp) & 0xfff,
-	       rdtp->dynticks_nesting, rdtp->dynticks_nmi_nesting,
+	       rdtp->dynticks_nesting,
 	       rdp->softirq_snap, kstat_softirqs_cpu(RCU_SOFTIRQ, cpu),
 	       READ_ONCE(rsp->n_force_qs) - rsp->n_force_qs_gpstart,
 	       fast_no_hz);
-- 
1.9.1

