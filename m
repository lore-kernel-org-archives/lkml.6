Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21233C282D7
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 19:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBDA32083B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 19:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=pmeerw.net header.i=@pmeerw.net header.b="YZAu6YUR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730164AbfBET6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 14:58:12 -0500
Received: from ns.pmeerw.net ([84.19.176.117]:54364 "EHLO ns.pmeerw.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727572AbfBET6M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 14:58:12 -0500
Received: by ns.pmeerw.net (Postfix, from userid 1000)
        id F3CD3E0193; Tue,  5 Feb 2019 20:58:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=pmeerw.net; s=mail;
        t=1549396689; bh=rbdJB5Xn1hjPVzCi1/CVY1++o7hBicZjSeQqmuA+GTM=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=YZAu6YURC5clWlsQYpT5oi3WVaratIu3MOyKP+Osog2BZGWBoJbxBxp4O6pSaUU8M
         MFBDMnxxYCS/wCg4QxQ6d/5a7LmUBbnbYCPtIfAjWps97VCzOwLlm3esSrm+NdrpBP
         ZKy5uOC6Rthr71Q4nZdC04svjLRlZOQCenRqq7jM=
Received: from localhost (localhost [127.0.0.1])
        by ns.pmeerw.net (Postfix) with ESMTP id CD4EBE0157;
        Tue,  5 Feb 2019 20:58:09 +0100 (CET)
Date:   Tue, 5 Feb 2019 20:58:09 +0100 (CET)
From:   Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To:     Renato Lui Geh <renatogeh@gmail.com>
cc:     lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        stefan.popa@analog.com, alexandru.Ardelean@analog.com,
        giuliano.belinassi@usp.br, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Subject: Re: [PATCH v3 1/4] staging: iio: ad7780: add gain & filter gpio
 support
In-Reply-To: <786543cbd8d60776083bcaca66f83502f23f561b.1549385784.git.renatogeh@gmail.com>
Message-ID: <alpine.DEB.2.21.1902052054330.1726@vps.pmeerw.net>
References: <cover.1549385784.git.renatogeh@gmail.com> <786543cbd8d60776083bcaca66f83502f23f561b.1549385784.git.renatogeh@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Feb 2019, Renato Lui Geh wrote:

> Previously, the AD7780 driver only supported gpio for the 'powerdown'
> pin. This commit adds suppport for the 'gain' and 'filter' pin.

comments below
 
> Signed-off-by: Renato Lui Geh <renatogeh@gmail.com>
> Signed-off-by: Giuliano Belinassi <giuliano.belinassi@usp.br>
> Co-developed-by: Giuliano Belinassi <giuliano.belinassi@usp.br>
> ---
> Changes in v3:
> 	- Renamed ad7780_chip_info's filter to odr
> 	- Renamed ad778x_filter to ad778x_odr_avail
> 	- Changed vref variable from unsigned int to unsigned long long to
> 	  avoid overflow
> 	- Removed unnecessary AD_SD_CHANNEL macro
> 
> drivers/staging/iio/adc/ad7780.c | 95 ++++++++++++++++++++++++++++++--
> 1 file changed, 89 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7780.c
> b/drivers/staging/iio/adc/ad7780.c
> index c4a85789c2db..6e4357800d31 100644
> --- a/drivers/staging/iio/adc/ad7780.c
> +++ b/drivers/staging/iio/adc/ad7780.c
> @@ -39,6 +39,15 @@
> #define AD7170_PATTERN		(AD7780_PAT0 | AD7170_PAT2)
> #define AD7170_PATTERN_MASK	(AD7780_PAT0 | AD7780_PAT1 | AD7170_PAT2)
> 
> +#define AD7780_GAIN_GPIO	0
> +#define AD7780_FILTER_GPIO	1
> +
> +#define AD7780_GAIN_MIDPOINT	64
> +#define AD7780_FILTER_MIDPOINT	13350
> +
> +static const unsigned int ad778x_gain[2]      = { 1, 128 };
> +static const unsigned int ad778x_odr_avail[2] = { 10000, 16700 };
> +
> struct ad7780_chip_info {
> 	struct iio_chan_spec	channel;
> 	unsigned int		pattern_mask;
> @@ -50,7 +59,11 @@ struct ad7780_state {
> 	const struct ad7780_chip_info	*chip_info;
> 	struct regulator		*reg;
> 	struct gpio_desc		*powerdown_gpio;
> -	unsigned int	gain;
> +	struct gpio_desc		*gain_gpio;
> +	struct gpio_desc		*filter_gpio;
> +	unsigned int			gain;
> +	unsigned int			odr;
> +	unsigned int			int_vref_mv;
> 
> 	struct ad_sigma_delta sd;
> };
> @@ -104,17 +117,65 @@ static int ad7780_read_raw(struct iio_dev *indio_dev,
> 		voltage_uv = regulator_get_voltage(st->reg);
> 		if (voltage_uv < 0)
> 			return voltage_uv;
> -		*val = (voltage_uv / 1000) * st->gain;
> +		voltage_uv /= 1000;
> +		*val = voltage_uv * st->gain;
> 		*val2 = chan->scan_type.realbits - 1;
> +		st->int_vref_mv = voltage_uv;
> 		return IIO_VAL_FRACTIONAL_LOG2;
> 	case IIO_CHAN_INFO_OFFSET:
> 		*val = -(1 << (chan->scan_type.realbits - 1));
> 		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SAMP_FREQ:

was this missing before?
this is not covered by the patch description and seems unrelated
needs to be added to the channel spec?

> +		*val = st->odr;
> +		return IIO_VAL_INT;
> 	}
> 
> 	return -EINVAL;
> }
> 
> +static int ad7780_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int val,
> +			    int val2,
> +			    long m)
> +{
> +	struct ad7780_state *st = iio_priv(indio_dev);
> +	const struct ad7780_chip_info *chip_info = st->chip_info;
> +	unsigned long long vref;
> +	unsigned int full_scale, gain;
> +
> +	if (!chip_info->is_ad778x)
> +		return 0;
> +
> +	switch (m) {
> +	case IIO_CHAN_INFO_SCALE:
> +		if (val != 0)
> +			return -EINVAL;
> +
> +		vref = st->int_vref_mv * 1000000LL;
> +		full_scale = 1 << (chip_info->channel.scan_type.realbits - 1);
> +		gain = DIV_ROUND_CLOSEST(vref, full_scale);
> +		gain = DIV_ROUND_CLOSEST(gain, val2);
> +		st->gain = gain;
> +		if (gain < AD7780_GAIN_MIDPOINT)
> +			gain = 0;
> +		else
> +			gain = 1;
> +		gpiod_set_value(st->gain_gpio, gain);
> +	break;

indentation with the other, previous statements

> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		if (1000*val + val2/1000 < AD7780_FILTER_MIDPOINT)

space around operators missing

> +			val = 0;
> +		else
> +			val = 1;
> +		st->odr = ad778x_odr_avail[val];
> +		gpiod_set_value(st->filter_gpio, val);
> +	break;
> +	}
> +
> +	return 0;
> +}
> +
> static int ad7780_postprocess_sample(struct ad_sigma_delta *sigma_delta,
> 				     unsigned int raw_sample)
> {
> @@ -126,10 +187,8 @@ static int ad7780_postprocess_sample(struct
> ad_sigma_delta *sigma_delta,
> 		return -EIO;
> 
> 	if (chip_info->is_ad778x) {
> -		if (raw_sample & AD7780_GAIN)
> -			st->gain = 1;
> -		else
> -			st->gain = 128;
> +		st->gain = ad778x_gain[raw_sample & AD7780_GAIN];
> +		st->odr = ad778x_odr_avail[raw_sample & AD7780_FILTER];
> 	}
> 
> 	return 0;
> @@ -173,6 +232,7 @@ static const struct ad7780_chip_info
> ad7780_chip_info_tbl[] = {
> 
> static const struct iio_info ad7780_info = {
> 	.read_raw = ad7780_read_raw,
> +	.write_raw = ad7780_write_raw,
> };
> 
> static int ad7780_probe(struct spi_device *spi)
> @@ -222,6 +282,29 @@ static int ad7780_probe(struct spi_device *spi)
> 		goto error_disable_reg;
> 	}
> 
> +	if (st->chip_info->is_ad778x) {
> +		st->gain_gpio = devm_gpiod_get_optional(&spi->dev,
> +							"gain",
> +							GPIOD_OUT_HIGH);
> +		if (IS_ERR(st->gain_gpio)) {
> +			ret = PTR_ERR(st->gain_gpio);
> +			dev_err(&spi->dev, "Failed to request gain GPIO:
> %d\n",
> +				ret);
> +			goto error_disable_reg;
> +		}
> +
> +		st->filter_gpio = devm_gpiod_get_optional(&spi->dev,
> +							  "filter",
> +							  GPIOD_OUT_HIGH);
> +		if (IS_ERR(st->filter_gpio)) {
> +			ret = PTR_ERR(st->filter_gpio);
> +			dev_err(&spi->dev,
> +				"Failed to request filter GPIO: %d\n",
> +				ret);
> +			goto error_disable_reg;
> +		}
> +	}
> +
> 	ret = ad_sd_setup_buffer_and_trigger(indio_dev);
> 	if (ret)
> 		goto error_disable_reg;
> 

-- 

Peter Meerwald-Stadler
Mobile: +43 664 24 44 418
