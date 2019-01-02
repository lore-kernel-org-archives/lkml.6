Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52777C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 16:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B28E206C0
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 16:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730534AbfABQ7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 11:59:36 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:33566 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728720AbfABQ7g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 11:59:36 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CB98D80D;
        Wed,  2 Jan 2019 08:59:35 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.113])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2BDF33F5D4;
        Wed,  2 Jan 2019 08:59:34 -0800 (PST)
Date:   Wed, 2 Jan 2019 16:59:31 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kmemleak: survive in a low-memory situation
Message-ID: <20190102165931.GB6584@arrakis.emea.arm.com>
References: <0b2ecfe8-b98b-755c-5b5d-00a09a0d9e57@lca.pw>
 <20190102160849.11480-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190102160849.11480-1-cai@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qian,

On Wed, Jan 02, 2019 at 11:08:49AM -0500, Qian Cai wrote:
> Kmemleak could quickly fail to allocate an object structure and then
> disable itself in a low-memory situation. For example, running a mmap()
> workload triggering swapping and OOM [1].
> 
> First, it unnecessarily attempt to allocate even though the tracking
> object is NULL in kmem_cache_alloc(). For example,
> 
> alloc_io
>   bio_alloc_bioset
>     mempool_alloc
>       mempool_alloc_slab
>         kmem_cache_alloc
>           slab_alloc_node
>             __slab_alloc <-- could return NULL
>             slab_post_alloc_hook
>               kmemleak_alloc_recursive

kmemleak_alloc() only continues with the kmemleak_object allocation if
the given pointer is not NULL.

> diff --git a/mm/slab.h b/mm/slab.h
> index 4190c24ef0e9..51a9a942cc56 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -435,15 +435,16 @@ static inline void slab_post_alloc_hook(struct kmem_cache *s, gfp_t flags,
>  {
>  	size_t i;
>  
> -	flags &= gfp_allowed_mask;
> -	for (i = 0; i < size; i++) {
> -		void *object = p[i];
> -
> -		kmemleak_alloc_recursive(object, s->object_size, 1,
> -					 s->flags, flags);
> -		p[i] = kasan_slab_alloc(s, object, flags);
> +	if (*p) {
> +		flags &= gfp_allowed_mask;
> +		for (i = 0; i < size; i++) {
> +			void *object = p[i];
> +
> +			kmemleak_alloc_recursive(object, s->object_size, 1,
> +						 s->flags, flags);
> +			p[i] = kasan_slab_alloc(s, object, flags);
> +		}
>  	}

This is not necessary for kmemleak.

-- 
Catalin
