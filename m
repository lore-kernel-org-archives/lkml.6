Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 296F9C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 13:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFA2C20989
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 13:53:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFA2C20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728439AbeK3A6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 19:58:33 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:15999 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbeK3A6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 19:58:33 -0500
X-IronPort-AV: E=Sophos;i="5.56,294,1539673200"; 
   d="scan'208";a="23803517"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 29 Nov 2018 06:53:06 -0700
Received: from localhost (10.10.76.4) by chn-sv-exch04.mchp-main.com
 (10.10.76.105) with Microsoft SMTP Server id 14.3.352.0; Thu, 29 Nov 2018
 06:53:06 -0700
Date:   Thu, 29 Nov 2018 14:52:59 +0100
From:   Ludovic Desroches <ludovic.desroches@microchip.com>
To:     Richard Genoud <richard.genoud@gmail.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Mario Forner <m.forner@be4energy.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH] dmaengine: at_hdmac: fix module unloading
Message-ID: <20181129135259.nhzx5wvpc6kxosto@M43218.corp.atmel.com>
Mail-Followup-To: Richard Genoud <richard.genoud@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Mario Forner <m.forner@be4energy.com>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        stable@vger.kernel.org
References: <20181127160635.11836-1-richard.genoud@gmail.com>
 <20181127160635.11836-2-richard.genoud@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181127160635.11836-2-richard.genoud@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 05:06:35PM +0100, Richard Genoud wrote:
> of_dma_controller_free() was not called on module onloading.

s/onloading/unloading

> This lead to a soft lockup:
> watchdog: BUG: soft lockup - CPU#0 stuck for 23s!
> Modules linked in: at_hdmac [last unloaded: at_hdmac]
> when of_dma_request_slave_channel() tried to call ofdma->of_dma_xlate().
> 
> Cc: stable@vger.kernel.org
> Fixes: bbe89c8e3d59 ("at_hdmac: move to generic DMA binding")
> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>

Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>

Thanks

Ludovic

> ---
>  drivers/dma/at_hdmac.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
> index 1b7f0ca0d5cd..01d936c9fe89 100644
> --- a/drivers/dma/at_hdmac.c
> +++ b/drivers/dma/at_hdmac.c
> @@ -2006,6 +2006,8 @@ static int at_dma_remove(struct platform_device *pdev)
>  	struct resource		*io;
>  
>  	at_dma_off(atdma);
> +	if (pdev->dev.of_node)
> +		of_dma_controller_free(pdev->dev.of_node);
>  	dma_async_device_unregister(&atdma->dma_common);
>  
>  	dma_pool_destroy(atdma->memset_pool);
