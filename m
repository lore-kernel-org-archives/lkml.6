Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2CF1C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 02:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CA9220843
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 02:10:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fbv3c7WI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CA9220843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbeIBGYh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 02:24:37 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:38667 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbeIBGYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 02:24:37 -0400
Received: by mail-oi0-f67.google.com with SMTP id x197-v6so28177856oix.5
        for <linux-kernel@vger.kernel.org>; Sat, 01 Sep 2018 19:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KbvrYNnUVsmHKIRzR7B3wBX4UTF3yKUXd9r3H5r1poA=;
        b=fbv3c7WIzO2p1qvpcJDs7yHj8rrewwqNafyb+rZnlhFYzEEw7g7gRYfIQuwGT8JUar
         Zi5hg8NQ7S7YCXt38rnNANrm9ms540SMdfUg6NU+zq5fFBiRaXL+Kok+R+Ik2cnei8qs
         +UY5GWA1LRaW2GWtoNPIX+GPs4vKnUc54/lw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KbvrYNnUVsmHKIRzR7B3wBX4UTF3yKUXd9r3H5r1poA=;
        b=ZvtE/7CkjM56U6JaVkorAW2ExqEzCVy5Te2H3W5klYB1DjTHoS2LD0Cv0w5ZX73iLb
         ZrsrIw6MVmj48lUny70jHSEQL/zwj9SjEIwttWE+NiYrL/DucWpYTE6fv4PfpM1QQrSV
         U2eS68Y6zgBOMJ6SZ2SGNoPRY8wA3NcN6upy4w+o4mkch7NNxmb/bds1oaJZSGS3n5s4
         1iVidz/R5jzxDWNtObNwa/GmcvvHewOVonEiv40TvW9yqZW0/lDpC8ct06XspDHrKWzz
         fyR9kxR5qyVoJj8JNqVa2VIyZSH/ZXD/x39/EW+VlhoRii+EyRmr8GMCA56JcEFjE9Xw
         vTww==
X-Gm-Message-State: APzg51AIm3tKa9GlxUKqka7re8QRLmrp/BZarQmCTUztYfkCgp44LgOr
        znALP/kTXm7rG3Lo0xJ59a1g5Q==
X-Google-Smtp-Source: ANB0VdaC3A4hpp0aJX9wB1UjiX016jDwbb9z/0HhreI8kGfCD1QXsAGok++JgJvWWXBtxDCDn+j/kA==
X-Received: by 2002:aca:d9c5:: with SMTP id q188-v6mr14490656oig.239.1535854237993;
        Sat, 01 Sep 2018 19:10:37 -0700 (PDT)
Received: from localhost (68-248-140-212.lightspeed.austtx.sbcglobal.net. [68.248.140.212])
        by smtp.gmail.com with ESMTPSA id k85-v6sm30577194oiy.2.2018.09.01.19.10.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 01 Sep 2018 19:10:37 -0700 (PDT)
Date:   Sat, 1 Sep 2018 21:10:36 -0500
From:   Brian Brooks <brian.brooks@linaro.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     David Miller <davem@davemloft.net>, antoine.tenart@bootlin.com,
        maxime.chevallier@bootlin.com, ymarkman@marvell.com,
        stefanc@marvell.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bjorn.topel@intel.com,
        brian.brooks@arm.com
Subject: Re: [PATCH] net: mvpp2: avoid bouncing buffers
Message-ID: <20180902021036.nyxcphdi3i5mgkjs@i7-8700>
References: <20180820024730.9147-1-brian.brooks@linaro.org>
 <20180819.195505.1988137313680465320.davem@davemloft.net>
 <20180820062326.GA22222@infradead.org>
 <20180827135524.fv4mxkwjn5bv7p5e@di3>
 <20180827154843.GA25821@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180827154843.GA25821@infradead.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/27 08:48:43, Christoph Hellwig wrote:
> WE should basically never have dev->dma_mask = &dev->coherent_dma_mask,
> so until that is the case you are doctoring around the symptoms and
> not the problem.
> 
> Does the patch below help your case?

Yes. Just tested it. Works great.

I see how this patch addresses the issue in the platform code instead of
the driver code. Thanks.

> ----
> From 6294e0e330851ee06e66ab85b348f1d92d375d7a Mon Sep 17 00:00:00 2001
> From: Christoph Hellwig <hch@lst.de>
> Date: Mon, 27 Aug 2018 17:23:24 +0200
> Subject: driver core: initialize a default DMA mask for platform device
> 
> We still treat devices without a DMA mask as defaulting to 32-bits for
> both mask, but a few releases ago we've started warning about such
> cases, as they require special cases to work around this sloppyness.
> Add a dma_mask field to struct platform_object so that we can initialize
> the dma_mask pointer in struct device and initialize both masks to
> 32-bits by default.  Architectures can still override this in
> arch_setup_pdev_archdata if needed.
> 
> Note that the code looks a little odd with the various conditionals
> because we have to support platform_device structures that are
> statically allocated.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/base/platform.c         | 15 +++++++++++++--
>  include/linux/platform_device.h |  1 +
>  2 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index dff82a3c2caa..baf4b06cf2d9 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -225,6 +225,17 @@ struct platform_object {
>  	char name[];
>  };
>  
> +static void setup_pdev_archdata(struct platform_device *pdev)
> +{
> +	if (!pdev->dev.coherent_dma_mask)
> +		pdev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
> +	if (!pdev->dma_mask)
> +		pdev->dma_mask = DMA_BIT_MASK(32);
> +	if (!pdev->dev.dma_mask)
> +		pdev->dev.dma_mask = &pdev->dma_mask;
> +	arch_setup_pdev_archdata(pdev);
> +};
> +
>  /**
>   * platform_device_put - destroy a platform device
>   * @pdev: platform device to free
> @@ -271,7 +282,7 @@ struct platform_device *platform_device_alloc(const char *name, int id)
>  		pa->pdev.id = id;
>  		device_initialize(&pa->pdev.dev);
>  		pa->pdev.dev.release = platform_device_release;
> -		arch_setup_pdev_archdata(&pa->pdev);
> +		setup_pdev_archdata(&pa->pdev);
>  	}
>  
>  	return pa ? &pa->pdev : NULL;
> @@ -472,7 +483,7 @@ EXPORT_SYMBOL_GPL(platform_device_del);
>  int platform_device_register(struct platform_device *pdev)
>  {
>  	device_initialize(&pdev->dev);
> -	arch_setup_pdev_archdata(pdev);
> +	setup_pdev_archdata(pdev);
>  	return platform_device_add(pdev);
>  }
>  EXPORT_SYMBOL_GPL(platform_device_register);
> diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
> index 1a9f38f27f65..d84ec1de6022 100644
> --- a/include/linux/platform_device.h
> +++ b/include/linux/platform_device.h
> @@ -25,6 +25,7 @@ struct platform_device {
>  	int		id;
>  	bool		id_auto;
>  	struct device	dev;
> +	dma_addr_t	dma_mask;

Hmm.. should struct device use dma_addr_t instead of u64 for masks too?

>  	u32		num_resources;
>  	struct resource	*resource;
>  
> -- 
> 2.18.0
> 
