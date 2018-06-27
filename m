Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7014DC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0923D22B27
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:41:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0923D22B27
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754795AbeF0PlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 11:41:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46714 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752937AbeF0PlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 11:41:19 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5RFdktf068964
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 11:41:19 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jvafusq8n-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 11:41:19 -0400
Received: from localhost
        by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 27 Jun 2018 11:41:17 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (9.57.198.26)
        by e11.ny.us.ibm.com (146.89.104.198) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 27 Jun 2018 11:41:12 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp22036.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5RFfBAk53411976
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 Jun 2018 15:41:11 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 87714B2066;
        Wed, 27 Jun 2018 11:41:03 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4C7F8B205F;
        Wed, 27 Jun 2018 11:41:03 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 27 Jun 2018 11:41:03 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id C9F1C16C3F79; Wed, 27 Jun 2018 08:43:17 -0700 (PDT)
Date:   Wed, 27 Jun 2018 08:43:17 -0700
From:   "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel@joelfernandes.org
Subject: Re: [PATCH tip/core/rcu 13/22] rcu: Fix grace-period hangs due to
 race with CPU offline
Reply-To: paulmck@linux.vnet.ibm.com
References: <20180626002052.GA24146@linux.vnet.ibm.com>
 <20180626171048.2181-13-paulmck@linux.vnet.ibm.com>
 <20180626175119.GL2494@hirez.programming.kicks-ass.net>
 <20180626182950.GH3593@linux.vnet.ibm.com>
 <20180626202615.GA32162@linux.vnet.ibm.com>
 <20180626203225.GT2494@hirez.programming.kicks-ass.net>
 <20180626234004.GQ3593@linux.vnet.ibm.com>
 <20180627083335.GA7184@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627083335.GA7184@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18062715-2213-0000-0000-000002C0C583
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009264; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01053119; UDB=6.00539939; IPR=6.00831043;
 MB=3.00021883; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-27 15:41:16
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062715-2214-0000-0000-00005AA0959B
Message-Id: <20180627154317.GX3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-27_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806270169
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 10:33:35AM +0200, Peter Zijlstra wrote:
> On Tue, Jun 26, 2018 at 04:40:04PM -0700, Paul E. McKenney wrote:
> > The options I have considered are as follows:
> > 
> > 1.	Stick with the no-failsafe approach, adding the lock as shown
> > 	in this patch.  (I obviously prefer this approach.)
> > 
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
> You can combine 2 and 3. Use a skip wakeup flag and ignore the return
> value most times. Let me do that just to see how horrible it is.
> 
> > 
> > 4.	Re-introduce the old fail-safe code, and don't report the
> > 	quiescent state at CPU-offline time, relying on the fail-safe
> > 	code to do so.	This also potentially introduces delays and can
> > 	add extra FQS scans, which in turn increases lock contention.
> > 
> > So what did you have in mind?
> 
> The thing I talked about last night before crashing is the patch below;
> it does however suffer from a little false-negative, much like the one
> you explained earlier. It allows @qsmaskinit to retain the bit set after
> offline.
> 
> I had hoped to be able to clear @qsmaskinit unconditionally, but that
> doesn't quite work.

Yes, unless you are insanely careful (and possess an unusual tolerance for
complexity), you will end up with inconsistent ->qsmask fields, which will
get you too-short grace periods, grace-period hangs, or maybe even both.

For one thing, whatever code sets/clears a leaf rcu_node structure's
->qsmaskinit must propagate that change up the tree.  If that code is
not grace-period initialization, then that code must somehow synchronize
correctly with grace-period initialization.  For example, by introducing
a lock.  ;-)

> The other approach is yet another mask @qsmaskofflinenext which the
> kthread will use to clear bits on @qsmaskinitnext.

And here I thought that my current use of only three such masks was
getting a bit ornate.  ;-)

> In any case, aside from the above, the below contains a bunch of missing
> WRITE_ONCE()s. Since you read the various @qsmask variables using
> READ_ONCE() you must also consistently update them using WRITE_ONCE(),
> otherwise it's all still buggered.

And I introduced those READ_ONCE() calls an embarrassingly long time ago,
didn't I?  But yes, any update needs to use WRITE_ONCE().  I will put
together a patch with your Reported-by.  No, wait, I guess I start with
pieces of your patch below.  To that end, may I have your Signed-off-by
for the WRITE_ONCE() pieces?

> ---
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 7832dd556490..8713048d5103 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -104,7 +104,6 @@ struct rcu_state sname##_state = { \
>  	.abbr = sabbr, \
>  	.exp_mutex = __MUTEX_INITIALIZER(sname##_state.exp_mutex), \
>  	.exp_wake_mutex = __MUTEX_INITIALIZER(sname##_state.exp_wake_mutex), \
> -	.ofl_lock = __SPIN_LOCK_UNLOCKED(sname##_state.ofl_lock), \
>  }
> 
>  RCU_STATE_INITIALIZER(rcu_sched, 's', call_rcu_sched);
> @@ -209,7 +208,12 @@ EXPORT_SYMBOL_GPL(rcu_get_gp_kthreads_prio);
>   */
>  unsigned long rcu_rnp_online_cpus(struct rcu_node *rnp)
>  {
> -	return READ_ONCE(rnp->qsmaskinitnext);
> +	/*
> +	 * For both online and offline we first set/clear @qsmaskinitnext,
> +	 * and complete by propagating into @qsmaskinit. As long as the bit
> +	 * remains in either mask, RCU is still online.
> +	 */
> +	return READ_ONCE(rnp->qsmaskinit) | READ_ONCE(rnp->qsmaskinitnext);
>  }
> 
>  /*
> @@ -1928,19 +1932,17 @@ static bool rcu_gp_init(struct rcu_state *rsp)
>  	 */
>  	rsp->gp_state = RCU_GP_ONOFF;
>  	rcu_for_each_leaf_node(rsp, rnp) {
> -		spin_lock(&rsp->ofl_lock);
>  		raw_spin_lock_irq_rcu_node(rnp);
>  		if (rnp->qsmaskinit == rnp->qsmaskinitnext &&
>  		    !rnp->wait_blkd_tasks) {
>  			/* Nothing to do on this leaf rcu_node structure. */
>  			raw_spin_unlock_irq_rcu_node(rnp);
> -			spin_unlock(&rsp->ofl_lock);
>  			continue;
>  		}
> 
>  		/* Record old state, apply changes to ->qsmaskinit field. */
>  		oldmask = rnp->qsmaskinit;
> -		rnp->qsmaskinit = rnp->qsmaskinitnext;
> +		WRITE_ONCE(rnp->qsmaskinit, rnp->qsmaskinitnext);
> 
>  		/* If zero-ness of ->qsmaskinit changed, propagate up tree. */
>  		if (!oldmask != !rnp->qsmaskinit) {
> @@ -1970,7 +1972,6 @@ static bool rcu_gp_init(struct rcu_state *rsp)
>  		}
> 
>  		raw_spin_unlock_irq_rcu_node(rnp);
> -		spin_unlock(&rsp->ofl_lock);
>  	}
>  	rcu_gp_slow(rsp, gp_preinit_delay); /* Races with CPU hotplug. */
> 
> @@ -1992,7 +1993,7 @@ static bool rcu_gp_init(struct rcu_state *rsp)
>  		raw_spin_lock_irqsave_rcu_node(rnp, flags);
>  		rdp = this_cpu_ptr(rsp->rda);
>  		rcu_preempt_check_blocked_tasks(rsp, rnp);
> -		rnp->qsmask = rnp->qsmaskinit;
> +		WRITE_ONCE(rnp->qsmask, rnp->qsmaskinit);
>  		WRITE_ONCE(rnp->gp_seq, rsp->gp_seq);
>  		if (rnp == rdp->mynode)
>  			(void)__note_gp_changes(rsp, rnp, rdp);
> @@ -2295,7 +2296,7 @@ rcu_report_qs_rnp(unsigned long mask, struct rcu_state *rsp,
>  		WARN_ON_ONCE(oldmask); /* Any child must be all zeroed! */
>  		WARN_ON_ONCE(!rcu_is_leaf_node(rnp) &&
>  			     rcu_preempt_blocked_readers_cgp(rnp));
> -		rnp->qsmask &= ~mask;
> +		WRITE_ONCE(rnp->qsmask, rnp->qsmask & ~mask);
>  		trace_rcu_quiescent_state_report(rsp->name, rnp->gp_seq,
>  						 mask, rnp->qsmask, rnp->level,
>  						 rnp->grplo, rnp->grphi,
> @@ -2503,7 +2504,7 @@ static void rcu_cleanup_dead_rnp(struct rcu_node *rnp_leaf)
>  		if (!rnp)
>  			break;
>  		raw_spin_lock_rcu_node(rnp); /* irqs already disabled. */
> -		rnp->qsmaskinit &= ~mask;
> +		WRITE_ONCE(rnp->qsmaskinit, rnp->qsmaskinit & ~mask);
>  		/* Between grace periods, so better already be zero! */
>  		WARN_ON_ONCE(rnp->qsmask);
>  		if (rnp->qsmaskinit) {
> @@ -3522,7 +3523,7 @@ static void rcu_init_new_rnp(struct rcu_node *rnp_leaf)
>  			return;
>  		raw_spin_lock_rcu_node(rnp); /* Interrupts already disabled. */
>  		oldmask = rnp->qsmaskinit;
> -		rnp->qsmaskinit |= mask;
> +		WRITE_ONCE(rnp->qsmaskinit, rnp->qsmaskinit | mask);
>  		raw_spin_unlock_rcu_node(rnp); /* Interrupts remain disabled. */
>  		if (oldmask)
>  			return;
> @@ -3733,7 +3734,7 @@ void rcu_cpu_starting(unsigned int cpu)
>  		rnp = rdp->mynode;
>  		mask = rdp->grpmask;
>  		raw_spin_lock_irqsave_rcu_node(rnp, flags);
> -		rnp->qsmaskinitnext |= mask;
> +		WRITE_ONCE(rnp->qsmaskinitnext, rnp->qsmaskinitnext | mask);
>  		oldmask = rnp->expmaskinitnext;
>  		rnp->expmaskinitnext |= mask;
>  		oldmask ^= rnp->expmaskinitnext;
> @@ -3768,18 +3769,36 @@ static void rcu_cleanup_dying_idle_cpu(int cpu, struct rcu_state *rsp)
> 
>  	/* Remove outgoing CPU from mask in the leaf rcu_node structure. */
>  	mask = rdp->grpmask;
> -	spin_lock(&rsp->ofl_lock);
>  	raw_spin_lock_irqsave_rcu_node(rnp, flags); /* Enforce GP memory-order guarantee. */
>  	rdp->rcu_ofl_gp_seq = READ_ONCE(rsp->gp_seq);
>  	rdp->rcu_ofl_gp_flags = READ_ONCE(rsp->gp_flags);
> +
> +	/*
> +	 * First clear @qsmaskinitnext such that we'll not start a new GP
> +	 * on this outgoing CPU.
> +	 */
> +	WRITE_ONCE(rnp->qsmaskinitnext, rnp->qsmaskinitnext & ~mask);
>  	if (rnp->qsmask & mask) { /* RCU waiting on outgoing CPU? */
> -		/* Report quiescent state -before- changing ->qsmaskinitnext! */
> +		/*
> +		 * Report the QS on the outgoing CPU. This will propagate the
> +		 * cleared bit into @qsmaskinit and @qsmask. We rely on
> +		 * @qsmaskinit still containing this CPU such that
> +		 * rcu_rnp_online_cpus() will still consider RCU online.
> +		 *
> +		 * This allows us to wake the GP kthread, since wakeups rely on
> +		 * RCU.
> +		 */
> +		WARN_ON_ONCE(!(rnp->qsmaskinit & mask));
>  		rcu_report_qs_rnp(mask, rsp, rnp, rnp->gp_seq, flags);
>  		raw_spin_lock_irqsave_rcu_node(rnp, flags);
> +	} else {
> +		/*
> +		 * If there was no QS required, clear @qsmaskinit now to
> +		 * finalize the offline.
> +		 */
> +		WRITE_ONCE(rnp->qsmaskinit, rnp->qsmaskinit & ~mask);
>  	}
> -	rnp->qsmaskinitnext &= ~mask;
>  	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> -	spin_unlock(&rsp->ofl_lock);
>  }
> 
>  /*
> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> index 4e74df768c57..a1528b970257 100644
> --- a/kernel/rcu/tree.h
> +++ b/kernel/rcu/tree.h
> @@ -84,19 +84,24 @@ struct rcu_node {
>  	unsigned long gp_seq;	/* Track rsp->rcu_gp_seq. */
>  	unsigned long gp_seq_needed; /* Track rsp->rcu_gp_seq_needed. */
>  	unsigned long completedqs; /* All QSes done for this node. */
> -	unsigned long qsmask;	/* CPUs or groups that need to switch in */
> -				/*  order for current grace period to proceed.*/
> -				/*  In leaf rcu_node, each bit corresponds to */
> -				/*  an rcu_data structure, otherwise, each */
> -				/*  bit corresponds to a child rcu_node */
> -				/*  structure. */
> -	unsigned long rcu_gp_init_mask;	/* Mask of offline CPUs at GP init. */
> +
> +	/*
> +	 * @qsmask		- CPUs pending in this GP

Huh.  I wasn't aware that docbook/sphinx/whatever knew about this
style of documentation.  I will have to check that out in the fulness
of time...

> +	 * @qsmaskinit		- CPUs we started this GP with

				- CPUs online at the last GP start

> +	 * @qsmaskinitnext	- CPUs we'll start the next GP with

Only if that GP were to start immediately, of course.

Note that if CPU 0 and CPU 88 come online in that order, it is quite
possible that there will be a grace period that waits on CPU 88 but
not CPU 0.  This would happen if CPU 0's rcu_node structure checked
->qsmaskinitnext, CPU 0 came online, CPU 88 came online, and then CPU 88's
rcu_node structure checked ->qsmaskinitnext. 

So the order in which CPUs come online and go offline is not necessarily
the order in which successive grace periods start/stop paying attention
to them.

							Thanx, Paul

> +	 *
> +	 * online: we add the incoming CPU to @qsmaskinitnext which will then
> +	 * be propagated into @qsmaskinit and @qsmask by starting/joining a GP.
> +	 *
> +	 * offline: we remove the CPU from @qsmaskinitnext such that the
> +	 * outgoing CPU will not be part of a next GP, which will then be
> +	 * propagated into @qsmaskinit and @qsmask by completing/leaving a GP.
> +	 */
> +	unsigned long qsmask;
>  	unsigned long qsmaskinit;
> -				/* Per-GP initial value for qsmask. */
> -				/*  Initialized from ->qsmaskinitnext at the */
> -				/*  beginning of each grace period. */
>  	unsigned long qsmaskinitnext;
> -				/* Online CPUs for next grace period. */
> +
> +	unsigned long rcu_gp_init_mask;	/* Mask of offline CPUs at GP init. */
>  	unsigned long expmask;	/* CPUs or groups that need to check in */
>  				/*  to allow the current expedited GP */
>  				/*  to complete. */
> @@ -367,10 +372,6 @@ struct rcu_state {
>  	const char *name;			/* Name of structure. */
>  	char abbr;				/* Abbreviated name. */
>  	struct list_head flavors;		/* List of RCU flavors. */
> -
> -	spinlock_t ofl_lock ____cacheline_internodealigned_in_smp;
> -						/* Synchronize offline with */
> -						/*  GP pre-initialization. */
>  };
> 
>  /* Values for rcu_state structure's gp_flags field. */
> 

