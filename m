Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCF38C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 09:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6049A26099
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 09:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vAss56/M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6049A26099
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753601AbeF0Jq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 05:46:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39268 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753091AbeF0Jq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 05:46:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=e/pUx4Dq22b3SlcgKFg43Y7PGf9g5mMSLFh+8lC/kok=; b=vAss56/MoFjaP+U5ts7wkKHYr
        TzStP5q2Em/KdmfdZbxrbIvIKnhGroekJPLw/6RML4q7kJ69VO4fLmXsVUKe1Ca1cuHrU9HejqVhl
        BGnysN0Uat2tOMji0Qtx60ScUyoGeaHuCfmeE/WRdE1qQpHsNeFgEFPf96wQ960hCbzd0wdAZ/v+y
        r0uyk65e6jXql2x0UkZcEwTLk/2wG7CPSDl/r8ucGdy6tuxuppizAtSKh0coazqIjpk52EekTMrMW
        knfuGzK+ZWFvchpWkAlp0V0UkXRAt4QNI/i+hBIixUNQ7fTtwTL//lH+93HhtCMgCA5LEvSMGgzAK
        bWP4664Kw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fY724-00062a-Gc; Wed, 27 Jun 2018 09:46:36 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A15512029F1D5; Wed, 27 Jun 2018 11:46:33 +0200 (CEST)
Date:   Wed, 27 Jun 2018 11:46:33 +0200
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
Message-ID: <20180627094633.GG2512@hirez.programming.kicks-ass.net>
References: <20180626002052.GA24146@linux.vnet.ibm.com>
 <20180626171048.2181-13-paulmck@linux.vnet.ibm.com>
 <20180626175119.GL2494@hirez.programming.kicks-ass.net>
 <20180626182950.GH3593@linux.vnet.ibm.com>
 <20180626202615.GA32162@linux.vnet.ibm.com>
 <20180626203225.GT2494@hirez.programming.kicks-ass.net>
 <20180626234004.GQ3593@linux.vnet.ibm.com>
 <20180627091106.GB7184@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627091106.GB7184@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 11:11:06AM +0200, Peter Zijlstra wrote:
> On Tue, Jun 26, 2018 at 04:40:04PM -0700, Paul E. McKenney wrote:
> > The options I have considered are as follows:
> 
> > 2.	Stick with the no-failsafe approach, but rely on RCU's grace-period
> > 	kthread to wake up later due to its timed wait during the
> > 	force-quiescent-state process.  This would be a bit obnoxious,
> > 	as it requires passing a don't-wake flag (or some such) up the
> > 	quiescent-state reporting mechanism.  It would also needlessly
> > 	delay grace-period ends, especially on large systems (RCU scales
> > 	up the FQS delay on larger systems to maintain limited CPU
> > 	consumption per unit time).
> > 
> > 3.	Stick with the no-failsafe approach, but have the quiescent-state
> > 	reporting code hand back a value indicating that a wakeup is needed.
> > 	Also a bit obnoxious, as this value would need to be threaded up
> > 	the reporting code's return path.  Simple in theory, but a bit
> > 	of an ugly change, especially for the many places in the code that
> > 	currently expect quiescent-state reporting to be an unconditional
> > 	fire-and-forget operation.
> 
> Here's a variant on 2+3, instead of propagating the state back, we
> completely ignore if we needed a wakeup or not, and then unconditionally
> wake the GP kthread on the managing CPU's rcutree_migrate_callbacks()
> invocation.
> 
> Hotplug is rare (or should damn well be), doing a spurious wake of the
> GP thread shouldn't matter here.

Another variant, which simply skips the wakeup whever ran on an offline
CPU, relying on the wakeup from rcutree_migrate_callbacks() right after
the CPU really is dead.

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 7832dd556490..417496a03259 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -104,7 +104,6 @@ struct rcu_state sname##_state = { \
 	.abbr = sabbr, \
 	.exp_mutex = __MUTEX_INITIALIZER(sname##_state.exp_mutex), \
 	.exp_wake_mutex = __MUTEX_INITIALIZER(sname##_state.exp_wake_mutex), \
-	.ofl_lock = __SPIN_LOCK_UNLOCKED(sname##_state.ofl_lock), \
 }
 
 RCU_STATE_INITIALIZER(rcu_sched, 's', call_rcu_sched);
@@ -1928,13 +1927,11 @@ static bool rcu_gp_init(struct rcu_state *rsp)
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
 
@@ -1970,7 +1967,6 @@ static bool rcu_gp_init(struct rcu_state *rsp)
 		}
 
 		raw_spin_unlock_irq_rcu_node(rnp);
-		spin_unlock(&rsp->ofl_lock);
 	}
 	rcu_gp_slow(rsp, gp_preinit_delay); /* Races with CPU hotplug. */
 
@@ -2250,11 +2246,19 @@ static int __noreturn rcu_gp_kthread(void *arg)
 static void rcu_report_qs_rsp(struct rcu_state *rsp, unsigned long flags)
 	__releases(rcu_get_root(rsp)->lock)
 {
+	int cpu = smp_processor_id();
+
 	raw_lockdep_assert_held_rcu_node(rcu_get_root(rsp));
 	WARN_ON_ONCE(!rcu_gp_in_progress(rsp));
 	WRITE_ONCE(rsp->gp_flags, READ_ONCE(rsp->gp_flags) | RCU_GP_FLAG_FQS);
 	raw_spin_unlock_irqrestore_rcu_node(rcu_get_root(rsp), flags);
-	rcu_gp_kthread_wake(rsp);
+
+	/*
+	 * When our @cpu is offline, we'll get a wakeup from
+	 * rcutree_migrate_callbacks.
+	 */
+	if (cpu_online(cpu))
+		rcu_gp_kthread_wake(rsp);
 }
 
 /*
@@ -3768,18 +3772,15 @@ static void rcu_cleanup_dying_idle_cpu(int cpu, struct rcu_state *rsp)
 
 	/* Remove outgoing CPU from mask in the leaf rcu_node structure. */
 	mask = rdp->grpmask;
-	spin_lock(&rsp->ofl_lock);
 	raw_spin_lock_irqsave_rcu_node(rnp, flags); /* Enforce GP memory-order guarantee. */
 	rdp->rcu_ofl_gp_seq = READ_ONCE(rsp->gp_seq);
 	rdp->rcu_ofl_gp_flags = READ_ONCE(rsp->gp_flags);
+	rnp->qsmaskinitnext &= ~mask;
 	if (rnp->qsmask & mask) { /* RCU waiting on outgoing CPU? */
-		/* Report quiescent state -before- changing ->qsmaskinitnext! */
 		rcu_report_qs_rnp(mask, rsp, rnp, rnp->gp_seq, flags);
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
 	}
-	rnp->qsmaskinitnext &= ~mask;
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
-	spin_unlock(&rsp->ofl_lock);
 }
 
 /*
@@ -3849,6 +3850,12 @@ void rcutree_migrate_callbacks(int cpu)
 {
 	struct rcu_state *rsp;
 
+	/*
+	 * Just in case the outgoing CPU needed to wake the GP kthread
+	 * do so here.
+	 */
+	rcu_gp_kthread_wake(rsp);
+
 	for_each_rcu_flavor(rsp)
 		rcu_migrate_callbacks(cpu, rsp);
 }
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 4e74df768c57..8dab71838141 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -367,10 +367,6 @@ struct rcu_state {
 	const char *name;			/* Name of structure. */
 	char abbr;				/* Abbreviated name. */
 	struct list_head flavors;		/* List of RCU flavors. */
-
-	spinlock_t ofl_lock ____cacheline_internodealigned_in_smp;
-						/* Synchronize offline with */
-						/*  GP pre-initialization. */
 };
 
 /* Values for rcu_state structure's gp_flags field. */
