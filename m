Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A6B9C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 03:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6057E20868
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 03:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Czc6XUcR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbfAEDmG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 22:42:06 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:42689 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfAEDmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 22:42:06 -0500
Received: by mail-pl1-f195.google.com with SMTP id y1so18243265plp.9
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 19:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mZMn0J4v8Iit88sU/NK7W9dEUGvG2FSumIpsvCnlbn8=;
        b=Czc6XUcRC0gyMtafiZVPHhix4fTq7F5eFkD6kbbyKVxRnRUQGvRlAudru5PeDZxqAT
         X30sEgT6Wa5zAAHWB4OsmxvDsiWCNdZttdGAr4VTjMU1Ki12BNHe6zQyrq45GG+BeE4g
         BfSetn14vB9iNKLEjUhnsE72v8O6SpGeECL3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mZMn0J4v8Iit88sU/NK7W9dEUGvG2FSumIpsvCnlbn8=;
        b=boJgIyv1Mp5kGGZBGnzH0F7QeWi5xakw4xbjq/qQ5JV3qsRwC3mN+UJ0rzEMJFWilx
         oaJ6u428R9utIc42sFZMMggUoPXMzRfigeuPAgfqCvLbt9FNA4/c3sLdDxGX1WVbtscP
         HLKE9C/kSm03lJ019S92GSWp4zvpFSRCJqi3ZO0/5fc+pZHUq28odRdrD5Qz4xw8TvrP
         JYaVAI87AYReUWxPjKlguZYiYkGb7mHVvo7z1K5gtBz2+lm3V2yMA7OvyKLncR95563v
         aE6uJXwaWq0W350s5Blzqs4a7bmVwfNNijn+WFwne9yH0jLV/6tF5/8LPB1Qw4ovp+aq
         skgg==
X-Gm-Message-State: AJcUukcI9nEI7AaGq9qtph2uFFBgTg3N7z1KijkJp962bT8MWQ1j+5Re
        e48YTRJArL7NpnwF6+Ftdd5FWLYBnA==
X-Google-Smtp-Source: ALg8bN6dFPfu9zRgMJSQcCTV8ZicoS3zwnPCCW4ldGcTnauaTZ2FxYUf+Q3Q6bAEecQqpyjqhJr1kw==
X-Received: by 2002:a17:902:8ec9:: with SMTP id x9mr53741094plo.27.1546659725143;
        Fri, 04 Jan 2019 19:42:05 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2405:204:72cb:a88d:406c:3ac8:e78f:4779])
        by smtp.gmail.com with ESMTPSA id s190sm86803953pfb.103.2019.01.04.19.41.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Jan 2019 19:42:04 -0800 (PST)
Date:   Sat, 5 Jan 2019 09:11:57 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Youlin Wang <wwx575822@notesmail.huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Zhuangluan Su <suzhuangluan@hisilicon.com>,
        Ryan Grachek <ryan@edited.us>, dmaengine@vger.kernel.org,
        Tanglei Han <hantanglei@huawei.com>
Subject: Re: [PATCH 3/8 v2] dma: k3dma: Upgrade k3dma driver to support
 hisi_asp_dma hardware
Message-ID: <20190105034157.GB2477@Mani-XPS-13-9360>
References: <1546635388-13795-1-git-send-email-john.stultz@linaro.org>
 <1546635388-13795-4-git-send-email-john.stultz@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546635388-13795-4-git-send-email-john.stultz@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On Fri, Jan 04, 2019 at 12:56:23PM -0800, John Stultz wrote:
> From: Youlin Wang <wwx575822@notesmail.huawei.com>
> 
> There is an new "hisi-pcm-asp-dma-1.0" device added in
> "arch/arm64/boot/dts/hisilicon/hi3660.dtsi".
> So we have to add a matching id in the driver file:
>  .compatible = "hisilicon,hisi-pcm-asp-dma-1.0"
> 
> And also hisi-pcm-asp dma device needs no setting to the clock.
> So we skip this by adding and using soc data flags.
> 
> After above this driver will support both k3 and hisi_asp dma hardware.
> 

Small description about the hardware (ASP DMAC) would be really helpful.

Thanks,
Mani

> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Zhuangluan Su <suzhuangluan@hisilicon.com>
> Cc: Ryan Grachek <ryan@edited.us>
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Cc: dmaengine@vger.kernel.org
> Signed-off-by: Youlin Wang <wwx575822@notesmail.huawei.com>
> Signed-off-by: Tanglei Han <hantanglei@huawei.com>
> [jstultz: Reworked to use of_match_data]
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
> v2:
> * Reworked to use of_match_data
> ---
>  drivers/dma/k3dma.c | 37 ++++++++++++++++++++++++++++++++-----
>  1 file changed, 32 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/dma/k3dma.c b/drivers/dma/k3dma.c
> index fdec2b6..df61406 100644
> --- a/drivers/dma/k3dma.c
> +++ b/drivers/dma/k3dma.c
> @@ -116,6 +116,13 @@ struct k3_dma_dev {
>  	unsigned int		irq;
>  };
>  
> +
> +#define K3_FLAG_NOCLK  (1<<0)
> +struct k3dma_soc_data {
> +	unsigned long flags;
> +};
> +
> +
>  #define to_k3_dma(dmadev) container_of(dmadev, struct k3_dma_dev, slave)
>  
>  static int k3_dma_config_write(struct dma_chan *chan,
> @@ -790,8 +797,21 @@ static int k3_dma_transfer_resume(struct dma_chan *chan)
>  	return 0;
>  }
>  
> +static const struct k3dma_soc_data k3_v1_dma_data = {
> +	.flags = 0,
> +};
> +
> +static const struct k3dma_soc_data asp_v1_dma_data = {
> +	.flags = K3_FLAG_NOCLK,
> +};
> +
>  static const struct of_device_id k3_pdma_dt_ids[] = {
> -	{ .compatible = "hisilicon,k3-dma-1.0", },
> +	{ .compatible = "hisilicon,k3-dma-1.0",
> +	  .data = &k3_v1_dma_data
> +	},
> +	{ .compatible = "hisilicon,hisi-pcm-asp-dma-1.0",
> +	  .data = &asp_v1_dma_data
> +	},
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, k3_pdma_dt_ids);
> @@ -810,6 +830,7 @@ static struct dma_chan *k3_of_dma_simple_xlate(struct of_phandle_args *dma_spec,
>  
>  static int k3_dma_probe(struct platform_device *op)
>  {
> +	const struct k3dma_soc_data *soc_data;
>  	struct k3_dma_dev *d;
>  	const struct of_device_id *of_id;
>  	struct resource *iores;
> @@ -823,6 +844,10 @@ static int k3_dma_probe(struct platform_device *op)
>  	if (!d)
>  		return -ENOMEM;
>  
> +	soc_data = device_get_match_data(&op->dev);
> +	if (!soc_data)
> +		return -EINVAL;
> +
>  	d->base = devm_ioremap_resource(&op->dev, iores);
>  	if (IS_ERR(d->base))
>  		return PTR_ERR(d->base);
> @@ -835,10 +860,12 @@ static int k3_dma_probe(struct platform_device *op)
>  				"dma-requests", &d->dma_requests);
>  	}
>  
> -	d->clk = devm_clk_get(&op->dev, NULL);
> -	if (IS_ERR(d->clk)) {
> -		dev_err(&op->dev, "no dma clk\n");
> -		return PTR_ERR(d->clk);
> +	if (!(soc_data->flags & K3_FLAG_NOCLK)) {
> +		d->clk = devm_clk_get(&op->dev, NULL);
> +		if (IS_ERR(d->clk)) {
> +			dev_err(&op->dev, "no dma clk\n");
> +			return PTR_ERR(d->clk);
> +		}
>  	}
>  
>  	irq = platform_get_irq(op, 0);
> -- 
> 2.7.4
> 
