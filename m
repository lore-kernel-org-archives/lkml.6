Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933587AbeBVRl6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 12:41:58 -0500
Received: from merlin.infradead.org ([205.233.59.134]:55770 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933427AbeBVRl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 12:41:57 -0500
Date: Thu, 22 Feb 2018 18:41:53 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Andrea Parri <parri.andrea@gmail.com>
Subject: Re: [RFC tip/locking/lockdep v5 08/17] lockdep: Fix recursive read
 lock related safe->unsafe detection
Message-ID: <20180222174153.GV25201@hirez.programming.kicks-ass.net>
References: <20180222070904.548-1-boqun.feng@gmail.com>
 <20180222070904.548-9-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180222070904.548-9-boqun.feng@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 03:08:55PM +0800, Boqun Feng wrote:
> There are four cases for recursive read lock realted deadlocks:
> 
> (--(X..Y)--> means a strong dependency path starts with a --(X*)-->
> dependency and ends with a --(*Y)-- dependency.)
> 
> 1.	An irq-safe lock L1 has a dependency --(*..*)--> to an
> 	irq-unsafe lock L2.
> 
> 2.	An irq-read-safe lock L1 has a dependency --(N..*)--> to an
> 	irq-unsafe lock L2.
> 
> 3.	An irq-safe lock L1 has a dependency --(*..N)--> to an
> 	irq-read-unsafe lock L2.
> 
> 4.	An irq-read-safe lock L1 has a dependency --(N..N)--> to an
> 	irq-read-unsafe lock L2.
> 
> The current check_usage() only checks 1) and 2), so this patch adds
> checks for 3) and 4) and makes sure when find_usage_{back,for}wards find
> an irq-read-{,un}safe lock, the traverse path should ends at a
> dependency --(*N)-->. Note when we search backwards, --(*N)--> indicates
> a real dependency --(N*)-->.
> 
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
>  kernel/locking/lockdep.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index 0b0ad3db78b4..bd3eef664f9d 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -1504,7 +1504,14 @@ check_redundant(struct lock_list *root, struct held_lock *target,
>  
>  static inline int usage_match(struct lock_list *entry, void *bit)
>  {
> -	return entry->class->usage_mask & (1 << (enum lock_usage_bit)bit);
> +	enum lock_usage_bit ub = (enum lock_usage_bit)bit;
> +
> +
> +	if (ub & 1)
> +		return entry->class->usage_mask & (1 << ub) &&
> +		       !entry->is_rr;
> +	else
> +		return entry->class->usage_mask & (1 << ub);
>  }

The whole is_rr/have_xr thing and backwards hurts my brain. That really
wants more than a little 'Note'.

Also, the above is unreadable, something like:

	unsigned long usage_mask = entry->class->usage_mask;
	enum lock_usage_bit ub = (enum lock_usage_bit)bit;
	unsigned long mask = 1ULL << ub;

	if (ub & 1) /* __STATE_RR */
		return !entry->have_xr && (usage_mask & mask);

	return !!(usage_mask & mask);

maybe. Also, perhaps we should make __bfs(.match) have a bool return
value.
