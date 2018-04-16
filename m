Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752250AbeDPP6g (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 11:58:36 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:50453 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751211AbeDPP6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 11:58:35 -0400
Date: Mon, 16 Apr 2018 08:58:32 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Vitaly Wool <vitalywool@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, mawilcox@microsoft.com,
        asavery@chromium.org, gwendal@chromium.org
Subject: Re: Crashes/hung tasks with z3pool under memory pressure
Message-ID: <20180416155832.GB12015@roeck-us.net>
References: <20180412215501.GA16406@roeck-us.net>
 <CAMJBoFMq8DoWdcrajB_xyMrGXsUsbMjos_U60mOvf01MpK_9Kw@mail.gmail.com>
 <20180413173555.GA30587@roeck-us.net>
 <CAMJBoFPXObpXyQWz-zPJ7JnC-Z5FqqrLfr5BFWKdh+szZrPZ7A@mail.gmail.com>
 <20180413175615.GA30242@roeck-us.net>
 <b241e25a-50a3-fefb-0443-ad6c0a200898@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b241e25a-50a3-fefb-0443-ad6c0a200898@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 16, 2018 at 02:43:01PM +0200, Vitaly Wool wrote:
> Hey Guenter,
> 
> On 04/13/2018 07:56 PM, Guenter Roeck wrote:
> 
> >On Fri, Apr 13, 2018 at 05:40:18PM +0000, Vitaly Wool wrote:
> >>On Fri, Apr 13, 2018, 7:35 PM Guenter Roeck <linux@roeck-us.net> wrote:
> >>
> >>>On Fri, Apr 13, 2018 at 05:21:02AM +0000, Vitaly Wool wrote:
> >>>>Hi Guenter,
> >>>>
> >>>>
> >>>>Den fre 13 apr. 2018 kl 00:01 skrev Guenter Roeck <linux@roeck-us.net>:
> >>>>
> >>>>>Hi all,
> >>>>>we are observing crashes with z3pool under memory pressure. The kernel
> >>>>version
> >>>>>used to reproduce the problem is v4.16-11827-g5d1365940a68, but the
> >>>>problem was
> >>>>>also seen with v4.14 based kernels.
> >>>>
> >>>>just before I dig into this, could you please try reproducing the errors
> >>>>you see with https://patchwork.kernel.org/patch/10210459/ applied?
> >>>>
> >>>As mentioned above, I tested with v4.16-11827-g5d1365940a68, which already
> >>>includes this patch.
> >>>
> >>Bah. Sorry. Expect an update after the weekend.
> >>
> >NP; easy to miss. Thanks a lot for looking into it.
> >
> I wonder if the following patch would make a difference:
> 
> diff --git a/mm/z3fold.c b/mm/z3fold.c
> index c0bca6153b95..5e547c2d5832 100644
> --- a/mm/z3fold.c
> +++ b/mm/z3fold.c
> @@ -887,19 +887,21 @@ static int z3fold_reclaim_page(struct z3fold_pool *pool, unsigned int retries)
>  				goto next;
>  		}
>  next:
> -		spin_lock(&pool->lock);
>  		if (test_bit(PAGE_HEADLESS, &page->private)) {
>  			if (ret == 0) {
> -				spin_unlock(&pool->lock);
>  				free_z3fold_page(page);
>  				return 0;
>  			}
> -		} else if (kref_put(&zhdr->refcount, release_z3fold_page)) {
> -			atomic64_dec(&pool->pages_nr);
> -			spin_unlock(&pool->lock);
> -			return 0;
> +		} else {
> +			spin_lock(&zhdr->page_lock);
> +			if (kref_put(&zhdr->refcount, release_z3fold_page_locked)) {
> +				atomic64_dec(&pool->pages_nr);
> +				return 0;
> +			}
> +			spin_unlock(&zhdr->page_lock);
>  		}
> +		spin_lock(&pool->lock);
>  		/*
>  		 * Add to the beginning of LRU.
>  		 * Pool lock has to be kept here to ensure the page has
> 
No, it doesn't. Same crash.

BUG: MAX_LOCK_DEPTH too low!
turning off the locking correctness validator.
depth: 48  max: 48!
48 locks held by kswapd0/51:
 #0: 000000004d7a35a9 (&(&pool->lock)->rlock#3){+.+.}, at: z3fold_zpool_shrink+0x47/0x3e0
 #1: 000000007739f49e (&(&zhdr->page_lock)->rlock){+.+.}, at: z3fold_zpool_shrink+0xb7/0x3e0
 #2: 00000000ff6cd4c8 (&(&zhdr->page_lock)->rlock){+.+.}, at: z3fold_zpool_shrink+0xb7/0x3e0
 #3: 000000004cffc6cb (&(&zhdr->page_lock)->rlock){+.+.}, at: z3fold_zpool_shrink+0xb7/0x3e0
...
PU: 0 PID: 51 Comm: kswapd0 Not tainted 4.17.0-rc1-yocto-standard+ #11
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.10.2-1 04/01/2014
Call Trace:
 dump_stack+0x67/0x9b
 __lock_acquire+0x429/0x18f0
 ? __lock_acquire+0x2af/0x18f0
 ? __lock_acquire+0x2af/0x18f0
 ? lock_acquire+0x93/0x230
 lock_acquire+0x93/0x230
 ? z3fold_zpool_shrink+0xb7/0x3e0
 _raw_spin_trylock+0x65/0x80
 ? z3fold_zpool_shrink+0xb7/0x3e0
 ? z3fold_zpool_shrink+0x47/0x3e0
 z3fold_zpool_shrink+0xb7/0x3e0
 zswap_frontswap_store+0x180/0x7c0
...
BUG: sleeping function called from invalid context at mm/page_alloc.c:4320
in_atomic(): 1, irqs_disabled(): 0, pid: 51, name: kswapd0
INFO: lockdep is turned off.
Preemption disabled at:
[<0000000000000000>]           (null)
CPU: 0 PID: 51 Comm: kswapd0 Not tainted 4.17.0-rc1-yocto-standard+ #11
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.10.2-1 04/01/2014
Call Trace:
 dump_stack+0x67/0x9b
 ___might_sleep+0x16c/0x250
 __alloc_pages_nodemask+0x1e7/0x1490
 ? lock_acquire+0x93/0x230
 ? lock_acquire+0x93/0x230
 __read_swap_cache_async+0x14d/0x260
 zswap_writeback_entry+0xdb/0x340
 z3fold_zpool_shrink+0x2b1/0x3e0
 zswap_frontswap_store+0x180/0x7c0
 ? page_vma_mapped_walk+0x22/0x230
 __frontswap_store+0x6e/0xf0
 swap_writepage+0x49/0x70
...

This is with your patch applied on top of v4.17-rc1.

Guenter
