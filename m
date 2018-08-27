Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 558BFC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 17:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 088FF208D8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 17:18:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHPV0yGA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 088FF208D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbeH0VFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 17:05:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:53616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726895AbeH0VFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 17:05:43 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B9B3208D5;
        Mon, 27 Aug 2018 17:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535390294;
        bh=hS6HTvCqrNq5Jt+hPYRegCMKldWcjKjscRwbmW7QMow=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fHPV0yGAz/8tunjH5i7TIIBH0kA5rFO8Xp1qITATRkxknajC0rTfsiS0wC8oTftbB
         DwXQKjj2yJfWk1VfqqstL21qG94rlT3auyK1ziNDG+twfx7IQHr4mHBjeL2FXQXGxk
         nMJOuScm+Di/n/cP3CiGDJzJqV/urzyHp+S6v9hY=
Date:   Mon, 27 Aug 2018 18:18:10 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Afonso Bordado <afonsobordado@az8.co>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 3/4] iio: fxas21002c: add ODR/Scale support
Message-ID: <20180827181810.6b4ee31d@archlinux>
In-Reply-To: <20180825211910.22929-3-afonsobordado@az8.co>
References: <20180825211910.22929-1-afonsobordado@az8.co>
        <20180825211910.22929-3-afonsobordado@az8.co>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Aug 2018 22:19:09 +0100
Afonso Bordado <afonsobordado@az8.co> wrote:

> This patch adds support for reading/writing ODR/Scale
> 
> We don't support the scale boost modes.
> 
> Signed-off-by: Afonso Bordado <afonsobordado@az8.co>

A few trivial bits in here.

Jonathan

> ---
>  drivers/iio/gyro/fxas21002c.c | 162 +++++++++++++++++++++++++++++++---
>  1 file changed, 149 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iio/gyro/fxas21002c.c b/drivers/iio/gyro/fxas21002c.c
> index 6fef210630e0..dc0cb9848386 100644
> --- a/drivers/iio/gyro/fxas21002c.c
> +++ b/drivers/iio/gyro/fxas21002c.c
> @@ -7,7 +7,7 @@
>   * IIO driver for FXAS21002C (7-bit I2C slave address 0x20 or 0x21).
>   * Datasheet: https://www.nxp.com/docs/en/data-sheet/FXAS21002.pdf
>   * TODO:
> - *        ODR / Scale Support
> + *        Scale boost mode
>   *        Power management
>   *        LowPass/HighPass Filters
>   *        Buffers
> @@ -40,7 +40,10 @@
>  #define FXAS21002C_REG_F_EVENT         0x0A
>  #define FXAS21002C_REG_INT_SRC_FLAG    0x0B
>  #define FXAS21002C_REG_WHO_AM_I        0x0C
> +
>  #define FXAS21002C_REG_CTRL_REG0       0x0D
> +#define FXAS21002C_SCALE_MASK          (BIT(0) | BIT(1))

This is a 2 bit mask, not a direct combination of two
one bit different things, so better as GENMASK(1, 0) to
make that implicit.

> +
>  #define FXAS21002C_REG_RT_CFG          0x0E
>  #define FXAS21002C_REG_RT_SRC          0x0F
>  #define FXAS21002C_REG_RT_THS          0x10
> @@ -52,13 +55,12 @@
>  #define FXAS21002C_ACTIVE_BIT          BIT(1)
>  #define FXAS21002C_READY_BIT           BIT(0)
>  
> -#define FXAS21002C_REG_CTRL_REG2       0x14
> -#define FXAS21002C_REG_CTRL_REG3       0x15
> +#define FXAS21002C_ODR_SHIFT           2
> +#define FXAS21002C_ODR_MASK            (BIT(2) | BIT(3) | BIT(4))
>  
> -#define FXAS21002C_DEFAULT_ODR_HZ      800
>  
> -// 0.0625 deg/s
> -#define FXAS21002C_DEFAULT_SENSITIVITY IIO_DEGREE_TO_RAD(62500)
> +#define FXAS21002C_REG_CTRL_REG2       0x14
> +#define FXAS21002C_REG_CTRL_REG3       0x15
>  
>  enum fxas21002c_id {
>  	ID_FXAS21002C,
> @@ -76,6 +78,40 @@ struct fxas21002c_data {
>  	struct regmap *regmap;
>  };
>  
> +enum fxas21002c_scale {
> +	FXAS21002C_SCALE_62MDPS,
> +	FXAS21002C_SCALE_31MDPS,
> +	FXAS21002C_SCALE_15MDPS,
> +	FXAS21002C_SCALE_7MDPS,
> +};
> +
> +static const int fxas21002c_anglevel_scale_avail[4][2] = {
> +	[FXAS21002C_SCALE_62MDPS] = { 0, IIO_DEGREE_TO_RAD(62500) },
> +	[FXAS21002C_SCALE_31MDPS] = { 0, IIO_DEGREE_TO_RAD(31250) },
> +	[FXAS21002C_SCALE_15MDPS] = { 0, IIO_DEGREE_TO_RAD(15625) },
> +	[FXAS21002C_SCALE_7MDPS]  = { 0, IIO_DEGREE_TO_RAD(7812) },
> +};
> +
> +enum fxas21002c_odr {
> +	FXAS21002C_ODR_800,
> +	FXAS21002C_ODR_400,
> +	FXAS21002C_ODR_200,
> +	FXAS21002C_ODR_100,
> +	FXAS21002C_ODR_50,
> +	FXAS21002C_ODR_25,
> +	FXAS21002C_ODR_12_5,
> +};
> +
> +static const int fxas21002c_sample_freq_avail[7][2] = {
> +	[FXAS21002C_ODR_800]  = { 800, 0 },
> +	[FXAS21002C_ODR_400]  = { 400, 0 },
> +	[FXAS21002C_ODR_200]  = { 200, 0 },
> +	[FXAS21002C_ODR_100]  = { 100, 0 },
> +	[FXAS21002C_ODR_50]   = { 50, 0 },
> +	[FXAS21002C_ODR_25]   = { 25, 0 },
> +	[FXAS21002C_ODR_12_5] = { 12, 500000 },
> +};
> +
>  static const struct regmap_range fxas21002c_writable_ranges[] = {
>  	regmap_reg_range(FXAS21002C_REG_F_SETUP, FXAS21002C_REG_F_SETUP),
>  	regmap_reg_range(FXAS21002C_REG_CTRL_REG0, FXAS21002C_REG_RT_CFG),
> @@ -242,6 +278,47 @@ static int fxas21002c_read_oneshot(struct fxas21002c_data *data,
>  	return IIO_VAL_INT;
>  }
>  
> +static int fxas21002c_scale_read(struct fxas21002c_data *data, int *val,
> +				 int *val2)
> +{
> +	int ret;
> +	unsigned int raw;
> +
> +	ret = regmap_read(data->regmap, FXAS21002C_REG_CTRL_REG0, &raw);
> +	if (ret)
> +		return ret;
> +
> +	raw &= FXAS21002C_SCALE_MASK;
> +
> +	*val = fxas21002c_anglevel_scale_avail[raw][0];
> +	*val2 = fxas21002c_anglevel_scale_avail[raw][1];
> +
> +	return IIO_VAL_INT_PLUS_MICRO;
> +}
> +
> +static int fxas21002c_odr_read(struct fxas21002c_data *data, int *val,
> +			       int *val2)
> +{
> +	int ret;
> +	unsigned int raw;
> +
> +	ret = regmap_read(data->regmap, FXAS21002C_REG_CTRL_REG1, &raw);
> +	if (ret)
> +		return ret;
> +
> +	raw = (raw & FXAS21002C_ODR_MASK) >> FXAS21002C_ODR_SHIFT;
> +
> +	// We don't use this mode but according to the datasheet its
> +	// also a 12.5Hz
/*
 * We...
 * also..
 */

The kernel style is very fussy about comment syntax.  It may seem silly but when
you read a lot of code these little thing being consistent help.

> +	if (raw == 7)
> +		raw = FXAS21002C_ODR_12_5;
> +
> +	*val = fxas21002c_sample_freq_avail[raw][0];
> +	*val2 = fxas21002c_sample_freq_avail[raw][1];
> +
> +	return IIO_VAL_INT_PLUS_MICRO;
> +}
> +
>  static int fxas21002c_read_raw(struct iio_dev *indio_dev,
>  			       struct iio_chan_spec const *chan, int *val,
>  			       int *val2, long mask)
> @@ -255,24 +332,83 @@ static int fxas21002c_read_raw(struct iio_dev *indio_dev,
>  		if (chan->type != IIO_ANGL_VEL)
>  			return -EINVAL;
>  
> -		*val = 0;
> -		*val2 = FXAS21002C_DEFAULT_SENSITIVITY;
> -
> -		return IIO_VAL_INT_PLUS_MICRO;
> +		return fxas21002c_scale_read(data, val, val2);
>  	case IIO_CHAN_INFO_SAMP_FREQ:
>  		if (chan->type != IIO_ANGL_VEL)
>  			return -EINVAL;
>  
> -		*val = FXAS21002C_DEFAULT_ODR_HZ;
> -
> -		return IIO_VAL_INT;
> +		return fxas21002c_odr_read(data, val, val2);
>  	}
>  
>  	return -EINVAL;
>  }
>  
> +static int fxas21002c_write_raw(struct iio_dev *indio_dev,
> +				struct iio_chan_spec const *chan, int val,
> +				int val2, long mask)
> +{
> +	struct fxas21002c_data *data = iio_priv(indio_dev);
> +	int ret = -EINVAL;
> +	int i;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		for (i = 0; i < ARRAY_SIZE(fxas21002c_sample_freq_avail); i++) {
> +			if (fxas21002c_sample_freq_avail[i][0] == val &&
> +			    fxas21002c_sample_freq_avail[i][1] == val2)
> +				break;
> +		}
> +
> +		if (i == ARRAY_SIZE(fxas21002c_sample_freq_avail))
> +			break;
> +
> +		ret = regmap_update_bits(data->regmap, FXAS21002C_REG_CTRL_REG1,
return regmap_update_bits...

> +					 FXAS21002C_ODR_MASK,
> +					 i << FXAS21002C_ODR_SHIFT);
> +
> +		break;
> +	case IIO_CHAN_INFO_SCALE:
> +		for (i = 0; i < ARRAY_SIZE(fxas21002c_anglevel_scale_avail);
> +		     i++) {
> +			if (fxas21002c_anglevel_scale_avail[i][0] == val &&
> +			    fxas21002c_anglevel_scale_avail[i][1] == val2)
> +				break;
> +		}
> +
> +		if (i == ARRAY_SIZE(fxas21002c_anglevel_scale_avail))
> +			break;
> +
> +		ret = regmap_update_bits(data->regmap, FXAS21002C_REG_CTRL_REG0,
return regmap_update_bits.
> +					 FXAS21002C_SCALE_MASK, i);
> +
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static IIO_CONST_ATTR(anglevel_scale_available,
> +		      "0.001090831 "  // 62.5    mdps
/* ... */
> +		      "0.000545415 "  // 31.25   mdps
> +		      "0.000272708 "  // 15.625  mdps
> +		      "0.000136354"); //  7.8125 mdps
> +
> +static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("800 400 200 100 50 25 12.5");
> +
> +static struct attribute *fxas21002c_attributes[] = {
> +	&iio_const_attr_anglevel_scale_available.dev_attr.attr,
> +	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group fxas21002c_attribute_group = {
> +	.attrs = fxas21002c_attributes,
> +};
> +
>  static const struct iio_info fxas21002c_info = {
>  	.read_raw		= fxas21002c_read_raw,
> +	.write_raw              = fxas21002c_write_raw,
> +	.attrs                  = &fxas21002c_attribute_group,
>  };
>  
>  static int fxas21002c_probe(struct i2c_client *client,

