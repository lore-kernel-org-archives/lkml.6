Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754761AbeD3PuM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 11:50:12 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:48357 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754526AbeD3PuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 11:50:08 -0400
Date: Mon, 30 Apr 2018 08:50:06 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Vitaly Wool <vitalywool@gmail.com>
Cc: linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>, Oleksiy.Avramchenko@sony.com,
        Matthew Wilcox <mawilcox@microsoft.com>, stable@kernel.org
Subject: Re: [PATCH] z3fold: fix reclaim lock-ups
Message-ID: <20180430155006.GA19372@roeck-us.net>
References: <20180430125800.444cae9706489f412ad12621@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180430125800.444cae9706489f412ad12621@gmail.com>
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

On Mon, Apr 30, 2018 at 12:58:00PM +0200, Vitaly Wool wrote:
> Do not try to optimize in-page object layout while the page is
> under reclaim. This fixes lock-ups on reclaim and improves reclaim
> performance at the same time.
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Vitaly Wool <vitaly.vul@sony.com>

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  mm/z3fold.c | 42 ++++++++++++++++++++++++++++++------------
>  1 file changed, 30 insertions(+), 12 deletions(-)
> 
> diff --git a/mm/z3fold.c b/mm/z3fold.c
> index c0bca6153b95..901c0b07cbda 100644
> --- a/mm/z3fold.c
> +++ b/mm/z3fold.c
> @@ -144,7 +144,8 @@ enum z3fold_page_flags {
>  	PAGE_HEADLESS = 0,
>  	MIDDLE_CHUNK_MAPPED,
>  	NEEDS_COMPACTING,
> -	PAGE_STALE
> +	PAGE_STALE,
> +	UNDER_RECLAIM
>  };
>  
>  /*****************
> @@ -173,6 +174,7 @@ static struct z3fold_header *init_z3fold_page(struct page *page,
>  	clear_bit(MIDDLE_CHUNK_MAPPED, &page->private);
>  	clear_bit(NEEDS_COMPACTING, &page->private);
>  	clear_bit(PAGE_STALE, &page->private);
> +	clear_bit(UNDER_RECLAIM, &page->private);
>  
>  	spin_lock_init(&zhdr->page_lock);
>  	kref_init(&zhdr->refcount);
> @@ -756,6 +758,10 @@ static void z3fold_free(struct z3fold_pool *pool, unsigned long handle)
>  		atomic64_dec(&pool->pages_nr);
>  		return;
>  	}
> +	if (test_bit(UNDER_RECLAIM, &page->private)) {
> +		z3fold_page_unlock(zhdr);
> +		return;
> +	}
>  	if (test_and_set_bit(NEEDS_COMPACTING, &page->private)) {
>  		z3fold_page_unlock(zhdr);
>  		return;
> @@ -840,6 +846,8 @@ static int z3fold_reclaim_page(struct z3fold_pool *pool, unsigned int retries)
>  			kref_get(&zhdr->refcount);
>  			list_del_init(&zhdr->buddy);
>  			zhdr->cpu = -1;
> +			set_bit(UNDER_RECLAIM, &page->private);
> +			break;
>  		}
>  
>  		list_del_init(&page->lru);
> @@ -887,25 +895,35 @@ static int z3fold_reclaim_page(struct z3fold_pool *pool, unsigned int retries)
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
> +			spin_lock(&pool->lock);
> +			list_add(&page->lru, &pool->lru);
> +			spin_unlock(&pool->lock);
> +		} else {
> +			z3fold_page_lock(zhdr);
> +			clear_bit(UNDER_RECLAIM, &page->private);
> +			 if (kref_put(&zhdr->refcount,
> +					release_z3fold_page_locked)) {
> +				atomic64_dec(&pool->pages_nr);
> +				return 0;
> +			}
> +			/*
> +			 * if we are here, the page is still not completely
> +			 * free. Take the global pool lock then to be able
> +			 * to add it back to the lru list
> +			 */
> +			spin_lock(&pool->lock);
> +			list_add(&page->lru, &pool->lru);
>  			spin_unlock(&pool->lock);
> -			return 0;
> +			z3fold_page_unlock(zhdr);
>  		}
>  
> -		/*
> -		 * Add to the beginning of LRU.
> -		 * Pool lock has to be kept here to ensure the page has
> -		 * not already been released
> -		 */
> -		list_add(&page->lru, &pool->lru);
> +		/* We started off locked to we need to lock the pool back */
> +		spin_lock(&pool->lock);
>  	}
>  	spin_unlock(&pool->lock);
>  	return -EAGAIN;
> -- 
> 2.15.1
