Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932616AbeCEWDc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 17:03:32 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:40920 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932611AbeCEWDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 17:03:20 -0500
X-Google-Smtp-Source: AG47ELsXv+J3zUufUP4fZI/HkjzexEEUo9d1RPlf+f0gnAL33d+u1c5HhjYrh+kw3KqufIFDOxi2Uw==
From: Tim Harvey <tharvey@gateworks.com>
To: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Mark Brown <broonie@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: [PATCH v2 4/4] input: misc: Add Gateworks System Controller support
Date: Mon,  5 Mar 2018 14:02:41 -0800
Message-Id: <1520287361-12569-5-git-send-email-tharvey@gateworks.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520287361-12569-1-git-send-email-tharvey@gateworks.com>
References: <1520287361-12569-1-git-send-email-tharvey@gateworks.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for dispatching Linux Input events for the various interrupts
the Gateworks System Controller provides.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
v2:
- reword Kconfig
- revise license comment block
- remove unnecessary read of status register
- remove unnecessary setting of input->dev.parent
- use dt bindings for irq to keycode mapping
- add support for platform-data
- remove work-queue

 drivers/input/misc/Kconfig              |   9 ++
 drivers/input/misc/Makefile             |   1 +
 drivers/input/misc/gsc-input.c          | 180 ++++++++++++++++++++++++++++++++
 include/linux/platform_data/gsc_input.h |  30 ++++++
 4 files changed, 220 insertions(+)
 create mode 100644 drivers/input/misc/gsc-input.c
 create mode 100644 include/linux/platform_data/gsc_input.h

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 9f082a3..e05f4fe 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -117,6 +117,15 @@ config INPUT_E3X0_BUTTON
 	  To compile this driver as a module, choose M here: the
 	  module will be called e3x0_button.
 
+config INPUT_GSC
+	tristate "Gateworks System Controller input support"
+	depends on MFD_GSC
+	help
+	  Support GSC events as Linux input events.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called gsc_input.
+
 config INPUT_PCSPKR
 	tristate "PC Speaker support"
 	depends on PCSPKR_PLATFORM
diff --git a/drivers/input/misc/Makefile b/drivers/input/misc/Makefile
index 4b6118d..969debe 100644
--- a/drivers/input/misc/Makefile
+++ b/drivers/input/misc/Makefile
@@ -38,6 +38,7 @@ obj-$(CONFIG_INPUT_GP2A)		+= gp2ap002a00f.o
 obj-$(CONFIG_INPUT_GPIO_BEEPER)		+= gpio-beeper.o
 obj-$(CONFIG_INPUT_GPIO_TILT_POLLED)	+= gpio_tilt_polled.o
 obj-$(CONFIG_INPUT_GPIO_DECODER)	+= gpio_decoder.o
+obj-$(CONFIG_INPUT_GSC)			+= gsc-input.o
 obj-$(CONFIG_INPUT_HISI_POWERKEY)	+= hisi_powerkey.o
 obj-$(CONFIG_HP_SDC_RTC)		+= hp_sdc_rtc.o
 obj-$(CONFIG_INPUT_IMS_PCU)		+= ims-pcu.o
diff --git a/drivers/input/misc/gsc-input.c b/drivers/input/misc/gsc-input.c
new file mode 100644
index 0000000..27b5e93
--- /dev/null
+++ b/drivers/input/misc/gsc-input.c
@@ -0,0 +1,180 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (C) 2018 Gateworks Corporation
+ *
+ * This driver dispatches Linux input events for GSC interrupt events
+ */
+#include <linux/input.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_irq.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#include <linux/mfd/gsc.h>
+#include <linux/platform_data/gsc_input.h>
+
+struct gsc_input_button_priv {
+	struct input_dev *input;
+	const struct gsc_input_button *button;
+};
+
+struct gsc_input_data {
+	struct gsc_dev *gsc;
+	struct gsc_input_platform_data *pdata;
+	struct input_dev *input;
+	struct gsc_input_button_priv *buttons;
+	int nbuttons;
+	unsigned int irqs[];
+#if 0
+	int irq;
+	struct work_struct irq_work;
+	struct mutex mutex;
+#endif
+};
+
+static irqreturn_t gsc_input_irq(int irq, void *data)
+{
+	const struct gsc_input_button_priv *button_priv = data;
+	struct input_dev *input = button_priv->input;
+
+	dev_dbg(&input->dev, "irq%d code=%d\n", irq, button_priv->button->code);
+	input_report_key(input, button_priv->button->code, 1);
+	input_sync(input);
+	input_report_key(input, button_priv->button->code, 0);
+	input_sync(input);
+
+	return IRQ_HANDLED;
+}
+
+static struct gsc_input_platform_data *
+gsc_input_get_devtree_pdata(struct device *dev)
+{
+	struct gsc_input_platform_data *pdata;
+	struct fwnode_handle *child;
+	struct gsc_input_button *button;
+	int nbuttons;
+
+	nbuttons = device_get_child_node_count(dev);
+	dev_dbg(dev, "buttons=%d\n", nbuttons);
+	if (nbuttons == 0)
+		return ERR_PTR(-ENODEV);
+
+	pdata = devm_kzalloc(dev,
+			     sizeof(*pdata) + nbuttons * sizeof(*button),
+			     GFP_KERNEL);
+	if (!pdata)
+		return ERR_PTR(-ENOMEM);
+
+	button = (struct gsc_input_button *)(pdata + 1);
+	pdata->buttons = button;
+	pdata->nbuttons = nbuttons;
+
+	device_property_read_string(dev, "label", &pdata->name);
+
+	device_for_each_child_node(dev, child) {
+		if (is_of_node(child))
+			button->irq = irq_of_parse_and_map(to_of_node(child),
+							   0);
+		if (fwnode_property_read_u32(child, "linux,code",
+					     &button->code)) {
+			dev_err(dev, "Button without keycode\n");
+			fwnode_handle_put(child);
+			return ERR_PTR(-EINVAL);
+		}
+		fwnode_property_read_string(child, "label", &button->desc);
+		button++;
+	}
+
+	return pdata;
+}
+
+static int gsc_input_probe(struct platform_device *pdev)
+{
+	struct gsc_dev *gsc = dev_get_drvdata(pdev->dev.parent);
+	struct device *dev = &pdev->dev;
+	struct gsc_input_platform_data *pdata = dev_get_platdata(dev);
+	struct gsc_input_data *input;
+	int i, ret;
+
+	if (!pdata) {
+		pdata = gsc_input_get_devtree_pdata(dev);
+		if (IS_ERR(pdata))
+			return PTR_ERR(pdata);
+	}
+
+	input = devm_kzalloc(dev, sizeof(*input), GFP_KERNEL);
+	if (!input)
+		return -ENOMEM;
+	input->gsc = gsc;
+	input->pdata = pdata;
+
+	input->buttons = devm_kzalloc(dev, pdata->nbuttons *
+				      sizeof(struct gsc_input_button_priv),
+				      GFP_KERNEL);
+	if (!input->buttons)
+		return -ENOMEM;
+
+	/* Register input device */
+	input->input = devm_input_allocate_device(dev);
+	if (!input->input) {
+		dev_err(dev, "Can't allocate input device\n");
+		return -ENOMEM;
+	}
+	input->input->name = pdata->name ? : pdev->name;
+
+	platform_set_drvdata(pdev, gsc);
+
+	for (i = 0; i < pdata->nbuttons; i++) {
+		const struct gsc_input_button *button = &pdata->buttons[i];
+		struct gsc_input_button_priv *button_priv = &input->buttons[i];
+
+		button_priv = &input->buttons[i];
+		button_priv->button = &pdata->buttons[i];
+		button_priv->input = input->input;
+		input_set_capability(input->input, EV_KEY, button->code);
+
+		ret = devm_request_threaded_irq(dev, button->irq, NULL,
+						gsc_input_irq, 0,
+						button->desc,
+						button_priv);
+		if (ret) {
+			dev_err(dev, "irq%d request failed: %d\n)", button->irq,
+				ret);
+			return ret;
+		}
+		dev_dbg(dev, "button: irq%d/%d code=%d %s\n",
+			button->irq - pdata->buttons[0].irq,
+			button->irq,
+			button->code, button->desc);
+	}
+
+	ret = input_register_device(input->input);
+	if (ret < 0) {
+		dev_err(dev, "Can't register input device: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static const struct of_device_id gsc_input_dt_ids[] = {
+	{ .compatible = "gw,gsc-input", },
+	{}
+};
+
+static struct platform_driver gsc_input_driver = {
+	.driver = {
+		.name = KBUILD_MODNAME,
+		.of_match_table = gsc_input_dt_ids,
+	},
+	.probe = gsc_input_probe,
+};
+
+module_platform_driver(gsc_input_driver);
+
+MODULE_AUTHOR("Tim Harvey <tharvey@gateworks.com>");
+MODULE_DESCRIPTION("GSC input driver");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/platform_data/gsc_input.h b/include/linux/platform_data/gsc_input.h
new file mode 100644
index 0000000..1a34284
--- /dev/null
+++ b/include/linux/platform_data/gsc_input.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _GSC_INPUT_H
+#define _GSC_INPUT_H
+
+/**
+ * struct gsc_input_button - configuration parameters
+ * @code:	input event code (KEY_*, SW_*)
+ * @irq:	irq index
+ * @desc:	name of interrupt
+ */
+struct gsc_input_button {
+	unsigned int irq;
+	unsigned int code;
+	const char *desc;
+};
+
+/**
+ * struct gsc_input_platform_data - platform data for gsc_input driver
+ * @buttons:	pointer to array of gsc_input_button structures
+ *		describing buttons mapped to interrupt events
+ * @nbuttons:	number of elements in @buttons array
+ * @name:	input device name
+ */
+struct gsc_input_platform_data {
+	const struct gsc_input_button *buttons;
+	int nbuttons;
+	const char *name;
+};
+
+#endif
-- 
2.7.4
