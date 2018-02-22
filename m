Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933031AbeBVPan (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 10:30:43 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:45994 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932942AbeBVPal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 10:30:41 -0500
Date: Thu, 22 Feb 2018 16:30:34 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Andrea Parri <parri.andrea@gmail.com>
Subject: Re: [RFC tip/locking/lockdep v5 05/17] lockdep: Extend __bfs() to
 work with multiple kinds of dependencies
Message-ID: <20180222153034.GO25181@hirez.programming.kicks-ass.net>
References: <20180222070904.548-1-boqun.feng@gmail.com>
 <20180222070904.548-6-boqun.feng@gmail.com>
 <20180222142614.GR25201@hirez.programming.kicks-ass.net>
 <20180222151210.jwxjchywk4jfecyf@tardis>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180222151210.jwxjchywk4jfecyf@tardis>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 11:12:10PM +0800, Boqun Feng wrote:
> On Thu, Feb 22, 2018 at 03:26:14PM +0100, Peter Zijlstra wrote:

> > However, I would suggest:
> > 
> > static inline bool is_xr(u16 dep)
> > {
> > 	return !!(dep & (DEP_NR_MASK | DEP_RR_MASK));
> > }
> > 
> > static inline bool is_rx(u16 dep)
> > {
> > 	return !!(dep & (DEP_RN_MASK | DEP_RR_MASK));
> > }
> > 
> > 
> > > @@ -1095,11 +1179,18 @@ static enum bfs_result __bfs(struct lock_list *source_entry,
> > >  		else
> > >  			head = &lock->class->locks_before;
> > >  
> > > +		is_rr = lock->is_rr;
> > > +
> > >  		DEBUG_LOCKS_WARN_ON(!irqs_disabled());
> > >  
> > >  		list_for_each_entry_rcu(entry, head, entry) {
> > >  			unsigned int cq_depth;
> > >  
> > > +			next_is_rr = pick_dep(is_rr, entry->dep);
> > > +			if (next_is_rr < 0)
> > > +				continue;
> > > +			entry->is_rr = next_is_rr;
> > 
> > 		/* Skip *R -> R* relations */
> > 		if (have_xr && is_rx(entry->dep))
> > 			continue;
> 
> I don't think this works, if we pick a *R for previous entry, and for
> current entry, we have RR, NN and NR, your approach will skip the
> current entry, but actually we can pick NN or NR (of course, in __bfs(),
> we can greedily pick NN, because if NR causes a deadlock, so does NN).

I don't get it, afaict my suggestion is identical.

You skip condition: pick_dep() < 0, evaluates to:

	is_rr && (!NN_MASK && !NR_MASK) :=
	is_rr && (RN_MASK | RR_MASK)

Which is exactly what I have.

If that is satisfied, you set entry->is_rr to pick_dep(), which his
harder to evaluate, but is something like:

	is_rr && NR_MASK || !(NN_MASK | RN_MASK) :=
	is_rr && NR_MASK || (NR_MASK | RR_MASK) :=
	(NR_MASK | RR_MASK)

(because is_rr && RR_MASK will have been skipped)

> > 
> > 		entry->have_xr = is_xr(entry->dep);
> > 
> > Which to me is a much simpler construct, hmm?
