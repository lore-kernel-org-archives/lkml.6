Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5272C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D51620880
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:33:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbfA1Jdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 04:33:39 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:59289 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbfA1Jdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 04:33:38 -0500
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=localhost)
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <l.stach@pengutronix.de>)
        id 1go3IK-00083N-2i; Mon, 28 Jan 2019 10:33:32 +0100
Message-ID: <7a3c2f812b7529e23a0007c70949a02e86a4f4f2.camel@pengutronix.de>
Subject: Re: [PATCH v5 4/5] dmaengine: imx-sdma: add a test for imx8mq multi
 sdma devices
From:   Lucas Stach <l.stach@pengutronix.de>
To:     "Angus Ainslie (Purism)" <angus@akkea.ca>
Cc:     angus.ainslie@puri.sm, Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Daniel Baluta <daniel.baluta@gmail.com>
Date:   Mon, 28 Jan 2019 10:33:31 +0100
In-Reply-To: <20190128060840.31695-5-angus@akkea.ca>
References: <20190120023150.17138-1-angus@akkea.ca>
         <20190128060840.31695-1-angus@akkea.ca>
         <20190128060840.31695-5-angus@akkea.ca>
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
> On i.mx8mq, there are two sdma instances, and the common dma framework
> will get a channel dynamically from any available sdma instance whether
> it's the first sdma device or the second sdma device. Some IPs like
> SAI only work with sdma2 not sdma1. To make sure the sdma channel is from
> the correct sdma device, use the node pointer to match.
> 
> Signed-off-by: Angus Ainslie (Purism) <angus@akkea.ca>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  drivers/dma/imx-sdma.c                | 6 ++++++
>  include/linux/platform_data/dma-imx.h | 1 +
>  2 files changed, 7 insertions(+)
> 
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index c4db4fe6bcc9..d5f86becf59e 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -1918,11 +1918,16 @@ static int sdma_init(struct sdma_engine *sdma)
>  static bool sdma_filter_fn(struct dma_chan *chan, void *fn_param)
>  {
>  	struct sdma_channel *sdmac = to_sdma_chan(chan);
> +	struct sdma_engine *sdma = sdmac->sdma;
>  	struct imx_dma_data *data = fn_param;
>  
>  	if (!imx_dma_is_general_purpose(chan))
>  		return false;
>  
> +	/* return false if it's not the right device */
> +	if (sdma->dev->of_node != data->of_node)
> +		return false;
> +
>  	sdmac->data = *data;
>  	chan->private = &sdmac->data;
>  
> @@ -1950,6 +1955,7 @@ static struct dma_chan *sdma_xlate(struct of_phandle_args *dma_spec,
>  	 * be set to sdmac->event_id1.
>  	 */
>  	data.dma_request2 = 0;
> +	data.of_node = ofdma->of_node;
>  
>  	return dma_request_channel(mask, sdma_filter_fn, &data);
>  }
> diff --git a/include/linux/platform_data/dma-imx.h b/include/linux/platform_data/dma-imx.h
> index 7d964e787299..9daea8d42a10 100644
> --- a/include/linux/platform_data/dma-imx.h
> +++ b/include/linux/platform_data/dma-imx.h
> @@ -55,6 +55,7 @@ struct imx_dma_data {
>  	int dma_request2; /* secondary DMA request line */
>  	enum sdma_peripheral_type peripheral_type;
>  	int priority;
> +	struct device_node *of_node;
>  };
>  
>  static inline int imx_dma_is_ipu(struct dma_chan *chan)

