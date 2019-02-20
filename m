Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C412DC10F01
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9735C2147C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 10:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550659257;
	bh=48R8l1yYZYp5vUIQbHr8KBwJ9k3lUDwkjwDH9fI2Ats=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=PIQ+1wAtmrrhqIKbaWrUG+TOCRHKCuuXtEDShyN6OgmeUza1p0OyZ/PJRdPBxZ4OK
	 ZHENK8MkxX9vk1jYK5c0i8nelSI9tpcS+Hw/akXJPnA1W8rJ/Cmu64Xe4I18tLq2Nx
	 b/uMYnRmlxZQtpRR8vRk+x/rMwVlMRnRP7Br51Mo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727483AbfBTKk4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 05:40:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:54800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726209AbfBTKk4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 05:40:56 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 915EE2087B;
        Wed, 20 Feb 2019 10:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550659254;
        bh=48R8l1yYZYp5vUIQbHr8KBwJ9k3lUDwkjwDH9fI2Ats=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LbZBL0BagGDMhPZFCDHb0XJtka7Xz73jgNyZHhf/QTb2DTRU7Hmsrmhscs8Rw74Rg
         rcZsJkNLwXFcMTxKpPP8xLc1GYTH4KdD4h+liTzcyrzcMj/LGHIPIHJteW4UkgpprS
         NVYL/7mSCvIng9sKVe/Dnw++7h1N3XCiOpMSpznw=
Date:   Wed, 20 Feb 2019 10:40:49 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     <robh+dt@kernel.org>, <Michael.Hennerich@analog.com>,
        <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 5/6] iio: imu: adis16480: Add support for ADIS1649x
 family of devices
Message-ID: <20190220104049.443106ef@archlinux>
In-Reply-To: <1550596338-24220-6-git-send-email-stefan.popa@analog.com>
References: <1550596338-24220-1-git-send-email-stefan.popa@analog.com>
        <1550596338-24220-6-git-send-email-stefan.popa@analog.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Feb 2019 19:12:17 +0200
Stefan Popa <stefan.popa@analog.com> wrote:

> The ADIS16495 and ADIS16497 are inertial systems that include a triaxis
> gyroscope and a triaxis accelerometer. The serial peripheral interface
> (SPI) provide a simple interface for data collection and configuration
> control. The devices are similar to ADIS16475, ADIS16480, ADIS16485 and
> ADIS16488, the main differences are related to range and scale factors.
> 
> The temperature data scale is 0.00565 C/LSB for ADIS16475 and ADIS1648x
> devices, while for ADIS1649x 0.0125 C/LSB.
> 
> Another difference is that ADIS1649x devices support different gyroscope
> measurement ranges which are dependent on the dash number (-1, -2, -3),
> see Table 24 in the ADIS16495 datasheet. However, the ADIS16497
> gyroscopes have the same scale as ADIS16495.
> 
> Furthermore, ADIS16495 devices support the acceleration maximum range of
> 8g, while ADIS16497 devices go up to 40g.
> 
> Datasheets:
> Link: https://www.analog.com/media/en/technical-documentation/data-sheets/adis16495.pdf
> Link: https://www.analog.com/media/en/technical-documentation/data-sheets/adis16497.pdf
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
Looks fine, but will probably change with the tweaks suggested for earlier
patches.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/adis16480.c | 72 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 72 insertions(+)
> 
> diff --git a/drivers/iio/imu/adis16480.c b/drivers/iio/imu/adis16480.c
> index cc53825..c30acfdb 100644
> --- a/drivers/iio/imu/adis16480.c
> +++ b/drivers/iio/imu/adis16480.c
> @@ -714,6 +714,12 @@ enum adis16480_variant {
>  	ADIS16480,
>  	ADIS16485,
>  	ADIS16488,
> +	ADIS16495_1,
> +	ADIS16495_2,
> +	ADIS16495_3,
> +	ADIS16497_1,
> +	ADIS16497_2,
> +	ADIS16497_3,
>  };
>  
>  static const struct adis16480_chip_info adis16480_chip_info[] = {
> @@ -758,6 +764,60 @@ static const struct adis16480_chip_info adis16480_chip_info[] = {
>  		.accel_max_scale = 18,
>  		.temp_max_scale = 10619,
>  	},
> +	[ADIS16495_1] = {
> +		.channels = adis16485_channels,
> +		.num_channels = ARRAY_SIZE(adis16485_channels),
> +		.gyro_max_val = IIO_RAD_TO_DEGREE(20000),
> +		.gyro_max_scale = 125,
> +		.accel_max_val = IIO_M_S_2_TO_G(32000),
> +		.accel_max_scale = 8,
> +		.temp_max_scale = 4800,
> +	},
> +	[ADIS16495_2] = {
> +		.channels = adis16485_channels,
> +		.num_channels = ARRAY_SIZE(adis16485_channels),
> +		.gyro_max_val = IIO_RAD_TO_DEGREE(18000),
> +		.gyro_max_scale = 450,
> +		.accel_max_val = IIO_M_S_2_TO_G(32000),
> +		.accel_max_scale = 8,
> +		.temp_max_scale = 4800,
> +	},
> +	[ADIS16495_3] = {
> +		.channels = adis16485_channels,
> +		.num_channels = ARRAY_SIZE(adis16485_channels),
> +		.gyro_max_val = IIO_RAD_TO_DEGREE(20000),
> +		.gyro_max_scale = 2000,
> +		.accel_max_val = IIO_M_S_2_TO_G(32000),
> +		.accel_max_scale = 8,
> +		.temp_max_scale = 4800,
> +	},
> +	[ADIS16497_1] = {
> +		.channels = adis16485_channels,
> +		.num_channels = ARRAY_SIZE(adis16485_channels),
> +		.gyro_max_val = IIO_RAD_TO_DEGREE(20000),
> +		.gyro_max_scale = 125,
> +		.accel_max_val = IIO_M_S_2_TO_G(32000),
> +		.accel_max_scale = 40,
> +		.temp_max_scale = 4800,
> +	},
> +	[ADIS16497_2] = {
> +		.channels = adis16485_channels,
> +		.num_channels = ARRAY_SIZE(adis16485_channels),
> +		.gyro_max_val = IIO_RAD_TO_DEGREE(18000),
> +		.gyro_max_scale = 450,
> +		.accel_max_val = IIO_M_S_2_TO_G(32000),
> +		.accel_max_scale = 40,
> +		.temp_max_scale = 4800,
> +	},
> +	[ADIS16497_3] = {
> +		.channels = adis16485_channels,
> +		.num_channels = ARRAY_SIZE(adis16485_channels),
> +		.gyro_max_val = IIO_RAD_TO_DEGREE(20000),
> +		.gyro_max_scale = 2000,
> +		.accel_max_val = IIO_M_S_2_TO_G(32000),
> +		.accel_max_scale = 40,
> +		.temp_max_scale = 4800,
> +	},
>  };
>  
>  static const struct iio_info adis16480_info = {
> @@ -1000,6 +1060,12 @@ static const struct spi_device_id adis16480_ids[] = {
>  	{ "adis16480", ADIS16480 },
>  	{ "adis16485", ADIS16485 },
>  	{ "adis16488", ADIS16488 },
> +	{ "adis16495-1", ADIS16495_1 },
> +	{ "adis16495-2", ADIS16495_2 },
> +	{ "adis16495-3", ADIS16495_3 },
> +	{ "adis16497-1", ADIS16497_1 },
> +	{ "adis16497-2", ADIS16497_2 },
> +	{ "adis16497-3", ADIS16497_3 },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(spi, adis16480_ids);
> @@ -1009,6 +1075,12 @@ static const struct of_device_id adis16480_of_match[] = {
>  	{ .compatible = "adi,adis16480" },
>  	{ .compatible = "adi,adis16485" },
>  	{ .compatible = "adi,adis16488" },
> +	{ .compatible = "adi,adis16495-1" },
> +	{ .compatible = "adi,adis16495-2" },
> +	{ .compatible = "adi,adis16495-3" },
> +	{ .compatible = "adi,adis16497-1" },
> +	{ .compatible = "adi,adis16497-2" },
> +	{ .compatible = "adi,adis16497-3" },
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(of, adis16480_of_match);

