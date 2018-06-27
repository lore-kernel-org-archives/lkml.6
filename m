Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC65C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C450E26061
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:51:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C450E26061
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754848AbeF0PvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 11:51:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34418 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751177AbeF0PvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 11:51:15 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5RFjji3073712
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 11:51:14 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2jvb5wy8b8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 11:51:14 -0400
Received: from localhost
        by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <paulmck@linux.vnet.ibm.com>;
        Wed, 27 Jun 2018 11:51:13 -0400
Received: from b01cxnp23034.gho.pok.ibm.com (9.57.198.29)
        by e12.ny.us.ibm.com (146.89.104.199) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 27 Jun 2018 11:51:09 -0400
Received: from b01ledav003.gho.pok.ibm.com (b01ledav003.gho.pok.ibm.com [9.57.199.108])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w5RFp8SJ10879470
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 Jun 2018 15:51:08 GMT
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E97DDB206B;
        Wed, 27 Jun 2018 11:51:00 -0400 (EDT)
Received: from b01ledav003.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B1042B2065;
        Wed, 27 Jun 2018 11:51:00 -0400 (EDT)
Received: from paulmck-ThinkPad-W541 (unknown [9.70.82.159])
        by b01ledav003.gho.pok.ibm.com (Postfix) with ESMTP;
        Wed, 27 Jun 2018 11:51:00 -0400 (EDT)
Received: by paulmck-ThinkPad-W541 (Postfix, from userid 1000)
        id 3D9CB16C5EC2; Wed, 27 Jun 2018 08:53:15 -0700 (PDT)
Date:   Wed, 27 Jun 2018 08:53:15 -0700
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
 <20180627091106.GB7184@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627091106.GB7184@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18062715-0060-0000-0000-000002834DEE
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009264; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000266; SDB=6.01053123; UDB=6.00539941; IPR=6.00831046;
 MB=3.00021883; MTD=3.00000008; XFM=3.00000015; UTC=2018-06-27 15:51:13
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18062715-0061-0000-0000-00004598386B
Message-Id: <20180627155315.GY3593@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-27_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806270170
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

Agreed.  I decided that the extra lock acquisition was OK on similar
grounds.  Though that could be improved...

> The extra argument isn't really pretty but not nearly as bad as feared.

The patch is indeed quite a bit larger.

And note that the penalty for a typo in one of those rcu_report_qs_rnp()
arguments is an intermittent grace-period hang that can be quite unpretty
to track down...

							Thanx, Paul

> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 7832dd556490..d4c38d8d3621 100644
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
> @@ -160,7 +159,8 @@ static int rcu_scheduler_fully_active __read_mostly;
> 
>  static void
>  rcu_report_qs_rnp(unsigned long mask, struct rcu_state *rsp,
> -		  struct rcu_node *rnp, unsigned long gps, unsigned long flags);
> +		  struct rcu_node *rnp, unsigned long gps,
> +		  unsigned long flags, bool no_wakeup);
>  static void rcu_init_new_rnp(struct rcu_node *rnp_leaf);
>  static void rcu_cleanup_dead_rnp(struct rcu_node *rnp_leaf);
>  static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp, int outgoingcpu);
> @@ -1928,13 +1928,11 @@ static bool rcu_gp_init(struct rcu_state *rsp)
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
> @@ -1970,7 +1968,6 @@ static bool rcu_gp_init(struct rcu_state *rsp)
>  		}
> 
>  		raw_spin_unlock_irq_rcu_node(rnp);
> -		spin_unlock(&rsp->ofl_lock);
>  	}
>  	rcu_gp_slow(rsp, gp_preinit_delay); /* Races with CPU hotplug. */
> 
> @@ -2004,7 +2001,7 @@ static bool rcu_gp_init(struct rcu_state *rsp)
>  		mask = rnp->qsmask & ~rnp->qsmaskinitnext;
>  		rnp->rcu_gp_init_mask = mask;
>  		if ((mask || rnp->wait_blkd_tasks) && rcu_is_leaf_node(rnp))
> -			rcu_report_qs_rnp(mask, rsp, rnp, rnp->gp_seq, flags);
> +			rcu_report_qs_rnp(mask, rsp, rnp, rnp->gp_seq, flags, false);
>  		else
>  			raw_spin_unlock_irq_rcu_node(rnp);
>  		cond_resched_tasks_rcu_qs();
> @@ -2247,14 +2244,17 @@ static int __noreturn rcu_gp_kthread(void *arg)
>   * just-completed grace period.  Note that the caller must hold rnp->lock,
>   * which is released before return.
>   */
> -static void rcu_report_qs_rsp(struct rcu_state *rsp, unsigned long flags)
> +static void rcu_report_qs_rsp(struct rcu_state *rsp, unsigned long flags,
> +			      bool no_wakeup)
>  	__releases(rcu_get_root(rsp)->lock)
>  {
>  	raw_lockdep_assert_held_rcu_node(rcu_get_root(rsp));
>  	WARN_ON_ONCE(!rcu_gp_in_progress(rsp));
>  	WRITE_ONCE(rsp->gp_flags, READ_ONCE(rsp->gp_flags) | RCU_GP_FLAG_FQS);
>  	raw_spin_unlock_irqrestore_rcu_node(rcu_get_root(rsp), flags);
> -	rcu_gp_kthread_wake(rsp);
> +
> +	if (!no_wakeup)
> +		rcu_gp_kthread_wake(rsp);
>  }
> 
>  /*
> @@ -2273,7 +2273,8 @@ static void rcu_report_qs_rsp(struct rcu_state *rsp, unsigned long flags)
>   */
>  static void
>  rcu_report_qs_rnp(unsigned long mask, struct rcu_state *rsp,
> -		  struct rcu_node *rnp, unsigned long gps, unsigned long flags)
> +		  struct rcu_node *rnp, unsigned long gps,
> +		  unsigned long flags, bool no_wakeup)
>  	__releases(rnp->lock)
>  {
>  	unsigned long oldmask = 0;
> @@ -2326,7 +2327,7 @@ rcu_report_qs_rnp(unsigned long mask, struct rcu_state *rsp,
>  	 * state for this grace period.  Invoke rcu_report_qs_rsp()
>  	 * to clean up and start the next grace period if one is needed.
>  	 */
> -	rcu_report_qs_rsp(rsp, flags); /* releases rnp->lock. */
> +	rcu_report_qs_rsp(rsp, flags, no_wakeup); /* releases rnp->lock. */
>  }
> 
>  /*
> @@ -2361,7 +2362,7 @@ rcu_report_unblock_qs_rnp(struct rcu_state *rsp,
>  		 * Only one rcu_node structure in the tree, so don't
>  		 * try to report up to its nonexistent parent!
>  		 */
> -		rcu_report_qs_rsp(rsp, flags);
> +		rcu_report_qs_rsp(rsp, flags, false);
>  		return;
>  	}
> 
> @@ -2370,7 +2371,7 @@ rcu_report_unblock_qs_rnp(struct rcu_state *rsp,
>  	mask = rnp->grpmask;
>  	raw_spin_unlock_rcu_node(rnp);	/* irqs remain disabled. */
>  	raw_spin_lock_rcu_node(rnp_p);	/* irqs already disabled. */
> -	rcu_report_qs_rnp(mask, rsp, rnp_p, gps, flags);
> +	rcu_report_qs_rnp(mask, rsp, rnp_p, gps, flags, false);
>  }
> 
>  /*
> @@ -2413,7 +2414,7 @@ rcu_report_qs_rdp(int cpu, struct rcu_state *rsp, struct rcu_data *rdp)
>  		 */
>  		needwake = rcu_accelerate_cbs(rsp, rnp, rdp);
> 
> -		rcu_report_qs_rnp(mask, rsp, rnp, rnp->gp_seq, flags);
> +		rcu_report_qs_rnp(mask, rsp, rnp, rnp->gp_seq, flags, false);
>  		/* ^^^ Released rnp->lock */
>  		if (needwake)
>  			rcu_gp_kthread_wake(rsp);
> @@ -2711,7 +2712,7 @@ static void force_qs_rnp(struct rcu_state *rsp, int (*f)(struct rcu_data *rsp))
>  		}
>  		if (mask != 0) {
>  			/* Idle/offline CPUs, report (releases rnp->lock). */
> -			rcu_report_qs_rnp(mask, rsp, rnp, rnp->gp_seq, flags);
> +			rcu_report_qs_rnp(mask, rsp, rnp, rnp->gp_seq, flags, false);
>  		} else {
>  			/* Nothing to do here, so just drop the lock. */
>  			raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> @@ -3745,7 +3746,7 @@ void rcu_cpu_starting(unsigned int cpu)
>  		rdp->rcu_onl_gp_flags = READ_ONCE(rsp->gp_flags);
>  		if (rnp->qsmask & mask) { /* RCU waiting on incoming CPU? */
>  			/* Report QS -after- changing ->qsmaskinitnext! */
> -			rcu_report_qs_rnp(mask, rsp, rnp, rnp->gp_seq, flags);
> +			rcu_report_qs_rnp(mask, rsp, rnp, rnp->gp_seq, flags, false);
>  		} else {
>  			raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
>  		}
> @@ -3768,18 +3769,15 @@ static void rcu_cleanup_dying_idle_cpu(int cpu, struct rcu_state *rsp)
> 
>  	/* Remove outgoing CPU from mask in the leaf rcu_node structure. */
>  	mask = rdp->grpmask;
> -	spin_lock(&rsp->ofl_lock);
>  	raw_spin_lock_irqsave_rcu_node(rnp, flags); /* Enforce GP memory-order guarantee. */
>  	rdp->rcu_ofl_gp_seq = READ_ONCE(rsp->gp_seq);
>  	rdp->rcu_ofl_gp_flags = READ_ONCE(rsp->gp_flags);
> +	rnp->qsmaskinitnext &= ~mask;
>  	if (rnp->qsmask & mask) { /* RCU waiting on outgoing CPU? */
> -		/* Report quiescent state -before- changing ->qsmaskinitnext! */
> -		rcu_report_qs_rnp(mask, rsp, rnp, rnp->gp_seq, flags);
> +		rcu_report_qs_rnp(mask, rsp, rnp, rnp->gp_seq, flags, true);
>  		raw_spin_lock_irqsave_rcu_node(rnp, flags);
>  	}
> -	rnp->qsmaskinitnext &= ~mask;
>  	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> -	spin_unlock(&rsp->ofl_lock);
>  }
> 
>  /*
> @@ -3849,6 +3847,12 @@ void rcutree_migrate_callbacks(int cpu)
>  {
>  	struct rcu_state *rsp;
> 
> +	/*
> +	 * Just in case the outgoing CPU needed to wake the GP kthread
> +	 * do so here.
> +	 */
> +	rcu_gp_kthread_wake(rsp);
> +
>  	for_each_rcu_flavor(rsp)
>  		rcu_migrate_callbacks(cpu, rsp);
>  }
> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
> index 4e74df768c57..8dab71838141 100644
> --- a/kernel/rcu/tree.h
> +++ b/kernel/rcu/tree.h
> @@ -367,10 +367,6 @@ struct rcu_state {
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

