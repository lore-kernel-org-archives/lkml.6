Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F55C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 12:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E8AB2083B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 12:31:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbfBEMbF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 07:31:05 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:4302 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727290AbfBEMbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 07:31:05 -0500
X-IronPort-AV: E=Sophos;i="5.56,563,1539673200"; 
   d="scan'208";a="26160965"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 05 Feb 2019 05:31:04 -0700
Received: from localhost (10.10.76.4) by chn-sv-exch04.mchp-main.com
 (10.10.76.105) with Microsoft SMTP Server id 14.3.352.0; Tue, 5 Feb 2019
 05:31:04 -0700
Date:   Tue, 5 Feb 2019 13:30:51 +0100
From:   Ludovic Desroches <ludovic.desroches@microchip.com>
To:     Nicolas Ferre <nicolas.ferre@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, "Vinod Koul" <vkoul@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] dmaengine: at_xdmac: remove BUG_ON macro in tasklet
Message-ID: <20190205123051.twnr45lawslr5ccr@M43218.corp.atmel.com>
Mail-Followup-To: Nicolas Ferre <nicolas.ferre@microchip.com>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org
References: <324b91c71a148a7694d28d9b8b4364095d9b0ebe.1549364323.git.nicolas.ferre@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <324b91c71a148a7694d28d9b8b4364095d9b0ebe.1549364323.git.nicolas.ferre@microchip.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2019 at 12:03:41PM +0100, Nicolas Ferre wrote:
> Even if this case shouldn't happen when controller is properly programmed,
> it's still better to avoid dumping a kernel Oops for this.
> As the sequence may happen only for debugging purposes, log the error and
> just finish the tasklet call.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>

Thanks

> ---
>  drivers/dma/at_xdmac.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
> index fe69dccfa0c0..37a269420435 100644
> --- a/drivers/dma/at_xdmac.c
> +++ b/drivers/dma/at_xdmac.c
> @@ -1606,7 +1606,11 @@ static void at_xdmac_tasklet(unsigned long data)
>  					struct at_xdmac_desc,
>  					xfer_node);
>  		dev_vdbg(chan2dev(&atchan->chan), "%s: desc 0x%p\n", __func__, desc);
> -		BUG_ON(!desc->active_xfer);
> +		if (!desc->active_xfer) {
> +			dev_err(chan2dev(&atchan->chan), "Xfer not active: exiting");
> +			spin_unlock_bh(&atchan->lock);
> +			return;
> +		}
>  
>  		txd = &desc->tx_dma_desc;
>  
> -- 
> 2.17.1
> 
