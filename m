Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A14C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 12:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 582B920823
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 12:58:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 582B920823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbeJ3VwC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 17:52:02 -0400
Received: from verein.lst.de ([213.95.11.211]:60100 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727530AbeJ3VwC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 17:52:02 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 3331768B02; Tue, 30 Oct 2018 13:58:41 +0100 (CET)
Date:   Tue, 30 Oct 2018 13:58:41 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Alistair Popple <alistair@popple.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        mpe@ellerman.id.au, benh@kernel.crashing.org, hch@lst.de
Subject: Re: [PATCH] powerpc/npu-dma: Remove NPU DMA ops
Message-ID: <20181030125841.GB30158@lst.de>
References: <20181030110203.27257-1-alistair@popple.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181030110203.27257-1-alistair@popple.id.au>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please take my patch instead.  We have a kernel polcity to not keep
dead code around, and everyone including Linus and the attending IBMers
confirmed this.

On Tue, Oct 30, 2018 at 10:02:03PM +1100, Alistair Popple wrote:
> The NPU IOMMU is setup to mirror the parent PCIe device IOMMU
> setup. Therefore it does not make sense to call dma operations such as
> dma_map_page, etc. directly on these devices. The existing dma-ops
> simply print a warning if they are ever called, however this is
> unnecessary and the warnings are likely to go unnoticed.
> 
> It is instead simpler to remove these operations and let the generic
> DMA code print warnings (eg. via a NULL pointer deref) in cases of
> buggy drivers attempting dma operations on NVLink devices.
> 
> Signed-off-by: Alistair Popple <alistair@popple.id.au>
> ---
>  arch/powerpc/platforms/powernv/npu-dma.c | 64 ++------------------------------
>  1 file changed, 4 insertions(+), 60 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
> index 6f60e0931922..75b935252981 100644
> --- a/arch/powerpc/platforms/powernv/npu-dma.c
> +++ b/arch/powerpc/platforms/powernv/npu-dma.c
> @@ -102,63 +102,6 @@ struct pci_dev *pnv_pci_get_npu_dev(struct pci_dev *gpdev, int index)
>  }
>  EXPORT_SYMBOL(pnv_pci_get_npu_dev);
> 
> -#define NPU_DMA_OP_UNSUPPORTED()					\
> -	dev_err_once(dev, "%s operation unsupported for NVLink devices\n", \
> -		__func__)
> -
> -static void *dma_npu_alloc(struct device *dev, size_t size,
> -			   dma_addr_t *dma_handle, gfp_t flag,
> -			   unsigned long attrs)
> -{
> -	NPU_DMA_OP_UNSUPPORTED();
> -	return NULL;
> -}
> -
> -static void dma_npu_free(struct device *dev, size_t size,
> -			 void *vaddr, dma_addr_t dma_handle,
> -			 unsigned long attrs)
> -{
> -	NPU_DMA_OP_UNSUPPORTED();
> -}
> -
> -static dma_addr_t dma_npu_map_page(struct device *dev, struct page *page,
> -				   unsigned long offset, size_t size,
> -				   enum dma_data_direction direction,
> -				   unsigned long attrs)
> -{
> -	NPU_DMA_OP_UNSUPPORTED();
> -	return 0;
> -}
> -
> -static int dma_npu_map_sg(struct device *dev, struct scatterlist *sglist,
> -			  int nelems, enum dma_data_direction direction,
> -			  unsigned long attrs)
> -{
> -	NPU_DMA_OP_UNSUPPORTED();
> -	return 0;
> -}
> -
> -static int dma_npu_dma_supported(struct device *dev, u64 mask)
> -{
> -	NPU_DMA_OP_UNSUPPORTED();
> -	return 0;
> -}
> -
> -static u64 dma_npu_get_required_mask(struct device *dev)
> -{
> -	NPU_DMA_OP_UNSUPPORTED();
> -	return 0;
> -}
> -
> -static const struct dma_map_ops dma_npu_ops = {
> -	.map_page		= dma_npu_map_page,
> -	.map_sg			= dma_npu_map_sg,
> -	.alloc			= dma_npu_alloc,
> -	.free			= dma_npu_free,
> -	.dma_supported		= dma_npu_dma_supported,
> -	.get_required_mask	= dma_npu_get_required_mask,
> -};
> -
>  /*
>   * Returns the PE assoicated with the PCI device of the given
>   * NPU. Returns the linked pci device if pci_dev != NULL.
> @@ -270,10 +213,11 @@ static void pnv_npu_dma_set_32(struct pnv_ioda_pe *npe)
>  	rc = pnv_npu_set_window(npe, 0, gpe->table_group.tables[0]);
> 
>  	/*
> -	 * We don't initialise npu_pe->tce32_table as we always use
> -	 * dma_npu_ops which are nops.
> +	 * NVLink devices use the same TCE table configuration as
> +	 * their parent device so drivers shouldn't be doing DMA
> +	 * operations directly on these devices.
>  	 */
> -	set_dma_ops(&npe->pdev->dev, &dma_npu_ops);
> +	set_dma_ops(&npe->pdev->dev, NULL);
>  }
> 
>  /*
> --
> 2.11.0
---end quoted text---
