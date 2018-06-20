Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB64C43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA1C320846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:17:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA1C320846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754360AbeFTRRy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 13:17:54 -0400
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:34952 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754153AbeFTRRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 13:17:51 -0400
Received: from belgarion ([90.55.203.186])
        by mwinf5d64 with ME
        id 15Hq1y00141oiFu035Hqjg; Wed, 20 Jun 2018 19:17:50 +0200
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Wed, 20 Jun 2018 19:17:50 +0200
X-ME-IP: 90.55.203.186
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Daniel Mack <daniel@zonque.org>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH v3 08/14] net: smc91x: remove the dmaengine compat need
References: <20180617170217.24177-1-robert.jarzmik@free.fr>
        <20180617170217.24177-9-robert.jarzmik@free.fr>
X-URL:  http://belgarath.falguerolles.org/
Date:   Wed, 20 Jun 2018 19:17:49 +0200
In-Reply-To: <20180617170217.24177-9-robert.jarzmik@free.fr> (Robert Jarzmik's
        message of "Sun, 17 Jun 2018 19:02:11 +0200")
Message-ID: <87lgb9pebm.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

I have converted all the pxa related drivers to DMA slave maps, the only 2 that
remain in my queue are touching your tree, ie. smc911x and smc91x (see [1]).

Once these 2 are done, I have my last dependency on the dma filter function
removed, and can queue the remaining cleanup patches.

Could you (or somebody from netdev) review it and either ack it (and I'll take
it through the pxa tree), or take it for v4.19 please ?

Cheers.

--
Robert

[1] Submission
Robert Jarzmik <robert.jarzmik@free.fr> writes:

> As the pxa architecture switched towards the dmaengine slave map, the
> old compatibility mechanism to acquire the dma requestor line number and
> priority are not needed anymore.
>
> This patch simplifies the dma resource acquisition, using the more
> generic function dma_request_slave_channel().
>
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---
> Since v2: converted to NULL filter function and NULL dma parameter call
> ---
>  drivers/net/ethernet/smsc/smc91x.c | 9 +--------
>  drivers/net/ethernet/smsc/smc91x.h | 1 -
>  2 files changed, 1 insertion(+), 9 deletions(-)
>
> diff --git a/drivers/net/ethernet/smsc/smc91x.c b/drivers/net/ethernet/smsc/smc91x.c
> index 080428762858..b944828f9ea3 100644
> --- a/drivers/net/ethernet/smsc/smc91x.c
> +++ b/drivers/net/ethernet/smsc/smc91x.c
> @@ -2019,17 +2019,10 @@ static int smc_probe(struct net_device *dev, void __iomem *ioaddr,
>  #  endif
>  	if (lp->cfg.flags & SMC91X_USE_DMA) {
>  		dma_cap_mask_t mask;
> -		struct pxad_param param;
>  
>  		dma_cap_zero(mask);
>  		dma_cap_set(DMA_SLAVE, mask);
> -		param.prio = PXAD_PRIO_LOWEST;
> -		param.drcmr = -1UL;
> -
> -		lp->dma_chan =
> -			dma_request_slave_channel_compat(mask, pxad_filter_fn,
> -							 &param, &dev->dev,
> -							 "data");
> +		lp->dma_chan = dma_request_channel(mask, NULL, NULL);
>  	}
>  #endif
>  
> diff --git a/drivers/net/ethernet/smsc/smc91x.h b/drivers/net/ethernet/smsc/smc91x.h
> index b337ee97e0c0..a27352229fc2 100644
> --- a/drivers/net/ethernet/smsc/smc91x.h
> +++ b/drivers/net/ethernet/smsc/smc91x.h
> @@ -301,7 +301,6 @@ struct smc_local {
>   * as RX which can overrun memory and lose packets.
>   */
>  #include <linux/dma-mapping.h>
> -#include <linux/dma/pxa-dma.h>
>  
>  #ifdef SMC_insl
>  #undef SMC_insl

-- 
Robert
