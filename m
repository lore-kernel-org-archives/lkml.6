Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752765AbeAaMjt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 07:39:49 -0500
Received: from merlin.infradead.org ([205.233.59.134]:45094 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751700AbeAaMjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 07:39:08 -0500
Date: Wed, 31 Jan 2018 13:38:59 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Will Deacon <will.deacon@arm.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH] locking/qspinlock: Ensure node is initialised before
 updating prev->next
Message-ID: <20180131123859.GQ2269@hirez.programming.kicks-ass.net>
References: <1517401246-2750-1-git-send-email-will.deacon@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517401246-2750-1-git-send-email-will.deacon@arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31, 2018 at 12:20:46PM +0000, Will Deacon wrote:
> diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
> index 294294c71ba4..1ebbc366a31d 100644
> --- a/kernel/locking/qspinlock.c
> +++ b/kernel/locking/qspinlock.c
> @@ -408,16 +408,15 @@ void queued_spin_lock_slowpath(struct qspinlock *lock, u32 val)
>  	 */
>  	if (old & _Q_TAIL_MASK) {
>  		prev = decode_tail(old);
> +
>  		/*
> -		 * The above xchg_tail() is also a load of @lock which generates,
> -		 * through decode_tail(), a pointer.
> -		 *
> -		 * The address dependency matches the RELEASE of xchg_tail()
> -		 * such that the access to @prev must happen after.
> +		 * We must ensure that the stores to @node are observed before
> +		 * the write to prev->next. The address dependency on xchg_tail
> +		 * is not sufficient to ensure this because the read component
> +		 * of xchg_tail is unordered with respect to the initialisation
> +		 * of node.
>  		 */
> -		smp_read_barrier_depends();

Right, except you're patching old code here, please try again on a tree
that includes commit:

  548095dea63f ("locking: Remove smp_read_barrier_depends() from queued_spin_lock_slowpath()")

> -
> -		WRITE_ONCE(prev->next, node);
> +		smp_store_release(prev->next, node);
>  
>  		pv_wait_node(node, prev);
>  		arch_mcs_spin_lock_contended(&node->locked);
> -- 
> 2.1.4
> 
