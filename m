Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64481ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28EDF2087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 15:37:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28EDF2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730936AbeIXVj5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:39:57 -0400
Received: from mail.bootlin.com ([62.4.15.54]:44671 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727770AbeIXVj5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 17:39:57 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 4A28B20725; Mon, 24 Sep 2018 17:37:10 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id F28CE204AE;
        Mon, 24 Sep 2018 17:37:09 +0200 (CEST)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Antoine Tenart <antoine.tenart@bootlin.com>
Cc:     davem@davemloft.net, yelena@marvell.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        maxime.chevallier@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com
Subject: Re: [PATCH net] net: mvneta: fix the remaining Rx descriptor unmapping issues
References: <20180924145613.27307-1-antoine.tenart@bootlin.com>
Date:   Mon, 24 Sep 2018 17:37:10 +0200
In-Reply-To: <20180924145613.27307-1-antoine.tenart@bootlin.com> (Antoine
        Tenart's message of "Mon, 24 Sep 2018 16:56:13 +0200")
Message-ID: <874leegb4p.fsf@bootlin.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Antoine,
 
 On lun., sept. 24 2018, Antoine Tenart <antoine.tenart@bootlin.com> wrote:

> With CONFIG_DMA_API_DEBUG enabled we get DMA unmapping warning in
> various places of the mvneta driver, for example when putting down an
> interface while traffic is passing through.
>
> The issue is when using s/w buffer management, the Rx buffers are mapped
> using dma_map_page but unmapped with dma_unmap_single. This patch fixes
> this by using the right unmapping function.
>
> Fixes: 562e2f467e71 ("net: mvneta: Improve the buffer allocation method for SWBM")
> Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>

Given the clarification provided by Yelen, this patch looks good:

Reviewed-by: Gregory CLEMENT <gregory.clement@bootlin.com>

Thanks,

Gregory


> ---
>  drivers/net/ethernet/marvell/mvneta.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
> index 2db9708f2e24..b4ed7d394d07 100644
> --- a/drivers/net/ethernet/marvell/mvneta.c
> +++ b/drivers/net/ethernet/marvell/mvneta.c
> @@ -1890,8 +1890,8 @@ static void mvneta_rxq_drop_pkts(struct mvneta_port *pp,
>  		if (!data || !(rx_desc->buf_phys_addr))
>  			continue;
>  
> -		dma_unmap_single(pp->dev->dev.parent, rx_desc->buf_phys_addr,
> -				 MVNETA_RX_BUF_SIZE(pp->pkt_size), DMA_FROM_DEVICE);
> +		dma_unmap_page(pp->dev->dev.parent, rx_desc->buf_phys_addr,
> +			       PAGE_SIZE, DMA_FROM_DEVICE);
>  		__free_page(data);
>  	}
>  }
> @@ -2039,9 +2039,8 @@ static int mvneta_rx_swbm(struct napi_struct *napi,
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
> 2.17.1
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
