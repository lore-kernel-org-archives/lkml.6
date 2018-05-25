Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967072AbeEYPwJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 11:52:09 -0400
Received: from a9-112.smtp-out.amazonses.com ([54.240.9.112]:52464 "EHLO
        a9-112.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S966513AbeEYPv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 11:51:59 -0400
Date: Fri, 25 May 2018 15:51:57 +0000
From: Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To: Vlastimil Babka <vbabka@suse.cz>
cc: linux-mm@kvack.org, Roman Gushchin <guro@fb.com>,
        Michal Hocko <mhocko@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vijayanand Jitta <vjitta@codeaurora.org>
Subject: Re: [RFC PATCH 1/5] mm, slab/slub: introduce kmalloc-reclaimable
 caches
In-Reply-To: <20180524110011.1940-2-vbabka@suse.cz>
Message-ID: <0100016397ffdbf2-dc8a305f-efa8-4771-9f2a-3a7568693db4-000000@email.amazonses.com>
References: <20180524110011.1940-1-vbabka@suse.cz> <20180524110011.1940-2-vbabka@suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2018.05.25-54.240.9.112
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 May 2018, Vlastimil Babka wrote:

> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 9ebe659bd4a5..5bff0571b360 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -296,11 +296,16 @@ static inline void __check_heap_object(const void *ptr, unsigned long n,
>                                 (KMALLOC_MIN_SIZE) : 16)
>
>  #ifndef CONFIG_SLOB
> -extern struct kmem_cache *kmalloc_caches[KMALLOC_SHIFT_HIGH + 1];
> +extern struct kmem_cache *kmalloc_caches[2][KMALLOC_SHIFT_HIGH + 1];
>  #ifdef CONFIG_ZONE_DMA
>  extern struct kmem_cache *kmalloc_dma_caches[KMALLOC_SHIFT_HIGH + 1];
>  #endif

In the existing code we used a different array name for the DMA caches.
This is a similar situation.

I would suggest to use

kmalloc_reclaimable_caches[]

or make it consistent by folding the DMA caches into the array too (but
then note the issues below).

> @@ -536,12 +541,13 @@ static __always_inline void *kmalloc(size_t size, gfp_t flags)
>  #ifndef CONFIG_SLOB
>  		if (!(flags & GFP_DMA)) {
>  			unsigned int index = kmalloc_index(size);
> +			unsigned int recl = kmalloc_reclaimable(flags);

This is a hotpath reserved for regular allocations. The reclaimable slabs
need to be handled like the DMA slabs.  So check for GFP_DMA plus the
reclaimable flags.

> @@ -588,12 +594,13 @@ static __always_inline void *kmalloc_node(size_t size, gfp_t flags, int node)
>  	if (__builtin_constant_p(size) &&
>  		size <= KMALLOC_MAX_CACHE_SIZE && !(flags & GFP_DMA)) {
>  		unsigned int i = kmalloc_index(size);
> +		unsigned int recl = kmalloc_reclaimable(flags);
>


Same situation here and additional times below.
