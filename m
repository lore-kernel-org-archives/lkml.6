Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752939AbeDRQIA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 12:08:00 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:33031 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750872AbeDRQH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 12:07:57 -0400
Date: Wed, 18 Apr 2018 09:07:55 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Vitaly Wool <vitalywool@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, mawilcox@microsoft.com,
        asavery@chromium.org, gwendal@chromium.org
Subject: Re: Crashes/hung tasks with z3pool under memory pressure
Message-ID: <20180418160755.GA10227@roeck-us.net>
References: <20180417160032.46915216@seldlx21914.corpusers.net>
 <20180418101317.74abe632@seldlx21914.corpusers.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180418101317.74abe632@seldlx21914.corpusers.net>
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

On Wed, Apr 18, 2018 at 10:13:17AM +0200, Vitaly Wool wrote:
> Den tis 17 apr. 2018 kl 18:35 skrev Guenter Roeck <linux@roeck-us.net>:
> 
> <snip>
> 
> > Getting better; the log is much less noisy. Unfortunately, there are still
> > locking problems, resulting in a hung task. I copied the log message to [1].
> > This is with [2] applied on top of v4.17-rc1.
> 
> Now this version (this is a full patch to be applied instead of the previous one) should have the above problem resolved too:
> 

Excellent - I can not reproduce the problem with this patch
applied.

Guenter

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

extra then ?

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
