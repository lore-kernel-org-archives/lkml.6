Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933497AbeE1Ju2 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 05:50:28 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:40950 "EHLO
        deadmen.hmeau.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932300AbeE1JuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 05:50:06 -0400
Date: Mon, 28 May 2018 17:49:56 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: akpm@linux-foundation.org, torvalds@linux-foundation.org,
        tgraf@suug.ch, manfred@colorfullife.com,
        guillaume.knispel@supersonicimagine.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 2/6] lib/rhashtable: guarantee initial hashtable
 allocation
Message-ID: <20180528094956.zaxusqqju3wtbdcz@gondor.apana.org.au>
References: <20180524211135.27760-1-dave@stgolabs.net>
 <20180524211135.27760-3-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180524211135.27760-3-dave@stgolabs.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2018 at 02:11:31PM -0700, Davidlohr Bueso wrote:
>
> -static struct bucket_table *bucket_table_alloc(struct rhashtable *ht,
> -					       size_t nbuckets,
> -					       gfp_t gfp)
> +static struct bucket_table *__bucket_table_alloc(struct rhashtable *ht,
> +						 size_t nbuckets,
> +						 gfp_t gfp, bool retry)
>  {
>  	struct bucket_table *tbl = NULL;
>  	size_t size, max_locks;
>  	int i;
>  
>  	size = sizeof(*tbl) + nbuckets * sizeof(tbl->buckets[0]);
> +	if (retry) {
> +		gfp |= __GFP_NOFAIL;
> +		tbl = kzalloc(size, gfp);
> +	} /* fall-through */

I'd prefer this logic to be moved to the caller.  So just call the
function with GFP_KERNEL | __GFP_NOFAIL.

Of course you need to modify bucket_table_alloc so that it still
treats this as GFP_KERNEL (as opposed to GFP_ATOMIC).  That is,
instead of 

>  	if (gfp != GFP_KERNEL)

You will need
	if ((gfp & ~__GFP_NOFAIL) != GFP_KERNEL)

> @@ -1067,9 +1086,20 @@ int rhashtable_init(struct rhashtable *ht,
>  		}
>  	}
>  
> +	/*
> +	 * This is api initialization and thus we need to guarantee the
> +	 * initial rhashtable allocation. Upon failure, retry with a
> +	 * smallest possible size, otherwise we exhaust our options with
> +	 * __GFP_NOFAIL.
> +	 */
>  	tbl = bucket_table_alloc(ht, size, GFP_KERNEL);
> -	if (tbl == NULL)
> -		return -ENOMEM;
> +	if (unlikely(tbl == NULL)) {
> +		size = HASH_MIN_SIZE;
> +
> +		tbl = bucket_table_alloc(ht, size, GFP_KERNEL);
> +		if (tbl == NULL)
> +			tbl = bucket_table_alloc_retry(ht, size, GFP_KERNEL);
> +	}

Perhaps you should also explain here why we don't just try the
minimum size with __GFP_NOFAIL as the second step rather than the
third.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
