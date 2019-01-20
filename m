Return-Path: <SRS0=5EgK=P4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B53DEC61CE4
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 11:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F4542084F
	for <linux-kernel@archiver.kernel.org>; Sun, 20 Jan 2019 11:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547982355;
	bh=wG3z5ITXAES2jgkOil2PTVNtsT+82+7nAmey+q+++8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=T+umdVS5d4PdNw3FH5kzCIqe5UeD1Z6G6Tiw1h89l9CMP0S/WmknlpKMTKJfgWwC8
	 qyz9WxG2S78IcIYpRBIG94pQxaTHFJjS+5sGCJKJ5f4vu0tTDbhKxzGVMoMfS9EQSj
	 e1+uxeleMg1kPCTUs+Nd0wc346Fp/z5zT43auq8M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730478AbfATLFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 20 Jan 2019 06:05:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:54850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728781AbfATLFx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Jan 2019 06:05:53 -0500
Received: from localhost (unknown [122.178.235.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FC4A2084F;
        Sun, 20 Jan 2019 11:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547982351;
        bh=wG3z5ITXAES2jgkOil2PTVNtsT+82+7nAmey+q+++8k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WTowMNusXZzUjqNrxBzGneaywZIP4Pe62784EJmMx2AImSMv2NMipxCscEBgy/N4X
         2pr16/6Ly8cwIYFHQVJxFLJzPWd2yhV0Q+cgqFIM1sZmZdheJvjvJIQbxL5x17jvV2
         1Z+jz19GSPV5mhhlI4Y62qa7OrfF0nE3LmVBZvR4=
Date:   Sun, 20 Jan 2019 16:34:17 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Codrin.Ciubotariu@microchip.com
Cc:     Ludovic.Desroches@microchip.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: at_xdmac: Fix wrongfull report of a channel
 as in use
Message-ID: <20190120110417.GS4635@vkoul-mobl>
References: <20190117160957.13175-1-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190117160957.13175-1-codrin.ciubotariu@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Codrin,

On 17-01-19, 16:10, Codrin.Ciubotariu@microchip.com wrote:
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

This looks reasonable but am unable to see how the bug is fixed. Perhaps
would be great to split the bug part (which can go to fixes) and remove
the reuse of variable as a subsequent patch..

> 
> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
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

-- 
~Vinod
