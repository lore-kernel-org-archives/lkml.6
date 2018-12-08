Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DABACC65BAF
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 15:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A248D20892
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 15:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544283436;
	bh=LTPtZ0jsAA2NeY60LDFUERRm7eCX2CAJrtLzCW1LI3w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=w7sW+snYGls89k4Rz/NsCoFzuEGV/awgMByHkxmBJxh0K8ADqqDpM3FuYizX8+07z
	 7xGD62gjze34Q5TZi4QrTKQIXvU9g9F1jv1c04lO9zIqiLkbA8diMZf2ylYbD5RiZ2
	 PRwyuPZA168fvHdYuICoJY2+5dUonrbWuHSUvleY=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A248D20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbeLHPhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 10:37:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:38838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbeLHPhP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 10:37:15 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 26B6D205C9;
        Sat,  8 Dec 2018 15:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544283433;
        bh=LTPtZ0jsAA2NeY60LDFUERRm7eCX2CAJrtLzCW1LI3w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wxr0MnODsehlnw4F5uIzalG20aLDJOr+E+ldETrEB/rKYXApYKRfrLgwBFiC8Y7vs
         gMapxbSJMbKXAiHEJiS0CajgNxwzW9llyxphR6ElHNFhBpLwARhbviNIV9ZecMOfKW
         kDhJNditbzku/7sXfR8fUwVUcnMHW8vNiCsHMIWo=
Date:   Sat, 8 Dec 2018 15:37:08 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mircea Caprioru <mircea.caprioru@analog.com>
Cc:     <Michael.Hennerich@analog.com>, <knaack.h@gmx.de>,
        <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        Stefan Popa <stefan.popa@analog.com>
Subject: Re: [PATCH] iio:dac:ad5686: Add AD5310R support
Message-ID: <20181208153708.4e07154a@archlinux>
In-Reply-To: <20181206133830.20488-1-mircea.caprioru@analog.com>
References: <20181206133830.20488-1-mircea.caprioru@analog.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Dec 2018 15:38:30 +0200
Mircea Caprioru <mircea.caprioru@analog.com> wrote:

> From: Stefan Popa <stefan.popa@analog.com>
> 
> The AD5310R is a single channel DAC with 10-bit precision, which is
> part of the same family as AD5311R, except that it uses the spi interface
> instead of i2c. The device has a built-in 2.5V reference which is enabled
> by default.
> 
> Another important difference is that the SPI write command operation is
> 16 bits long. The first four bits represent the command, while the
> remaining 12 bits are for data. In the control reg, DB9 and DB10 are used
> for power-down modes, while DB8 is the REF bit. In order to accommodate
> this change, a new regmap type was defined and checked accordingly.
> 
> Because AD5310R does not have a readback register, the read_raw operation
> will return "Operation is not supported".
> 
> Datasheet:
> Link: http://www.analog.com/media/en/technical-documentation/data-sheets/AD5310R_5311R.pdf
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
A few comments inline, but mostly just me being fussy about patch presentation
so applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/dac/ad5686-spi.c | 21 ++++++++++++++++++---
>  drivers/iio/dac/ad5686.c     | 16 ++++++++++++++++
>  drivers/iio/dac/ad5686.h     |  7 +++++++
>  3 files changed, 41 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5686-spi.c b/drivers/iio/dac/ad5686-spi.c
> index 1df9143f55e9..665fa6bd9ced 100644
> --- a/drivers/iio/dac/ad5686-spi.c
> +++ b/drivers/iio/dac/ad5686-spi.c
> @@ -19,6 +19,12 @@ static int ad5686_spi_write(struct ad5686_state *st,
>  	u8 tx_len, *buf;
>  
>  	switch (st->chip_info->regmap_type) {
> +	case AD5310_REGMAP:
> +		st->data[0].d16 = cpu_to_be16(AD5310_CMD(cmd) |
> +					      val);
> +		buf = &st->data[0].d8[0];
> +		tx_len = 2;
> +		break;
>  	case AD5683_REGMAP:
>  		st->data[0].d32 = cpu_to_be32(AD5686_CMD(cmd) |
>  					      AD5683_DATA(val));
> @@ -56,10 +62,18 @@ static int ad5686_spi_read(struct ad5686_state *st, u8 addr)
>  	u8 cmd = 0;
>  	int ret;
>  
> -	if (st->chip_info->regmap_type == AD5686_REGMAP)
> -		cmd = AD5686_CMD_READBACK_ENABLE;
> -	else if (st->chip_info->regmap_type == AD5683_REGMAP)
> +	switch (st->chip_info->regmap_type) {

This is fine, though I'd prefer it done really as rework
patch without the new device support followed by adding the support
later in the series.   I prefer to have to do minimum thinking
whilst reviewing :)

> +	case AD5310_REGMAP:
> +		return -ENOTSUPP;
> +	case AD5683_REGMAP:
>  		cmd = AD5686_CMD_READBACK_ENABLE_V2;
> +		break;
> +	case AD5686_REGMAP:
> +		cmd = AD5686_CMD_READBACK_ENABLE;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
>  
>  	st->data[0].d32 = cpu_to_be32(AD5686_CMD(cmd) |
>  				      AD5686_ADDR(addr));
> @@ -86,6 +100,7 @@ static int ad5686_spi_remove(struct spi_device *spi)
>  }
>  
>  static const struct spi_device_id ad5686_spi_id[] = {
> +	{"ad5310r", ID_AD5310R},
>  	{"ad5672r", ID_AD5672R},
>  	{"ad5676", ID_AD5676},
>  	{"ad5676r", ID_AD5676R},
> diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
> index 0e134b13967a..54ff76b93366 100644
> --- a/drivers/iio/dac/ad5686.c
> +++ b/drivers/iio/dac/ad5686.c
> @@ -83,6 +83,10 @@ static ssize_t ad5686_write_dac_powerdown(struct iio_dev *indio_dev,
>  		st->pwr_down_mask &= ~(0x3 << (chan->channel * 2));
>  
>  	switch (st->chip_info->regmap_type) {
> +	case AD5310_REGMAP:
> +		shift = 9;
> +		ref_bit_msk = AD5310_REF_BIT_MSK;
> +		break;
>  	case AD5683_REGMAP:
>  		shift = 13;
>  		ref_bit_msk = AD5683_REF_BIT_MSK;
> @@ -221,6 +225,7 @@ static struct iio_chan_spec name[] = {				\
>  		AD5868_CHANNEL(7, 7, bits, _shift),		\
>  }
>  
> +DECLARE_AD5693_CHANNELS(ad5310r_channels, 10, 2);
>  DECLARE_AD5693_CHANNELS(ad5311r_channels, 10, 6);
>  DECLARE_AD5676_CHANNELS(ad5672_channels, 12, 4);
>  DECLARE_AD5676_CHANNELS(ad5676_channels, 16, 0);
> @@ -232,6 +237,12 @@ DECLARE_AD5693_CHANNELS(ad5692r_channels, 14, 2);
>  DECLARE_AD5693_CHANNELS(ad5691r_channels, 12, 4);
>  
>  static const struct ad5686_chip_info ad5686_chip_info_tbl[] = {
> +	[ID_AD5310R] = {
> +		.channels = ad5310r_channels,
> +		.int_vref_mv = 2500,
> +		.num_channels = 1,
> +		.regmap_type = AD5310_REGMAP,
> +	},
>  	[ID_AD5311R] = {
>  		.channels = ad5311r_channels,
>  		.int_vref_mv = 2500,
> @@ -419,6 +430,11 @@ int ad5686_probe(struct device *dev,
>  	indio_dev->num_channels = st->chip_info->num_channels;
>  
>  	switch (st->chip_info->regmap_type) {
> +	case AD5310_REGMAP:
> +		cmd = AD5686_CMD_CONTROL_REG;
> +		ref_bit_msk = AD5310_REF_BIT_MSK;
> +		st->use_internal_vref = !voltage_uv;
> +		break;
>  	case AD5683_REGMAP:
>  		cmd = AD5686_CMD_CONTROL_REG;
>  		ref_bit_msk = AD5683_REF_BIT_MSK;
> diff --git a/drivers/iio/dac/ad5686.h b/drivers/iio/dac/ad5686.h
> index 57b3c61bfb91..19f6917d4738 100644
> --- a/drivers/iio/dac/ad5686.h
> +++ b/drivers/iio/dac/ad5686.h
> @@ -13,7 +13,10 @@
>  #include <linux/mutex.h>
>  #include <linux/kernel.h>
>  
> +#define AD5310_CMD(x)				((x) << 12)
> +
>  #define AD5683_DATA(x)				((x) << 4)
> +

I'd rather these white space changes weren't in here, but they are small
enough it's not all that important.

>  #define AD5686_ADDR(x)				((x) << 16)
>  #define AD5686_CMD(x)				((x) << 20)
>  
> @@ -38,6 +41,8 @@
>  
>  #define AD5686_CMD_CONTROL_REG			0x4
>  #define AD5686_CMD_READBACK_ENABLE_V2		0x5
> +
> +#define AD5310_REF_BIT_MSK			BIT(8)
>  #define AD5683_REF_BIT_MSK			BIT(12)
>  #define AD5693_REF_BIT_MSK			BIT(12)
>  
> @@ -45,6 +50,7 @@
>   * ad5686_supported_device_ids:
>   */
>  enum ad5686_supported_device_ids {
> +	ID_AD5310R,
>  	ID_AD5311R,
>  	ID_AD5671R,
>  	ID_AD5672R,
> @@ -72,6 +78,7 @@ enum ad5686_supported_device_ids {
>  };
>  
>  enum ad5686_regmap_type {
> +	AD5310_REGMAP,
>  	AD5683_REGMAP,
>  	AD5686_REGMAP,
>  	AD5693_REGMAP

