Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F2DC6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 18:02:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89EB021721
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 18:02:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bm0+N/fR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89EB021721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932776AbeGGSCC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 14:02:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:36940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932182AbeGGSCA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 14:02:00 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F9B4216FD;
        Sat,  7 Jul 2018 18:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530986520;
        bh=Vawsubz8H0MzoBEpVCQ32OUDH7qrcv223NlsvHh8u2U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Bm0+N/fRn4DU0QlRWztPp04JnWn45CLWp8olNUuiAP6/ubrVbhU7Uf1SVxnaR7nRF
         Ay2YmOYFFeqFprwwTyaB+p9z7ynkJM+z9P437vXG8qtTapC1NdXaQxZvZzxp7OJHok
         YEnyTj7ftEeckFBEDmC3TMaknoqZvbCQcdLEEK+U=
Date:   Sat, 7 Jul 2018 19:01:55 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Himanshu Jha <himanshujha199640@gmail.com>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [PATCH v2] iio: chemical: bme680: Add Bosch BME680 sensor
 support
Message-ID: <20180707190155.09d37da0@archlinux>
In-Reply-To: <1530863416-4369-1-git-send-email-himanshujha199640@gmail.com>
References: <1530863416-4369-1-git-send-email-himanshujha199640@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  6 Jul 2018 13:20:16 +0530
Himanshu Jha <himanshujha199640@gmail.com> wrote:

> Bosch BME680 is a 4-in-1 sensor with temperature, pressure, humidity
> and gas sensing capability. It supports both I2C and SPI communication
> protocol for effective data communication.
> 
> The device supports two modes:
> 
> 1. Sleep mode
> 2. Forced mode
> 
> The measurements only takes place when forced mode is triggered and a
> single TPHG cycle is performed by the sensor. The sensor automatically
> goes to sleep after afterwards.
> 
> The device has various calibration constants/parameters programmed into
> devices' non-volatile memory(NVM) during production and can't be altered
> by the user. These constants are used in the compensation functions to
> get the required compensated readings along with the raw data. The
> compensation functions/algorithms are provided by Bosch Sensortec GmbH
> via their API[1]. As these don't change during the measurement cycle,
> therefore we read and store them at the probe. The default configs
> supplied by Bosch are also set at probe.
> 
> 0-day tested with build success.
> 
> GSoC-2018: https://summerofcode.withgoogle.com/projects/#6691473790074880
> Mentor: Daniel Baluta
> [1] https://github.com/BoschSensortec/BME680_driver
> Datasheet:
> https://ae-bst.resource.bosch.com/media/_tech/media/datasheets/BST-BME680-DS001-00.pdf
> 
> Cc: Daniel Baluta <daniel.baluta@gmail.com>
> Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>

Hi Himanshu,

This is coming together nicely.   A few suggestions inline on
things that I think can be further improved.

In particular I would take a close look at the calibration functions.
Those look to be awfully full of casts and not all of them need to be
there.  They just make things harder to read.

Jonathan
> ---
> 
> v2:
> 	-Used devm_add_action() to add a generic remove method for
> 	 both I2C & SPI driver.
> 	-Introduction of compensation functions.
> 	-chip initialisation routines moved to respective I2C and SPI
> 	 driver.
> 	-Introduction of gas sensing rountines.
> 	-Simplified Kconfig to reduce various options.
> 
>  drivers/iio/chemical/Kconfig              |   2 +
>  drivers/iio/chemical/Makefile             |   2 +
>  drivers/iio/chemical/bme680/Kconfig       |  29 ++
>  drivers/iio/chemical/bme680/Makefile      |   6 +
>  drivers/iio/chemical/bme680/bme680.h      | 118 +++++
>  drivers/iio/chemical/bme680/bme680_core.c | 839 ++++++++++++++++++++++++++++++
>  drivers/iio/chemical/bme680/bme680_i2c.c  |  83 +++
>  drivers/iio/chemical/bme680/bme680_spi.c  | 121 +++++
>  8 files changed, 1200 insertions(+)
>  create mode 100644 drivers/iio/chemical/bme680/Kconfig
>  create mode 100644 drivers/iio/chemical/bme680/Makefile
>  create mode 100644 drivers/iio/chemical/bme680/bme680.h
>  create mode 100644 drivers/iio/chemical/bme680/bme680_core.c
>  create mode 100644 drivers/iio/chemical/bme680/bme680_i2c.c
>  create mode 100644 drivers/iio/chemical/bme680/bme680_spi.c
> 
> diff --git a/drivers/iio/chemical/Kconfig b/drivers/iio/chemical/Kconfig
> index 5cb5be7..07593ee 100644
> --- a/drivers/iio/chemical/Kconfig
> +++ b/drivers/iio/chemical/Kconfig
> @@ -21,6 +21,8 @@ config ATLAS_PH_SENSOR
>  	 To compile this driver as module, choose M here: the
>  	 module will be called atlas-ph-sensor.
>  
> +source "drivers/iio/chemical/bme680/Kconfig"
> +
>  config CCS811
>  	tristate "AMS CCS811 VOC sensor"
>  	depends on I2C
> diff --git a/drivers/iio/chemical/Makefile b/drivers/iio/chemical/Makefile
> index a629b29..d0be7ae 100644
> --- a/drivers/iio/chemical/Makefile
> +++ b/drivers/iio/chemical/Makefile
> @@ -7,3 +7,5 @@ obj-$(CONFIG_ATLAS_PH_SENSOR)	+= atlas-ph-sensor.o
>  obj-$(CONFIG_CCS811)		+= ccs811.o
>  obj-$(CONFIG_IAQCORE)		+= ams-iaq-core.o
>  obj-$(CONFIG_VZ89X)		+= vz89x.o
> +
> +obj-y += bme680/
> diff --git a/drivers/iio/chemical/bme680/Kconfig b/drivers/iio/chemical/bme680/Kconfig
> new file mode 100644
> index 0000000..97cd07c
> --- /dev/null
> +++ b/drivers/iio/chemical/bme680/Kconfig

I would say this driver isn't going to be complex enough to really need its
own directory.  It's only 4 well defined files.

> @@ -0,0 +1,29 @@
> +#
> +# Bosch BME680 Driver
> +#
> +
> +config BME680
> +	tristate "Bosch Sensortec BME680 sensor driver"
> +	depends on (I2C || SPI)
> +	select REGMAP
> +	select BME680_I2C if (I2C)
> +	select BME680_SPI if (SPI)
> +	help
> +	  Say yes here to build support for Bosch Sensortec BME680 sensor with
> +	  temperature, pressure, humidity and gas sensing capability.
> +
> +	  This driver can also be built as a module. If so, the module for I2C
> +	  would be called bme680_i2c and bme680_spi for SPI support.
> +
> +config BME680_I2C
> +	tristate
> +	depends on BME680
> +	depends on I2C
> +	select REGMAP_I2C
> +
> +config BME680_SPI
> +	tristate
> +	depends on BME680
> +	depends on SPI
> +	select REGMAP_SPI
> +
> diff --git a/drivers/iio/chemical/bme680/Makefile b/drivers/iio/chemical/bme680/Makefile
> new file mode 100644
> index 0000000..562a708
> --- /dev/null
> +++ b/drivers/iio/chemical/bme680/Makefile
> @@ -0,0 +1,6 @@
> +#
> +# Makefile for Bosch BME680
> +#
> +obj-$(CONFIG_BME680) += bme680_core.o
> +obj-$(CONFIG_BME680_I2C) += bme680_i2c.o
> +obj-$(CONFIG_BME680_SPI) += bme680_spi.o
> diff --git a/drivers/iio/chemical/bme680/bme680.h b/drivers/iio/chemical/bme680/bme680.h
> new file mode 100644
> index 0000000..b5c1f873
> --- /dev/null
> +++ b/drivers/iio/chemical/bme680/bme680.h
> @@ -0,0 +1,118 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#ifndef BME680_H_
> +#define BME680_H_
> +
> +#define BME680_REG_CHIP_I2C_ID			0xD0
> +#define BME680_REG_CHIP_SPI_ID			0x50
> +#define BME680_CHIP_ID_VAL			0x61
> +#define BME680_REG_SOFT_RESET			0xE0
> +#define BME680_CMD_SOFTRESET			0xB6
> +#define BME680_REG_STATUS			0x73
> +#define   BME680_SPI_MEM_PAGE_BIT		BIT(4)
> +#define   BME680_SPI_MEM_PAGE_1_VAL		1
> +
> +#define BME680_OSRS_TEMP_X(osrs_t)		((osrs_t) << 5)
> +#define BME680_OSRS_PRESS_X(osrs_p)		((osrs_p) << 2)
> +#define BME680_OSRS_HUMID_X(osrs_h)		((osrs_h) << 0)
> +
> +#define BME680_REG_TEMP_MSB			0x22
> +#define BME680_REG_PRESS_MSB			0x1F
> +#define BM6880_REG_HUMIDITY_MSB			0x25
> +#define BME680_REG_GAS_MSB			0x2A
> +#define BME680_REG_GAS_R_LSB			0x2B
> +#define   BME680_GAS_STAB_BIT			BIT(4)
> +
> +#define BME680_REG_CTRL_HUMIDITY		0x72
> +#define   BME680_OSRS_HUMIDITY_MASK		GENMASK(2, 0)
> +
> +#define BME680_REG_CTRL_MEAS			0x74
> +#define   BME680_OSRS_TEMP_MASK			GENMASK(7, 5)
> +#define   BME680_OSRS_PRESS_MASK		GENMASK(4, 2)
> +#define   BME680_MODE_MASK			GENMASK(1, 0)
> +
> +#define BME680_MODE_FORCED			BIT(0)
> +#define BME680_MODE_SLEEP			0
> +
> +#define BME680_REG_CONFIG			0x75
> +#define   BME680_FILTER_MASK			GENMASK(4, 2)
> +#define   BME680_FILTER_COEFF			BIT(1)
> +
> +/* TEMP/PRESS/HUMID reading skipped */
> +#define BME680_MEAS_SKIPPED			0x8000
> +
> +/* Calibration coefficient's address */
> +#define BME680_COEFF_ADDR1			0x89
> +#define BME680_COEFF_ADDR1_LEN			25
> +#define BME680_COEFF_ADDR2			0xE1
> +#define BME680_COEFF_ADDR2_LEN			16
> +#define BME680_COEFF_SIZE			41
> +
> +#define BME680_MAX_OVERFLOW_VAL			0x40000000
> +#define BME680_HUM_REG_SHIFT_VAL		4
> +#define BME680_BIT_H1_DATA_MSK			0x0F
> +
> +#define BME680_REG_RES_HEAT_RANGE		0x02
> +#define BME680_RHRANGE_MSK			0x30
> +#define BME680_REG_RES_HEAT_VAL			0x00
> +#define BME680_REG_RANGE_SW_ERR			0x04
> +#define BME680_RSERROR_MSK			0xF0
> +#define BME680_REG_RES_HEAT_0			0x5A
> +#define BME680_REG_GAS_WAIT_0			0x64
> +#define BME680_GAS_RANGE_MASK			0x0F
> +#define BME680_ADC_GAS_RES_SHIFT		6
> +#define BME680_AMB_TEMP				25
> +
> +#define BME680_REG_CTRL_GAS_1			0x71
> +#define   BME680_RUN_GAS_MASK			BIT(4)
> +#define   BME680_NB_CONV_MASK			GENMASK(3, 0)
> +#define	BME680_RUN_GAS_EN			BIT(4)

Why extra indent on this one? Tab instead of spaces I suspect.

> +#define BME680_NB_CONV_0			0
> +
> +#define BME680_REG_MEAS_STAT_0			0x1D
> +#define   BME680_GAS_MEAS_BIT			BIT(6)
> +
> +/* Macro to combine two 8 bit data's to form a 16 bit data */
> +#define BME680_CONCAT_BYTES(MSB, LSB)   (((uint16_t)MSB << 8) | (uint16_t)LSB)
So this is a standard endian conversion in most cases?

Please do that instead of rolling your own where possible.
It is made more complex by the fact they are unaligned in the array..

Comments below on this.  I wouldn't read it as an array as you have
specific handling to do anyway for most of the elements.  It just
leads to harder to read code by adding an indirection we don't need.

> +
> +/* Array Index to Field data mapping for Calibration Data*/
> +#define BME680_T2_LSB_REG	1
> +#define BME680_T2_MSB_REG	2
> +#define BME680_T3_REG		3
> +#define BME680_P1_LSB_REG	5
> +#define BME680_P1_MSB_REG	6
> +#define BME680_P2_LSB_REG	7
> +#define BME680_P2_MSB_REG	8
> +#define BME680_P3_REG		9
> +#define BME680_P4_LSB_REG	11
> +#define BME680_P4_MSB_REG	12
> +#define BME680_P5_LSB_REG	13
> +#define BME680_P5_MSB_REG	14
> +#define BME680_P7_REG		15
> +#define BME680_P6_REG		16
> +#define BME680_P8_LSB_REG	19
> +#define BME680_P8_MSB_REG	20
> +#define BME680_P9_LSB_REG	21
> +#define BME680_P9_MSB_REG	22
> +#define BME680_P10_REG		23
> +#define BME680_H2_MSB_REG	25
> +#define BME680_H2_LSB_REG	26
> +#define BME680_H1_LSB_REG	26
> +#define BME680_H1_MSB_REG	27
> +#define BME680_H3_REG		28
> +#define BME680_H4_REG		29
> +#define BME680_H5_REG		30
> +#define BME680_H6_REG		31
> +#define BME680_H7_REG		32
> +#define BME680_T1_LSB_REG	33
> +#define BME680_T1_MSB_REG	34
> +#define BME680_GH2_LSB_REG	35
> +#define BME680_GH2_MSB_REG	36
> +#define BME680_GH1_REG		37
> +#define BME680_GH3_REG		38
> +
> +extern const struct regmap_config bme680_regmap_config;
> +
> +int bme680_core_probe(struct device *dev, struct regmap *regmap,
> +		      const char *name);
> +
> +#endif  /* BME680_H_ */
> diff --git a/drivers/iio/chemical/bme680/bme680_core.c b/drivers/iio/chemical/bme680/bme680_core.c
> new file mode 100644
> index 0000000..9d4cf10
> --- /dev/null
> +++ b/drivers/iio/chemical/bme680/bme680_core.c
> @@ -0,0 +1,839 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Bosch BME680 - Temperature, Pressure, Humidity & Gas Sensor
> + *
> + * Copyright (C) 2017 - 2018 Bosch Sensortec GmbH
> + * Copyright (C) 2018 Himanshu Jha <himanshujha199640@gmail.com>
> + *
> + * IIO core driver - I2C & SPI bus support

I'm not sure this particular comment really provides any additional
value. I'd drop this last line.

> + */
> +#include <linux/acpi.h>
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/log2.h>
> +#include <linux/regmap.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +
> +#include "bme680.h"
> +
> +struct bme680_calib {
> +	u16 par_t1;
> +	s16 par_t2;
> +	s8  par_t3;
> +	u16 par_p1;
> +	s16 par_p2;
> +	s8  par_p3;
> +	s16 par_p4;
> +	s16 par_p5;
> +	s8  par_p6;
> +	s8  par_p7;
> +	s16 par_p8;
> +	s16 par_p9;
> +	u8  par_p10;
> +	u16 par_h1;
> +	u16 par_h2;
> +	s8  par_h3;
> +	s8  par_h4;
> +	s8  par_h5;
> +	s8  par_h6;
> +	s8  par_h7;
> +	s8  par_gh1;
> +	s16 par_gh2;
> +	s8  par_gh3;
> +	u8  res_heat_range;
> +	s8  res_heat_val;
> +	s8  range_sw_err;
> +};
> +
> +struct bme680_data {
> +	struct regmap *regmap;
> +	struct bme680_calib bme680;
> +	u8 oversampling_temp;
> +	u8 oversampling_press;
> +	u8 oversampling_humid;
> +	u16 heater_dur;
> +	u16 heater_temp;
> +	/*
> +	 * Carryover value from temperature conversion, used in pressure
> +	 * and humidity compensation calculations.
> +	 */
> +	s32 t_fine;
> +};
> +
> +const struct regmap_config bme680_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +};
> +EXPORT_SYMBOL(bme680_regmap_config);
> +
> +static const struct iio_chan_spec bme680_channels[] = {
> +	{
> +		.type = IIO_TEMP,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> +				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> +	},
> +	{
> +		.type = IIO_PRESSURE,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> +				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> +	},
> +	{
> +		.type = IIO_HUMIDITYRELATIVE,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> +				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> +	},
> +	{
> +		.type = IIO_RESISTANCE,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
> +	},
> +};
> +
> +static const int bme680_oversampling_avail[] = { 1, 2, 4, 8, 16 };
> +
> +static int bme680_read_calib(struct bme680_data *data,
> +			     struct bme680_calib *calib)
> +{
> +	int ret;
> +	u8 t_buf[BME680_COEFF_SIZE] = {0};
> +	unsigned int tmp;
> +	struct device *dev = regmap_get_device(data->regmap);
> +
> +	/* Read calibration parameters values from sensor's NVM */
> +	ret = regmap_bulk_read(data->regmap, BME680_COEFF_ADDR1,
> +			       t_buf, BME680_COEFF_ADDR1_LEN);
> +	if (ret < 0) {
> +		dev_err(dev,
> +			"failed to read first set of calibration parameters\n");
> +		return ret;
> +	}
> +
> +	/* append the remaing parameters to the same array */
> +	ret = regmap_bulk_read(data->regmap, BME680_COEFF_ADDR2,
> +			       &t_buf[BME680_COEFF_ADDR1_LEN],
> +			       BME680_COEFF_ADDR2_LEN);

Hmm. So I would be tempted to break this up here.  You send
a lot of time reworking data into the relevant places below.
Perhaps do a series of reads to put it directly in the right place
to begin with?  This will also avoid the unaligned elements
for using standard endian conversions.

> +	if (ret < 0) {
> +		dev_err(dev,
> +			"failed to read second set of calibration parameters\n");
> +		return ret;
> +	}
> +		/* Temperature related coefficients */
Please check all comment indentations.  Should never be greater
than the surrounding code.

> +	calib->par_t1 = BME680_CONCAT_BYTES(t_buf[BME680_T1_MSB_REG],
> +					    t_buf[BME680_T1_LSB_REG]);
> +	calib->par_t2 = BME680_CONCAT_BYTES(t_buf[BME680_T2_MSB_REG],
> +					    t_buf[BME680_T2_LSB_REG]);
> +	calib->par_t3 = t_buf[BME680_T3_REG];
> +
> +		/* Pressure related coefficients */
> +	calib->par_p1 =	BME680_CONCAT_BYTES(t_buf[BME680_P1_MSB_REG],
> +					    t_buf[BME680_P1_LSB_REG]);
> +	calib->par_p2 = BME680_CONCAT_BYTES(t_buf[BME680_P2_MSB_REG],
> +					    t_buf[BME680_P2_LSB_REG]);
> +	calib->par_p3 = t_buf[BME680_P3_REG];
> +	calib->par_p4 = BME680_CONCAT_BYTES(t_buf[BME680_P4_MSB_REG],
> +					    t_buf[BME680_P4_LSB_REG]);
> +	calib->par_p5 = BME680_CONCAT_BYTES(t_buf[BME680_P5_MSB_REG],
> +					    t_buf[BME680_P5_LSB_REG]);
> +	calib->par_p6 = t_buf[BME680_P6_REG];
> +	calib->par_p7 = t_buf[BME680_P7_REG];
> +	calib->par_p8 = BME680_CONCAT_BYTES(t_buf[BME680_P8_MSB_REG],
> +					    t_buf[BME680_P8_LSB_REG]);
> +	calib->par_p9 = BME680_CONCAT_BYTES(t_buf[BME680_P9_MSB_REG],
> +					    t_buf[BME680_P9_LSB_REG]);
> +	calib->par_p10 = t_buf[BME680_P10_REG];
> +
> +		/* Humidity related coefficients */
> +	calib->par_h1 = ((t_buf[BME680_H1_MSB_REG] << BME680_HUM_REG_SHIFT_VAL)
> +				| (t_buf[BME680_H1_LSB_REG]
> +					& BME680_BIT_H1_DATA_MSK));
> +	calib->par_h2 = ((t_buf[BME680_H2_MSB_REG] << BME680_HUM_REG_SHIFT_VAL)
> +				| ((t_buf[BME680_H2_LSB_REG])
> +					>> BME680_HUM_REG_SHIFT_VAL));
> +	calib->par_h3 = t_buf[BME680_H3_REG];
> +	calib->par_h4 = t_buf[BME680_H4_REG];
> +	calib->par_h5 = t_buf[BME680_H5_REG];
> +	calib->par_h6 = t_buf[BME680_H6_REG];
> +	calib->par_h7 = t_buf[BME680_H7_REG];
> +
> +	/* Gas heater related coefficients */
> +	calib->par_gh1 = t_buf[BME680_GH1_REG];
> +	calib->par_gh2 = BME680_CONCAT_BYTES(t_buf[BME680_GH2_MSB_REG],
> +					     t_buf[BME680_GH2_LSB_REG]);
> +	calib->par_gh3 = t_buf[BME680_GH3_REG];
> +
> +	/* Other coefficients */
> +	ret = regmap_read(data->regmap, BME680_REG_RES_HEAT_RANGE, &tmp);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to read resistance heat range\n");
> +		return ret;
> +	}
> +	calib->res_heat_range = ((tmp & BME680_RHRANGE_MSK) / 16);
> +
> +	ret = regmap_read(data->regmap, BME680_REG_RES_HEAT_VAL, &tmp);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to read resistance heat value\n");
> +		return ret;
> +	}
> +	calib->res_heat_val = (s8)tmp;
> +
> +	ret = regmap_read(data->regmap, BME680_REG_RANGE_SW_ERR, &tmp);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to read range software error\n");
> +		return ret;
> +	}
> +	calib->range_sw_err = ((s8)tmp & (s8)BME680_RSERROR_MSK) / 16;
> +
> +	return 0;
> +}
> +
> +/* Taken from Bosch BME680 API */
> +static s32 bme680_compensate_temp(struct bme680_data *data,
> +				  s32 adc_temp)
> +{
> +	s64 var1, var2, var3, calc_temp;
> +	struct bme680_calib *calib = &data->bme680;
> +
> +	var1 = ((s32) adc_temp >> 3) - ((s32) calib->par_t1 << 1);
> +	var2 = (var1 * (s32) calib->par_t2) >> 11;
> +	var3 = ((var1 >> 1) * (var1 >> 1)) >> 12;
> +	var3 = ((var3) * ((s32) calib->par_t3 << 4)) >> 14;
> +	data->t_fine = (s32) (var2 + var3);
> +	calc_temp = (s16) (((data->t_fine * 5) + 128) >> 8);
> +
> +	return calc_temp;
> +}
> +
> +/* Taken from Bosch BME680 API */
> +static u32 bme680_compensate_press(struct bme680_data *data,
> +				   u32 adc_press)
> +{
> +	struct bme680_calib *calib = &data->bme680;
> +	s32 var1 = 0, var2 = 0, var3 = 0, pressure_comp = 0;
> +
> +	var1 = (((s32)data->t_fine) >> 1) - 64000;
> +	var2 = ((((var1 >> 2) * (var1 >> 2)) >> 11) *
> +				(s32)calib->par_p6) >> 2;
> +	var2 = var2 + ((var1 * (s32)calib->par_p5) << 1);
> +	var2 = (var2 >> 2) + ((s32)calib->par_p4 << 16);
> +	var1 = (((((var1 >> 2) * (var1 >> 2)) >> 13) *
> +			((s32)calib->par_p3 << 5)) >> 3) +
> +			(((s32)calib->par_p2 * var1) >> 1);
> +	var1 = var1 >> 18;
> +	var1 = ((32768 + var1) * (s32)calib->par_p1) >> 15;
> +	pressure_comp = 1048576 - adc_press;
> +	pressure_comp = (s32)((pressure_comp - (var2 >> 12)) * ((u32)3125));
> +
> +	if (pressure_comp >= BME680_MAX_OVERFLOW_VAL)
> +		pressure_comp = ((pressure_comp / (u32)var1) << 1);
> +	else
> +		pressure_comp = ((pressure_comp << 1) / (u32)var1);
> +
> +	var1 = ((s32)calib->par_p9 * (s32)(((pressure_comp >> 3) *
> +					(pressure_comp >> 3)) >> 13)) >> 12;
> +	var2 = ((s32)(pressure_comp >> 2) * (s32)calib->par_p8) >> 13;
> +	var3 = ((s32)(pressure_comp >> 8) * (s32)(pressure_comp >> 8) *
> +					(s32)(pressure_comp >> 8) *
> +					(s32)calib->par_p10) >> 17;
> +
> +	pressure_comp = (s32)(pressure_comp) + ((var1 + var2 + var3 +
> +					((s32)calib->par_p7 << 7)) >> 4);

Check all the casts in here.  For example pressure_comp is an s32 so
that one isn't doing anything useful.

I'm not going to go through them until the obvious issues are sorted! 
This stuff is really boring to check ;)

> +
> +	return (u32)pressure_comp;
> +}
> +
> +/* Taken from Bosch BME680 API */
> +static u32 bme680_compensate_humid(struct bme680_data *data,
> +				   u16 adc_humid)
> +{
> +	struct bme680_calib *calib = &data->bme680;
> +	s32 var1, var2, var3, var4, var5, var6, temp_scaled, calc_hum;
> +
> +	temp_scaled = (((s32) data->t_fine * 5) + 128) >> 8;
> +	var1 = (s32) (adc_humid - ((s32) ((s32) calib->par_h1 * 16)))
> +				- (((temp_scaled * (s32) calib->par_h3)
> +				/ ((s32) 100)) >> 1);
> +	var2 = ((s32) calib->par_h2 *
> +			(((temp_scaled * (s32) calib->par_h4) / ((s32) 100))
> +			+ (((temp_scaled * ((temp_scaled * (s32) calib->par_h5)
> +			/ ((s32) 100))) >> 6)
> +			/ ((s32) 100)) + (s32) (1 << 14))) >> 10;
> +	var3 = var1 * var2;
> +	var4 = (s32) calib->par_h6 << 7;
> +	var4 = ((var4) + ((temp_scaled * (s32) calib->par_h7)
> +				       / ((s32) 100))) >> 4;
> +	var5 = ((var3 >> 14) * (var3 >> 14)) >> 10;
> +	var6 = (var4 * var5) >> 1;
> +	calc_hum = (((var3 + var6) >> 10) * ((s32) 1000)) >> 12;
> +
> +	if (calc_hum > 100000) /* Cap at 100%rH */
> +		calc_hum = 100000;
> +	else if (calc_hum < 0)
> +		calc_hum = 0;
> +
> +	return (u32) calc_hum;
> +}
> +
> +/* Taken from Bosch BME680 API */
> +static u32 bme680_compensate_gas(struct bme680_data *data, u16 gas_res_adc,
> +				 u8 gas_range)
> +{
> +	struct bme680_calib *calib = &data->bme680;
> +	s64 var1;
> +	u64 var2;
> +	s64 var3;
> +	u32 calc_gas_res;
> +
> +	/* Look up table 1 for the possible gas range values */
> +	u32 lookupTable1[16] = {2147483647, 2147483647, 2147483647, 2147483647,
> +				2147483647, 2126008810, 2147483647, 2130303777,
> +				2147483647, 2147483647, 2143188679, 2136746228,
> +				2147483647, 2126008810, 2147483647, 2147483647};
> +	/* Look up table 2 for the possible gas range values */
> +	u32 lookupTable2[16] = {4096000000, 2048000000, 1024000000, 512000000,
> +				255744255, 127110228, 64000000, 32258064,
> +				16016016, 8000000, 4000000, 2000000, 1000000,
> +				500000, 250000, 125000};
> +
> +	var1 = (s64) ((1340 + (5 * (s64) calib->range_sw_err)) *
> +				((s64) lookupTable1[gas_range])) >> 16;
> +	var2 = (((s64) ((s64) gas_res_adc << 15) - (s64) (16777216)) + var1);
> +	var3 = (((s64) lookupTable2[gas_range] * (s64) var1) >> 9);
> +	calc_gas_res = (u32) ((var3 + ((s64) var2 >> 1)) / (s64) var2);
> +
> +	return calc_gas_res;
> +}
> +
> +/* Taken from Bosch BME680 API */
> +static u8 bme680_calc_heater_res(struct bme680_data *data, u16 temp)
> +{
> +	struct bme680_calib *calib = &data->bme680;
> +	u8 heatr_res;
> +	s32 var1, var2, var3, var4, var5, heatr_res_x100;
> +
> +	if (temp > 400) /* Cap temperature */
> +		temp = 400;
> +
> +	var1 = (((s32) BME680_AMB_TEMP * calib->par_gh3) / 1000) * 256;
> +	var2 = (calib->par_gh1 + 784) * (((((calib->par_gh2 + 154009) *
> +						temp * 5) / 100)
> +						+ 3276800) / 10);
> +	var3 = var1 + (var2 / 2);
> +	var4 = (var3 / (calib->res_heat_range + 4));
> +	var5 = (131 * calib->res_heat_val) + 65536;
> +	heatr_res_x100 = (s32) (((var4 / var5) - 250) * 34);
> +	heatr_res = (u8) ((heatr_res_x100 + 50) / 100);
> +
> +	return heatr_res;
> +}
> +
> +/* Taken from Bosch BME680 API */
> +static u8 bme680_calc_heater_dur(u16 dur)
> +{
> +	u8 durval, factor = 0;
> +
> +	if (dur >= 0xfc0) {
> +		durval = 0xff; /* Max duration */
> +	} else {
> +		while (dur > 0x3F) {
> +			dur = dur / 4;
> +			factor += 1;
> +		}
> +		durval = (u8) (dur + (factor * 64));
> +	}
> +
> +	return durval;
> +}
> +
> +static int bme680_set_mode(struct bme680_data *data, bool mode)
> +{
> +	struct device *dev = regmap_get_device(data->regmap);
> +	int ret;
> +
> +	if (mode) {
> +		ret = regmap_write_bits(data->regmap, BME680_REG_CTRL_MEAS,
> +					BME680_MODE_MASK, BME680_MODE_FORCED);
> +		if (ret < 0) {
> +			dev_err(dev, "failed to set forced mode\n");
> +			return ret;
> +		}
> +	} else {
> +		ret = regmap_write_bits(data->regmap, BME680_REG_CTRL_MEAS,
> +					BME680_MODE_MASK, BME680_MODE_SLEEP);
> +		if (ret < 0) {
> +			dev_err(dev, "failed to set sleep mode\n");
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int bme680_chip_config(struct bme680_data *data)
> +{
> +	struct device *dev = regmap_get_device(data->regmap);
> +	int ret;
> +	u8 osrs = BME680_OSRS_HUMID_X(data->oversampling_humid + 1);
> +	/*
> +	 * Highly recommended to set oversampling of humidity before
> +	 * temperature/pressure oversampling.
> +	 */
> +	ret = regmap_update_bits(data->regmap, BME680_REG_CTRL_HUMIDITY,
> +				 BME680_OSRS_HUMIDITY_MASK, osrs);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to write ctrl_hum register\n");
> +		return ret;
> +	}
> +
> +		/* IIR filter settings */

Indenting.

> +	ret = regmap_update_bits(data->regmap, BME680_REG_CONFIG,
> +				 BME680_FILTER_MASK,
> +				 BME680_FILTER_COEFF);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to write config register\n");
> +		return ret;
> +	}
> +
> +	osrs = BME680_OSRS_TEMP_X(data->oversampling_temp + 1) |
> +		BME680_OSRS_PRESS_X(data->oversampling_press + 1);
> +
> +	ret = regmap_write_bits(data->regmap, BME680_REG_CTRL_MEAS,
> +				BME680_OSRS_TEMP_MASK |
> +				BME680_OSRS_PRESS_MASK,
> +				osrs);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to write ctrl_meas register\n");
> +		return ret;

drop the return ret out of these brackets as ret is never positive.
For that matter use if (ret) to make that clear.

Do this throughout (I usually forget to point this one out).

> +	}
> +
> +	return 0;
> +}
> +
> +static int bme680_gas_config(struct bme680_data *data)
> +{
> +	struct device *dev = regmap_get_device(data->regmap);
> +	int ret;
> +	u8 heatr_res = 0, heatr_dur = 0;

Check throughout for local variables being assigned that don't
need to.

Also try checkpatch , sparse and ideally smatch as they'll point
out stuff like this.

> +
> +	heatr_res = bme680_calc_heater_res(data, data->heater_temp);
> +
> +		/* set target heater temperature */
> +	ret = regmap_write(data->regmap, BME680_REG_RES_HEAT_0, heatr_res);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to write res_heat_0 register\n");
> +		return ret;
> +	}
> +
> +	heatr_dur = bme680_calc_heater_dur(data->heater_dur);
> +
> +		/* set target heating duration */

odd indenting.

> +	ret = regmap_write(data->regmap, BME680_REG_GAS_WAIT_0, heatr_dur);
> +	if (ret < 0) {
> +		dev_err(dev, "failted to write gas_wait_0 register\n");
> +		return ret;
> +	}
> +
> +	/* Selecting the runGas and NB conversion settings for the sensor */
> +	ret = regmap_update_bits(data->regmap, BME680_REG_CTRL_GAS_1,
> +				 BME680_RUN_GAS_MASK | BME680_NB_CONV_MASK,
> +				 BME680_RUN_GAS_EN | BME680_NB_CONV_0);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to write ctrl_gas_1 register\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +/* Outputs temperature measurement in degC */
> +static int bme680_read_temp(struct bme680_data *data,
> +			    int *val, int *val2)
> +{
> +	struct device *dev = regmap_get_device(data->regmap);
> +	int ret = 0;
> +	__be32 tmp = 0;
> +	s32 adc_temp, comp_temp;
> +
> +	/* set forced mode to trigger a single measurement */
> +	ret = bme680_set_mode(data, true);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = regmap_bulk_read(data->regmap, BME680_REG_TEMP_MSB,
> +			       (u8 *) &tmp, 3);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to read temperature\n");
> +		return ret;
> +	}
> +
> +	adc_temp = be32_to_cpu(tmp) >> 12;
> +	if (adc_temp == BME680_MEAS_SKIPPED) {
> +		/* reading was skipped */
> +		dev_err(dev, "reading temperature skipped\n");
> +		return -EINVAL;
> +	}
> +	comp_temp = bme680_compensate_temp(data, adc_temp);
> +	/*
> +	 * val might be NULL if we're called by the read_press/read_humid
> +	 * routine which is callled to get t_fine value used in
> +	 * compensate_press/compensate_humid to get compensated
> +	 * pressure/humidity readings.
> +	 */
> +	if (val && val2) {
> +		*val = comp_temp;
> +		*val2 = 100;
> +		return IIO_VAL_FRACTIONAL;
> +	}
> +
> +	return 0;
> +}
> +
> +/* Outputs pressure measurement in hPa */
> +static int bme680_read_press(struct bme680_data *data,
> +			     int *val, int *val2)
> +{
> +	struct device *dev = regmap_get_device(data->regmap);
> +	int ret;
> +	__be32 tmp = 0;
> +	s32 adc_press;
> +	u32 comp_press;
> +
> +	/* Read and compensate temperature to get a reading of t_fine. */
> +	ret = bme680_read_temp(data, NULL, NULL);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = regmap_bulk_read(data->regmap, BME680_REG_PRESS_MSB,
> +			       (u8 *) &tmp, 3);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to read pressure\n");
> +		return ret;
> +	}
> +
> +	adc_press = be32_to_cpu(tmp) >> 12;
> +	if (adc_press == BME680_MEAS_SKIPPED) {
> +		/* reading was skipped */
> +		dev_err(dev, "reading pressure skipped\n");
> +		return -EINVAL;
> +	}
> +	comp_press = bme680_compensate_press(data, adc_press);
> +
> +	*val = comp_press;

*val = bme680_compensate...

> +	*val2 = 100;
> +	return IIO_VAL_FRACTIONAL;
> +}
> +
> +/* Outputs humidity measurement in %r.H */
> +static int bme680_read_humid(struct bme680_data *data,
> +			     int *val, int *val2)
> +{
> +	struct device *dev = regmap_get_device(data->regmap);
> +	int ret;
> +	__be16 tmp = 0;
> +	s32 adc_humidity;
> +	u32 comp_humidity;
> +
> +	/* Read and compensate temperature so we get a reading of t_fine. */
> +	ret = bme680_read_temp(data, NULL, NULL);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = regmap_bulk_read(data->regmap, BM6880_REG_HUMIDITY_MSB,
> +			       (u8 *) &tmp, 2);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to read humidity\n");
> +		return ret;
> +	}
> +
> +	adc_humidity = be16_to_cpu(tmp);
> +	if (adc_humidity == BME680_MEAS_SKIPPED) {
> +		/* reading was skipped */
> +		dev_err(dev, "reading humidity skipped\n");
> +		return -EINVAL;
> +	}
> +	comp_humidity = bme680_compensate_humid(data, adc_humidity);
> +
> +	*val = comp_humidity;
> +	*val2 = 1000;
> +	return IIO_VAL_FRACTIONAL;
> +}
> +
> +/* Outputs gas measurement in ohm */
> +static int bme680_read_gas(struct bme680_data *data,
> +			   int *val)
> +{
> +	struct device *dev = regmap_get_device(data->regmap);
> +	int ret;
> +	__be16 tmp = 0;
> +	unsigned int check;
> +	u16 adc_gas_res;
> +	u8 gas_range;
> +	u32 comp_gas;
> +
> +	/* Set heater settings */
> +	ret = bme680_gas_config(data);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to set gas config\n");
> +		return ret;
> +	}
> +
> +	/* set forced mode to trigger a single measurement */
> +	ret = bme680_set_mode(data, true);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = regmap_read(data->regmap, BME680_REG_MEAS_STAT_0, &check);
> +	if (check & BME680_GAS_MEAS_BIT) {
> +		dev_err(dev, "gas measurement incomplete\n");
> +		return -EBUSY;
> +	}
> +
> +	ret = regmap_read(data->regmap, BME680_REG_GAS_R_LSB, &check);
> +	if (ret < 0) {
> +		dev_err(dev,
> +			"failed to read gas_r_lsb register\n");
> +		return ret;
> +	}
> +
> +	if ((check & BME680_GAS_STAB_BIT) == 0) {
> +		dev_err(dev,
> +			"heater failed to reach the target temperature\n");
> +		return -EINVAL;

I wonder if we can improve on that error value.  Not sure what would be
better for 'too cold', but it's not Invalid...

> +	}
> +
> +	ret = regmap_bulk_read(data->regmap, BME680_REG_GAS_MSB,
> +			       (u8 *) &tmp, 2);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to read gas resistance\n");
> +		return ret;
> +	}
> +
> +	gas_range = check & BME680_GAS_RANGE_MASK;
> +	adc_gas_res = be16_to_cpu(tmp) >> BME680_ADC_GAS_RES_SHIFT;
> +	comp_gas = bme680_compensate_gas(data, adc_gas_res, gas_range);
> +
> +	*val = comp_gas;
> +	return IIO_VAL_INT;
> +}
> +
> +static int bme680_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan,
> +			   int *val, int *val2, long mask)
> +{
> +	struct bme680_data *data = iio_priv(indio_dev);
> +	int ret = -EINVAL;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_PROCESSED:
> +		switch (chan->type) {
> +		case IIO_TEMP:
> +			return bme680_read_temp(data, val, val2);
> +		case IIO_PRESSURE:
> +			return bme680_read_press(data, val, val2);
> +		case IIO_HUMIDITYRELATIVE:
> +			return bme680_read_humid(data, val, val2);
> +		case IIO_RESISTANCE:
> +			return bme680_read_gas(data, val);
> +		default:
> +			break;
return -EINVAL; then no need for the break.
> +		}
> +		break;
Can't get here once you return EINVAL so no need to have this
break either.

> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		switch (chan->type) {
> +		case IIO_TEMP:
> +			*val = 1 << data->oversampling_temp;
> +			return IIO_VAL_INT;
> +		case IIO_PRESSURE:
> +			*val = 1 << data->oversampling_press;
> +			return IIO_VAL_INT;
> +		case IIO_HUMIDITYRELATIVE:
> +			*val = 1 << data->oversampling_humid;
> +			return IIO_VAL_INT;
> +		default:
> +			break;
> +		}

You need a default for the outer switch statement I think.
return -EINVAL again then get ride of the local variable ret
as not needed.

> +	}
> +
> +	return ret;
> +}
> +
> +static int bme680_write_oversampling_ratio_temp(struct bme680_data *data,
> +						int val)
> +{
> +	const int *avail = bme680_oversampling_avail;
> +	const int n = ARRAY_SIZE(bme680_oversampling_avail);
> +	int i;
> +
> +	for (i = 0; i < n; ++i) {
> +		if (avail[i] == val) {
> +			data->oversampling_temp = ilog2(val);
> +
> +			return bme680_chip_config(data);
> +		}
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int bme680_write_oversampling_ratio_press(struct bme680_data *data,
> +						 int val)
> +{
> +	const int *avail = bme680_oversampling_avail;
> +	const int n = ARRAY_SIZE(bme680_oversampling_avail);
> +	int i;
> +
> +	for (i = 0; i < n; ++i) {
> +		if (avail[i] == val) {
> +			data->oversampling_press = ilog2(val);
> +
> +			return bme680_chip_config(data);
> +		}
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int bme680_write_oversampling_ratio_humid(struct bme680_data *data,
> +						 int val)
> +{
> +	const int *avail = bme680_oversampling_avail;

I'm not sure the local variable helps much here.  Why have it?

> +	const int n = ARRAY_SIZE(bme680_oversampling_avail);

Same is true for this local variable, just put it inline.

> +	int i;
> +
> +	for (i = 0; i < n; ++i) {
> +		if (avail[i] == val) {
> +			data->oversampling_humid = ilog2(val);
> +
> +			return bme680_chip_config(data);
> +		}
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int bme680_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int val, int val2, long mask)
> +{
> +	struct bme680_data *data = iio_priv(indio_dev);
> +	int ret = -EINVAL;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		switch (chan->type) {
> +		case IIO_TEMP:
> +			return bme680_write_oversampling_ratio_temp(data, val);
> +		case IIO_PRESSURE:
> +			return bme680_write_oversampling_ratio_press(data, val);
> +		case IIO_HUMIDITYRELATIVE:
> +			return bme680_write_oversampling_ratio_humid(data, val);
Will be interesting to see how this works if you add buffered support.

I'm assuming having different oversampling ratios will cause problems with
different sampling frequencies for the different channels, but perhaps not.
Depends on how the hardware works and I haven't looked yet!

> +		default:
> +			break;
> +		}
> +	break;
> +	}
> +
> +	return ret;
> +}
> +
> +static const char bme680_oversampling_ratio_show[] = "1 2 4 8 16";
> +
> +static IIO_CONST_ATTR(oversampling_ratio_available,
> +		      bme680_oversampling_ratio_show);
> +
> +static struct attribute *bme680_attributes[] = {
> +	&iio_const_attr_oversampling_ratio_available.dev_attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group bme680_attribute_group = {
> +	.attrs = bme680_attributes,
> +};
> +
> +static const struct iio_info bme680_info = {
> +	.read_raw = &bme680_read_raw,
> +	.write_raw = &bme680_write_raw,
> +	.attrs = &bme680_attribute_group,
> +};
> +
> +static const char *bme680_match_acpi_device(struct device *dev)
> +{
> +	const struct acpi_device_id *id;
> +
> +	id = acpi_match_device(dev->driver->acpi_match_table, dev);
> +	if (!id)
> +		return NULL;
> +
> +	return dev_name(dev);
> +}
> +
> +static void bme680_core_remove(void *arg)
> +{
> +	struct bme680_data *data = iio_priv(arg);
> +
> +	bme680_set_mode(data, false);
> +	iio_device_unregister(arg);
> +}
> +
> +int bme680_core_probe(struct device *dev, struct regmap *regmap,
> +		      const char *name)
> +{
> +	struct iio_dev *indio_dev;
> +	struct bme680_data *data;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	ret = devm_add_action(dev, bme680_core_remove, indio_dev);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to register remove action\n");
> +		return ret;
> +	}
> +
> +	if (!name && ACPI_HANDLE(dev))
> +		name = bme680_match_acpi_device(dev);
> +
> +	data = iio_priv(indio_dev);
> +	dev_set_drvdata(dev, indio_dev);
> +	data->regmap = regmap;
> +	indio_dev->dev.parent = dev;
> +	indio_dev->name = name;
> +	indio_dev->channels = bme680_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(bme680_channels);
> +	indio_dev->info = &bme680_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	/* default values for the sensor */
> +	data->oversampling_humid = ilog2(2); /* 2X oversampling rate */
> +	data->oversampling_press = ilog2(4); /* 4X oversampling rate */
> +	data->oversampling_temp = ilog2(8);  /* 8X oversampling rate */
> +	data->heater_temp = 320; /* degree Celsius */
> +	data->heater_dur = 150;  /* milliseconds */
> +
> +	ret = bme680_chip_config(data);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to set chip_config data\n");
> +		return ret;
> +	}
> +
> +	ret = bme680_gas_config(data);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to set gas config data\n");
> +		return ret;
> +	}
> +
> +	ret = bme680_read_calib(data, &data->bme680);
> +	if (ret < 0) {
> +		dev_err(dev,
> +			"failed to read calibration coefficients at probe\n");
> +		return ret;
> +	}
> +
> +	return iio_device_register(indio_dev);
> +}
> +EXPORT_SYMBOL_GPL(bme680_core_probe);
> +
> +MODULE_AUTHOR("Himanshu Jha <himanshujha199640@gmail.com>");
> +MODULE_DESCRIPTION("Bosch BME680 Driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iio/chemical/bme680/bme680_i2c.c b/drivers/iio/chemical/bme680/bme680_i2c.c
> new file mode 100644
> index 0000000..0a06796
> --- /dev/null
> +++ b/drivers/iio/chemical/bme680/bme680_i2c.c
> @@ -0,0 +1,83 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * BME680 - I2C Driver
> + *
> + * Copyright (C) 2018 Himanshu Jha <himanshujha199640@gmail.com>
> + *
> + * 7-Bit I2C slave address is:
> + *	- 0x76 if SDO is pulled to GND
> + *	- 0x77 if SDO is pulled to VDDIO
> + *
> + * Note: SDO pin cannot be left floating otherwise I2C address
> + *	 will be undefined.
> + */
> +#include <linux/acpi.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +
> +#include "bme680.h"
> +
> +static int bme680_i2c_probe(struct i2c_client *client,
> +			    const struct i2c_device_id *id)
> +{
> +	struct regmap *regmap;
> +	const char *name = NULL;
> +	unsigned int val;
> +	int ret;
> +
> +	regmap = devm_regmap_init_i2c(client, &bme680_regmap_config);
> +	if (IS_ERR(regmap)) {
> +		dev_err(&client->dev, "Failed to register i2c regmap %d\n",
> +				(int)PTR_ERR(regmap));
> +		return PTR_ERR(regmap);
> +	}
> +
> +	ret = regmap_write(regmap, BME680_REG_SOFT_RESET,
> +			   BME680_CMD_SOFTRESET);
Looks like it'll fit on one line under 80 chars...

> +	if (ret < 0)
> +		return ret;
> +
> +	ret = regmap_read(regmap, BME680_REG_CHIP_I2C_ID, &val);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "Error reading I2C chip ID\n");
> +		return ret;
> +	}
> +
> +	if (val != BME680_CHIP_ID_VAL) {
> +		dev_err(&client->dev, "Wrong chip ID, got %x expected %x\n",
> +				val, BME680_CHIP_ID_VAL);
> +		return -ENODEV;
> +	}
> +
> +	if (id)
> +		name = id->name;
> +
> +	return bme680_core_probe(&client->dev, regmap, name);
> +}
> +
> +static const struct i2c_device_id bme680_i2c_id[] = {
> +	{"bme680", 0},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(i2c, bme680_i2c_id);
> +
> +static const struct acpi_device_id bme680_acpi_match[] = {
> +	{"BME0680", 0},
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(acpi, bme680_acpi_match);
> +
> +static struct i2c_driver bme680_i2c_driver = {
> +	.driver = {
> +		.name			= "bme680_i2c",
> +		.acpi_match_table       = ACPI_PTR(bme680_acpi_match),
> +	},
> +	.probe = bme680_i2c_probe,
> +	.id_table = bme680_i2c_id,
> +};
> +module_i2c_driver(bme680_i2c_driver);
> +
> +MODULE_AUTHOR("Himanshu Jha <himanshujha199640@gmail.com>");
> +MODULE_DESCRIPTION("BME680 I2C driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iio/chemical/bme680/bme680_spi.c b/drivers/iio/chemical/bme680/bme680_spi.c
> new file mode 100644
> index 0000000..1e272db
> --- /dev/null
> +++ b/drivers/iio/chemical/bme680/bme680_spi.c
> @@ -0,0 +1,121 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * BME680 - SPI Driver
> + *
> + * Copyright (C) 2018 Himanshu Jha <himanshujha199640@gmail.com>
> + */
> +#include <linux/acpi.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/spi/spi.h>
> +
> +#include "bme680.h"
> +
> +static int bme680_regmap_spi_write(void *context, const void *data,
> +				   size_t count)
> +{
> +	struct device *dev = context;
> +	struct spi_device *spi = to_spi_device(dev);

Can we make the context the spi_device? Would make these
a tiny bit simpler I think.

> +	u8 buf[2];
> +
> +	memcpy(buf, data, 2);
> +	/*
> +	 * The SPI register address (= full register address without bit 7) and
> +	 * the write command (bit7 = RW = '0')
> +	 */
> +	buf[0] &= ~0x80;
> +
> +	return spi_write_then_read(spi, buf, 2, NULL, 0);
> +}
> +
> +static int bme680_regmap_spi_read(void *context, const void *reg,
> +				  size_t reg_size, void *val, size_t val_size)
> +{
> +	struct device *dev = context;
> +	struct spi_device *spi = to_spi_device(dev);
> +
> +	return spi_write_then_read(spi, reg, reg_size, val, val_size);
> +}
> +
> +static struct regmap_bus bme680_regmap_bus = {
> +	.write = bme680_regmap_spi_write,
> +	.read = bme680_regmap_spi_read,
> +	.reg_format_endian_default = REGMAP_ENDIAN_BIG,
> +	.val_format_endian_default = REGMAP_ENDIAN_BIG,
> +};
> +
> +static int bme680_spi_probe(struct spi_device *spi)
> +{
> +	const struct spi_device_id *id = spi_get_device_id(spi);
> +	struct regmap *regmap;
> +	unsigned int val;
> +	int ret;
> +
> +	spi->bits_per_word = 8;
> +	ret = spi_setup(spi);
> +	if (ret < 0) {
> +		dev_err(&spi->dev, "spi_setup failed!\n");
> +		return ret;
> +	}
> +
> +	regmap = devm_regmap_init(&spi->dev, &bme680_regmap_bus,
> +				  &spi->dev, &bme680_regmap_config);
> +	if (IS_ERR(regmap)) {
> +		dev_err(&spi->dev, "Failed to register spi regmap %d\n",
> +				(int)PTR_ERR(regmap));
> +		return PTR_ERR(regmap);
> +	}
> +
> +	ret = regmap_write(regmap, BME680_REG_SOFT_RESET,
> +			   BME680_CMD_SOFTRESET);
The above will fit under 80 chars so perhaps put it on one line?

Email clients with rulers make this stuff easy to spot ;)

> +	if (ret < 0)
> +		return ret;
> +
> +	/* after power-on reset, Page 0(0x80-0xFF) of spi_mem_page is active */
> +	ret = regmap_read(regmap, BME680_REG_CHIP_SPI_ID, &val);
> +	if (ret < 0) {
> +		dev_err(&spi->dev, "Error reading SPI chip ID\n");
> +		return ret;
> +	}
> +
> +	if (val != BME680_CHIP_ID_VAL) {
> +		dev_err(&spi->dev, "Wrong chip ID, got %x expected %x\n",
> +				val, BME680_CHIP_ID_VAL);
> +		return -ENODEV;
> +	}
> +	/*
> +	 * select Page 1 of spi_mem_page to enable access to
> +	 * to registers from address 0x00 to 0x7F.
> +	 */
> +	ret = regmap_write_bits(regmap, BME680_REG_STATUS,
> +				BME680_SPI_MEM_PAGE_BIT,
> +				BME680_SPI_MEM_PAGE_1_VAL);

You need to check ret and handle the error appropriately if
there is one.

> +
> +	return bme680_core_probe(&spi->dev, regmap, id->name);
> +}
> +
> +static const struct spi_device_id bme680_spi_id[] = {
> +	{"bme680", 0},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(spi, bme680_spi_id);
> +
> +static const struct acpi_device_id bme680_acpi_match[] = {
> +	{"BME0680", 0},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(acpi, bme680_acpi_match);
> +
> +static struct spi_driver bme680_spi_driver = {
> +	.driver = {
> +		.name			= "bme680_spi",
> +		.acpi_match_table	= ACPI_PTR(bme680_acpi_match),
> +	},
> +	.probe = bme680_spi_probe,
> +	.id_table = bme680_spi_id,
> +};
> +module_spi_driver(bme680_spi_driver);
> +
> +MODULE_AUTHOR("Himanshu Jha <himanshujha199640@gmail.com>");
> +MODULE_DESCRIPTION("Bosch BME680 SPI driver");
> +MODULE_LICENSE("GPL v2");

