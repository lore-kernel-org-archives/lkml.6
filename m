Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755865AbeEABpl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 21:45:41 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:39123 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751429AbeEABpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 21:45:39 -0400
X-Google-Smtp-Source: AB8JxZoJV+Bnl329C1+uk2RHwI2lF6sMoXSJE0SLmabXtBLPf0xLqpQ9kXvpaQZXp8pt1AsXnOpT4g==
Subject: Re: [PATCH] z3fold: fix reclaim lock-ups
To: Vitaly Wool <vitalywool@gmail.com>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>
Cc: Oleksiy.Avramchenko@sony.com, Matthew Wilcox <mawilcox@microsoft.com>,
        stable@kernel.org, asavery@chromium.org
References: <20180430125800.444cae9706489f412ad12621@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <e1364949-5c3e-d175-0764-e6d497734284@roeck-us.net>
Date: Mon, 30 Apr 2018 18:45:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180430125800.444cae9706489f412ad12621@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vitaly,

On 04/30/2018 03:58 AM, Vitaly Wool wrote:
> Do not try to optimize in-page object layout while the page is
> under reclaim. This fixes lock-ups on reclaim and improves reclaim
> performance at the same time.
> 

A heads-up: z3fold is still crashing (due to a NULL pointer access) under
heavy memory pressure with this patch applied. That doesn't mean the patch
should not be applied - the new crash is different - but there is more work
to do.

See https://bugs.chromium.org/p/chromium/issues/detail?id=822360#c21 for a
crash log. This was seen with chromeos-4.14 with (I hope) all relevant z3fold
patches applied. I am trying to reproduce the problem on top of mainline.

Guenter

> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Vitaly Wool <vitaly.vul@sony.com>
> ---
>   mm/z3fold.c | 42 ++++++++++++++++++++++++++++++------------
>   1 file changed, 30 insertions(+), 12 deletions(-)
> 
> diff --git a/mm/z3fold.c b/mm/z3fold.c
> index c0bca6153b95..901c0b07cbda 100644
> --- a/mm/z3fold.c
> +++ b/mm/z3fold.c
> @@ -144,7 +144,8 @@ enum z3fold_page_flags {
>   	PAGE_HEADLESS = 0,
>   	MIDDLE_CHUNK_MAPPED,
>   	NEEDS_COMPACTING,
> -	PAGE_STALE
> +	PAGE_STALE,
> +	UNDER_RECLAIM
>   };
>   
>   /*****************
> @@ -173,6 +174,7 @@ static struct z3fold_header *init_z3fold_page(struct page *page,
>   	clear_bit(MIDDLE_CHUNK_MAPPED, &page->private);
>   	clear_bit(NEEDS_COMPACTING, &page->private);
>   	clear_bit(PAGE_STALE, &page->private);
> +	clear_bit(UNDER_RECLAIM, &page->private);
>   
>   	spin_lock_init(&zhdr->page_lock);
>   	kref_init(&zhdr->refcount);
> @@ -756,6 +758,10 @@ static void z3fold_free(struct z3fold_pool *pool, unsigned long handle)
>   		atomic64_dec(&pool->pages_nr);
>   		return;
>   	}
> +	if (test_bit(UNDER_RECLAIM, &page->private)) {
> +		z3fold_page_unlock(zhdr);
> +		return;
> +	}
>   	if (test_and_set_bit(NEEDS_COMPACTING, &page->private)) {
>   		z3fold_page_unlock(zhdr);
>   		return;
> @@ -840,6 +846,8 @@ static int z3fold_reclaim_page(struct z3fold_pool *pool, unsigned int retries)
>   			kref_get(&zhdr->refcount);
>   			list_del_init(&zhdr->buddy);
>   			zhdr->cpu = -1;
> +			set_bit(UNDER_RECLAIM, &page->private);
> +			break;
>   		}
>   
>   		list_del_init(&page->lru);
> @@ -887,25 +895,35 @@ static int z3fold_reclaim_page(struct z3fold_pool *pool, unsigned int retries)
>   				goto next;
>   		}
>   next:
> -		spin_lock(&pool->lock);
>   		if (test_bit(PAGE_HEADLESS, &page->private)) {
>   			if (ret == 0) {
> -				spin_unlock(&pool->lock);
>   				free_z3fold_page(page);
>   				return 0;
>   			}
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
>   			spin_unlock(&pool->lock);
> -			return 0;
> +			z3fold_page_unlock(zhdr);
>   		}
>   
> -		/*
> -		 * Add to the beginning of LRU.
> -		 * Pool lock has to be kept here to ensure the page has
> -		 * not already been released
> -		 */
> -		list_add(&page->lru, &pool->lru);
> +		/* We started off locked to we need to lock the pool back */
> +		spin_lock(&pool->lock);
>   	}
>   	spin_unlock(&pool->lock);
>   	return -EAGAIN;
> 
