Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4719EC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 09:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C0FD2064D
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 09:13:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C0FD2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729155AbeGZK3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 06:29:43 -0400
Received: from verein.lst.de ([213.95.11.211]:35518 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728600AbeGZK3n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 06:29:43 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 1B68D68D64; Thu, 26 Jul 2018 11:17:32 +0200 (CEST)
Date:   Thu, 26 Jul 2018 11:17:32 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>, hch@lst.de
Subject: Re: [PATCH 3/4] ARC: refactor arch/arc/mm/dma.c
Message-ID: <20180726091731.GC24209@lst.de>
References: <20180724101001.31965-1-Eugeniy.Paltsev@synopsys.com> <20180724101001.31965-4-Eugeniy.Paltsev@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180724101001.31965-4-Eugeniy.Paltsev@synopsys.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 01:10:00PM +0300, Eugeniy Paltsev wrote:
> Refactoring, no functional change intended.

Might be worth explaining a bit why you are refactoring it (i.e. what is the
benefit).

> 
> Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> ---
>  arch/arc/mm/dma.c | 28 ++++++++++------------------
>  1 file changed, 10 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/arc/mm/dma.c b/arch/arc/mm/dma.c
> index b693818cd8e5..46584c7c2858 100644
> --- a/arch/arc/mm/dma.c
> +++ b/arch/arc/mm/dma.c
> @@ -27,30 +27,24 @@ void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
>  	struct page *page;
>  	phys_addr_t paddr;
>  	void *kvaddr;
> -	int need_coh = 1, need_kvaddr = 0;
> +	bool need_coh = !(attrs & DMA_ATTR_NON_CONSISTENT);
>  
>  	page = alloc_pages(gfp, order);
>  	if (!page)
>  		return NULL;
>  
>  	/* This is linear addr (0x8000_0000 based) */
>  	paddr = page_to_phys(page);
>  
>  	*dma_handle = paddr;
>  
> +	/*
> +	 * - A coherent buffer needs MMU mapping to enforce non-cachability
> +	 * - A highmem page needs a virtual handle (hence MMU mapping)
> +	 *   independent of cachability.
> +	 * kvaddr is kernel Virtual address (0x7000_0000 based)
> +	 */
> +	if (PageHighMem(page) || need_coh) {

dma_alloc_attrs clears __GFP_HIGHMEM from the passed in gfp mask, so
you'll never get a highmem page here.

That also means you can merge this conditional with the one for the cache
writeback and invalidation and kill the need_coh flag entirely.

>  		kvaddr = ioremap_nocache(paddr, size);
>  		if (kvaddr == NULL) {
>  			__free_pages(page, order);
> @@ -81,11 +75,9 @@ void arch_dma_free(struct device *dev, size_t size, void *vaddr,
>  {
>  	phys_addr_t paddr = dma_handle;
>  	struct page *page = virt_to_page(paddr);
> -	int is_non_coh = 1;
> -
> -	is_non_coh = (attrs & DMA_ATTR_NON_CONSISTENT);
> +	bool is_coh = !(attrs & DMA_ATTR_NON_CONSISTENT);
>  
> -	if (PageHighMem(page) || !is_non_coh)
> +	if (PageHighMem(page) || is_coh)
>  		iounmap((void __force __iomem *)vaddr);
>  

Same here.

Also if you clean this up it would be great to take the per-device pfn offset
into account, even if that isn't used anywhere on arc yet, that is call
phys_to_dma and dma_to_phys to convert to an from the dma address.
