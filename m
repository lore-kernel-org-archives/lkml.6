Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751685AbeEVAT4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 20:19:56 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:40627 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750859AbeEVATx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 20:19:53 -0400
X-Google-Smtp-Source: AB8JxZpGEXib7rrXERtfEnZIVVJqbWirDvKRbbNVH8U+0xZ9JbKTk4infl0C3wVOOx8G8UBYl71PXQ==
Date: Mon, 21 May 2018 17:19:51 -0700
From: Joel Fernandes <joel@joelfernandes.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Joel Fernandes <joelaf@google.com>, linux-kernel@vger.kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>, byungchul.park@lge.com,
        kernel-team@android.com
Subject: Re: [PATCH v3 3/4] rcu: Use better variable names in funnel locking
 loop
Message-ID: <20180522001951.GE40541@joelaf.mtv.corp.google.com>
References: <20180521044220.123933-1-joel@joelfernandes.org>
 <20180521044220.123933-4-joel@joelfernandes.org>
 <20180521231357.GI3803@linux.vnet.ibm.com>
 <20180522000016.GC40541@joelaf.mtv.corp.google.com>
 <20180522001925.GO3803@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180522001925.GO3803@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2018 at 05:19:25PM -0700, Paul E. McKenney wrote:
> On Mon, May 21, 2018 at 05:00:16PM -0700, Joel Fernandes wrote:
> > On Mon, May 21, 2018 at 04:13:57PM -0700, Paul E. McKenney wrote:
> > > > ---
> > > >  kernel/rcu/tree.c | 48 ++++++++++++++++++++++++-----------------------
> > > >  1 file changed, 25 insertions(+), 23 deletions(-)
> > > > 
> > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > index 0ffd41ba304f..879c67a31116 100644
> > > > --- a/kernel/rcu/tree.c
> > > > +++ b/kernel/rcu/tree.c
> > > > @@ -1526,7 +1526,7 @@ static void trace_rcu_this_gp(struct rcu_node *rnp, struct rcu_data *rdp,
> > > > 
> > > >  /*
> > > >   * rcu_start_this_gp - Request the start of a particular grace period
> > > > - * @rnp: The leaf node of the CPU from which to start.
> > > > + * @rnp_start: The leaf node of the CPU from which to start.
> > > >   * @rdp: The rcu_data corresponding to the CPU from which to start.
> > > >   * @gp_seq_req: The gp_seq of the grace period to start.
> > > >   *
> > > > @@ -1540,12 +1540,12 @@ static void trace_rcu_this_gp(struct rcu_node *rnp, struct rcu_data *rdp,
> > > >   *
> > > >   * Returns true if the GP thread needs to be awakened else false.
> > > >   */
> > > > -static bool rcu_start_this_gp(struct rcu_node *rnp, struct rcu_data *rdp,
> > > > +static bool rcu_start_this_gp(struct rcu_node *rnp_start, struct rcu_data *rdp,
> > > >  			      unsigned long gp_seq_req)
> > > >  {
> > > >  	bool ret = false;
> > > >  	struct rcu_state *rsp = rdp->rsp;
> > > > -	struct rcu_node *rnp_root;
> > > > +	struct rcu_node *rnp, *rnp_root = NULL;
> > > 
> > > Unless I am going blind, this patch really isn't using rnp_root.  It
> > > could be removed.
> > 
> > Its just limitation of the diff tools. Your eyes are just fine and doing
> > great based on your review comments ;)
> > 
> > The rnp_root is used after we break out of the loop.
> > 
> > > > 
> > > >  	/*
> > > >  	 * Use funnel locking to either acquire the root rcu_node
> > > > @@ -1556,34 +1556,36 @@ static bool rcu_start_this_gp(struct rcu_node *rnp, struct rcu_data *rdp,
> > > >  	 * scan the leaf rcu_node structures.  Note that rnp->lock must
> > > >  	 * not be released.
> > > >  	 */
> > > > -	raw_lockdep_assert_held_rcu_node(rnp);
> > > > -	trace_rcu_this_gp(rnp, rdp, gp_seq_req, TPS("Startleaf"));
> > > > -	for (rnp_root = rnp; 1; rnp_root = rnp_root->parent) {
> > > > -		if (rnp_root != rnp)
> > > > -			raw_spin_lock_rcu_node(rnp_root);
> > > > -		if (ULONG_CMP_GE(rnp_root->gp_seq_needed, gp_seq_req) ||
> > > > -		    rcu_seq_started(&rnp_root->gp_seq, gp_seq_req) ||
> > > > -		    (rnp != rnp_root &&
> > > > -		     rcu_seq_state(rcu_seq_current(&rnp_root->gp_seq)))) {
> > > > -			trace_rcu_this_gp(rnp_root, rdp, gp_seq_req,
> > > > +	raw_lockdep_assert_held_rcu_node(rnp_start);
> > > > +	trace_rcu_this_gp(rnp_start, rdp, gp_seq_req, TPS("Startleaf"));
> > > > +	for (rnp = rnp_start; 1; rnp = rnp->parent) {
> > > > +		if (rnp != rnp_start)
> > > > +			raw_spin_lock_rcu_node(rnp);
> > > > +		if (ULONG_CMP_GE(rnp->gp_seq_needed, gp_seq_req) ||
> > > > +		    rcu_seq_started(&rnp->gp_seq, gp_seq_req) ||
> > > > +		    (rnp != rnp_start &&
> > > > +		     rcu_seq_state(rcu_seq_current(&rnp->gp_seq)))) {
> > > > +			trace_rcu_this_gp(rnp, rdp, gp_seq_req,
> > > >  					  TPS("Prestarted"));
> > > >  			goto unlock_out;
> > > >  		}
> > > > -		rnp_root->gp_seq_needed = gp_seq_req;
> > > > -		if (rcu_seq_state(rcu_seq_current(&rnp->gp_seq))) {
> > > > +		rnp->gp_seq_needed = gp_seq_req;
> > > > +		if (rcu_seq_state(rcu_seq_current(&rnp_start->gp_seq))) {
> > > 
> > > The original had a performance bug, which is quite a bit more obvious
> > > given the new names, so thank you for that!  The above statement should
> > > instead be as follows:
> > > 
> > > 		if (rcu_seq_state(rcu_seq_current(&rnp->gp_seq))) {
> > > 
> > > It does not make sense to keep checking the starting rcu_node because
> > > changes to ->gp_seq happen first at the top of the tree.  So we might
> > > take an earlier exit by checking the current rnp instead of rechecking
> > > rnp_start over and over.
> > > 
> > > Please feel free to make this change, which is probably best as a separate
> > > patch.  That way this rename patch can remain a straightforward rename patch.
> > 
> > Yes, sounds like a nice optimization and I'm glad my variable renaming helped
> > ;) I feel I should have seen it too. I can make this change and send out
> > with my next series as you suggest.
> > 
> > > >  			/*
> > > >  			 * We just marked the leaf, and a grace period
> > > >  			 * is in progress, which means that rcu_gp_cleanup()
> > > >  			 * will see the marking.  Bail to reduce contention.
> > > >  			 */
> > > > -			trace_rcu_this_gp(rnp, rdp, gp_seq_req,
> > > > +			trace_rcu_this_gp(rnp_start, rdp, gp_seq_req,
> > > >  					  TPS("Startedleaf"));
> > > >  			goto unlock_out;
> > > >  		}
> > > > -		if (rnp_root != rnp && rnp_root->parent != NULL)
> > > > -			raw_spin_unlock_rcu_node(rnp_root);
> > > > -		if (!rnp_root->parent)
> > > > +		if (rnp != rnp_start && rnp->parent != NULL)
> > > > +			raw_spin_unlock_rcu_node(rnp);
> > > > +		if (!rnp->parent) {
> > > > +			rnp_root = rnp;
> > > 
> > > Since rnp_root is otherwise unused in the new version, the above statement
> > > can be dropped along with the "if" statement's braces and the declaration.
> > 
> > Actually rnp_root is needed for tracing calls after we breakout of the loop.
> 
> But at that point, rnp_root is equal to rnp, so rnp_root still isn't
> really needed, correct?

You are right. Sorry about that, so I'll change the tracepoints that follow
to use rnp, as you suggested.

thanks,

 - Joel
