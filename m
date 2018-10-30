Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A5CCC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F68220831
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 13:09:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F68220831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbeJ3WDQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 18:03:16 -0400
Received: from gate.crashing.org ([63.228.1.57]:37568 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727705AbeJ3WDQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 18:03:16 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w9UD9TCI030426;
        Tue, 30 Oct 2018 08:09:31 -0500
Message-ID: <30359cc433e97739d93e13717b2897e462895097.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/npu-dma: Remove NPU DMA ops
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Christoph Hellwig <hch@lst.de>,
        Alistair Popple <alistair@popple.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        mpe@ellerman.id.au
Date:   Wed, 31 Oct 2018 00:09:29 +1100
In-Reply-To: <20181030125841.GB30158@lst.de>
References: <20181030110203.27257-1-alistair@popple.id.au>
         <20181030125841.GB30158@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-10-30 at 13:58 +0100, Christoph Hellwig wrote:
> Please take my patch instead.  We have a kernel polcity to not keep
> dead code around, and everyone including Linus and the attending IBMers
> confirmed this.

Let's call a cat a cat ... ;-)

It's not *dead* code. It's code that is used by an out of tree driver
(which also happen not to be open source).

Just making things clear for everybody.

Cheers,
Ben.

> On Tue, Oct 30, 2018 at 10:02:03PM +1100, Alistair Popple wrote:
> > The NPU IOMMU is setup to mirror the parent PCIe device IOMMU
> > setup. Therefore it does not make sense to call dma operations such as
> > dma_map_page, etc. directly on these devices. The existing dma-ops
> > simply print a warning if they are ever called, however this is
> > unnecessary and the warnings are likely to go unnoticed.
> > 
> > It is instead simpler to remove these operations and let the generic
> > DMA code print warnings (eg. via a NULL pointer deref) in cases of
> > buggy drivers attempting dma operations on NVLink devices.
> > 
> > Signed-off-by: Alistair Popple <alistair@popple.id.au>
> > ---
> >  arch/powerpc/platforms/powernv/npu-dma.c | 64 ++------------------------------
> >  1 file changed, 4 insertions(+), 60 deletions(-)
> > 
> > diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
> > index 6f60e0931922..75b935252981 100644
> > --- a/arch/powerpc/platforms/powernv/npu-dma.c
> > +++ b/arch/powerpc/platforms/powernv/npu-dma.c
> > @@ -102,63 +102,6 @@ struct pci_dev *pnv_pci_get_npu_dev(struct pci_dev *gpdev, int index)
> >  }
> >  EXPORT_SYMBOL(pnv_pci_get_npu_dev);
> > 
> > -#define NPU_DMA_OP_UNSUPPORTED()					\
> > -	dev_err_once(dev, "%s operation unsupported for NVLink devices\n", \
> > -		__func__)
> > -
> > -static void *dma_npu_alloc(struct device *dev, size_t size,
> > -			   dma_addr_t *dma_handle, gfp_t flag,
> > -			   unsigned long attrs)
> > -{
> > -	NPU_DMA_OP_UNSUPPORTED();
> > -	return NULL;
> > -}
> > -
> > -static void dma_npu_free(struct device *dev, size_t size,
> > -			 void *vaddr, dma_addr_t dma_handle,
> > -			 unsigned long attrs)
> > -{
> > -	NPU_DMA_OP_UNSUPPORTED();
> > -}
> > -
> > -static dma_addr_t dma_npu_map_page(struct device *dev, struct page *page,
> > -				   unsigned long offset, size_t size,
> > -				   enum dma_data_direction direction,
> > -				   unsigned long attrs)
> > -{
> > -	NPU_DMA_OP_UNSUPPORTED();
> > -	return 0;
> > -}
> > -
> > -static int dma_npu_map_sg(struct device *dev, struct scatterlist *sglist,
> > -			  int nelems, enum dma_data_direction direction,
> > -			  unsigned long attrs)
> > -{
> > -	NPU_DMA_OP_UNSUPPORTED();
> > -	return 0;
> > -}
> > -
> > -static int dma_npu_dma_supported(struct device *dev, u64 mask)
> > -{
> > -	NPU_DMA_OP_UNSUPPORTED();
> > -	return 0;
> > -}
> > -
> > -static u64 dma_npu_get_required_mask(struct device *dev)
> > -{
> > -	NPU_DMA_OP_UNSUPPORTED();
> > -	return 0;
> > -}
> > -
> > -static const struct dma_map_ops dma_npu_ops = {
> > -	.map_page		= dma_npu_map_page,
> > -	.map_sg			= dma_npu_map_sg,
> > -	.alloc			= dma_npu_alloc,
> > -	.free			= dma_npu_free,
> > -	.dma_supported		= dma_npu_dma_supported,
> > -	.get_required_mask	= dma_npu_get_required_mask,
> > -};
> > -
> >  /*
> >   * Returns the PE assoicated with the PCI device of the given
> >   * NPU. Returns the linked pci device if pci_dev != NULL.
> > @@ -270,10 +213,11 @@ static void pnv_npu_dma_set_32(struct pnv_ioda_pe *npe)
> >  	rc = pnv_npu_set_window(npe, 0, gpe->table_group.tables[0]);
> > 
> >  	/*
> > -	 * We don't initialise npu_pe->tce32_table as we always use
> > -	 * dma_npu_ops which are nops.
> > +	 * NVLink devices use the same TCE table configuration as
> > +	 * their parent device so drivers shouldn't be doing DMA
> > +	 * operations directly on these devices.
> >  	 */
> > -	set_dma_ops(&npe->pdev->dev, &dma_npu_ops);
> > +	set_dma_ops(&npe->pdev->dev, NULL);
> >  }
> > 
> >  /*
> > --
> > 2.11.0
> 
> ---end quoted text---

