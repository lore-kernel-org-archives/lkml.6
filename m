Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754957AbeCHSB3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 13:01:29 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:35742 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752168AbeCHSB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 13:01:27 -0500
Date: Thu, 8 Mar 2018 10:01:56 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Byungchul Park <byungchul.park@lge.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, jiangshanlai@gmail.com,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
        kernel-team@lge.com
Subject: Re: [RFC] rcu: Prevent expedite reporting within RCU read-side
 section
Reply-To: paulmck@linux.vnet.ibm.com
References: <1520314318-30916-1-git-send-email-byungchul.park@lge.com>
 <20180306134205.lwmn3cgisnwkngcf@tardis>
 <908c33f9-c8ed-5d4e-91cb-a123de5dbbc7@lge.com>
 <a2e0a9c5-4246-d3b9-2eb7-9bdd87aef636@lge.com>
 <20180307150343.GD3918@linux.vnet.ibm.com>
 <20180308100825.GA32165@X58A-UD3R>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180308100825.GA32165@X58A-UD3R>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-TM-AS-GCONF: 00
x-cbid: 18030818-0048-0000-0000-00000246F38D
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00008636; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000254; SDB=6.01000142; UDB=6.00508700; IPR=6.00779472;
 MB=3.00019919; MTD=3.00000008; XFM=3.00000015; UTC=2018-03-08 18:01:23
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030818-0049-0000-0000-000044602A2F
Message-Id: <20180308180156.GQ3918@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-08_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803080204
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 08, 2018 at 07:08:25PM +0900, Byungchul Park wrote:
> On Wed, Mar 07, 2018 at 07:03:43AM -0800, Paul E. McKenney wrote:
> > On Wed, Mar 07, 2018 at 03:25:36PM +0900, Byungchul Park wrote:
> > > On 3/7/2018 2:55 PM, Byungchul Park wrote:
> > > >On 3/6/2018 10:42 PM, Boqun Feng wrote:
> > > >>On Tue, Mar 06, 2018 at 02:31:58PM +0900, Byungchul Park wrote:
> > > >>>Hello Paul and RCU folks,
> > > >>>
> > > >>>I am afraid I correctly understand and fix it. But I really wonder why
> > > >>>sync_rcu_exp_handler() reports the quiescent state even in the case that
> > > >>>current task is within a RCU read-side section. Do I miss something?
> > > >>>
> > > >>>If I correctly understand it and you agree with it, I can add more logic
> > > >>>which make it more expedited by boosting current or making it urgent
> > > >>>when we fail to report the quiescent state on the IPI.
> > > >>>
> > > >>>----->8-----
> > > >>> From 0b0191f506c19ce331a1fdb7c2c5a00fb23fbcf2 Mon Sep 17 00:00:00 2001
> > > >>>From: Byungchul Park <byungchul.park@lge.com>
> > > >>>Date: Tue, 6 Mar 2018 13:54:41 +0900
> > > >>>Subject: [RFC] rcu: Prevent expedite reporting within RCU
> > > >>>read-side section
> > > >>>
> > > >>>We report the quiescent state for this cpu if it's out of RCU read-side
> > > >>>section at the moment IPI was just fired during the expedite process.
> > > >>>
> > > >>>However, current code reports the quiescent state even in the case:
> > > >>>
> > > >>>    1) the current task is still within a RCU read-side section
> > > >>>    2) the current task has been blocked within the RCU
> > > >>>read-side section
> > > >>>
> > > >>
> > > >>If this happens, the task will queue itself in
> > > >>rcu_preempt_note_context_switch() using rcu_preempt_ctxt_queue(). The gp
> > > >>kthread will wait for this task to dequeue itself. IOW, we have other
> > > >>mechanism to wait for this task other than bottom-up qs reporting tree.
> > > >>So I think we are fine here.
> > > >
> > > >Right. Basically we consider both the quiscent state within the current
> > > >task and queued tasks on rcu nodes that you mentioned, to control grace
> > > >periods when PREEMPT kernel is used.
> > > >
> > > >Actually my concern was if it's safe to clear the bit of 'expmask' on
> > > >the IPI for all possible cases, even though anyway blocked tasks would
> > > >try to prevent the grace period from ending.
> > > >
> > > >I worried if something subtle might cause problems, but the code looks
> > > >fine on second thought as you said. Thank you for your explanation.
> > > 
> > > In addition, by making quiescent states reported and bits of expmask
> > > cleared only when it's out of rcu read sections, of course keeping
> > > other mechanism unchanged like what you mentioned, I think we can avoid
> > > unnecessary locking ops and other statements, keeping the code still
> > > sane, even though the benefit might be small.
> > > 
> > > For example, by removing some evitable calls to rcu_report_cpu_mult()
> > > either directly or indirectly. I'm not sure if RCU maintainers think
> > > it's worthy tho.
> > 
> > You mean rcu_report_exp_cpu_mult()?  If so, which calls to this function
> > do you believe should be removed?
> > 
> > (Please note that there are likely to be changes in this area soon,
> > but still, I would like to understand what might be make more
> > efficient.)
> 
> Hello Paul,
> 
> I think there are two options to manage an expedite-gp when a current
> task is preempted within a RCU read section (with CONFIG_PREEMPT_RCU):
> 
>    1. Clear its bit of ->expmask even though it's within a RCU read
>       section and rely on ->exp_tasks to prevent the gp from ending.
> 
>       This option would work because we anyway check both ->exp_tasks
>       and ->expmask to finish the expedite-gp.

And this is indeed what is currently done.

>    2. Clear its bit of ->expmask *only* when it's out of RCU read
>       sections and keep others unchanged. So it will be cleared at the
>       end of the RCU read section in that case.
> 
>       This option would also work because we anyway check both
>       ->exp_tasks and ->expmask to finish the expedite-gp.

This could be made to work, but one shortcoming is that the grace
period would end up waiting on later read-side critical sections
that it does not really need to wait on.  Also, eventually all the
bits would clear, and they might clear before the last preempted
task resumed, so the race would still exist.

Or am I missing your point?

> Current code chose the 1st option and try to report the quiescent state
> using rcu_report_exp_rdp() when it's out of RCU read sections or the
> task is preempted, while an expedite-gp is in progress.
> 
> However, when reporting it within a RCU read section, the reporting
> hardly goes further since sync_rcu_preempt_exp_done() of course returns
> false, furthermore, it might add *unnecessary* lock contention of
> rcu_node's spin lock within rcu_report_exp_cpu_mult(). I think those are
> unnecessary at all even though there's no logical problem.

It would be possible to use ordering and memory barriers to avoid at
least some lock acquisitions, but the resulting code would be more
complex and fragile.  So I would want to see a real problem before
using a more aggressive design.

> Showing the patch reflecting the 2nd might be more helpful for you to
> understand what I'd like to do. Please take a look at the following
> patch. And it would be appriciated if you answer it. (In addition, we
> can do similar work to normal-gp but this time I worked it only with
> expedite-gp.)

Some questions and comments below.

> --
> Thanks,
> Byungchul
> 
> -----8<-----
> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> index 73e1d3d..08c2944 100644
> --- a/kernel/rcu/tree_exp.h
> +++ b/kernel/rcu/tree_exp.h
> @@ -716,28 +716,22 @@ static void sync_rcu_exp_handler(void *info)
>  	struct rcu_state *rsp = info;
>  	struct task_struct *t = current;
> 
> -	/*
> -	 * Within an RCU read-side critical section, request that the next
> -	 * rcu_read_unlock() report.  Unless this RCU read-side critical
> -	 * section has already blocked, in which case it is already set
> -	 * up for the expedited grace period to wait on it.
> -	 */
> -	if (t->rcu_read_lock_nesting > 0 &&
> -	    !t->rcu_read_unlock_special.b.blocked) {
> +	if (t->rcu_read_lock_nesting > 0) {
> +		/*
> +		 * Within an RCU read-side critical section, request that
> +		 * the next rcu_read_unlock() report.
> +		 */
>  		t->rcu_read_unlock_special.b.exp_need_qs = true;
> -		return;
> +	} else {
> +		/*
> +		 * We are either exiting an RCU read-side critical section
> +		 * (negative values of t->rcu_read_lock_nesting) or are not
> +		 * in one at all (zero value of t->rcu_read_lock_nesting).
> +		 * We can immediately report the quiescent state.
> +		 */
> +		rdp = this_cpu_ptr(rsp->rda);
> +		rcu_report_exp_rdp(rsp, rdp, true);
>  	}
> -
> -	/*
> -	 * We are either exiting an RCU read-side critical section (negative
> -	 * values of t->rcu_read_lock_nesting) or are not in one at all
> -	 * (zero value of t->rcu_read_lock_nesting).  Or we are in an RCU
> -	 * read-side critical section that blocked before this expedited
> -	 * grace period started.  Either way, we can immediately report
> -	 * the quiescent state.
> -	 */
> -	rdp = this_cpu_ptr(rsp->rda);
> -	rcu_report_exp_rdp(rsp, rdp, true);

This code is equivalent, correct?  All that happened is that a
"return" statement was replaced with an "else" clause.  Or am I
blind this morning?

>  }
> 
>  /**
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> index b0d7f9b..b303b63 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -269,20 +269,6 @@ static void rcu_preempt_ctxt_queue(struct rcu_node *rnp, struct rcu_data *rdp)
>  	WARN_ON_ONCE(!(blkd_state & RCU_EXP_BLKD) !=
>  		     !(rnp->expmask & rdp->grpmask));
>  	raw_spin_unlock_rcu_node(rnp); /* interrupts remain disabled. */
> -
> -	/*
> -	 * Report the quiescent state for the expedited GP.  This expedited
> -	 * GP should not be able to end until we report, so there should be
> -	 * no need to check for a subsequent expedited GP.  (Though we are
> -	 * still in a quiescent state in any case.)
> -	 */
> -	if (blkd_state & RCU_EXP_BLKD &&
> -	    t->rcu_read_unlock_special.b.exp_need_qs) {
> -		t->rcu_read_unlock_special.b.exp_need_qs = false;
> -		rcu_report_exp_rdp(rdp->rsp, rdp, true);
> -	} else {
> -		WARN_ON_ONCE(t->rcu_read_unlock_special.b.exp_need_qs);
> -	}

Again, this does not eliminate the race, from what I can see.  And it
can unnecessarily extend the expedited grace period.

>  }
> 
>  /*
> @@ -414,9 +400,7 @@ static bool rcu_preempt_has_tasks(struct rcu_node *rnp)
>   */
>  void rcu_read_unlock_special(struct task_struct *t)
>  {
> -	bool empty_exp;
>  	bool empty_norm;
> -	bool empty_exp_now;
>  	unsigned long flags;
>  	struct list_head *np;
>  	bool drop_boost_mutex = false;
> @@ -436,6 +420,7 @@ void rcu_read_unlock_special(struct task_struct *t)
>  	 * t->rcu_read_unlock_special cannot change.
>  	 */
>  	special = t->rcu_read_unlock_special;
> +
>  	if (special.b.need_qs) {
>  		rcu_preempt_qs();
>  		t->rcu_read_unlock_special.b.need_qs = false;
> @@ -445,39 +430,22 @@ void rcu_read_unlock_special(struct task_struct *t)
>  		}
>  	}
> 
> -	/*
> -	 * Respond to a request for an expedited grace period, but only if
> -	 * we were not preempted, meaning that we were running on the same
> -	 * CPU throughout.  If we were preempted, the exp_need_qs flag
> -	 * would have been cleared at the time of the first preemption,
> -	 * and the quiescent state would be reported when we were dequeued.
> -	 */
> -	if (special.b.exp_need_qs) {
> -		WARN_ON_ONCE(special.b.blocked);
> -		t->rcu_read_unlock_special.b.exp_need_qs = false;
> -		rdp = this_cpu_ptr(rcu_state_p->rda);
> -		rcu_report_exp_rdp(rcu_state_p, rdp, true);
> -		if (!t->rcu_read_unlock_special.s) {
> +	/* Clean up if blocked during RCU read-side critical section. */
> +	if (special.b.blocked) {
> +
> +		/* Hardware IRQ handlers cannot block, complain if they get here. */
> +		if (in_irq() || in_serving_softirq()) {
> +			lockdep_rcu_suspicious(__FILE__, __LINE__,
> +					"rcu_read_unlock() from irq or softirq with blocking in critical section!!!\n");
> +			pr_alert("->rcu_read_unlock_special: %#x (b: %d, enq: %d nq: %d)\n",
> +					t->rcu_read_unlock_special.s,
> +					t->rcu_read_unlock_special.b.blocked,
> +					t->rcu_read_unlock_special.b.exp_need_qs,
> +					t->rcu_read_unlock_special.b.need_qs);
>  			local_irq_restore(flags);
>  			return;
>  		}
> -	}
> 
> -	/* Hardware IRQ handlers cannot block, complain if they get here. */
> -	if (in_irq() || in_serving_softirq()) {
> -		lockdep_rcu_suspicious(__FILE__, __LINE__,
> -				       "rcu_read_unlock() from irq or softirq with blocking in critical section!!!\n");
> -		pr_alert("->rcu_read_unlock_special: %#x (b: %d, enq: %d nq: %d)\n",
> -			 t->rcu_read_unlock_special.s,
> -			 t->rcu_read_unlock_special.b.blocked,
> -			 t->rcu_read_unlock_special.b.exp_need_qs,
> -			 t->rcu_read_unlock_special.b.need_qs);
> -		local_irq_restore(flags);
> -		return;
> -	}
> -
> -	/* Clean up if blocked during RCU read-side critical section. */
> -	if (special.b.blocked) {
>  		t->rcu_read_unlock_special.b.blocked = false;
> 
>  		/*
> @@ -491,7 +459,6 @@ void rcu_read_unlock_special(struct task_struct *t)
>  		WARN_ON_ONCE(rnp != t->rcu_blocked_node);
>  		WARN_ON_ONCE(rnp->level != rcu_num_lvls - 1);
>  		empty_norm = !rcu_preempt_blocked_readers_cgp(rnp);
> -		empty_exp = sync_rcu_preempt_exp_done(rnp);
>  		smp_mb(); /* ensure expedited fastpath sees end of RCU c-s. */
>  		np = rcu_next_node_entry(t, rnp);
>  		list_del_init(&t->rcu_node_entry);
> @@ -515,7 +482,6 @@ void rcu_read_unlock_special(struct task_struct *t)
>  		 * Note that rcu_report_unblock_qs_rnp() releases rnp->lock,
>  		 * so we must take a snapshot of the expedited state.
>  		 */
> -		empty_exp_now = sync_rcu_preempt_exp_done(rnp);
>  		if (!empty_norm && !rcu_preempt_blocked_readers_cgp(rnp)) {
>  			trace_rcu_quiescent_state_report(TPS("preempt_rcu"),
>  							 rnp->gpnum,
> @@ -532,16 +498,18 @@ void rcu_read_unlock_special(struct task_struct *t)
>  		/* Unboost if we were boosted. */
>  		if (IS_ENABLED(CONFIG_RCU_BOOST) && drop_boost_mutex)
>  			rt_mutex_futex_unlock(&rnp->boost_mtx);
> -
> -		/*
> -		 * If this was the last task on the expedited lists,
> -		 * then we need to report up the rcu_node hierarchy.
> -		 */
> -		if (!empty_exp && empty_exp_now)
> -			rcu_report_exp_rnp(rcu_state_p, rnp, true);
>  	} else {
>  		local_irq_restore(flags);
>  	}
> +
> +	/*
> +	 * Respond to a request for an expedited grace period.
> +	 */
> +	if (special.b.exp_need_qs) {
> +		t->rcu_read_unlock_special.b.exp_need_qs = false;
> +		rdp = this_cpu_ptr(rcu_state_p->rda);
> +		rcu_report_exp_rdp(rcu_state_p, rdp, true);
> +	}

OK, so it looks like you are thinking in terms of combining the two
possible calls to rcu_report_exp_rdp().  But can't you lose reports
this way?  For example, suppose that this rcu_node structure has
two tasks queued behind ->exp_tasks?

The current code uses the non-empty-to-empty transition to make the
later report happen.  How does this code make that happen?

In addition, preemption is rare, so we don't necessarily need to
optimize for that case.

							Thanx, Paul

>  }
> 
>  /*
> 
