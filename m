Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C43C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B344217FA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:18:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388721AbfBKUS3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 15:18:29 -0500
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:53254 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727377AbfBKUS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 15:18:28 -0500
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 8F3179E765B;
        Mon, 11 Feb 2019 20:18:25 +0000 (GMT)
Date:   Mon, 11 Feb 2019 20:18:23 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Tomasz Duszynski <tduszyns@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org, pmeerw@pmeerw.net,
        johan@kernel.org
Subject: Re: [PATCH v4 1/3] iio: chemical: add support for Plantower PMS7003
 sensor
Message-ID: <20190211201823.3f7ed47c@archlinux>
In-Reply-To: <20190209173609.13220-2-tduszyns@gmail.com>
References: <20190209173609.13220-1-tduszyns@gmail.com>
        <20190209173609.13220-2-tduszyns@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  9 Feb 2019 18:36:07 +0100
Tomasz Duszynski <tduszyns@gmail.com> wrote:

> Add support for Plantower PMS7003 particulate matter sensor.
> 
> Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

I made a really small tweak to suppress a truncation
warning I just got testing building.  Not sure why GCC has started
getting fussy about deliberate casts.

thanks,

Jonathan

> ---
>  drivers/iio/chemical/Kconfig   |  10 +
>  drivers/iio/chemical/Makefile  |   1 +
>  drivers/iio/chemical/pms7003.c | 340 +++++++++++++++++++++++++++++++++
>  3 files changed, 351 insertions(+)
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
> index 000000000000..0c913c60adde
> --- /dev/null
> +++ b/drivers/iio/chemical/pms7003.c
> @@ -0,0 +1,340 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Plantower PMS7003 particulate matter sensor driver
> + *
> + * Copyright (c) Tomasz Duszynski <tduszyns@gmail.com>
> + */
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
> +#define PMS7003_MAGIC 0x424d
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
> +enum pms7003_cmd {
> +	CMD_WAKEUP,
> +	CMD_ENTER_PASSIVE_MODE,
> +	CMD_READ_PASSIVE,
> +	CMD_SLEEP,
> +};
> +
> +/*
> + * commands have following format:
> + *
> + * +------+------+-----+------+-----+-----------+-----------+
> + * | 0x42 | 0x4d | cmd | 0x00 | arg | cksum msb | cksum lsb |
> + * +------+------+-----+------+-----+-----------+-----------+
> + */
> +static const u8 pms7003_cmd_tbl[][PMS7003_CMD_LENGTH] = {
> +	[CMD_WAKEUP] = { 0x42, 0x4d, 0xe4, 0x00, 0x01, 0x01, 0x74 },
> +	[CMD_ENTER_PASSIVE_MODE] = { 0x42, 0x4d, 0xe1, 0x00, 0x00, 0x01, 0x70 },
> +	[CMD_READ_PASSIVE] = { 0x42, 0x4d, 0xe2, 0x00, 0x00, 0x01, 0x71 },
> +	[CMD_SLEEP] = { 0x42, 0x4d, 0xe4, 0x00, 0x00, 0x01, 0x73 },
> +};
> +
> +struct pms7003_frame {
> +	u8 data[PMS7003_MAX_DATA_LENGTH];
> +	u16 expected_length;
> +	u16 length;
> +};
> +
> +struct pms7003_state {
> +	struct serdev_device *serdev;
> +	struct pms7003_frame frame;
> +	struct completion frame_ready;
> +	struct mutex lock; /* must be held whenever state gets touched */
> +};
> +
> +static int pms7003_do_cmd(struct pms7003_state *state, enum pms7003_cmd cmd)
> +{
> +	int ret;
> +
> +	ret = serdev_device_write(state->serdev, pms7003_cmd_tbl[cmd],
> +				  PMS7003_CMD_LENGTH, PMS7003_TIMEOUT);
> +	if (ret < PMS7003_CMD_LENGTH)
> +		return ret < 0 ? ret : -EIO;
> +
> +	ret = wait_for_completion_interruptible_timeout(&state->frame_ready,
> +							PMS7003_TIMEOUT);
> +	if (!ret)
> +		ret = -ETIMEDOUT;
> +
> +	return ret < 0 ? ret : 0;
> +}
> +
> +static u16 pms7003_get_pm(const u8 *data)
> +{
> +	return clamp_val(get_unaligned_be16(data),
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
> +	data[PM1] = pms7003_get_pm(frame->data + PMS7003_PM1_OFFSET);
> +	data[PM2P5] = pms7003_get_pm(frame->data + PMS7003_PM2P5_OFFSET);
> +	data[PM10] = pms7003_get_pm(frame->data + PMS7003_PM10_OFFSET);
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
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_PROCESSED:
> +		switch (chan->type) {
> +		case IIO_MASSCONCENTRATION:
> +			mutex_lock(&state->lock);
> +			ret = pms7003_do_cmd(state, CMD_READ_PASSIVE);
> +			if (ret) {
> +				mutex_unlock(&state->lock);
> +				return ret;
> +			}
> +
> +			*val = pms7003_get_pm(frame->data + chan->address);
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
> +static const struct iio_info pms7003_info = {
> +	.read_raw = pms7003_read_raw,
> +};
> +
> +#define PMS7003_CHAN(_index, _mod, _addr) { \
> +	.type = IIO_MASSCONCENTRATION, \
> +	.modified = 1, \
> +	.channel2 = IIO_MOD_ ## _mod, \
> +	.address = _addr, \
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
> +	PMS7003_CHAN(0, PM1, PMS7003_PM1_OFFSET),
> +	PMS7003_CHAN(1, PM2P5, PMS7003_PM2P5_OFFSET),
> +	PMS7003_CHAN(2, PM10, PMS7003_PM10_OFFSET),
> +	IIO_CHAN_SOFT_TIMESTAMP(3),
> +};
> +
> +static u16 pms7003_calc_checksum(struct pms7003_frame *frame)
> +{
> +	u16 checksum = (PMS7003_MAGIC >> 8) + (u8)PMS7003_MAGIC +

So I'm getting a warning about truncating MAGIC by the cast.
I added a mask by 0xff as silly as it seems to suppress this.

Jonathan

> +		       (frame->length >> 8) + (u8)frame->length;
> +	int i;
> +
> +	for (i = 0; i < frame->length - PMS7003_CHECKSUM_LENGTH; i++)
> +		checksum += frame->data[i];
> +
> +	return checksum;
> +}
> +
> +static bool pms7003_frame_is_okay(struct pms7003_frame *frame)
> +{
> +	int offset = frame->length - PMS7003_CHECKSUM_LENGTH;
> +	u16 checksum = get_unaligned_be16(frame->data + offset);
> +
> +	return checksum == pms7003_calc_checksum(frame);
> +}
> +
> +static int pms7003_receive_buf(struct serdev_device *serdev,
> +			       const unsigned char *buf, size_t size)
> +{
> +	struct iio_dev *indio_dev = serdev_device_get_drvdata(serdev);
> +	struct pms7003_state *state = iio_priv(indio_dev);
> +	struct pms7003_frame *frame = &state->frame;
> +	int num;
> +
> +	if (!frame->expected_length) {
> +		u16 magic;
> +
> +		/* wait for SOF and data length */
> +		if (size < 4)
> +			return 0;
> +
> +		magic = get_unaligned_be16(buf);
> +		if (magic != PMS7003_MAGIC)
> +			return 2;
> +
> +		num = get_unaligned_be16(buf + 2);
> +		if (num <= PMS7003_MAX_DATA_LENGTH) {
> +			frame->expected_length = num;
> +			frame->length = 0;
> +		}
> +
> +		return 4;
> +	}
> +
> +	num = min(size, (size_t)(frame->expected_length - frame->length));
> +	memcpy(frame->data + frame->length, buf, num);
> +	frame->length += num;
> +
> +	if (frame->length == frame->expected_length) {
> +		if (pms7003_frame_is_okay(frame))
> +			complete(&state->frame_ready);
> +
> +		frame->expected_length = 0;
> +	}
> +
> +	return num;
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

