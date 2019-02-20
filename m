Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4688C10F01
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B81D12086A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550659081;
	bh=4oQAHDsz6TOQEMW1QciWam049QEYozb7FKG0h72ICb4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=GV0O601GxWAw0TX7VyS/mm+JDqJnqPholZ+lD2aHWNHHTo/gZgS0CbFCBen21Bflu
	 9RrWXgr3NAVJNxIoz+nX3/PDa4fznR6Lt6SxOG+SbKRaVcNhAOVnLChLPBc9nICcWa
	 SE5jgSjVVBH0ndAti2YM7SpPYxhOwyLkeFyGFmNY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbfBTKiA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 05:38:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:52984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726209AbfBTKiA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 05:38:00 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B83C520700;
        Wed, 20 Feb 2019 10:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550659078;
        bh=4oQAHDsz6TOQEMW1QciWam049QEYozb7FKG0h72ICb4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TH7FuhhUu9zQSQostfrk0KqyAXjaVBFnUwKxg2af8JpZhAaK91ws6VGtL/g72b3jc
         MlLNZqMa2Oym9SBttq/Ay4xECH/UAYUfgZgQJjSk89TulCtS3CD7ZabbgMz8mwS19V
         wcaTJzEjUDEeAAdC4bTljhI6ADBwB0m878L3t7LQ=
Date:   Wed, 20 Feb 2019 10:37:53 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     <robh+dt@kernel.org>, <Michael.Hennerich@analog.com>,
        <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 4/6] iio: imu: adis16480: Treat temperature scale in a
 generic way
Message-ID: <20190220103753.0b64f5cc@archlinux>
In-Reply-To: <1550596338-24220-5-git-send-email-stefan.popa@analog.com>
References: <1550596338-24220-1-git-send-email-stefan.popa@analog.com>
        <1550596338-24220-5-git-send-email-stefan.popa@analog.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Feb 2019 19:12:16 +0200
Stefan Popa <stefan.popa@analog.com> wrote:

> All supported devices provide internal temperature measurement from -40 C
> to +85 C, with +25 C representing value 0x00.
> 
> This patch treats the temperature scale in a generic way, similar to the
> accelerometer and gyroscope scales. So far, there are no temperature max
> scale differences between the supported devices. However, devices that
> will make use of this feature will be added in the future.
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>


Given the datasheet (well 16480 anyway as I'm lazy and only checked that
one) give the scale directly in deg C / LSB, why not just provide directly?
For 16480 it is 0.00565.

For the other channel types it also gives them this way so we could change
them all over, but probably best not to touch something that is 'working' :)

Jonathan

> ---
>  drivers/iio/imu/adis16480.c | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
> index 7ae71f4..cc53825 100644
> --- a/drivers/iio/imu/adis16480.c
> +++ b/drivers/iio/imu/adis16480.c
> @@ -124,6 +124,7 @@ struct adis16480_chip_info {
>  	unsigned int gyro_max_scale;
>  	unsigned int accel_max_val;
>  	unsigned int accel_max_scale;
> +	unsigned int temp_max_scale;
>  };
>  
>  enum adis16480_int_pin {
> @@ -530,6 +531,7 @@ static int adis16480_read_raw(struct iio_dev *indio_dev,
>  	const struct iio_chan_spec *chan, int *val, int *val2, long info)
>  {
>  	struct adis16480 *st = iio_priv(indio_dev);
> +	unsigned int temp, scale;
>  
>  	switch (info) {
>  	case IIO_CHAN_INFO_RAW:
> @@ -549,8 +551,15 @@ static int adis16480_read_raw(struct iio_dev *indio_dev,
>  			*val2 = 100; /* 0.0001 gauss */
>  			return IIO_VAL_INT_PLUS_MICRO;
>  		case IIO_TEMP:
> -			*val = 5;
> -			*val2 = 650000; /* 5.65 milli degree Celsius */
> +			/*
> +			 * +85 degrees Celsius = temp_max_scale
> +			 * +25 degrees Celsius = 0
> +			 * LSB, 25 degrees Celsius  = 60 / temp_max_scale
> +			 */
> +			scale = DIV_ROUND_CLOSEST_ULL(60 * 1000000LL,
> +					st->chip_info->temp_max_scale);
> +			*val = scale / 1000;
> +			*val2 = (scale % 1000) * 1000;
>  			return IIO_VAL_INT_PLUS_MICRO;
>  		case IIO_PRESSURE:
>  			*val = 0;
> @@ -561,7 +570,10 @@ static int adis16480_read_raw(struct iio_dev *indio_dev,
>  		}
>  	case IIO_CHAN_INFO_OFFSET:
>  		/* Only the temperature channel has a offset */
> -		*val = 4425; /* 25 degree Celsius = 0x0000 */
> +		temp = 25 * 1000000LL; /* 25 degree Celsius = 0x0000 */
> +		scale = DIV_ROUND_CLOSEST_ULL(60 * 1000000LL,
> +				st->chip_info->temp_max_scale);
> +		*val = DIV_ROUND_CLOSEST_ULL(temp, scale);
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_CALIBBIAS:
>  		return adis16480_get_calibbias(indio_dev, chan, val);
> @@ -717,6 +729,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
>  		.gyro_max_scale = 300,
>  		.accel_max_val = IIO_M_S_2_TO_G(21973),
>  		.accel_max_scale = 18,
> +		.temp_max_scale = 10619,
>  	},
>  	[ADIS16480] = {
>  		.channels = adis16480_channels,
> @@ -725,6 +738,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
>  		.gyro_max_scale = 450,
>  		.accel_max_val = IIO_M_S_2_TO_G(12500),
>  		.accel_max_scale = 10,
> +		.temp_max_scale = 10619,
>  	},
>  	[ADIS16485] = {
>  		.channels = adis16485_channels,
> @@ -733,6 +747,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
>  		.gyro_max_scale = 450,
>  		.accel_max_val = IIO_M_S_2_TO_G(20000),
>  		.accel_max_scale = 5,
> +		.temp_max_scale = 10619,
>  	},
>  	[ADIS16488] = {
>  		.channels = adis16480_channels,
> @@ -741,6 +756,7 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
>  		.gyro_max_scale = 450,
>  		.accel_max_val = IIO_M_S_2_TO_G(22500),
>  		.accel_max_scale = 18,
> +		.temp_max_scale = 10619,
>  	},
>  };
>  

