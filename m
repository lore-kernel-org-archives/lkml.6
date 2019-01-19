Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C1BC61CE8
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 17:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 916D82086D
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 17:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547919220;
	bh=DtvgE/snMwSj3ZN1+bmlCAElg0h7LXzdeERzCLJc92U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=W4W5OerlmQnbKTi4mCR8+v8pLURi1w4WNn4UYDXVhXdg/sBnllE6Z76IK3hejSg6d
	 fZ1+5T3VORO7PlkzVwypnmhv3bMYtY9/Wipr34dUwOeG6HihGXmNkDSgU7NfDOW4tF
	 /PCn1laMxsGaY4Tq/A6HIpm+TFLyr9GAuTYV0WQc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbfASRdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 12:33:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:51706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728620AbfASRdf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 12:33:35 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B233D2086D;
        Sat, 19 Jan 2019 17:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547919214;
        bh=DtvgE/snMwSj3ZN1+bmlCAElg0h7LXzdeERzCLJc92U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Jd4aTyMPUW4q4BSBL/RMcJ1TndjPS9QXxSUSNucBDinZiH3vd2XcA+357b0HcAYEO
         JL72Ot84z3qe+DNPd34tm/5SU7KFpEVmEgztdmpkVQqFaThw8NuqOOhzAe24dZXmvP
         JmGKlD2Wxtf9sEjA/odm99HBE88Gr4FUCxzt7aeM=
Date:   Sat, 19 Jan 2019 17:33:30 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Denis CIOCCA <denis.ciocca@st.com>
Cc:     Mario Tesi <martepisa@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mario TESI <mario.tesi@st.com>
Subject: Re: [PATCH] iio:st_pressure:initial lps22hh sensor support
Message-ID: <20190119173330.29e49c63@archlinux>
In-Reply-To: <2844d78742404a0ebea470fa5e0ec722@SFHDAG2NODE1.st.com>
References: <1547486660-15359-1-git-send-email-mario.tesi@st.com>
        <2844d78742404a0ebea470fa5e0ec722@SFHDAG2NODE1.st.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jan 2019 00:18:58 +0000
Denis CIOCCA <denis.ciocca@st.com> wrote:

> Acked-by: Denis Ciocca <denis.ciocca@st.com>
> 
> 
> -----Original Message-----
> From: linux-iio-owner@vger.kernel.org <linux-iio-owner@vger.kernel.org> On Behalf Of Mario Tesi
> Sent: Monday, January 14, 2019 9:24 AM
> To: jic23@kernel.org
> Cc: linux-iio@vger.kernel.org; linux-kernel@vger.kernel.org; Mario TESI <mario.tesi@st.com>
> Subject: [PATCH] iio:st_pressure:initial lps22hh sensor support
> 
> From: mario tesi <mario.tesi@st.com>
> 
> Initial support for ST LPS22HH pressure sensor. Datasheet:
> http://www2.st.com/resource/en/datasheet/lps22hh.pdf
> 
> Features:
>  * pressure, temperature data and timestamping channels
>  * sampling frequency selection [1..200] Hz
>  * interrupt based trigger
>  * over I2C or SPI interface
> 
> Signed-off-by: mario tesi <mario.tesi@st.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/pressure/Kconfig            |  2 +-
>  drivers/iio/pressure/st_pressure.h      |  2 +
>  drivers/iio/pressure/st_pressure_core.c | 69 +++++++++++++++++++++++++++++++++  drivers/iio/pressure/st_pressure_i2c.c  |  5 +++  drivers/iio/pressure/st_pressure_spi.c  |  5 +++
>  5 files changed, 82 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig index eaa7cfc..efeb89f 100644
> --- a/drivers/iio/pressure/Kconfig
> +++ b/drivers/iio/pressure/Kconfig
> @@ -165,7 +165,7 @@ config IIO_ST_PRESS
>  	select IIO_TRIGGERED_BUFFER if (IIO_BUFFER)
>  	help
>  	  Say yes here to build support for STMicroelectronics pressure
> -	  sensors: LPS001WP, LPS25H, LPS331AP, LPS22HB.
> +	  sensors: LPS001WP, LPS25H, LPS331AP, LPS22HB, LPS22HH.
>  
>  	  This driver can also be built as a module. If so, these modules
>  	  will be created:
> diff --git a/drivers/iio/pressure/st_pressure.h b/drivers/iio/pressure/st_pressure.h
> index e67eb0d..5794660 100644
> --- a/drivers/iio/pressure/st_pressure.h
> +++ b/drivers/iio/pressure/st_pressure.h
> @@ -21,6 +21,7 @@ enum st_press_type {
>  	LPS22HB,
>  	LPS33HW,
>  	LPS35HW,
> +	LPS22HH,
>  	ST_PRESS_MAX,
>  };
>  
> @@ -30,6 +31,7 @@ enum st_press_type {
>  #define LPS22HB_PRESS_DEV_NAME		"lps22hb"
>  #define LPS33HW_PRESS_DEV_NAME		"lps33hw"
>  #define LPS35HW_PRESS_DEV_NAME		"lps35hw"
> +#define LPS22HH_PRESS_DEV_NAME		"lps22hh"
>  
>  /**
>   * struct st_sensors_platform_data - default press platform data diff --git a/drivers/iio/pressure/st_pressure_core.c b/drivers/iio/pressure/st_pressure_core.c
> index 4ddb6cf..38dcdb7 100644
> --- a/drivers/iio/pressure/st_pressure_core.c
> +++ b/drivers/iio/pressure/st_pressure_core.c
> @@ -492,6 +492,75 @@
>  		.multi_read_bit = false,
>  		.bootime = 2,
>  	},
> +	{
> +		/*
> +		 * CUSTOM VALUES FOR LPS22HH SENSOR
> +		 * See LPS22HH datasheet:
> +		 * http://www2.st.com/resource/en/datasheet/lps22hh.pdf
> +		 */
> +		.wai = 0xb3,
> +		.wai_addr = ST_SENSORS_DEFAULT_WAI_ADDRESS,
> +		.sensors_supported = {
> +			[0] = LPS22HH_PRESS_DEV_NAME,
> +		},
> +		.ch = (struct iio_chan_spec *)st_press_lps22hb_channels,
> +		.num_ch = ARRAY_SIZE(st_press_lps22hb_channels),
> +		.odr = {
> +			.addr = 0x10,
> +			.mask = 0x70,
> +			.odr_avl = {
> +				{ .hz = 1, .value = 0x01 },
> +				{ .hz = 10, .value = 0x02 },
> +				{ .hz = 25, .value = 0x03 },
> +				{ .hz = 50, .value = 0x04 },
> +				{ .hz = 75, .value = 0x05 },
> +				{ .hz = 100, .value = 0x06 },
> +				{ .hz = 200, .value = 0x07 },
> +			},
> +		},
> +		.pw = {
> +			.addr = 0x10,
> +			.mask = 0x70,
> +			.value_off = ST_SENSORS_DEFAULT_POWER_OFF_VALUE,
> +		},
> +		.fs = {
> +			.fs_avl = {
> +				/*
> +				 * Pressure and temperature sensitivity values
> +				 * as defined in table 3 of LPS22HH datasheet.
> +				 */
> +				[0] = {
> +					.num = ST_PRESS_FS_AVL_1260MB,
> +					.gain = ST_PRESS_KPASCAL_NANO_SCALE,
> +					.gain2 = ST_PRESS_LPS22HB_LSB_PER_CELSIUS,
> +				},
> +			},
> +		},
> +		.bdu = {
> +			.addr = 0x10,
> +			.mask = BIT(1),
> +		},
> +		.drdy_irq = {
> +			.int1 = {
> +				.addr = 0x12,
> +				.mask = BIT(2),
> +				.addr_od = 0x11,
> +				.mask_od = BIT(5),
> +			},
> +			.addr_ihl = 0x11,
> +			.mask_ihl = BIT(6),
> +			.stat_drdy = {
> +				.addr = ST_SENSORS_DEFAULT_STAT_ADDR,
> +				.mask = 0x03,
> +			},
> +		},
> +		.sim = {
> +			.addr = 0x10,
> +			.value = BIT(0),
> +		},
> +		.multi_read_bit = false,
> +		.bootime = 2,
> +	},
>  };
>  
>  static int st_press_write_raw(struct iio_dev *indio_dev, diff --git a/drivers/iio/pressure/st_pressure_i2c.c b/drivers/iio/pressure/st_pressure_i2c.c
> index 2026a10..a60849d 100644
> --- a/drivers/iio/pressure/st_pressure_i2c.c
> +++ b/drivers/iio/pressure/st_pressure_i2c.c
> @@ -45,6 +45,10 @@
>  		.compatible = "st,lps35hw",
>  		.data = LPS35HW_PRESS_DEV_NAME,
>  	},
> +	{
> +		.compatible = "st,lps22hh",
> +		.data = LPS22HH_PRESS_DEV_NAME,
> +	},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, st_press_of_match); @@ -69,6 +73,7 @@
>  	{ LPS22HB_PRESS_DEV_NAME, LPS22HB },
>  	{ LPS33HW_PRESS_DEV_NAME, LPS33HW },
>  	{ LPS35HW_PRESS_DEV_NAME, LPS35HW },
> +	{ LPS22HH_PRESS_DEV_NAME, LPS22HH },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(i2c, st_press_id_table); diff --git a/drivers/iio/pressure/st_pressure_spi.c b/drivers/iio/pressure/st_pressure_spi.c
> index 9a3441b..79a12ed 100644
> --- a/drivers/iio/pressure/st_pressure_spi.c
> +++ b/drivers/iio/pressure/st_pressure_spi.c
> @@ -49,6 +49,10 @@
>  		.compatible = "st,lps35hw",
>  		.data = LPS35HW_PRESS_DEV_NAME,
>  	},
> +	{
> +		.compatible = "st,lps22hh",
> +		.data = LPS22HH_PRESS_DEV_NAME,
> +	},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, st_press_of_match); @@ -93,6 +97,7 @@ static int st_press_spi_remove(struct spi_device *spi)
>  	{ LPS22HB_PRESS_DEV_NAME },
>  	{ LPS33HW_PRESS_DEV_NAME },
>  	{ LPS35HW_PRESS_DEV_NAME },
> +	{ LPS22HH_PRESS_DEV_NAME },
>  	{},
>  };
>  MODULE_DEVICE_TABLE(spi, st_press_id_table);
> --
> 1.9.1
> 

