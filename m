Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F8EC6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:57:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69D0922BD0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 16:57:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69D0922BD0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nocrew.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934068AbeGCQ5c (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 12:57:32 -0400
Received: from pio-pvt-msa2.bahnhof.se ([79.136.2.41]:51788 "EHLO
        pio-pvt-msa2.bahnhof.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932410AbeGCQ5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 12:57:31 -0400
X-Greylist: delayed 566 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Jul 2018 12:57:31 EDT
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id D03303FA3E;
        Tue,  3 Jul 2018 18:48:03 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1hiKflV9wt_7; Tue,  3 Jul 2018 18:47:58 +0200 (CEST)
Received: from localhost.localdomain (h-155-4-135-114.NA.cust.bahnhof.se [155.4.135.114])
        (Authenticated sender: mb547485)
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 453443F935;
        Tue,  3 Jul 2018 18:47:54 +0200 (CEST)
Date:   Tue, 3 Jul 2018 18:47:51 +0200
From:   Fredrik Noring <noring@nocrew.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     hch@lst.de, m.szyprowski@samsung.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        JuergenUrban@gmx.de, "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH] dma-mapping: Relax warnings for per-device areas
Message-ID: <20180703164750.GB17378@localhost.localdomain>
References: <1f8262d206c6886072d04cc93454f6e3f812bd20.1530623284.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1f8262d206c6886072d04cc93454f6e3f812bd20.1530623284.git.robin.murphy@arm.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you Robin,

On Tue, Jul 03, 2018 at 02:08:30PM +0100, Robin Murphy wrote:
> The reasons why dma_free_attrs() should not be called from IRQ context
> are not necessarily obvious and somewhat buried in the development
> history, so let's start by documenting the warning itself to help anyone
> who does happen to hit it and wonder what the deal is.
> 
> However, this check turns out to be slightly over-restrictive for the
> way that per-device memory has been spliced into the general API, since
> for that case we know that dma_declare_coherent_memory() has created an
> appropriate CPU mapping for the entire area and nothing dynamic should
> be happening. Given that the usage model for per-device memory is often
> more akin to streaming DMA than 'real' coherent DMA (e.g. allocating and
> freeing space to copy short-lived packets in and out), it is also
> somewhat more reasonable for those operations to happen in IRQ handlers
> for such devices.
> 
> A somewhat similar line of reasoning also applies at the other end for
> the mask check in dma_alloc_attrs() too - indeed, a device which cannot
> access anything other than its own local memory probably *shouldn't*
> have a valid mask for the general coherent DMA API.
> 
> Therefore, let's move the per-device area hooks up ahead of the assorted
> checks, so that they get a chance to resolve the request before we get
> as far as definite "you're doing it wrong" territory.

I have tested this patch and it corrects both problems with the PS2 OHCI
driver. I believe there is a fair chance that drivers/usb/host/ohci-sm501.c
and drivers/usb/host/ohci-tmio.c are fixed as well, since they are similar.

Tested-by: Fredrik Noring <noring@nocrew.org>

Fredrik

> Reported-by: Fredrik Noring <noring@nocrew.org>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  include/linux/dma-mapping.h | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index f9cc309507d9..ffeca3ab59c0 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -512,12 +512,12 @@ static inline void *dma_alloc_attrs(struct device *dev, size_t size,
>  	const struct dma_map_ops *ops = get_dma_ops(dev);
>  	void *cpu_addr;
>  
> -	BUG_ON(!ops);
> -	WARN_ON_ONCE(dev && !dev->coherent_dma_mask);
> -
>  	if (dma_alloc_from_dev_coherent(dev, size, dma_handle, &cpu_addr))
>  		return cpu_addr;
>  
> +	BUG_ON(!ops);
> +	WARN_ON_ONCE(dev && !dev->coherent_dma_mask);
> +
>  	/* let the implementation decide on the zone to allocate from: */
>  	flag &= ~(__GFP_DMA | __GFP_DMA32 | __GFP_HIGHMEM);
>  
> @@ -537,12 +537,19 @@ static inline void dma_free_attrs(struct device *dev, size_t size,
>  {
>  	const struct dma_map_ops *ops = get_dma_ops(dev);
>  
> -	BUG_ON(!ops);
> -	WARN_ON(irqs_disabled());
> -
>  	if (dma_release_from_dev_coherent(dev, get_order(size), cpu_addr))
>  		return;
>  
> +	BUG_ON(!ops);
> +	/*
> +	 * On non-coherent platforms which implement DMA-coherent buffers via
> +	 * non-cacheable remaps, ops->free() may call vunmap(). Thus arriving
> +	 * here in IRQ context is a) at risk of a BUG_ON() or trying to sleep
> +	 * on some machines, and b) an indication that the driver is probably
> +	 * misusing the coherent API anyway.
> +	 */
> +	WARN_ON(irqs_disabled());
> +
>  	if (!ops->free || !cpu_addr)
>  		return;
>  
> -- 
> 2.17.1.dirty
> 
