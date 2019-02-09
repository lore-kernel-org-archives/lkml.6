Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB0DC282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 15:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAAC921919
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 15:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549727568;
	bh=WLaB5j9fXDIXs7HAwPH/5lPuvZ9dAhX1k/iXjQuZtg0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=XhSHGAw2eEk3r+bhNQ/VDuPGKaWqpFWtRig0bqvOVF/Z2lYbJlfwB7HNw18ISe2uK
	 SxGOqLjv65tnNzhT99S0GkFisQjuIoXmpm6y8KlIDuqUI4558S9ni01l+JXGFUcuqJ
	 TeHkR+j9ce4aY1lxsGEfoT581E7zN0NM1XH9XMDU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfBIPwq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 10:52:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:50100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726741AbfBIPwq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 10:52:46 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37902217D8;
        Sat,  9 Feb 2019 15:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549727564;
        bh=WLaB5j9fXDIXs7HAwPH/5lPuvZ9dAhX1k/iXjQuZtg0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BBHSY5UGjZvIB1MqlIKnFA/TIyB3T4S457KZNyQ7IA9uUnmB4ijC0gVakenM5JbPp
         I8RqV2mnFLISTYE/4oyrvGFyIgDNUr+Eq9VoiRWL01e8WrUehZmIUa3yB7GBtQXUB5
         69MXcIWiDWpMFyNWn9M9excUNyrYtIgMWNfaNLW4=
Date:   Sat, 9 Feb 2019 15:52:39 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: ad7768-1: Add support for setting the
 sampling frequency
Message-ID: <20190209155239.3908b4fd@archlinux>
In-Reply-To: <1549276215-29570-1-git-send-email-stefan.popa@analog.com>
References: <1549276215-29570-1-git-send-email-stefan.popa@analog.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Feb 2019 12:30:15 +0200
Stefan Popa <stefan.popa@analog.com> wrote:

> The AD7768-1 core ADC receives a master clock signal (MCLK). The MCLK
> frequency combined with the MCLK division and the digital filter
> decimation rates, determines the sampling frequency. Along with
> MCLK_DIV, the power mode is also configured according to datasheet
> recommendations.
> 
> From user space, available sampling frequencies can be read. However,
> it is not required for an exact value to be entered, since the driver
> will look for the closest available match.
> 
> When the device configuration changes (for example, if the filter
> decimation rate changes), a SYNC_IN pulse is required.
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>

Interesting. The binding always required the clock, but the driver
wasn't using it.  Handy now as we 'should' have no bindings out there
that don't provide it.  Same with the sync in gpio.

Was a fairly narrow window for anyone to have written such a binding
even if this misses the merge window, but good forward thinking there :)
+ keeps Rob happy by being as complete as possible from the start.

Anyhow, looks good to me.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to poke it.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ad7768-1.c | 202 ++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 199 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> index 78449e9..0d13270 100644
> --- a/drivers/iio/adc/ad7768-1.c
> +++ b/drivers/iio/adc/ad7768-1.c
> @@ -9,6 +9,7 @@
>  #include <linux/delay.h>
>  #include <linux/device.h>
>  #include <linux/err.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/regulator/consumer.h>
> @@ -59,6 +60,18 @@
>  #define AD7768_REG_DIG_DIAG_STATUS	0x30
>  #define AD7768_REG_MCLK_COUNTER		0x31
>  
> +/* AD7768_REG_POWER_CLOCK */
> +#define AD7768_PWR_MCLK_DIV_MSK		GENMASK(5, 4)
> +#define AD7768_PWR_MCLK_DIV(x)		FIELD_PREP(AD7768_PWR_MCLK_DIV_MSK, x)
> +#define AD7768_PWR_PWRMODE_MSK		GENMASK(1, 0)
> +#define AD7768_PWR_PWRMODE(x)		FIELD_PREP(AD7768_PWR_PWRMODE_MSK, x)
> +
> +/* AD7768_REG_DIGITAL_FILTER */
> +#define AD7768_DIG_FIL_FIL_MSK		GENMASK(6, 4)
> +#define AD7768_DIG_FIL_FIL(x)		FIELD_PREP(AD7768_DIG_FIL_FIL_MSK, x)
> +#define AD7768_DIG_FIL_DEC_MSK		GENMASK(2, 0)
> +#define AD7768_DIG_FIL_DEC_RATE(x)	FIELD_PREP(AD7768_DIG_FIL_DEC_MSK, x)
> +
>  /* AD7768_REG_CONVERSION */
>  #define AD7768_CONV_MODE_MSK		GENMASK(2, 0)
>  #define AD7768_CONV_MODE(x)		FIELD_PREP(AD7768_CONV_MODE_MSK, x)
> @@ -80,11 +93,51 @@ enum ad7768_pwrmode {
>  	AD7768_FAST_MODE = 3
>  };
>  
> +enum ad7768_mclk_div {
> +	AD7768_MCLK_DIV_16,
> +	AD7768_MCLK_DIV_8,
> +	AD7768_MCLK_DIV_4,
> +	AD7768_MCLK_DIV_2
> +};
> +
> +enum ad7768_dec_rate {
> +	AD7768_DEC_RATE_32 = 0,
> +	AD7768_DEC_RATE_64 = 1,
> +	AD7768_DEC_RATE_128 = 2,
> +	AD7768_DEC_RATE_256 = 3,
> +	AD7768_DEC_RATE_512 = 4,
> +	AD7768_DEC_RATE_1024 = 5,
> +	AD7768_DEC_RATE_8 = 9,
> +	AD7768_DEC_RATE_16 = 10
> +};
> +
> +struct ad7768_clk_configuration {
> +	enum ad7768_mclk_div mclk_div;
> +	enum ad7768_dec_rate dec_rate;
> +	unsigned int clk_div;
> +	enum ad7768_pwrmode pwrmode;
> +};
> +
> +static const struct ad7768_clk_configuration ad7768_clk_config[] = {
> +	{ AD7768_MCLK_DIV_2, AD7768_DEC_RATE_8, 16,  AD7768_FAST_MODE },
> +	{ AD7768_MCLK_DIV_2, AD7768_DEC_RATE_16, 32,  AD7768_FAST_MODE },
> +	{ AD7768_MCLK_DIV_2, AD7768_DEC_RATE_32, 64, AD7768_FAST_MODE },
> +	{ AD7768_MCLK_DIV_2, AD7768_DEC_RATE_64, 128, AD7768_FAST_MODE },
> +	{ AD7768_MCLK_DIV_2, AD7768_DEC_RATE_128, 256, AD7768_FAST_MODE },
> +	{ AD7768_MCLK_DIV_4, AD7768_DEC_RATE_128, 512, AD7768_MED_MODE },
> +	{ AD7768_MCLK_DIV_4, AD7768_DEC_RATE_256, 1024, AD7768_MED_MODE },
> +	{ AD7768_MCLK_DIV_4, AD7768_DEC_RATE_512, 2048, AD7768_MED_MODE },
> +	{ AD7768_MCLK_DIV_4, AD7768_DEC_RATE_1024, 4096, AD7768_MED_MODE },
> +	{ AD7768_MCLK_DIV_8, AD7768_DEC_RATE_1024, 8192, AD7768_MED_MODE },
> +	{ AD7768_MCLK_DIV_16, AD7768_DEC_RATE_1024, 16384, AD7768_ECO_MODE },
> +};
> +
>  static const struct iio_chan_spec ad7768_channels[] = {
>  	{
>  		.type = IIO_VOLTAGE,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
>  		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
>  		.indexed = 1,
>  		.channel = 0,
>  		.scan_index = 0,
> @@ -102,8 +155,12 @@ struct ad7768_state {
>  	struct spi_device *spi;
>  	struct regulator *vref;
>  	struct mutex lock;
> +	struct clk *mclk;
> +	unsigned int mclk_freq;
> +	unsigned int samp_freq;
>  	struct completion completion;
>  	struct iio_trigger *trig;
> +	struct gpio_desc *gpio_sync_in;
>  	/*
>  	 * DMA (thus cache coherency maintenance) requires the
>  	 * transfer buffers to live in their own cache lines.
> @@ -210,6 +267,90 @@ static int ad7768_reg_access(struct iio_dev *indio_dev,
>  	return ret;
>  }
>  
> +static int ad7768_set_dig_fil(struct ad7768_state *st,
> +			      enum ad7768_dec_rate dec_rate)
> +{
> +	unsigned int mode;
> +	int ret;
> +
> +	if (dec_rate == AD7768_DEC_RATE_8 || dec_rate == AD7768_DEC_RATE_16)
> +		mode = AD7768_DIG_FIL_FIL(dec_rate);
> +	else
> +		mode = AD7768_DIG_FIL_DEC_RATE(dec_rate);
> +
> +	ret = ad7768_spi_reg_write(st, AD7768_REG_DIGITAL_FILTER, mode);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* A sync-in pulse is required every time the filter dec rate changes */
> +	gpiod_set_value(st->gpio_sync_in, 1);
> +	gpiod_set_value(st->gpio_sync_in, 0);
> +
> +	return 0;
> +}
> +
> +static int ad7768_set_freq(struct ad7768_state *st,
> +			   unsigned int freq)
> +{
> +	unsigned int diff_new, diff_old, pwr_mode, i, idx;
> +	int res, ret;
> +
> +	diff_old = U32_MAX;
> +	idx = 0;
> +
> +	res = DIV_ROUND_CLOSEST(st->mclk_freq, freq);
> +
> +	/* Find the closest match for the desired sampling frequency */
> +	for (i = 0; i < ARRAY_SIZE(ad7768_clk_config); i++) {
> +		diff_new = abs(res - ad7768_clk_config[i].clk_div);
> +		if (diff_new < diff_old) {
> +			diff_old = diff_new;
> +			idx = i;
> +		}
> +	}
> +
> +	/*
> +	 * Set both the mclk_div and pwrmode with a single write to the
> +	 * POWER_CLOCK register
> +	 */
> +	pwr_mode = AD7768_PWR_MCLK_DIV(ad7768_clk_config[idx].mclk_div) |
> +		   AD7768_PWR_PWRMODE(ad7768_clk_config[idx].pwrmode);
> +	ret = ad7768_spi_reg_write(st, AD7768_REG_POWER_CLOCK, pwr_mode);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =  ad7768_set_dig_fil(st, ad7768_clk_config[idx].dec_rate);
> +	if (ret < 0)
> +		return ret;
> +
> +	st->samp_freq = DIV_ROUND_CLOSEST(st->mclk_freq,
> +					  ad7768_clk_config[idx].clk_div);
> +
> +	return 0;
> +}
> +
> +static ssize_t ad7768_sampling_freq_avail(struct device *dev,
> +					  struct device_attribute *attr,
> +					  char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct ad7768_state *st = iio_priv(indio_dev);
> +	unsigned int freq;
> +	int i, len = 0;
> +
> +	for (i = 0; i < ARRAY_SIZE(ad7768_clk_config); i++) {
> +		freq = DIV_ROUND_CLOSEST(st->mclk_freq,
> +					 ad7768_clk_config[i].clk_div);
> +		len += scnprintf(buf + len, PAGE_SIZE - len, "%d ", freq);
> +	}
> +
> +	buf[len - 1] = '\n';
> +
> +	return len;
> +}
> +
> +static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(ad7768_sampling_freq_avail);
> +
>  static int ad7768_read_raw(struct iio_dev *indio_dev,
>  			   struct iio_chan_spec const *chan,
>  			   int *val, int *val2, long info)
> @@ -242,13 +383,43 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
>  		*val2 = chan->scan_type.realbits;
>  
>  		return IIO_VAL_FRACTIONAL_LOG2;
> +
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*val = st->samp_freq;
> +
> +		return IIO_VAL_INT;
>  	}
>  
>  	return -EINVAL;
>  }
>  
> +static int ad7768_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int val, int val2, long info)
> +{
> +	struct ad7768_state *st = iio_priv(indio_dev);
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		return ad7768_set_freq(st, val);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static struct attribute *ad7768_attributes[] = {
> +	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group ad7768_group = {
> +	.attrs = ad7768_attributes,
> +};
> +
>  static const struct iio_info ad7768_info = {
> +	.attrs = &ad7768_group,
>  	.read_raw = &ad7768_read_raw,
> +	.write_raw = &ad7768_write_raw,
>  	.debugfs_reg_access = &ad7768_reg_access,
>  };
>  
> @@ -270,9 +441,13 @@ static int ad7768_setup(struct ad7768_state *st)
>  	if (ret)
>  		return ret;
>  
> -	/* Set power mode to fast */
> -	return ad7768_spi_reg_write(st, AD7768_REG_POWER_CLOCK,
> -				    AD7768_FAST_MODE);
> +	st->gpio_sync_in = devm_gpiod_get(&st->spi->dev, "adi,sync-in",
> +					  GPIOD_OUT_LOW);
> +	if (IS_ERR(st->gpio_sync_in))
> +		return PTR_ERR(st->gpio_sync_in);
> +
> +	/* Set the default sampling frequency to 32000 kSPS */
> +	return ad7768_set_freq(st, 32000);
>  }
>  
>  static irqreturn_t ad7768_trigger_handler(int irq, void *p)
> @@ -356,6 +531,13 @@ static void ad7768_regulator_disable(void *data)
>  	regulator_disable(st->vref);
>  }
>  
> +static void ad7768_clk_disable(void *data)
> +{
> +	struct ad7768_state *st = data;
> +
> +	clk_disable_unprepare(st->mclk);
> +}
> +
>  static int ad7768_probe(struct spi_device *spi)
>  {
>  	struct ad7768_state *st;
> @@ -383,6 +565,20 @@ static int ad7768_probe(struct spi_device *spi)
>  	if (ret)
>  		return ret;
>  
> +	st->mclk = devm_clk_get(&spi->dev, "mclk");
> +	if (IS_ERR(st->mclk))
> +		return PTR_ERR(st->mclk);
> +
> +	ret = clk_prepare_enable(st->mclk);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = devm_add_action_or_reset(&spi->dev, ad7768_clk_disable, st);
> +	if (ret)
> +		return ret;
> +
> +	st->mclk_freq = clk_get_rate(st->mclk);
> +
>  	spi_set_drvdata(spi, indio_dev);
>  	mutex_init(&st->lock);
>  

