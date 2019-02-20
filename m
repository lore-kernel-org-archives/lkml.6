Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 524F9C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2332720700
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550658907;
	bh=vt+bs0jGgN+TNYmkGGn67X+VGSCVyFvwi5P+MS2qe+o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TNspDDDNUxLxr2dxM6oylOHH/yxD+N4GBRq0ijuXag8r/xe2iixxBPOy2xFW0yrJ4
	 ICzzjLCbAG5Ujk/aiaQtHh9Qs7txXWJbglMRZQg7pm5MmAx+RQr6HZGV+AaC1WuTMD
	 /Yd0vQOiPiYa77jW5n6uFbcEOgKterkPhtsjGAvA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbfBTKfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 05:35:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:51462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727255AbfBTKfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 05:35:05 -0500
Received: from localhost (unknown [195.134.171.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6551620700;
        Wed, 20 Feb 2019 10:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550658905;
        bh=vt+bs0jGgN+TNYmkGGn67X+VGSCVyFvwi5P+MS2qe+o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ya0iK6btHnU61vgQj422x4sc1eTHOj1ma5u4vTh8ciCb2L143NwsHNKPaG7oODpLp
         +9RGFC42Mb0plQChskCZg1DIrjUDBl88Fj+YP4vfbFwLzJfkoGCynf3lNeSG6G1wed
         YLxFoKXG6f21PF32L1SAdvlfh1/p+W5/uz/rdjfc=
Date:   Wed, 20 Feb 2019 11:34:59 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Keerthy <j-keerthy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH 1/2] drivers: provide devm_platform_ioremap_resource()
Message-ID: <20190220103459.GA12108@kroah.com>
References: <20190215152507.31066-1-brgl@bgdev.pl>
 <20190215152507.31066-2-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190215152507.31066-2-brgl@bgdev.pl>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 04:25:06PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> There are currently 1200+ instances of using platform_get_resource()
> and devm_ioremap_resource() together in the kernel tree.
> 
> This patch wraps these two calls in a single helper. Thanks to that
> we don't have to declare a local variable for struct resource * and can
> omit the redundant argument for resource type. We also have one
> function call less.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  drivers/base/platform.c         | 18 ++++++++++++++++++
>  include/linux/platform_device.h |  3 +++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/drivers/base/platform.c b/drivers/base/platform.c
> index 1c958eb33ef4..14400a63cc81 100644
> --- a/drivers/base/platform.c
> +++ b/drivers/base/platform.c
> @@ -79,6 +79,24 @@ struct resource *platform_get_resource(struct platform_device *dev,
>  }
>  EXPORT_SYMBOL_GPL(platform_get_resource);
>  
> +/**
> + * devm_platform_ioremap_resource - call devm_ioremap_resource() for a platform
> + *				    device
> + *
> + * @pdev: platform device to use both for memory resource lookup as well as
> + *        resource managemend
> + * @index: resource index
> + */
> +void __iomem *devm_platform_ioremap_resource(struct platform_device *pdev,
> +					     unsigned int index)
> +{
> +	struct resource *res;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, index);
> +	return devm_ioremap_resource(&pdev->dev, res);
> +}
> +EXPORT_SYMBOL(devm_platform_ioremap_resource);

functions in drivers/base/* should be EXPORT_SYMBOL_GPL() please.

thanks,

greg k-h
