Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A126C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:02:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F74A20878
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 14:02:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F74A20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbeLEOCM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 09:02:12 -0500
Received: from mx2.suse.de ([195.135.220.15]:41920 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727142AbeLEOCM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 09:02:12 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id F1D0CAEF2;
        Wed,  5 Dec 2018 14:02:08 +0000 (UTC)
Subject: Re: [PATCH v4 2/3] mm: Add support for kmem caches in DMA32 zone
To:     Nicolas Boichat <drinkcat@chromium.org>,
        Will Deacon <will.deacon@arm.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Levin Alexander <Alexander.Levin@microsoft.com>,
        Huaisheng Ye <yehs1@lenovo.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Yong Wu <yong.wu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>, yingjoe.chen@mediatek.com,
        hch@infradead.org, Matthew Wilcox <willy@infradead.org>
References: <20181205054828.183476-1-drinkcat@chromium.org>
 <20181205054828.183476-3-drinkcat@chromium.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Openpgp: preference=signencrypt
Autocrypt: addr=vbabka@suse.cz; prefer-encrypt=mutual; keydata=
 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
 cqmP8roqufIAj+Ohhzs=
Message-ID: <5eddd264-5527-a98e-fc8b-31ea89f474db@suse.cz>
Date:   Wed, 5 Dec 2018 14:59:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <20181205054828.183476-3-drinkcat@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/5/18 6:48 AM, Nicolas Boichat wrote:
> In some cases (e.g. IOMMU ARMv7s page allocator), we need to allocate
> data structures smaller than a page with GFP_DMA32 flag.
> 
> This change makes it possible to create a custom cache in DMA32 zone
> using kmem_cache_create, then allocate memory using kmem_cache_alloc.
> 
> We do not create a DMA32 kmalloc cache array, as there are currently
> no users of kmalloc(..., GFP_DMA32). The new test in check_slab_flags
> ensures that such calls still fail (as they do before this change).
> 
> Fixes: ad67f5a6545f ("arm64: replace ZONE_DMA with ZONE_DMA32")

Same as my comment for 1/3.

> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>

In general,
Acked-by: Vlastimil Babka <vbabka@suse.cz>

Some comments below:

> ---
> 
> Changes since v2:
>  - Clarified commit message
>  - Add entry in sysfs-kernel-slab to document the new sysfs file
> 
> (v3 used the page_frag approach)
> 
> Documentation/ABI/testing/sysfs-kernel-slab |  9 +++++++++
>  include/linux/slab.h                        |  2 ++
>  mm/internal.h                               |  8 ++++++--
>  mm/slab.c                                   |  4 +++-
>  mm/slab.h                                   |  3 ++-
>  mm/slab_common.c                            |  2 +-
>  mm/slub.c                                   | 18 +++++++++++++++++-
>  7 files changed, 40 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-kernel-slab b/Documentation/ABI/testing/sysfs-kernel-slab
> index 29601d93a1c2ea..d742c6cfdffbe9 100644
> --- a/Documentation/ABI/testing/sysfs-kernel-slab
> +++ b/Documentation/ABI/testing/sysfs-kernel-slab
> @@ -106,6 +106,15 @@ Description:
>  		are from ZONE_DMA.
>  		Available when CONFIG_ZONE_DMA is enabled.
>  
> +What:		/sys/kernel/slab/cache/cache_dma32
> +Date:		December 2018
> +KernelVersion:	4.21
> +Contact:	Nicolas Boichat <drinkcat@chromium.org>
> +Description:
> +		The cache_dma32 file is read-only and specifies whether objects
> +		are from ZONE_DMA32.
> +		Available when CONFIG_ZONE_DMA32 is enabled.

I don't have a strong opinion. It's a new file, yeah, but consistent
with already existing ones. I'd leave the decision with SL*B maintainers.

>  What:		/sys/kernel/slab/cache/cpu_slabs
>  Date:		May 2007
>  KernelVersion:	2.6.22
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 11b45f7ae4057c..9449b19c5f107a 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -32,6 +32,8 @@
>  #define SLAB_HWCACHE_ALIGN	((slab_flags_t __force)0x00002000U)
>  /* Use GFP_DMA memory */
>  #define SLAB_CACHE_DMA		((slab_flags_t __force)0x00004000U)
> +/* Use GFP_DMA32 memory */
> +#define SLAB_CACHE_DMA32	((slab_flags_t __force)0x00008000U)
>  /* DEBUG: Store the last owner for bug hunting */
>  #define SLAB_STORE_USER		((slab_flags_t __force)0x00010000U)
>  /* Panic if kmem_cache_create() fails */
> diff --git a/mm/internal.h b/mm/internal.h
> index a2ee82a0cd44ae..fd244ad716eaf8 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -14,6 +14,7 @@
>  #include <linux/fs.h>
>  #include <linux/mm.h>
>  #include <linux/pagemap.h>
> +#include <linux/slab.h>
>  #include <linux/tracepoint-defs.h>
>  
>  /*
> @@ -34,9 +35,12 @@
>  #define GFP_CONSTRAINT_MASK (__GFP_HARDWALL|__GFP_THISNODE)
>  
>  /* Check for flags that must not be used with a slab allocator */
> -static inline gfp_t check_slab_flags(gfp_t flags)
> +static inline gfp_t check_slab_flags(gfp_t flags, slab_flags_t slab_flags)
>  {
> -	gfp_t bug_mask = __GFP_DMA32 | __GFP_HIGHMEM | ~__GFP_BITS_MASK;
> +	gfp_t bug_mask = __GFP_HIGHMEM | ~__GFP_BITS_MASK;
> +
> +	if (!IS_ENABLED(CONFIG_ZONE_DMA32) || !(slab_flags & SLAB_CACHE_DMA32))
> +		bug_mask |= __GFP_DMA32;

I'll point out that this is not even strictly needed AFAICS, as only
flags passed to kmem_cache_alloc() are checked - the cache->allocflags
derived from SLAB_CACHE_DMA32 are appended only after check_slab_flags()
(in both SLAB and SLUB AFAICS). And for a cache created with
SLAB_CACHE_DMA32, the caller of kmem_cache_alloc() doesn't need to also
include __GFP_DMA32, the allocation will be from ZONE_DMA32 regardless.
So it would be fine even unchanged. The check would anyway need some
more love to catch the same with __GFP_DMA to be consistent and cover
all corner cases.

>  
>  	if (unlikely(flags & bug_mask)) {
>  		gfp_t invalid_mask = flags & bug_mask;
