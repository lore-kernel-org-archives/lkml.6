Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752132AbeCIImy (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 03:42:54 -0500
Received: from lgeamrelo11.lge.com ([156.147.23.51]:35463 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750926AbeCIImv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 03:42:51 -0500
X-Original-SENDERIP: 156.147.1.127
X-Original-MAILFROM: byungchul.park@lge.com
X-Original-SENDERIP: 10.177.222.33
X-Original-MAILFROM: byungchul.park@lge.com
Date: Fri, 9 Mar 2018 17:41:54 +0900
From: Byungchul Park <byungchul.park@lge.com>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, jiangshanlai@gmail.com,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
        kernel-team@lge.com
Subject: Re: [RFC] rcu: Prevent expedite reporting within RCU read-side
 section
Message-ID: <20180309084154.GA24031@X58A-UD3R>
References: <1520314318-30916-1-git-send-email-byungchul.park@lge.com>
 <20180306134205.lwmn3cgisnwkngcf@tardis>
 <908c33f9-c8ed-5d4e-91cb-a123de5dbbc7@lge.com>
 <a2e0a9c5-4246-d3b9-2eb7-9bdd87aef636@lge.com>
 <20180307150343.GD3918@linux.vnet.ibm.com>
 <20180308100825.GA32165@X58A-UD3R>
 <20180308180156.GQ3918@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180308180156.GQ3918@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 08, 2018 at 10:01:56AM -0800, Paul E. McKenney wrote:
> On Thu, Mar 08, 2018 at 07:08:25PM +0900, Byungchul Park wrote:

[...]

> >    2. Clear its bit of ->expmask *only* when it's out of RCU read
> >       sections and keep others unchanged. So it will be cleared at the
> >       end of the RCU read section in that case.
> > 
> >       This option would also work because we anyway check both
> >       ->exp_tasks and ->expmask to finish the expedite-gp.
> 
> This could be made to work, but one shortcoming is that the grace
> period would end up waiting on later read-side critical sections
> that it does not really need to wait on.  Also, eventually all the

I don't think it waits on any later ones since ->expmask would be
cleared at the end of the previous RCU read section.

> bits would clear, and they might clear before the last preempted
> task resumed, so the race would still exist.

No problem since ->exp_tasks will prevent the expedite-gp from ending.

> > Current code chose the 1st option and try to report the quiescent state
> > using rcu_report_exp_rdp() when it's out of RCU read sections or the
> > task is preempted, while an expedite-gp is in progress.
> > 
> > However, when reporting it within a RCU read section, the reporting
> > hardly goes further since sync_rcu_preempt_exp_done() of course returns
> > false, furthermore, it might add *unnecessary* lock contention of
> > rcu_node's spin lock within rcu_report_exp_cpu_mult(). I think those are
> > unnecessary at all even though there's no logical problem.
> 
> It would be possible to use ordering and memory barriers to avoid at
> least some lock acquisitions, but the resulting code would be more
> complex and fragile.  So I would want to see a real problem before

Yes, the simpler the better.

> using a more aggressive design.

I admit that I've done far more than I intended. I understand you and
don't wanna change the design aggressively.

> > @@ -716,28 +716,22 @@ static void sync_rcu_exp_handler(void *info)
> >  	struct rcu_state *rsp = info;
> >  	struct task_struct *t = current;
> > 
> > -	/*
> > -	 * Within an RCU read-side critical section, request that the next
> > -	 * rcu_read_unlock() report.  Unless this RCU read-side critical
> > -	 * section has already blocked, in which case it is already set
> > -	 * up for the expedited grace period to wait on it.
> > -	 */
> > -	if (t->rcu_read_lock_nesting > 0 &&
> > -	    !t->rcu_read_unlock_special.b.blocked) {
> > +	if (t->rcu_read_lock_nesting > 0) {
> > +		/*
> > +		 * Within an RCU read-side critical section, request that
> > +		 * the next rcu_read_unlock() report.
> > +		 */
> >  		t->rcu_read_unlock_special.b.exp_need_qs = true;
> > -		return;
> > +	} else {
> > +		/*
> > +		 * We are either exiting an RCU read-side critical section
> > +		 * (negative values of t->rcu_read_lock_nesting) or are not
> > +		 * in one at all (zero value of t->rcu_read_lock_nesting).
> > +		 * We can immediately report the quiescent state.
> > +		 */
> > +		rdp = this_cpu_ptr(rsp->rda);
> > +		rcu_report_exp_rdp(rsp, rdp, true);
> >  	}
> > -
> > -	/*
> > -	 * We are either exiting an RCU read-side critical section (negative
> > -	 * values of t->rcu_read_lock_nesting) or are not in one at all
> > -	 * (zero value of t->rcu_read_lock_nesting).  Or we are in an RCU
> > -	 * read-side critical section that blocked before this expedited
> > -	 * grace period started.  Either way, we can immediately report
> > -	 * the quiescent state.
> > -	 */
> > -	rdp = this_cpu_ptr(rsp->rda);
> > -	rcu_report_exp_rdp(rsp, rdp, true);
> 
> This code is equivalent, correct?  All that happened is that a
> "return" statement was replaced with an "else" clause.  Or am I
> blind this morning?

It's different. I made it do rcu_report_exp_rdp() only when it's out of
RCU read sections, otherwise set the exp_need_qs flag. But I noticed
that this part should be modified thanks to your explanation below.

> > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > index b0d7f9b..b303b63 100644
> > --- a/kernel/rcu/tree_plugin.h
> > +++ b/kernel/rcu/tree_plugin.h
> > @@ -269,20 +269,6 @@ static void rcu_preempt_ctxt_queue(struct rcu_node *rnp, struct rcu_data *rdp)
> >  	WARN_ON_ONCE(!(blkd_state & RCU_EXP_BLKD) !=
> >  		     !(rnp->expmask & rdp->grpmask));
> >  	raw_spin_unlock_rcu_node(rnp); /* interrupts remain disabled. */
> > -
> > -	/*
> > -	 * Report the quiescent state for the expedited GP.  This expedited
> > -	 * GP should not be able to end until we report, so there should be
> > -	 * no need to check for a subsequent expedited GP.  (Though we are
> > -	 * still in a quiescent state in any case.)
> > -	 */
> > -	if (blkd_state & RCU_EXP_BLKD &&
> > -	    t->rcu_read_unlock_special.b.exp_need_qs) {
> > -		t->rcu_read_unlock_special.b.exp_need_qs = false;
> > -		rcu_report_exp_rdp(rdp->rsp, rdp, true);
> > -	} else {
> > -		WARN_ON_ONCE(t->rcu_read_unlock_special.b.exp_need_qs);
> > -	}
> 
> Again, this does not eliminate the race, from what I can see.  And it

There are races neither in the current code nor in my patch, I think.

> can unnecessarily extend the expedited grace period.

I don't know what you're pointing out here. Does the patch I'm attaching
below still have the same problem? Do you remind that it's gonna be
handled in rcu_read_unlock_special()?

> > @@ -532,16 +498,18 @@ void rcu_read_unlock_special(struct task_struct *t)
> >  		/* Unboost if we were boosted. */
> >  		if (IS_ENABLED(CONFIG_RCU_BOOST) && drop_boost_mutex)
> >  			rt_mutex_futex_unlock(&rnp->boost_mtx);
> > -
> > -		/*
> > -		 * If this was the last task on the expedited lists,
> > -		 * then we need to report up the rcu_node hierarchy.
> > -		 */
> > -		if (!empty_exp && empty_exp_now)
> > -			rcu_report_exp_rnp(rcu_state_p, rnp, true);
> >  	} else {
> >  		local_irq_restore(flags);
> >  	}
> > +
> > +	/*
> > +	 * Respond to a request for an expedited grace period.
> > +	 */
> > +	if (special.b.exp_need_qs) {
> > +		t->rcu_read_unlock_special.b.exp_need_qs = false;
> > +		rdp = this_cpu_ptr(rcu_state_p->rda);
> > +		rcu_report_exp_rdp(rcu_state_p, rdp, true);
> > +	}
> 
> OK, so it looks like you are thinking in terms of combining the two
> possible calls to rcu_report_exp_rdp().  But can't you lose reports
> this way?  For example, suppose that this rcu_node structure has
> two tasks queued behind ->exp_tasks?

I certainly missed something here. I noticed it thanks to you.

> The current code uses the non-empty-to-empty transition to make the
> later report happen.  How does this code make that happen?

Exactly. My code doesn't make it.

What about the modified version which doesn't change the design but just
eliminates the obvious unnecessary? And it might answer your question
properly saying "which calls to this function (rcu_report_exp_cpu_mult())
do you believe should be removed?".

----->8-----
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 73e1d3d..33dfe6b 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -736,8 +736,10 @@ static void sync_rcu_exp_handler(void *info)
 	 * grace period started.  Either way, we can immediately report
 	 * the quiescent state.
 	 */
-	rdp = this_cpu_ptr(rsp->rda);
-	rcu_report_exp_rdp(rsp, rdp, true);
+	if (t->rcu_read_lock_nesting <= 0) {
+		rdp = this_cpu_ptr(rsp->rda);
+		rcu_report_exp_rdp(rsp, rdp, true);
+	}
 }
 
 /**
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index b0d7f9b..bb6b2dc 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -271,15 +271,12 @@ static void rcu_preempt_ctxt_queue(struct rcu_node *rnp, struct rcu_data *rdp)
 	raw_spin_unlock_rcu_node(rnp); /* interrupts remain disabled. */
 
 	/*
-	 * Report the quiescent state for the expedited GP.  This expedited
-	 * GP should not be able to end until we report, so there should be
-	 * no need to check for a subsequent expedited GP.  (Though we are
-	 * still in a quiescent state in any case.)
+	 * Reporting the quiescent state for the expedited GP will be
+	 * handled by special.b.blocked field in rcu_read_unlock_special().
 	 */
 	if (blkd_state & RCU_EXP_BLKD &&
 	    t->rcu_read_unlock_special.b.exp_need_qs) {
 		t->rcu_read_unlock_special.b.exp_need_qs = false;
-		rcu_report_exp_rdp(rdp->rsp, rdp, true);
 	} else {
 		WARN_ON_ONCE(t->rcu_read_unlock_special.b.exp_need_qs);
 	}
@@ -491,7 +488,7 @@ void rcu_read_unlock_special(struct task_struct *t)
 		WARN_ON_ONCE(rnp != t->rcu_blocked_node);
 		WARN_ON_ONCE(rnp->level != rcu_num_lvls - 1);
 		empty_norm = !rcu_preempt_blocked_readers_cgp(rnp);
-		empty_exp = sync_rcu_preempt_exp_done(rnp);
+		empty_exp = rnp->exp_tasks == NULL;
 		smp_mb(); /* ensure expedited fastpath sees end of RCU c-s. */
 		np = rcu_next_node_entry(t, rnp);
 		list_del_init(&t->rcu_node_entry);
@@ -515,7 +512,7 @@ void rcu_read_unlock_special(struct task_struct *t)
 		 * Note that rcu_report_unblock_qs_rnp() releases rnp->lock,
 		 * so we must take a snapshot of the expedited state.
 		 */
-		empty_exp_now = sync_rcu_preempt_exp_done(rnp);
+		empty_exp_now = rnp->exp_tasks == NULL;
 		if (!empty_norm && !rcu_preempt_blocked_readers_cgp(rnp)) {
 			trace_rcu_quiescent_state_report(TPS("preempt_rcu"),
 							 rnp->gpnum,
@@ -537,8 +534,10 @@ void rcu_read_unlock_special(struct task_struct *t)
 		 * If this was the last task on the expedited lists,
 		 * then we need to report up the rcu_node hierarchy.
 		 */
-		if (!empty_exp && empty_exp_now)
-			rcu_report_exp_rnp(rcu_state_p, rnp, true);
+		if (!empty_exp && empty_exp_now) {
+			rdp = this_cpu_ptr(rcu_state_p->rda);
+			rcu_report_exp_rdp(rcu_state_p, rdp, true);
+		}
 	} else {
 		local_irq_restore(flags);
 	}
