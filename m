Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47FBBC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 01:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E968B2150D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 01:45:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E968B2150D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbeI0IB2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 04:01:28 -0400
Received: from gate.crashing.org ([63.228.1.57]:33091 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726651AbeI0IB2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 04:01:28 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w8R1jFU1007969;
        Wed, 26 Sep 2018 20:45:17 -0500
Message-ID: <1811156d5a1df1166c7ab7522525619b951f047d.camel@kernel.crashing.org>
Subject: Re: [PATCH 3/5] dma-direct: refine dma_direct_alloc zone selection
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 27 Sep 2018 11:45:15 +1000
In-Reply-To: <20180920185247.20037-4-hch@lst.de>
References: <20180920185247.20037-1-hch@lst.de>
         <20180920185247.20037-4-hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-09-20 at 20:52 +0200, Christoph Hellwig wrote:
> +static gfp_t __dma_direct_optimal_gfp_mask(struct device *dev, u64 dma_mask,
> +               u64 *phys_mask)
> +{
> +       if (force_dma_unencrypted())
> +               *phys_mask = __dma_to_phys(dev, dma_mask);
> +       else
> +               *phys_mask = dma_to_phys(dev, dma_mask);
> +
> +       /* GFP_DMA32 and GFP_DMA are no ops without the corresponding zones: */
> +       if (*phys_mask <= DMA_BIT_MASK(ARCH_ZONE_DMA_BITS))
> +               return GFP_DMA;
> +       if (*phys_mask <= DMA_BIT_MASK(32))
> +               return GFP_DMA32;
> +       return 0;
> +}

I'm not sure this is entirely right.

Let's say the mask is 30 bits. You will return GFP_DMA32, which will
fail if you allocate something above 1G (which is legit for
ZONE_DMA32).

I think the logic should be:

	if (mask < ZONE_DMA)
		fail;
	else if (mask < ZONE_DMA32)
		use ZONE_DMA or fail if doesn't exist
	else if (mask < top_of_ram)
		use ZONE_DMA32 or fail if doesn't exist
	else
		use ZONE_NORMAL

Additionally, we want to fold-in the top-of-ram test such that we don't
fail the second case if the mask is 31-bits (smaller than ZONE_DMA32)
but top of ram is also small enough.

So the top of ram test should take precendence.

Cheers,
Ben.


