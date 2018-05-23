Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754813AbeEWQmJ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 12:42:09 -0400
Received: from foss.arm.com ([217.140.101.70]:58372 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754661AbeEWQmH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 12:42:07 -0400
Date: Wed, 23 May 2018 17:42:34 +0100
From: Will Deacon <will.deacon@arm.com>
To: Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] perf/ring_buffer: ensure atomicity and order of updates
Message-ID: <20180523164234.GJ2983@arm.com>
References: <20180510130632.34497-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180510130632.34497-1-mark.rutland@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 10, 2018 at 02:06:32PM +0100, Mark Rutland wrote:
> Userspace can read/write the user page at any point in time, and in
> perf_output_put_handle() we're very careful to use memory barriers to
> ensure ordering between updates to data and the user page.
> 
> We don't use barriers when updating aux_head, where similar ordering
> constraints apply. This could result in userspace seeing stale data, or
> data being overwritten while userspace was still consuming it.
> 
> Further, we update data_head and aux_head with plain assignments, which
> the compiler can tear, potentially resulting in userspace seeing
> erroneous values.
> 
> We can solve both of these problems by using smp_store_release to update
> data_head and aux_head, so let's do so.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  kernel/events/ring_buffer.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
> index 6c6b3c48db71..839b207e4c77 100644
> --- a/kernel/events/ring_buffer.c
> +++ b/kernel/events/ring_buffer.c
> @@ -63,10 +63,10 @@ static void perf_output_put_handle(struct perf_output_handle *handle)
>  	 *   kernel				user
>  	 *
>  	 *   if (LOAD ->data_tail) {		LOAD ->data_head
> -	 *			(A)		smp_rmb()	(C)
> +	 *				(A) 	smp_rmb()	(C)
>  	 *	STORE $data			LOAD $data
> -	 *	smp_wmb()	(B)		smp_mb()	(D)
> -	 *	STORE ->data_head		STORE ->data_tail
> +	 *					smp_mb()	(D)
> +	 *	RELEASE ->data_head	(B)	STORE ->data_tail
>  	 *   }

One thing to be aware of here is that the choice of ordering primitive (e.g.
using fences vs acquire/release operations) has the potential to create
ABI with userspace. I don't know of any architectures which currently care,
but if were were to merge a non multi-copy atomic architecture with native
acquire/release instructions, you could see issues if e.g. userspace used
smp_rmb(); READ_ONCE but the kernel used a RELEASE store.

Anyway, that's currently theoretical, but I think it's an argument for
putting these accessors in a uapi header.

Will
