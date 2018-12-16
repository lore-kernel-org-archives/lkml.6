Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECBCFC43612
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 11:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF3F6217FB
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 11:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544958631;
	bh=peP0ySD2rux8PRNQ+MptN+pEnOstnOnZT07tn9NK5RQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ubJ8H2cmvFPhuXpptauLkWsRM86xVTe5TuA8Fm9aZIcltj8zQfoo3K4lZVxPAJsA5
	 Y5Z7QWM7wh+JCaCxnP18Yk/dfFDOLnrmDhv7Qku3DWWjkF+Od/4KUhcpPpvYfRQdjY
	 yRVhNSQFWxrA+qo4Dw5DD3YDifIlPrEtCfxacl4k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730236AbeLPLKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 06:10:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:38766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729821AbeLPLKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 06:10:30 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F4B4217FB;
        Sun, 16 Dec 2018 11:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544958630;
        bh=peP0ySD2rux8PRNQ+MptN+pEnOstnOnZT07tn9NK5RQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2YYkIx1nmxSnVuiOMRZM/1Gp5Rm2rPSzREbNZFSa8//gpm5arDMyzu4yz3Eg5NL0S
         5vvJ/LAKFsaqDXW3XS6WYPee5dPYpgy1uXumwmN6+IUG4s6RTdITGYaCH4zunYPsHa
         GH/5hh3vrbI9qLktuDbjkMSvi6lGrgQIBrSFZakg=
Date:   Sun, 16 Dec 2018 11:10:25 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>
Subject: Re: [PATCH v2 4/4] iio: ti-ads8688: Migrate to device managed IIO
 calls
Message-ID: <20181216111025.0be9cb9e@archlinux>
In-Reply-To: <20181211191207.21900-4-dmurphy@ti.com>
References: <20181211191207.21900-1-dmurphy@ti.com>
        <20181211191207.21900-4-dmurphy@ti.com>
X-Mailer: Claws Mail 3.17.2 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Dec 2018 13:12:07 -0600
Dan Murphy <dmurphy@ti.com> wrote:

> Migrate the driver to use the devm IIO calls as opposed to
> the unmanaged calls.
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
The remove order should always be the opposite of probe.
As devm cleanup is done 'after' whatever is in the remove function
you should never mix and match between managed and unmanaged.

That's not to say this can't be done, but it should also handle
the regulator disables.  For that
devm_add_action_or_reset is what you want.  As you need to check
the regulator is not an error, you would need a little utility function.

Jonathan
> ---
> 
> v2 - New patch
> 
>  drivers/iio/adc/ti-ads8688.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads8688.c b/drivers/iio/adc/ti-ads8688.c
> index 3597bc0697ee..8f42103a1fd9 100644
> --- a/drivers/iio/adc/ti-ads8688.c
> +++ b/drivers/iio/adc/ti-ads8688.c
> @@ -462,21 +462,21 @@ static int ads8688_probe(struct spi_device *spi)
>  
>  	mutex_init(&st->lock);
>  
> -	ret = iio_triggered_buffer_setup(indio_dev, NULL, ads8688_trigger_handler, NULL);
> +	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev, NULL,
> +					      ads8688_trigger_handler, NULL);
>  	if (ret < 0) {
>  		dev_err(&spi->dev, "iio triggered buffer setup failed\n");
>  		goto err_regulator_disable;
>  	}
>  
> -	ret = iio_device_register(indio_dev);
> -	if (ret)
> -		goto err_buffer_cleanup;
> +	ret = devm_iio_device_register(&spi->dev, indio_dev);
> +	if (ret < 0) {
> +		dev_err(&spi->dev, "iio device registration failed\n");
> +		goto err_regulator_disable;
> +	}
>  
>  	return 0;
>  
> -err_buffer_cleanup:
> -	iio_triggered_buffer_cleanup(indio_dev);
> -
>  err_regulator_disable:
>  	if (!IS_ERR(st->reg))
>  		regulator_disable(st->reg);
> @@ -489,9 +489,6 @@ static int ads8688_remove(struct spi_device *spi)
>  	struct iio_dev *indio_dev = spi_get_drvdata(spi);
>  	struct ads8688_state *st = iio_priv(indio_dev);
>  
> -	iio_device_unregister(indio_dev);
> -	iio_triggered_buffer_cleanup(indio_dev);
> -
>  	if (!IS_ERR(st->reg))
>  		regulator_disable(st->reg);
>  

