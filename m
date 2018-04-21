Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753050AbeDUIvS (ORCPT <rfc822;w@1wt.eu>);
        Sat, 21 Apr 2018 04:51:18 -0400
Received: from bert.emutex.com ([91.103.1.109]:53863 "EHLO bert.emutex.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752547AbeDUIur (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Apr 2018 04:50:47 -0400
From: Javier Arteaga <javier@emutex.com>
To: Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>
Cc: Javier Arteaga <javier@emutex.com>, "Dan O'Donovan" <dan@emutex.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH RESEND 2/3] leds: upboard: Add LED support
Date: Sat, 21 Apr 2018 09:50:08 +0100
Message-Id: <20180421085009.28773-3-javier@emutex.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180421085009.28773-1-javier@emutex.com>
References: <20180421085009.28773-1-javier@emutex.com>
X-Spam-Score: -1.0 (-)
X-Spam-Report: Spam detection software, running on the system "statler.emutex.com",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  Allow userspace to use the on-board LEDs as "upboard:<color>:".
    Signed-off-by: Javier Arteaga <javier@emutex.com> --- drivers/leds/Kconfig
    | 10 +++++ drivers/leds/Makefile | 1 + drivers/leds/leds-upboard.c | 87 +++++++++++++++++++++++++++++++++++++
    drivers/mfd/upboard.c | 19 ++++++++ include/linux/mfd/upboard.h | 5 +++ 5
    files changed, 122 insertions(+) create mode 100644 drivers/leds/leds-upboard.c
    [...]
 Content analysis details:   (-1.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow userspace to use the on-board LEDs as "upboard:<color>:".

Signed-off-by: Javier Arteaga <javier@emutex.com>
---
 drivers/leds/Kconfig        | 10 +++++
 drivers/leds/Makefile       |  1 +
 drivers/leds/leds-upboard.c | 87 +++++++++++++++++++++++++++++++++++++
 drivers/mfd/upboard.c       | 19 ++++++++
 include/linux/mfd/upboard.h |  5 +++
 5 files changed, 122 insertions(+)
 create mode 100644 drivers/leds/leds-upboard.c

diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
index 2c896c0e69e1..2e77b46f2802 100644
--- a/drivers/leds/Kconfig
+++ b/drivers/leds/Kconfig
@@ -722,6 +722,16 @@ config LEDS_NIC78BX
 	  To compile this driver as a module, choose M here: the module
 	  will be called leds-nic78bx.
 
+config LEDS_UPBOARD
+	tristate "LED support for the UP Squared"
+	depends on LEDS_CLASS
+	depends on MFD_UPBOARD
+	help
+	  This option enables support for the LEDs on the UP Squared board.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called leds-upboard.
+
 comment "LED Triggers"
 source "drivers/leds/trigger/Kconfig"
 
diff --git a/drivers/leds/Makefile b/drivers/leds/Makefile
index 91eca81cae82..4008e2061e1f 100644
--- a/drivers/leds/Makefile
+++ b/drivers/leds/Makefile
@@ -76,6 +76,7 @@ obj-$(CONFIG_LEDS_MLXREG)		+= leds-mlxreg.o
 obj-$(CONFIG_LEDS_NIC78BX)		+= leds-nic78bx.o
 obj-$(CONFIG_LEDS_MT6323)		+= leds-mt6323.o
 obj-$(CONFIG_LEDS_LM3692X)		+= leds-lm3692x.o
+obj-$(CONFIG_LEDS_UPBOARD)		+= leds-upboard.o
 
 # LED SPI Drivers
 obj-$(CONFIG_LEDS_DAC124S085)		+= leds-dac124s085.o
diff --git a/drivers/leds/leds-upboard.c b/drivers/leds/leds-upboard.c
new file mode 100644
index 000000000000..e9d7a1fbcde4
--- /dev/null
+++ b/drivers/leds/leds-upboard.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * UP Board LED driver
+ *
+ * Copyright (c) 2018, Emutex Ltd.
+ *
+ * Author: Javier Arteaga <javier@emutex.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/leds.h>
+#include <linux/mfd/upboard.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+struct upboard_led {
+	struct regmap_field *field;
+	struct led_classdev cdev;
+};
+
+static enum led_brightness upboard_led_brightness_get(struct led_classdev *cdev)
+{
+	struct upboard_led *led = container_of(cdev, struct upboard_led, cdev);
+	int brightness = 0;
+
+	regmap_field_read(led->field, &brightness);
+
+	return brightness;
+};
+
+static void upboard_led_brightness_set(struct led_classdev *cdev,
+				       enum led_brightness brightness)
+{
+	struct upboard_led *led = container_of(cdev, struct upboard_led, cdev);
+
+	regmap_field_write(led->field, brightness != LED_OFF);
+};
+
+static int __init upboard_led_probe(struct platform_device *pdev)
+{
+	struct upboard_led_data * const pdata = pdev->dev.platform_data;
+	struct upboard *upboard;
+	struct upboard_led *led;
+	struct reg_field conf = {
+		.reg = UPBOARD_REG_FUNC_EN0,
+	};
+
+	if (!pdev->dev.parent)
+		return -EINVAL;
+
+	upboard = dev_get_drvdata(pdev->dev.parent);
+	if (!upboard || !pdata)
+		return -EINVAL;
+
+	led = devm_kzalloc(&pdev->dev, sizeof(*led), GFP_KERNEL);
+	if (!led)
+		return -ENOMEM;
+
+	conf.lsb = pdata->id;
+	conf.msb = pdata->id;
+	led->field = devm_regmap_field_alloc(&pdev->dev, upboard->regmap, conf);
+	if (IS_ERR(led->field))
+		return PTR_ERR(led->field);
+
+	led->cdev.brightness_get = upboard_led_brightness_get;
+	led->cdev.brightness_set = upboard_led_brightness_set;
+	led->cdev.name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "upboard:%s:",
+					pdata->color);
+	if (!led->cdev.name)
+		return -ENOMEM;
+
+	return devm_led_classdev_register(&pdev->dev, &led->cdev);
+};
+
+static struct platform_driver upboard_led_driver = {
+	.driver = {
+		.name = "upboard-led",
+	},
+};
+
+module_platform_driver_probe(upboard_led_driver, upboard_led_probe);
+
+MODULE_ALIAS("platform:upboard-led");
+MODULE_AUTHOR("Javier Arteaga <javier@emutex.com>");
+MODULE_DESCRIPTION("UP Board LED driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/mfd/upboard.c b/drivers/mfd/upboard.c
index 8bae450cb83d..6e4767e4dc41 100644
--- a/drivers/mfd/upboard.c
+++ b/drivers/mfd/upboard.c
@@ -79,6 +79,14 @@ struct upboard_data {
 	size_t ncells;
 };
 
+#define UPBOARD_LED_CELL(led_data, n)                   \
+	{                                               \
+		.name = "upboard-led",                  \
+		.id = (n),                              \
+		.platform_data = &led_data[(n)],        \
+		.pdata_size = sizeof(*(led_data)),      \
+	}
+
 /* UP Squared */
 
 static const struct regmap_range upboard_up2_readable_ranges[] = {
@@ -116,7 +124,18 @@ static const struct regmap_config upboard_up2_regmap_config = {
 	.wr_table = &upboard_up2_writable_table,
 };
 
+static struct upboard_led_data upboard_up2_led_data[] = {
+	{ .id = 0, .color = "blue" },
+	{ .id = 1, .color = "yellow" },
+	{ .id = 2, .color = "green" },
+	{ .id = 3, .color = "red" },
+};
+
 static const struct mfd_cell upboard_up2_mfd_cells[] = {
+	UPBOARD_LED_CELL(upboard_up2_led_data, 0),
+	UPBOARD_LED_CELL(upboard_up2_led_data, 1),
+	UPBOARD_LED_CELL(upboard_up2_led_data, 2),
+	UPBOARD_LED_CELL(upboard_up2_led_data, 3),
 };
 
 static const struct upboard_data upboard_up2_data = {
diff --git a/include/linux/mfd/upboard.h b/include/linux/mfd/upboard.h
index d9dd214f4d29..eed68caa23ce 100644
--- a/include/linux/mfd/upboard.h
+++ b/include/linux/mfd/upboard.h
@@ -62,4 +62,9 @@ struct upboard {
 	struct gpio_desc *dataout_gpio;
 };
 
+struct upboard_led_data {
+	unsigned int id;
+	const char *color;
+};
+
 #endif /*  __LINUX_MFD_UPBOARD_H */
-- 
2.17.0
