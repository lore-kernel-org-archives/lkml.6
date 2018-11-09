Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE52C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69FFC20892
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 10:43:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69FFC20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbeKIUXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 15:23:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:58164 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727560AbeKIUXa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 15:23:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4F1BAAF58;
        Fri,  9 Nov 2018 10:43:26 +0000 (UTC)
Subject: Re: [PATCH RFC 1/3] mm: When CONFIG_ZONE_DMA32 is set, use DMA32 for
 SLAB_CACHE_DMA
To:     Nicolas Boichat <drinkcat@chromium.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Levin Alexander <alexander.levin@verizon.com>,
        Huaisheng Ye <yehs1@lenovo.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Yong Wu <yong.wu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>, yingjoe.chen@mediatek.com
References: <20181109082448.150302-1-drinkcat@chromium.org>
 <20181109082448.150302-2-drinkcat@chromium.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Openpgp: preference=signencrypt
Autocrypt: addr=vbabka@suse.cz; prefer-encrypt=mutual; keydata=
 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
 cqmP8roqufIAj+Ohhzs=
Message-ID: <00afe803-22dd-5a75-70aa-dda0c7752470@suse.cz>
Date:   Fri, 9 Nov 2018 11:43:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181109082448.150302-2-drinkcat@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/18 9:24 AM, Nicolas Boichat wrote:
> Some callers, namely iommu/io-pgtable-arm-v7s, expect the physical
> address returned by kmem_cache_alloc with GFP_DMA parameter to be
> a 32-bit address.
> 
> Instead of adding a separate SLAB_CACHE_DMA32 (and then audit
> all the calls to check if they require memory from DMA or DMA32
> zone), we simply allocate SLAB_CACHE_DMA cache in DMA32 region,
> if CONFIG_ZONE_DMA32 is set.
> 
> Fixes: ad67f5a6545f ("arm64: replace ZONE_DMA with ZONE_DMA32")
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> ---
>  include/linux/slab.h | 13 ++++++++++++-
>  mm/slab.c            |  2 +-
>  mm/slub.c            |  2 +-
>  3 files changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 918f374e7156f4..390afe90c5dec0 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -30,7 +30,7 @@
>  #define SLAB_POISON		((slab_flags_t __force)0x00000800U)
>  /* Align objs on cache lines */
>  #define SLAB_HWCACHE_ALIGN	((slab_flags_t __force)0x00002000U)
> -/* Use GFP_DMA memory */
> +/* Use GFP_DMA or GFP_DMA32 memory */
>  #define SLAB_CACHE_DMA		((slab_flags_t __force)0x00004000U)
>  /* DEBUG: Store the last owner for bug hunting */
>  #define SLAB_STORE_USER		((slab_flags_t __force)0x00010000U)
> @@ -126,6 +126,17 @@
>  #define ZERO_OR_NULL_PTR(x) ((unsigned long)(x) <= \
>  				(unsigned long)ZERO_SIZE_PTR)
>  
> +/*
> + * When ZONE_DMA32 is defined, have SLAB_CACHE_DMA allocate memory with
> + * GFP_DMA32 instead of GFP_DMA, as this is what some of the callers
> + * require (instead of duplicating cache for DMA and DMA32 zones).
> + */
> +#ifdef CONFIG_ZONE_DMA32
> +#define SLAB_CACHE_DMA_GFP GFP_DMA32
> +#else
> +#define SLAB_CACHE_DMA_GFP GFP_DMA
> +#endif

AFAICS this will break e.g. x86 which can have both ZONE_DMA and
ZONE_DMA32, and now you would make kmalloc(__GFP_DMA) return objects
from ZONE_DMA32 instead of __ZONE_DMA, which can break something.

Also I'm probably missing the point of this all. In patch 3 you use
__get_dma32_pages() thus __get_free_pages(__GFP_DMA32), which uses
alloc_pages, thus the page allocator directly, and there's no slab
caches involved. It makes little sense to involve slab for page table
allocations anyway, as those tend to be aligned to a page size (or
high-order page size). So what am I missing?
