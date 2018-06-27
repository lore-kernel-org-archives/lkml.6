Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E82C43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 08:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A83D25A0B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 08:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hETmzJ9w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A83D25A0B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932393AbeF0IeR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 04:34:17 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57424 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932107AbeF0IeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 04:34:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7Us1lUH/Ub8rO9CZuk3SFbPjODk5p3ptgESF1FR8ygw=; b=hETmzJ9wlNWLFi2lHxH1RFAID
        xyKBRZFUaHPd6Rpcnr7gbg21lUj1d62gDQczBITbyKBw1WUoWL/ODY6hEj9W141RKX+NjBExCIMnV
        3J+2FxRDiUeAz/GTferJqNXG1iBjcLnV5uW2LLg9A+CiqK8yF7KejfY4VVn6veYtMNDPl1lH5dklv
        7auosX5lS5OvdLRlba9G6d0yyrcqQTQH2cdbJ7pQSq98qgNS+zPFkh324POVb+NEnHakD+pVP+01J
        Oo5Wa2j8Uz0sh+eESWtS7C0ZL4WfRg+M1e2DenwkMkuQ1wyGiG4nnDqtm6xqivvUp7Kb5/+FUQSOv
        N+hUT9bpg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fY5tS-0003gj-Mt; Wed, 27 Jun 2018 08:33:38 +0000
Received: by worktop (Postfix, from userid 1000)
        id 858836E0A9B; Wed, 27 Jun 2018 10:33:35 +0200 (CEST)
Date:   Wed, 27 Jun 2018 10:33:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 13/22] rcu: Fix grace-period hangs due to
 race with CPU offline
Message-ID: <20180627083335.GA7184@worktop.programming.kicks-ass.net>
References: <20180626002052.GA24146@linux.vnet.ibm.com>
 <20180626171048.2181-13-paulmck@linux.vnet.ibm.com>
 <20180626175119.GL2494@hirez.programming.kicks-ass.net>
 <20180626182950.GH3593@linux.vnet.ibm.com>
 <20180626202615.GA32162@linux.vnet.ibm.com>
 <20180626203225.GT2494@hirez.programming.kicks-ass.net>
 <20180626234004.GQ3593@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626234004.GQ3593@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.22.1 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 04:40:04PM -0700, Paul E. McKenney wrote:
> The options I have considered are as follows:
> 
> 1.	Stick with the no-failsafe approach, adding the lock as shown
> 	in this patch.  (I obviously prefer this approach.)
> 
> 2.	Stick with the no-failsafe approach, but rely on RCU's grace-period
> 	kthread to wake up later due to its timed wait during the
> 	force-quiescent-state process.  This would be a bit obnoxious,
> 	as it requires passing a don't-wake flag (or some such) up the
> 	quiescent-state reporting mechanism.  It would also needlessly
> 	delay grace-period ends, especially on large systems (RCU scales
> 	up the FQS delay on larger systems to maintain limited CPU
> 	consumption per unit time).
> 
> 3.	Stick with the no-failsafe approach, but have the quiescent-state
> 	reporting code hand back a value indicating that a wakeup is needed.
> 	Also a bit obnoxious, as this value would need to be threaded up
> 	the reporting code's return path.  Simple in theory, but a bit
> 	of an ugly change, especially for the many places in the code that
> 	currently expect quiescent-state reporting to be an unconditional
> 	fire-and-forget operation.

You can combine 2 and 3. Use a skip wakeup flag and ignore the return
value most times. Let me do that just to see how horrible it is.

> 
> 4.	Re-introduce the old fail-safe code, and don't report the
> 	quiescent state at CPU-offline time, relying on the fail-safe
> 	code to do so.	This also potentially introduces delays and can
> 	add extra FQS scans, which in turn increases lock contention.
> 
> So what did you have in mind?

The thing I talked about last night before crashing is the patch below;
it does however suffer from a little false-negative, much like the one
you explained earlier. It allows @qsmaskinit to retain the bit set after
offline.

I had hoped to be able to clear @qsmaskinit unconditionally, but that
doesn't quite work.

The other approach is yet another mask @qsmaskofflinenext which the
kthread will use to clear bits on @qsmaskinitnext.

In any case, aside from the above, the below contains a bunch of missing
WRITE_ONCE()s. Since you read the various @qsmask variables using
READ_ONCE() you must also consistently update them using WRITE_ONCE(),
otherwise it's all still buggered.

---
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 7832dd556490..8713048d5103 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -104,7 +104,6 @@ struct rcu_state sname##_state = { \
 	.abbr = sabbr, \
 	.exp_mutex = __MUTEX_INITIALIZER(sname##_state.exp_mutex), \
 	.exp_wake_mutex = __MUTEX_INITIALIZER(sname##_state.exp_wake_mutex), \
-	.ofl_lock = __SPIN_LOCK_UNLOCKED(sname##_state.ofl_lock), \
 }
 
 RCU_STATE_INITIALIZER(rcu_sched, 's', call_rcu_sched);
@@ -209,7 +208,12 @@ EXPORT_SYMBOL_GPL(rcu_get_gp_kthreads_prio);
  */
 unsigned long rcu_rnp_online_cpus(struct rcu_node *rnp)
 {
-	return READ_ONCE(rnp->qsmaskinitnext);
+	/*
+	 * For both online and offline we first set/clear @qsmaskinitnext,
+	 * and complete by propagating into @qsmaskinit. As long as the bit
+	 * remains in either mask, RCU is still online.
+	 */
+	return READ_ONCE(rnp->qsmaskinit) | READ_ONCE(rnp->qsmaskinitnext);
 }
 
 /*
@@ -1928,19 +1932,17 @@ static bool rcu_gp_init(struct rcu_state *rsp)
 	 */
 	rsp->gp_state = RCU_GP_ONOFF;
 	rcu_for_each_leaf_node(rsp, rnp) {
-		spin_lock(&rsp->ofl_lock);
 		raw_spin_lock_irq_rcu_node(rnp);
 		if (rnp->qsmaskinit == rnp->qsmaskinitnext &&
 		    !rnp->wait_blkd_tasks) {
 			/* Nothing to do on this leaf rcu_node structure. */
 			raw_spin_unlock_irq_rcu_node(rnp);
-			spin_unlock(&rsp->ofl_lock);
 			continue;
 		}
 
 		/* Record old state, apply changes to ->qsmaskinit field. */
 		oldmask = rnp->qsmaskinit;
-		rnp->qsmaskinit = rnp->qsmaskinitnext;
+		WRITE_ONCE(rnp->qsmaskinit, rnp->qsmaskinitnext);
 
 		/* If zero-ness of ->qsmaskinit changed, propagate up tree. */
 		if (!oldmask != !rnp->qsmaskinit) {
@@ -1970,7 +1972,6 @@ static bool rcu_gp_init(struct rcu_state *rsp)
 		}
 
 		raw_spin_unlock_irq_rcu_node(rnp);
-		spin_unlock(&rsp->ofl_lock);
 	}
 	rcu_gp_slow(rsp, gp_preinit_delay); /* Races with CPU hotplug. */
 
@@ -1992,7 +1993,7 @@ static bool rcu_gp_init(struct rcu_state *rsp)
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
 		rdp = this_cpu_ptr(rsp->rda);
 		rcu_preempt_check_blocked_tasks(rsp, rnp);
-		rnp->qsmask = rnp->qsmaskinit;
+		WRITE_ONCE(rnp->qsmask, rnp->qsmaskinit);
 		WRITE_ONCE(rnp->gp_seq, rsp->gp_seq);
 		if (rnp == rdp->mynode)
 			(void)__note_gp_changes(rsp, rnp, rdp);
@@ -2295,7 +2296,7 @@ rcu_report_qs_rnp(unsigned long mask, struct rcu_state *rsp,
 		WARN_ON_ONCE(oldmask); /* Any child must be all zeroed! */
 		WARN_ON_ONCE(!rcu_is_leaf_node(rnp) &&
 			     rcu_preempt_blocked_readers_cgp(rnp));
-		rnp->qsmask &= ~mask;
+		WRITE_ONCE(rnp->qsmask, rnp->qsmask & ~mask);
 		trace_rcu_quiescent_state_report(rsp->name, rnp->gp_seq,
 						 mask, rnp->qsmask, rnp->level,
 						 rnp->grplo, rnp->grphi,
@@ -2503,7 +2504,7 @@ static void rcu_cleanup_dead_rnp(struct rcu_node *rnp_leaf)
 		if (!rnp)
 			break;
 		raw_spin_lock_rcu_node(rnp); /* irqs already disabled. */
-		rnp->qsmaskinit &= ~mask;
+		WRITE_ONCE(rnp->qsmaskinit, rnp->qsmaskinit & ~mask);
 		/* Between grace periods, so better already be zero! */
 		WARN_ON_ONCE(rnp->qsmask);
 		if (rnp->qsmaskinit) {
@@ -3522,7 +3523,7 @@ static void rcu_init_new_rnp(struct rcu_node *rnp_leaf)
 			return;
 		raw_spin_lock_rcu_node(rnp); /* Interrupts already disabled. */
 		oldmask = rnp->qsmaskinit;
-		rnp->qsmaskinit |= mask;
+		WRITE_ONCE(rnp->qsmaskinit, rnp->qsmaskinit | mask);
 		raw_spin_unlock_rcu_node(rnp); /* Interrupts remain disabled. */
 		if (oldmask)
 			return;
@@ -3733,7 +3734,7 @@ void rcu_cpu_starting(unsigned int cpu)
 		rnp = rdp->mynode;
 		mask = rdp->grpmask;
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
-		rnp->qsmaskinitnext |= mask;
+		WRITE_ONCE(rnp->qsmaskinitnext, rnp->qsmaskinitnext | mask);
 		oldmask = rnp->expmaskinitnext;
 		rnp->expmaskinitnext |= mask;
 		oldmask ^= rnp->expmaskinitnext;
@@ -3768,18 +3769,36 @@ static void rcu_cleanup_dying_idle_cpu(int cpu, struct rcu_state *rsp)
 
 	/* Remove outgoing CPU from mask in the leaf rcu_node structure. */
 	mask = rdp->grpmask;
-	spin_lock(&rsp->ofl_lock);
 	raw_spin_lock_irqsave_rcu_node(rnp, flags); /* Enforce GP memory-order guarantee. */
 	rdp->rcu_ofl_gp_seq = READ_ONCE(rsp->gp_seq);
 	rdp->rcu_ofl_gp_flags = READ_ONCE(rsp->gp_flags);
+
+	/*
+	 * First clear @qsmaskinitnext such that we'll not start a new GP
+	 * on this outgoing CPU.
+	 */
+	WRITE_ONCE(rnp->qsmaskinitnext, rnp->qsmaskinitnext & ~mask);
 	if (rnp->qsmask & mask) { /* RCU waiting on outgoing CPU? */
-		/* Report quiescent state -before- changing ->qsmaskinitnext! */
+		/*
+		 * Report the QS on the outgoing CPU. This will propagate the
+		 * cleared bit into @qsmaskinit and @qsmask. We rely on
+		 * @qsmaskinit still containing this CPU such that
+		 * rcu_rnp_online_cpus() will still consider RCU online.
+		 *
+		 * This allows us to wake the GP kthread, since wakeups rely on
+		 * RCU.
+		 */
+		WARN_ON_ONCE(!(rnp->qsmaskinit & mask));
 		rcu_report_qs_rnp(mask, rsp, rnp, rnp->gp_seq, flags);
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
+	} else {
+		/*
+		 * If there was no QS required, clear @qsmaskinit now to
+		 * finalize the offline.
+		 */
+		WRITE_ONCE(rnp->qsmaskinit, rnp->qsmaskinit & ~mask);
 	}
-	rnp->qsmaskinitnext &= ~mask;
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
-	spin_unlock(&rsp->ofl_lock);
 }
 
 /*
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 4e74df768c57..a1528b970257 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -84,19 +84,24 @@ struct rcu_node {
 	unsigned long gp_seq;	/* Track rsp->rcu_gp_seq. */
 	unsigned long gp_seq_needed; /* Track rsp->rcu_gp_seq_needed. */
 	unsigned long completedqs; /* All QSes done for this node. */
-	unsigned long qsmask;	/* CPUs or groups that need to switch in */
-				/*  order for current grace period to proceed.*/
-				/*  In leaf rcu_node, each bit corresponds to */
-				/*  an rcu_data structure, otherwise, each */
-				/*  bit corresponds to a child rcu_node */
-				/*  structure. */
-	unsigned long rcu_gp_init_mask;	/* Mask of offline CPUs at GP init. */
+
+	/*
+	 * @qsmask		- CPUs pending in this GP
+	 * @qsmaskinit		- CPUs we started this GP with
+	 * @qsmaskinitnext	- CPUs we'll start the next GP with
+	 *
+	 * online: we add the incoming CPU to @qsmaskinitnext which will then
+	 * be propagated into @qsmaskinit and @qsmask by starting/joining a GP.
+	 *
+	 * offline: we remove the CPU from @qsmaskinitnext such that the
+	 * outgoing CPU will not be part of a next GP, which will then be
+	 * propagated into @qsmaskinit and @qsmask by completing/leaving a GP.
+	 */
+	unsigned long qsmask;
 	unsigned long qsmaskinit;
-				/* Per-GP initial value for qsmask. */
-				/*  Initialized from ->qsmaskinitnext at the */
-				/*  beginning of each grace period. */
 	unsigned long qsmaskinitnext;
-				/* Online CPUs for next grace period. */
+
+	unsigned long rcu_gp_init_mask;	/* Mask of offline CPUs at GP init. */
 	unsigned long expmask;	/* CPUs or groups that need to check in */
 				/*  to allow the current expedited GP */
 				/*  to complete. */
@@ -367,10 +372,6 @@ struct rcu_state {
 	const char *name;			/* Name of structure. */
 	char abbr;				/* Abbreviated name. */
 	struct list_head flavors;		/* List of RCU flavors. */
-
-	spinlock_t ofl_lock ____cacheline_internodealigned_in_smp;
-						/* Synchronize offline with */
-						/*  GP pre-initialization. */
 };
 
 /* Values for rcu_state structure's gp_flags field. */
