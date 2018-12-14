Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A52C5C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 18:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5CC3206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 18:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p4SIkxRD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730607AbeLNSN1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 13:13:27 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52046 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730529AbeLNSN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 13:13:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hJgdCg3vo8DncaMxqltTQlCPcSmHyP7PsXzqm69fGvM=; b=p4SIkxRDWEPrQReEhLrqhbT4s
        UrWMN5JLc9yjwLV6ISb+69yYVsrbC6bUF8W8+NHiuE39P3ZzXPMooynuxvn1mq23h/Dcv6pfZ/PKy
        Fb6uLm85mwcbqoJmWICj3jLUoVj/87sr7B7ylfIIOQrShesqh8fyUsiLmbhAm4HGnC2iJzKJKVaDK
        bZHJvBMO8FgMuQOMNvHdCYdSnHPQU33fqaTSeo8XGzMXXFNMzjTlMReOs++0jz/d2UeYwxzT+VvhF
        G/uHYbNyKSuHrGbC1pquyjSZ40JJjMr7ekHxRnEm4T8pBfGZ6Myo1oe13iqqUIsgjRbe9poT7RhJa
        bEgDnBc6w==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gXrxi-00081u-S8; Fri, 14 Dec 2018 18:13:22 +0000
Date:   Fri, 14 Dec 2018 10:13:22 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Roman Gushchin <guroan@gmail.com>
Cc:     linux-mm@kvack.org, Alexey Dobriyan <adobriyan@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        kernel-team@fb.com, Roman Gushchin <guro@fb.com>
Subject: Re: [RFC 2/4] mm: separate memory allocation and actual work in
 alloc_vmap_area()
Message-ID: <20181214181322.GC10600@bombadil.infradead.org>
References: <20181214180720.32040-1-guro@fb.com>
 <20181214180720.32040-3-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181214180720.32040-3-guro@fb.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 10:07:18AM -0800, Roman Gushchin wrote:
> alloc_vmap_area() is allocating memory for the vmap_area, and
> performing the actual lookup of the vm area and vmap_area
> initialization.
> 
> This prevents us from using a pre-allocated memory for the map_area
> structure, which can be used in some cases to minimize the number
> of required memory allocations.
> 
> Let's keep the memory allocation part in alloc_vmap_area() and
> separate everything else into init_vmap_area().

Oh good, I was considering doing something like this eventually.

> +++ b/mm/vmalloc.c
> @@ -395,16 +395,11 @@ static void purge_vmap_area_lazy(void);
>  
>  static BLOCKING_NOTIFIER_HEAD(vmap_notify_list);
>  
> -/*
> - * Allocate a region of KVA of the specified size and alignment, within the
> - * vstart and vend.
> - */
> -static struct vmap_area *alloc_vmap_area(unsigned long size,
> -				unsigned long align,
> -				unsigned long vstart, unsigned long vend,
> -				int node, gfp_t gfp_mask)
> +static int init_vmap_area(struct vmap_area *va, unsigned long size,
> +			  unsigned long align, unsigned long vstart,
> +			  unsigned long vend, int node, gfp_t gfp_mask)
>  {
> -	struct vmap_area *va;
> +

Why the blank line?

>  	struct rb_node *n;
>  	unsigned long addr;
>  	int purged = 0;
> @@ -416,11 +411,6 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
>  
>  	might_sleep();
>  
> -	va = kmalloc_node(sizeof(struct vmap_area),
> -			gfp_mask & GFP_RECLAIM_MASK, node);
> -	if (unlikely(!va))
> -		return ERR_PTR(-ENOMEM);
> -
>  	/*
>  	 * Only scan the relevant parts containing pointers to other objects
>  	 * to avoid false negatives.
> @@ -512,7 +502,7 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
>  	BUG_ON(va->va_start < vstart);
>  	BUG_ON(va->va_end > vend);
>  
> -	return va;
> +	return 0;
>  
>  overflow:
>  	spin_unlock(&vmap_area_lock);
> @@ -534,10 +524,38 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
>  	if (!(gfp_mask & __GFP_NOWARN) && printk_ratelimit())
>  		pr_warn("vmap allocation for size %lu failed: use vmalloc=<size> to increase size\n",
>  			size);
> -	kfree(va);
> -	return ERR_PTR(-EBUSY);
> +
> +	return -EBUSY;
> +}
> +
> +/*
> + * Allocate a region of KVA of the specified size and alignment, within the
> + * vstart and vend.
> + */
> +static struct vmap_area *alloc_vmap_area(unsigned long size,
> +					 unsigned long align,
> +					 unsigned long vstart,
> +					 unsigned long vend,
> +					 int node, gfp_t gfp_mask)
> +{
> +	struct vmap_area *va;
> +	int ret;
> +
> +	va = kmalloc_node(sizeof(struct vmap_area),
> +			gfp_mask & GFP_RECLAIM_MASK, node);
> +	if (unlikely(!va))
> +		return ERR_PTR(-ENOMEM);
> +
> +	ret = init_vmap_area(va, size, align, vstart, vend, node, gfp_mask);
> +	if (ret) {
> +		kfree(va);
> +		return ERR_PTR(ret);
> +	}
> +
> +	return va;
>  }
>  
> +

Another spurious blank line?

With these two fixed,
Reviewed-by: Matthew Wilcox <willy@infradead.org>

