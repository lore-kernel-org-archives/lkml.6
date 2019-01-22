Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA72C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F7282085A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 09:13:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727622AbfAVJNa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 04:13:30 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:15414 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727517AbfAVJNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 04:13:30 -0500
X-IronPort-AV: E=Sophos;i="5.56,505,1539673200"; 
   d="scan'208";a="25618244"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 22 Jan 2019 02:13:29 -0700
Received: from localhost (10.10.76.4) by chn-sv-exch06.mchp-main.com
 (10.10.76.107) with Microsoft SMTP Server id 14.3.352.0; Tue, 22 Jan 2019
 02:13:28 -0700
Date:   Tue, 22 Jan 2019 10:13:17 +0100
From:   Ludovic Desroches <ludovic.desroches@microchip.com>
To:     Codrin Ciubotariu - M19940 <Codrin.Ciubotariu@microchip.com>
CC:     "vkoul@kernel.org" <vkoul@kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dmaengine: at_xdmac: Fix wrongfull report of a channel
 as in use
Message-ID: <20190122091317.47iwli4ru4iom7fg@M43218.corp.atmel.com>
Mail-Followup-To: Codrin Ciubotariu - M19940 <Codrin.Ciubotariu@microchip.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20190117160957.13175-1-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190117160957.13175-1-codrin.ciubotariu@microchip.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 05:10:38PM +0100, Codrin Ciubotariu - M19940 wrote:
> From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> 
> atchan->status is used for two things:
>  - pass channel interrupts status from interrupt handler to tasklet;
>  - channel information like whether it is cyclic or paused;
> 
> Since these operations have nothing in common, this patch adds a
> different struct member to keep the interrupts status.
> 
> Fixes a bug in which a channel is wrongfully reported as in use when
> trying to obtain a new descriptior for a previously used cyclic channel.
> 
> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>

As Vinod suggested, you may change the commit message to emphasize
that the bug comes from the fact that a single variable is used to store
different information.

The Fixes: tag should be added too.

Regards

Ludovic

> ---
>  drivers/dma/at_xdmac.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
> index 4e557684f792..fe69dccfa0c0 100644
> --- a/drivers/dma/at_xdmac.c
> +++ b/drivers/dma/at_xdmac.c
> @@ -203,6 +203,7 @@ struct at_xdmac_chan {
>  	u32				save_cim;
>  	u32				save_cnda;
>  	u32				save_cndc;
> +	u32				irq_status;
>  	unsigned long			status;
>  	struct tasklet_struct		tasklet;
>  	struct dma_slave_config		sconfig;
> @@ -1580,8 +1581,8 @@ static void at_xdmac_tasklet(unsigned long data)
>  	struct at_xdmac_desc	*desc;
>  	u32			error_mask;
>  
> -	dev_dbg(chan2dev(&atchan->chan), "%s: status=0x%08lx\n",
> -		 __func__, atchan->status);
> +	dev_dbg(chan2dev(&atchan->chan), "%s: status=0x%08x\n",
> +		__func__, atchan->irq_status);
>  
>  	error_mask = AT_XDMAC_CIS_RBEIS
>  		     | AT_XDMAC_CIS_WBEIS
> @@ -1589,15 +1590,15 @@ static void at_xdmac_tasklet(unsigned long data)
>  
>  	if (at_xdmac_chan_is_cyclic(atchan)) {
>  		at_xdmac_handle_cyclic(atchan);
> -	} else if ((atchan->status & AT_XDMAC_CIS_LIS)
> -		   || (atchan->status & error_mask)) {
> +	} else if ((atchan->irq_status & AT_XDMAC_CIS_LIS)
> +		   || (atchan->irq_status & error_mask)) {
>  		struct dma_async_tx_descriptor  *txd;
>  
> -		if (atchan->status & AT_XDMAC_CIS_RBEIS)
> +		if (atchan->irq_status & AT_XDMAC_CIS_RBEIS)
>  			dev_err(chan2dev(&atchan->chan), "read bus error!!!");
> -		if (atchan->status & AT_XDMAC_CIS_WBEIS)
> +		if (atchan->irq_status & AT_XDMAC_CIS_WBEIS)
>  			dev_err(chan2dev(&atchan->chan), "write bus error!!!");
> -		if (atchan->status & AT_XDMAC_CIS_ROIS)
> +		if (atchan->irq_status & AT_XDMAC_CIS_ROIS)
>  			dev_err(chan2dev(&atchan->chan), "request overflow error!!!");
>  
>  		spin_lock(&atchan->lock);
> @@ -1652,7 +1653,7 @@ static irqreturn_t at_xdmac_interrupt(int irq, void *dev_id)
>  			atchan = &atxdmac->chan[i];
>  			chan_imr = at_xdmac_chan_read(atchan, AT_XDMAC_CIM);
>  			chan_status = at_xdmac_chan_read(atchan, AT_XDMAC_CIS);
> -			atchan->status = chan_status & chan_imr;
> +			atchan->irq_status = chan_status & chan_imr;
>  			dev_vdbg(atxdmac->dma.dev,
>  				 "%s: chan%d: imr=0x%x, status=0x%x\n",
>  				 __func__, i, chan_imr, chan_status);
> @@ -1666,7 +1667,7 @@ static irqreturn_t at_xdmac_interrupt(int irq, void *dev_id)
>  				 at_xdmac_chan_read(atchan, AT_XDMAC_CDA),
>  				 at_xdmac_chan_read(atchan, AT_XDMAC_CUBC));
>  
> -			if (atchan->status & (AT_XDMAC_CIS_RBEIS | AT_XDMAC_CIS_WBEIS))
> +			if (atchan->irq_status & (AT_XDMAC_CIS_RBEIS | AT_XDMAC_CIS_WBEIS))
>  				at_xdmac_write(atxdmac, AT_XDMAC_GD, atchan->mask);
>  
>  			tasklet_schedule(&atchan->tasklet);
> -- 
> 2.17.1
> 
