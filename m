Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F164DC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C820720880
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:29:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfA1J3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 04:29:18 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:58881 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbfA1J3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 04:29:18 -0500
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=localhost)
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1go3E6-0007PO-Ds; Mon, 28 Jan 2019 10:29:10 +0100
Message-ID: <3e5e2026e98a3e4ae74541c0e09e1ca4120209de.camel@pengutronix.de>
Subject: Re: [PATCH v5 1/5] dmaengine: imx-sdma: add clock ratio 1:1 check
From:   Lucas Stach <l.stach@pengutronix.de>
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     angus.ainslie@puri.sm, Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Daniel Baluta <daniel.baluta@gmail.com>
Date:   Mon, 28 Jan 2019 10:29:07 +0100
In-Reply-To: <20190128060840.31695-2-angus@akkea.ca>
References: <20190120023150.17138-1-angus@akkea.ca>
         <20190128060840.31695-1-angus@akkea.ca>
         <20190128060840.31695-2-angus@akkea.ca>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.4 (3.30.4-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sonntag, den 27.01.2019, 23:08 -0700 schrieb Angus Ainslie (Purism):
> On i.mx8 mscale B0 chip, AHB/SDMA clock ratio 2:1 can't be supportted,
> since SDMA clock ratio has to be increased to 250Mhz, AHB can't reach
> to 500Mhz, so use 1:1 instead.
> 
> Based on NXP commit MLK-16841-1 by Robin Gong <yibin.gong@nxp.com>
> 
> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  drivers/dma/imx-sdma.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index 0b3a67ff8e82..757fad2fbfae 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -440,6 +440,8 @@ struct sdma_engine {
>  	unsigned int			irq;
>  	dma_addr_t			bd0_phys;
>  	struct sdma_buffer_descriptor	*bd0;
> +	/* clock ratio for AHB:SDMA core. 1:1 is 1, 2:1 is 0*/
> +	bool				clk_ratio;
>  };
>  
>  static int sdma_config_write(struct dma_chan *chan,
> @@ -662,8 +664,11 @@ static int sdma_run_channel0(struct sdma_engine *sdma)
>  		dev_err(sdma->dev, "Timeout waiting for CH0 ready\n");
>  
>  	/* Set bits of CONFIG register with dynamic context switching */
> -	if (readl(sdma->regs + SDMA_H_CONFIG) == 0)
> -		writel_relaxed(SDMA_H_CONFIG_CSM, sdma->regs + SDMA_H_CONFIG);
> +	reg = readl(sdma->regs + SDMA_H_CONFIG);
> +	if ((reg & SDMA_H_CONFIG_CSM) == 0) {
> +		reg |= SDMA_H_CONFIG_CSM;
> +		writel_relaxed(reg, sdma->regs + SDMA_H_CONFIG);
> +	}
>  
>  	return ret;
>  }
> @@ -1840,6 +1845,9 @@ static int sdma_init(struct sdma_engine *sdma)
>  	if (ret)
>  		goto disable_clk_ipg;
>  
> +	if (clk_get_rate(sdma->clk_ahb) == clk_get_rate(sdma->clk_ipg))
> +		sdma->clk_ratio = 1;
> +
>  	/* Be sure SDMA has not started yet */
>  	writel_relaxed(0, sdma->regs + SDMA_H_C0PTR);
>  
> @@ -1880,8 +1888,10 @@ static int sdma_init(struct sdma_engine *sdma)
>  	writel_relaxed(0x4050, sdma->regs + SDMA_CHN0ADDR);
>  
>  	/* Set bits of CONFIG register but with static context switching */
> -	/* FIXME: Check whether to set ACR bit depending on clock ratios */
> -	writel_relaxed(0, sdma->regs + SDMA_H_CONFIG);
> +	if (sdma->clk_ratio)
> +		writel_relaxed(SDMA_H_CONFIG_ACR, sdma->regs + SDMA_H_CONFIG);
> +	else
> +		writel_relaxed(0, sdma->regs + SDMA_H_CONFIG);
>  
>  	writel_relaxed(ccb_phys, sdma->regs + SDMA_H_C0PTR);
>  

