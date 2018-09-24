Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6BBBECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CB142098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 14:46:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CB142098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730220AbeIXUtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 16:49:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:43392 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729122AbeIXUtR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 16:49:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 80ED9AD4D;
        Mon, 24 Sep 2018 14:46:45 +0000 (UTC)
Subject: Re: [PATCH] bug fix for making cache device failed
To:     Dongbo Cao <cdbdyx@163.com>
Cc:     kent.overstreet@gmail.com, linux-bcache@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180921061418.3131-1-cdbdyx@163.com>
From:   Coly Li <colyli@suse.de>
Message-ID: <22662faa-22da-11c6-e093-c89ee86a448a@suse.de>
Date:   Mon, 24 Sep 2018 22:46:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180921061418.3131-1-cdbdyx@163.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/21/18 2:14 PM, Dongbo Cao wrote:
> 1)when the nbuckets of cache device is smaller than 1024, make cache device will trigger BUG_ON in kernel, add a condition to avoid this.
> 2)split original if condition code into separate ones to make it clearly to debug.
>
> Signed-off-by: Dongbo Cao <cdbdyx@163.com>

Hi Dongbo,


In general the patch is good to me. But could you please to split this 
patch into 2 patches?  One is for split original if-condition code, one 
is for the panic fix.

Then it might be more clear to me.

Thanks.

Coly Li


> ---
>   drivers/md/bcache/super.c | 87 ++++++++++++++++++++++++++++++++-------
>   1 file changed, 73 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
> index fa4058e4..47d122ed 100644
> --- a/drivers/md/bcache/super.c
> +++ b/drivers/md/bcache/super.c
> @@ -2017,6 +2017,8 @@ static int cache_alloc(struct cache *ca)
>   	size_t free;
>   	size_t btree_buckets;
>   	struct bucket *b;
> +	int ret = -ENOMEM;
> +	const char *err = NULL;
>   
>   	__module_get(THIS_MODULE);
>   	kobject_init(&ca->kobj, &bch_cache_ktype);
> @@ -2034,27 +2036,82 @@ static int cache_alloc(struct cache *ca)
>   	 */
>   	btree_buckets = ca->sb.njournal_buckets ?: 8;
>   	free = roundup_pow_of_two(ca->sb.nbuckets) >> 10;
> +	if (!free) {
> +		ret = -EPERM;
> +		err = "ca->sb.nbuckets is too small";
> +		goto err_free;
> +	}
>   
> -	if (!init_fifo(&ca->free[RESERVE_BTREE], btree_buckets, GFP_KERNEL) ||
> -	    !init_fifo_exact(&ca->free[RESERVE_PRIO], prio_buckets(ca), GFP_KERNEL) ||
> -	    !init_fifo(&ca->free[RESERVE_MOVINGGC], free, GFP_KERNEL) ||
> -	    !init_fifo(&ca->free[RESERVE_NONE], free, GFP_KERNEL) ||
> -	    !init_fifo(&ca->free_inc,	free << 2, GFP_KERNEL) ||
> -	    !init_heap(&ca->heap,	free << 3, GFP_KERNEL) ||
> -	    !(ca->buckets	= vzalloc(array_size(sizeof(struct bucket),
> -						     ca->sb.nbuckets))) ||
> -	    !(ca->prio_buckets	= kzalloc(array3_size(sizeof(uint64_t),
> -						      prio_buckets(ca), 2),
> -					  GFP_KERNEL)) ||
> -	    !(ca->disk_buckets	= alloc_bucket_pages(GFP_KERNEL, ca)))
> -		return -ENOMEM;
> +	if (!init_fifo(&ca->free[RESERVE_BTREE], btree_buckets,
> +						GFP_KERNEL)) {
> +		err = "ca->free[RESERVE_BTREE] alloc failed";
> +		goto err_btree_alloc;
> +	}
> +	if (!init_fifo_exact(&ca->free[RESERVE_PRIO], prio_buckets(ca),
> +							GFP_KERNEL)) {
> +		err = "ca->free[RESERVE_PRIO] alloc failed";
> +		goto err_prio_alloc;
> +	}
> +	if (!init_fifo(&ca->free[RESERVE_MOVINGGC], free, GFP_KERNEL)) {
> +		err = "ca->free[RESERVE_MOVINGGC] alloc failed";
> +		goto err_movinggc_alloc;
> +	}
> +	if (!init_fifo(&ca->free[RESERVE_NONE], free, GFP_KERNEL)) {
> +		err = "ca->free[RESERVE_NONE] alloc failed";
> +		goto err_none_alloc;
> +	}
> +	if (!init_fifo(&ca->free_inc, free << 2, GFP_KERNEL)) {
> +		err = "ca->free_inc alloc failed";
> +		goto err_free_inc_alloc;
> +	}
> +	if (!init_heap(&ca->heap, free << 3, GFP_KERNEL)) {
> +		err = "ca->heap alloc failed";
> +		goto err_heap_alloc;
> +	}
> +	if (!(ca->buckets = vzalloc(array_size(sizeof(struct bucket),
> +						ca->sb.nbuckets)))) {
> +		err = "ca->buckets alloc failed";
> +		goto err_buckets_alloc;
> +	}
> +	if (!(ca->prio_buckets = kzalloc(array3_size(sizeof(uint64_t),
> +						prio_buckets(ca), 2),
> +							GFP_KERNEL))) {
> +		err = "ca->prio_buckets alloc failed";
> +		goto err_prio_buckets_alloc;
> +	}
> +	if (!(ca->disk_buckets = alloc_bucket_pages(GFP_KERNEL, ca))) {
> +		err = "ca->disk_buckets alloc failed";
> +		goto err_disk_buckets_alloc;
> +	}
>   
>   	ca->prio_last_buckets = ca->prio_buckets + prio_buckets(ca);
>   
>   	for_each_bucket(b, ca)
>   		atomic_set(&b->pin, 0);
> -
>   	return 0;
> +
> +err_disk_buckets_alloc:
> +	kfree(ca->prio_buckets);
> +err_prio_buckets_alloc:
> +	vfree(ca->buckets);
> +err_buckets_alloc:
> +	free_heap(&ca->heap);
> +err_heap_alloc:
> +	free_fifo(&ca->free_inc);
> +err_free_inc_alloc:
> +	free_fifo(&ca->free[RESERVE_NONE]);
> +err_none_alloc:
> +	free_fifo(&ca->free[RESERVE_MOVINGGC]);
> +err_movinggc_alloc:
> +	free_fifo(&ca->free[RESERVE_PRIO]);
> +err_prio_alloc:
> +	free_fifo(&ca->free[RESERVE_BTREE]);
> +err_btree_alloc:
> +err_free:
> +	module_put(THIS_MODULE);
> +	if (err)
> +		pr_notice("error %s: %s", ca->cache_dev_name, err);
> +	return ret;
>   }
>   
>   static int register_cache(struct cache_sb *sb, struct page *sb_page,
> @@ -2080,6 +2137,8 @@ static int register_cache(struct cache_sb *sb, struct page *sb_page,
>   		blkdev_put(bdev, FMODE_READ|FMODE_WRITE|FMODE_EXCL);
>   		if (ret == -ENOMEM)
>   			err = "cache_alloc(): -ENOMEM";
> +		else if (ret == -EPERM)
> +			err = "cache_alloc(): cache device is too small";
>   		else
>   			err = "cache_alloc(): unknown error";
>   		goto err;
