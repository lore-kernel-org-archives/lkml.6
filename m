Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE774C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:41:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 809D02086E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:41:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 809D02086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbeIYSs3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 14:48:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:34926 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728773AbeIYSs3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 14:48:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EBC1FAEA3;
        Tue, 25 Sep 2018 12:41:03 +0000 (UTC)
Subject: Re: [PATCH 1/2] split original if-condition code into separate ones
To:     Dongbo Cao <cdbdyx@163.com>
Cc:     kent.overstreet@gmail.com, linux-bcache@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180925060945.6731-1-cdbdyx@163.com>
From:   Coly Li <colyli@suse.de>
Message-ID: <fa0710ef-8f08-d286-73f1-6873001733be@suse.de>
Date:   Tue, 25 Sep 2018 20:40:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180925060945.6731-1-cdbdyx@163.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/25/18 2:09 PM, Dongbo Cao wrote:
> to make it clearly to debug.
>
> Signed-off-by: Dongbo Cao <cdbdyx@163.com>

The patch added to my for-next, with minor changes to fix checkpatch.pl 
warnings.

Thanks.


Coly Li


> ---
>   drivers/md/bcache/super.c | 81 +++++++++++++++++++++++++++++++--------
>   1 file changed, 66 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
> index fa4058e4..0c0f6d8f 100644
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
> @@ -2034,27 +2036,76 @@ static int cache_alloc(struct cache *ca)
>   	 */
>   	btree_buckets = ca->sb.njournal_buckets ?: 8;
>   	free = roundup_pow_of_two(ca->sb.nbuckets) >> 10;
> -
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
> +	
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
> +	module_put(THIS_MODULE);
> +	if (err)
> +		pr_notice("error %s: %s", ca->cache_dev_name, err);
> +	return ret;
>   }
>   
>   static int register_cache(struct cache_sb *sb, struct page *sb_page,
