Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CAA2C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 13:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E0D020989
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 13:51:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E0D020989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbeK3A46 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 19:56:58 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:50912 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726949AbeK3A46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 19:56:58 -0500
X-IronPort-AV: E=Sophos;i="5.56,294,1539673200"; 
   d="scan'208";a="24655063"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 29 Nov 2018 06:51:32 -0700
Received: from localhost (10.10.76.4) by chn-sv-exch06.mchp-main.com
 (10.10.76.107) with Microsoft SMTP Server id 14.3.352.0; Thu, 29 Nov 2018
 06:51:31 -0700
Date:   Thu, 29 Nov 2018 14:51:24 +0100
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
Subject: Re: [PATCH] dmaengine: at_hdmac: fix memory leak in at_dma_xlate()
Message-ID: <20181129135124.qyz6avwqidk7dfyu@M43218.corp.atmel.com>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181127160635.11836-1-richard.genoud@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 05:06:34PM +0100, Richard Genoud wrote:
> The leak was found when opening/closing a serial port a great number of
> time, increasing kmalloc-32 in slabinfo.
> 
> Each time the port was opened, dma_request_slave_channel() was called.
> Then, in at_dma_xlate(), atslave was allocated with devm_kzalloc() and
> never freed. (Well, it was free at module unload, but that's not what we
> want).
> So, here, kzalloc is more suited for the job since it has to be freed in
> atc_free_chan_resources().
> 
> Cc: stable@vger.kernel.org
> Fixes: bbe89c8e3d59 ("at_hdmac: move to generic DMA binding")
> Reported-by: Mario Forner <m.forner@be4energy.com>
> Suggested-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>

Thanks for handling this issue.

Ludovic

> ---
>  drivers/dma/at_hdmac.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
> index 7cbac6e8c113..1b7f0ca0d5cd 100644
> --- a/drivers/dma/at_hdmac.c
> +++ b/drivers/dma/at_hdmac.c
> @@ -1641,6 +1641,12 @@ static void atc_free_chan_resources(struct dma_chan *chan)
>  	atchan->descs_allocated = 0;
>  	atchan->status = 0;
>  
> +	/*
> +	 * Free atslave allocated in at_dma_xlate()
> +	 */
> +	kfree(chan->private);
> +	chan->private = NULL;
> +
>  	dev_vdbg(chan2dev(chan), "free_chan_resources: done\n");
>  }
>  
> @@ -1675,7 +1681,7 @@ static struct dma_chan *at_dma_xlate(struct of_phandle_args *dma_spec,
>  	dma_cap_zero(mask);
>  	dma_cap_set(DMA_SLAVE, mask);
>  
> -	atslave = devm_kzalloc(&dmac_pdev->dev, sizeof(*atslave), GFP_KERNEL);
> +	atslave = kzalloc(sizeof(*atslave), GFP_KERNEL);
>  	if (!atslave)
>  		return NULL;
>  
