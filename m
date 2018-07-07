Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD0E5C6778F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 17:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 588E021528
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 17:21:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="P6L26rpg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 588E021528
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932824AbeGGRV0 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 13:21:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:34256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932692AbeGGRVY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 13:21:24 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DFCB2154F;
        Sat,  7 Jul 2018 17:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530984084;
        bh=JFNJuSV+BqruWs6EgOOfLVCvmC7Qpza4k2GH+8L9LZY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=P6L26rpgMZUX6lUCCLjTeX/3Fi9sa4eVmHisozukT4Odp6JxbZlYTZwr4B/20VT6j
         pTLCyH0PwrkCeLN9vkpnGvLvXtZ9zFwK1297tHpMX0WpAu76rJVecumY0KJaYMz6Ui
         LtW5iaJHYMv8veamnvrT8rVpg82bgZYsy+Iom7Rs=
Date:   Sat, 7 Jul 2018 18:21:17 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stefan Popa <stefan.popa@analog.com>
Cc:     <Michael.Hennerich@analog.com>, <lars@metafoo.de>,
        <knaack.h@gmx.de>, <pmeerw@pmeerw.net>, <mchehab@kernel.org>,
        <davem@davemloft.net>, <gregkh@linuxfoundation.org>,
        <akpm@linux-foundation.org>, <linus.walleij@linaro.org>,
        <rdunlap@infradead.org>, <lukas@wunner.de>,
        <Ismail.Kose@maximintegrated.com>, <vilhelm.gray@gmail.com>,
        <sean.nyekjaer@prevas.dk>, <pombredanne@nexb.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/2] iio: dac: Add AD5758 support
Message-ID: <20180707182117.7a56985d@archlinux>
In-Reply-To: <1530714723-18835-1-git-send-email-stefan.popa@analog.com>
References: <1530714723-18835-1-git-send-email-stefan.popa@analog.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Jul 2018 17:32:03 +0300
Stefan Popa <stefan.popa@analog.com> wrote:

> The AD5758 is a single channel DAC with 16-bit precision which uses the
> SPI interface that operates at clock rates up to 50MHz.
>=20
> The output can be configured as voltage or current and is available on a
> single terminal.
>=20
> Datasheet:
> http://www.analog.com/media/en/technical-documentation/data-sheets/ad5758=
.pdf
>=20
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>

Very nice!

Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to play with it.

Thanks,

Jonathan

> ---
> Changes in v5:
> 	- changed the handling choice of voltage vs current by picking
> 	  between two constant structs.
> 	- returned ad5758_wait_for_task_complete() directly where possible.
> 	- fixed double spaces and removed unnecessary parentheses.
> 	- kept the includes in alphabetical order and removed asm/div64.h.
> 	- used usleep_range() instead of udelay().
> 	- removed unnecessary casting when calling bsearch().
> Changes in v4:
> 	- fixed kbuild test robot warnings.
> Changes in v3:
> 	- AD5758 can be both a current and voltage output DAC. The
> 	  decision is made based on the DT and the channel type is set
> 	  during probe.
> 	- dc-dc-mode, range-microvolt and range-microamp are required
> 	  properties.
> 	- Introduced a slew-time-us property from which slew rate clock
> 	  and slew rate step are calculated using a best match algorithm.
> 	- Dropped the union from ad5758_state struct.
> 	- Introduced a IIO_CHAN_INFO_OFFSET case part of ad5758_read_raw().
> 	- Added a TODO comment which specifies that CRC is not supported.
> 	- Kept the includes in order and removed the unused ones.
> 	- Removed unused macros and shortened the lengthy ones.
> 	- Renamed AD5758_REG_WRITE to AD5758_WR_FLAG_MSK.
> 	- Added an explanation for enum ad5758_output_range.
> 	- Used bsearch() instead of ad5758_get_array_index().
> 	- Reduced the delays.
> 	- strtobool() -> kstrtobool().
>=20
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
>=20
>  MAINTAINERS              |   7 +
>  drivers/iio/dac/Kconfig  |  10 +
>  drivers/iio/dac/Makefile |   1 +
>  drivers/iio/dac/ad5758.c | 897 +++++++++++++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 915 insertions(+)
>  create mode 100644 drivers/iio/dac/ad5758.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 00e9670..12d102d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -796,6 +796,13 @@ M:	Michael Hanselmann <linux-kernel@hansmi.ch>
>  S:	Supported
>  F:	drivers/macintosh/ams/
> =20
> +ANALOG DEVICES INC AD5758 DRIVER
> +M:	Stefan Popa <stefan.popa@analog.com>
> +L:	linux-iio@vger.kernel.org
> +W:	http://ez.analog.com/community/linux-device-drivers
> +S:	Supported
> +F:	drivers/iio/dac/ad5758.c
> +
>  ANALOG DEVICES INC AD5686 DRIVER
>  M:	Stefan Popa <stefan.popa@analog.com>
>  L:	linux-pm@vger.kernel.org
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index 06e90de..80beb64 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -167,6 +167,16 @@ config AD5755
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called ad5755.
> =20
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
> index 57aa230..a1b37cf 100644
> --- a/drivers/iio/dac/Makefile
> +++ b/drivers/iio/dac/Makefile
> @@ -16,6 +16,7 @@ obj-$(CONFIG_AD5592R_BASE) +=3D ad5592r-base.o
>  obj-$(CONFIG_AD5592R) +=3D ad5592r.o
>  obj-$(CONFIG_AD5593R) +=3D ad5593r.o
>  obj-$(CONFIG_AD5755) +=3D ad5755.o
> +obj-$(CONFIG_AD5755) +=3D ad5758.o
>  obj-$(CONFIG_AD5761) +=3D ad5761.o
>  obj-$(CONFIG_AD5764) +=3D ad5764.o
>  obj-$(CONFIG_AD5791) +=3D ad5791.o
> diff --git a/drivers/iio/dac/ad5758.c b/drivers/iio/dac/ad5758.c
> new file mode 100644
> index 0000000..bd36333
> --- /dev/null
> +++ b/drivers/iio/dac/ad5758.c
> @@ -0,0 +1,897 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * AD5758 Digital to analog converters driver
> + *
> + * Copyright 2018 Analog Devices Inc.
> + *
> + * TODO: Currently CRC is not supported in this driver
> + */
> +#include <linux/bsearch.h>
> +#include <linux/delay.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/property.h>
> +#include <linux/spi/spi.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +
> +/* AD5758 registers definition */
> +#define AD5758_NOP				0x00
> +#define AD5758_DAC_INPUT			0x01
> +#define AD5758_DAC_OUTPUT			0x02
> +#define AD5758_CLEAR_CODE			0x03
> +#define AD5758_USER_GAIN			0x04
> +#define AD5758_USER_OFFSET			0x05
> +#define AD5758_DAC_CONFIG			0x06
> +#define AD5758_SW_LDAC				0x07
> +#define AD5758_KEY				0x08
> +#define AD5758_GP_CONFIG1			0x09
> +#define AD5758_GP_CONFIG2			0x0A
> +#define AD5758_DCDC_CONFIG1			0x0B
> +#define AD5758_DCDC_CONFIG2			0x0C
> +#define AD5758_WDT_CONFIG			0x0F
> +#define AD5758_DIGITAL_DIAG_CONFIG		0x10
> +#define AD5758_ADC_CONFIG			0x11
> +#define AD5758_FAULT_PIN_CONFIG			0x12
> +#define AD5758_TWO_STAGE_READBACK_SELECT	0x13
> +#define AD5758_DIGITAL_DIAG_RESULTS		0x14
> +#define AD5758_ANALOG_DIAG_RESULTS		0x15
> +#define AD5758_STATUS				0x16
> +#define AD5758_CHIP_ID				0x17
> +#define AD5758_FREQ_MONITOR			0x18
> +#define AD5758_DEVICE_ID_0			0x19
> +#define AD5758_DEVICE_ID_1			0x1A
> +#define AD5758_DEVICE_ID_2			0x1B
> +#define AD5758_DEVICE_ID_3			0x1C
> +
> +/* AD5758_DAC_CONFIG */
> +#define AD5758_DAC_CONFIG_RANGE_MSK		GENMASK(3, 0)
> +#define AD5758_DAC_CONFIG_RANGE_MODE(x)		(((x) & 0xF) << 0)
> +#define AD5758_DAC_CONFIG_INT_EN_MSK		BIT(5)
> +#define AD5758_DAC_CONFIG_INT_EN_MODE(x)	(((x) & 0x1) << 5)
> +#define AD5758_DAC_CONFIG_OUT_EN_MSK		BIT(6)
> +#define AD5758_DAC_CONFIG_OUT_EN_MODE(x)	(((x) & 0x1) << 6)
> +#define AD5758_DAC_CONFIG_SR_EN_MSK		BIT(8)
> +#define AD5758_DAC_CONFIG_SR_EN_MODE(x)		(((x) & 0x1) << 8)
> +#define AD5758_DAC_CONFIG_SR_CLOCK_MSK		GENMASK(12, 9)
> +#define AD5758_DAC_CONFIG_SR_CLOCK_MODE(x)	(((x) & 0xF) << 9)
> +#define AD5758_DAC_CONFIG_SR_STEP_MSK		GENMASK(15, 13)
> +#define AD5758_DAC_CONFIG_SR_STEP_MODE(x)	(((x) & 0x7) << 13)
> +
> +/* AD5758_KEY */
> +#define AD5758_KEY_CODE_RESET_1			0x15FA
> +#define AD5758_KEY_CODE_RESET_2			0xAF51
> +#define AD5758_KEY_CODE_SINGLE_ADC_CONV		0x1ADC
> +#define AD5758_KEY_CODE_RESET_WDT		0x0D06
> +#define AD5758_KEY_CODE_CALIB_MEM_REFRESH	0xFCBA
> +
> +/* AD5758_DCDC_CONFIG1 */
> +#define AD5758_DCDC_CONFIG1_DCDC_VPROG_MSK	GENMASK(4, 0)
> +#define AD5758_DCDC_CONFIG1_DCDC_VPROG_MODE(x)	(((x) & 0x1F) << 0)
> +#define AD5758_DCDC_CONFIG1_DCDC_MODE_MSK	GENMASK(6, 5)
> +#define AD5758_DCDC_CONFIG1_DCDC_MODE_MODE(x)	(((x) & 0x3) << 5)
> +#define AD5758_DCDC_CONFIG1_PROT_SW_EN_MSK	BIT(7)
> +#define AD5758_DCDC_CONFIG1_PROT_SW_EN_MODE(x)	(((x) & 0x1) << 7)
> +
> +/* AD5758_DCDC_CONFIG2 */
> +#define AD5758_DCDC_CONFIG2_ILIMIT_MSK		GENMASK(3, 1)
> +#define AD5758_DCDC_CONFIG2_ILIMIT_MODE(x)	(((x) & 0x7) << 1)
> +#define AD5758_DCDC_CONFIG2_INTR_SAT_3WI_MSK	BIT(11)
> +#define AD5758_DCDC_CONFIG2_BUSY_3WI_MSK	BIT(12)
> +
> +/* AD5758_DIGITAL_DIAG_RESULTS */
> +#define AD5758_CAL_MEM_UNREFRESHED_MSK		BIT(15)
> +
> +#define AD5758_WR_FLAG_MSK(x)		(0x80 | ((x) & 0x1F))
> +
> +#define AD5758_FULL_SCALE_MICRO	65535000000ULL
> +
> +/**
> + * struct ad5758_state - driver instance specific data
> + * @spi:	spi_device
> + * @lock:	mutex lock
> + * @out_range:	struct which stores the output range
> + * @dc_dc_mode:	variable which stores the mode of operation
> + * @dc_dc_ilim:	variable which stores the dc-to-dc converter current lim=
it
> + * @slew_time:	variable which stores the target slew time
> + * @pwr_down:	variable which contains whether a channel is powered down =
or not
> + * @data:	spi transfer buffers
> + */
> +
> +struct ad5758_range {
> +	int reg;
> +	int min;
> +	int max;
> +};
> +
> +struct ad5758_state {
> +	struct spi_device *spi;
> +	struct mutex lock;
> +	struct ad5758_range out_range;
> +	unsigned int dc_dc_mode;
> +	unsigned int dc_dc_ilim;
> +	unsigned int slew_time;
> +	bool pwr_down;
> +	__be32 d32[3];
> +};
> +
> +/**
> + * Output ranges corresponding to bits [3:0] from DAC_CONFIG register
> + * 0000: 0 V to 5 V voltage range
> + * 0001: 0 V to 10 V voltage range
> + * 0010: =C2=B15 V voltage range
> + * 0011: =C2=B110 V voltage range
> + * 1000: 0 mA to 20 mA current range
> + * 1001: 0 mA to 24 mA current range
> + * 1010: 4 mA to 20 mA current range
> + * 1011: =C2=B120 mA current range
> + * 1100: =C2=B124 mA current range
> + * 1101: -1 mA to +22 mA current range
> + */
> +enum ad5758_output_range {
> +	AD5758_RANGE_0V_5V,
> +	AD5758_RANGE_0V_10V,
> +	AD5758_RANGE_PLUSMINUS_5V,
> +	AD5758_RANGE_PLUSMINUS_10V,
> +	AD5758_RANGE_0mA_20mA =3D 8,
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
> +static const struct ad5758_range ad5758_voltage_range[] =3D {
> +	{ AD5758_RANGE_0V_5V, 0, 5000000 },
> +	{ AD5758_RANGE_0V_10V, 0, 10000000 },
> +	{ AD5758_RANGE_PLUSMINUS_5V, -5000000, 5000000 },
> +	{ AD5758_RANGE_PLUSMINUS_10V, -10000000, 10000000 }
> +};
> +
> +static const struct ad5758_range ad5758_current_range[] =3D {
> +	{ AD5758_RANGE_0mA_20mA, 0, 20000},
> +	{ AD5758_RANGE_0mA_24mA, 0, 24000 },
> +	{ AD5758_RANGE_4mA_24mA, 4, 24000 },
> +	{ AD5758_RANGE_PLUSMINUS_20mA, -20000, 20000 },
> +	{ AD5758_RANGE_PLUSMINUS_24mA, -24000, 24000 },
> +	{ AD5758_RANGE_MINUS_1mA_PLUS_22mA, -1000, 22000 },
> +};
> +
> +static const int ad5758_sr_clk[16] =3D {
> +	240000, 200000, 150000, 128000, 64000, 32000, 16000, 8000, 4000, 2000,
> +	1000, 512, 256, 128, 64, 16
> +};
> +
> +static const int ad5758_sr_step[8] =3D {
> +	4, 12, 64, 120, 256, 500, 1820, 2048
> +};
> +
> +static const int ad5758_dc_dc_ilim[6] =3D {
> +	150000, 200000, 250000, 300000, 350000, 400000
> +};
> +
> +static int ad5758_spi_reg_read(struct ad5758_state *st, unsigned int add=
r)
> +{
> +	struct spi_transfer t[] =3D {
> +		{
> +			.tx_buf =3D &st->d32[0],
> +			.len =3D 4,
> +			.cs_change =3D 1,
> +		}, {
> +			.tx_buf =3D &st->d32[1],
> +			.rx_buf =3D &st->d32[2],
> +			.len =3D 4,
> +		},
> +	};
> +	int ret;
> +
> +	st->d32[0] =3D cpu_to_be32(
> +		(AD5758_WR_FLAG_MSK(AD5758_TWO_STAGE_READBACK_SELECT) << 24) |
> +		(addr << 8));
> +	st->d32[1] =3D cpu_to_be32(AD5758_WR_FLAG_MSK(AD5758_NOP) << 24);
> +
> +	ret =3D spi_sync_transfer(st->spi, t, ARRAY_SIZE(t));
> +	if (ret < 0)
> +		return ret;
> +
> +	return (be32_to_cpu(st->d32[2]) >> 8) & 0xFFFF;
> +}
> +
> +static int ad5758_spi_reg_write(struct ad5758_state *st,
> +				unsigned int addr,
> +				unsigned int val)
> +{
> +	st->d32[0] =3D cpu_to_be32((AD5758_WR_FLAG_MSK(addr) << 24) |
> +				 ((val & 0xFFFF) << 8));
> +
> +	return spi_write(st->spi, &st->d32[0], sizeof(st->d32[0]));
> +}
> +
> +static int ad5758_spi_write_mask(struct ad5758_state *st,
> +				 unsigned int addr,
> +				 unsigned long int mask,
> +				 unsigned int val)
> +{
> +	int regval;
> +
> +	regval =3D ad5758_spi_reg_read(st, addr);
> +	if (regval < 0)
> +		return regval;
> +
> +	regval &=3D ~mask;
> +	regval |=3D val;
> +
> +	return ad5758_spi_reg_write(st, addr, regval);
> +}
> +
> +static int cmpfunc(const void *a, const void *b)
> +{
> +	return *(int *)a - *(int *)b;
> +}
> +
> +static int ad5758_find_closest_match(const int *array,
> +				     unsigned int size, int val)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < size; i++) {
> +		if (val <=3D array[i])
> +			return i;
> +	}
> +
> +	return size - 1;
> +}
> +
> +static int ad5758_wait_for_task_complete(struct ad5758_state *st,
> +					 unsigned int reg,
> +					 unsigned int mask)
> +{
> +	unsigned int timeout;
> +	int ret;
> +
> +	timeout =3D 10;
> +	do {
> +		ret =3D ad5758_spi_reg_read(st, reg);
> +		if (ret < 0)
> +			return ret;
> +
> +		if (!(ret & mask))
> +			return 0;
> +
> +		usleep_range(100, 1000);
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
> +	ret =3D ad5758_spi_reg_write(st, AD5758_KEY,
> +				   AD5758_KEY_CODE_CALIB_MEM_REFRESH);
> +	if (ret < 0) {
> +		dev_err(&st->spi->dev,
> +			"Failed to initiate a calibration memory refresh\n");
> +		return ret;
> +	}
> +
> +	/* Wait to allow time for the internal calibrations to complete */
> +	return ad5758_wait_for_task_complete(st, AD5758_DIGITAL_DIAG_RESULTS,
> +					     AD5758_CAL_MEM_UNREFRESHED_MSK);
> +}
> +
> +static int ad5758_soft_reset(struct ad5758_state *st)
> +{
> +	int ret;
> +
> +	ret =3D ad5758_spi_reg_write(st, AD5758_KEY, AD5758_KEY_CODE_RESET_1);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D ad5758_spi_reg_write(st, AD5758_KEY, AD5758_KEY_CODE_RESET_2);
> +
> +	/* Perform a software reset and wait at least 100us */
> +	usleep_range(100, 1000);
> +
> +	return ret;
> +}
> +
> +static int ad5758_set_dc_dc_conv_mode(struct ad5758_state *st,
> +				      enum ad5758_dc_dc_mode mode)
> +{
> +	int ret;
> +
> +	ret =3D ad5758_spi_write_mask(st, AD5758_DCDC_CONFIG1,
> +				    AD5758_DCDC_CONFIG1_DCDC_MODE_MSK,
> +				    AD5758_DCDC_CONFIG1_DCDC_MODE_MODE(mode));
> +	if (ret < 0)
> +		return ret;
> +
> +	/*
> +	 * Poll the BUSY_3WI bit in the DCDC_CONFIG2 register until it is 0.
> +	 * This allows the 3-wire interface communication to complete.
> +	 */
> +	ret =3D ad5758_wait_for_task_complete(st, AD5758_DCDC_CONFIG2,
> +					    AD5758_DCDC_CONFIG2_BUSY_3WI_MSK);
> +	if (ret < 0)
> +		return ret;
> +
> +	st->dc_dc_mode =3D mode;
> +
> +	return ret;
> +}
> +
> +static int ad5758_set_dc_dc_ilim(struct ad5758_state *st, unsigned int i=
lim)
> +{
> +	int ret;
> +
> +	ret =3D ad5758_spi_write_mask(st, AD5758_DCDC_CONFIG2,
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
> +static int ad5758_slew_rate_set(struct ad5758_state *st,
> +				unsigned int sr_clk_idx,
> +				unsigned int sr_step_idx)
> +{
> +	unsigned int mode;
> +	unsigned long int mask;
> +	int ret;
> +
> +	mask =3D AD5758_DAC_CONFIG_SR_EN_MSK |
> +	       AD5758_DAC_CONFIG_SR_CLOCK_MSK |
> +	       AD5758_DAC_CONFIG_SR_STEP_MSK;
> +	mode =3D AD5758_DAC_CONFIG_SR_EN_MODE(1) |
> +	       AD5758_DAC_CONFIG_SR_STEP_MODE(sr_step_idx) |
> +	       AD5758_DAC_CONFIG_SR_CLOCK_MODE(sr_clk_idx);
> +
> +	ret =3D ad5758_spi_write_mask(st, AD5758_DAC_CONFIG, mask, mode);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Wait to allow time for the internal calibrations to complete */
> +	return ad5758_wait_for_task_complete(st, AD5758_DIGITAL_DIAG_RESULTS,
> +					     AD5758_CAL_MEM_UNREFRESHED_MSK);
> +}
> +
> +static int ad5758_slew_rate_config(struct ad5758_state *st)
> +{
> +	unsigned int sr_clk_idx, sr_step_idx;
> +	int i, res;
> +	s64 diff_new, diff_old;
> +	u64 sr_step, calc_slew_time;
> +
> +	sr_clk_idx =3D 0;
> +	sr_step_idx =3D 0;
> +	diff_old =3D S64_MAX;
> +	/*
> +	 * The slew time can be determined by using the formula:
> +	 * Slew Time =3D (Full Scale Out / (Step Size x Update Clk Freq))
> +	 * where Slew time is expressed in microseconds
> +	 * Given the desired slew time, the following algorithm determines the
> +	 * best match for the step size and the update clock frequency.
> +	 */
> +	for (i =3D 0; i < ARRAY_SIZE(ad5758_sr_clk); i++) {
> +		/*
> +		 * Go through each valid update clock freq and determine a raw
> +		 * value for the step size by using the formula:
> +		 * Step Size =3D Full Scale Out / (Update Clk Freq * Slew Time)
> +		 */
> +		sr_step =3D AD5758_FULL_SCALE_MICRO;
> +		do_div(sr_step, ad5758_sr_clk[i]);
> +		do_div(sr_step, st->slew_time);
> +		/*
> +		 * After a raw value for step size was determined, find the
> +		 * closest valid match
> +		 */
> +		res =3D ad5758_find_closest_match(ad5758_sr_step,
> +						ARRAY_SIZE(ad5758_sr_step),
> +						sr_step);
> +		/* Calculate the slew time */
> +		calc_slew_time =3D AD5758_FULL_SCALE_MICRO;
> +		do_div(calc_slew_time, ad5758_sr_step[res]);
> +		do_div(calc_slew_time, ad5758_sr_clk[i]);
> +		/*
> +		 * Determine with how many microseconds the calculated slew time
> +		 * is different from the desired slew time and store the diff
> +		 * for the next iteration
> +		 */
> +		diff_new =3D abs(st->slew_time - calc_slew_time);
> +		if (diff_new < diff_old) {
> +			diff_old =3D diff_new;
> +			sr_clk_idx =3D i;
> +			sr_step_idx =3D res;
> +		}
> +	}
> +
> +	return ad5758_slew_rate_set(st, sr_clk_idx, sr_step_idx);
> +}
> +
> +static int ad5758_set_out_range(struct ad5758_state *st, int range)
> +{
> +	int ret;
> +
> +	ret =3D ad5758_spi_write_mask(st, AD5758_DAC_CONFIG,
> +				    AD5758_DAC_CONFIG_RANGE_MSK,
> +				    AD5758_DAC_CONFIG_RANGE_MODE(range));
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Wait to allow time for the internal calibrations to complete */
> +	return ad5758_wait_for_task_complete(st, AD5758_DIGITAL_DIAG_RESULTS,
> +					     AD5758_CAL_MEM_UNREFRESHED_MSK);
> +}
> +
> +static int ad5758_fault_prot_switch_en(struct ad5758_state *st, bool ena=
ble)
> +{
> +	int ret;
> +
> +	ret =3D ad5758_spi_write_mask(st, AD5758_DCDC_CONFIG1,
> +			AD5758_DCDC_CONFIG1_PROT_SW_EN_MSK,
> +			AD5758_DCDC_CONFIG1_PROT_SW_EN_MODE(enable));
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
> +static int ad5758_internal_buffers_en(struct ad5758_state *st, bool enab=
le)
> +{
> +	int ret;
> +
> +	ret =3D ad5758_spi_write_mask(st, AD5758_DAC_CONFIG,
> +				    AD5758_DAC_CONFIG_INT_EN_MSK,
> +				    AD5758_DAC_CONFIG_INT_EN_MODE(enable));
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Wait to allow time for the internal calibrations to complete */
> +	return ad5758_wait_for_task_complete(st, AD5758_DIGITAL_DIAG_RESULTS,
> +					     AD5758_CAL_MEM_UNREFRESHED_MSK);
> +}
> +
> +static int ad5758_reg_access(struct iio_dev *indio_dev,
> +			     unsigned int reg,
> +			     unsigned int writeval,
> +			     unsigned int *readval)
> +{
> +	struct ad5758_state *st =3D iio_priv(indio_dev);
> +	int ret;
> +
> +	mutex_lock(&st->lock);
> +	if (readval) {
> +		ret =3D ad5758_spi_reg_read(st, reg);
> +		if (ret < 0) {
> +			mutex_unlock(&st->lock);
> +			return ret;
> +		}
> +
> +		*readval =3D ret;
> +		ret =3D 0;
> +	} else {
> +		ret =3D ad5758_spi_reg_write(st, reg, writeval);
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
> +	struct ad5758_state *st =3D iio_priv(indio_dev);
> +	int max, min, ret;
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_RAW:
> +		mutex_lock(&st->lock);
> +		ret =3D ad5758_spi_reg_read(st, AD5758_DAC_INPUT);
> +		mutex_unlock(&st->lock);
> +		if (ret < 0)
> +			return ret;
> +
> +		*val =3D ret;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		min =3D st->out_range.min;
> +		max =3D st->out_range.max;
> +		*val =3D (max - min) / 1000;
> +		*val2 =3D 16;
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	case IIO_CHAN_INFO_OFFSET:
> +		min =3D st->out_range.min;
> +		max =3D st->out_range.max;
> +		*val =3D ((min * (1 << 16)) / (max - min)) / 1000;
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad5758_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int val, int val2, long info)
> +{
> +	struct ad5758_state *st =3D iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_RAW:
> +		mutex_lock(&st->lock);
> +		ret =3D ad5758_spi_reg_write(st, AD5758_DAC_INPUT, val);
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
> +	struct ad5758_state *st =3D iio_priv(indio_dev);
> +
> +	return sprintf(buf, "%d\n", st->pwr_down);
> +}
> +
> +static ssize_t ad5758_write_powerdown(struct iio_dev *indio_dev,
> +				      uintptr_t priv,
> +				      struct iio_chan_spec const *chan,
> +				      const char *buf, size_t len)
> +{
> +	struct ad5758_state *st =3D iio_priv(indio_dev);
> +	bool pwr_down;
> +	unsigned int dcdc_config1_mode, dc_dc_mode, dac_config_mode, val;
> +	unsigned long int dcdc_config1_msk, dac_config_msk;
> +	int ret;
> +
> +	ret =3D kstrtobool(buf, &pwr_down);
> +	if (ret)
> +		return ret;
> +
> +	mutex_lock(&st->lock);
> +	if (pwr_down) {
> +		dc_dc_mode =3D AD5758_DCDC_MODE_POWER_OFF;
> +		val =3D 0;
> +	} else {
> +		dc_dc_mode =3D st->dc_dc_mode;
> +		val =3D 1;
> +	}
> +
> +	dcdc_config1_mode =3D AD5758_DCDC_CONFIG1_DCDC_MODE_MODE(dc_dc_mode) |
> +			    AD5758_DCDC_CONFIG1_PROT_SW_EN_MODE(val);
> +	dcdc_config1_msk =3D AD5758_DCDC_CONFIG1_DCDC_MODE_MSK |
> +			   AD5758_DCDC_CONFIG1_PROT_SW_EN_MSK;
> +
> +	ret =3D ad5758_spi_write_mask(st, AD5758_DCDC_CONFIG1,
> +				    dcdc_config1_msk,
> +				    dcdc_config1_mode);
> +	if (ret < 0)
> +		goto err_unlock;
> +
> +	dac_config_mode =3D AD5758_DAC_CONFIG_OUT_EN_MODE(val) |
> +			  AD5758_DAC_CONFIG_INT_EN_MODE(val);
> +	dac_config_msk =3D AD5758_DAC_CONFIG_OUT_EN_MSK |
> +			 AD5758_DAC_CONFIG_INT_EN_MSK;
> +
> +	ret =3D ad5758_spi_write_mask(st, AD5758_DAC_CONFIG,
> +				    dac_config_msk,
> +				    dac_config_mode);
> +	if (ret < 0)
> +		goto err_unlock;
> +
> +	st->pwr_down =3D pwr_down;
> +
> +err_unlock:
> +	mutex_unlock(&st->lock);
> +
> +	return ret ? ret : len;
> +}
> +
> +static const struct iio_info ad5758_info =3D {
> +	.read_raw =3D ad5758_read_raw,
> +	.write_raw =3D ad5758_write_raw,
> +	.debugfs_reg_access =3D &ad5758_reg_access,
> +};
> +
> +static const struct iio_chan_spec_ext_info ad5758_ext_info[] =3D {
> +	{
> +		.name =3D "powerdown",
> +		.read =3D ad5758_read_powerdown,
> +		.write =3D ad5758_write_powerdown,
> +		.shared =3D IIO_SHARED_BY_TYPE,
> +	},
> +	{ }
> +};
> +
> +#define AD5758_DAC_CHAN(_chan_type) {				\
> +	.type =3D (_chan_type),					\
> +	.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_RAW) |	\
> +		BIT(IIO_CHAN_INFO_SCALE) |			\
> +		BIT(IIO_CHAN_INFO_OFFSET),			\
> +	.indexed =3D 1,						\
> +	.output =3D 1,						\
> +	.ext_info =3D ad5758_ext_info,				\
> +}
> +
> +static const struct iio_chan_spec ad5758_voltage_ch[] =3D {
> +	AD5758_DAC_CHAN(IIO_VOLTAGE)
> +};
> +
> +static const struct iio_chan_spec ad5758_current_ch[] =3D {
> +	AD5758_DAC_CHAN(IIO_CURRENT)
> +};
> +
> +static bool ad5758_is_valid_mode(enum ad5758_dc_dc_mode mode)
> +{
> +	switch (mode) {
> +	case AD5758_DCDC_MODE_DPC_CURRENT:
> +	case AD5758_DCDC_MODE_DPC_VOLTAGE:
> +	case AD5758_DCDC_MODE_PPC_CURRENT:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +static int ad5758_crc_disable(struct ad5758_state *st)
> +{
> +	unsigned int mask;
> +
> +	mask =3D (AD5758_WR_FLAG_MSK(AD5758_DIGITAL_DIAG_CONFIG) << 24) | 0x5C3=
A;
> +	st->d32[0] =3D cpu_to_be32(mask);
> +
> +	return spi_write(st->spi, &st->d32[0], 4);
> +}
> +
> +static int ad5758_find_out_range(struct ad5758_state *st,
> +				 const struct ad5758_range *range,
> +				 unsigned int size,
> +				 int min, int max)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < size; i++) {
> +		if ((min =3D=3D range[i].min) && (max =3D=3D range[i].max)) {
> +			st->out_range.reg =3D range[i].reg;
> +			st->out_range.min =3D range[i].min;
> +			st->out_range.max =3D range[i].max;
> +
> +			return 0;
> +		}
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int ad5758_parse_dt(struct ad5758_state *st)
> +{
> +	unsigned int tmp, tmparray[2], size;
> +	const struct ad5758_range *range;
> +	int *index, ret;
> +
> +	st->dc_dc_ilim =3D 0;
> +	ret =3D device_property_read_u32(&st->spi->dev,
> +				       "adi,dc-dc-ilim-microamp", &tmp);
> +	if (ret) {
> +		dev_dbg(&st->spi->dev,
> +			"Missing \"dc-dc-ilim-microamp\" property\n");
> +	} else {
> +		index =3D bsearch(&tmp, ad5758_dc_dc_ilim,
> +				ARRAY_SIZE(ad5758_dc_dc_ilim),
> +				sizeof(int), cmpfunc);
> +		if (!index)
> +			dev_dbg(&st->spi->dev, "dc-dc-ilim out of range\n");
> +		else
> +			st->dc_dc_ilim =3D index - ad5758_dc_dc_ilim;
> +	}
> +
> +	ret =3D device_property_read_u32(&st->spi->dev, "adi,dc-dc-mode",
> +				       &st->dc_dc_mode);
> +	if (ret) {
> +		dev_err(&st->spi->dev, "Missing \"dc-dc-mode\" property\n");
> +		return ret;
> +	}
> +
> +	if (!ad5758_is_valid_mode(st->dc_dc_mode))
> +		return -EINVAL;
> +
> +	if (st->dc_dc_mode =3D=3D AD5758_DCDC_MODE_DPC_VOLTAGE) {
> +		ret =3D device_property_read_u32_array(&st->spi->dev,
> +						     "adi,range-microvolt",
> +						     tmparray, 2);
> +		if (ret) {
> +			dev_err(&st->spi->dev,
> +				"Missing \"range-microvolt\" property\n");
> +			return ret;
> +		}
> +		range =3D ad5758_voltage_range;
> +		size =3D ARRAY_SIZE(ad5758_voltage_range);
> +	} else {
> +		ret =3D device_property_read_u32_array(&st->spi->dev,
> +						     "adi,range-microamp",
> +						     tmparray, 2);
> +		if (ret) {
> +			dev_err(&st->spi->dev,
> +				"Missing \"range-microamp\" property\n");
> +			return ret;
> +		}
> +		range =3D ad5758_current_range;
> +		size =3D ARRAY_SIZE(ad5758_current_range);
> +	}
> +
> +	ret =3D ad5758_find_out_range(st, range, size, tmparray[0], tmparray[1]=
);
> +	if (ret) {
> +		dev_err(&st->spi->dev, "range invalid\n");
> +		return ret;
> +	}
> +
> +	ret =3D device_property_read_u32(&st->spi->dev, "adi,slew-time-us", &tm=
p);
> +	if (ret) {
> +		dev_dbg(&st->spi->dev, "Missing \"slew-time-us\" property\n");
> +		st->slew_time =3D 0;
> +	} else {
> +		st->slew_time =3D tmp;
> +	}
> +
> +	return 0;
> +}
> +
> +static int ad5758_init(struct ad5758_state *st)
> +{
> +	int regval, ret;
> +
> +	/* Disable CRC checks */
> +	ret =3D ad5758_crc_disable(st);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Perform a software reset */
> +	ret =3D ad5758_soft_reset(st);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Disable CRC checks */
> +	ret =3D ad5758_crc_disable(st);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Perform a calibration memory refresh */
> +	ret =3D ad5758_calib_mem_refresh(st);
> +	if (ret < 0)
> +		return ret;
> +
> +	regval =3D ad5758_spi_reg_read(st, AD5758_DIGITAL_DIAG_RESULTS);
> +	if (regval < 0)
> +		return regval;
> +
> +	/* Clear all the error flags */
> +	ret =3D ad5758_spi_reg_write(st, AD5758_DIGITAL_DIAG_RESULTS, regval);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Set the dc-to-dc current limit */
> +	ret =3D ad5758_set_dc_dc_ilim(st, st->dc_dc_ilim);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Configure the dc-to-dc controller mode */
> +	ret =3D ad5758_set_dc_dc_conv_mode(st, st->dc_dc_mode);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Configure the output range */
> +	ret =3D ad5758_set_out_range(st, st->out_range.reg);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Enable Slew Rate Control, set the slew rate clock and step */
> +	if (st->slew_time) {
> +		ret =3D ad5758_slew_rate_config(st);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	/* Enable the VIOUT fault protection switch (FPS is closed) */
> +	ret =3D ad5758_fault_prot_switch_en(st, 1);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Power up the DAC and internal (INT) amplifiers */
> +	ret =3D ad5758_internal_buffers_en(st, 1);
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
> +	indio_dev =3D devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st =3D iio_priv(indio_dev);
> +	spi_set_drvdata(spi, indio_dev);
> +
> +	st->spi =3D spi;
> +
> +	mutex_init(&st->lock);
> +
> +	indio_dev->dev.parent =3D &spi->dev;
> +	indio_dev->name =3D spi_get_device_id(spi)->name;
> +	indio_dev->info =3D &ad5758_info;
> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> +	indio_dev->num_channels =3D 1;
> +
> +	ret =3D ad5758_parse_dt(st);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (st->dc_dc_mode =3D=3D AD5758_DCDC_MODE_DPC_VOLTAGE)
> +		indio_dev->channels =3D ad5758_voltage_ch;
> +	else
> +		indio_dev->channels =3D ad5758_current_ch;
> +
> +	ret =3D ad5758_init(st);
> +	if (ret < 0) {
> +		dev_err(&spi->dev, "AD5758 init failed\n");
> +		return ret;
> +	}
> +
> +	return devm_iio_device_register(&st->spi->dev, indio_dev);
> +}
> +
> +static const struct spi_device_id ad5758_id[] =3D {
> +	{ "ad5758", 0 },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(spi, ad5758_id);
> +
> +static struct spi_driver ad5758_driver =3D {
> +	.driver =3D {
> +		.name =3D KBUILD_MODNAME,
> +	},
> +	.probe =3D ad5758_probe,
> +	.id_table =3D ad5758_id,
> +};
> +
> +module_spi_driver(ad5758_driver);
> +
> +MODULE_AUTHOR("Stefan Popa <stefan.popa@analog.com>");
> +MODULE_DESCRIPTION("Analog Devices AD5758 DAC");
> +MODULE_LICENSE("GPL v2");

