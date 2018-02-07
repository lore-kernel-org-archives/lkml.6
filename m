Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753409AbeBGIHq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 03:07:46 -0500
Received: from bombadil.infradead.org ([65.50.211.133]:46859 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753156AbeBGIHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 03:07:45 -0500
Date: Wed, 7 Feb 2018 09:07:40 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Joel Fernandes <joelaf@google.com>
Cc: linux-kernel@vger.kernel.org, mhocko@kernel.org, minchan@kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH RFC] ashmem: Fix lockdep RECLAIM_FS false positive
Message-ID: <20180207080740.GH2269@hirez.programming.kicks-ass.net>
References: <20180206004903.224390-1-joelaf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180206004903.224390-1-joelaf@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 05, 2018 at 04:49:03PM -0800, Joel Fernandes wrote:

> [ 2115.359650] -(1)[106:kswapd0]=================================
> [ 2115.359665] -(1)[106:kswapd0][ INFO: inconsistent lock state ]
> [ 2115.359684] -(1)[106:kswapd0]4.9.60+ #2 Tainted: G        W  O
> [ 2115.359699] -(1)[106:kswapd0]---------------------------------
> [ 2115.359715] -(1)[106:kswapd0]inconsistent {RECLAIM_FS-ON-W} ->
> {IN-RECLAIM_FS-W} usage.

Please don't wrap log output, this is unreadable :/

Also, the output is from an ancient kernel and doesn't match the current
code.

> ---
>  drivers/staging/android/ashmem.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/ashmem.c
> index 372ce9913e6d..7e060f32aaa8 100644
> --- a/drivers/staging/android/ashmem.c
> +++ b/drivers/staging/android/ashmem.c
> @@ -32,6 +32,7 @@
>  #include <linux/bitops.h>
>  #include <linux/mutex.h>
>  #include <linux/shmem_fs.h>
> +#include <linux/sched/mm.h>
>  #include "ashmem.h"
>  
>  #define ASHMEM_NAME_PREFIX "dev/ashmem/"
> @@ -446,8 +447,17 @@ ashmem_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
>  	if (!(sc->gfp_mask & __GFP_FS))
>  		return SHRINK_STOP;
>  
> -	if (!mutex_trylock(&ashmem_mutex))
> +	/*
> +	 * Release reclaim-fs marking since we've already checked GFP_FS, This
> +	 * will prevent lockdep's reclaim recursion deadlock false positives.
> +	 * We'll renable it before returning from this function.
> +	 */
> +	fs_reclaim_release(sc->gfp_mask);
> +
> +	if (!mutex_trylock(&ashmem_mutex)) {
> +		fs_reclaim_acquire(sc->gfp_mask);
>  		return -1;
> +	}
>  
>  	list_for_each_entry_safe(range, next, &ashmem_lru_list, lru) {
>  		loff_t start = range->pgstart * PAGE_SIZE;
> @@ -464,6 +474,8 @@ ashmem_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
>  			break;
>  	}
>  	mutex_unlock(&ashmem_mutex);
> +
> +	fs_reclaim_acquire(sc->gfp_mask);
>  	return freed;
>  }

Yuck that is horrible.. so if GFP_FS was set, we bail, but if GFP_FS
wasn't set, why is fs_reclaim_*() doing anything at all?

That is, __need_fd_reclaim() should return false when !GFP_FS.
