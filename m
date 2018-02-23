Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751437AbeBWLz2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 06:55:28 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:50362 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750798AbeBWLz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 06:55:26 -0500
Date: Fri, 23 Feb 2018 12:55:20 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Andrea Parri <parri.andrea@gmail.com>
Subject: Re: [RFC tip/locking/lockdep v5 04/17] lockdep: Introduce
 lock_list::dep
Message-ID: <20180223115520.GV25181@hirez.programming.kicks-ass.net>
References: <20180222070904.548-1-boqun.feng@gmail.com>
 <20180222070904.548-5-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180222070904.548-5-boqun.feng@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 03:08:51PM +0800, Boqun Feng wrote:
> @@ -1012,6 +1013,33 @@ static inline bool bfs_error(enum bfs_result res)
>  	return res < 0;
>  }
>  
> +#define DEP_NN_BIT 0
> +#define DEP_RN_BIT 1
> +#define DEP_NR_BIT 2
> +#define DEP_RR_BIT 3
> +
> +#define DEP_NN_MASK (1U << (DEP_NN_BIT))
> +#define DEP_RN_MASK (1U << (DEP_RN_BIT))
> +#define DEP_NR_MASK (1U << (DEP_NR_BIT))
> +#define DEP_RR_MASK (1U << (DEP_RR_BIT))
> +
> +static inline unsigned int __calc_dep_bit(int prev, int next)
> +{
> +	if (prev == 2 && next != 2)
> +		return DEP_RN_BIT;
> +	if (prev != 2 && next == 2)
> +		return DEP_NR_BIT;
> +	if (prev == 2 && next == 2)
> +		return DEP_RR_BIT;
> +	else
> +		return DEP_NN_BIT;
> +}
> +
> +static inline unsigned int calc_dep(int prev, int next)
> +{
> +	return 1U << __calc_dep_bit(prev, next);
> +}
> +
>  static enum bfs_result __bfs(struct lock_list *source_entry,
>  			     void *data,
>  			     int (*match)(struct lock_list *entry, void *data),
> @@ -1921,6 +1949,16 @@ check_prev_add(struct task_struct *curr, struct held_lock *prev,
>  		if (entry->class == hlock_class(next)) {
>  			if (distance == 1)
>  				entry->distance = 1;
> +			entry->dep |= calc_dep(prev->read, next->read);
> +		}
> +	}
> +
> +	/* Also, update the reverse dependency in @next's ->locks_before list */
> +	list_for_each_entry(entry, &hlock_class(next)->locks_before, entry) {
> +		if (entry->class == hlock_class(prev)) {
> +			if (distance == 1)
> +				entry->distance = 1;
> +			entry->dep |= calc_dep(next->read, prev->read);
>  			return 1;
>  		}
>  	}

I think it all becomes simpler if you use only 2 bits. Such that:

  bit0 is the prev R (0) or N (1) value,
  bit1 is the next R (0) or N (1) value.

I think this should work because we don't care about the empty set
(currently 0000) and all the complexity in patch 5 is because we can
have R bits set when there's also N bits. The concequence of that is
that we cannot replace ! with ~ (which is what I kept doing).

But with only 2 bits, we only track the strongest relation in the set,
which is exactly what we appear to need.


The above then becomes something like:

static inline u8 __calc_dep(struct held_lock *lock)
{
	return lock->read != 2;
}

static inline u8
calc_dep(struct held_lock *prev, struct held_lock *next)
{
	return (__calc_dep(prev) << 0) | (__calc_dep(next) << 1);
}


	entry->dep |= calc_dep(prev, next);



Then the stuff from 5 can be:

static inline bool is_rx(u8 dep)
{
	return !(dep & 1);
}

static inline bool is_xr(u8 dep)
{
	return !(dep & 2);
}


	if (have_xr && is_rx(entry->dep))
		continue;

	entry->have_xr = is_xr(entry->dep);


Or did I mess that up somewhere?
