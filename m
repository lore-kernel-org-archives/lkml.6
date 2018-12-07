Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68963C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 08:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D36B20989
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 08:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bMkaPtto"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D36B20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbeLGIGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 03:06:14 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:45594 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbeLGIGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 03:06:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PKxGGSpxIvJY9WF3AhCImMrydS/tCK19xSVKFODfjY4=; b=bMkaPtto+Fx0qY9PaOH5vjOPQ
        DCUCPbAQ07ynIXP0Z5s8IJAclSP+avQUnPVyxtG2Un62Cgfgl37K23vL9lrbgAzI71KWUTX08twF/
        LWh3nhH5qGaiaaFOHVGGJGIIIKIe5aUl6GsYkfzkymNA82v0VTFiQsI0wMFX7vLF/XZSc5XGb0slq
        C1hs4vugR8FjWCMqzGx0wVTO5pir+8VKEF7C82FNbighkRUAHoWw72Hd0ta9Snbmqdxi6gIvrOD34
        N29oTt8fFC0DM4y930Zs0Ae9wzDgNRpzOiu1yJ179q0m419yDN3r/g/es0YrKjDQ3Q/dzRxIv5hJY
        FaUq4c+nQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gVB8x-0006r5-JA; Fri, 07 Dec 2018 08:05:51 +0000
Date:   Fri, 7 Dec 2018 00:05:51 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Nicolas Boichat <drinkcat@chromium.org>
Cc:     Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
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
        hch@infradead.org
Subject: Re: [PATCH v5 2/3] iommu/io-pgtable-arm-v7s: Request DMA32 memory,
 and improve debugging
Message-ID: <20181207080551.GA15120@bombadil.infradead.org>
References: <20181207061620.107881-1-drinkcat@chromium.org>
 <20181207061620.107881-3-drinkcat@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181207061620.107881-3-drinkcat@chromium.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2018 at 02:16:19PM +0800, Nicolas Boichat wrote:
> +#ifdef CONFIG_ZONE_DMA32
> +#define ARM_V7S_TABLE_GFP_DMA GFP_DMA32
> +#define ARM_V7S_TABLE_SLAB_CACHE SLAB_CACHE_DMA32

This name doesn't make any sense.  Why not ARM_V7S_TABLE_SLAB_FLAGS ?

> +#else
> +#define ARM_V7S_TABLE_GFP_DMA GFP_DMA
> +#define ARM_V7S_TABLE_SLAB_CACHE SLAB_CACHE_DMA

Can you remind me again why it is, on machines which don't support
ZONE_DMA32, why we have to allocate from ZONE_DMA?  My understanding
is that 64-bit machines have ZONE_DMA32 and 32-bit machines don't.
So shouldn't this rather be GFP_KERNEL?

Actually, maybe we could centralise this in gfp.h:

#ifdef CONFIG_64BIT
# ifdef CONFIG_ZONE_DMA32
#define GFP_32BIT	GFP_DMA32
# else
#define GFP_32BIT	GFP_DMA
#else /* 32-bit */
#define GFP_32BIT	GFP_KERNEL
#endif

