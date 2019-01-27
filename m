Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D304C282CA
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 21:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCD6F2087F
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 21:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BjuZ6YeC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbfA0VHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 16:07:24 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39232 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727229AbfA0VHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 16:07:21 -0500
Received: by mail-lj1-f196.google.com with SMTP id t9-v6so12491417ljh.6;
        Sun, 27 Jan 2019 13:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HQUTB8RT3zlYl4iFhwCa2N5ux8u3zWUoC1PTQPwXrtQ=;
        b=BjuZ6YeC5qG+QxZFuajI6DKo4yF1wkdwV+6XrjEevuyI33QUcb+Fe35NMR4adXrWFG
         1NVOs04LCRf8bz1Go+dlNW02SLaS8Cs6EZlBJ/wS5IjwUCtoO1Ma0J9hF1/ajfiXVKUw
         k64piWMcnXsL6flWrWBa4jS3OcCAni+bTkRAhrWlXPC63kM2S2cScWHcQqeghONL4scU
         4bYe6lxOJIicnBKIvbQmG2PnDsAEtcf4wSHzmrXJ378iCRuDhPrQzXljkMJejDCViBOv
         8q8zSki5pP0JRjey4/W5175l116ZJzjkJXD68h1hIWze2R2EbDZPFKA93pqWBWOVk5l+
         3BNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HQUTB8RT3zlYl4iFhwCa2N5ux8u3zWUoC1PTQPwXrtQ=;
        b=UOHDJvMqnQ5zha2GQ5v/kShhCg9OQp1HHgwMkCEagLFTSFhliF1eTVpizTXRFymPO8
         W9tXoWD8uNYi0pcG96EJ3xT/3oGos/6JDeAGoqx9cAtkYz+dpUfhgGHY4V+2IRjVrCJS
         zT87YwWcaeHbKNjyq/yOssZUOr8NWjAdKIUesWzAyBAWR4UofsxosxPo+R3H2pHUkNc3
         CcJGZ+cvCJemQSfK9eZGok0AQShY2d+TeiwtbUSzfZgtg1LjHsjtY0oi2p0vH8F/zlYs
         f2uzeLkGoeZjCx56gQAgwj+8+WPYXdT3huRL5NXbtDDZyGnBQ+cYOuGaTQWvbYKskln0
         uHcA==
X-Gm-Message-State: AJcUukfBTSrrEctvr4YDponAH8j1tBvR/muLr9Q7wy/pAqr57FA3h739
        f0FeEY49IKFQw1CLO82pZXs=
X-Google-Smtp-Source: ALg8bN7qw73Fk5PmyiFKmRqtbxzLxoQXq8ndxb2l44L2U0f37I18r76A3YNIAgH6qPG9f0hxRK3wjQ==
X-Received: by 2002:a2e:8855:: with SMTP id z21-v6mr15030330ljj.191.1548623238148;
        Sun, 27 Jan 2019 13:07:18 -0800 (PST)
Received: from localhost (89-70-37-207.dynamic.chello.pl. [89.70.37.207])
        by smtp.gmail.com with ESMTPSA id q23sm2554637lfm.82.2019.01.27.13.07.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 27 Jan 2019 13:07:17 -0800 (PST)
Date:   Sun, 27 Jan 2019 22:06:54 +0100
From:   Tomasz Duszynski <tduszyns@gmail.com>
To:     Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Tomasz Duszynski <tduszyns@gmail.com>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, johan@kernel.org,
        jic23@jic23.retrosnub.co.uk
Subject: Re: [PATCH v2 1/3] iio: chemical: add support for Plantower PMS7003
 sensor
Message-ID: <20190127210650.GA21962@arch>
References: <20190127181916.19948-1-tduszyns@gmail.com>
 <20190127181916.19948-2-tduszyns@gmail.com>
 <alpine.DEB.2.21.1901271947290.20089@vps.pmeerw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1901271947290.20089@vps.pmeerw.net>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 27, 2019 at 07:53:58PM +0100, Peter Meerwald-Stadler wrote:
> On Sun, 27 Jan 2019, Tomasz Duszynski wrote:
>
> some minor comments below, looks good to me
>

Thanks for comments.

> > Add support for Plantower PMS7003 particulate matter sensor.
> >
> > Signed-off-by: Tomasz Duszynski <tduszyns@gmail.com>
> > ---
> >  drivers/iio/chemical/Kconfig   |  10 +
> >  drivers/iio/chemical/Makefile  |   1 +
> >  drivers/iio/chemical/pms7003.c | 343 +++++++++++++++++++++++++++++++++
> >  3 files changed, 354 insertions(+)
> >  create mode 100644 drivers/iio/chemical/pms7003.c
> >
> > diff --git a/drivers/iio/chemical/Kconfig b/drivers/iio/chemical/Kconfig
> > index 57832b4360e9..d5d146e9e372 100644
> > --- a/drivers/iio/chemical/Kconfig
> > +++ b/drivers/iio/chemical/Kconfig
> > @@ -61,6 +61,16 @@ config IAQCORE
> >  	  iAQ-Core Continuous/Pulsed VOC (Volatile Organic Compounds)
> >  	  sensors
> >
> > +config PMS7003
> > +	tristate "Plantower PMS7003 particulate matter sensor"
> > +	depends on SERIAL_DEV_BUS
> > +	help
> > +	  Say Y here to build support for the Plantower PMS7003 particulate
> > +	  matter sensor.
> > +
> > +	  To compile this driver as a module, choose M here: the module will
> > +	  be called pms7003.
> > +
> >  config SPS30
> >  	tristate "SPS30 particulate matter sensor"
> >  	depends on I2C
> > diff --git a/drivers/iio/chemical/Makefile b/drivers/iio/chemical/Makefile
> > index 65bf0f89c0e4..f5d1365acb49 100644
> > --- a/drivers/iio/chemical/Makefile
> > +++ b/drivers/iio/chemical/Makefile
> > @@ -9,6 +9,7 @@ obj-$(CONFIG_BME680_I2C) += bme680_i2c.o
> >  obj-$(CONFIG_BME680_SPI) += bme680_spi.o
> >  obj-$(CONFIG_CCS811)		+= ccs811.o
> >  obj-$(CONFIG_IAQCORE)		+= ams-iaq-core.o
> > +obj-$(CONFIG_PMS7003) += pms7003.o
> >  obj-$(CONFIG_SENSIRION_SGP30)	+= sgp30.o
> >  obj-$(CONFIG_SPS30) += sps30.o
> >  obj-$(CONFIG_VZ89X)		+= vz89x.o
> > diff --git a/drivers/iio/chemical/pms7003.c b/drivers/iio/chemical/pms7003.c
> > new file mode 100644
> > index 000000000000..b1ac4aeea989
> > --- /dev/null
> > +++ b/drivers/iio/chemical/pms7003.c
> > @@ -0,0 +1,343 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Plantower PMS7003 particulate matter sensor driver
> > + *
> > + * Copyright (c) Tomasz Duszynski <tduszyns@gmail.com>
> > + */
> > +
> > +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>
> pr_fmt() is not used
>

Good catch, indeed no calls to prink() in the driver code.

> > +
> > +#include <asm/unaligned.h>
> > +#include <linux/completion.h>
> > +#include <linux/device.h>
> > +#include <linux/errno.h>
> > +#include <linux/iio/buffer.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/trigger_consumer.h>
> > +#include <linux/iio/triggered_buffer.h>
> > +#include <linux/jiffies.h>
> > +#include <linux/kernel.h>
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/module.h>
> > +#include <linux/mutex.h>
> > +#include <linux/serdev.h>
> > +
> > +#define PMS7003_DRIVER_NAME "pms7003"
> > +
> > +#define PMS7003_MAGIC 0x424d
> > +/* last 2 data bytes hold frame checksum */
> > +#define PMS7003_MAX_DATA_LENGTH 28
> > +#define PMS7003_CHECKSUM_LENGTH 2
> > +#define PMS7003_PM10_OFFSET 10
> > +#define PMS7003_PM2P5_OFFSET 8
> > +#define PMS7003_PM1_OFFSET 6
> > +
> > +#define PMS7003_TIMEOUT msecs_to_jiffies(6000)
> > +#define PMS7003_CMD_LENGTH 7
> > +#define PMS7003_PM_MAX 1000
> > +#define PMS7003_PM_MIN 0
> > +
> > +enum {
> > +	PM1,
> > +	PM2P5,
> > +	PM10,
> > +};
> > +
> > +enum pms7003_cmd {
> > +	CMD_WAKEUP,
> > +	CMD_ENTER_PASSIVE_MODE,
> > +	CMD_READ_PASSIVE,
> > +	CMD_SLEEP,
> > +};
> > +
> > +/*
> > + * commands have following format:
> > + *
> > + * +------+------+-----+------+-----+-----------+-----------+
> > + * | 0x42 | 0x4d | cmd | 0x00 | arg | cksum msb | cksum lsb |
> > + * +------+------+-----+------+-----+-----------+-----------+
> > + */
> > +static const u8 pms7003_cmd_tbl[][PMS7003_CMD_LENGTH] = {
> > +	[CMD_WAKEUP] = { 0x42, 0x4d, 0xe4, 0x00, 0x01, 0x01, 0x74 },
> > +	[CMD_ENTER_PASSIVE_MODE] = { 0x42, 0x4d, 0xe1, 0x00, 0x00, 0x01, 0x70 },
> > +	[CMD_READ_PASSIVE] = { 0x42, 0x4d, 0xe2, 0x00, 0x00, 0x01, 0x71 },
> > +	[CMD_SLEEP] = { 0x42, 0x4d, 0xe4, 0x00, 0x00, 0x01, 0x73 },
> > +};
> > +
> > +struct pms7003_frame {
> > +	u8 data[PMS7003_MAX_DATA_LENGTH];
> > +	u16 expected_length;
> > +	u16 length;
> > +};
> > +
> > +struct pms7003_state {
> > +	struct serdev_device *serdev;
> > +	struct pms7003_frame frame;
> > +	struct completion frame_ready;
> > +	struct mutex lock; /* must be held whenever state gets touched */
> > +};
> > +
> > +static int pms7003_do_cmd(struct pms7003_state *state, enum pms7003_cmd cmd)
> > +{
> > +	int ret;
> > +
> > +	ret = serdev_device_write(state->serdev, pms7003_cmd_tbl[cmd],
> > +				  PMS7003_CMD_LENGTH, PMS7003_TIMEOUT);
> > +	if (ret < PMS7003_CMD_LENGTH)
> > +		return ret < 0 ? ret : -EIO;
> > +
> > +	ret = wait_for_completion_interruptible_timeout(&state->frame_ready,
> > +							PMS7003_TIMEOUT);
> > +	if (!ret)
> > +		ret = -ETIMEDOUT;
> > +
> > +	return ret < 0 ? ret : 0;
> > +}
> > +
> > +static u16 pms7003_get_pm(const u8 *data)
> > +{
> > +	return clamp_val(get_unaligned_be16(data),
> > +			 PMS7003_PM_MIN, PMS7003_PM_MAX);
> > +}
> > +
> > +static irqreturn_t pms7003_trigger_handler(int irq, void *p)
> > +{
> > +	struct iio_poll_func *pf = p;
> > +	struct iio_dev *indio_dev = pf->indio_dev;
> > +	struct pms7003_state *state = iio_priv(indio_dev);
> > +	struct pms7003_frame *frame = &state->frame;
> > +	u16 data[3 + 1 + 4]; /* PM1, PM2P5, PM10, padding, timestamp */
> > +	int ret;
> > +
> > +	mutex_lock(&state->lock);
> > +	ret = pms7003_do_cmd(state, CMD_READ_PASSIVE);
> > +	if (ret) {
> > +		mutex_unlock(&state->lock);
> > +		goto err;
> > +	}
> > +
> > +	data[PM1] = pms7003_get_pm(frame->data + PMS7003_PM1_OFFSET);
> > +	data[PM2P5] = pms7003_get_pm(frame->data + PMS7003_PM2P5_OFFSET);
> > +	data[PM10] = pms7003_get_pm(frame->data + PMS7003_PM10_OFFSET);
> > +	mutex_unlock(&state->lock);
> > +
> > +	iio_push_to_buffers_with_timestamp(indio_dev, data,
> > +					   iio_get_time_ns(indio_dev));
> > +err:
> > +	iio_trigger_notify_done(indio_dev->trig);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static int pms7003_read_raw(struct iio_dev *indio_dev,
> > +			    struct iio_chan_spec const *chan,
> > +			    int *val, int *val2, long mask)
> > +{
> > +	struct pms7003_state *state = iio_priv(indio_dev);
> > +	struct pms7003_frame *frame = &state->frame;
> > +	int ret;
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_PROCESSED:
> > +		switch (chan->type) {
> > +		case IIO_MASSCONCENTRATION:
> > +			mutex_lock(&state->lock);
> > +			ret = pms7003_do_cmd(state, CMD_READ_PASSIVE);
> > +			if (ret) {
> > +				mutex_unlock(&state->lock);
> > +				return ret;
> > +			}
> > +
> > +			*val = pms7003_get_pm(frame->data + chan->address);
> > +			mutex_unlock(&state->lock);
> > +
> > +			return IIO_VAL_INT;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +	}
> > +
> > +	return -EINVAL;
> > +}
> > +
>
> remove dup newline
>

Okay.

> > +
> > +static const struct iio_info pms7003_info = {
> > +	.read_raw = pms7003_read_raw,
> > +};
> > +
> > +#define PMS7003_CHAN(_index, _mod, _addr) { \
> > +	.type = IIO_MASSCONCENTRATION, \
> > +	.modified = 1, \
> > +	.channel2 = IIO_MOD_ ## _mod, \
> > +	.address = _addr, \
> > +	.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED), \
> > +	.scan_index = _index, \
> > +	.scan_type = { \
> > +		.sign = 'u', \
> > +		.realbits = 10, \
> > +		.storagebits = 16, \
> > +		.endianness = IIO_CPU, \
> > +	}, \
> > +}
> > +
> > +static const struct iio_chan_spec pms7003_channels[] = {
> > +	PMS7003_CHAN(0, PM1, PMS7003_PM1_OFFSET),
> > +	PMS7003_CHAN(1, PM2P5, PMS7003_PM2P5_OFFSET),
> > +	PMS7003_CHAN(2, PM10, PMS7003_PM10_OFFSET),
> > +	IIO_CHAN_SOFT_TIMESTAMP(3),
> > +};
> > +
> > +static u16 pms7003_calc_checksum(struct pms7003_frame *frame)
> > +{
> > +	u16 checksum = (PMS7003_MAGIC >> 8) + (u8)PMS7003_MAGIC +
> > +		       (frame->length >> 8) + (u8)frame->length;
> > +	int i;
> > +
> > +	for (i = 0; i < frame->length - PMS7003_CHECKSUM_LENGTH; i++)
> > +		checksum += frame->data[i];
> > +
> > +	return checksum;
> > +}
> > +
> > +static bool pms7003_frame_is_okay(struct pms7003_frame *frame)
> > +{
> > +	int offset = frame->length - PMS7003_CHECKSUM_LENGTH;
> > +	u16 checksum = get_unaligned_be16(frame->data + offset);
> > +
> > +	return checksum == pms7003_calc_checksum(frame);
> > +}
> > +
> > +static int pms7003_receive_buf(struct serdev_device *serdev,
>
> maybe add a comment what the return value of this function is
>

From what I see serdev header file already has some documentation
regarding this. Perhaps there's no real value in repeating it here
again.

> > +			       const unsigned char *buf, size_t size)
> > +{
> > +	struct iio_dev *indio_dev = serdev_device_get_drvdata(serdev);
> > +	struct pms7003_state *state = iio_priv(indio_dev);
> > +	struct pms7003_frame *frame = &state->frame;
> > +	int num;
> > +
> > +	if (!frame->expected_length) {
> > +		u16 magic;
> > +
> > +		/* wait for SOF  and data length */
>
> remove extra space after SOF
>

Okay.

> > +		if (size < 4)
> > +			return 0;
> > +
> > +		magic = get_unaligned_be16(buf);
> > +		if (magic != PMS7003_MAGIC)
> > +			return 2;
> > +
> > +		num = get_unaligned_be16(buf + 2);
>
> 2 is sizeof(MAGIC)
>

If you do not have particularly strong opinion on this one I would like
to leave it as is. Otherwise I would likely need to replace other
numbers in this branch with sizeofs due to consistency.

> > +		if (num <= PMS7003_MAX_DATA_LENGTH) {
> > +			frame->expected_length = num;
> > +			frame->length = 0;
> > +		}
> > +
> > +		return 4;
> > +	}
> > +
> > +	num = min(size, (size_t)(frame->expected_length - frame->length));
> > +	memcpy(frame->data + frame->length, buf, num);
> > +	frame->length += num;
> > +
> > +	if (frame->length == frame->expected_length) {
> > +		if (pms7003_frame_is_okay(frame))
> > +			complete(&state->frame_ready);
> > +
> > +		frame->expected_length = 0;
> > +	}
> > +
> > +	return num;
> > +}
> > +
> > +static const struct serdev_device_ops pms7003_serdev_ops = {
> > +	.receive_buf = pms7003_receive_buf,
> > +	.write_wakeup = serdev_device_write_wakeup,
> > +};
> > +
> > +static void pms7003_stop(void *data)
> > +{
> > +	struct pms7003_state *state = data;
> > +
> > +	pms7003_do_cmd(state, CMD_SLEEP);
> > +}
> > +
> > +static const unsigned long pms7003_scan_masks[] = { 0x07, 0x00 };
> > +
> > +static int pms7003_probe(struct serdev_device *serdev)
> > +{
> > +	struct pms7003_state *state;
> > +	struct iio_dev *indio_dev;
> > +	int ret;
> > +
> > +	indio_dev = devm_iio_device_alloc(&serdev->dev, sizeof(*state));
> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	state = iio_priv(indio_dev);
> > +	serdev_device_set_drvdata(serdev, indio_dev);
> > +	state->serdev = serdev;
> > +	indio_dev->dev.parent = &serdev->dev;
> > +	indio_dev->info = &pms7003_info;
> > +	indio_dev->name = PMS7003_DRIVER_NAME;
> > +	indio_dev->channels = pms7003_channels,
> > +	indio_dev->num_channels = ARRAY_SIZE(pms7003_channels);
> > +	indio_dev->modes = INDIO_DIRECT_MODE;
> > +	indio_dev->available_scan_masks = pms7003_scan_masks;
> > +
> > +	mutex_init(&state->lock);
> > +	init_completion(&state->frame_ready);
> > +
> > +	serdev_device_set_client_ops(serdev, &pms7003_serdev_ops);
> > +	ret = devm_serdev_device_open(&serdev->dev, serdev);
> > +	if (ret)
> > +		return ret;
> > +
> > +	serdev_device_set_baudrate(serdev, 9600);
> > +	serdev_device_set_flow_control(serdev, false);
> > +
> > +	ret = serdev_device_set_parity(serdev, SERDEV_PARITY_NONE);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = pms7003_do_cmd(state, CMD_WAKEUP);
> > +	if (ret) {
> > +		dev_err(&serdev->dev, "failed to wakeup sensor\n");
> > +		return ret;
> > +	}
> > +
> > +	ret = pms7003_do_cmd(state, CMD_ENTER_PASSIVE_MODE);
> > +	if (ret) {
> > +		dev_err(&serdev->dev, "failed to enter passive mode\n");
> > +		return ret;
> > +	}
> > +
> > +	ret = devm_add_action_or_reset(&serdev->dev, pms7003_stop, state);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = devm_iio_triggered_buffer_setup(&serdev->dev, indio_dev, NULL,
> > +					      pms7003_trigger_handler, NULL);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return devm_iio_device_register(&serdev->dev, indio_dev);
> > +}
> > +
> > +static const struct of_device_id pms7003_of_match[] = {
> > +	{ .compatible = "plantower,pms7003" },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(of, pms7003_of_match);
> > +
> > +static struct serdev_device_driver pms7003_driver = {
> > +	.driver = {
> > +		.name = PMS7003_DRIVER_NAME,
> > +		.of_match_table = pms7003_of_match,
> > +	},
> > +	.probe = pms7003_probe,
> > +};
> > +module_serdev_device_driver(pms7003_driver);
> > +
> > +MODULE_AUTHOR("Tomasz Duszynski <tduszyns@gmail.com>");
> > +MODULE_DESCRIPTION("Plantower PMS7003 particulate matter sensor driver");
> > +MODULE_LICENSE("GPL v2");
> >
>
> --
>
> Peter Meerwald-Stadler
> Mobile: +43 664 24 44 418
