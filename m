Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE7EC67863
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 09:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11EE020652
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 09:41:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11EE020652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbeJVR7f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 13:59:35 -0400
Received: from verein.lst.de ([213.95.11.211]:35316 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728363AbeJVR7f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 13:59:35 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 96E2968BE1; Mon, 22 Oct 2018 11:41:48 +0200 (CEST)
Date:   Mon, 22 Oct 2018 11:41:48 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-direct: reject highmem pages from
 dma_alloc_from_contiguous
Message-ID: <20181022094148.GA20099@lst.de>
References: <20181014181447.22783-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181014181447.22783-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Any comments?

On Sun, Oct 14, 2018 at 08:14:47PM +0200, Christoph Hellwig wrote:
> dma_alloc_from_contiguous can return highmem pages depending on the
> setup, which a plain non-remapping DMA allocator can't handle.  Detect
> this case and try the normal page allocator instead.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  kernel/dma/direct.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 87a6bc2a96c0..46fbaa49125b 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -126,6 +126,18 @@ void *dma_direct_alloc_pages(struct device *dev, size_t size,
>  	if (gfpflags_allow_blocking(gfp)) {
>  		page = dma_alloc_from_contiguous(dev, count, page_order,
>  						 gfp & __GFP_NOWARN);
> +		if (page && PageHighMem(page)) {
> +			/*
> +			 * Depending on the cma= arguments and per-arch setup
> +			 * dma_alloc_from_contiguous could return highmem
> +			 * pages.  Without remapping there is no way to return
> +			 * them here, so log an error and fail.
> +			 */
> +			dev_info(dev, "Ignoring highmem page from CMA.\n");
> +			dma_release_from_contiguous(dev, page, count);
> +			page = NULL;
> +		}
> +
>  		if (page && !dma_coherent_ok(dev, page_to_phys(page), size)) {
>  			dma_release_from_contiguous(dev, page, count);
>  			page = NULL;
> -- 
> 2.19.1
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
---end quoted text---
