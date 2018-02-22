Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932848AbeBVO0X (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 09:26:23 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56380 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932564AbeBVO0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 09:26:22 -0500
Date: Thu, 22 Feb 2018 15:26:14 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Andrea Parri <parri.andrea@gmail.com>
Subject: Re: [RFC tip/locking/lockdep v5 05/17] lockdep: Extend __bfs() to
 work with multiple kinds of dependencies
Message-ID: <20180222142614.GR25201@hirez.programming.kicks-ass.net>
References: <20180222070904.548-1-boqun.feng@gmail.com>
 <20180222070904.548-6-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180222070904.548-6-boqun.feng@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 03:08:52PM +0800, Boqun Feng wrote:
> Now we have four kinds of dependencies in the dependency graph, and not
> all the pathes carry strong dependencies, for example:
> 
> 	Given lock A, B, C, if we have:
> 
> 	CPU1			CPU2
> 	=============		==============
> 	write_lock(A);		read_lock(B);
> 	read_lock(B);		write_lock(C);
> 
> 	then we have dependencies A--(NR)-->B, and B--(RN)-->C, (NR and
> 	RN are to indicate the dependency kind), A actually doesn't have
> 	strong dependency to C(IOW, C doesn't depend on A), to see this,
                              ^ missing space

You're fairly consistent with not putting spaces before opening braces
in text, please don't do this, this is not a C function call. Also
double check all your braces are matched, IIRC there's at least one that
isn't closed in the previous patches.

> 	let's say we have a third CPU3 doing:
> 
> 	CPU3:
> 	=============
> 	write_lock(C);
> 	write_lock(A);
> 
> 	, this is not a deadlock. However if we change the read_lock()
> 	on CPU2 to a write_lock(), it's a deadlock then.
> 
> 	So A --(NR)--> B --(RN)--> C is not a strong dependency path but
> 	A --(NR)--> B --(NN)-->C is a strong dependency path.

I'm not really satisfied with the above reasoning. I don't disagree, but
if possible it would be nice to have something a little more solid.


> We can generalize this as: If a path of dependencies doesn't have two
> adjacent dependencies as (*R)--L-->(R*), where L is some lock, it is a
> strong dependency path, otherwise it's not.
> 
> Now our mission is to make __bfs() traverse only the strong dependency
> paths, which is simple: we record whether we have -(*R)-> at the current
> tail of the path in lock_list::is_rr, and whenever we pick a dependency
> in the traverse, we 1) make sure we don't pick a -(R*)-> dependency if
> our current tail is -(*R)-> and 2) greedily pick a -(*N)-> as hard as
> possible.
> 
> With this extension for __bfs(), we now need to initialize the root of
> __bfs() properly(with a correct ->is_rr), to do so, we introduce some
                  ^ another missing space

Also, I don't like is_rr as a name, have_xr might be better.

Only if we combine *R with R* do we have RR.

> +/*
> + * return -1 if no proper dependency could be picked
> + * return 0 if a -(*N)-> dependency could be picked
> + * return 1 if only a -(*R)-> dependency could be picked
> + *
> + * N: non-recursive lock
> + * R: recursive read lock
> + */
> +static inline int pick_dep(u16 is_rr, u16 cap_dep)
> +{
> +	if (is_rr) { /* could only pick -(N*)-> */
> +		if (cap_dep & DEP_NN_MASK)
> +			return 0;
> +		else if (cap_dep & DEP_NR_MASK)
> +			return 1;
> +		else
> +			return -1;
> +	} else {
> +		if (cap_dep & DEP_NN_MASK || cap_dep & DEP_RN_MASK)

	if (cap_dep & (DEP_NN_MASK | DEP_RN_MASK))

> +			return 0;
> +		else
> +			return 1;
> +	}
> +}

However, I would suggest:

static inline bool is_xr(u16 dep)
{
	return !!(dep & (DEP_NR_MASK | DEP_RR_MASK));
}

static inline bool is_rx(u16 dep)
{
	return !!(dep & (DEP_RN_MASK | DEP_RR_MASK));
}


> @@ -1095,11 +1179,18 @@ static enum bfs_result __bfs(struct lock_list *source_entry,
>  		else
>  			head = &lock->class->locks_before;
>  
> +		is_rr = lock->is_rr;
> +
>  		DEBUG_LOCKS_WARN_ON(!irqs_disabled());
>  
>  		list_for_each_entry_rcu(entry, head, entry) {
>  			unsigned int cq_depth;
>  
> +			next_is_rr = pick_dep(is_rr, entry->dep);
> +			if (next_is_rr < 0)
> +				continue;
> +			entry->is_rr = next_is_rr;

		/* Skip *R -> R* relations */
		if (have_xr && is_rx(entry->dep))
			continue;

		entry->have_xr = is_xr(entry->dep);

Which to me is a much simpler construct, hmm?

> +
>  			visit_lock_entry(entry, lock);
>  			if (match(entry, data)) {
>  				*target_entry = entry;
