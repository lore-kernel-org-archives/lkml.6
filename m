Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 013BBC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 00:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96A8820870
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 00:00:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="TL+bnCl1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96A8820870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbeIYGFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 02:05:22 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:44144 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726366AbeIYGFW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 02:05:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=NnSHijSgBXWNqEIC2oxR7eMFo/tZeySvz7WOeRyJjfo=;
        b=TL+bnCl1jiONa8eXSGatTgrDZt/SBPlOC0qkmyibnOs5nY1YRMVUqD/dQ/QmyRiPAYWxbykMhI/IryNks/H9rkMJS8dkgsV8LB2nQphNU8MR7wk14uzGz4kQ2O8CcNGYdBlz5PeZY8Q0HVPFtYIViKWxbcSdbfR+f15scGlLSog=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1g4amJ-0006M5-Qs; Tue, 25 Sep 2018 02:00:35 +0200
Date:   Tue, 25 Sep 2018 02:00:35 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Moritz Fischer <mdf@kernel.org>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        keescook@chromium.org, davem@davemloft.net,
        moritz.fischer@ettus.com, f.fainelli@gmail.com,
        alex.williams@ni.com
Subject: Re: [PATCH] net: nixge: Address compiler warnings when building for
 i386
Message-ID: <20180925000035.GA24003@lunn.ch>
References: <20180924212712.1790-1-mdf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180924212712.1790-1-mdf@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 02:27:12PM -0700, Moritz Fischer wrote:
> Address compiler warnings reported by kbuild autobuilders
> when building for i386 as a result of dma_addr_t size on
> different architectures.
> 
> warning: cast to pointer from integer of different size
> 	[-Wint-to-pointer-cast]
> 
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> ---
>  drivers/net/ethernet/ni/nixge.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ni/nixge.c b/drivers/net/ethernet/ni/nixge.c
> index 74cf52e3fb09..0611f2335b4a 100644
> --- a/drivers/net/ethernet/ni/nixge.c
> +++ b/drivers/net/ethernet/ni/nixge.c
> @@ -127,8 +127,8 @@ struct nixge_hw_dma_bd {
>  #ifdef CONFIG_PHYS_ADDR_T_64BIT
>  #define nixge_hw_dma_bd_set_addr(bd, field, addr) \
>  	do { \
> -		(bd)->field##_lo = lower_32_bits(((u64)addr)); \
> -		(bd)->field##_hi = upper_32_bits(((u64)addr)); \
> +		(bd)->field##_lo = lower_32_bits((addr)); \
> +		(bd)->field##_hi = upper_32_bits((addr)); \
>  	} while (0)

Hi Maritz

Maybe turn this into an function. It is small enough it will get
inlined.  You then gain type checking. Make addr a void *.

>  #else
>  #define nixge_hw_dma_bd_set_addr(bd, field, addr) \
> @@ -251,7 +251,7 @@ static void nixge_hw_dma_bd_release(struct net_device *ndev)
>  				 NIXGE_MAX_JUMBO_FRAME_SIZE,
>  				 DMA_FROM_DEVICE);
>  
> -		skb = (struct sk_buff *)
> +		skb = (struct sk_buff *)(uintptr_t)
>  			nixge_hw_dma_bd_get_addr(&priv->rx_bd_v[i],
>  						 sw_id_offset);

How about making nixge_hw_dma_bd_get_addr return a void *. You can
assign that to anything without needing a cast.

       Andrew
