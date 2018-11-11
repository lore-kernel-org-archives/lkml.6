Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9ED6C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 12:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CF5521104
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 12:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="X46B2jYH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CF5521104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbeKKWXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 17:23:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:55318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727510AbeKKWXg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 17:23:36 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7434A20866;
        Sun, 11 Nov 2018 12:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541939708;
        bh=S4dLL4SN0fS03qGxTOgFgky1fQXEx+GruS26JQFnCzA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=X46B2jYHuH4xwVuv9YnomTEDkcUFZEHAZ6JNpgajBMaauhpbxksK9gLk3Li6rC4K3
         lP8Zr4klAcwX7bApYCaFpvKZWKcBLezNl99xTFLqgi2dqdIrF72dBH2bMGlA62PaU3
         CdkeTQ1FuU4hC13UoP/+Wb1Gmcf0ywpl1DymZTfs=
Date:   Sun, 11 Nov 2018 12:35:03 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nishad Kamdar <nishadkamdar@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] staging: iio: ad7816: Do not use busy_pin in
 case of AD7818
Message-ID: <20181111123503.3a4acef2@archlinux>
In-Reply-To: <3f0bc36261c54c945a3213ef03425099e57e9060.1541733949.git.nishadkamdar@gmail.com>
References: <cover.1541733949.git.nishadkamdar@gmail.com>
        <3f0bc36261c54c945a3213ef03425099e57e9060.1541733949.git.nishadkamdar@gmail.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Nov 2018 13:06:24 +0530
Nishad Kamdar <nishadkamdar@gmail.com> wrote:

> AD7818 does not support busy_pin functionality as per datasheet.
> Hence drop busy_pin when AD7818 is used.
> 
> Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

A slight concern that I can't immediately find an answer to,
is whether we should be waiting a short while for the ad7818 given
we can't wait on the gpio?  We can add this in a follow up patch
if it is necessary.

Thanks,

Jonathan
> ---
>  drivers/staging/iio/adc/ad7816.c | 35 ++++++++++++++++++++++----------
>  1 file changed, 24 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
> index 12c4e0ab4713..3cda5cd09365 100644
> --- a/drivers/staging/iio/adc/ad7816.c
> +++ b/drivers/staging/iio/adc/ad7816.c
> @@ -43,6 +43,7 @@
>   */
>  
>  struct ad7816_chip_info {
> +	kernel_ulong_t id;
>  	struct spi_device *spi_dev;
>  	struct gpio_desc *rdwr_pin;
>  	struct gpio_desc *convert_pin;
> @@ -52,6 +53,12 @@ struct ad7816_chip_info {
>  	u8  mode;
>  };
>  
> +enum ad7816_type {
> +	ID_AD7816,
> +	ID_AD7817,
> +	ID_AD7818,
> +};
> +
>  /*
>   * ad7816 data access by SPI
>   */
> @@ -78,8 +85,10 @@ static int ad7816_spi_read(struct ad7816_chip_info *chip, u16 *data)
>  		gpiod_set_value(chip->convert_pin, 1);
>  	}
>  
> -	while (gpiod_get_value(chip->busy_pin))
> -		cpu_relax();
> +	if (chip->id == ID_AD7816 || chip->id == ID_AD7817) {
> +		while (gpiod_get_value(chip->busy_pin))
> +			cpu_relax();
> +	}
>  
>  	gpiod_set_value(chip->rdwr_pin, 0);
>  	gpiod_set_value(chip->rdwr_pin, 1);
> @@ -359,6 +368,7 @@ static int ad7816_probe(struct spi_device *spi_dev)
>  	for (i = 0; i <= AD7816_CS_MAX; i++)
>  		chip->oti_data[i] = 203;
>  
> +	chip->id = spi_get_device_id(spi_dev)->driver_data;
>  	chip->rdwr_pin = devm_gpiod_get(&spi_dev->dev, "rdwr", GPIOD_IN);
>  	if (IS_ERR(chip->rdwr_pin)) {
>  		ret = PTR_ERR(chip->rdwr_pin);
> @@ -373,12 +383,15 @@ static int ad7816_probe(struct spi_device *spi_dev)
>  			ret);
>  		return ret;
>  	}
> -	chip->busy_pin = devm_gpiod_get(&spi_dev->dev, "busy", GPIOD_IN);
> -	if (IS_ERR(chip->busy_pin)) {
> -		ret = PTR_ERR(chip->busy_pin);
> -		dev_err(&spi_dev->dev, "Failed to request busy GPIO: %d\n",
> -			ret);
> -		return ret;
> +	if (chip->id == ID_AD7816 || chip->id == ID_AD7817) {
> +		chip->busy_pin = devm_gpiod_get(&spi_dev->dev, "busy",
> +						GPIOD_IN);
> +		if (IS_ERR(chip->busy_pin)) {
> +			ret = PTR_ERR(chip->busy_pin);
> +			dev_err(&spi_dev->dev, "Failed to request busy GPIO: %d\n",
> +				ret);
> +			return ret;
> +		}
>  	}
>  
>  	indio_dev->name = spi_get_device_id(spi_dev)->name;
> @@ -409,9 +422,9 @@ static int ad7816_probe(struct spi_device *spi_dev)
>  }
>  
>  static const struct spi_device_id ad7816_id[] = {
> -	{ "ad7816", 0 },
> -	{ "ad7817", 0 },
> -	{ "ad7818", 0 },
> +	{ "ad7816", ID_AD7816 },
> +	{ "ad7817", ID_AD7817 },
> +	{ "ad7818", ID_AD7818 },
>  	{}
>  };
>  

