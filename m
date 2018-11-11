Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C75C7C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 11:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DDBF21479
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 11:42:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hNWVufNh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DDBF21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbeKKVav (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 16:30:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:53050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727440AbeKKVav (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 16:30:51 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5C7020866;
        Sun, 11 Nov 2018 11:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541936549;
        bh=Qhi5lM0wWSdIxP9N22IY1lgCBSP3vxV8I0DYd+In9cU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hNWVufNhNZI3dqyurHO589WIkZWRuX/oFAcVJeg0F55Y5830COOJToAvDUE7xfTeY
         emzgBBOse0vpbNKgepu7YNx6OaGwoVpto04EVYbrA4amYIQIwzD0Fo/oD3D+b9l7UV
         92xSE98sJ+QF/3DgueeZ3JLP8Tf17kXv6KU2O08Q=
Date:   Sun, 11 Nov 2018 11:42:24 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        kernel-usp@googlegroups.com, victorcolombo@gmail.com,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/6] staging:iio:ad2s90: Remove spi setup that should be
 done via dt
Message-ID: <20181111114224.1d8cfaec@archlinux>
In-Reply-To: <20181109220044.24843-3-matheus.bernardino@usp.br>
References: <20181109220044.24843-1-matheus.bernardino@usp.br>
        <20181109220044.24843-3-matheus.bernardino@usp.br>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  9 Nov 2018 20:00:40 -0200
Matheus Tavares <matheus.bernardino@usp.br> wrote:

> The ad2s90 driver currently sets some spi settings (max_speed_hz and
> mode) at ad2s90_probe. This should, instead, be handled via device tree.
> This patch removes these configurations from the probe function.
> 
> Note: The way in which the mentioned spi settings need to be specified
> on the ad2s90's node of a device tree will be documented in the future
> patch "dt-bindings:iio:resolver: Add docs for ad2s90".
> 
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
I'd actually like to get Rob and Mark's views on this one.  Previously
I would just have applied it without thinking on the basis these can
be easily specified from devicetree.

Recent discussions with Rob have suggested that the settings in devicetree
should perhaps be concerned with specifying constraints about the device
that are not visible to the driver.  The driver itself should apply
the device constraints, but there are others such as wiring that
might reduce the maximum frequency for example...

So should a driver be clamping an over specified value from DT for
example?  Or given that is optional in DT, should it be making sure
that a controller max frequency isn't too high for the sensor?

It seems to be unusual to do this, but to my mind it would make
sense and might be worth pushing out into more drivers.

Jonathan
> ---
>  drivers/staging/iio/resolver/ad2s90.c | 11 -----------
>  1 file changed, 11 deletions(-)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s90.c b/drivers/staging/iio/resolver/ad2s90.c
> index ff32ca76ca00..95c118c48400 100644
> --- a/drivers/staging/iio/resolver/ad2s90.c
> +++ b/drivers/staging/iio/resolver/ad2s90.c
> @@ -77,7 +77,6 @@ static int ad2s90_probe(struct spi_device *spi)
>  {
>  	struct iio_dev *indio_dev;
>  	struct ad2s90_state *st;
> -	int ret;
>  
>  	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
>  	if (!indio_dev)
> @@ -94,16 +93,6 @@ static int ad2s90_probe(struct spi_device *spi)
>  	indio_dev->num_channels = 1;
>  	indio_dev->name = spi_get_device_id(spi)->name;
>  
> -	/* need 600ns between CS and the first falling edge of SCLK */
> -	spi->max_speed_hz = 830000;
> -	spi->mode = SPI_MODE_3;
> -	ret = spi_setup(spi);
> -
> -	if (ret < 0) {
> -		dev_err(&spi->dev, "spi_setup failed!\n");
> -		return ret;
> -	}
> -
>  	return devm_iio_device_register(indio_dev->dev.parent, indio_dev);
>  }
>  

