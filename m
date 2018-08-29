Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F43C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 09:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BFD920868
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 09:21:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BFD920868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbeH2NRM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 09:17:12 -0400
Received: from mail.bootlin.com ([62.4.15.54]:45560 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727198AbeH2NRM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 09:17:12 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B4335207B0; Wed, 29 Aug 2018 11:21:13 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 81635206F6;
        Wed, 29 Aug 2018 11:21:13 +0200 (CEST)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     <thomas.petazzoni@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 2/5] net: mvneta: fix the wrong function to unmap rx buf
References: <20180829162456.2bd69796@xhacker.debian>
        <20180829162751.018acbb6@xhacker.debian>
Date:   Wed, 29 Aug 2018 11:21:12 +0200
In-Reply-To: <20180829162751.018acbb6@xhacker.debian> (Jisheng Zhang's message
        of "Wed, 29 Aug 2018 16:27:51 +0800")
Message-ID: <87a7p5jzp3.fsf@bootlin.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jisheng,
 
 On mer., août 29 2018, Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:

> Commit 7e47fd84b56b ("net: mvneta: Allocate page for the descriptor")
> always allocate one page for each rx descriptor, so the rx is mapped
> with dmap_map_page() now, but the unmap routine isn't updated at the
> same time.
>
> Fix this by using dma_unmap_page() in corresponding places.
>
> Fixes: 7e47fd84b56b ("net: mvneta: Allocate page for the descriptor")
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
>  drivers/net/ethernet/marvell/mvneta.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
> index 0ce94f6587a5..d9206094fce3 100644
> --- a/drivers/net/ethernet/marvell/mvneta.c
> +++ b/drivers/net/ethernet/marvell/mvneta.c
> @@ -1890,8 +1890,9 @@ static void mvneta_rxq_drop_pkts(struct mvneta_port *pp,
>  		if (!data || !(rx_desc->buf_phys_addr))
>  			continue;
>  
> -		dma_unmap_single(pp->dev->dev.parent, rx_desc->buf_phys_addr,
> -				 MVNETA_RX_BUF_SIZE(pp->pkt_size), DMA_FROM_DEVICE);
> +		dma_unmap_page(pp->dev->dev.parent, rx_desc->buf_phys_addr,
> +			       MVNETA_RX_BUF_SIZE(pp->pkt_size),
> +			       DMA_FROM_DEVICE);
>  		__free_page(data);
>  	}
>  }
This one can be called when the allocation is done in with HWBM in this
case which use a dma_map_single.

Gregory



> @@ -2008,8 +2009,8 @@ static int mvneta_rx_swbm(struct napi_struct *napi,
>  				skb_add_rx_frag(rxq->skb, frag_num, page,
>  						frag_offset, frag_size,
>  						PAGE_SIZE);
> -				dma_unmap_single(dev->dev.parent, phys_addr,
> -						 PAGE_SIZE, DMA_FROM_DEVICE);
> +				dma_unmap_page(dev->dev.parent, phys_addr,
> +					       PAGE_SIZE, DMA_FROM_DEVICE);
>  				rxq->left_size -= frag_size;
>  			}
>  		} else {
> @@ -2039,9 +2040,8 @@ static int mvneta_rx_swbm(struct napi_struct *napi,
>  						frag_offset, frag_size,
>  						PAGE_SIZE);
>  
> -				dma_unmap_single(dev->dev.parent, phys_addr,
> -						 PAGE_SIZE,
> -						 DMA_FROM_DEVICE);
> +				dma_unmap_page(dev->dev.parent, phys_addr,
> +					       PAGE_SIZE, DMA_FROM_DEVICE);
>  
>  				rxq->left_size -= frag_size;
>  			}
> -- 
> 2.18.0
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
