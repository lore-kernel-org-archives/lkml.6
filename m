Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690F3C43444
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 17:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48D142086C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 17:48:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfALRs3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 12:48:29 -0500
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:34082 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbfALRs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 12:48:29 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id BFBE19E7A7E;
        Sat, 12 Jan 2019 17:48:25 +0000 (GMT)
Date:   Sat, 12 Jan 2019 17:48:22 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Tomasz Duszynski <tduszyns@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: chemical: add support for Plantower PMS7003
 sensor
Message-ID: <20190112174822.25e36471@archlinux>
In-Reply-To: <20190106171614.12615-2-tduszyns@gmail.com>
References: <20190106171614.12615-1-tduszyns@gmail.com>
        <20190106171614.12615-2-tduszyns@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  6 Jan 2019 18:16:12 +0100
Tomasz Duszynski <tduszyns@gmail.com> wrote:

> Add support for Plantower PMS7003 particulate matter sensor.
> 
> Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>

A few minor bits and pieces from me.

Jonathan

> ---
>  drivers/iio/chemical/Kconfig   |  10 +
>  drivers/iio/chemical/Makefile  |   1 +
>  drivers/iio/chemical/pms7003.c | 411 +++++++++++++++++++++++++++++++++
>  3 files changed, 422 insertions(+)
>  create mode 100644 drivers/iio/chemical/pms7003.c
> 
> diff --git a/drivers/iio/chemical/Kconfig b/drivers/iio/chemical/Kconfig
> index 57832b4360e9..d5d146e9e372 100644
> --- a/drivers/iio/chemical/Kconfig
> +++ b/drivers/iio/chemical/Kconfig
> @@ -61,6 +61,16 @@ config IAQCORE
>  	  iAQ-Core Continuous/Pulsed VOC (Volatile Organic Compounds)
>  	  sensors
>  
> +config PMS7003
> +	tristate "Plantower PMS7003 particulate matter sensor"
> +	depends on SERIAL_DEV_BUS
> +	help
> +	  Say Y here to build support for the Plantower PMS7003 particulate
> +	  matter sensor.
> +
> +	  To compile this driver as a module, choose M here: the module will
> +	  be called pms7003.
> +
>  config SPS30
>  	tristate "SPS30 particulate matter sensor"
>  	depends on I2C
> diff --git a/drivers/iio/chemical/Makefile b/drivers/iio/chemical/Makefile
> index 65bf0f89c0e4..f5d1365acb49 100644
> --- a/drivers/iio/chemical/Makefile
> +++ b/drivers/iio/chemical/Makefile
> @@ -9,6 +9,7 @@ obj-$(CONFIG_BME680_I2C) += bme680_i2c.o
>  obj-$(CONFIG_BME680_SPI) += bme680_spi.o
>  obj-$(CONFIG_CCS811)		+= ccs811.o
>  obj-$(CONFIG_IAQCORE)		+= ams-iaq-core.o
> +obj-$(CONFIG_PMS7003) += pms7003.o
>  obj-$(CONFIG_SENSIRION_SGP30)	+= sgp30.o
>  obj-$(CONFIG_SPS30) += sps30.o
>  obj-$(CONFIG_VZ89X)		+= vz89x.o
> diff --git a/drivers/iio/chemical/pms7003.c b/drivers/iio/chemical/pms7003.c
> new file mode 100644
> index 000000000000..bc8a4fbdf641
> --- /dev/null
> +++ b/drivers/iio/chemical/pms7003.c
> @@ -0,0 +1,411 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Plantower PMS7003 particulate matter sensor driver
> + *
> + * Copyright (c) Tomasz Duszynski <tduszyns@gmail.com>
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <asm/unaligned.h>
> +#include <linux/completion.h>
> +#include <linux/device.h>
> +#include <linux/errno.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> +#include <linux/jiffies.h>
> +#include <linux/kernel.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/serdev.h>
> +
> +#define PMS7003_DRIVER_NAME "pms7003"
> +
> +#define PMS7003_MAGIC_MSB 0x42
> +#define PMS7003_MAGIC_LSB 0x4d
> +/* last 2 data bytes hold frame checksum */
> +#define PMS7003_MAX_DATA_LENGTH 28
> +#define PMS7003_CHECKSUM_LENGTH 2
> +#define PMS7003_PM10_OFFSET 10
> +#define PMS7003_PM2P5_OFFSET 8
> +#define PMS7003_PM1_OFFSET 6
> +
> +#define PMS7003_TIMEOUT msecs_to_jiffies(6000)
> +#define PMS7003_CMD_LENGTH 7
> +#define PMS7003_PM_MAX 1000
> +#define PMS7003_PM_MIN 0
> +
> +enum {
> +	PM1,
> +	PM2P5,
> +	PM10,
> +};
> +
> +enum {
> +	CMD_WAKEUP,
> +	CMD_ENTER_PASSIVE_MODE,
> +	CMD_READ_PASSIVE,
> +	CMD_SLEEP,
> +};
> +
> +enum {
> +	STATE_MAGIC_MSB,
> +	STATE_MAGIC_LSB,
> +	STATE_LENGTH_MSB,
> +	STATE_LENGTH_LSB,
> +	STATE_DATA,
> +};
> +
> +struct pms7003_frame {
> +	u8 data[PMS7003_MAX_DATA_LENGTH];
> +	u16 expected_length;
> +	u16 length;
> +	int state;
> +};
> +
> +struct pms7003_state {
> +	struct serdev_device *serdev;
> +	struct pms7003_frame frame;
> +	struct completion frame_ready;
> +	struct mutex lock; /* must be held whenever state gets touched */
> +};
> +
> +static u16 pms7003_calc_checksum(const u8 *data, int size)
> +{
> +	u16 checksum = 0;
> +
> +	while (size--)
> +		checksum += data[size];
> +
> +	return checksum;
> +}
> +
> +static int pms7003_do_cmd(struct pms7003_state *state, u8 cmd)

Use the enum not u8.

> +{
> +	/*
> +	 * commands have following format:
> +	 *
> +	 * +------+------+-----+------+-----+-----------+-----------+
> +	 * | 0x42 | 0x4d | cmd | 0x00 | arg | cksum msb | cksum lsb |
> +	 * +------+------+-----+------+-----+-----------+-----------+
> +	 */
> +	u8 tmp[PMS7003_CMD_LENGTH] = { PMS7003_MAGIC_MSB, PMS7003_MAGIC_LSB };
> +	int ret, n = 2;
> +	u16 checksum;
> +
> +	switch (cmd) {
> +	case CMD_WAKEUP:
> +		tmp[n++] = 0xe4;
> +		tmp[n++] = 0x00;
> +		tmp[n++] = 0x01;
> +		break;
> +	case CMD_ENTER_PASSIVE_MODE:
> +		tmp[n++] = 0xe1;
> +		tmp[n++] = 0x00;
> +		tmp[n++] = 0x00;
> +		break;
> +	case CMD_READ_PASSIVE:
> +		tmp[n++] = 0xe2;
> +		tmp[n++] = 0x00;
> +		tmp[n++] = 0x00;
> +		break;
> +	case CMD_SLEEP:
> +		tmp[n++] = 0xe4;
> +		tmp[n++] = 0x00;
> +		tmp[n++] = 0x00;

These look like they should be in a look up table to me rather than the more
verbose switch statement.

> +		break;
> +	}
> +
> +	checksum = pms7003_calc_checksum(tmp, n);

This is fixed for all calls of a given command (I think).  If so, it would
be good to precompute it (on startup for example, ideally letting the compiler
figure it out if it can).

> +	put_unaligned_be16(checksum, tmp + n);
> +	n += PMS7003_CHECKSUM_LENGTH;
> +
> +	ret = serdev_device_write(state->serdev, tmp, n, PMS7003_TIMEOUT);
> +	if (ret)
> +		return ret;
> +
> +	ret = wait_for_completion_interruptible_timeout(&state->frame_ready,
> +							PMS7003_TIMEOUT);
> +	if (!ret)
> +		ret = -ETIMEDOUT;
> +
> +	return ret < 0 ? ret : 0;
> +}
> +
> +static u16 pms7003_get_pm(struct pms7003_frame *frame, int offset)
> +{
> +	return clamp_val(get_unaligned_be16(frame->data + offset),
> +			 PMS7003_PM_MIN, PMS7003_PM_MAX);
> +}
> +
> +static irqreturn_t pms7003_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct pms7003_state *state = iio_priv(indio_dev);
> +	struct pms7003_frame *frame = &state->frame;
> +	u16 data[3 + 1 + 4]; /* PM1, PM2P5, PM10, padding, timestamp */
> +	int ret;
> +
> +	mutex_lock(&state->lock);
> +	ret = pms7003_do_cmd(state, CMD_READ_PASSIVE);
> +	if (ret) {
> +		mutex_unlock(&state->lock);
> +		goto err;
> +	}
> +
> +	data[PM1] = pms7003_get_pm(frame, PMS7003_PM1_OFFSET);
> +	data[PM2P5] = pms7003_get_pm(frame, PMS7003_PM2P5_OFFSET);
> +	data[PM10] = pms7003_get_pm(frame, PMS7003_PM10_OFFSET);

> +	mutex_unlock(&state->lock);
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, data,
> +					   iio_get_time_ns(indio_dev));
> +err:
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int pms7003_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val, int *val2, long mask)
> +{
> +	struct pms7003_state *state = iio_priv(indio_dev);
> +	struct pms7003_frame *frame = &state->frame;

This local variable for the frame can go away once you make the other
change suggested below.

> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_PROCESSED:
> +		switch (chan->type) {
> +		case IIO_MASSCONCENTRATION:
> +			mutex_lock(&state->lock);

Will this interfere in any way with buffered operation?  I'd normally
expect to see some claim_direct etc calls in here to prevent that.

> +			ret = pms7003_do_cmd(state, CMD_READ_PASSIVE);
> +			if (ret) {
> +				mutex_unlock(&state->lock);
> +				return ret;
> +			}
> +
> +			switch (chan->channel2) {
> +			case IIO_MOD_PM1:
> +				*val = pms7003_get_pm(frame,
> +						      PMS7003_PM1_OFFSET);

Put the PMS7003_PM1_OFFSET in the address element of the channel then
you can get rid fo this switch statement.

> +				break;
> +			case IIO_MOD_PM2P5:
> +				*val = pms7003_get_pm(frame,
> +						      PMS7003_PM2P5_OFFSET);
> +				break;
> +			case IIO_MOD_PM10:
> +				*val = pms7003_get_pm(frame,
> +						      PMS7003_PM10_OFFSET);
> +				break;

Just possible some compiler will give us warnings for the lack of a default
in here.  Might be worth putting one in to avoid that noise.
Particularly as you already have one for the chan->type.

> +			}
> +			mutex_unlock(&state->lock);
> +
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +
> +static const struct iio_info pms7003_info = {
> +	.read_raw = pms7003_read_raw,
> +};
> +
> +#define PMS7003_CHAN(_index, _mod) { \
> +	.type = IIO_MASSCONCENTRATION, \
> +	.modified = 1, \
> +	.channel2 = IIO_MOD_ ## _mod, \
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED), \
> +	.scan_index = _index, \
> +	.scan_type = { \
> +		.sign = 'u', \
> +		.realbits = 10, \
> +		.storagebits = 16, \
> +		.endianness = IIO_CPU, \
> +	}, \
> +}
> +
> +static const struct iio_chan_spec pms7003_channels[] = {
> +	PMS7003_CHAN(0, PM1),
> +	PMS7003_CHAN(1, PM2P5),
> +	PMS7003_CHAN(2, PM10),
> +	IIO_CHAN_SOFT_TIMESTAMP(3),
> +};
> +
> +static int pms7003_frame_okay(struct pms7003_frame *frame)
> +{
> +	int offset = frame->length - PMS7003_CHECKSUM_LENGTH;
> +	u16 checksum = PMS7003_MAGIC_MSB + PMS7003_MAGIC_LSB +
> +		       (frame->length >> 8) + (u8)frame->length +
> +		       pms7003_calc_checksum(frame->data, offset);
> +
> +	return checksum == get_unaligned_be16(frame->data + offset);
> +}
> +

The returning of 1 or 0 is not entirely obvious.  Please provide
some documentation on what that is doing.

This doesn't seem like an entirely obvious construct in general.

Given we can't (I think) do anything much useful with the data until
we get a whole frame, why not simply buffer it up unprocessed until
we have enough data to process it in one go?

On first packet dump data until you get that start markers.  After that
wait until you have the 'header' (length) and then wait until all data
is available keeping it in a raw buffer.

A state machine that is a simple step through like this one with only
one path ends up less readable to my eye than buffer data and
process when all there...


> +static int pms7003_update_frame(struct pms7003_frame *frame, u8 byte)
> +{
> +	switch (frame->state) {
> +	case STATE_MAGIC_MSB:
> +		if (byte != PMS7003_MAGIC_MSB)
> +			return 1;
> +		frame->state = STATE_MAGIC_LSB;
> +		frame->length = 0;
> +		return 1;
> +	case STATE_MAGIC_LSB:
> +		if (byte != PMS7003_MAGIC_LSB) {
> +			frame->state = STATE_MAGIC_MSB;
> +			return 1;
> +		}
> +		frame->state = STATE_LENGTH_MSB;
> +		return 1;
> +	case STATE_LENGTH_MSB:
> +		frame->expected_length = (u16)byte << 8;
> +		frame->state = STATE_LENGTH_LSB;
> +		return 1;
> +	case STATE_LENGTH_LSB:
> +		frame->expected_length |= byte;
> +		frame->state = STATE_DATA;
> +		return 1;
> +	case STATE_DATA:
> +		if (frame->length > PMS7003_MAX_DATA_LENGTH) {
> +			frame->state = STATE_MAGIC_MSB;
> +			return 1;
> +		}
> +
> +		frame->data[frame->length++] = byte;
> +
> +		if (frame->length != frame->expected_length)
> +			return 1;
> +
> +		if (!pms7003_frame_okay(frame)) {
> +			frame->state = STATE_MAGIC_MSB;
> +			return 1;
> +		}
> +
> +		frame->state = STATE_MAGIC_MSB;
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static int pms7003_receive_buf(struct serdev_device *serdev,
> +			       const unsigned char *buf, size_t size)
> +{
> +	struct iio_dev *indio_dev = serdev_device_get_drvdata(serdev);
> +	struct pms7003_state *state = iio_priv(indio_dev);
> +	struct pms7003_frame *frame = &state->frame;
> +	int i, ret;
> +
> +	for (i = 0; i < size; i++) {
> +		ret = pms7003_update_frame(frame, buf[i]);
> +		if (ret)
> +			continue;
Given this is the normal path (continue) I would invert the
logic to be
	if (!ret) {
		complete
		return..
	}

Trivial but perhaps slightly easier to follow.

> +
> +		complete(&state->frame_ready);
> +		return i + 1;
> +	}
> +
> +	return size;
> +}
> +
> +static const struct serdev_device_ops pms7003_serdev_ops = {
> +	.receive_buf = pms7003_receive_buf,
> +	.write_wakeup = serdev_device_write_wakeup,
> +};
> +
> +static void pms7003_stop(void *data)
> +{
> +	struct pms7003_state *state = data;
> +
> +	pms7003_do_cmd(state, CMD_SLEEP);
> +}
> +
> +static const unsigned long pms7003_scan_masks[] = { 0x07, 0x00 };
> +
> +static int pms7003_probe(struct serdev_device *serdev)
> +{
> +	struct pms7003_state *state;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&serdev->dev, sizeof(*state));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	state = iio_priv(indio_dev);
> +	serdev_device_set_drvdata(serdev, indio_dev);
> +	state->serdev = serdev;
> +	indio_dev->dev.parent = &serdev->dev;
> +	indio_dev->info = &pms7003_info;
> +	indio_dev->name = PMS7003_DRIVER_NAME;
> +	indio_dev->channels = pms7003_channels,
> +	indio_dev->num_channels = ARRAY_SIZE(pms7003_channels);
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->available_scan_masks = pms7003_scan_masks;
> +
> +	mutex_init(&state->lock);
> +	init_completion(&state->frame_ready);
> +
> +	serdev_device_set_client_ops(serdev, &pms7003_serdev_ops);
> +	ret = devm_serdev_device_open(&serdev->dev, serdev);
> +	if (ret)
> +		return ret;
> +
> +	serdev_device_set_baudrate(serdev, 9600);
> +	serdev_device_set_flow_control(serdev, false);
> +
> +	ret = serdev_device_set_parity(serdev, SERDEV_PARITY_NONE);
> +	if (ret)
> +		return ret;
> +
> +	ret = pms7003_do_cmd(state, CMD_WAKEUP);
> +	if (ret) {
> +		dev_err(&serdev->dev, "failed to wakeup sensor\n");
> +		return ret;
> +	}
> +
> +	ret = pms7003_do_cmd(state, CMD_ENTER_PASSIVE_MODE);
> +	if (ret) {
> +		dev_err(&serdev->dev, "failed to enter passive mode\n");
> +		return ret;
> +	}
> +
> +	ret = devm_add_action_or_reset(&serdev->dev, pms7003_stop, state);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_iio_triggered_buffer_setup(&serdev->dev, indio_dev, NULL,
> +					      pms7003_trigger_handler, NULL);
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(&serdev->dev, indio_dev);
> +}
> +
> +static const struct of_device_id pms7003_of_match[] = {
> +	{ .compatible = "plantower,pms7003" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, pms7003_of_match);
> +
> +static struct serdev_device_driver pms7003_driver = {
> +	.driver = {
> +		.name = PMS7003_DRIVER_NAME,
> +		.of_match_table = pms7003_of_match,
> +	},
> +	.probe = pms7003_probe,
> +};
> +module_serdev_device_driver(pms7003_driver);
> +
> +MODULE_AUTHOR("Tomasz Duszynski <tduszyns@gmail.com>");
> +MODULE_DESCRIPTION("Plantower PMS7003 particulate matter sensor driver");
> +MODULE_LICENSE("GPL v2");

