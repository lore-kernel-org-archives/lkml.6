Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD0EC43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC97D20850
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 14:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728832AbfAHOap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 09:30:45 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:46761 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728318AbfAHOap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 09:30:45 -0500
X-IronPort-AV: E=Sophos;i="5.56,454,1539640800"; 
   d="scan'208";a="363106600"
Received: from vaio-julia.rsr.lip6.fr ([132.227.76.33])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2019 15:30:43 +0100
Date:   Tue, 8 Jan 2019 15:30:41 +0100 (CET)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Christoph Hellwig <hch@lst.de>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] cross-tree: phase out dma_zalloc_coherent() on
 headers
In-Reply-To: <20190108130701.14161-3-hch@lst.de>
Message-ID: <alpine.DEB.2.20.1901081530070.6130@hadrien>
References: <20190108130701.14161-1-hch@lst.de> <20190108130701.14161-3-hch@lst.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 8 Jan 2019, Christoph Hellwig wrote:

> From: Luis Chamberlain <mcgrof@kernel.org>
>
> The last few stragglers coccinelle doesn't pick up are on driver
> specific header files. Phase those out as well as dma_alloc_coherent()
> zeroes out the memory as well now too.

You can use the --include-headers option to also process the header files
(just an information, no need to change).

julia

>
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/net/ethernet/broadcom/bnx2x/bnx2x.h        | 2 +-
>  drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h    | 2 +-
>  drivers/net/ethernet/marvell/octeontx2/af/common.h | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x.h b/drivers/net/ethernet/broadcom/bnx2x/bnx2x.h
> index 5cd3135dfe30..03d131f777bc 100644
> --- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x.h
> +++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x.h
> @@ -2081,7 +2081,7 @@ void bnx2x_igu_clear_sb_gen(struct bnx2x *bp, u8 func, u8 idu_sb_id,
>  			    bool is_pf);
>
>  #define BNX2X_ILT_ZALLOC(x, y, size)					\
> -	x = dma_zalloc_coherent(&bp->pdev->dev, size, y, GFP_KERNEL)
> +	x = dma_alloc_coherent(&bp->pdev->dev, size, y, GFP_KERNEL)
>
>  #define BNX2X_ILT_FREE(x, y, size) \
>  	do { \
> diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h
> index 142bc11b9fbb..2462e7aa0c5d 100644
> --- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h
> +++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h
> @@ -52,7 +52,7 @@ extern int bnx2x_num_queues;
>
>  #define BNX2X_PCI_ALLOC(y, size)					\
>  ({									\
> -	void *x = dma_zalloc_coherent(&bp->pdev->dev, size, y, GFP_KERNEL); \
> +	void *x = dma_alloc_coherent(&bp->pdev->dev, size, y, GFP_KERNEL); \
>  	if (x)								\
>  		DP(NETIF_MSG_HW,					\
>  		   "BNX2X_PCI_ALLOC: Physical %Lx Virtual %p\n",	\
> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/common.h b/drivers/net/ethernet/marvell/octeontx2/af/common.h
> index ec50a21c5aaf..e332e82fc066 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/common.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/common.h
> @@ -64,7 +64,7 @@ static inline int qmem_alloc(struct device *dev, struct qmem **q,
>
>  	qmem->entry_sz = entry_sz;
>  	qmem->alloc_sz = (qsize * entry_sz) + OTX2_ALIGN;
> -	qmem->base = dma_zalloc_coherent(dev, qmem->alloc_sz,
> +	qmem->base = dma_alloc_coherent(dev, qmem->alloc_sz,
>  					 &qmem->iova, GFP_KERNEL);
>  	if (!qmem->base)
>  		return -ENOMEM;
> --
> 2.20.1
>
>
