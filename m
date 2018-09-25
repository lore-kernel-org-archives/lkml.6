Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 587BAC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1801E2086E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:41:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1801E2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729092AbeIYStG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 14:49:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:35032 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728773AbeIYStG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 14:49:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 10AF9AEA3;
        Tue, 25 Sep 2018 12:41:42 +0000 (UTC)
Subject: Re: [PATCH 2/2] panic fix for making cache device
To:     Dongbo Cao <cdbdyx@163.com>
Cc:     kent.overstreet@gmail.com, linux-bcache@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180925060945.6731-1-cdbdyx@163.com>
 <20180925060945.6731-2-cdbdyx@163.com>
From:   Coly Li <colyli@suse.de>
Message-ID: <e588a1a7-2fa7-a84a-2c74-11f503005dbd@suse.de>
Date:   Tue, 25 Sep 2018 20:41:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180925060945.6731-2-cdbdyx@163.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/25/18 2:09 PM, Dongbo Cao wrote:
> when the nbuckets of cache device is smaller than 1024, making cache device will trigger BUG_ON in kernel, add a condition to avoid this.
>
> Signed-off-by: Dongbo Cao <cdbdyx@163.com>

This patch added to my for-next, with minor change to fix checkpatch.pl 
warning.

Thanks.


Coly Li


> ---
>   drivers/md/bcache/super.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
> index 0c0f6d8f..47d122ed 100644
> --- a/drivers/md/bcache/super.c
> +++ b/drivers/md/bcache/super.c
> @@ -2036,7 +2036,12 @@ static int cache_alloc(struct cache *ca)
>   	 */
>   	btree_buckets = ca->sb.njournal_buckets ?: 8;
>   	free = roundup_pow_of_two(ca->sb.nbuckets) >> 10;
> -	
> +	if (!free) {
> +		ret = -EPERM;
> +		err = "ca->sb.nbuckets is too small";
> +		goto err_free;
> +	}
> +
>   	if (!init_fifo(&ca->free[RESERVE_BTREE], btree_buckets,
>   						GFP_KERNEL)) {
>   		err = "ca->free[RESERVE_BTREE] alloc failed";
> @@ -2102,6 +2107,7 @@ static int cache_alloc(struct cache *ca)
>   err_prio_alloc:
>   	free_fifo(&ca->free[RESERVE_BTREE]);
>   err_btree_alloc:
> +err_free:
>   	module_put(THIS_MODULE);
>   	if (err)
>   		pr_notice("error %s: %s", ca->cache_dev_name, err);
> @@ -2131,6 +2137,8 @@ static int register_cache(struct cache_sb *sb, struct page *sb_page,
>   		blkdev_put(bdev, FMODE_READ|FMODE_WRITE|FMODE_EXCL);
>   		if (ret == -ENOMEM)
>   			err = "cache_alloc(): -ENOMEM";
> +		else if (ret == -EPERM)
> +			err = "cache_alloc(): cache device is too small";
>   		else
>   			err = "cache_alloc(): unknown error";
>   		goto err;
