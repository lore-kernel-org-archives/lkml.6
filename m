Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04FFBC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D60AE217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:57:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730766AbfBLP5F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 10:57:05 -0500
Received: from foss.arm.com ([217.140.101.70]:39534 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730753AbfBLP5E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 10:57:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 155C280D;
        Tue, 12 Feb 2019 07:57:03 -0800 (PST)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7401F3F557;
        Tue, 12 Feb 2019 07:57:00 -0800 (PST)
Subject: Re: [PATCH 2/5] kasan, kmemleak: pass tagged pointers to kmemleak
To:     Andrey Konovalov <andreyknvl@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Qian Cai <cai@lca.pw>, Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>
References: <cover.1549921721.git.andreyknvl@google.com>
 <cd825aa4897b0fc37d3316838993881daccbe9f5.1549921721.git.andreyknvl@google.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <f57831be-c57a-4a9e-992e-1f193866467b@arm.com>
Date:   Tue, 12 Feb 2019 15:56:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <cd825aa4897b0fc37d3316838993881daccbe9f5.1549921721.git.andreyknvl@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/02/2019 21:59, Andrey Konovalov wrote:
> Right now we call kmemleak hooks before assigning tags to pointers in
> KASAN hooks. As a result, when an objects gets allocated, kmemleak sees
> a differently tagged pointer, compared to the one it sees when the object
> gets freed. Fix it by calling KASAN hooks before kmemleak's ones.
>

Nit: Could you please add comments to the the code? It should prevent that the
code gets refactored in future, reintroducing the same issue.

> Reported-by: Qian Cai <cai@lca.pw>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  mm/slab.h        | 6 ++----
>  mm/slab_common.c | 2 +-
>  mm/slub.c        | 3 ++-
>  3 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/slab.h b/mm/slab.h
> index 4190c24ef0e9..638ea1b25d39 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -437,11 +437,9 @@ static inline void slab_post_alloc_hook(struct kmem_cache *s, gfp_t flags,
>  
>  	flags &= gfp_allowed_mask;
>  	for (i = 0; i < size; i++) {
> -		void *object = p[i];
> -
> -		kmemleak_alloc_recursive(object, s->object_size, 1,
> +		p[i] = kasan_slab_alloc(s, p[i], flags);
> +		kmemleak_alloc_recursive(p[i], s->object_size, 1,
>  					 s->flags, flags);
> -		p[i] = kasan_slab_alloc(s, object, flags);
>  	}
>  
>  	if (memcg_kmem_enabled())
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 81732d05e74a..fe524c8d0246 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1228,8 +1228,8 @@ void *kmalloc_order(size_t size, gfp_t flags, unsigned int order)
>  	flags |= __GFP_COMP;
>  	page = alloc_pages(flags, order);
>  	ret = page ? page_address(page) : NULL;
> -	kmemleak_alloc(ret, size, 1, flags);
>  	ret = kasan_kmalloc_large(ret, size, flags);
> +	kmemleak_alloc(ret, size, 1, flags);
>  	return ret;
>  }
>  EXPORT_SYMBOL(kmalloc_order);
> diff --git a/mm/slub.c b/mm/slub.c
> index 1e3d0ec4e200..4a3d7686902f 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1374,8 +1374,9 @@ static inline void dec_slabs_node(struct kmem_cache *s, int node,
>   */
>  static inline void *kmalloc_large_node_hook(void *ptr, size_t size, gfp_t flags)
>  {
> +	ptr = kasan_kmalloc_large(ptr, size, flags);
>  	kmemleak_alloc(ptr, size, 1, flags);
> -	return kasan_kmalloc_large(ptr, size, flags);
> +	return ptr;
>  }
>  
>  static __always_inline void kfree_hook(void *x)
> 

-- 
Regards,
Vincenzo
