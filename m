Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752125AbeDJS02 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 14:26:28 -0400
Received: from foss.arm.com ([217.140.101.70]:41404 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752064AbeDJS0Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 14:26:25 -0400
Date: Tue, 10 Apr 2018 19:26:39 +0100
From: Will Deacon <will.deacon@arm.com>
To: Waiman Long <longman@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, boqun.feng@gmail.com,
        catalin.marinas@arm.com,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/2] locking/qspinlock: Limit # of spins in
 _Q_PENDING_VAL wait loop
Message-ID: <20180410182639.GI15514@arm.com>
References: <1523297332-22720-1-git-send-email-longman@redhat.com>
 <1523297332-22720-2-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523297332-22720-2-git-send-email-longman@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Waiman,

On Mon, Apr 09, 2018 at 02:08:52PM -0400, Waiman Long wrote:
> A locker in the pending code path is doing an infinite number of spins
> when waiting for the _Q_PENDING_VAL to _Q_LOCK_VAL transition. There
> is a concern that lock starvation can happen concurrent lockers are
> able to take the lock in the cmpxchg loop without queuing and pass it
> around amongst themselves.
> 
> To ensure forward progress while still taking advantage of using
> the pending code path without queuing, the code is now modified
> to do a limited number of spins before aborting the effort and
> going to queue itself.
> 
> Ideally, the spinning times should be at least a few times the typical
> cacheline load time from memory which I think can be down to 100ns or
> so for each cacheline load with the newest systems or up to several
> hundreds ns for older systems.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  kernel/locking/qspinlock.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
> index 634a49b..35367cc 100644
> --- a/kernel/locking/qspinlock.c
> +++ b/kernel/locking/qspinlock.c
> @@ -82,6 +82,15 @@
>  #endif
>  
>  /*
> + * The pending bit spinning loop count.
> + * This parameter can be overridden by another architecture specific
> + * constant. Default is 512.
> + */
> +#ifndef _Q_PENDING_LOOP
> +#define _Q_PENDING_LOOP	(1 << 9)
> +#endif

I really dislike heuristics like this because there's never a good number
to choose and it almost certainly varies between systems and workloads
rather than just by architecture. However, I've also not managed to come
up with something better.

If I rewrite your code slightly to look like:

	if (val == _Q_PENDING_VAL) {
		int cnt = _Q_PENDING_LOOP;
		val = atomic_cond_read_relaxed(&lock->val, (VAL != _Q_PENDING_VAL) || !cnt--);
	}

then architectures that implement atomic_cond_read_relaxed as something
more interesting than a spinning loop will probably be happy with
_Q_PENDING_LOOP == 1;

I'll post a v2 tomorrow with that change, and I'll add your stat patch to
the series too so that everything is kept together.

Will
