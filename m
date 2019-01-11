Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D1DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DA59218AE
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:26:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388472AbfAKT0W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 14:26:22 -0500
Received: from relay.sw.ru ([185.231.240.75]:43152 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726201AbfAKT0V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 14:26:21 -0500
Received: from [172.16.25.12]
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <aryabinin@virtuozzo.com>)
        id 1gi2Rd-0006qF-Sv; Fri, 11 Jan 2019 22:26:18 +0300
Subject: Re: [PATCH 2/3] mm/vmalloc: do not call kmemleak_free() on not yet
 accounted memory
To:     Roman Penyaev <rpenyaev@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Joe Perches <joe@perches.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20190103145954.16942-1-rpenyaev@suse.de>
 <20190103145954.16942-3-rpenyaev@suse.de>
From:   Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <b761b165-9892-0761-cd33-14300e39e36f@virtuozzo.com>
Date:   Fri, 11 Jan 2019 22:26:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190103145954.16942-3-rpenyaev@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/3/19 5:59 PM, Roman Penyaev wrote:
> __vmalloc_area_node() calls vfree() on error path, which in turn calls
> kmemleak_free(), but area is not yet accounted by kmemleak_vmalloc().
> 
> Signed-off-by: Roman Penyaev <rpenyaev@suse.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Cc: Joe Perches <joe@perches.com>
> Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  mm/vmalloc.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 2cd24186ba84..dc6a62bca503 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -1565,6 +1565,14 @@ void vfree_atomic(const void *addr)
>  	__vfree_deferred(addr);
>  }
>  
> +static void __vfree(const void *addr)
> +{
> +	if (unlikely(in_interrupt()))
> +		__vfree_deferred(addr);
> +	else
> +		__vunmap(addr, 1);
> +}
> +
>  /**
>   *	vfree  -  release memory allocated by vmalloc()
>   *	@addr:		memory base address
> @@ -1591,10 +1599,8 @@ void vfree(const void *addr)
>  
>  	if (!addr)
>  		return;
> -	if (unlikely(in_interrupt()))
> -		__vfree_deferred(addr);
> -	else
> -		__vunmap(addr, 1);
> +
> +	__vfree(addr);
>  }
>  EXPORT_SYMBOL(vfree);
>  
> @@ -1709,7 +1715,7 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
>  	warn_alloc(gfp_mask, NULL,
>  			  "vmalloc: allocation failure, allocated %ld of %ld bytes",
>  			  (area->nr_pages*PAGE_SIZE), area->size);
> -	vfree(area->addr);
> +	__vfree(area->addr);

This can't be an interrupt context for a several reasons. One of them is BUG_ON(in_interrupt()) in __get_vm_area_node()
which is called right before __vmalloc_are_node().

So you can just do __vunmap(area->addr, 1); instead of __vfree().


>  	return NULL;
>  }
>  
> 
