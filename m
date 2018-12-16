Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50D5EC43612
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 13:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FECC21839
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 13:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544967799;
	bh=7CP9V4sAOhh0X6cAyRN5kZZUV+Eg9NbeiMd6ILghFDw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=NPiqEQUScA8dn4MQOntYzOFp9hjzkG6r1b/42y7AFwHLODHV9e8BjrDWb0dN5uVd7
	 ZD9nV0KXSfwYfIHaTP/n+7SHifOK4ZYBUDt8yRjIw85CrJxsssCHdkWy2Rxxwu4zDK
	 usN/tE0bapkbTdLVoucMgOwrv4IOBxgQFa2xvxac=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730619AbeLPNnS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 08:43:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:55768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729910AbeLPNnS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 08:43:18 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8601E2086C;
        Sun, 16 Dec 2018 13:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544967796;
        bh=7CP9V4sAOhh0X6cAyRN5kZZUV+Eg9NbeiMd6ILghFDw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0NUzN/2GMtxd9HK50e6zFq8IX8EPrj4rz4TTMkoro2ojwbFLQobUI13g69Y4J7Dd1
         iz2eb2pXFhdABhdD9SmQtHlRmDoqFY5TR5UgKbKEfHm1dr67+5X3e68aX7x/Fev0Pk
         GDwR7n93QONx3WzHE2Y8ot5gYXqnWz7qhrekayvQ=
Date:   Sun, 16 Dec 2018 13:43:11 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <stefan.popa@analog.co>
Subject: Re: [PATCH 04/11] staging: iio: adc: ad7606: Use devm functions in
 probe
Message-ID: <20181216134311.32b2b0cc@archlinux>
In-Reply-To: <1544705183-13288-5-git-send-email-stefan.popa@analog.com>
References: <1544705183-13288-1-git-send-email-stefan.popa@analog.com>
        <1544705183-13288-5-git-send-email-stefan.popa@analog.com>
X-Mailer: Claws Mail 3.17.2 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Dec 2018 14:46:16 +0200
Stefan Popa <stefan.popa@analog.com> wrote:

> Switch to devm version of request_irq, iio_triggered_buffer_setup,
> iio_device_register. To avoid potential ordering issues in probe,
> devm_add_action_or_reset() is used for the regulator_disable(). This
> simplifies the code and decreases the chance of bugs.
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
Very nice.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/adc/ad7606.c     | 59 +++++++++++++-----------------------
>  drivers/staging/iio/adc/ad7606.h     |  1 -
>  drivers/staging/iio/adc/ad7606_par.c |  6 ----
>  drivers/staging/iio/adc/ad7606_spi.c |  6 ----
>  4 files changed, 21 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7606.c b/drivers/staging/iio/adc/ad7606.c
> index 4b1bc20..7191d51 100644
> --- a/drivers/staging/iio/adc/ad7606.c
> +++ b/drivers/staging/iio/adc/ad7606.c
> @@ -417,6 +417,13 @@ static const struct iio_info ad7606_info_range = {
>  	.attrs = &ad7606_attribute_group_range,
>  };
>  
> +static void ad7606_regulator_disable(void *data)
> +{
> +	struct ad7606_state *st = data;
> +
> +	regulator_disable(st->reg);
> +}
> +
>  int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
>  		 const char *name, unsigned int id,
>  		 const struct ad7606_bus_ops *bops)
> @@ -430,6 +437,7 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
>  		return -ENOMEM;
>  
>  	st = iio_priv(indio_dev);
> +	dev_set_drvdata(dev, indio_dev);
>  
>  	st->dev = dev;
>  	mutex_init(&st->lock);
> @@ -450,11 +458,15 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
>  		return ret;
>  	}
>  
> +	ret = devm_add_action_or_reset(dev, ad7606_regulator_disable, st);
> +	if (ret)
> +		return ret;
> +
>  	st->chip_info = &ad7606_chip_info_tbl[id];
>  
>  	ret = ad7606_request_gpios(st);
>  	if (ret)
> -		goto error_disable_reg;
> +		return ret;
>  
>  	indio_dev->dev.parent = dev;
>  	if (st->gpio_os) {
> @@ -479,50 +491,21 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
>  	if (ret)
>  		dev_warn(st->dev, "failed to RESET: no RESET GPIO specified\n");
>  
> -	ret = request_irq(irq, ad7606_interrupt, IRQF_TRIGGER_FALLING, name,
> -			  indio_dev);
> -	if (ret)
> -		goto error_disable_reg;
> -
> -	ret = iio_triggered_buffer_setup(indio_dev, &ad7606_trigger_handler,
> -					 NULL, NULL);
> +	ret = devm_request_irq(dev, irq, ad7606_interrupt, IRQF_TRIGGER_FALLING,
> +			       name, indio_dev);
>  	if (ret)
> -		goto error_free_irq;
> +		return ret;
>  
> -	ret = iio_device_register(indio_dev);
> +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
> +					      &ad7606_trigger_handler,
> +					      NULL, NULL);
>  	if (ret)
> -		goto error_unregister_ring;
> -
> -	dev_set_drvdata(dev, indio_dev);
> -
> -	return 0;
> -error_unregister_ring:
> -	iio_triggered_buffer_cleanup(indio_dev);
> -
> -error_free_irq:
> -	free_irq(irq, indio_dev);
> +		return ret;
>  
> -error_disable_reg:
> -	regulator_disable(st->reg);
> -	return ret;
> +	return devm_iio_device_register(dev, indio_dev);
>  }
>  EXPORT_SYMBOL_GPL(ad7606_probe);
>  
> -int ad7606_remove(struct device *dev, int irq)
> -{
> -	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> -	struct ad7606_state *st = iio_priv(indio_dev);
> -
> -	iio_device_unregister(indio_dev);
> -	iio_triggered_buffer_cleanup(indio_dev);
> -
> -	free_irq(irq, indio_dev);
> -	regulator_disable(st->reg);
> -
> -	return 0;
> -}
> -EXPORT_SYMBOL_GPL(ad7606_remove);
> -
>  #ifdef CONFIG_PM_SLEEP
>  
>  static int ad7606_suspend(struct device *dev)
> diff --git a/drivers/staging/iio/adc/ad7606.h b/drivers/staging/iio/adc/ad7606.h
> index cf20ca2..70486ef 100644
> --- a/drivers/staging/iio/adc/ad7606.h
> +++ b/drivers/staging/iio/adc/ad7606.h
> @@ -84,7 +84,6 @@ struct ad7606_bus_ops {
>  int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
>  		 const char *name, unsigned int id,
>  		 const struct ad7606_bus_ops *bops);
> -int ad7606_remove(struct device *dev, int irq);
>  
>  enum ad7606_supported_device_ids {
>  	ID_AD7605_4,
> diff --git a/drivers/staging/iio/adc/ad7606_par.c b/drivers/staging/iio/adc/ad7606_par.c
> index db2fede46..6269ee7 100644
> --- a/drivers/staging/iio/adc/ad7606_par.c
> +++ b/drivers/staging/iio/adc/ad7606_par.c
> @@ -71,11 +71,6 @@ static int ad7606_par_probe(struct platform_device *pdev)
>  			    &ad7606_par8_bops);
>  }
>  
> -static int ad7606_par_remove(struct platform_device *pdev)
> -{
> -	return ad7606_remove(&pdev->dev, platform_get_irq(pdev, 0));
> -}
> -
>  static const struct platform_device_id ad7606_driver_ids[] = {
>  	{
>  		.name		= "ad7605-4",
> @@ -97,7 +92,6 @@ MODULE_DEVICE_TABLE(platform, ad7606_driver_ids);
>  
>  static struct platform_driver ad7606_driver = {
>  	.probe = ad7606_par_probe,
> -	.remove	= ad7606_par_remove,
>  	.id_table = ad7606_driver_ids,
>  	.driver = {
>  		.name	 = "ad7606",
> diff --git a/drivers/staging/iio/adc/ad7606_spi.c b/drivers/staging/iio/adc/ad7606_spi.c
> index b6553ce..9291598 100644
> --- a/drivers/staging/iio/adc/ad7606_spi.c
> +++ b/drivers/staging/iio/adc/ad7606_spi.c
> @@ -48,11 +48,6 @@ static int ad7606_spi_probe(struct spi_device *spi)
>  			    &ad7606_spi_bops);
>  }
>  
> -static int ad7606_spi_remove(struct spi_device *spi)
> -{
> -	return ad7606_remove(&spi->dev, spi->irq);
> -}
> -
>  static const struct spi_device_id ad7606_id[] = {
>  	{"ad7605-4", ID_AD7605_4},
>  	{"ad7606-8", ID_AD7606_8},
> @@ -68,7 +63,6 @@ static struct spi_driver ad7606_driver = {
>  		.pm = AD7606_PM_OPS,
>  	},
>  	.probe = ad7606_spi_probe,
> -	.remove = ad7606_spi_remove,
>  	.id_table = ad7606_id,
>  };
>  module_spi_driver(ad7606_driver);

