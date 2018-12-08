Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F03EC64EB1
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 15:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 091282083D
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 15:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544283004;
	bh=2hkfujxVfdOfzKnNKIaqz8e01A+D0HMekUzkboHFT0M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=nf/O3AHhYQNR1OXov8ELLw6YxupIs9TM31qTUXb9xWOIWH6qbAu83Qz70N13hMRbb
	 6MtlKKsTgyIRz1J9RUfJh7T6t8qEh+H2nJJG8Yds0dL+RQS/3BA6HZThJWmafQDV1m
	 1FX1/vxaYXPCeoq648GHyxlPhDdSkwcsF+DUbyOc=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 091282083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbeLHPaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 10:30:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:36648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbeLHPaA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 10:30:00 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54047208E7;
        Sat,  8 Dec 2018 15:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544282999;
        bh=2hkfujxVfdOfzKnNKIaqz8e01A+D0HMekUzkboHFT0M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OCjxr2T7wE+NxWoX2GaeXZfaLYO6egbZUKGs9XoEFiPL+DauyRhuBfA303DmDaRdK
         LPsEduC4yRecIC9rKuGUKV8G4FqQCXy+cKLwoszLV7hH21ult/WnxM11cYDRtiCpr5
         +UIScHAM17WPUF0hRTuMk4OaRCczaaq3QercDQmA=
Date:   Sat, 8 Dec 2018 15:29:54 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mircea Caprioru <mircea.caprioru@analog.com>
Cc:     <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        Rob Herring <robh+dt@kernel.org>, linux-clk@vger.kernel.org
Subject: Re: [PATCH 1/2] staging: iio: adc: ad7192: Add clock for external
 clock reference
Message-ID: <20181208152954.596529f8@archlinux>
In-Reply-To: <20181206091052.7644-1-mircea.caprioru@analog.com>
References: <20181206091052.7644-1-mircea.caprioru@analog.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Dec 2018 11:10:51 +0200
Mircea Caprioru <mircea.caprioru@analog.com> wrote:

> This patch adds a clock to the state structure of ad7192 for getting the
> external clock frequency. This modifications is in accordance with clock
> framework dt bindings documentation.
> 
> Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>

+cc Rob and the clk list for advise on how to do the binding for this one.

It is basically 2 pins, you can put a clock in on one of them or connect
a crystal across them.  The driver has to set a register to say which is
the case.  

Current proposal is two optional clocks (fall back to internal oscillator)
but that doesn't seem to be commonly done, so I'm wondering if there
is a 'standard' way to handle this sort of thing.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/adc/ad7192.c | 74 +++++++++++++++++++++-----------
>  drivers/staging/iio/adc/ad7192.h |  2 -
>  2 files changed, 50 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
> index acdbc07fd259..8a4e6ede42b3 100644
> --- a/drivers/staging/iio/adc/ad7192.c
> +++ b/drivers/staging/iio/adc/ad7192.c
> @@ -6,6 +6,7 @@
>   * Licensed under the GPL-2.
>   */
>  
> +#include <linux/clk.h>
>  #include <linux/interrupt.h>
>  #include <linux/device.h>
>  #include <linux/kernel.h>
> @@ -156,8 +157,9 @@
>  struct ad7192_state {
>  	struct regulator		*avdd;
>  	struct regulator		*dvdd;
> +	struct clk			*mclk;
>  	u16				int_vref_mv;
> -	u32				mclk;
> +	u32				fclk;
>  	u32				f_order;
>  	u32				mode;
>  	u32				conf;
> @@ -165,6 +167,7 @@ struct ad7192_state {
>  	u8				gpocon;
>  	u8				devid;
>  	struct mutex			lock;	/* protect sensor state */
> +	u8				clock_sel;
>  
>  	struct ad_sigma_delta		sd;
>  };
> @@ -250,28 +253,8 @@ static int ad7192_setup(struct ad7192_state *st,
>  		dev_warn(&st->sd.spi->dev, "device ID query failed (0x%X)\n",
>  			 id);
>  
> -	switch (pdata->clock_source_sel) {
> -	case AD7192_CLK_INT:
> -	case AD7192_CLK_INT_CO:
> -		st->mclk = AD7192_INT_FREQ_MHZ;
> -		break;
> -	case AD7192_CLK_EXT_MCLK1_2:
> -	case AD7192_CLK_EXT_MCLK2:
> -		if (ad7192_valid_external_frequency(pdata->ext_clk_hz)) {
> -			st->mclk = pdata->ext_clk_hz;
> -			break;
> -		}
> -		dev_err(&st->sd.spi->dev, "Invalid frequency setting %u\n",
> -			pdata->ext_clk_hz);
> -		ret = -EINVAL;
> -		goto out;
> -	default:
> -		ret = -EINVAL;
> -		goto out;
> -	}
> -
>  	st->mode = AD7192_MODE_SEL(AD7192_MODE_IDLE) |
> -		AD7192_MODE_CLKSRC(pdata->clock_source_sel) |
> +		AD7192_MODE_CLKSRC(st->clock_sel) |
>  		AD7192_MODE_RATE(480);
>  
>  	st->conf = AD7192_CONF_GAIN(0);
> @@ -499,7 +482,7 @@ static int ad7192_read_raw(struct iio_dev *indio_dev,
>  			*val -= 273 * ad7192_get_temp_scale(unipolar);
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SAMP_FREQ:
> -		*val = st->mclk /
> +		*val = st->fclk /
>  			(st->f_order * 1024 * AD7192_MODE_RATE(st->mode));
>  		return IIO_VAL_INT;
>  	}
> @@ -546,7 +529,7 @@ static int ad7192_write_raw(struct iio_dev *indio_dev,
>  			break;
>  		}
>  
> -		div = st->mclk / (val * st->f_order * 1024);
> +		div = st->fclk / (val * st->f_order * 1024);
>  		if (div < 1 || div > 1023) {
>  			ret = -EINVAL;
>  			break;
> @@ -625,6 +608,42 @@ static const struct iio_chan_spec ad7193_channels[] = {
>  	IIO_CHAN_SOFT_TIMESTAMP(14),
>  };
>  
> +static int ad7192_clock_select(struct spi_device *spi, struct ad7192_state *st)
> +{
> +	int ret;
> +
> +	st->clock_sel = AD7192_CLK_EXT_MCLK2;
> +	st->mclk = devm_clk_get(&spi->dev, "clk");
> +	if (IS_ERR(st->mclk)) {
> +		if (PTR_ERR(st->mclk) != -ENOENT)
> +			return PTR_ERR(st->mclk);
> +
> +		/* try xtal option */
> +		st->mclk = devm_clk_get(&spi->dev, "xtal");

I'm not seeing any other driver using clock naming to distinguish
between different clock options. 

Which does raise the question of how to do this? 

I think it's probably going to be a single clock as both the external
clock and the crystal would be connected to the same pins.


> +		st->clock_sel = AD7192_CLK_EXT_MCLK1_2;
> +		if (IS_ERR(st->mclk)) {
> +			if (PTR_ERR(st->mclk) != -ENOENT)
> +				return PTR_ERR(st->mclk);
> +
> +			/* use internal clock */
> +			st->clock_sel = AD7192_CLK_INT;
> +			st->fclk = AD7192_INT_FREQ_MHZ;
> +		}
> +	}
> +	if (st->clock_sel == AD7192_CLK_EXT_MCLK2 ||
> +	    st->clock_sel == AD7192_CLK_EXT_MCLK1_2) {
> +		ret = clk_prepare_enable(st->mclk);
> +		if (ret < 0)
> +			return ret;
> +
> +		st->fclk = clk_get_rate(st->mclk);
> +		if (!ad7192_valid_external_frequency(st->fclk))
> +			return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  static int ad7192_probe(struct spi_device *spi)
>  {
>  	const struct ad7192_platform_data *pdata = dev_get_platdata(&spi->dev);
> @@ -672,6 +691,10 @@ static int ad7192_probe(struct spi_device *spi)
>  		goto error_disable_avdd;
>  	}
>  
> +	ret = ad7192_clock_select(spi, st);
> +	if (ret < 0)
> +		goto error_clk_disable_unprepare;
> +
>  	voltage_uv = regulator_get_voltage(st->avdd);
>  
>  	if (pdata->vref_mv)
> @@ -720,6 +743,8 @@ static int ad7192_probe(struct spi_device *spi)
>  
>  error_remove_trigger:
>  	ad_sd_cleanup_buffer_and_trigger(indio_dev);
> +error_clk_disable_unprepare:
> +	clk_disable_unprepare(st->mclk);
>  error_disable_dvdd:
>  	regulator_disable(st->dvdd);
>  error_disable_avdd:
> @@ -735,6 +760,7 @@ static int ad7192_remove(struct spi_device *spi)
>  
>  	iio_device_unregister(indio_dev);
>  	ad_sd_cleanup_buffer_and_trigger(indio_dev);
> +	clk_disable_unprepare(st->mclk);
>  
>  	regulator_disable(st->dvdd);
>  	regulator_disable(st->avdd);
> diff --git a/drivers/staging/iio/adc/ad7192.h b/drivers/staging/iio/adc/ad7192.h
> index 7433a43c2611..3be3ee269ed5 100644
> --- a/drivers/staging/iio/adc/ad7192.h
> +++ b/drivers/staging/iio/adc/ad7192.h
> @@ -33,8 +33,6 @@
>  
>  struct ad7192_platform_data {
>  	u16		vref_mv;
> -	u8		clock_source_sel;
> -	u32		ext_clk_hz;
>  	bool		refin2_en;
>  	bool		rej60_en;
>  	bool		sinc3_en;

