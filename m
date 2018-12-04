Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C2A3C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C639206B6
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 16:41:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C639206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbeLDQlX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 11:41:23 -0500
Received: from foss.arm.com ([217.140.101.70]:36710 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726367AbeLDQlW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 11:41:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A52CA78;
        Tue,  4 Dec 2018 08:41:22 -0800 (PST)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 28F673F614;
        Tue,  4 Dec 2018 08:41:22 -0800 (PST)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 862C81AE0BA0; Tue,  4 Dec 2018 16:41:42 +0000 (GMT)
Date:   Tue, 4 Dec 2018 16:41:42 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Nicolas Boichat <drinkcat@chromium.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Christoph Lameter <cl@linux.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
        Yong Wu <yong.wu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>, yingjoe.chen@mediatek.com,
        hch@infradead.org, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v3, RFC] iommu/io-pgtable-arm-v7s: Use page_frag to
 request DMA32 memory
Message-ID: <20181204164142.GA8520@arm.com>
References: <20181204082300.95106-1-drinkcat@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181204082300.95106-1-drinkcat@chromium.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 04:23:00PM +0800, Nicolas Boichat wrote:
> IOMMUs using ARMv7 short-descriptor format require page tables
> (level 1 and 2) to be allocated within the first 4GB of RAM, even
> on 64-bit systems.
> 
> For level 1/2 tables, ensure GFP_DMA32 is used if CONFIG_ZONE_DMA32
> is defined (e.g. on arm64 platforms).
> 
> For level 2 tables (1 KB), we use page_frag to allocate these pages,
> as we cannot directly use kmalloc (no slab cache for GFP_DMA32) or
> kmem_cache (mm/ code treats GFP_DMA32 as an invalid flag).
> 
> One downside is that we only free the allocated page if all the
> 4 fragments (4 IOMMU L2 tables) are freed, but given that we
> usually only allocate limited number of IOMMU L2 tables, this
> should not have too much impact on memory usage: In the absolute
> worst case (4096 L2 page tables, each on their own 4K page),
> we would use 16 MB of memory for 4 MB of L2 tables.
> 
> Also, print an error when the physical address does not fit in
> 32-bit, to make debugging easier in the future.
> 
> Fixes: ad67f5a6545f ("arm64: replace ZONE_DMA with ZONE_DMA32")
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> ---
> 
> As an alternative to the series [1], which adds support for GFP_DMA32
> to kmem_cache in mm/. IMHO the solution in [1] is cleaner and more
> efficient, as it allows freed fragments (L2 tables) to be reused, but
> this approach does not require any core change.
> 
> [1] https://patchwork.kernel.org/cover/10677529/, 3 patches
> 
>  drivers/iommu/io-pgtable-arm-v7s.c | 32 ++++++++++++++++--------------
>  1 file changed, 17 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/iommu/io-pgtable-arm-v7s.c b/drivers/iommu/io-pgtable-arm-v7s.c
> index 445c3bde04800c..0de6a51eb6755f 100644
> --- a/drivers/iommu/io-pgtable-arm-v7s.c
> +++ b/drivers/iommu/io-pgtable-arm-v7s.c
> @@ -161,6 +161,12 @@
>  
>  #define ARM_V7S_TCR_PD1			BIT(5)
>  
> +#ifdef CONFIG_ZONE_DMA32
> +#define ARM_V7S_TABLE_GFP_DMA GFP_DMA32
> +#else
> +#define ARM_V7S_TABLE_GFP_DMA GFP_DMA
> +#endif

We may as well include __GFP_ZERO in here too.
Anyway, this looks alright to me:

Acked-by: Will Deacon <will.deacon@arm.com>

But it sounds like you're still on the fence about this patch, so I won't
pick it up unless you ask explicitly.

Will
