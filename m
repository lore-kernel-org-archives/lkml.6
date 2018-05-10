Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935239AbeEJKt0 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 06:49:26 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:1528 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935006AbeEJKtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 06:49:21 -0400
X-IronPort-AV: E=Sophos;i="5.49,385,1520924400";
   d="scan'208";a="14726561"
From: Eugen Hristev <eugen.hristev@microchip.com>
To: <jic23@kernel.org>, <ludovic.desroches@microchip.com>,
        <alexandre.belloni@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-input@vger.kernel.org>, <nicolas.ferre@microchip.com>,
        <dmitry.torokhov@gmail.com>, <robh@kernel.org>
CC: Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH v5 6/9] input: touchscreen: resistive-adc-touch: add generic resistive ADC touchscreen
Date: Thu, 10 May 2018 13:45:11 +0300
Message-ID: <1525949114-29263-7-git-send-email-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525949114-29263-1-git-send-email-eugen.hristev@microchip.com>
References: <1525949114-29263-1-git-send-email-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a generic resistive touchscreen (GRTS) driver, which is based
on an IIO device (an ADC). It must be connected to the channels of an ADC
to receive touch data. Then it will feed the data into the input subsystem
where it registers an input device.
It uses an IIO callback buffer to register to the IIO device

Some parts of this patch are based on initial original work by
Mohamed Jamsheeth Hajanajubudeen and Bandaru Venkateswara Swamy

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
Changes in v5:
 - return error on probe if failed add_action_or_reset
 - renamed property touchscreen-threshold-pressure to
touchscreen-min-pressure, changed variables accordingly

Changes in v4:
 - added a small description in file header
 - changed MAX_POS_MASK to GRTS_MAX_POS_MASK
 - initialized press with 0, as this value means no touch.
press has to be initialized because compiler/checkpatch complains
that can be used uninitialized.
 - changed of_property_read_u32 to device_*
 - set_abs_params for pressure will have range according to threshold
 - changed evbit and keybit with set_capability call
 - changed variable names to error instead of ret
 - checked errors for add_action_or_reset
 - cosmetic cleaning

Changes in v3:
 - pressure now reported naturally growing down-up
 - using helpers from touchscreen.h to parse DT properties
 - added devm_add_action_or_reset to handle callback buffer clean on exit
 - changed compatible and threshold property to adapt to changed bindings

Changes in v2:
 - this is now a generic resistive adc touchscreen driver


 drivers/input/touchscreen/Kconfig               |  13 ++
 drivers/input/touchscreen/Makefile              |   1 +
 drivers/input/touchscreen/resistive-adc-touch.c | 201 ++++++++++++++++++++++++
 3 files changed, 215 insertions(+)
 create mode 100644 drivers/input/touchscreen/resistive-adc-touch.c

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 4f15496..8f85d3a 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -92,6 +92,19 @@ config TOUCHSCREEN_AD7879_SPI
 	  To compile this driver as a module, choose M here: the
 	  module will be called ad7879-spi.
 
+config TOUCHSCREEN_ADC
+	tristate "Generic ADC based resistive touchscreen"
+	depends on IIO
+	select IIO_BUFFER_CB
+	help
+	  Say Y here if you want to use the generic ADC
+	  resistive touchscreen driver.
+
+	  If unsure, say N (but it's safe to say "Y").
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called resistive-adc-touch.ko.
+
 config TOUCHSCREEN_AR1021_I2C
 	tristate "Microchip AR1020/1021 i2c touchscreen"
 	depends on I2C && OF
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
index dddae79..843c7f9 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_TOUCHSCREEN_AD7877)	+= ad7877.o
 obj-$(CONFIG_TOUCHSCREEN_AD7879)	+= ad7879.o
 obj-$(CONFIG_TOUCHSCREEN_AD7879_I2C)	+= ad7879-i2c.o
 obj-$(CONFIG_TOUCHSCREEN_AD7879_SPI)	+= ad7879-spi.o
+obj-$(CONFIG_TOUCHSCREEN_ADC)		+= resistive-adc-touch.o
 obj-$(CONFIG_TOUCHSCREEN_ADS7846)	+= ads7846.o
 obj-$(CONFIG_TOUCHSCREEN_AR1021_I2C)	+= ar1021_i2c.o
 obj-$(CONFIG_TOUCHSCREEN_ATMEL_MXT)	+= atmel_mxt_ts.o
diff --git a/drivers/input/touchscreen/resistive-adc-touch.c b/drivers/input/touchscreen/resistive-adc-touch.c
new file mode 100644
index 0000000..ced4ece
--- /dev/null
+++ b/drivers/input/touchscreen/resistive-adc-touch.c
@@ -0,0 +1,201 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ADC generic resistive touchscreen (GRTS)
+ * This is a generic input driver that connects to an ADC
+ * given the channels in device tree, and reports events to the input
+ * subsystem.
+ *
+ * Copyright (C) 2017,2018 Microchip Technology,
+ * Author: Eugen Hristev <eugen.hristev@microchip.com>
+ *
+ */
+#include <linux/input.h>
+#include <linux/input/touchscreen.h>
+#include <linux/iio/consumer.h>
+#include <linux/iio/iio.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+
+#define DRIVER_NAME					"resistive-adc-touch"
+#define GRTS_DEFAULT_PRESSURE_MIN			50000
+#define GRTS_MAX_POS_MASK				GENMASK(11, 0)
+
+/**
+ * grts_state - generic resistive touch screen information struct
+ * @pressure_min:	number representing the minimum for the pressure
+ * @pressure:		are we getting pressure info or not
+ * @iio_chans:		list of channels acquired
+ * @iio_cb:		iio_callback buffer for the data
+ * @input:		the input device structure that we register
+ * @prop:		touchscreen properties struct
+ */
+struct grts_state {
+	u32				pressure_min;
+	bool				pressure;
+	struct iio_channel		*iio_chans;
+	struct iio_cb_buffer		*iio_cb;
+	struct input_dev		*input;
+	struct touchscreen_properties	prop;
+};
+
+static int grts_cb(const void *data, void *private)
+{
+	const u16 *touch_info = data;
+	struct grts_state *st = private;
+	unsigned int x, y, press = 0x0;
+
+	/* channel data coming in buffer in the order below */
+	x = touch_info[0];
+	y = touch_info[1];
+	if (st->pressure)
+		press = touch_info[2];
+
+	if ((!x && !y) || (st->pressure && (press < st->pressure_min))) {
+		/* report end of touch */
+		input_report_key(st->input, BTN_TOUCH, 0);
+		input_sync(st->input);
+		return 0;
+	}
+
+	/* report proper touch to subsystem*/
+	touchscreen_report_pos(st->input, &st->prop, x, y, false);
+	if (st->pressure)
+		input_report_abs(st->input, ABS_PRESSURE, press);
+	input_report_key(st->input, BTN_TOUCH, 1);
+	input_sync(st->input);
+
+	return 0;
+}
+
+static int grts_open(struct input_dev *dev)
+{
+	int error;
+	struct grts_state *st = input_get_drvdata(dev);
+
+	error = iio_channel_start_all_cb(st->iio_cb);
+	if (error) {
+		dev_err(dev->dev.parent, "failed to start callback buffer.\n");
+		return error;
+	}
+	return 0;
+}
+
+static void grts_close(struct input_dev *dev)
+{
+	struct grts_state *st = input_get_drvdata(dev);
+
+	iio_channel_stop_all_cb(st->iio_cb);
+}
+
+static void grts_disable(void *data)
+{
+	iio_channel_release_all_cb(data);
+}
+
+static int grts_probe(struct platform_device *pdev)
+{
+	struct grts_state *st;
+	struct input_dev *input;
+	struct device *dev = &pdev->dev;
+	struct iio_channel *chan;
+	int error;
+
+	st = devm_kzalloc(dev, sizeof(struct grts_state), GFP_KERNEL);
+	if (!st)
+		return -ENOMEM;
+
+	error = device_property_read_u32(dev, "touchscreen-min-pressure",
+					 &st->pressure_min);
+	if (error) {
+		dev_err(dev, "can't get touchscreen-min-pressure property.\n");
+		st->pressure_min = GRTS_DEFAULT_PRESSURE_MIN;
+	}
+
+	/* get the channels from IIO device */
+	st->iio_chans = devm_iio_channel_get_all(dev);
+	if (IS_ERR(st->iio_chans)) {
+		if (PTR_ERR(st->iio_chans) != -EPROBE_DEFER)
+			dev_err(dev, "can't get iio channels.\n");
+		return PTR_ERR(st->iio_chans);
+	}
+
+	chan = &st->iio_chans[0];
+	st->pressure = false;
+	while (chan && chan->indio_dev) {
+		if (!strcmp(chan->channel->datasheet_name, "pressure"))
+			st->pressure = true;
+		chan++;
+	}
+
+	input = devm_input_allocate_device(dev);
+	if (!input) {
+		dev_err(dev, "failed to allocate input device.\n");
+		return -ENOMEM;
+	}
+
+	input->name = DRIVER_NAME;
+	input->id.bustype = BUS_HOST;
+	input->open = grts_open;
+	input->close = grts_close;
+
+	input_set_abs_params(input, ABS_X, 0, GRTS_MAX_POS_MASK - 1, 0, 0);
+	input_set_abs_params(input, ABS_Y, 0, GRTS_MAX_POS_MASK - 1, 0, 0);
+	if (st->pressure)
+		input_set_abs_params(input, ABS_PRESSURE, st->pressure_min,
+				     0xffff, 0, 0);
+
+	input_set_capability(input, EV_KEY, BTN_TOUCH);
+
+	/* parse optional device tree properties */
+	touchscreen_parse_properties(input, false, &st->prop);
+
+	st->input = input;
+	input_set_drvdata(input, st);
+
+	error = input_register_device(input);
+	if (error) {
+		dev_err(dev, "failed to register input device.");
+		return error;
+	}
+
+	st->iio_cb = iio_channel_get_all_cb(dev, grts_cb, st);
+	if (IS_ERR(st->iio_cb)) {
+		dev_err(dev, "failed to allocate callback buffer.\n");
+		error =  PTR_ERR(st->iio_cb);
+		return error;
+	}
+
+	error = devm_add_action_or_reset(dev, grts_disable, st->iio_cb);
+	if (error) {
+		dev_err(dev, "failed to add disable action.\n");
+		return error;
+	}
+
+	return 0;
+}
+
+static const struct of_device_id grts_of_match[] = {
+	{
+		.compatible = "resistive-adc-touch",
+	}, {
+		/* sentinel */
+	},
+};
+
+MODULE_DEVICE_TABLE(of, grts_of_match);
+
+static struct platform_driver grts_driver = {
+	.probe = grts_probe,
+	.driver = {
+		.name = DRIVER_NAME,
+		.of_match_table = of_match_ptr(grts_of_match),
+	},
+};
+
+module_platform_driver(grts_driver);
+
+MODULE_AUTHOR("Eugen Hristev <eugen.hristev@microchip.com>");
+MODULE_DESCRIPTION("Generic ADC Resistive Touch Driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4
