Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A75A9C282F6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D7AD2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:17:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727566AbfAUJRp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 04:17:45 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:50893 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726058AbfAUJRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 04:17:45 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1glViB-0007tO-OZ; Mon, 21 Jan 2019 10:17:43 +0100
Message-ID: <1548062262.2465.5.camel@pengutronix.de>
Subject: Re: [PATCH v2 2/3] dma: imx-sdma: add clock ratio 1:1 check
From:   Lucas Stach <l.stach@pengutronix.de>
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     linux-kernel@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date:   Mon, 21 Jan 2019 10:17:42 +0100
In-Reply-To: <20190120023150.17138-3-angus@akkea.ca>
References: <20190120023150.17138-1-angus@akkea.ca>
         <20190120023150.17138-3-angus@akkea.ca>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::2a
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Angus,

Am Samstag, den 19.01.2019, 19:31 -0700 schrieb Angus Ainslie (Purism):
> On i.mx8 mscale B0 chip, AHB/SDMA clock ratio 2:1 can't be supportted,
> since SDMA clock ratio has to be increased to 250Mhz, AHB can't reach
> to 500Mhz, so use 1:1 instead.
> 
> based on NXP commit MLK-16841-1
> 
> > Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
> ---
>  .../devicetree/bindings/dma/fsl-imx-sdma.txt  |  1 +
>  drivers/dma/imx-sdma.c                        | 20 +++++++++++++++----
>  2 files changed, 17 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt b/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
> index 3c9a57a8443b..17544c1820b7 100644
> --- a/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
> +++ b/Documentation/devicetree/bindings/dma/fsl-imx-sdma.txt
> @@ -67,6 +67,7 @@ Optional properties:
>      reg is the GPR register offset.
>      shift is the bit position inside the GPR register.
>      val is the value of the bit (0 or 1).
> +- fsl,ratio-1-1: AHB/SDMA core clock ration 1:1, 2:1 without this.

Why does this need a separate DT property? Shouldn't the driver be able
to infer this from the clock rates going into the SDMA hardware?

Regards,
Lucas

>  Examples:
>  
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index 0b3a67ff8e82..65dada21d3c1 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -440,6 +440,8 @@ struct sdma_engine {
> > >  	unsigned int			irq;
> > >  	dma_addr_t			bd0_phys;
> > >  	struct sdma_buffer_descriptor	*bd0;
> > +	/* clock ratio for AHB:SDMA core. 1:1 is 1, 2:1 is 0*/
> > > +	bool				clk_ratio;
>  };
>  
>  static int sdma_config_write(struct dma_chan *chan,
> @@ -662,8 +664,14 @@ static int sdma_run_channel0(struct sdma_engine *sdma)
> >  		dev_err(sdma->dev, "Timeout waiting for CH0 ready\n");
>  
> >  	/* Set bits of CONFIG register with dynamic context switching */
> > -	if (readl(sdma->regs + SDMA_H_CONFIG) == 0)
> > -		writel_relaxed(SDMA_H_CONFIG_CSM, sdma->regs + SDMA_H_CONFIG);
> > +	if (readl(sdma->regs + SDMA_H_CONFIG) == 0) {
> > +		if (sdma->clk_ratio)
> > +			reg = SDMA_H_CONFIG_CSM | SDMA_H_CONFIG_ACR;
> > +		else
> > +			reg = SDMA_H_CONFIG_CSM;
> +
> > +		writel_relaxed(reg, sdma->regs + SDMA_H_CONFIG);
> > +	}
>  
> >  	return ret;
>  }
> @@ -1880,8 +1888,10 @@ static int sdma_init(struct sdma_engine *sdma)
> >  	writel_relaxed(0x4050, sdma->regs + SDMA_CHN0ADDR);
>  
> >  	/* Set bits of CONFIG register but with static context switching */
> > -	/* FIXME: Check whether to set ACR bit depending on clock ratios */
> > -	writel_relaxed(0, sdma->regs + SDMA_H_CONFIG);
> > +	if (sdma->clk_ratio)
> > +		writel_relaxed(SDMA_H_CONFIG_ACR, sdma->regs + SDMA_H_CONFIG);
> > +	else
> > +		writel_relaxed(0, sdma->regs + SDMA_H_CONFIG);
>  
> >  	writel_relaxed(ccb_phys, sdma->regs + SDMA_H_C0PTR);
>  
> @@ -1975,6 +1985,8 @@ static int sdma_probe(struct platform_device *pdev)
> >  	if (!sdma)
> >  		return -ENOMEM;
>  
> > +	sdma->clk_ratio = of_property_read_bool(np, "fsl,ratio-1-1");
> +
> >  	spin_lock_init(&sdma->channel_0_lock);
>  
> >  	sdma->dev = &pdev->dev;
