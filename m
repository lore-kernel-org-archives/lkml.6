Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1632C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 09:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D6A321470
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 09:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pVv0RHtc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D6A321470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbeJMRBQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 13:01:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:53808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbeJMRBP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 13:01:15 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC7E920859;
        Sat, 13 Oct 2018 09:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539422687;
        bh=WZzu8BmcCd8aT0FZ6HGoyzgJUssZd0WWHGWepYZClrU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pVv0RHtcZPRnME+qE2BSrEUeklUFp0wHzPwc5b7kMLwppaXF+XL2gix+3Zm0X09/7
         vjHw86/ryRZDtM2V2nA5MU0jHXK5sIEMnD3xEezb2709oRCLdlGYq79TlpDABGLswH
         CjKqym+SqQ5C+Bljw4D9mm3vqglLJneH74j7P3gk=
Date:   Sat, 13 Oct 2018 10:24:41 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Song Qiang <songqiang1304521@gmail.com>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        robh+dt@kernel.org, mark.rutland@arm.com,
        himanshujha199640@gmail.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] iio: magnetometer: Add driver support for PNI
 RM3100
Message-ID: <20181013102441.5fcdad5e@archlinux>
In-Reply-To: <4ce188a9-c999-6234-2c48-fd80d6518da6@gmail.com>
References: <20180925031724.21399-1-songqiang1304521@gmail.com>
        <20181002143812.3661-1-songqiang1304521@gmail.com>
        <20181002143812.3661-4-songqiang1304521@gmail.com>
        <20181007164429.26335752@archlinux>
        <4ce188a9-c999-6234-2c48-fd80d6518da6@gmail.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Oct 2018 12:35:18 +0800
Song Qiang <songqiang1304521@gmail.com> wrote:

> On 2018=E5=B9=B410=E6=9C=8807=E6=97=A5 23:44, Jonathan Cameron wrote:
> > On Tue,  2 Oct 2018 22:38:12 +0800
> > Song Qiang <songqiang1304521@gmail.com> wrote:
> > =20
> >> PNI RM3100 is a high resolution, large signal immunity magnetometer,
> >> composed of 3 single sensors and a processing chip with a MagI2C
> >> interface.
> >>
> >> Following functions are available:
> >>   - Single-shot measurement from
> >>     /sys/bus/iio/devices/iio:deviceX/in_magn_{axis}_raw
> >>   - Triggerd buffer measurement.
> >>   - Both i2c and spi interface are supported.
> >>   - Both interrupt and polling measurement is supported, depends on if
> >>     the 'interrupts' in DT is declared.
> >>
> >> Signed-off-by: Song Qiang <songqiang1304521@gmail.com> =20
> > I realise now that I should have read the datasheet properly.
> > Sorry about that.
> >
> > What we have here is a hybrid of polled and continuous measurement.
> >
> > If you are using the dataready as a trigger it is fine to support
> > continuous measurement, but you aren't doing that here.
> >
> > The single shot measurement should be done with the method
> > described in the datasheet where you write a POLL command and then wait
> > for the single interrupt.  There is no problem with racing and that
> > interrupt is a high level one and can be handled as such.  We should
> > not do it by waiting for the next continuous measurement to happen
> > after clearing the status register, which is what I think is happening
> > here.
> >
> > If you want to use it in continuous mode, you should provide a trigger.
> > That trigger will be fired by the dataready signal and the
> > discussion I put in the earlier reply becomes relevant.
> >
> > Doing both of these options requires the interrupt handler to know
> > which mode you are in, but that is straight forward to implement and
> > is done in a number of other drivers.
> >
> > Sorry again that I failed to identify this issue earlier.
> >
> > Thanks to Phil as his question in the interrupt type got me thinking
> > about how you were handing the interrupts.
> >
> > Jonathan
> > =20
>=20
> Hi Jonathan,
>=20
> I learned the way of handling single shot from the driver of hmc5843,=20
> seems like it needs changing, too.
Yikes, that is indeed much the same and for no apparent reason.
If I was guessing, I would say that driver started as an input device
streaming continuously and had no 'read_raw' equivalent so they
thought, oh we will just bolt it in as somewhat of a hack rather
than thinking about power usage and speeds etc.

It should have used the single read mode on that device as well.
Now the challenge is whether anyone has one of these fairly old parts
to test any changes?

> There was some problems with my computer. Lenovo updates told me to=20
> update BIOS and it went dead. I didn't write any code the past few days,=
=20
> just got it fixed today.
:(

Jonathan
>=20
> yours,
> Song Qiang
>=20
> >> ---
> >>   MAINTAINERS                            |   7 +
> >>   drivers/iio/magnetometer/Kconfig       |  29 ++
> >>   drivers/iio/magnetometer/Makefile      |   4 +
> >>   drivers/iio/magnetometer/rm3100-core.c | 539 +++++++++++++++++++++++=
++
> >>   drivers/iio/magnetometer/rm3100-i2c.c  |  58 +++
> >>   drivers/iio/magnetometer/rm3100-spi.c  |  64 +++
> >>   drivers/iio/magnetometer/rm3100.h      |  17 +
> >>   7 files changed, 718 insertions(+)
> >>   create mode 100644 drivers/iio/magnetometer/rm3100-core.c
> >>   create mode 100644 drivers/iio/magnetometer/rm3100-i2c.c
> >>   create mode 100644 drivers/iio/magnetometer/rm3100-spi.c
> >>   create mode 100644 drivers/iio/magnetometer/rm3100.h
> >>
> >> diff --git a/MAINTAINERS b/MAINTAINERS
> >> index 967ce8cdd1cc..14eeeb072403 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -11393,6 +11393,13 @@ M:	"Rafael J. Wysocki" <rafael.j.wysocki@inte=
l.com>
> >>   S:	Maintained
> >>   F:	drivers/pnp/
> >>  =20
> >> +PNI RM3100 IIO DRIVER
> >> +M:	Song Qiang <songqiang1304521@gmail.com>
> >> +L:	linux-iio@vger.kernel.org
> >> +S:	Maintained
> >> +F:	drivers/iio/magnetometer/rm3100*
> >> +F:	Documentation/devicetree/bindings/iio/magnetometer/pni,rm3100.txt
> >> +
> >>   POSIX CLOCKS and TIMERS
> >>   M:	Thomas Gleixner <tglx@linutronix.de>
> >>   L:	linux-kernel@vger.kernel.org
> >> diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetomet=
er/Kconfig
> >> index ed9d776d01af..8a63cbbca4b7 100644
> >> --- a/drivers/iio/magnetometer/Kconfig
> >> +++ b/drivers/iio/magnetometer/Kconfig
> >> @@ -175,4 +175,33 @@ config SENSORS_HMC5843_SPI
> >>   	  - hmc5843_core (core functions)
> >>   	  - hmc5843_spi (support for HMC5983)
> >>  =20
> >> +config SENSORS_RM3100
> >> +	tristate
> >> +	select IIO_BUFFER
> >> +	select IIO_TRIGGERED_BUFFER
> >> +
> >> +config SENSORS_RM3100_I2C
> >> +	tristate "PNI RM3100 3-Axis Magnetometer (I2C)"
> >> +	depends on I2C
> >> +	select SENSORS_RM3100
> >> +	select REGMAP_I2C
> >> +	help
> >> +	  Say Y here to add support for the PNI RM3100 3-Axis Magnetometer.
> >> +
> >> +	  This driver can also be compiled as a module.
> >> +	  To compile this driver as a module, choose M here: the module
> >> +	  will be called rm3100-i2c.
> >> +
> >> +config SENSORS_RM3100_SPI
> >> +	tristate "PNI RM3100 3-Axis Magnetometer (SPI)"
> >> +	depends on SPI_MASTER
> >> +	select SENSORS_RM3100
> >> +	select REGMAP_SPI
> >> +	help
> >> +	  Say Y here to add support for the PNI RM3100 3-Axis Magnetometer.
> >> +
> >> +	  This driver can also be compiled as a module.
> >> +	  To compile this driver as a module, choose M here: the module
> >> +	  will be called rm3100-spi.
> >> +
> >>   endmenu
> >> diff --git a/drivers/iio/magnetometer/Makefile b/drivers/iio/magnetome=
ter/Makefile
> >> index 664b2f866472..ba1bc34b82fa 100644
> >> --- a/drivers/iio/magnetometer/Makefile
> >> +++ b/drivers/iio/magnetometer/Makefile
> >> @@ -24,3 +24,7 @@ obj-$(CONFIG_IIO_ST_MAGN_SPI_3AXIS) +=3D st_magn_spi=
.o
> >>   obj-$(CONFIG_SENSORS_HMC5843)		+=3D hmc5843_core.o
> >>   obj-$(CONFIG_SENSORS_HMC5843_I2C)	+=3D hmc5843_i2c.o
> >>   obj-$(CONFIG_SENSORS_HMC5843_SPI)	+=3D hmc5843_spi.o
> >> +
> >> +obj-$(CONFIG_SENSORS_RM3100)		+=3D rm3100-core.o
> >> +obj-$(CONFIG_SENSORS_RM3100_I2C)	+=3D rm3100-i2c.o
> >> +obj-$(CONFIG_SENSORS_RM3100_SPI)	+=3D rm3100-spi.o
> >> diff --git a/drivers/iio/magnetometer/rm3100-core.c b/drivers/iio/magn=
etometer/rm3100-core.c
> >> new file mode 100644
> >> index 000000000000..cacdaee28ae3
> >> --- /dev/null
> >> +++ b/drivers/iio/magnetometer/rm3100-core.c
> >> @@ -0,0 +1,539 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * PNI RM3100 3-axis geomagnetic sensor driver core.
> >> + *
> >> + * Copyright (C) 2018 Song Qiang <songqiang1304521@gmail.com>
> >> + *
> >> + * User Manual available at
> >> + * <https://www.pnicorp.com/download/rm3100-user-manual/>
> >> + *
> >> + * TODO: event generation, pm.
> >> + */
> >> +
> >> +#include <linux/delay.h>
> >> +#include <linux/interrupt.h>
> >> +#include <linux/module.h>
> >> +#include <linux/slab.h>
> >> +
> >> +#include <linux/iio/buffer.h>
> >> +#include <linux/iio/iio.h>
> >> +#include <linux/iio/kfifo_buf.h>
> >> +#include <linux/iio/sysfs.h>
> >> +#include <linux/iio/triggered_buffer.h>
> >> +#include <linux/iio/trigger_consumer.h>
> >> +
> >> +#include "rm3100.h"
> >> +
> >> +/* Cycle Count Registers. */
> >> +#define RM3100_REG_CC_X			0x05
> >> +#define RM3100_REG_CC_Y			0x07
> >> +#define RM3100_REG_CC_Z			0x09
> >> +
> >> +/* Continuous Measurement Mode register. */
> >> +#define RM3100_REG_CMM			0x01
> >> +#define		RM3100_CMM_START	BIT(0)
> >> +#define		RM3100_CMM_X		BIT(4)
> >> +#define		RM3100_CMM_Y		BIT(5)
> >> +#define		RM3100_CMM_Z		BIT(6)
> >> +
> >> +/* TiMe Rate Configuration register. */
> >> +#define RM3100_REG_TMRC			0x0B
> >> +#define RM3100_TMRC_OFFSET		0x92
> >> +
> >> +/* Result Status register. */
> >> +#define RM3100_REG_STATUS		0x34
> >> +#define		RM3100_STATUS_DRDY	BIT(7)
> >> +
> >> +/* Measurement result registers. */
> >> +#define RM3100_REG_MX2			0x24
> >> +#define RM3100_REG_MY2			0x27
> >> +#define RM3100_REG_MZ2			0x2a
> >> +
> >> +#define RM3100_W_REG_START		RM3100_REG_CMM
> >> +#define RM3100_W_REG_END		RM3100_REG_STATUS
> >> +#define RM3100_R_REG_START		RM3100_REG_CMM
> >> +#define RM3100_R_REG_END		RM3100_REG_STATUS
> >> +#define RM3100_V_REG_START		RM3100_REG_MX2
> >> +#define RM3100_V_REG_END		RM3100_REG_STATUS
> >> +
> >> +/*
> >> + * This is computed by hand, is the sum of channel storage bits and p=
adding
> >> + * bits, which is 4+4+4+12=3D24 in here.
> >> + */
> >> +#define RM3100_SCAN_BYTES		24
> >> +
> >> +struct rm3100_data {
> >> +	struct regmap *regmap;
> >> +	struct completion measuring_done;
> >> +	bool use_interrupt;
> >> +
> >> +	int conversion_time;
> >> +	int cycle_count_index;
> >> +
> >> +	u8 buffer[RM3100_SCAN_BYTES];
> >> +
> >> +	/*
> >> +	 * This lock is for protecting the consistency of series of i2c
> >> +	 * operations, that is, to make sure a measurement process will
> >> +	 * not be interrupted by a set frequency operation, which should
> >> +	 * be taken where a series of i2c operation starts, released where
> >> +	 * the operation ends.
> >> +	 */
> >> +	struct mutex lock;
> >> +};
> >> +
> >> +static const struct regmap_range rm3100_readable_ranges[] =3D {
> >> +	regmap_reg_range(RM3100_W_REG_START, RM3100_W_REG_END),
> >> +};
> >> +
> >> +const struct regmap_access_table rm3100_readable_table =3D {
> >> +	.yes_ranges =3D rm3100_readable_ranges,
> >> +	.n_yes_ranges =3D ARRAY_SIZE(rm3100_readable_ranges),
> >> +};
> >> +EXPORT_SYMBOL_GPL(rm3100_readable_table);
> >> +
> >> +static const struct regmap_range rm3100_writable_ranges[] =3D {
> >> +	regmap_reg_range(RM3100_R_REG_START, RM3100_R_REG_END),
> >> +};
> >> +
> >> +const struct regmap_access_table rm3100_writable_table =3D {
> >> +	.yes_ranges =3D rm3100_writable_ranges,
> >> +	.n_yes_ranges =3D ARRAY_SIZE(rm3100_writable_ranges),
> >> +};
> >> +EXPORT_SYMBOL_GPL(rm3100_writable_table);
> >> +
> >> +static const struct regmap_range rm3100_volatile_ranges[] =3D {
> >> +	regmap_reg_range(RM3100_V_REG_START, RM3100_V_REG_END),
> >> +};
> >> +
> >> +const struct regmap_access_table rm3100_volatile_table =3D {
> >> +	.yes_ranges =3D rm3100_volatile_ranges,
> >> +	.n_yes_ranges =3D ARRAY_SIZE(rm3100_volatile_ranges),
> >> +};
> >> +EXPORT_SYMBOL_GPL(rm3100_volatile_table);
> >> +
> >> +static irqreturn_t rm3100_irq_handler(int irq, void *d)
> >> +{
> >> +	struct rm3100_data *data =3D d;
> >> +
> >> +	complete(&data->measuring_done);
> >> +
> >> +	return IRQ_HANDLED;
> >> +}
> >> +
> >> +static int rm3100_wait_measurement(struct rm3100_data *data)
> >> +{
> >> +	struct regmap *regmap =3D data->regmap;
> >> +	unsigned int val;
> >> +	int tries =3D 20;
> >> +	int ret;
> >> +
> >> +	/*
> >> +	 * A read cycle of 400kbits i2c bus is about 20us, plus the time
> >> +	 * used for scheduling, a read cycle of fast mode of this device
> >> +	 * can reach 1.7ms, it may be possible for data to arrive just
> >> +	 * after we check the RM3100_REG_STATUS. In this case, irq_handler is
> >> +	 * called before measuring_done is reinitialized, it will wait
> >> +	 * forever for data that has already been ready.
> >> +	 * Reinitialize measuring_done before looking up makes sure we
> >> +	 * will always capture interrupt no matter when it happens.
> >> +	 */
> >> +	if (data->use_interrupt)
> >> +		reinit_completion(&data->measuring_done);
> >> +
> >> +	ret =3D regmap_read(regmap, RM3100_REG_STATUS, &val);
> >> +	if (ret < 0)
> >> +		return ret;
> >> +
> >> +	if ((val & RM3100_STATUS_DRDY) !=3D RM3100_STATUS_DRDY) {
> >> +		if (data->use_interrupt) {
> >> +			ret =3D wait_for_completion_timeout(&data->measuring_done,
> >> +				msecs_to_jiffies(data->conversion_time));
> >> +			if (ret < 0)
> >> +				return -ETIMEDOUT;
> >> +		} else {
> >> +			do {
> >> +				usleep_range(1000, 5000);
> >> +
> >> +				ret =3D regmap_read(regmap, RM3100_REG_STATUS,
> >> +						  &val);
> >> +				if (ret < 0)
> >> +					return ret;
> >> +
> >> +				if (val & RM3100_STATUS_DRDY)
> >> +					break;
> >> +			} while (--tries);
> >> +			if (!tries)
> >> +				return -ETIMEDOUT;
> >> +		}
> >> +	}
> >> +	return 0;
> >> +}
> >> +
> >> +static int rm3100_read_mag(struct rm3100_data *data, int idx, int *va=
l)
> >> +{
> >> +	struct regmap *regmap =3D data->regmap;
> >> +	u8 buffer[3];
> >> +	int ret;
> >> +
> >> +	mutex_lock(&data->lock);
> >> +	ret =3D rm3100_wait_measurement(data);
> >> +	if (ret < 0) {
> >> +		mutex_unlock(&data->lock);
> >> +		return ret;
> >> +	}
> >> +
> >> +	ret =3D regmap_bulk_read(regmap, RM3100_REG_MX2 + 3 * idx, buffer, 3=
);
> >> +	mutex_unlock(&data->lock);
> >> +	if (ret < 0)
> >> +		return ret;
> >> +
> >> +	*val =3D sign_extend32((buffer[0] << 16) | (buffer[1] << 8) | buffer=
[2],
> >> +			     23);
> >> +
> >> +	return IIO_VAL_INT;
> >> +}
> >> +
> >> +#define RM3100_CHANNEL(axis, idx)					\
> >> +	{								\
> >> +		.type =3D IIO_MAGN,					\
> >> +		.modified =3D 1,						\
> >> +		.channel2 =3D IIO_MOD_##axis,				\
> >> +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),		\
> >> +		.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE) |	\
> >> +			BIT(IIO_CHAN_INFO_SAMP_FREQ),			\
> >> +		.scan_index =3D idx,					\
> >> +		.scan_type =3D {						\
> >> +			.sign =3D 's',					\
> >> +			.realbits =3D 24,					\
> >> +			.storagebits =3D 32,				\
> >> +			.shift =3D 8,					\
> >> +			.endianness =3D IIO_BE,				\
> >> +		},							\
> >> +	}
> >> +
> >> +static const struct iio_chan_spec rm3100_channels[] =3D {
> >> +	RM3100_CHANNEL(X, 0),
> >> +	RM3100_CHANNEL(Y, 1),
> >> +	RM3100_CHANNEL(Z, 2),
> >> +	IIO_CHAN_SOFT_TIMESTAMP(3),
> >> +};
> >> +
> >> +static const unsigned long rm3100_scan_masks[] =3D {BIT(0) | BIT(1) |=
 BIT(2), 0};
> >> +
> >> +static IIO_CONST_ATTR_SAMP_FREQ_AVAIL(
> >> +	"600 300 150 75 37 18 9 4.5 2.3 1.2 0.6 0.3 0.015 0.075"
> >> +);
> >> +
> >> +static struct attribute *rm3100_attributes[] =3D {
> >> +	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
> >> +	NULL,
> >> +};
> >> +
> >> +static const struct attribute_group rm3100_attribute_group =3D {
> >> +	.attrs =3D rm3100_attributes,
> >> +};
> >> +
> >> +#define RM3100_SAMP_NUM			14
> >> +
> >> +/*
> >> + * Frequency : rm3100_samp_rates[][0].rm3100_samp_rates[][1]Hz.
> >> + * Time between reading: rm3100_sam_rates[][2]ms.
> >> + * The first one is actually 1.7ms.
> >> + */
> >> +static const int rm3100_samp_rates[RM3100_SAMP_NUM][3] =3D {
> >> +	{600, 0, 2}, {300, 0, 3}, {150, 0, 7}, {75, 0, 13}, {37, 0, 27},
> >> +	{18, 0, 55}, {9, 0, 110}, {4, 500000, 220}, {2, 300000, 440},
> >> +	{1, 200000, 800}, {0, 600000, 1600}, {0, 300000, 3300},
> >> +	{0, 15000, 6700},  {0, 75000, 13000}
> >> +};
> >> +
> >> +static int rm3100_get_samp_freq(struct rm3100_data *data, int *val, i=
nt *val2)
> >> +{
> >> +	int ret;
> >> +	unsigned int tmp;
> >> +
> >> +	mutex_lock(&data->lock);
> >> +	ret =3D regmap_read(data->regmap, RM3100_REG_TMRC, &tmp);
> >> +	mutex_unlock(&data->lock);
> >> +	if (ret < 0)
> >> +		return ret;
> >> +	*val =3D rm3100_samp_rates[tmp - RM3100_TMRC_OFFSET][0];
> >> +	*val2 =3D rm3100_samp_rates[tmp - RM3100_TMRC_OFFSET][1];
> >> +
> >> +	return IIO_VAL_INT_PLUS_MICRO;
> >> +}
> >> +
> >> +static int rm3100_set_cycle_count(struct rm3100_data *data, int val)
> >> +{
> >> +	int ret;
> >> +	u8 i;
> >> +
> >> +	for (i =3D 0; i < 3; i++) {
> >> +		ret =3D regmap_write(data->regmap, RM3100_REG_CC_X + 2 * i, val);
> >> +		if (ret < 0)
> >> +			return ret;
> >> +	}
> >> +
> >> +	switch (val) {
> >> +	case 50:
> >> +		data->cycle_count_index =3D 0;
> >> +		break;
> >> +	case 100:
> >> +		data->cycle_count_index =3D 1;
> >> +		break;
> >> +	/*
> >> +	 * This function will never be called by users' code, so here we
> >> +	 * assume that it will never get a wrong parameter.
> >> +	 */
> >> +	default:
> >> +		data->cycle_count_index =3D 2;
> >> +	}
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static int rm3100_set_samp_freq(struct rm3100_data *data, int val, in=
t val2)
> >> +{
> >> +	struct regmap *regmap =3D data->regmap;
> >> +	unsigned int cycle_count;
> >> +	int ret;
> >> +	int i;
> >> +
> >> +	mutex_lock(&data->lock);
> >> +	/* All cycle count registers use the same value. */
> >> +	ret =3D regmap_read(regmap, RM3100_REG_CC_X, &cycle_count);
> >> +	if (ret < 0)
> >> +		goto unlock_return;
> >> +
> >> +	for (i =3D 0; i < RM3100_SAMP_NUM; i++) {
> >> +		if (val =3D=3D rm3100_samp_rates[i][0] &&
> >> +		    val2 =3D=3D rm3100_samp_rates[i][1])
> >> +			break;
> >> +	}
> >> +	if (i =3D=3D RM3100_SAMP_NUM) {
> >> +		ret =3D -EINVAL;
> >> +		goto unlock_return;
> >> +	}
> >> +
> >> +	ret =3D regmap_write(regmap, RM3100_REG_TMRC, i + RM3100_TMRC_OFFSET=
);
> >> +	if (ret < 0)
> >> +		goto unlock_return;
> >> +
> >> +	/* Checking if cycle count registers need changing. */
> >> +	if (val =3D=3D 600 && cycle_count =3D=3D 200) {
> >> +		ret =3D rm3100_set_cycle_count(data, 100);
> >> +		if (ret < 0)
> >> +			goto unlock_return;
> >> +	} else if (val !=3D 600 && cycle_count =3D=3D 100) {
> >> +		ret =3D rm3100_set_cycle_count(data, 200);
> >> +		if (ret < 0)
> >> +			goto unlock_return;
> >> +	}
> >> +
> >> +	/* Writing TMRC registers requires CMM reset. */
> >> +	ret =3D regmap_write(regmap, RM3100_REG_CMM, 0);
> >> +	if (ret < 0)
> >> +		goto unlock_return;
> >> +	ret =3D regmap_write(regmap, RM3100_REG_CMM,
> >> +		RM3100_CMM_X | RM3100_CMM_Y | RM3100_CMM_Z | RM3100_CMM_START);
> >> +	if (ret < 0)
> >> +		goto unlock_return;
> >> +	mutex_unlock(&data->lock);
> >> +
> >> +	data->conversion_time =3D rm3100_samp_rates[i][2] + 3000;
> >> +	return 0;
> >> +
> >> +unlock_return:
> >> +	mutex_unlock(&data->lock);
> >> +	return ret;
> >> +}
> >> +
> >> +/*
> >> + * The scale of this sensor depends on the cycle count value, these t=
hree
> >> + * values are corresponding to the cycle count value 50, 100, 200.
> >> + * scale =3D output / gain * 10^4.
> >> + */
> >> +const static int rm3100_scale[] =3D {500, 263, 133};
> >> +
> >> +static int rm3100_read_raw(struct iio_dev *indio_dev,
> >> +			   const struct iio_chan_spec *chan,
> >> +			   int *val, int *val2, long mask)
> >> +{
> >> +	struct rm3100_data *data =3D iio_priv(indio_dev);
> >> +	int ret;
> >> +
> >> +	switch (mask) {
> >> +	case IIO_CHAN_INFO_RAW:
> >> +		ret =3D iio_device_claim_direct_mode(indio_dev);
> >> +		if (ret < 0)
> >> +			return ret;
> >> +
> >> +		ret =3D rm3100_read_mag(data, chan->scan_index, val);
> >> +		iio_device_release_direct_mode(indio_dev);
> >> +
> >> +		return ret;
> >> +	case IIO_CHAN_INFO_SCALE:
> >> +		*val =3D 0;
> >> +		*val2 =3D rm3100_scale[data->cycle_count_index];
> >> +
> >> +		return IIO_VAL_INT_PLUS_MICRO;
> >> +	case IIO_CHAN_INFO_SAMP_FREQ:
> >> +		return rm3100_get_samp_freq(data, val, val2);
> >> +	default:
> >> +		return -EINVAL;
> >> +	}
> >> +}
> >> +
> >> +static int rm3100_write_raw(struct iio_dev *indio_dev,
> >> +			    struct iio_chan_spec const *chan,
> >> +			    int val, int val2, long mask)
> >> +{
> >> +	struct rm3100_data *data =3D iio_priv(indio_dev);
> >> +
> >> +	switch (mask) {
> >> +	case IIO_CHAN_INFO_SAMP_FREQ:
> >> +		return rm3100_set_samp_freq(data, val, val2);
> >> +	default:
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +}
> >> +
> >> +static const struct iio_info rm3100_info =3D {
> >> +	.attrs =3D &rm3100_attribute_group,
> >> +	.read_raw =3D rm3100_read_raw,
> >> +	.write_raw =3D rm3100_write_raw,
> >> +};
> >> +
> >> +static irqreturn_t rm3100_trigger_handler(int irq, void *p)
> >> +{
> >> +	struct iio_poll_func *pf =3D p;
> >> +	struct iio_dev *indio_dev =3D pf->indio_dev;
> >> +	struct rm3100_data *data =3D iio_priv(indio_dev);
> >> +	struct regmap *regmap =3D data->regmap;
> >> +	int ret;
> >> +	int i;
> >> +
> >> +	mutex_lock(&data->lock);
> >> +	ret =3D rm3100_wait_measurement(data);
> >> +	if (ret < 0) {
> >> +		mutex_unlock(&data->lock);
> >> +		goto done;
> >> +	}
> >> +
> >> +	ret =3D regmap_bulk_read(regmap, RM3100_REG_MX2, data->buffer, 9);
> >> +	mutex_unlock(&data->lock);
> >> +	if (ret < 0)
> >> +		goto done;
> >> +
> >> +	/* Convert XXXYYYZZZxxx to XXXxYYYxZZZx. x for paddings. */
> >> +	for (i =3D 0; i < 2; i++)
> >> +		memcpy(data->buffer + (2 - i) * 4, data->buffer + (2 - i) * 3,
> >> +		       3);
> >> +
> >> +	/*
> >> +	 * Always using the same buffer so that we wouldn't need to set the
> >> +	 * paddings to 0 in case of leaking any data.
> >> +	 */
> >> +	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
> >> +					   iio_get_time_ns(indio_dev));
> >> +
> >> +done:
> >> +	iio_trigger_notify_done(indio_dev->trig);
> >> +
> >> +	return IRQ_HANDLED;
> >> +}
> >> +
> >> +static void rm3100_remove(void *pdata)
> >> +{ =20
> > Given this is no longer the opposite of probe, but rather just an
> > action to undo one particular element of probe (be it the only
> > one that needs undoing - yeah a subtle distinction ;)...
> >
> > Can we give it a more meaningful name?
> >
> > rm3100_stop perhaps? Perhaps even create a little function
> > to be rm3100_start as well so that it's easy to see how these
> > are paired?
> >
> > =20
> >> +	struct rm3100_data *data =3D pdata;
> >> +	struct device *dev =3D regmap_get_device(data->regmap);
> >> +	int ret;
> >> +
> >> +	ret =3D regmap_write(data->regmap, RM3100_REG_CMM, 0x00);
> >> +	if (ret < 0)
> >> +		dev_err(dev, "failed to stop the device.\n");
> >> +}
> >> +
> >> +int rm3100_common_probe(struct device *dev, struct regmap *regmap, in=
t irq)
> >> +{
> >> +	struct iio_dev *indio_dev;
> >> +	struct rm3100_data *data;
> >> +	unsigned int tmp;
> >> +	int ret;
> >> +
> >> +	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*data));
> >> +	if (!indio_dev)
> >> +		return -ENOMEM;
> >> +
> >> +	data =3D iio_priv(indio_dev);
> >> +	data->regmap =3D regmap;
> >> +
> >> +	mutex_init(&data->lock);
> >> +
> >> +	indio_dev->dev.parent =3D dev;
> >> +	indio_dev->name =3D "rm3100";
> >> +	indio_dev->info =3D &rm3100_info;
> >> +	indio_dev->channels =3D rm3100_channels;
> >> +	indio_dev->num_channels =3D ARRAY_SIZE(rm3100_channels);
> >> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> >> +	indio_dev->available_scan_masks =3D rm3100_scan_masks;
> >> +
> >> +	if (!irq)
> >> +		data->use_interrupt =3D false;
> >> +	else {
> >> +		data->use_interrupt =3D true;
> >> +		ret =3D devm_request_irq(dev,
> >> +				       irq,
> >> +				       rm3100_irq_handler,
> >> +				       IRQF_TRIGGER_RISING,
> >> +				       indio_dev->name,
> >> +				       data);
> >> +		if (ret < 0) {
> >> +			dev_err(dev, "request irq line failed.\n");
> >> +			return ret;
> >> +		}
> >> +		init_completion(&data->measuring_done);
> >> +	}
> >> +
> >> +	ret =3D devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
> >> +					      rm3100_trigger_handler, NULL);
> >> +	if (ret < 0)
> >> +		return ret;
> >> +
> >> +	ret =3D regmap_read(regmap, RM3100_REG_TMRC, &tmp);
> >> +	if (ret < 0)
> >> +		return ret;
> >> +	/* Initializing max wait time, 3sec more wait time for conversion. */
> >> +	data->conversion_time =3D
> >> +		rm3100_samp_rates[tmp - RM3100_TMRC_OFFSET][2] + 3000;
> >> +
> >> +	/* Cycle count values may not be what we want. */
> >> +	ret =3D regmap_read(data->regmap, RM3100_REG_TMRC, &tmp);
> >> +	if (ret < 0)
> >> +		return ret;
> >> +	if ((tmp - RM3100_TMRC_OFFSET) =3D=3D 0)
> >> +		rm3100_set_cycle_count(data, 100);
> >> +	else
> >> +		rm3100_set_cycle_count(data, 200);
> >> +
> >> +	/* Starting all channels' conversion. */
> >> +	ret =3D regmap_write(regmap, RM3100_REG_CMM,
> >> +		RM3100_CMM_X | RM3100_CMM_Y | RM3100_CMM_Z | RM3100_CMM_START);
> >> +	if (ret < 0)
> >> +		return ret;
> >> +
> >> +	ret =3D devm_add_action(dev, rm3100_remove, data);
> >> +	if (ret < 0) {
> >> +		rm3100_remove(data);
> >> +		return ret;
> >> +	}
> >> +
> >> +	return devm_iio_device_register(dev, indio_dev);
> >> +}
> >> +EXPORT_SYMBOL_GPL(rm3100_common_probe);
> >> +
> >> +MODULE_AUTHOR("Song Qiang <songqiang1304521@gmail.com>");
> >> +MODULE_DESCRIPTION("PNI RM3100 3-axis magnetometer i2c driver");
> >> +MODULE_LICENSE("GPL v2");
> >> diff --git a/drivers/iio/magnetometer/rm3100-i2c.c b/drivers/iio/magne=
tometer/rm3100-i2c.c
> >> new file mode 100644
> >> index 000000000000..8f02e0366886
> >> --- /dev/null
> >> +++ b/drivers/iio/magnetometer/rm3100-i2c.c
> >> @@ -0,0 +1,58 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * Support for PNI RM3100 3-axis geomagnetic sensor on a i2c bus.
> >> + *
> >> + * Copyright (C) 2018 Song Qiang <songqiang1304521@gmail.com>
> >> + *
> >> + * i2c slave address: 0x20 + SA1 << 1 + SA0.
> >> + */
> >> +
> >> +#include <linux/i2c.h>
> >> +#include <linux/module.h>
> >> +
> >> +#include "rm3100.h"
> >> +
> >> +static const struct regmap_config rm3100_regmap_config =3D {
> >> +	.reg_bits =3D 8,
> >> +	.val_bits =3D 8,
> >> +
> >> +	.rd_table =3D &rm3100_readable_table,
> >> +	.wr_table =3D &rm3100_writable_table,
> >> +	.volatile_table =3D &rm3100_volatile_table,
> >> +
> >> +	.cache_type =3D REGCACHE_RBTREE,
> >> +};
> >> +
> >> +static int rm3100_probe(struct i2c_client *client)
> >> +{
> >> +	struct regmap *regmap;
> >> +
> >> +	if (!i2c_check_functionality(client->adapter,
> >> +		I2C_FUNC_SMBUS_READ_I2C_BLOCK | I2C_FUNC_SMBUS_BYTE_DATA))
> >> +		return -EOPNOTSUPP;
> >> +
> >> +	regmap =3D  devm_regmap_init_i2c(client, &rm3100_regmap_config);
> >> +	if (IS_ERR(regmap))
> >> +		return PTR_ERR(regmap);
> >> +
> >> +	return rm3100_common_probe(&client->dev, regmap, client->irq);
> >> +}
> >> +
> >> +static const struct of_device_id rm3100_dt_match[] =3D {
> >> +	{ .compatible =3D "pni,rm3100", },
> >> +	{ }
> >> +};
> >> +MODULE_DEVICE_TABLE(of, rm3100_dt_match);
> >> +
> >> +static struct i2c_driver rm3100_driver =3D {
> >> +	.driver =3D {
> >> +		.name =3D "rm3100-i2c",
> >> +		.of_match_table =3D rm3100_dt_match,
> >> +	},
> >> +	.probe_new =3D rm3100_probe,
> >> +};
> >> +module_i2c_driver(rm3100_driver);
> >> +
> >> +MODULE_AUTHOR("Song Qiang <songqiang1304521@gmail.com>");
> >> +MODULE_DESCRIPTION("PNI RM3100 3-axis magnetometer i2c driver");
> >> +MODULE_LICENSE("GPL v2");
> >> diff --git a/drivers/iio/magnetometer/rm3100-spi.c b/drivers/iio/magne=
tometer/rm3100-spi.c
> >> new file mode 100644
> >> index 000000000000..65d5eb9e4f5e
> >> --- /dev/null
> >> +++ b/drivers/iio/magnetometer/rm3100-spi.c
> >> @@ -0,0 +1,64 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * Support for PNI RM3100 3-axis geomagnetic sensor on a spi bus.
> >> + *
> >> + * Copyright (C) 2018 Song Qiang <songqiang1304521@gmail.com>
> >> + */
> >> +
> >> +#include <linux/module.h>
> >> +#include <linux/spi/spi.h>
> >> +
> >> +#include "rm3100.h"
> >> +
> >> +static const struct regmap_config rm3100_regmap_config =3D {
> >> +	.reg_bits =3D 8,
> >> +	.val_bits =3D 8,
> >> +
> >> +	.rd_table =3D &rm3100_readable_table,
> >> +	.wr_table =3D &rm3100_writable_table,
> >> +	.volatile_table =3D &rm3100_volatile_table,
> >> +
> >> +	.read_flag_mask =3D 0x80,
> >> +
> >> +	.cache_type =3D REGCACHE_RBTREE,
> >> +};
> >> +
> >> +static int rm3100_probe(struct spi_device *spi)
> >> +{
> >> +	struct regmap *regmap;
> >> +	int ret;
> >> +
> >> +	/* Actually this device supports both mode 0 and mode 3. */
> >> +	spi->mode =3D SPI_MODE_0;
> >> +	/* Data rates cannot exceed 1Mbits. */
> >> +	spi->max_speed_hz =3D 1000000;
> >> +	spi->bits_per_word =3D 8;
> >> +	ret =3D spi_setup(spi);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	regmap =3D devm_regmap_init_spi(spi, &rm3100_regmap_config);
> >> +	if (IS_ERR(regmap))
> >> +		return PTR_ERR(regmap);
> >> +
> >> +	return rm3100_common_probe(&spi->dev, regmap, spi->irq);
> >> +}
> >> +
> >> +static const struct of_device_id rm3100_dt_match[] =3D {
> >> +	{ .compatible =3D "pni,rm3100", },
> >> +	{ }
> >> +};
> >> +MODULE_DEVICE_TABLE(of, rm3100_dt_match);
> >> +
> >> +static struct spi_driver rm3100_driver =3D {
> >> +	.driver =3D {
> >> +		.name =3D "rm3100-spi",
> >> +		.of_match_table =3D rm3100_dt_match,
> >> +	},
> >> +	.probe =3D rm3100_probe,
> >> +};
> >> +module_spi_driver(rm3100_driver);
> >> +
> >> +MODULE_AUTHOR("Song Qiang <songqiang1304521@gmail.com>");
> >> +MODULE_DESCRIPTION("PNI RM3100 3-axis magnetometer spi driver");
> >> +MODULE_LICENSE("GPL v2");
> >> diff --git a/drivers/iio/magnetometer/rm3100.h b/drivers/iio/magnetome=
ter/rm3100.h
> >> new file mode 100644
> >> index 000000000000..c3508218bc77
> >> --- /dev/null
> >> +++ b/drivers/iio/magnetometer/rm3100.h
> >> @@ -0,0 +1,17 @@
> >> +/* SPDX-License-Identifier: GPL-2.0 */
> >> +/*
> >> + * Copyright (C) 2018 Song Qiang <songqiang1304521@gmail.com>
> >> + */
> >> +
> >> +#ifndef RM3100_CORE_H
> >> +#define RM3100_CORE_H
> >> +
> >> +#include <linux/regmap.h>
> >> +
> >> +extern const struct regmap_access_table rm3100_readable_table;
> >> +extern const struct regmap_access_table rm3100_writable_table;
> >> +extern const struct regmap_access_table rm3100_volatile_table;
> >> +
> >> +int rm3100_common_probe(struct device *dev, struct regmap *regmap, in=
t irq);
> >> +
> >> +#endif /* RM3100_CORE_H */ =20
>=20

