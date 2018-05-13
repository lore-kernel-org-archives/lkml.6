Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752014AbeEMTvY (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 15:51:24 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:40691 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751295AbeEMTvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 15:51:22 -0400
X-Google-Smtp-Source: AB8JxZqHs7MKIgdJE250ETC2X+ZMHViSW2VZwA6ycLtRHu6TqrpM7dyeHP3EpXj1d/UR5yUkXKOLtg==
Date: Sun, 13 May 2018 12:51:20 -0700
From: Joel Fernandes <joel@joelfernandes.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, jiangshanlai@gmail.com,
        dipankar@in.ibm.com, akpm@linux-foundation.org,
        mathieu.desnoyers@efficios.com, josh@joshtriplett.org,
        tglx@linutronix.de, peterz@infradead.org, rostedt@goodmis.org,
        dhowells@redhat.com, edumazet@google.com, fweisbec@gmail.com,
        oleg@redhat.com, joel.opensrc@gmail.com, torvalds@linux-foundation.org,
        npiggin@gmail.com
Subject: Re: [tip/core/rcu,16/21] rcu: Add funnel locking to
 rcu_start_this_gp()
Message-ID: <20180513195120.GA15962@joelaf.mtv.corp.google.com>
References: <1524452624-27589-16-git-send-email-paulmck@linux.vnet.ibm.com>
 <20180512060325.GA53808@joelaf.mtv.corp.google.com>
 <20180512144002.GI26088@linux.vnet.ibm.com>
 <20180512144438.GA12826@linux.vnet.ibm.com>
 <20180512235301.GD192642@joelaf.mtv.corp.google.com>
 <20180513153842.GK26088@linux.vnet.ibm.com>
 <20180513164953.GA8358@joelaf.mtv.corp.google.com>
 <20180513190906.GL26088@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180513190906.GL26088@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 13, 2018 at 12:09:06PM -0700, Paul E. McKenney wrote:
> On Sun, May 13, 2018 at 09:49:53AM -0700, Joel Fernandes wrote:
> > On Sun, May 13, 2018 at 08:38:42AM -0700, Paul E. McKenney wrote:
> > > On Sat, May 12, 2018 at 04:53:01PM -0700, Joel Fernandes wrote:
> > > > On Sat, May 12, 2018 at 07:44:38AM -0700, Paul E. McKenney wrote:
> > > > > On Sat, May 12, 2018 at 07:40:02AM -0700, Paul E. McKenney wrote:
> > > > > > On Fri, May 11, 2018 at 11:03:25PM -0700, Joel Fernandes wrote:
> > > > > > > On Sun, Apr 22, 2018 at 08:03:39PM -0700, Paul E. McKenney wrote:
> > > > > > > > The rcu_start_this_gp() function had a simple form of funnel locking that
> > > > > > > > used only the leaves and root of the rcu_node tree, which is fine for
> > > > > > > > systems with only a few hundred CPUs, but sub-optimal for systems having
> > > > > > > > thousands of CPUs.  This commit therefore adds full-tree funnel locking.
> > > > > > > > 
> > > > > > > > This variant of funnel locking is unusual in the following ways:
> > > > > > > > 
> > > > > > > > 1.	The leaf-level rcu_node structure's ->lock is held throughout.
> > > > > > > > 	Other funnel-locking implementations drop the leaf-level lock
> > > > > > > > 	before progressing to the next level of the tree.
> > > > > > > > 
> > > > > > > > 2.	Funnel locking can be started at the root, which is convenient
> > > > > > > > 	for code that already holds the root rcu_node structure's ->lock.
> > > > > > > > 	Other funnel-locking implementations start at the leaves.
> > > > > > > > 
> > > > > > > > 3.	If an rcu_node structure other than the initial one believes
> > > > > > > > 	that a grace period is in progress, it is not necessary to
> > > > > > > > 	go further up the tree.  This is because grace-period cleanup
> > > > > > > > 	scans the full tree, so that marking the need for a subsequent
> > > > > > > > 	grace period anywhere in the tree suffices -- but only if
> > > > > > > > 	a grace period is currently in progress.
> > > > > > > > 
> > > > > > > > 4.	It is possible that the RCU grace-period kthread has not yet
> > > > > > > > 	started, and this case must be handled appropriately.
> > > > > > > > 
> > > > > > > > However, the general approach of using a tree to control lock contention
> > > > > > > > is still in place.
> > > > > > > > 
> > > > > > > > Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> > > > > > > > ---
> > > > > > > >  kernel/rcu/tree.c | 92 +++++++++++++++++++++----------------------------------
> > > > > > > >  1 file changed, 35 insertions(+), 57 deletions(-)
> > > > > > > > 
> > > > > > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > > > > > index 94519c7d552f..d3c769502929 100644
> > > > > > > > --- a/kernel/rcu/tree.c
> > > > > > > > +++ b/kernel/rcu/tree.c
> > > > > > > > @@ -1682,74 +1682,52 @@ static bool rcu_start_this_gp(struct rcu_node *rnp, struct rcu_data *rdp,
> > > > > > > >  {
> > > > > > > >  	bool ret = false;
> > > > > > > >  	struct rcu_state *rsp = rdp->rsp;
> > > > > > > > -	struct rcu_node *rnp_root = rcu_get_root(rsp);
> > > > > > > > -
> > > > > > > > -	raw_lockdep_assert_held_rcu_node(rnp);
> > > > > > > > -
> > > > > > > > -	/* If the specified GP is already known needed, return to caller. */
> > > > > > > > -	trace_rcu_this_gp(rnp, rdp, c, TPS("Startleaf"));
> > > > > > > > -	if (need_future_gp_element(rnp, c)) {
> > > > > > > > -		trace_rcu_this_gp(rnp, rdp, c, TPS("Prestartleaf"));
> > > > > > > > -		goto out;
> > > > > > > > -	}
> > > > > > > > +	struct rcu_node *rnp_root;
> > > > > > > >  
> > > > > > > >  	/*
> > > > > > > > -	 * If this rcu_node structure believes that a grace period is in
> > > > > > > > -	 * progress, then we must wait for the one following, which is in
> > > > > > > > -	 * "c".  Because our request will be noticed at the end of the
> > > > > > > > -	 * current grace period, we don't need to explicitly start one.
> > > > > > > > +	 * Use funnel locking to either acquire the root rcu_node
> > > > > > > > +	 * structure's lock or bail out if the need for this grace period
> > > > > > > > +	 * has already been recorded -- or has already started.  If there
> > > > > > > > +	 * is already a grace period in progress in a non-leaf node, no
> > > > > > > > +	 * recording is needed because the end of the grace period will
> > > > > > > > +	 * scan the leaf rcu_node structures.  Note that rnp->lock must
> > > > > > > > +	 * not be released.
> > > > > > > >  	 */
> > > > > > > > -	if (rnp->gpnum != rnp->completed) {
> > > > > > > > -		need_future_gp_element(rnp, c) = true;
> > > > > > > > -		trace_rcu_this_gp(rnp, rdp, c, TPS("Startedleaf"));
> > > > > > > > -		goto out;
> > > > > > > 
> > > > > > > Referring to the above negative diff as [1] (which I wanted to refer to later
> > > > > > > in this message..)
> > > > > > > 
> > > > > > > > +	raw_lockdep_assert_held_rcu_node(rnp);
> > > > > > > > +	trace_rcu_this_gp(rnp, rdp, c, TPS("Startleaf"));
> > > > > > > > +	for (rnp_root = rnp; 1; rnp_root = rnp_root->parent) {
> > > > > > > > +		if (rnp_root != rnp)
> > > > > > > > +			raw_spin_lock_rcu_node(rnp_root);
> > > > > > > > +		if (need_future_gp_element(rnp_root, c) ||
> > > > > > > > +		    ULONG_CMP_GE(rnp_root->gpnum, c) ||
> > > > > > > > +		    (rnp != rnp_root &&
> > > > > > > > +		     rnp_root->gpnum != rnp_root->completed)) {
> > > > > > > > +			trace_rcu_this_gp(rnp_root, rdp, c, TPS("Prestarted"));
> > > > > > > > +			goto unlock_out;
> > > > > > > 
> > > > > > > I was a bit confused about the implementation of the above for loop:
> > > > > > > 
> > > > > > > In the previous code (which I refer to in the negative diff [1]), we were
> > > > > > > checking the leaf, and if the leaf believed that RCU was not idle, then we
> > > > > > > were marking the need for the future GP and quitting this function. In the
> > > > > > > new code, it seems like even if the leaf believes RCU is not-idle, we still
> > > > > > > go all the way up the tree.
> > > > > > > 
> > > > > > > I think the big change is, in the above new for loop, we either bail of if a
> > > > > > > future GP need was already marked by an intermediate node, or we go marking
> > > > > > > up the whole tree about the need for one.
> > > > > > > 
> > > > > > > If a leaf believes RCU is not idle, can we not just mark the future GP need
> > > > > > > like before and return? It seems we would otherwise increase the lock
> > > > > > > contention since now we lock intermediate nodes and then finally even the
> > > > > > > root. Where as before we were not doing that if the leaf believed RCU was not
> > > > > > > idle.
> > > > > > > 
> > > > > > > I am sorry if I missed something obvious.
> > > > > > 
> > > > > > The trick is that we do the check before we have done the marking.
> > > > > > So if we bailed, we would not have marked at all.  If we are at an
> > > > > > intermediate node and a grace period is in progress, we do bail.
> > > > > > 
> > > > > > You are right that this means that we (perhaps unnecessarily) acquire
> > > > > > the lock of the parent rcu_node, which might or might not be the root.
> > > > > > And on systems with default fanout with 1024 CPUs or fewer, yes, it will
> > > > > > be the root, and yes, this is the common case.  So might be well worth
> > > > > > improving.
> > > > > > 
> > > > > > One way to implement the old mark-and-return approach as you suggest
> > > > > > above would be as shown below (untested, probably doesn't build, and
> > > > > > against current rcu/dev).  What do you think?
> > > > > > 
> > > > > > > The other thing is we now don't have the 'Startedleaf' trace like we did
> > > > > > > before. I sent a patch to remove it, but I think the removal of that is
> > > > > > > somehow connected to what I was just talking about.. and I was thinking if we
> > > > > > > should really remove it. Should we add the case for checking leaves only back
> > > > > > > or is that a bad thing to do?
> > > > > > 
> > > > > > Suppose I got hit by a bus and you were stuck with the job of debugging
> > > > > > this.  What traces would you want and where would they be?  Keeping in
> > > > > > mind that too-frequent traces have their problems as well.
> > > > > > 
> > > > > > (Yes, I will be trying very hard to avoid this scenario for as long as
> > > > > > I can, but this might be a good way for you (and everyone else) to be
> > > > > > thinking about this.)
> > > > > > 
> > > > > > 							Thanx, Paul
> > > > > > 
> > > > > > ------------------------------------------------------------------------
> > > > > > 
> > > > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > > > index 1abe29a43944..abf3195e01dc 100644
> > > > > > --- a/kernel/rcu/tree.c
> > > > > > +++ b/kernel/rcu/tree.c
> > > > > > @@ -1585,6 +1585,8 @@ static bool rcu_start_this_gp(struct rcu_node *rnp, struct rcu_data *rdp,
> > > > > >  			goto unlock_out;
> > > > > >  		}
> > > > > >  		rnp_root->gp_seq_needed = c;
> > > > e 
> > > > > > +		if (rcu_seq_statn(rcu_seq_current(&rnp_root->gp_seq)))
> > > > > > +		if (rcu_seq_state(rcu_seq_current(&rnp_root->gp_seq)))
> > > > > Right...  Make that rnp->gp_seq.  Memory locality and all that...
> > > > > 
> > > > > 							Thanx, Paul
> > > > 
> > > > Yes, I think this condition would be right to add. I could roll it into my
> > > > clean up patch.
> > > 
> > > I already queued it, please see below.
> > 
> > Cool!
> > 
> > > > Also, I think its better if we split the conditions for prestarted into
> > > > separate if conditions and comment them so its clear, I have started to do
> > > > that in my tree.
> > > 
> > > Hmmm...  Let's see how this plays out.
> > > 
> > 
> > Sure.
> > 
> > > > If you don't mind going through the if conditions in the funnel locking loop
> > > > with me, it would be quite helpful so that I don't mess the code up and would
> > > > also help me add tracing correctly.
> > > > 
> > > > The if condition for prestarted is this:
> > > > 
> > > >                if (need_future_gp_element(rnp_root, c) ||
> > > >                    ULONG_CMP_GE(rnp_root->gpnum, c) ||
> > > >                    (rnp != rnp_root &&
> > > >                     rnp_root->gpnum != rnp_root->completed)) {
> > > >                        trace_rcu_this_gp(rnp_root, rdp, c, TPS("Prestarted"));
> > > >                        goto unlock_out;
> > > > 		need_future_gp_element(rnp_root, c) = true;
> > > > 
> > > > As of 16/21, the heart of the loop is the above (excluding the locking bits)
> > > > 
> > > > In this what confuses me is the second and the third condition for
> > > > pre-started.
> > > > 
> > > > The second condition is:  ULONG_CMP_GE(rnp_root->gpnum, c). 
> > > > AIUI the goal of this condition is to check whether the requested grace
> > > > period has already started. I believe then the above check is insufficient. 
> > > > The reason I think its insufficient is I believe we should also check the
> > > > state of the grace period to augment this check.
> > > > IMO the condition should really be:
> > > > (ULONG_CMP_GT(rnp_root->gpnum, c) ||
> > > 
> > > The above asks whether the -next- grace period -after- the requested
> > > one had started.
> > > 
> > > >   (rnp_root->gpnum == c && rnp_root->gpnum != rnp_root->completed))
> > > 
> > > This asks that the requested grace period not have completed.
> > > 
> > > What about the case where the requested grace period has completed,
> > > but the one after has not yet started?  If you add that in, I bet you
> > > will have something that simplifies to my original.
> > > 
> > > > In a later patch you replaced this with rseq_done(&rnp_root->gp_seq, c) which
> > > > kind of accounts for the state, except that rseq_done uses ULONG_CMP_GE,
> > > > whereas to fix this, rseq_done IMO should be using ULONG_CMP_GT to be equivalent
> > > > to the above check. Do you agree?
> > > 
> > > I do not believe that I do.  The ULONG_CMP_GE() allows for the missing case
> > > where the requested grace period completed, but the following grace period
> > > has not yet started.
> > 
> > Ok thanks that clears it up. For some reason I was thinking if
> > rnp_root->gpnum == c, that could means 'c' has not yet started, unless we
> > also checked the state. Obviously, now I realize gpnum == c can only mean 2
> > things:
> >  - c has started but not yet completed
> >  - c has completed
> > 
> > Both of these cases should cause a bail out so I agree now with your
> > condition ULONG_CMP_GE, thanks.
> > 
> > > 
> > > > The third condition for pre-started is:
> > > >                    (rnp != rnp_root && rnp_root->gpnum != rnp_root->completed))
> > > > This as I followed from your commit message is if an intermediate node thinks
> > > > RCU is non-idle, then its not necessary to mark the tree and we can bail out
> > > > since the clean up will scan the whole tree anyway. That makes sense to me
> > > > but I think I will like to squash the diff in your previous email into this
> > > > condition as well to handle both conditions together.
> > > 
> > > Please keep in mind that it is necessary to actually record the request
> > > in the leaf case.  Or are you advocating use of ?: or similar to make this
> > > happen?
> > 
> > Yes, I realized yesterday you wanted to record it for the leaf that's why
> > you're doing things this way. I'll let you know if I find any other ways of
> > simplifying it once I look at your latest tree.
> > 
> > Btw, I checked your git tree and couldn't see the update that you mentioned
> > you queued above. Could you push those changes?
> 
> Good point, pushed now.  And the patch that I forgot to include in the
> last email is below.

Cool, thanks. Also one thing I wanted to discuss, I am a bit unclear about
the if (rcu_seq_done..) condition in the loop which decides if the GP
requested is pre-started.

Say c is 8 (0b1000) - i.e. gp requested is 2.
I drew some tables with some examples, the result column is what the
current code will do.

Say gp_seq is 12 and its not progress (0b1100),

gp_seq	gp_num	state	analysis of gp_seq  result
12	3	0	gp 3 not started    pre-started
			(gp 2 completed)

For this, the "greater than" check in rcu_seq_done will work because 2 already
completed (The check essentially does 12 >= 8 which implies prestarted).

Say gp_seq is 9 and it is in progress (0b1001)
gp_seq	gp_num	state	state of gp_seq    result
9	2	1	gp 2 in progress   pre-started
			(gp 1 completed)

Here also the "greater than" check is correct (9 >= 8 which implies prestarted).

However, say gp_seq is 8
gp_seq	gp_num	state	state of gp_seq    result
8	2	0	gp 2 not started   pre-started
			(gp 1 completed)

In this case, rcu_seq_done will incorrectly say that its pre-started when 2
has not yet started. For this reason, I feel the equal-to check in
rcu_seq_done will incorrectly predict prestarted.

I think to fix this, the rseq_done condition could be replaced with:
	if (ULONG_CMP_GT(rnp_root->gpseq, c)) {
		// pre-started
	}

I believe the difference arises because one of the patches during the
conversion to use gp_seq in the tree replaced rcu_seq_done with ULONG_CMP_GE,
where as such a replacement doesn't work in the gp_seq regime because of
difference in the way a gp's starte/end is accounted (vs the old way).

Does it make sense or was I way off about something :D ?

thanks,

- Joel
