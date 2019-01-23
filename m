Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 573FFC282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 15:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EBD1218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 15:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbfAWPnz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 10:43:55 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:59125 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726243AbfAWPnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 10:43:55 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1gmKgu-0008R4-DT; Wed, 23 Jan 2019 16:43:48 +0100
Message-ID: <1548258228.28802.5.camel@pengutronix.de>
Subject: Re: [PATCH v3 1/5] dma: imx-sdma: add clock ratio 1:1 check
From:   Lucas Stach <l.stach@pengutronix.de>
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     angus.ainslie@puri.sm, Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Daniel Baluta <daniel.baluta@gmail.com>
Date:   Wed, 23 Jan 2019 16:43:48 +0100
In-Reply-To: <20190123152310.11680-2-angus@akkea.ca>
References: <20190120023150.17138-1-angus@akkea.ca>
         <20190123152310.11680-1-angus@akkea.ca>
         <20190123152310.11680-2-angus@akkea.ca>
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

Am Mittwoch, den 23.01.2019, 08:23 -0700 schrieb Angus Ainslie (Purism):
> On i.mx8 mscale B0 chip, AHB/SDMA clock ratio 2:1 can't be supportted,
> since SDMA clock ratio has to be increased to 250Mhz, AHB can't reach
> to 500Mhz, so use 1:1 instead.
> 
> > Based on NXP commit MLK-16841-1 by Robin Gong <yibin.gong@nxp.com>
> 
> > Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
> ---
>  drivers/dma/imx-sdma.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index 0b3a67ff8e82..531a9d8b032a 100644
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
> +	if (readl(sdma->regs + SDMA_H_CONFIG) == 0) {

If the ACR bit gets set in sdma_init(), do we ever end up in this code
path? From a quick glance it seems we might wrongfully skip the CSM
enable here.

> +		if (sdma->clk_ratio)
> > +			reg = SDMA_H_CONFIG_CSM | SDMA_H_CONFIG_ACR;
> > +		else
> +			reg = SDMA_H_CONFIG_CSM;

That's a personal style preference, but I would write this as:

reg = SDMA_H_CONFIG_CSM;

if (sdma->clk_ratio);
	reg |= SDMA_H_CONFIG_ACR;

> +
> > +		writel_relaxed(reg, sdma->regs + SDMA_H_CONFIG);
> > +	}
>  
> >  	return ret;
>  }
> @@ -1840,6 +1848,11 @@ static int sdma_init(struct sdma_engine *sdma)
> >  	if (ret)
> >  		goto disable_clk_ipg;
>  
> > +	if (clk_get_rate(sdma->clk_ahb) == clk_get_rate(sdma->clk_ipg))
> > +		sdma->clk_ratio = 1;
> > +	else
> +		sdma->clk_ratio = 0;

sdma is zeroed at allocation, so the else path here isn't necessary.

> +
> >  	/* Be sure SDMA has not started yet */
> >  	writel_relaxed(0, sdma->regs + SDMA_H_C0PTR);
>  
> @@ -1880,8 +1893,10 @@ static int sdma_init(struct sdma_engine *sdma)
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
