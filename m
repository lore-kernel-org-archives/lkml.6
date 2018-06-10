Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id D5OtKyIzHVvEOgAAmS7hNA
	; Sun, 10 Jun 2018 14:18:10 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 93F9460791; Sun, 10 Jun 2018 14:18:10 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eh3MMs6o"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id CF8EB606FA;
	Sun, 10 Jun 2018 14:18:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CF8EB606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753466AbeFJOSG (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 10:18:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:42418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750744AbeFJOSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 10:18:04 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B83052089C;
        Sun, 10 Jun 2018 14:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528640283;
        bh=q0S8DPwH/SRbFenxR9B5qeerSksxEqDS5WCNQhH2X+U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eh3MMs6ohZI5vrW8/2+LLYjjppYJzEvXQLCtFXHZbO6Zw2JDpNV/t/2eCqK9bhdd0
         MyUdv3eWJ/QFj++iX/rWIwAhjn4q87xofumKFZuXjPdnr2Anw8ohGwFwgh+yL/YFrq
         wsDXDzC3gHbszD3TqP1hgnubWbCzFZ6ABAjTKLxA=
Date: Sun, 10 Jun 2018 15:17:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Stefan Popa <stefan.popa@analog.com>
Cc: <Michael.Hennerich@analog.com>, <lars@metafoo.de>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>, <mchehab@kernel.org>,
        <davem@davemloft.net>, <gregkh@linuxfoundation.org>,
        <akpm@linux-foundation.org>, <linus.walleij@linaro.org>,
        <rdunlap@infradead.org>, <lukas@wunner.de>,
        <Ismail.Kose@maximintegrated.com>, <vilhelm.gray@gmail.com>,
        <sean.nyekjaer@prevas.dk>, <pombredanne@nexb.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] iio: dac: Add AD5758 support
Message-ID: <20180610151756.372f185f@archlinux>
In-Reply-To: <1528376980-526-1-git-send-email-stefan.popa@analog.com>
References: <1528376980-526-1-git-send-email-stefan.popa@analog.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Jun 2018 16:09:40 +0300
Stefan Popa <stefan.popa@analog.com> wrote:

> The AD5758 is a single channel DAC with 16-bit precision which uses the SPI
> interface that operates at clock rates up to 50MHz.
> 
> The output can be configured as voltage or current and is available on a
> single terminal.
> 
> Datasheet:
> http://www.analog.com/media/en/technical-documentation/data-sheets/ad5758.pdf
> 
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>

Various things inline, but basically looks fine once we have those
bindings sorted out.

One that confused me though is that this can be a current output device,
but you only provide a voltage channel?

Thanks,

Jonathan

> ---
> Changes in v2:
> 	- removed unnecessary parenthesis in AD5758_REG_WRITE macro.
> 	- added missing documentation fields of ad5758_state struct.
> 	- changed the type of pwr_down attribute to bool.
> 	- changed ad5758_dc_dc_ilimt[] to ad5758_dc_dc_ilim[].
> 	- ad5758_spi_reg_write() now returns spi_write(st->spi,
> 	  &st->data[0].d32, sizeof(st->data[0].d32));
> 	- removed unnecessary new line in ad5758_calib_mem_refresh().
> 	- changed the type of the mode parameter in
> 	  ad5758_set_dc_dc_conv_mode() from unsigned int to enum
> 	  ad5758_dc_dc_mode.
> 	- removed unnecessary parenthesis in ad5758_slew_rate_config().
> 	- changed the type of the enable parameter in
> 	  ad5758_fault_prot_switch_en() from unsigned char to bool.
> 	- the same as above, but for ad5758_internal_buffers_en().
> 	- added a missing mutex_unlock() in ad5758_reg_access().
> 	- moved the mutex_unlock() in ad5758_read_raw() and removed the
> 	  unreachable return.
> 	- returned directly where it was possible in ad5758_write_raw().
> 	- removed the channel, scan_type and scan_index fields.
> 	- in ad5758_parse_dt(), added missing "\n", and specified what the
> 	  default mode actually is.
> 	- returned directly at the end of ad5758_init().
> 	- in ad5758_probe() used device managed for registering the device
> 	  and returned directly without the error message.
> 
>  MAINTAINERS              |   7 +
>  drivers/iio/dac/Kconfig  |  10 +
>  drivers/iio/dac/Makefile |   1 +
>  drivers/iio/dac/ad5758.c | 805 +++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 823 insertions(+)
>  create mode 100644 drivers/iio/dac/ad5758.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4b65225..1993779 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -802,6 +802,13 @@ S:	Supported
>  F:	drivers/iio/dac/ad5686*
>  F:	drivers/iio/dac/ad5696*
>  
> +ANALOG DEVICES INC AD5758 DRIVER
> +M:	Stefan Popa <stefan.popa@analog.com>
> +L:	linux-iio@vger.kernel.org
> +W:	http://ez.analog.com/community/linux-device-drivers
> +S:	Supported
> +F:	drivers/iio/dac/ad5758.c
> +
>  ANALOG DEVICES INC AD9389B DRIVER
>  M:	Hans Verkuil <hans.verkuil@cisco.com>
>  L:	linux-media@vger.kernel.org
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index 06e90de..80beb64 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -167,6 +167,16 @@ config AD5755
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called ad5755.
>  
> +config AD5758
> +	tristate "Analog Devices AD5758 DAC driver"
> +	depends on SPI_MASTER
> +	help
> +	  Say yes here to build support for Analog Devices AD5758 single channel
> +	  Digital to Analog Converter.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called ad5758.
> +
>  config AD5761
>  	tristate "Analog Devices AD5761/61R/21/21R DAC driver"
>  	depends on SPI_MASTER
> diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
> index 57aa230..e859f2d 100644
> --- a/drivers/iio/dac/Makefile
> +++ b/drivers/iio/dac/Makefile
> @@ -16,6 +16,7 @@ obj-$(CONFIG_AD5592R_BASE) += ad5592r-base.o
>  obj-$(CONFIG_AD5592R) += ad5592r.o
>  obj-$(CONFIG_AD5593R) += ad5593r.o
>  obj-$(CONFIG_AD5755) += ad5755.o
> +obj-$(CONFIG_AD5758) += ad5758.o
>  obj-$(CONFIG_AD5761) += ad5761.o
>  obj-$(CONFIG_AD5764) += ad5764.o
>  obj-$(CONFIG_AD5791) += ad5791.o
> diff --git a/drivers/iio/dac/ad5758.c b/drivers/iio/dac/ad5758.c
> new file mode 100644
> index 0000000..3008a3a
> --- /dev/null
> +++ b/drivers/iio/dac/ad5758.c
> @@ -0,0 +1,805 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * AD5758 Digital to analog converters driver
> + *
> + * Copyright 2018 Analog Devices Inc.
> + */
> +
> +#include <linux/fs.h>
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <linux/sysfs.h>
> +#include <linux/spi/spi.h>
> +#include <linux/delay.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/property.h>
> +
> +/* AD5758 registers definition */
> +#define AD5758_NOP					0x00
> +#define AD5758_DAC_INPUT				0x01
> +#define AD5758_DAC_OUTPUT				0x02
> +#define AD5758_CLEAR_CODE				0x03
> +#define AD5758_USER_GAIN				0x04
> +#define AD5758_USER_OFFSET				0x05
> +#define AD5758_DAC_CONFIG				0x06
> +#define AD5758_SW_LDAC					0x07
> +#define AD5758_KEY					0x08
> +#define AD5758_GP_CONFIG1				0x09
> +#define AD5758_GP_CONFIG2				0x0A
> +#define AD5758_DCDC_CONFIG1				0x0B
> +#define AD5758_DCDC_CONFIG2				0x0C
> +#define AD5758_WDT_CONFIG				0x0F
> +#define AD5758_DIGITAL_DIAG_CONFIG			0x10
> +#define AD5758_ADC_CONFIG				0x11
> +#define AD5758_FAULT_PIN_CONFIG				0x12
> +#define AD5758_TWO_STAGE_READBACK_SELECT		0x13
> +#define AD5758_DIGITAL_DIAG_RESULTS			0x14
> +#define AD5758_ANALOG_DIAG_RESULTS			0x15
> +#define AD5758_STATUS					0x16
> +#define AD5758_CHIP_ID					0x17
> +#define AD5758_FREQ_MONITOR				0x18
> +#define AD5758_DEVICE_ID_0				0x19
> +#define AD5758_DEVICE_ID_1				0x1A
> +#define AD5758_DEVICE_ID_2				0x1B
> +#define AD5758_DEVICE_ID_3				0x1C
> +
> +/* AD5758_DAC_CONFIG */
> +#define AD5758_DAC_CONFIG_RANGE_MSK			GENMASK(3, 0)
> +#define AD5758_DAC_CONFIG_RANGE_MODE(x)			(((x) & 0xF) << 0)
> +#define AD5758_DAC_CONFIG_OVRNG_EN_MSK			BIT(4)
> +#define AD5758_DAC_CONFIG_OVRNG_EN_MODE(x)		(((x) & 0x1) << 4)
> +#define AD5758_DAC_CONFIG_INT_EN_MSK			BIT(5)
> +#define AD5758_DAC_CONFIG_INT_EN_MODE(x)		(((x) & 0x1) << 5)
> +#define AD5758_DAC_CONFIG_OUT_EN_MSK			BIT(6)
> +#define AD5758_DAC_CONFIG_OUT_EN_MODE(x)		(((x) & 0x1) << 6)
> +#define AD5758_DAC_CONFIG_RSET_EXT_EN_MSK		BIT(7)
> +#define AD5758_DAC_CONFIG_RSET_EXT_EN_MODE(x)		(((x) & 0x1) << 7)
> +#define AD5758_DAC_CONFIG_SR_EN_MSK			BIT(8)
> +#define AD5758_DAC_CONFIG_SR_EN_MODE(x)			(((x) & 0x1) << 8)
> +#define AD5758_DAC_CONFIG_SR_CLOCK_MSK			GENMASK(12, 9)
> +#define AD5758_DAC_CONFIG_SR_CLOCK_MODE(x)		(((x) & 0xF) << 9)
> +#define AD5758_DAC_CONFIG_SR_STEP_MSK			GENMASK(15, 13)
> +#define AD5758_DAC_CONFIG_SR_STEP_MODE(x)		(((x) & 0x7) << 13)
> +
> +/* AD5758_KEY */
> +#define AD5758_KEY_CODE_RESET_1				0x15FA
> +#define AD5758_KEY_CODE_RESET_2				0xAF51
> +#define AD5758_KEY_CODE_SINGLE_ADC_CONV			0x1ADC
> +#define AD5758_KEY_CODE_RESET_WDT			0x0D06
> +#define AD5758_KEY_CODE_CALIB_MEM_REFRESH		0xFCBA
> +
> +/* AD5758_DCDC_CONFIG1 */
> +#define AD5758_DCDC_CONFIG1_DCDC_VPROG_MSK		GENMASK(4, 0)
> +#define AD5758_DCDC_CONFIG1_DCDC_VPROG_MODE(x)		(((x) & 0x1F) << 0)
> +#define AD5758_DCDC_CONFIG1_DCDC_MODE_MSK		GENMASK(6, 5)
> +#define AD5758_DCDC_CONFIG1_DCDC_MODE_MODE(x)		(((x) & 0x3) << 5)
> +#define AD5758_DCDC_CONFIG1_FAULT_PROT_SW_EN_MSK	BIT(7)
> +#define AD5758_DCDC_CONFIG1_FAULT_PROT_SW_EN_MODE(x)	(((x) & 0x1) << 7)
> +
> +/* AD5758_DCDC_CONFIG2 */
> +#define AD5758_DCDC_CONFIG2_ILIMIT_MSK			GENMASK(3, 1)
> +#define AD5758_DCDC_CONFIG2_ILIMIT_MODE(x)		(((x) & 0x7) << 1)
> +#define AD5758_DCDC_CONFIG2_ADC_CONTROL_DIAG_MSK	GENMASK(5, 4)
> +#define AD5758_DCDC_CONFIG2_ADC_CONTROL_DIAG_MODE(x)	(((x) & 0x3) << 4)
> +#define AD5758_DCDC_CONFIG2_VIOUT_PULLDOWN_EN_MSK	BIT(6)
> +#define AD5758_DCDC_CONFIG2_VIOUT_PULLDOWN_EN_MODE(x)	(((x) & 0x1) << 6)
> +#define AD5758_DCDC_CONFIG2_SHORT_DEGLITCH_MSK		BIT(7)
> +#define AD5758_DCDC_CONFIG2_SHORT_DEGLITCH_MODE(x)	(((x) & 0x1) << 7)
> +#define AD5758_DCDC_CONFIG2_READ_COMP_DIS_MSK		BIT(10)
> +#define AD5758_DCDC_CONFIG2_READ_COMP_DIS_MODE(x)	(((x) & 0x1) << 10)
> +#define AD5758_DCDC_CONFIG2_INTR_SAT_3WI_MSK		BIT(11)
> +#define AD5758_DCDC_CONFIG2_BUSY_3WI_MSK		BIT(12)
> +
> +/* AD5758_DIGITAL_DIAG_RESULTS */
> +#define AD5758_DIG_DIAG_RES_CAL_MEM_UNREFRESHED_MSK	BIT(15)
> +
> +#define AD5758_REG_WRITE(x)	(0x80 | ((x) & 0x1F))
> +
> +/* x^8 + x^2 + x^1 + x^0 */
> +#define AD5758_CRC8_POLY	0x07
> +
> +/**
> + * struct ad5758_state - driver instance specific data
> + * @spi:	spi_device
> + * @lock:	mutex lock
> + * @dc_dc_mode:	variable which stores the mode of operation
> + * @dc_dc_ilim:	variable which stores the dc-to-dc converter current limit
> + * @sr_config:	array which stores the slew rate settings
> + * @out_range:	variable which stores the output range
> + * @pwr_down:	variable which contains whether a channel is powered down or not
> + * @data:	spi transfer buffers
> + */
> +
> +struct ad5758_state {
> +	struct spi_device *spi;
> +	struct mutex lock;
> +	unsigned int dc_dc_mode;
> +	unsigned int dc_dc_ilim;
> +	unsigned int sr_config[3];
> +	unsigned int out_range;
> +	bool pwr_down;
> +
> +	/*
> +	 * DMA (thus cache coherency maintenance) requires the
> +	 * transfer buffers to live in their own cache lines.
> +	 */
> +
> +	union {
> +		__be32 d32;
> +		u8 d8[4];
I'm not seeing any cases where d8 needs to be used instead of
d32.  So I would drop the union as causing more confusion that
it is worth.

> +	} data[3] ____cacheline_aligned;
> +};
> +
> +enum ad5758_output_range {
> +	AD5758_RANGE_0V_5V,
> +	AD5758_RANGE_0V_10V,
> +	AD5758_RANGE_PLUSMINUS_5V,
> +	AD5758_RANGE_PLUSMINUS_10V,
> +	AD5758_RANGE_0mA_20mA = 8,
> +	AD5758_RANGE_0mA_24mA,
> +	AD5758_RANGE_4mA_24mA,
> +	AD5758_RANGE_PLUSMINUS_20mA,
> +	AD5758_RANGE_PLUSMINUS_24mA,
> +	AD5758_RANGE_MINUS_1mA_PLUS_22mA,
> +};
> +
> +enum ad5758_dc_dc_mode {
> +	AD5758_DCDC_MODE_POWER_OFF,
> +	AD5758_DCDC_MODE_DPC_CURRENT,
> +	AD5758_DCDC_MODE_DPC_VOLTAGE,
> +	AD5758_DCDC_MODE_PPC_CURRENT,
> +};
> +
> +struct ad5758_range {
> +	int reg;
> +	int min;
> +	int max;
> +};
> +
> +static const struct ad5758_range ad5758_min_max_table[] = {
> +	{ AD5758_RANGE_0V_5V, 0, 5000 },
> +	{ AD5758_RANGE_0V_10V, 0, 10000 },
> +	{ AD5758_RANGE_PLUSMINUS_5V, -5000, 5000 },
> +	{ AD5758_RANGE_PLUSMINUS_10V, -10000, 10000 },
> +	{ AD5758_RANGE_0mA_20mA, 0, 20},
> +	{ AD5758_RANGE_0mA_24mA, 0, 24 },
> +	{ AD5758_RANGE_4mA_24mA, 4, 24 },
> +	{ AD5758_RANGE_PLUSMINUS_20mA, -20, 20 },
> +	{ AD5758_RANGE_PLUSMINUS_24mA, -24, 24 },
> +	{ AD5758_RANGE_MINUS_1mA_PLUS_22mA, -1, 22 },
> +};
> +
> +static const int ad5758_slew_rate_clk[16] = {
> +	240000, 200000, 150000, 128000, 64000, 32000, 16000, 8000, 4000, 2000,
> +	1000, 512, 256, 128, 64, 16
> +};
> +
> +static const int ad5758_slew_rate_step[8] = {
> +	4, 12, 64, 120, 256, 500, 1820, 2048
> +};
> +
> +static const int ad5758_dc_dc_ilim[6] = {
> +	150, 200, 250, 300, 350, 400
> +};
> +
> +static int ad5758_spi_reg_read(struct ad5758_state *st, unsigned int addr)
> +{
> +	struct spi_transfer t[] = {
> +		{
> +			.tx_buf = &st->data[0].d8[0],
> +			.len = 4,
> +			.cs_change = 1,
> +		}, {
> +			.tx_buf = &st->data[1].d8[0],
> +			.rx_buf = &st->data[2].d8[0],
> +			.len = 4,
> +		},
> +	};
> +	int ret;
> +
> +	st->data[0].d32 = cpu_to_be32(
> +		(AD5758_REG_WRITE(AD5758_TWO_STAGE_READBACK_SELECT) << 24) |
> +		(addr << 8));
> +	st->data[1].d32 = cpu_to_be32(AD5758_REG_WRITE(AD5758_NOP) << 24);
> +
> +	ret = spi_sync_transfer(st->spi, t, ARRAY_SIZE(t));
> +	if (ret < 0)
> +		return ret;
> +
> +	return (be32_to_cpu(st->data[2].d32) >> 8) & 0xFFFF;
> +}
> +
> +static int ad5758_spi_reg_write(struct ad5758_state *st,
> +				unsigned int addr,
> +				unsigned int val)
> +{
> +	st->data[0].d32 = cpu_to_be32((AD5758_REG_WRITE(addr) << 24) |
> +				      ((val & 0xFFFF) << 8));
> +
> +	return spi_write(st->spi, &st->data[0].d32, sizeof(st->data[0].d32));
> +}
> +
> +static int ad5758_spi_write_mask(struct ad5758_state *st,
> +				 unsigned int addr,
> +				 unsigned long int mask,
> +				 unsigned int val)
> +{
> +	int regval;
> +
> +	regval = ad5758_spi_reg_read(st, addr);
> +	if (regval < 0) 	
> +		return regval;
> +
> +	regval &= ~mask;
> +	regval |= val;
> +
> +	return ad5758_spi_reg_write(st, addr, regval);
> +}
> +
> +static int ad5758_get_array_index(const int *array, unsigned int size, int val)
> +{
> +	int i;
> +
> +	for (i = 0; i < size; i++) {
> +		if (val == array[i])
> +			return i;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int ad5758_wait_for_task_complete(struct ad5758_state *st,
> +					 unsigned int reg,
> +					 unsigned int mask)
> +{
> +	unsigned int timeout;
> +	int ret;
> +
> +	timeout = 4;
> +	do {
> +		ret = ad5758_spi_reg_read(st, reg);
> +		if (ret < 0)
> +			return ret;
> +
> +		if (!(ret & mask))
> +			return 0;
> +
> +		mdelay(1);
> +	} while (--timeout);
> +
> +	dev_err(&st->spi->dev,
> +		"Error reading bit 0x%x in 0x%x register\n", mask, reg);
> +
> +	return -EIO;
> +}
> +
> +static int ad5758_calib_mem_refresh(struct ad5758_state *st)
> +{
> +	int ret;
> +
> +	ret = ad5758_spi_reg_write(st, AD5758_KEY,
> +				   AD5758_KEY_CODE_CALIB_MEM_REFRESH);
> +	if (ret < 0) {
> +		dev_err(&st->spi->dev,
> +			"Failed to initiate a calibration memory refresh\n");
> +		return ret;
> +	}
> +
> +	/* Wait to allow time for the internal calibrations to complete */
> +	return ad5758_wait_for_task_complete(st, AD5758_DIGITAL_DIAG_RESULTS,
> +				AD5758_DIG_DIAG_RES_CAL_MEM_UNREFRESHED_MSK);
> +}
> +
> +static int ad5758_soft_reset(struct ad5758_state *st)
> +{
> +	int ret;
> +
> +	ret = ad5758_spi_reg_write(st, AD5758_KEY, AD5758_KEY_CODE_RESET_1);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = ad5758_spi_reg_write(st, AD5758_KEY, AD5758_KEY_CODE_RESET_2);
> +
> +	mdelay(1);
> +
> +	return ret;
> +}
> +
> +static int ad5758_set_dc_dc_conv_mode(struct ad5758_state *st,
> +				      enum ad5758_dc_dc_mode mode)
> +{
> +	int ret;
> +
> +	ret = ad5758_spi_write_mask(st, AD5758_DCDC_CONFIG1,
> +				    AD5758_DCDC_CONFIG1_DCDC_MODE_MSK,
> +				    AD5758_DCDC_CONFIG1_DCDC_MODE_MODE(mode));
> +	if (ret < 0)
> +		return ret;
> +
> +	/*
> +	 * Poll the BUSY_3WI bit in the DCDC_CONFIG2 register until it is 0.
> +	 * This allows the 3-wire interface communication to complete.
> +	 */
> +	ret = ad5758_wait_for_task_complete(st, AD5758_DCDC_CONFIG2,
> +					    AD5758_DCDC_CONFIG2_BUSY_3WI_MSK);
> +	if (ret < 0)
> +		return ret;
> +
> +	st->dc_dc_mode = mode;
> +
> +	return ret;
> +}
> +
> +static int ad5758_set_dc_dc_ilim(struct ad5758_state *st, unsigned int ilim)
> +{
> +	int ret;
> +
> +	ret = ad5758_spi_write_mask(st, AD5758_DCDC_CONFIG2,
> +				    AD5758_DCDC_CONFIG2_ILIMIT_MSK,
> +				    AD5758_DCDC_CONFIG2_ILIMIT_MODE(ilim));
> +	if (ret < 0)
> +		return ret;
> +	/*
> +	 * Poll the BUSY_3WI bit in the DCDC_CONFIG2 register until it is 0.
> +	 * This allows the 3-wire interface communication to complete.
> +	 */
> +	return ad5758_wait_for_task_complete(st, AD5758_DCDC_CONFIG2,
> +					     AD5758_DCDC_CONFIG2_BUSY_3WI_MSK);
> +}
> +
> +static int ad5758_slew_rate_config(struct ad5758_state *st,
> +				   unsigned int enable,
> +				   unsigned int sr_clk,
> +				   unsigned int sr_step)
> +{
> +	unsigned int mode;
> +	unsigned long int mask;
> +	int ret;
> +
> +	mask = AD5758_DAC_CONFIG_SR_EN_MSK |
> +	       AD5758_DAC_CONFIG_SR_CLOCK_MSK |
> +	       AD5758_DAC_CONFIG_SR_STEP_MSK;
> +
> +	mode = AD5758_DAC_CONFIG_SR_EN_MODE(enable) |
> +		AD5758_DAC_CONFIG_SR_CLOCK_MODE(sr_clk) |
> +		AD5758_DAC_CONFIG_SR_STEP_MODE(sr_step);
> +
> +	ret = ad5758_spi_write_mask(st, AD5758_DAC_CONFIG, mask, mode);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Wait to allow time for the internal calibrations to complete */
> +	return ad5758_wait_for_task_complete(st, AD5758_DIGITAL_DIAG_RESULTS,
> +				AD5758_DIG_DIAG_RES_CAL_MEM_UNREFRESHED_MSK);
> +}
> +
> +static int ad5758_set_out_range(struct ad5758_state *st, unsigned int range)
> +{
> +	int ret;
> +
> +	ret = ad5758_spi_write_mask(st, AD5758_DAC_CONFIG,
> +				    AD5758_DAC_CONFIG_RANGE_MSK,
> +				    AD5758_DAC_CONFIG_RANGE_MODE(
> +					    ad5758_min_max_table[range].reg));
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Wait to allow time for the internal calibrations to complete */
> +	ret =  ad5758_wait_for_task_complete(st, AD5758_DIGITAL_DIAG_RESULTS,
> +				AD5758_DIG_DIAG_RES_CAL_MEM_UNREFRESHED_MSK);
> +	if (ret < 0)
> +		return ret;
> +
> +	st->out_range = range;
> +
> +	return ret;
> +}
> +
> +static int ad5758_fault_prot_switch_en(struct ad5758_state *st, bool enable)
> +{
> +	int ret;
> +
> +	ret = ad5758_spi_write_mask(st, AD5758_DCDC_CONFIG1,
> +			AD5758_DCDC_CONFIG1_FAULT_PROT_SW_EN_MSK,
> +			AD5758_DCDC_CONFIG1_FAULT_PROT_SW_EN_MODE(enable));
> +	if (ret < 0)
> +		return ret;
> +	/*
> +	 * Poll the BUSY_3WI bit in the DCDC_CONFIG2 register until it is 0.
> +	 * This allows the 3-wire interface communication to complete.
> +	 */
> +	return ad5758_wait_for_task_complete(st, AD5758_DCDC_CONFIG2,
> +					     AD5758_DCDC_CONFIG2_BUSY_3WI_MSK);
> +}
> +
> +static int ad5758_internal_buffers_en(struct ad5758_state *st, bool enable)
> +{
> +	int ret;
> +
> +	ret = ad5758_spi_write_mask(st, AD5758_DAC_CONFIG,
> +				    AD5758_DAC_CONFIG_INT_EN_MSK,
> +				    AD5758_DAC_CONFIG_INT_EN_MODE(enable));
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Wait to allow time for the internal calibrations to complete */
> +	return ad5758_wait_for_task_complete(st, AD5758_DIGITAL_DIAG_RESULTS,
> +				AD5758_DIG_DIAG_RES_CAL_MEM_UNREFRESHED_MSK);
> +}
> +
> +static int ad5758_reg_access(struct iio_dev *indio_dev,
> +			     unsigned int reg,
> +			     unsigned int writeval,
> +			     unsigned int *readval)
> +{
> +	struct ad5758_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	mutex_lock(&st->lock);
> +	if (readval == NULL) {
> +		ret =  ad5758_spi_reg_write(st, reg, writeval);
> +	} else {
> +		ret = ad5758_spi_reg_read(st, reg);
> +		if (ret < 0) {
> +			mutex_unlock(&st->lock);
> +			return ret;
> +		}
> +
> +		*readval = ret;
> +		ret = 0;
> +	}
> +	mutex_unlock(&st->lock);
> +
> +	return ret;
> +}
> +
> +static int ad5758_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan,
> +			   int *val, int *val2, long info)
> +{
> +	struct ad5758_state *st = iio_priv(indio_dev);
> +	int max, min, ret;
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_RAW:
> +		mutex_lock(&st->lock);
> +		ret = ad5758_spi_reg_read(st, AD5758_DAC_INPUT);
> +		mutex_unlock(&st->lock);
> +		if (ret < 0)
> +			return ret;
> +
> +		*val = ret;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		min = ad5758_min_max_table[st->out_range].min;
> +		max = ad5758_min_max_table[st->out_range].max;

No offset?  Given ranges aren't all 'central' about 0, I'd expect one
to be needed.

> +		*val = max - min;
> +		*val2 = chan->scan_type.realbits;
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad5758_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int val, int val2, long info)
> +{
> +	struct ad5758_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_RAW:
> +		mutex_lock(&st->lock);
> +		ret = ad5758_spi_reg_write(st, AD5758_DAC_INPUT, val);
> +		mutex_unlock(&st->lock);
> +		return ret;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static ssize_t ad5758_read_powerdown(struct iio_dev *indio_dev,
> +				     uintptr_t priv,
> +				     const struct iio_chan_spec *chan,
> +				     char *buf)
> +{
> +	struct ad5758_state *st = iio_priv(indio_dev);
> +
> +	return sprintf(buf, "%d\n", st->pwr_down);
> +}
> +
> +static ssize_t ad5758_write_powerdown(struct iio_dev *indio_dev,
> +				      uintptr_t priv,
> +				      struct iio_chan_spec const *chan,
> +				      const char *buf, size_t len)
> +{
> +	struct ad5758_state *st = iio_priv(indio_dev);
> +	bool pwr_down;
> +	unsigned int dcdc_config1_mode, dc_dc_mode, dac_config_mode, val;
> +	unsigned long int dcdc_config1_msk, dac_config_msk;
> +	int ret;
> +
> +	ret = strtobool(buf, &pwr_down);
> +	if (ret)
> +		return ret;
> +
> +	mutex_lock(&st->lock);
> +	if (pwr_down) {
> +		dc_dc_mode = AD5758_DCDC_MODE_POWER_OFF;
> +		val = 0;
> +	} else {
> +		dc_dc_mode = st->dc_dc_mode;
> +		val = 1;
> +	}
> +
> +	dcdc_config1_mode = (AD5758_DCDC_CONFIG1_DCDC_MODE_MODE(dc_dc_mode) |
> +			     AD5758_DCDC_CONFIG1_FAULT_PROT_SW_EN_MODE(val));
> +	dcdc_config1_msk = (AD5758_DCDC_CONFIG1_DCDC_MODE_MSK |
> +			    AD5758_DCDC_CONFIG1_FAULT_PROT_SW_EN_MSK);
> +
> +	ret = ad5758_spi_write_mask(st, AD5758_DCDC_CONFIG1,
> +				    dcdc_config1_msk,
> +				    dcdc_config1_mode);
> +	if (ret < 0)
> +		goto err_unlock;
> +
> +	dac_config_mode = (AD5758_DAC_CONFIG_OUT_EN_MODE(val) |
> +			   AD5758_DAC_CONFIG_INT_EN_MODE(val));
> +	dac_config_msk =  (AD5758_DAC_CONFIG_OUT_EN_MSK |
> +			   AD5758_DAC_CONFIG_INT_EN_MSK);
> +
> +	ret = ad5758_spi_write_mask(st, AD5758_DAC_CONFIG,
> +				    dac_config_msk,
> +				    dac_config_mode);
> +	if (ret < 0)
> +		goto err_unlock;
> +
> +	st->pwr_down = pwr_down;
> +
> +err_unlock:
> +	mutex_unlock(&st->lock);
> +
> +	return ret ? ret : len;
> +}
> +
> +static const struct iio_info ad5758_info = {
> +	.read_raw = ad5758_read_raw,
> +	.write_raw = ad5758_write_raw,
> +	.debugfs_reg_access = &ad5758_reg_access,
> +};
> +
> +static const struct iio_chan_spec_ext_info ad5758_ext_info[] = {
> +	{
> +		.name = "powerdown",
> +		.read = ad5758_read_powerdown,
> +		.write = ad5758_write_powerdown,
> +		.shared = IIO_SEPARATE,
> +	},
> +	{ },
> +};
> +
> +static const struct iio_chan_spec ad5758_channels[] = {
> +	{
> +		.type = IIO_VOLTAGE,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
> +		.indexed = 1,
> +		.output = 1,
> +		.ext_info = ad5758_ext_info,
> +	},
> +};
> +
> +static int ad5758_crc_disable(struct ad5758_state *st)
> +{
> +	st->data[0].d32 =
> +		cpu_to_be32(
> +		(AD5758_REG_WRITE(AD5758_DIGITAL_DIAG_CONFIG) << 24) | 0x5C3A);
> +
> +	return spi_write(st->spi, &st->data[0].d8[0], 4);
> +}
> +
> +static void ad5758_parse_dt(struct ad5758_state *st)
> +{
> +	unsigned int i, tmp, tmparray[3];
> +	int index;
> +
> +	st->dc_dc_ilim = 150;
> +	if (!device_property_read_u32(&st->spi->dev,
> +				      "adi,dc-dc-ilim", &tmp)) {
> +		index = ad5758_get_array_index(ad5758_dc_dc_ilim,
> +					ARRAY_SIZE(ad5758_dc_dc_ilim), tmp);
> +		if (index < 0)
> +			dev_warn(&st->spi->dev,
> +				 "dc-dc-ilim out of range, using 150mA\n");
> +		else
> +			st->dc_dc_ilim = index;
> +	} else {
> +		dev_dbg(&st->spi->dev,
> +			 "Missing \"dc-dc-ilim\" property, using 150mA\n");
> +	}
> +
> +	st->dc_dc_mode = AD5758_DCDC_MODE_DPC_VOLTAGE;
> +	if (device_property_read_u32(&st->spi->dev, "adi,dc-dc-mode",
> +				     &st->dc_dc_mode))
> +		dev_dbg(&st->spi->dev,
> +			"Missing \"dc-dc-mode\" property, using DPC_VOLTAGE\n");

Again, I'm not 100% sure that's safe for all circuits.  I would error out
and not enable the device.  This doesn't feel like an optional parameter
to me!

> +
> +	/* 0 V to 5 V voltage range */
> +	st->out_range = 0;
> +	if (!device_property_read_u32(&st->spi->dev, "adi,range", &tmp)) {
> +		for (i = 0; i < ARRAY_SIZE(ad5758_min_max_table); i++) {
> +			if (tmp == ad5758_min_max_table[i].reg) {
> +				st->out_range = i;
> +				break;
> +			}
> +		}
> +
> +		if (i == ARRAY_SIZE(ad5758_min_max_table))
> +			dev_warn(&st->spi->dev,
> +				 "range invalid, using 0V to 5V\n");

Error out.  Should not be turning the device on if we have invalid
config coming from DT.  Better to never enable it and have no risk.

once you've done that set the default in the else.

Actually my gut feeling for this device is it makes no sense to have
a default for this.  It changes over such a wide range that people should
always have specified what they wanted.  Make it non optional.

> +	} else {
> +		dev_dbg(&st->spi->dev,
> +			"Missing \"range\" property, using 0V to 5V\n");
> +	}
> +
> +	st->sr_config[0] = 1;
> +	st->sr_config[1] = 16000;
> +	st->sr_config[2] = 4;

Given you have a perfectly good else below for the error print,
why not move these defaults in there?  Seems like slightly simpler logical
flow.

> +	if (!device_property_read_u32_array(&st->spi->dev, "adi,slew",
> +					    tmparray, 3)) {
> +		st->sr_config[0] = tmparray[0];
> +
> +		index = ad5758_get_array_index(ad5758_slew_rate_clk,
> +					       ARRAY_SIZE(ad5758_slew_rate_clk),
> +					       tmparray[1]);
> +
> +		if (index < 0)
> +			dev_warn(&st->spi->dev,
> +				"slew rate clock out of range, using 16kHz\n");

I would error out.  If someone has set a slew rate deliberately and you have
ended up with an invalid option, you really don't want to turn the DAC on.

> +		else
> +			st->sr_config[1] = index;
> +
> +		index = ad5758_get_array_index(ad5758_slew_rate_step,
> +					ARRAY_SIZE(ad5758_slew_rate_step),
> +					tmparray[2]);
> +
> +		if (index < 0)
> +			dev_warn(&st->spi->dev,
> +				"slew rate step out of range, using 4 LSB\n");
> +		else
> +			st->sr_config[2] = index;
> +	} else {
> +		dev_dbg(&st->spi->dev,
> +			 "Missing \"slew\" property, using 16kHz and 4 LSB\n");

I'd go with off as the more obvious default choice if it's not specified.

> +	}
> +}
> +
> +static int ad5758_init(struct ad5758_state *st)
> +{
> +	int regval, ret;
> +
> +	ad5758_parse_dt(st);
> +
> +	/* Disable CRC checks */
> +	ret = ad5758_crc_disable(st);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Perform a software reset */
> +	ret = ad5758_soft_reset(st);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Disable CRC checks */

I would add a todo to the comments at the top of the driver as
a means of making it clear that we don't use CRC currently in the
driver.

> +	ret = ad5758_crc_disable(st);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Perform a calibration memory refresh */
> +	ret = ad5758_calib_mem_refresh(st);
> +	if (ret < 0)
> +		return ret;
> +
> +	regval = ad5758_spi_reg_read(st, AD5758_DIGITAL_DIAG_RESULTS);
> +	if (regval < 0)
> +		return regval;
> +
> +	/* Clear all the error flags */
> +	ret = ad5758_spi_reg_write(st, AD5758_DIGITAL_DIAG_RESULTS, regval);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Set the dc-to-dc current limit */
> +	ret = ad5758_set_dc_dc_ilim(st, st->dc_dc_ilim);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Configure the dc-to-dc controller mode */
> +	ret = ad5758_set_dc_dc_conv_mode(st, st->dc_dc_mode);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Configure the output range */
> +	ret = ad5758_set_out_range(st, st->out_range);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Enable Slew Rate Control, set the slew rate clock and step */
> +	ret = ad5758_slew_rate_config(st, st->sr_config[0],
> +				      st->sr_config[1], st->sr_config[2]);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Enable the VIOUT fault protection switch (FPS is closed) */
> +	ret = ad5758_fault_prot_switch_en(st, 1);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Power up the DAC and internal (INT) amplifiers */
> +	ret = ad5758_internal_buffers_en(st, 1);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Enable VIOUT */
> +	return ad5758_spi_write_mask(st, AD5758_DAC_CONFIG,
> +				     AD5758_DAC_CONFIG_OUT_EN_MSK,
> +				     AD5758_DAC_CONFIG_OUT_EN_MODE(1));
> +}
> +
> +static int ad5758_probe(struct spi_device *spi)
> +{
> +	struct ad5758_state *st;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +	spi_set_drvdata(spi, indio_dev);
> +
> +	st->spi = spi;
> +
> +	indio_dev->dev.parent = &spi->dev;
> +	indio_dev->name = spi_get_device_id(spi)->name;
> +	indio_dev->info = &ad5758_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = ad5758_channels;

This surprised me.  Looked from the DT bindings like this was
a DAC that could also be a current output DAC. I was expecting
to see a decision made based on the DT here.
So pick between two different channel arrays.

> +	indio_dev->num_channels = ARRAY_SIZE(ad5758_channels);
> +
> +	mutex_init(&st->lock);
> +
> +	ret = ad5758_init(st);
> +	if (ret < 0) {
> +		dev_err(&spi->dev, "AD5758 init failed\n");
> +		return ret;
> +	}
> +
> +	return devm_iio_device_register(&st->spi->dev, indio_dev);
> +}
> +
> +static const struct spi_device_id ad5758_id[] = {
> +	{ "ad5758", 0 },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(spi, ad5758_id);
> +
> +static struct spi_driver ad5758_driver = {
> +	.driver = {
> +		.name = KBUILD_MODNAME,
> +	},
> +	.probe = ad5758_probe,
> +	.id_table = ad5758_id,
> +};
> +
> +module_spi_driver(ad5758_driver);
> +
> +MODULE_AUTHOR("Stefan Popa <stefan.popa@analog.com>");
> +MODULE_DESCRIPTION("Analog Devices AD5758 DAC");
> +MODULE_LICENSE("GPL v2");
