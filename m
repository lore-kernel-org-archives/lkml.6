Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD58C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08E73208F7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hRVAKyqD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08E73208F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934057AbeGJPdh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 11:33:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:51642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754260AbeGJPdf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 11:33:35 -0400
Received: from localhost (unknown [106.200.232.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6618D208EB;
        Tue, 10 Jul 2018 15:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531236815;
        bh=uo4nkp/+GVkjqV4NlAFGWkZyTk73wKIALNb1IBVOG7o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hRVAKyqD75gPs4Tzr5LOajLlsRDbM35eSyz6HjVnnIW8S/GAKZnDbOyUkI60YaITs
         Ai/9ZXzWAxjjmDtR06TSrbvLCD1cMQU2ZCC5bu7Az6k7uyLEyBeld8EzbMEDwRiU9F
         Crx78HCq7PNkyW3oYc9Or0z3kxfkhOlhfsBAKJkg=
Date:   Tue, 10 Jul 2018 21:03:26 +0530
From:   Vinod <vkoul@kernel.org>
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     dan.j.williams@intel.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, fabio.estevam@nxp.com,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: Re: [PATCH v1 3/4] dmaengine: imx-sdma: support dmatest
Message-ID: <20180710153326.GG3219@vkoul-mobl>
References: <1531239793-11781-1-git-send-email-yibin.gong@nxp.com>
 <1531239793-11781-4-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531239793-11781-4-git-send-email-yibin.gong@nxp.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-07-18, 00:23, Robin Gong wrote:
> dmatest(memcpy) will never call dmaengine_slave_config before prep,

and that should have been a hint to you that you should not expect that

> so jobs in dmaengine_slave_config need to be moved into somewhere
> before device_prep_dma_memcpy. Besides, dmatest never setup chan
> ->private as other common case like uart/audio/spi will always setup
> chan->private. Here check it to judge if it's dmatest case and do
> jobs in slave_config.

and you should not do anything for dmatest. Supporting it means memcpy
implementation is not correct :)

> 
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> ---
>  drivers/dma/imx-sdma.c | 37 ++++++++++++++++++++++++++++---------
>  1 file changed, 28 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index ed2267d..48f3749 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -1222,10 +1222,36 @@ static int sdma_alloc_chan_resources(struct dma_chan *chan)
>  {
>  	struct sdma_channel *sdmac = to_sdma_chan(chan);
>  	struct imx_dma_data *data = chan->private;
> +	struct imx_dma_data default_data;
>  	int prio, ret;
>  
> -	if (!data)
> -		return -EINVAL;
> +	ret = clk_enable(sdmac->sdma->clk_ipg);
> +	if (ret)
> +		return ret;
> +	ret = clk_enable(sdmac->sdma->clk_ahb);
> +	if (ret)
> +		goto disable_clk_ipg;
> +	/*
> +	 * dmatest(memcpy) will never call dmaengine_slave_config before prep,
> +	 * so jobs in dmaengine_slave_config need to be moved into somewhere
> +	 * before device_prep_dma_memcpy. Besides, dmatest never setup chan
> +	 * ->private as other common cases like uart/audio/spi will setup
> +	 * chan->private always. Here check it to judge if it's dmatest case
> +	 * and do jobs in slave_config.
> +	 */
> +	if (!data) {
> +		dev_warn(sdmac->sdma->dev, "dmatest is running?\n");

why is that a warning!

> +		sdmac->word_size  =  sdmac->sdma->dma_device.copy_align;
> +		default_data.priority = 2;
> +		default_data.peripheral_type = IMX_DMATYPE_MEMORY;
> +		default_data.dma_request = 0;
> +		default_data.dma_request2 = 0;
> +		data = &default_data;
> +
> +		sdma_config_ownership(sdmac, false, true, false);
> +		sdma_get_pc(sdmac, IMX_DMATYPE_MEMORY);
> +		sdma_load_context(sdmac);
> +	}

this needs to be default for memcpy

-- 
~Vinod
