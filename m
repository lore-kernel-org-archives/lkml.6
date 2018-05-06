Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751886AbeEFRdu (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 13:33:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:51224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751774AbeEFRdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 13:33:47 -0400
Date: Sun, 6 May 2018 18:33:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Eugen Hristev <eugen.hristev@microchip.com>
Cc: <ludovic.desroches@microchip.com>, <alexandre.belloni@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-input@vger.kernel.org>, <nicolas.ferre@microchip.com>,
        <dmitry.torokhov@gmail.com>, <robh@kernel.org>
Subject: Re: [PATCH v4 6/9] input: touchscreen: resistive-adc-touch: add
 generic resistive ADC touchscreen
Message-ID: <20180506183341.36919ad2@archlinux>
In-Reply-To: <1525084335-11276-7-git-send-email-eugen.hristev@microchip.com>
References: <1525084335-11276-1-git-send-email-eugen.hristev@microchip.com>
        <1525084335-11276-7-git-send-email-eugen.hristev@microchip.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Apr 2018 13:32:12 +0300
Eugen Hristev <eugen.hristev@microchip.com> wrote:

> This adds a generic resistive touchscreen (GRTS) driver, which is based
> on an IIO device (an ADC). It must be connected to the channels of an ADC
> to receive touch data. Then it will feed the data into the input subsystem
> where it registers an input device.
> It uses an IIO callback buffer to register to the IIO device
> 
> Some parts of this patch are based on initial original work by
> Mohamed Jamsheeth Hajanajubudeen and Bandaru Venkateswara Swamy
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> ---
> Changes in v4:
>  - added a small description in file header
>  - changed MAX_POS_MASK to GRTS_MAX_POS_MASK
>  - initialized press with 0, as this value means no touch.
> press has to be initialized because compiler/checkpatch complains
> that can be used uninitialized.
>  - changed of_property_read_u32 to device_*
>  - set_abs_params for pressure will have range according to threshold
>  - changed evbit and keybit with set_capability call
>  - changed variable names to error instead of ret
>  - checked errors for add_action_or_reset
>  - cosmetic cleaning
> 
> Changes in v3:
>  - pressure now reported naturally growing down-up
>  - using helpers from touchscreen.h to parse DT properties
>  - added devm_add_action_or_reset to handle callback buffer clean on exit
>  - changed compatible and threshold property to adapt to changed bindings
> 
> Changes in v2:
>  - this is now a generic resistive adc touchscreen driver
> 
>  drivers/input/touchscreen/Kconfig               |  13 ++
>  drivers/input/touchscreen/Makefile              |   1 +
>  drivers/input/touchscreen/resistive-adc-touch.c | 199 ++++++++++++++++++++++++
>  3 files changed, 213 insertions(+)
>  create mode 100644 drivers/input/touchscreen/resistive-adc-touch.c
> 
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> index 4f15496..8f85d3a 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -92,6 +92,19 @@ config TOUCHSCREEN_AD7879_SPI
...
> +static int grts_probe(struct platform_device *pdev)
> +{
> +	struct grts_state *st;
> +	struct input_dev *input;
> +	struct device *dev = &pdev->dev;
> +	struct iio_channel *chan;
> +	int error;
> +
> +	st = devm_kzalloc(dev, sizeof(struct grts_state), GFP_KERNEL);
> +	if (!st)
> +		return -ENOMEM;
> +
> +	error = device_property_read_u32(dev, "touchscreen-threshold-pressure",
> +					 &st->pressure_threshold);
> +	if (error) {
> +		dev_dbg(dev, "can't get touchscreen pressure threshold property.\n");
> +		st->pressure_threshold = GRTS_DEFAULT_PRESSURE_THRESHOLD;
> +	}
> +
> +	/* get the channels from IIO device */
> +	st->iio_chans = devm_iio_channel_get_all(dev);
> +	if (IS_ERR(st->iio_chans)) {
> +		if (PTR_ERR(st->iio_chans) != -EPROBE_DEFER)
> +			dev_err(dev, "can't get iio channels.\n");
> +		return PTR_ERR(st->iio_chans);
> +	}
> +
> +	chan = &st->iio_chans[0];
> +	st->pressure = false;
> +	while (chan && chan->indio_dev) {
> +		if (!strcmp(chan->channel->datasheet_name, "pressure"))
> +			st->pressure = true;
> +		chan++;
> +	}
> +
> +	input = devm_input_allocate_device(dev);
> +	if (!input) {
> +		dev_err(dev, "failed to allocate input device.\n");
> +		return -ENOMEM;
> +	}
> +
> +	input->name = DRIVER_NAME;
> +	input->id.bustype = BUS_HOST;
> +	input->open = grts_open;
> +	input->close = grts_close;
> +
> +	input_set_abs_params(input, ABS_X, 0, GRTS_MAX_POS_MASK - 1, 0, 0);
> +	input_set_abs_params(input, ABS_Y, 0, GRTS_MAX_POS_MASK - 1, 0, 0);
> +	if (st->pressure)
> +		input_set_abs_params(input, ABS_PRESSURE,
> +				     st->pressure_threshold, 0xffff, 0, 0);
> +
> +	input_set_capability(input, EV_KEY, BTN_TOUCH);
> +
> +	/* parse optional device tree properties */
> +	touchscreen_parse_properties(input, false, &st->prop);
> +
> +	st->input = input;
> +	input_set_drvdata(input, st);
> +
> +	error = input_register_device(input);
> +	if (error) {
> +		dev_err(dev, "failed to register input device.");
> +		return error;
> +	}
> +
> +	st->iio_cb = iio_channel_get_all_cb(dev, grts_cb, st);
> +	if (IS_ERR(st->iio_cb)) {
> +		dev_err(dev, "failed to allocate callback buffer.\n");
> +		error =  PTR_ERR(st->iio_cb);
> +		return error;
> +	}
> +
> +	error = devm_add_action_or_reset(dev, grts_disable, st->iio_cb);
> +	if (error)
> +		dev_err(dev, "failed to add disable action.\n");

Why would you not be returning the error?

> +
> +	return 0;
> +}
..
