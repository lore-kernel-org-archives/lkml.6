Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35BA9C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 06:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D40EC20883
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 06:39:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D40EC20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lge.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754271AbeFUGj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 02:39:56 -0400
Received: from lgeamrelo11.lge.com ([156.147.23.51]:49680 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754093AbeFUGjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 02:39:54 -0400
Received: from unknown (HELO lgemrelse7q.lge.com) (156.147.1.151)
        by 156.147.23.51 with ESMTP; 21 Jun 2018 15:39:51 +0900
X-Original-SENDERIP: 156.147.1.151
X-Original-MAILFROM: byungchul.park@lge.com
Received: from unknown (HELO X58A-UD3R) (10.177.222.33)
        by 156.147.1.151 with ESMTP; 21 Jun 2018 15:39:51 +0900
X-Original-SENDERIP: 10.177.222.33
X-Original-MAILFROM: byungchul.park@lge.com
Date:   Thu, 21 Jun 2018 15:39:49 +0900
From:   Byungchul Park <byungchul.park@lge.com>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     Byungchul Park <max.byungchul.park@gmail.com>,
        jiangshanlai@gmail.com, josh@joshtriplett.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org, kernel-team@lge.com,
        Joel Fernandes <joel@joelfernandes.org>, luto@kernel.org
Subject: Re: [RFC 2/2] rcu: Remove ->dynticks_nmi_nesting from struct
 rcu_dynticks
Message-ID: <20180621063949.GA28024@X58A-UD3R>
References: <1529484440-20634-1-git-send-email-byungchul.park@lge.com>
 <1529484440-20634-2-git-send-email-byungchul.park@lge.com>
 <20180620145814.GQ3593@linux.vnet.ibm.com>
 <CANrsvRMYc5u3L53nnnGC6p-QcjBTfLPjkJGZyubGWAPauc-W8w@mail.gmail.com>
 <20180620164902.GW3593@linux.vnet.ibm.com>
 <CANrsvRPAWv8LgSvPrGgLiXnjrtK3CmpJgdpNsuu-0LZJTYeYWQ@mail.gmail.com>
 <20180620174037.GZ3593@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180620174037.GZ3593@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 10:40:37AM -0700, Paul E. McKenney wrote:
> On Thu, Jun 21, 2018 at 02:15:07AM +0900, Byungchul Park wrote:

[...]

> > Totally agree with you. Sorry bothering you.
> 
> Absolutely not a problem, absolutely no need to apologize!  I am
> actually very happy that you are taking RCU seriously and looking at it
> in such depth.

Thanks a lot. :)

> My problem is that when I see a patch like this, something in the back of
> my head screams "WRONG!!!", and I sometimes get confused about exactly
> what the back of my head is screaming about, which was the case here.
> Hence my misguided initial complaint about NMI nesting instead of about
> the possibility of unpaired rcu_irq_enter() calls.
> 
> So apologies for that, but I unfortunately cannot promise that this

It's ok. I also made a mistake.

> won't happen again.  I have learned the hard way to trust the back of
> my head.  It sometimes makes mistakes, but less often than the rest of
> my head does.  ;-)

I believe it doesn't matter at all as everybody makes mistakes. You must
be much more careful in everything than others though. I believe the
only problem with regard to human's mistakes is the attitude never even
trying to communicate with others, being convinced that they've never
made mistakes.

> In the meantime, is it possible to rearrange rcu_irq_enter() and
> rcu_nmi_enter() (and similarly rcu_irq_exit() and rcu_nmi_exit())
> to avoid the conditionals (via compiler inlining) while still keeping
> function calls ordered properly?  I bet that you could do it by splitting
> rcu_nmi_enter() and rcu_nmi_exit() sort of like this:
> 
> 	static void rcu_nmi_enter_common(bool irq)
> 	{
> 		/*
> 		 * You fill this in.  Maybe __always_inline above.  The
> 		 * rcu_dynticks_task_exit() and rcu_cleanup_after_idle()
> 		 * calls need to be on opposite sides of the
> 		 * rcu_dynticks_eqs_exit() call, just like they are now.
> 		 */
> 	}
> 
> 	void rcu_nmi_enter(void)
> 	{
> 		rcu_nmi_enter_common(false);
> 	}
> 
> 	void rcu_irq_enter(void)
> 	{
> 		lockdep_assert_irqs_disabled();
> 		rcu_nmi_enter(true);
> 	}
> 
> Saving a couple of branches on the irq enter/exit paths seems like it
> just might be worth something.  ;-)

What about the following patch?

I applied what you suggested and re-named rcu_nmi_{enter,exit} to
rcu_irq_{enter,exit} and applied the same re-naming to
->dynticks_nmi_nesting as well, since those are not things to do with
nmi anymore but both irq and nmi.

I think "irq" is better to represent both irq and nmi than "nmi".
Please let me know if you don't think so. I can get rid of the re-
naming from the patch.

I will re-send this with a change log after getting your opinion.

----->8-----
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index deb2508..413fef7 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -260,7 +260,7 @@ void rcu_bh_qs(void)
 
 static DEFINE_PER_CPU(struct rcu_dynticks, rcu_dynticks) = {
 	.dynticks_nesting = 1,
-	.dynticks_nmi_nesting = DYNTICK_IRQ_NONIDLE,
+	.dynticks_irq_nesting = DYNTICK_IRQ_NONIDLE,
 	.dynticks = ATOMIC_INIT(RCU_DYNTICK_CTRL_CTR),
 };
 
@@ -695,7 +695,7 @@ static struct rcu_node *rcu_get_root(struct rcu_state *rsp)
  * Enter an RCU extended quiescent state, which can be either the
  * idle loop or adaptive-tickless usermode execution.
  *
- * We crowbar the ->dynticks_nmi_nesting field to zero to allow for
+ * We crowbar the ->dynticks_irq_nesting field to zero to allow for
  * the possibility of usermode upcalls having messed up our count
  * of interrupt nesting level during the prior busy period.
  */
@@ -706,7 +706,7 @@ static void rcu_eqs_enter(bool user)
 	struct rcu_dynticks *rdtp;
 
 	rdtp = this_cpu_ptr(&rcu_dynticks);
-	WRITE_ONCE(rdtp->dynticks_nmi_nesting, 0);
+	WRITE_ONCE(rdtp->dynticks_irq_nesting, 0);
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) &&
 		     rdtp->dynticks_nesting == 0);
 	if (rdtp->dynticks_nesting != 1) {
@@ -764,43 +764,58 @@ void rcu_user_enter(void)
 #endif /* CONFIG_NO_HZ_FULL */
 
 /**
- * rcu_nmi_exit - inform RCU of exit from NMI context
+ * rcu_irq_exit_common - inform RCU of exit from interrupt context
  *
- * If we are returning from the outermost NMI handler that interrupted an
- * RCU-idle period, update rdtp->dynticks and rdtp->dynticks_nmi_nesting
- * to let the RCU grace-period handling know that the CPU is back to
- * being RCU-idle.
+ * If we are returning from the outermost interrupt handler that
+ * interrupted an RCU-idle period, update rdtp->dynticks and
+ * rdtp->dynticks_irq_nesting to let the RCU grace-period handling
+ * know that the CPU is back to being RCU-idle.
  *
- * If you add or remove a call to rcu_nmi_exit(), be sure to test
- * with CONFIG_RCU_EQS_DEBUG=y.
+ * If you add or remove a call to rcu_irq_exit_common(), be sure to
+ * test with CONFIG_RCU_EQS_DEBUG=y.
  */
-void rcu_nmi_exit(void)
+static __always_inline void rcu_irq_exit_common(bool nmi)
 {
 	struct rcu_dynticks *rdtp = this_cpu_ptr(&rcu_dynticks);
 
 	/*
-	 * Check for ->dynticks_nmi_nesting underflow and bad ->dynticks.
+	 * Check for ->dynticks_irq_nesting underflow and bad ->dynticks.
 	 * (We are exiting an NMI handler, so RCU better be paying attention
 	 * to us!)
 	 */
-	WARN_ON_ONCE(rdtp->dynticks_nmi_nesting <= 0);
+	WARN_ON_ONCE(rdtp->dynticks_irq_nesting <= 0);
 	WARN_ON_ONCE(rcu_dynticks_curr_cpu_in_eqs());
 
 	/*
 	 * If the nesting level is not 1, the CPU wasn't RCU-idle, so
 	 * leave it in non-RCU-idle state.
 	 */
-	if (rdtp->dynticks_nmi_nesting != 1) {
-		trace_rcu_dyntick(TPS("--="), rdtp->dynticks_nmi_nesting, rdtp->dynticks_nmi_nesting - 2, rdtp->dynticks);
-		WRITE_ONCE(rdtp->dynticks_nmi_nesting, /* No store tearing. */
-			   rdtp->dynticks_nmi_nesting - 2);
+	if (rdtp->dynticks_irq_nesting != 1) {
+		trace_rcu_dyntick(TPS("--="), rdtp->dynticks_irq_nesting, rdtp->dynticks_irq_nesting - 2, rdtp->dynticks);
+		WRITE_ONCE(rdtp->dynticks_irq_nesting, /* No store tearing. */
+			   rdtp->dynticks_irq_nesting - 2);
 		return;
 	}
 
 	/* This NMI interrupted an RCU-idle CPU, restore RCU-idleness. */
-	trace_rcu_dyntick(TPS("Startirq"), rdtp->dynticks_nmi_nesting, 0, rdtp->dynticks);
-	WRITE_ONCE(rdtp->dynticks_nmi_nesting, 0); /* Avoid store tearing. */
+	trace_rcu_dyntick(TPS("Startirq"), rdtp->dynticks_irq_nesting, 0, rdtp->dynticks);
+	WRITE_ONCE(rdtp->dynticks_irq_nesting, 0); /* Avoid store tearing. */
+
+	if (!nmi)
+		rcu_prepare_for_idle();
+
 	rcu_dynticks_eqs_enter();
+
+	if (!nmi)
+		rcu_dynticks_task_enter();
+}
+
+/**
+ * rcu_nmi_exit - inform RCU of exit from NMI context
+ */
+void rcu_nmi_exit(void)
+{
+	rcu_irq_exit_common(true);
 }
 
 /**
@@ -824,14 +839,8 @@ void rcu_nmi_exit(void)
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
+	rcu_irq_exit_common(false);
 }
 
 /*
@@ -853,7 +862,7 @@ void rcu_irq_exit_irqson(void)
  * Exit an RCU extended quiescent state, which can be either the
  * idle loop or adaptive-tickless usermode execution.
  *
- * We crowbar the ->dynticks_nmi_nesting field to DYNTICK_IRQ_NONIDLE to
+ * We crowbar the ->dynticks_irq_nesting field to DYNTICK_IRQ_NONIDLE to
  * allow for the possibility of usermode upcalls messing up our count of
  * interrupt nesting level during the busy period that is just now starting.
  */
@@ -876,7 +885,7 @@ static void rcu_eqs_exit(bool user)
 	trace_rcu_dyntick(TPS("End"), rdtp->dynticks_nesting, 1, rdtp->dynticks);
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !user && !is_idle_task(current));
 	WRITE_ONCE(rdtp->dynticks_nesting, 1);
-	WRITE_ONCE(rdtp->dynticks_nmi_nesting, DYNTICK_IRQ_NONIDLE);
+	WRITE_ONCE(rdtp->dynticks_irq_nesting, DYNTICK_IRQ_NONIDLE);
 }
 
 /**
@@ -914,46 +923,62 @@ void rcu_user_exit(void)
 #endif /* CONFIG_NO_HZ_FULL */
 
 /**
- * rcu_nmi_enter - inform RCU of entry to NMI context
+ * rcu_irq_enter_common - inform RCU of entry to interrupt context
  *
  * If the CPU was idle from RCU's viewpoint, update rdtp->dynticks and
- * rdtp->dynticks_nmi_nesting to let the RCU grace-period handling know
- * that the CPU is active.  This implementation permits nested NMIs, as
- * long as the nesting level does not overflow an int.  (You will probably
- * run out of stack space first.)
+ * rdtp->dynticks_irq_nesting to let the RCU grace-period handling know
+ * that the CPU is active.  This implementation permits nested
+ * interrupts including NMIs, as long as the nesting level does not
+ * overflow an int. (You will probably run out of stack space first.)
  *
- * If you add or remove a call to rcu_nmi_enter(), be sure to test
- * with CONFIG_RCU_EQS_DEBUG=y.
+ * If you add or remove a call to rcu_irq_enter_common(), be sure to
+ * test with CONFIG_RCU_EQS_DEBUG=y.
  */
-void rcu_nmi_enter(void)
+static __always_inline void rcu_irq_enter_common(bool nmi)
 {
 	struct rcu_dynticks *rdtp = this_cpu_ptr(&rcu_dynticks);
 	long incby = 2;
 
 	/* Complain about underflow. */
-	WARN_ON_ONCE(rdtp->dynticks_nmi_nesting < 0);
+	WARN_ON_ONCE(rdtp->dynticks_irq_nesting < 0);
 
 	/*
 	 * If idle from RCU viewpoint, atomically increment ->dynticks
-	 * to mark non-idle and increment ->dynticks_nmi_nesting by one.
-	 * Otherwise, increment ->dynticks_nmi_nesting by two.  This means
-	 * if ->dynticks_nmi_nesting is equal to one, we are guaranteed
+	 * to mark non-idle and increment ->dynticks_irq_nesting by one.
+	 * Otherwise, increment ->dynticks_irq_nesting by two.  This means
+	 * if ->dynticks_irq_nesting is equal to one, we are guaranteed
 	 * to be in the outermost NMI handler that interrupted an RCU-idle
 	 * period (observation due to Andy Lutomirski).
 	 */
 	if (rcu_dynticks_curr_cpu_in_eqs()) {
+
+		if (!nmi)
+			rcu_dynticks_task_exit();
+
 		rcu_dynticks_eqs_exit();
+
+		if (!nmi)
+			rcu_cleanup_after_idle();
+
 		incby = 1;
 	}
 	trace_rcu_dyntick(incby == 1 ? TPS("Endirq") : TPS("++="),
-			  rdtp->dynticks_nmi_nesting,
-			  rdtp->dynticks_nmi_nesting + incby, rdtp->dynticks);
-	WRITE_ONCE(rdtp->dynticks_nmi_nesting, /* Prevent store tearing. */
-		   rdtp->dynticks_nmi_nesting + incby);
+			  rdtp->dynticks_irq_nesting,
+			  rdtp->dynticks_irq_nesting + incby, rdtp->dynticks);
+	WRITE_ONCE(rdtp->dynticks_irq_nesting, /* Prevent store tearing. */
+		   rdtp->dynticks_irq_nesting + incby);
 	barrier();
 }
 
 /**
+ * rcu_nmi_enter - inform RCU of entry to NMI context
+ */
+void rcu_nmi_enter(void)
+{
+	rcu_irq_enter_common(true);
+}
+
+/**
  * rcu_irq_enter - inform RCU that current CPU is entering irq away from idle
  *
  * Enter an interrupt handler, which might possibly result in exiting
@@ -977,14 +1002,8 @@ void rcu_nmi_enter(void)
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
+	rcu_irq_enter_common(false);
 }
 
 /*
@@ -1092,7 +1111,7 @@ bool rcu_lockdep_current_cpu_online(void)
 static int rcu_is_cpu_rrupt_from_idle(void)
 {
 	return __this_cpu_read(rcu_dynticks.dynticks_nesting) <= 0 &&
-	       __this_cpu_read(rcu_dynticks.dynticks_nmi_nesting) <= 1;
+	       __this_cpu_read(rcu_dynticks.dynticks_irq_nesting) <= 1;
 }
 
 /*
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 4e74df7..80ba455 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -39,7 +39,7 @@
  */
 struct rcu_dynticks {
 	long dynticks_nesting;      /* Track process nesting level. */
-	long dynticks_nmi_nesting;  /* Track irq/NMI nesting level. */
+	long dynticks_irq_nesting;  /* Track irq/NMI nesting level. */
 	atomic_t dynticks;	    /* Even value for idle, else odd. */
 	bool rcu_need_heavy_qs;     /* GP old, need heavy quiescent state. */
 	unsigned long rcu_qs_ctr;   /* Light universal quiescent state ctr. */
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index c1b17f5..2cd637d 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1811,7 +1811,7 @@ static void print_cpu_stall_info(struct rcu_state *rsp, int cpu)
 				"!."[!delta],
 	       ticks_value, ticks_title,
 	       rcu_dynticks_snap(rdtp) & 0xfff,
-	       rdtp->dynticks_nesting, rdtp->dynticks_nmi_nesting,
+	       rdtp->dynticks_nesting, rdtp->dynticks_irq_nesting,
 	       rdp->softirq_snap, kstat_softirqs_cpu(RCU_SOFTIRQ, cpu),
 	       READ_ONCE(rsp->n_force_qs) - rsp->n_force_qs_gpstart,
 	       fast_no_hz);
