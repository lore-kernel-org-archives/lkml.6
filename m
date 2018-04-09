Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752947AbeDIRxG (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 13:53:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49326 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751942AbeDIRxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 13:53:04 -0400
Date: Mon, 9 Apr 2018 10:52:51 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: laurent.pinchart@ideasonboard.com, robin.murphy@arm.com,
        dalias@libc.org, ysato@users.sourceforge.jp, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH] base: dma-mapping: Postpone cpu addr translation on
 mmap()
Message-ID: <20180409175251.GA5426@infradead.org>
References: <1523293148-18726-1-git-send-email-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523293148-18726-1-git-send-email-jacopo+renesas@jmondi.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 09, 2018 at 06:59:08PM +0200, Jacopo Mondi wrote:
> I'm still a bit puzzled on what happens if dma_mmap_from_dev_coherent() fails.
> Does a dma_mmap_from_dev_coherent() failure guarantee anyhow that the
> successive virt_to_page() isn't problematic as it is today?
> Or is it the
>  	if (off < count && user_count <= (count - off))
> check that makes the translation safe?

It doesn't.  I think one major issue is that we should not simply fall
to dma_common_mmap if no method is required, but need every instance of
dma_map_ops to explicitly opt into an mmap method that is known to work.

>  #ifndef CONFIG_ARCH_NO_COHERENT_DMA_MMAP
>  	unsigned long user_count = vma_pages(vma);
>  	unsigned long count = PAGE_ALIGN(size) >> PAGE_SHIFT;
> -	unsigned long pfn = page_to_pfn(virt_to_page(cpu_addr));
>  	unsigned long off = vma->vm_pgoff;
> +	unsigned long pfn;
> 
>  	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> 
> @@ -235,6 +235,7 @@ int dma_common_mmap(struct device *dev, struct vm_area_struct *vma,
>  		return ret;
> 
>  	if (off < count && user_count <= (count - off)) {
> +		pfn = page_to_pfn(virt_to_page(cpu_addr));
>  		ret = remap_pfn_range(vma, vma->vm_start,
>  				      pfn + off,
>  				      user_count << PAGE_SHIFT,

Why not:

		ret = remap_pfn_range(vma, vma->vm_start,
				page_to_pfn(virt_to_page(cpu_addr)) + off,

and save the temp variable?
