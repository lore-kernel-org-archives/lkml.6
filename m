Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A11C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE5E721855
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 09:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbfAYJez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 04:34:55 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:56965 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbfAYJey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 04:34:54 -0500
Received: from kresse.hi.pengutronix.de ([2001:67c:670:100:1d::2a])
        by metis.ext.pengutronix.de with esmtp (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1gmxst-0001Sj-1b; Fri, 25 Jan 2019 10:34:47 +0100
Message-ID: <1548408884.28802.33.camel@pengutronix.de>
Subject: Re: [PATCH v4 4/5] dma: imx-sdma: add a test for imx8mq multi sdma
 devices
From:   Lucas Stach <l.stach@pengutronix.de>
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     angus.ainslie@puri.sm, Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Daniel Baluta <daniel.baluta@gmail.com>
Date:   Fri, 25 Jan 2019 10:34:44 +0100
In-Reply-To: <20190125025528.15645-5-angus@akkea.ca>
References: <20190120023150.17138-1-angus@akkea.ca>
         <20190125025528.15645-1-angus@akkea.ca>
         <20190125025528.15645-5-angus@akkea.ca>
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

Am Donnerstag, den 24.01.2019, 19:55 -0700 schrieb Angus Ainslie (Purism):
> On i.mx8mq, there are two sdma instances, and the common dma framework
> will get a channel dynamically from any available sdma instance whether
> it's the first sdma device or the second sdma device. Some IPs like
> SAI only work with sdma2 not sdma1. To make sure the sdma channel is from
> the correct sdma device, use the phandle to match.
> 
> > Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>
> ---
>  drivers/dma/imx-sdma.c                | 8 ++++++++
>  include/linux/platform_data/dma-imx.h | 1 +
>  2 files changed, 9 insertions(+)
> 
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index ec6fb48f387a..88e112a4aabf 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -1927,11 +1927,17 @@ static int sdma_init(struct sdma_engine *sdma)
>  static bool sdma_filter_fn(struct dma_chan *chan, void *fn_param)
>  {
> >  	struct sdma_channel *sdmac = to_sdma_chan(chan);
> > +	struct sdma_engine *sdma = sdmac->sdma;
> >  	struct imx_dma_data *data = fn_param;
>  
> >  	if (!imx_dma_is_general_purpose(chan))
> >  		return false;
>  
> > +	/* return false if it's not the right device */
> +	if ((sdmac->sdma->drvdata == &sdma_imx8mq)

Why do this check only on i.MX8M? This is completely generic and can
and should be done for every SDMA engine with a OF node.

Also why use the phandle to match this instead of the of_node pointer
directly?

Regards,
Lucas

> +		&& (sdma->dev->of_node->phandle != data->phandle))
> > +		return false;
> +
> >  	sdmac->data = *data;
> >  	chan->private = &sdmac->data;
>  
> @@ -1942,6 +1948,7 @@ static struct dma_chan *sdma_xlate(struct of_phandle_args *dma_spec,
> >  				   struct of_dma *ofdma)
>  {
> >  	struct sdma_engine *sdma = ofdma->of_dma_data;
> > +	struct device_node *np = ofdma->of_node;
> >  	dma_cap_mask_t mask = sdma->dma_device.cap_mask;
> >  	struct imx_dma_data data;
>  
> @@ -1959,6 +1966,7 @@ static struct dma_chan *sdma_xlate(struct of_phandle_args *dma_spec,
> >  	 * be set to sdmac->event_id1.
> >  	 */
> >  	data.dma_request2 = 0;
> > +	data.phandle = np->phandle;
>  
> >  	return dma_request_channel(mask, sdma_filter_fn, &data);
>  }
> diff --git a/include/linux/platform_data/dma-imx.h b/include/linux/platform_data/dma-imx.h
> index 7d964e787299..eeb5b73ae542 100644
> --- a/include/linux/platform_data/dma-imx.h
> +++ b/include/linux/platform_data/dma-imx.h
> @@ -55,6 +55,7 @@ struct imx_dma_data {
> >  	int dma_request2; /* secondary DMA request line */
> >  	enum sdma_peripheral_type peripheral_type;
> >  	int priority;
> > +	int phandle;
>  };
>  
>  static inline int imx_dma_is_ipu(struct dma_chan *chan)
