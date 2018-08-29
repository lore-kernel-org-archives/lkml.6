Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F172C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 09:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 128B320868
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 09:37:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 128B320868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbeH2NdS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 09:33:18 -0400
Received: from mail.bootlin.com ([62.4.15.54]:46056 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727107AbeH2NdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 09:33:18 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 9E828207AD; Wed, 29 Aug 2018 11:37:15 +0200 (CEST)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 6EB002071E;
        Wed, 29 Aug 2018 11:37:15 +0200 (CEST)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     <thomas.petazzoni@bootlin.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH 3/5] net: mvneta: Don't check NETIF_F_GRO ourself
References: <20180829162456.2bd69796@xhacker.debian>
        <20180829162836.2551ba46@xhacker.debian>
Date:   Wed, 29 Aug 2018 11:37:14 +0200
In-Reply-To: <20180829162836.2551ba46@xhacker.debian> (Jisheng Zhang's message
        of "Wed, 29 Aug 2018 16:28:36 +0800")
Message-ID: <875zztjyyd.fsf@bootlin.com>
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

> napi_gro_receive() checks NETIF_F_GRO bit as well, if the bit is not
> set, we will go through GRO_NORMAL in napi_skb_finish(), so fall back
> to netif_receive_skb_internal(), so we don't need to check NETIF_F_GRO
> ourself.

this one is not a fix and it should go to net-next.

And for the patch it looks OK:

Reviewed-by: Gregory CLEMENT <gregory.clement@bootlin.com>

Thanks,

Gregory


>
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
>  drivers/net/ethernet/marvell/mvneta.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
> index d9206094fce3..06634d4f9b94 100644
> --- a/drivers/net/ethernet/marvell/mvneta.c
> +++ b/drivers/net/ethernet/marvell/mvneta.c
> @@ -2065,10 +2065,7 @@ static int mvneta_rx_swbm(struct napi_struct *napi,
>  		/* Linux processing */
>  		rxq->skb->protocol = eth_type_trans(rxq->skb, dev);
>  
> -		if (dev->features & NETIF_F_GRO)
> -			napi_gro_receive(napi, rxq->skb);
> -		else
> -			netif_receive_skb(rxq->skb);
> +		napi_gro_receive(napi, rxq->skb);
>  
>  		/* clean uncomplete skb pointer in queue */
>  		rxq->skb = NULL;
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
