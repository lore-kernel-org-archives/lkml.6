Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932675AbeDWXZF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 19:25:05 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34901 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932567AbeDWXZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 19:25:02 -0400
X-Google-Smtp-Source: AIpwx493TYLqMKFXKoIQw5Xt90FKCe6nx48Ht3S2nn4MRBDc1tqlH2+SV1j3dcbwAuMS6dKaBDQ7pQ==
Date: Mon, 23 Apr 2018 16:24:58 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Eugen Hristev <eugen.hristev@microchip.com>
Cc: jic23@kernel.org, ludovic.desroches@microchip.com,
        alexandre.belloni@bootlin.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
        nicolas.ferre@microchip.com, robh@kernel.org
Subject: Re: [PATCH v3 08/11] input: touchscreen: resistive-adc-touch: add
 generic resistive ADC touchscreen
Message-ID: <20180423232458.GG66646@dtor-ws>
References: <1523350677-27106-1-git-send-email-eugen.hristev@microchip.com>
 <1523350677-27106-9-git-send-email-eugen.hristev@microchip.com>
 <20180423232251.GF66646@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180423232251.GF66646@dtor-ws>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 04:22:51PM -0700, Dmitry Torokhov wrote:
> Hi Eugen,
> 
> On Tue, Apr 10, 2018 at 11:57:54AM +0300, Eugen Hristev wrote:
> > This adds a generic resistive touchscreen (GRTS) driver, which is based
> > on an IIO device (an ADC). It must be connected to the channels of an ADC
> > to receive touch data. Then it will feed the data into the input subsystem
> > where it registers an input device.
> > It uses an IIO callback buffer to register to the IIO device
> > 
> > Some parts of this patch are based on initial original work by
> > Mohamed Jamsheeth Hajanajubudeen and Bandaru Venkateswara Swamy
> > 
> > Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> > ---
> > Changes in v3:
> >  - pressure now reported naturally growing down-up
> >  - using helpers from touchscreen.h to parse DT properties
> >  - added devm_add_action_or_reset to handle callback buffer clean on exit
> >  - changed compatible and threshold property to adapt to changed bindings
> > 
> > Changes in v2:
> >  - this is now a generic resistive adc touchscreen driver
> > 
> >  drivers/input/touchscreen/Kconfig               |  13 ++
> >  drivers/input/touchscreen/Makefile              |   1 +
> >  drivers/input/touchscreen/resistive-adc-touch.c | 200 ++++++++++++++++++++++++
> >  3 files changed, 214 insertions(+)
> >  create mode 100644 drivers/input/touchscreen/resistive-adc-touch.c
> > 
> > diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> > index 4f15496..8f85d3a 100644
> > --- a/drivers/input/touchscreen/Kconfig
> > +++ b/drivers/input/touchscreen/Kconfig
> > @@ -92,6 +92,19 @@ config TOUCHSCREEN_AD7879_SPI
> >  	  To compile this driver as a module, choose M here: the
> >  	  module will be called ad7879-spi.
> >  
> > +config TOUCHSCREEN_ADC
> > +	tristate "Generic ADC based resistive touchscreen"
> > +	depends on IIO
> > +	select IIO_BUFFER_CB
> > +	help
> > +	  Say Y here if you want to use the generic ADC
> > +	  resistive touchscreen driver.
> > +
> > +	  If unsure, say N (but it's safe to say "Y").
> > +
> > +	  To compile this driver as a module, choose M here: the
> > +	  module will be called resistive-adc-touch.ko.
> > +
> >  config TOUCHSCREEN_AR1021_I2C
> >  	tristate "Microchip AR1020/1021 i2c touchscreen"
> >  	depends on I2C && OF
> > diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
> > index dddae79..843c7f9 100644
> > --- a/drivers/input/touchscreen/Makefile
> > +++ b/drivers/input/touchscreen/Makefile
> > @@ -13,6 +13,7 @@ obj-$(CONFIG_TOUCHSCREEN_AD7877)	+= ad7877.o
> >  obj-$(CONFIG_TOUCHSCREEN_AD7879)	+= ad7879.o
> >  obj-$(CONFIG_TOUCHSCREEN_AD7879_I2C)	+= ad7879-i2c.o
> >  obj-$(CONFIG_TOUCHSCREEN_AD7879_SPI)	+= ad7879-spi.o
> > +obj-$(CONFIG_TOUCHSCREEN_ADC)		+= resistive-adc-touch.o
> >  obj-$(CONFIG_TOUCHSCREEN_ADS7846)	+= ads7846.o
> >  obj-$(CONFIG_TOUCHSCREEN_AR1021_I2C)	+= ar1021_i2c.o
> >  obj-$(CONFIG_TOUCHSCREEN_ATMEL_MXT)	+= atmel_mxt_ts.o
> > diff --git a/drivers/input/touchscreen/resistive-adc-touch.c b/drivers/input/touchscreen/resistive-adc-touch.c
> > new file mode 100644
> > index 0000000..7e201ee
> > --- /dev/null
> > +++ b/drivers/input/touchscreen/resistive-adc-touch.c
> > @@ -0,0 +1,200 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * ADC generic resistive touchscreen (GRTS)
> > + *
> > + * Copyright (C) 2017,2018 Microchip Technology,
> > + * Author: Eugen Hristev <eugen.hristev@microchip.com>
> > + *
> > + */
> > +#include <linux/input.h>
> > +#include <linux/input/touchscreen.h>
> > +#include <linux/iio/consumer.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/of_device.h>
> > +#include <linux/platform_device.h>
> > +
> > +#define DRIVER_NAME					"resistive-adc-touch"
> > +#define GRTS_DEFAULT_PRESSURE_THRESHOLD			50000
> > +#define MAX_POS_MASK					GENMASK(11, 0)
> > +
> > +/**
> > + * grts_state - generic resistive touch screen information struct
> > + * @pressure_threshold:	number representing the threshold for the pressure
> > + * @pressure:		are we getting pressure info or not
> > + * @iio_chans:		list of channels acquired
> > + * @iio_cb:		iio_callback buffer for the data
> > + * @input:		the input device structure that we register
> > + * @prop:		touchscreen properties struct
> > + */
> > +struct grts_state {
> > +	u32				pressure_threshold;
> > +	bool				pressure;
> > +	struct iio_channel		*iio_chans;
> > +	struct iio_cb_buffer		*iio_cb;
> > +	struct input_dev		*input;
> > +	struct touchscreen_properties	prop;
> > +};
> > +
> > +static int grts_cb(const void *data, void *private)
> > +{
> > +	const u16 *touch_info = data;
> > +	struct grts_state *st = private;
> > +
> 
> Extra blank line.
> 
> > +	unsigned int x, y, press = 0xFFFF;
> 
> Why to you need to initialize "press"?
> 
> > +
> > +	/* channel data coming in buffer in the order below */
> > +	x = touch_info[0];
> > +	y = touch_info[1];
> > +	if (st->pressure)
> > +		press = touch_info[2];
> > +
> > +	if ((!x && !y) || (st->pressure && (press < st->pressure_threshold))) {
> > +		/* report end of touch */
> 
> Hm, so this makes "press" not pressure but resistance...

Sorry, ignore this and below. I misread the code.

> 
> > +		input_report_key(st->input, BTN_TOUCH, 0);
> > +		input_sync(st->input);
> > +		return 0;
> > +	}
> > +
> > +	/* report proper touch to subsystem*/
> > +	touchscreen_report_pos(st->input, &st->prop, x, y, false);
> > +	if (st->pressure)
> > +		input_report_abs(st->input, ABS_PRESSURE, press);
> 
> and if this is resistance, then you want to have:
> 
> 		input_report_abs(st->input, ABS_PRESSURE,
> 				 st->resistance_threshold - resistance);
> 
> > +	input_report_key(st->input, BTN_TOUCH, 1);
> > +	input_sync(st->input);
> > +
> > +	return 0;
> > +}
> > +
> > +static int grts_open(struct input_dev *dev)
> > +{
> > +	int error;
> > +	struct grts_state *st = input_get_drvdata(dev);
> > +
> > +	error = iio_channel_start_all_cb(st->iio_cb);
> > +	if (error) {
> > +		dev_err(dev->dev.parent, "failed to start callback buffer.\n");
> > +		return error;
> > +	}
> > +	return 0;
> > +}
> > +
> > +static void grts_close(struct input_dev *dev)
> > +{
> > +	struct grts_state *st = input_get_drvdata(dev);
> > +
> > +	iio_channel_stop_all_cb(st->iio_cb);
> > +}
> > +
> > +static void grts_disable(void *data)
> > +{
> > +	iio_channel_release_all_cb(data);
> > +}
> > +
> > +static int grts_probe(struct platform_device *pdev)
> > +{
> > +	struct grts_state *st;
> > +	struct input_dev *input;
> > +	struct device *dev = &pdev->dev;
> > +	struct device_node *node = dev->of_node;
> > +	struct iio_channel *chan;
> > +	int ret = 0;
> 
> Let's call this variable "error". There is also no need to initialize it
> to 0.
> 
> > +
> > +	st = devm_kzalloc(dev, sizeof(struct grts_state), GFP_KERNEL);
> > +	if (!st)
> > +		return -ENOMEM;
> > +
> > +	ret = of_property_read_u32(node, "touchscreen-threshold-pressure",
> > +				   &st->pressure_threshold);
> 
> Let's use generic device property API (device_property_read_u32).
> 
> 
> > +	if (ret < 0) {
> 
> I do not think of_ or device_ property API returns positive on success.
> So simply
> 
> 	if (error) {
> 		...
> 	}
> 
> > +		dev_dbg(dev, "can't get touchscreen pressure threshold property.\n");
> > +		st->pressure_threshold = GRTS_DEFAULT_PRESSURE_THRESHOLD;
> > +	}
> > +
> > +	/* get the channels from IIO device */
> > +	st->iio_chans = devm_iio_channel_get_all(dev);
> > +
> 
> Extra blank line.
> 
> > +	if (IS_ERR(st->iio_chans)) {
> > +		if (PTR_ERR(st->iio_chans) != -EPROBE_DEFER)
> > +			dev_err(dev, "can't get iio channels.\n");
> > +		return PTR_ERR(st->iio_chans);
> > +	}
> > +
> > +	chan = &st->iio_chans[0];
> > +	st->pressure = false;
> > +	while (chan && chan->indio_dev) {
> > +		if (!strcmp(chan->channel->datasheet_name, "pressure"))
> > +			st->pressure = true;
> > +		chan++;
> > +	}
> > +
> > +	input = devm_input_allocate_device(dev);
> > +	if (!input) {
> > +		dev_err(dev, "failed to allocate input device.\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	input->name = DRIVER_NAME;
> > +	input->id.bustype = BUS_HOST;
> > +	input->open = grts_open;
> > +	input->close = grts_close;
> > +
> > +	input_set_abs_params(input, ABS_X, 0, MAX_POS_MASK - 1, 0, 0);
> > +	input_set_abs_params(input, ABS_Y, 0, MAX_POS_MASK - 1, 0, 0);
> > +	if (st->pressure)
> > +		input_set_abs_params(input, ABS_PRESSURE, 0, 0xffffff, 0, 0);
> 
> I am sure we can figure the range given the resistance threshold.
> 
> > +
> > +	input->evbit[0] = BIT_MASK(EV_KEY) | BIT_MASK(EV_ABS);
> > +	input->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
> 
> Replace this 2 with
> 
> 	input_set_capability(input, EV_KEY, BTN_TOUCH);
> 
> > +
> > +	/* parse optional device tree properties */
> > +	touchscreen_parse_properties(input, false, &st->prop);
> > +
> > +	st->input = input;
> > +	input_set_drvdata(input, st);
> > +
> > +	ret = input_register_device(input);
> > +	if (ret) {
> > +		dev_err(dev, "failed to register input device.");
> > +		return ret;
> > +	}
> > +
> > +	st->iio_cb = iio_channel_get_all_cb(dev, grts_cb, st);
> > +
> > +	if (IS_ERR(st->iio_cb)) {
> > +		dev_err(dev, "failed to allocate callback buffer.\n");
> > +		ret =  PTR_ERR(st->iio_cb);
> > +		return ret;
> > +	}
> > +
> > +	ret = devm_add_action_or_reset(dev, grts_disable, st->iio_cb);
> 
> 	if (error)
> 		return error;
> 
> > +
> > +	platform_set_drvdata(pdev, st);
> 
> I do not think you are using platform device driver data anywhere.
> 
> > +
> > +	return ret;
> 
> Prefer explicit success returns, so
> 
> 	return 0;
> 
> > +}
> > +
> > +static const struct of_device_id grts_of_match[] = {
> > +	{
> > +		.compatible = "resistive-adc-touch",
> > +	}, {
> > +		/* sentinel */
> > +	},
> > +};
> > +
> > +MODULE_DEVICE_TABLE(of, grts_of_match);
> > +
> > +static struct platform_driver grts_driver = {
> > +	.probe = grts_probe,
> > +	.driver = {
> > +		   .name = DRIVER_NAME,
> 
> Keep indenting with tabs please.
> 
> > +		   .of_match_table = of_match_ptr(grts_of_match),
> > +	},
> > +};
> > +
> > +module_platform_driver(grts_driver);
> > +
> > +MODULE_AUTHOR("Eugen Hristev <eugen.hristev@microchip.com>");
> > +MODULE_DESCRIPTION("Generic ADC Resistive Touch Driver");
> > +MODULE_LICENSE("GPL v2");
> > -- 
> > 2.7.4
> > 
> 
> -- 
> Dmitry

-- 
Dmitry
