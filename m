Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D59C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 14:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72E3820837
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 14:59:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72E3820837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933270AbeFUO7v (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 10:59:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:60877 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932981AbeFUO7u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 10:59:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 210BEAC69;
        Thu, 21 Jun 2018 14:59:49 +0000 (UTC)
Date:   Thu, 21 Jun 2018 16:59:47 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     akpm@linux-foundation.org, jthumshirn@suse.de, cl@linux.com,
        kstewart@linuxfoundation.org, pombredanne@nexb.com,
        gregkh@linuxfoundation.org, dvyukov@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: mempool: Remove unused argument in
 kasan_unpoison_element() and remove_element()
Message-ID: <20180621145947.GA13063@dhcp22.suse.cz>
References: <20180621070332.16633-1-baijiaju1990@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621070332.16633-1-baijiaju1990@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 21-06-18 15:03:32, Jia-Ju Bai wrote:
> The argument "gfp_t flags" is not used in kasan_unpoison_element() 
> and remove_element(), so remove it.

yeah, seems like left over from 9b75a867cc9d ("mm: mempool: kasan: don't
poot mempool objects in quarantine")
 
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/mempool.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/mempool.c b/mm/mempool.c
> index 5c9dce34719b..3076ab3f7bc4 100644
> --- a/mm/mempool.c
> +++ b/mm/mempool.c
> @@ -111,7 +111,7 @@ static __always_inline void kasan_poison_element(mempool_t *pool, void *element)
>  		kasan_free_pages(element, (unsigned long)pool->pool_data);
>  }
>  
> -static void kasan_unpoison_element(mempool_t *pool, void *element, gfp_t flags)
> +static void kasan_unpoison_element(mempool_t *pool, void *element)
>  {
>  	if (pool->alloc == mempool_alloc_slab || pool->alloc == mempool_kmalloc)
>  		kasan_unpoison_slab(element);
> @@ -127,12 +127,12 @@ static __always_inline void add_element(mempool_t *pool, void *element)
>  	pool->elements[pool->curr_nr++] = element;
>  }
>  
> -static void *remove_element(mempool_t *pool, gfp_t flags)
> +static void *remove_element(mempool_t *pool)
>  {
>  	void *element = pool->elements[--pool->curr_nr];
>  
>  	BUG_ON(pool->curr_nr < 0);
> -	kasan_unpoison_element(pool, element, flags);
> +	kasan_unpoison_element(pool, element);
>  	check_element(pool, element);
>  	return element;
>  }
> @@ -151,7 +151,7 @@ void mempool_destroy(mempool_t *pool)
>  		return;
>  
>  	while (pool->curr_nr) {
> -		void *element = remove_element(pool, GFP_KERNEL);
> +		void *element = remove_element(pool);
>  		pool->free(element, pool->pool_data);
>  	}
>  	kfree(pool->elements);
> @@ -247,7 +247,7 @@ int mempool_resize(mempool_t *pool, int new_min_nr)
>  	spin_lock_irqsave(&pool->lock, flags);
>  	if (new_min_nr <= pool->min_nr) {
>  		while (new_min_nr < pool->curr_nr) {
> -			element = remove_element(pool, GFP_KERNEL);
> +			element = remove_element(pool);
>  			spin_unlock_irqrestore(&pool->lock, flags);
>  			pool->free(element, pool->pool_data);
>  			spin_lock_irqsave(&pool->lock, flags);
> @@ -333,7 +333,7 @@ void *mempool_alloc(mempool_t *pool, gfp_t gfp_mask)
>  
>  	spin_lock_irqsave(&pool->lock, flags);
>  	if (likely(pool->curr_nr)) {
> -		element = remove_element(pool, gfp_temp);
> +		element = remove_element(pool);
>  		spin_unlock_irqrestore(&pool->lock, flags);
>  		/* paired with rmb in mempool_free(), read comment there */
>  		smp_wmb();
> -- 
> 2.17.0

-- 
Michal Hocko
SUSE Labs
