Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D340AC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72FE520673
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="pNo8PARD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72FE520673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731804AbeGSPBH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 11:01:07 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:57470 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbeGSPBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 11:01:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mR37eHaEzLeEQkmPX9tgSKfIdMJ/nLGkMH1Qur6wNKg=; b=pNo8PARDj1VJT9b8SK9ALnYn4
        YwVXN68pwKbBe8L4cRSpAFcaZXb2bls9/FARO+VZaon0JOKjo5ZhCMl+B2f0SW2wAh5jSp/iYeA37
        buoIUiqGOCjJDqgNUw98kPL+Crb4tlkutqkelCpGA2GPwzt2Dfh3exEqG+3oKLxHFedtQ=;
Received: from n2100.armlinux.org.uk ([fd8f:7570:feb6:1:214:fdff:fe10:4f86]:58033)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1fg9kH-000664-G7; Thu, 19 Jul 2018 15:17:29 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1fg9kD-0003eF-L2; Thu, 19 Jul 2018 15:17:25 +0100
Date:   Thu, 19 Jul 2018 15:17:23 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     davem@davemloft.net, nbd@openwrt.org, john@phrozen.org,
        sean.wang@mediatek.com, nelson.chang@mediatek.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] net: mediatek: use dma_zalloc_coherent instead of
 allocator/memset
Message-ID: <20180719141723.GM17271@n2100.armlinux.org.uk>
References: <20180719140955.19444-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180719140955.19444-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 10:09:55PM +0800, YueHaibing wrote:
> Use dma_zalloc_coherent instead of dma_alloc_coherent
> followed by memset 0.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/net/ethernet/mediatek/mtk_eth_soc.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> index d8ebf0a..fbdb3e3 100644
> --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> @@ -1221,14 +1221,11 @@ static int mtk_tx_alloc(struct mtk_eth *eth)
>  	if (!ring->buf)
>  		goto no_tx_mem;
>  
> -	ring->dma = dma_alloc_coherent(eth->dev,
> -					  MTK_DMA_SIZE * sz,
> -					  &ring->phys,
> -					  GFP_ATOMIC | __GFP_ZERO);
> +	ring->dma = dma_zalloc_coherent(eth->dev, MTK_DMA_SIZE * sz,
> +					&ring->phys, GFP_ATOMIC | __GFP_ZERO);
>  	if (!ring->dma)
>  		goto no_tx_mem;
>  
> -	memset(ring->dma, 0, MTK_DMA_SIZE * sz);

I have to wonder whether this code needs two forms of zeroing... in
the original code, __GFP_ZERO _and_ a call to memset() just in case
__GFP_ZERO failed to do its job, and in the replacement code, just
in case dma_zalloc_coherent() hasn't got the idea...

I think you can drop the __GFP_ZERO. ;)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 13.8Mbps down 630kbps up
According to speedtest.net: 13Mbps down 490kbps up
