Return-Path: <SRS0=1exb=NO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D4DC0044C
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 12:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94A6420833
	for <linux-kernel@archiver.kernel.org>; Sat,  3 Nov 2018 12:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nd9QZXho"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94A6420833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbeKCV42 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 17:56:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:39958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727658AbeKCV42 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 17:56:28 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F6A12082D;
        Sat,  3 Nov 2018 12:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541249114;
        bh=/8AtL2qUxiFz+eal/GbiU3NOqgMyPioX2fYCspKZ02A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Nd9QZXhof2HbXYO+ilTxDz2oqDfuL4QfbjKg1Us5nc87y5quO2nF2lO1V+ql7EadD
         oRna5M1LnbQo7wTmwGngP56wVdtdqq6tsMcXLZ1e/4vz1SHddyZ1YsvJA3t1KQz1U8
         f9clgzxY1N3zxOy6ttF7FgoR08z/DsdVotZ9FZO4=
Date:   Sat, 3 Nov 2018 12:45:09 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nishad Kamdar <nishadkamdar@gmail.com>
Cc:     Slawomir Stepien <sst@poczta.fm>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/3] staging: iio: ad2s1210: Switch to the gpio
 descriptor interface
Message-ID: <20181103124509.102204a5@archlinux>
In-Reply-To: <1626698317a8f0b1caf5596374088f6d5b6141c9.1541000375.git.nishadkamdar@gmail.com>
References: <cover.1541000375.git.nishadkamdar@gmail.com>
        <1626698317a8f0b1caf5596374088f6d5b6141c9.1541000375.git.nishadkamdar@gmail.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Oct 2018 21:28:52 +0530
Nishad Kamdar <nishadkamdar@gmail.com> wrote:

> Use the gpiod interface instead of the deprecated old non-descriptor
> interface.
> 
> Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
It would have been less 'noisy' to do these in the reverse order (drop
the flag and support first, then do the gpiod conversion), but I suppose
it doesn't really matter.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/resolver/ad2s1210.c | 106 ++++++++++++++----------
>  drivers/staging/iio/resolver/ad2s1210.h |   3 -
>  2 files changed, 62 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
> index ac13b99bd9cb..82ac9847f6f4 100644
> --- a/drivers/staging/iio/resolver/ad2s1210.c
> +++ b/drivers/staging/iio/resolver/ad2s1210.c
> @@ -15,7 +15,7 @@
>  #include <linux/slab.h>
>  #include <linux/sysfs.h>
>  #include <linux/delay.h>
> -#include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/module.h>
>  
>  #include <linux/iio/iio.h>
> @@ -67,12 +67,42 @@ enum ad2s1210_mode {
>  	MOD_RESERVED,
>  };
>  
> +enum ad2s1210_gpios {
> +	AD2S1210_SAMPLE,
> +	AD2S1210_A0,
> +	AD2S1210_A1,
> +	AD2S1210_RES0,
> +	AD2S1210_RES1,
> +};
> +
> +struct ad2s1210_gpio {
> +	const char *name;
> +	unsigned long flags;
> +};
> +
> +static const struct ad2s1210_gpio gpios_in[] = {
> +	[AD2S1210_SAMPLE] = { .name = "adi,sample", .flags = GPIOD_IN },
> +	[AD2S1210_A0] = { .name = "adi,a0", .flags = GPIOD_IN },
> +	[AD2S1210_A1] = { .name = "adi,a1", .flags = GPIOD_IN },
> +	[AD2S1210_RES0] = { .name = "adi,res0", .flags = GPIOD_IN },
> +	[AD2S1210_RES1] = { .name = "adi,res1", .flags = GPIOD_IN },
> +};
> +
> +static const struct ad2s1210_gpio gpios_out[] = {
> +	[AD2S1210_SAMPLE] = { .name = "adi,sample", .flags = GPIOD_OUT_LOW },
> +	[AD2S1210_A0] = { .name = "adi,a0", .flags = GPIOD_OUT_LOW },
> +	[AD2S1210_A1] = { .name = "adi,a1", .flags = GPIOD_OUT_LOW },
> +	[AD2S1210_RES0] = { .name = "adi,res0", .flags = GPIOD_OUT_LOW },
> +	[AD2S1210_RES1] = { .name = "adi,res1", .flags = GPIOD_OUT_LOW },
> +};
> +
>  static const unsigned int ad2s1210_resolution_value[] = { 10, 12, 14, 16 };
>  
>  struct ad2s1210_state {
>  	const struct ad2s1210_platform_data *pdata;
>  	struct mutex lock;
>  	struct spi_device *sdev;
> +	struct gpio_desc *gpios[5];
>  	unsigned int fclkin;
>  	unsigned int fexcit;
>  	bool hysteresis;
> @@ -91,8 +121,8 @@ static const int ad2s1210_mode_vals[4][2] = {
>  static inline void ad2s1210_set_mode(enum ad2s1210_mode mode,
>  				     struct ad2s1210_state *st)
>  {
> -	gpio_set_value(st->pdata->a[0], ad2s1210_mode_vals[mode][0]);
> -	gpio_set_value(st->pdata->a[1], ad2s1210_mode_vals[mode][1]);
> +	gpiod_set_value(st->gpios[AD2S1210_A0], ad2s1210_mode_vals[mode][0]);
> +	gpiod_set_value(st->gpios[AD2S1210_A1], ad2s1210_mode_vals[mode][1]);
>  	st->mode = mode;
>  }
>  
> @@ -152,8 +182,8 @@ int ad2s1210_update_frequency_control_word(struct ad2s1210_state *st)
>  
>  static unsigned char ad2s1210_read_resolution_pin(struct ad2s1210_state *st)
>  {
> -	int resolution = (gpio_get_value(st->pdata->res[0]) << 1) |
> -			  gpio_get_value(st->pdata->res[1]);
> +	int resolution = (gpiod_get_value(st->gpios[AD2S1210_RES0]) << 1) |
> +			  gpiod_get_value(st->gpios[AD2S1210_RES1]);
>  
>  	return ad2s1210_resolution_value[resolution];
>  }
> @@ -164,10 +194,10 @@ static const int ad2s1210_res_pins[4][2] = {
>  
>  static inline void ad2s1210_set_resolution_pin(struct ad2s1210_state *st)
>  {
> -	gpio_set_value(st->pdata->res[0],
> -		       ad2s1210_res_pins[(st->resolution - 10) / 2][0]);
> -	gpio_set_value(st->pdata->res[1],
> -		       ad2s1210_res_pins[(st->resolution - 10) / 2][1]);
> +	gpiod_set_value(st->gpios[AD2S1210_RES0],
> +			ad2s1210_res_pins[(st->resolution - 10) / 2][0]);
> +	gpiod_set_value(st->gpios[AD2S1210_RES1],
> +			ad2s1210_res_pins[(st->resolution - 10) / 2][1]);
>  }
>  
>  static inline int ad2s1210_soft_reset(struct ad2s1210_state *st)
> @@ -401,15 +431,15 @@ static ssize_t ad2s1210_clear_fault(struct device *dev,
>  	int ret;
>  
>  	mutex_lock(&st->lock);
> -	gpio_set_value(st->pdata->sample, 0);
> +	gpiod_set_value(st->gpios[AD2S1210_SAMPLE], 0);
>  	/* delay (2 * tck + 20) nano seconds */
>  	udelay(1);
> -	gpio_set_value(st->pdata->sample, 1);
> +	gpiod_set_value(st->gpios[AD2S1210_SAMPLE], 1);
>  	ret = ad2s1210_config_read(st, AD2S1210_REG_FAULT);
>  	if (ret < 0)
>  		goto error_ret;
> -	gpio_set_value(st->pdata->sample, 0);
> -	gpio_set_value(st->pdata->sample, 1);
> +	gpiod_set_value(st->gpios[AD2S1210_SAMPLE], 0);
> +	gpiod_set_value(st->gpios[AD2S1210_SAMPLE], 1);
>  error_ret:
>  	mutex_unlock(&st->lock);
>  
> @@ -466,7 +496,7 @@ static int ad2s1210_read_raw(struct iio_dev *indio_dev,
>  	s16 vel;
>  
>  	mutex_lock(&st->lock);
> -	gpio_set_value(st->pdata->sample, 0);
> +	gpiod_set_value(st->gpios[AD2S1210_SAMPLE], 0);
>  	/* delay (6 * tck + 20) nano seconds */
>  	udelay(1);
>  
> @@ -512,7 +542,7 @@ static int ad2s1210_read_raw(struct iio_dev *indio_dev,
>  	}
>  
>  error_ret:
> -	gpio_set_value(st->pdata->sample, 1);
> +	gpiod_set_value(st->gpios[AD2S1210_SAMPLE], 1);
>  	/* delay (2 * tck + 20) nano seconds */
>  	udelay(1);
>  	mutex_unlock(&st->lock);
> @@ -630,30 +660,23 @@ static const struct iio_info ad2s1210_info = {
>  
>  static int ad2s1210_setup_gpios(struct ad2s1210_state *st)
>  {
> -	unsigned long flags = st->pdata->gpioin ? GPIOF_DIR_IN : GPIOF_DIR_OUT;
> -	struct gpio ad2s1210_gpios[] = {
> -		{ st->pdata->sample, GPIOF_DIR_IN, "sample" },
> -		{ st->pdata->a[0], flags, "a0" },
> -		{ st->pdata->a[1], flags, "a1" },
> -		{ st->pdata->res[0], flags, "res0" },
> -		{ st->pdata->res[0], flags, "res1" },
> -	};
> -
> -	return gpio_request_array(ad2s1210_gpios, ARRAY_SIZE(ad2s1210_gpios));
> -}
> -
> -static void ad2s1210_free_gpios(struct ad2s1210_state *st)
> -{
> -	unsigned long flags = st->pdata->gpioin ? GPIOF_DIR_IN : GPIOF_DIR_OUT;
> -	struct gpio ad2s1210_gpios[] = {
> -		{ st->pdata->sample, GPIOF_DIR_IN, "sample" },
> -		{ st->pdata->a[0], flags, "a0" },
> -		{ st->pdata->a[1], flags, "a1" },
> -		{ st->pdata->res[0], flags, "res0" },
> -		{ st->pdata->res[0], flags, "res1" },
> -	};
> +	struct ad2s1210_gpio *pin = st->pdata->gpioin ? &gpios_in[0] : &gpios_out[0];
> +	struct spi_device *spi = st->sdev;
> +	int i, ret;
> +
> +	for (i = 0; i < ARRAY_SIZE(gpios_in); i++) {
> +		st->gpios[i] = devm_gpiod_get(&spi->dev, pin[i].name,
> +					      pin[i].flags);
> +		if (IS_ERR(st->gpios[i])) {
> +			ret = PTR_ERR(st->gpios[i]);
> +			dev_err(&spi->dev,
> +				"ad2s1210: failed to request %s GPIO: %d\n",
> +				pin[i].name, ret);
> +			return ret;
> +		}
> +	}
>  
> -	gpio_free_array(ad2s1210_gpios, ARRAY_SIZE(ad2s1210_gpios));
> +	return 0;
>  }
>  
>  static int ad2s1210_probe(struct spi_device *spi)
> @@ -692,7 +715,7 @@ static int ad2s1210_probe(struct spi_device *spi)
>  
>  	ret = iio_device_register(indio_dev);
>  	if (ret)
> -		goto error_free_gpios;
> +		return ret;
>  
>  	st->fclkin = spi->max_speed_hz;
>  	spi->mode = SPI_MODE_3;
> @@ -700,10 +723,6 @@ static int ad2s1210_probe(struct spi_device *spi)
>  	ad2s1210_initial(st);
>  
>  	return 0;
> -
> -error_free_gpios:
> -	ad2s1210_free_gpios(st);
> -	return ret;
>  }
>  
>  static int ad2s1210_remove(struct spi_device *spi)
> @@ -711,7 +730,6 @@ static int ad2s1210_remove(struct spi_device *spi)
>  	struct iio_dev *indio_dev = spi_get_drvdata(spi);
>  
>  	iio_device_unregister(indio_dev);
> -	ad2s1210_free_gpios(iio_priv(indio_dev));
>  
>  	return 0;
>  }
> diff --git a/drivers/staging/iio/resolver/ad2s1210.h b/drivers/staging/iio/resolver/ad2s1210.h
> index e9b2147701fc..63d479b20a6c 100644
> --- a/drivers/staging/iio/resolver/ad2s1210.h
> +++ b/drivers/staging/iio/resolver/ad2s1210.h
> @@ -12,9 +12,6 @@
>  #define _AD2S1210_H
>  
>  struct ad2s1210_platform_data {
> -	unsigned int		sample;
> -	unsigned int		a[2];
> -	unsigned int		res[2];
>  	bool			gpioin;
>  };
>  #endif /* _AD2S1210_H */

