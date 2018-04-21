Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752844AbeDUIuu (ORCPT <rfc822;w@1wt.eu>);
        Sat, 21 Apr 2018 04:50:50 -0400
Received: from bert.emutex.com ([91.103.1.109]:53858 "EHLO bert.emutex.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751850AbeDUIuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Apr 2018 04:50:44 -0400
From: Javier Arteaga <javier@emutex.com>
To: Lee Jones <lee.jones@linaro.org>
Cc: Javier Arteaga <javier@emutex.com>, "Dan O'Donovan" <dan@emutex.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, linux-gpio@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH RESEND 1/3] mfd: upboard: Add UP2 platform controller driver
Date: Sat, 21 Apr 2018 09:50:07 +0100
Message-Id: <20180421085009.28773-2-javier@emutex.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180421085009.28773-1-javier@emutex.com>
References: <20180421085009.28773-1-javier@emutex.com>
X-Spam-Score: -1.0 (-)
X-Spam-Report: Spam detection software, running on the system "statler.emutex.com",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  UP Squared (UP2) is a x86 SBC from AAEON based on Intel Apollo
    Lake. It features a MAX 10 FPGA that routes lines from both SoC and on-board
    devices to two I/O headers: ++ | 40-pin RPi-like header | +------| (HAT)
   | | ++ +-------+ +--------+ | | | | ++ | SoC |----| FPGA |-----| Custom UP2
    pin header | | | | | | (EXHAT) | +-------+ +--------+ ++ | +------* On-board
    devices: LED, VLS... [...]
 Content analysis details:   (-1.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -1.0 ALL_TRUSTED            Passed through trusted hosts only via SMTP
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UP Squared (UP2) is a x86 SBC from AAEON based on Intel Apollo Lake. It
features a MAX 10 FPGA that routes lines from both SoC and on-board
devices to two I/O headers:

                                +------------------------+
                                | 40-pin RPi-like header |
                         +------|         (HAT)          |
                         |      +------------------------+
    +-------+    +--------+
    |       |    |        |     +------------------------+
    |  SoC  |----|  FPGA  |-----|  Custom UP2 pin header |
    |       |    |        |     |        (EXHAT)         |
    +-------+    +--------+     +------------------------+
                         |
                         +------* On-board devices: LED, VLS...

This is intended to enable vendor-specific applications to customize I/O
header pinout, as well as include low-latency functionality. It also
performs voltage level translation between the SoC (1.8V) and HAT header
(3.3V).

Out of the box, this block implements a platform controller with a
GPIO-bitbanged control interface. It's enumerated by ACPI and provides
registers to control:

- Configuration of all FPGA-routed header lines. These can be driven
  SoC-to-header, header-to-SoC or set in high impedance.

- On-board LEDs and enable lines for other platform devices.

Add core support for this platform controller as a MFD device, exposing
these registers as a regmap.

Signed-off-by: Javier Arteaga <javier@emutex.com>
---
 drivers/mfd/Kconfig         |  17 +++
 drivers/mfd/Makefile        |   1 +
 drivers/mfd/upboard.c       | 253 ++++++++++++++++++++++++++++++++++++
 include/linux/mfd/upboard.h |  65 +++++++++
 4 files changed, 336 insertions(+)
 create mode 100644 drivers/mfd/upboard.c
 create mode 100644 include/linux/mfd/upboard.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index b860eb5aa194..d72927601fa2 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1812,6 +1812,23 @@ config MFD_STM32_TIMERS
 	  for PWM and IIO Timer. This driver allow to share the
 	  registers between the others drivers.
 
+config MFD_UPBOARD
+	tristate "UP Squared"
+	depends on ACPI
+	depends on GPIOLIB
+	select MFD_CORE
+	select REGMAP
+	help
+	  If you say yes here you get support for the platform controller
+	  of the UP Squared single-board computer.
+
+	  This driver provides common support for accessing the device,
+	  additional drivers must be enabled in order to use the
+	  functionality of the device.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called upboard.
+
 menu "Multimedia Capabilities Port drivers"
 	depends on ARCH_SA1100
 
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index d9d2cf0d32ef..ea5b29167a80 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -229,3 +229,4 @@ obj-$(CONFIG_MFD_MXS_LRADC)     += mxs-lradc.o
 obj-$(CONFIG_MFD_SC27XX_PMIC)	+= sprd-sc27xx-spi.o
 obj-$(CONFIG_RAVE_SP_CORE)	+= rave-sp.o
 
+obj-$(CONFIG_MFD_UPBOARD)  += upboard.o
diff --git a/drivers/mfd/upboard.c b/drivers/mfd/upboard.c
new file mode 100644
index 000000000000..8bae450cb83d
--- /dev/null
+++ b/drivers/mfd/upboard.c
@@ -0,0 +1,253 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * UP Board platform controller driver
+ *
+ * Copyright (c) 2018, Emutex Ltd.
+ *
+ * Author: Javier Arteaga <javier@emutex.com>
+ */
+
+#include <linux/acpi.h>
+#include <linux/gpio/consumer.h>
+#include <linux/kernel.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/upboard.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+static int upboard_read(void *context, unsigned int reg, unsigned int *val)
+{
+	const struct upboard * const upboard = context;
+	int i;
+
+	gpiod_set_value(upboard->clear_gpio, 0);
+	gpiod_set_value(upboard->clear_gpio, 1);
+
+	reg |= UPBOARD_READ_FLAG;
+
+	for (i = UPBOARD_ADDRESS_SIZE; i >= 0; i--) {
+		gpiod_set_value(upboard->strobe_gpio, 0);
+		gpiod_set_value(upboard->datain_gpio, (reg >> i) & 0x1);
+		gpiod_set_value(upboard->strobe_gpio, 1);
+	}
+
+	gpiod_set_value(upboard->strobe_gpio, 0);
+	*val = 0;
+
+	for (i = UPBOARD_REGISTER_SIZE - 1; i >= 0; i--) {
+		gpiod_set_value(upboard->strobe_gpio, 1);
+		gpiod_set_value(upboard->strobe_gpio, 0);
+		*val |= gpiod_get_value(upboard->dataout_gpio) << i;
+	}
+
+	gpiod_set_value(upboard->strobe_gpio, 1);
+
+	return 0;
+};
+
+static int upboard_write(void *context, unsigned int reg, unsigned int val)
+{
+	const struct upboard * const upboard = context;
+	int i;
+
+	gpiod_set_value(upboard->clear_gpio, 0);
+	gpiod_set_value(upboard->clear_gpio, 1);
+
+	for (i = UPBOARD_ADDRESS_SIZE; i >= 0; i--) {
+		gpiod_set_value(upboard->strobe_gpio, 0);
+		gpiod_set_value(upboard->datain_gpio, (reg >> i) & 0x1);
+		gpiod_set_value(upboard->strobe_gpio, 1);
+	}
+
+	gpiod_set_value(upboard->strobe_gpio, 0);
+
+	for (i = UPBOARD_REGISTER_SIZE - 1; i >= 0; i--) {
+		gpiod_set_value(upboard->datain_gpio, (val >> i) & 0x1);
+		gpiod_set_value(upboard->strobe_gpio, 1);
+		gpiod_set_value(upboard->strobe_gpio, 0);
+	}
+
+	gpiod_set_value(upboard->strobe_gpio, 1);
+
+	return 0;
+};
+
+struct upboard_data {
+	const struct regmap_config *regmapconf;
+	const struct mfd_cell *cells;
+	size_t ncells;
+};
+
+/* UP Squared */
+
+static const struct regmap_range upboard_up2_readable_ranges[] = {
+	regmap_reg_range(UPBOARD_REG_PLATFORM_ID, UPBOARD_REG_FIRMWARE_ID),
+	regmap_reg_range(UPBOARD_REG_FUNC_EN0, UPBOARD_REG_FUNC_EN1),
+	regmap_reg_range(UPBOARD_REG_GPIO_EN0, UPBOARD_REG_GPIO_EN2),
+	regmap_reg_range(UPBOARD_REG_GPIO_DIR0, UPBOARD_REG_GPIO_DIR2),
+};
+
+static const struct regmap_range upboard_up2_writable_ranges[] = {
+	regmap_reg_range(UPBOARD_REG_FUNC_EN0, UPBOARD_REG_FUNC_EN1),
+	regmap_reg_range(UPBOARD_REG_GPIO_EN0, UPBOARD_REG_GPIO_EN2),
+	regmap_reg_range(UPBOARD_REG_GPIO_DIR0, UPBOARD_REG_GPIO_DIR2),
+};
+
+static const struct regmap_access_table upboard_up2_readable_table = {
+	.yes_ranges = upboard_up2_readable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(upboard_up2_readable_ranges),
+};
+
+static const struct regmap_access_table upboard_up2_writable_table = {
+	.yes_ranges = upboard_up2_writable_ranges,
+	.n_yes_ranges = ARRAY_SIZE(upboard_up2_writable_ranges),
+};
+
+static const struct regmap_config upboard_up2_regmap_config = {
+	.reg_bits = UPBOARD_ADDRESS_SIZE,
+	.val_bits = UPBOARD_REGISTER_SIZE,
+	.max_register = UPBOARD_REG_MAX,
+	.reg_read = upboard_read,
+	.reg_write = upboard_write,
+	.fast_io = false,
+	.cache_type = REGCACHE_RBTREE,
+	.rd_table = &upboard_up2_readable_table,
+	.wr_table = &upboard_up2_writable_table,
+};
+
+static const struct mfd_cell upboard_up2_mfd_cells[] = {
+};
+
+static const struct upboard_data upboard_up2_data = {
+	.regmapconf = &upboard_up2_regmap_config,
+	.cells = upboard_up2_mfd_cells,
+	.ncells = ARRAY_SIZE(upboard_up2_mfd_cells),
+};
+
+static int upboard_init_gpio(struct upboard *upboard)
+{
+	struct gpio_desc *enable_gpio;
+
+	enable_gpio = devm_gpiod_get(upboard->dev, "enable", GPIOD_OUT_LOW);
+	if (IS_ERR(enable_gpio))
+		return PTR_ERR(enable_gpio);
+
+	upboard->clear_gpio = devm_gpiod_get(upboard->dev, "clear", GPIOD_OUT_LOW);
+	if (IS_ERR(upboard->clear_gpio))
+		return PTR_ERR(upboard->clear_gpio);
+
+	upboard->strobe_gpio = devm_gpiod_get(upboard->dev, "strobe", GPIOD_OUT_LOW);
+	if (IS_ERR(upboard->strobe_gpio))
+		return PTR_ERR(upboard->strobe_gpio);
+
+	upboard->datain_gpio = devm_gpiod_get(upboard->dev, "datain", GPIOD_OUT_LOW);
+	if (IS_ERR(upboard->datain_gpio))
+		return PTR_ERR(upboard->datain_gpio);
+
+	upboard->dataout_gpio = devm_gpiod_get(upboard->dev, "dataout", GPIOD_IN);
+	if (IS_ERR(upboard->dataout_gpio))
+		return PTR_ERR(upboard->dataout_gpio);
+
+	gpiod_set_value(enable_gpio, 1);
+
+	return 0;
+}
+
+static int upboard_check_supported(struct upboard *upboard)
+{
+	const unsigned int AAEON_MANUFACTURER_ID = 0x01;
+	const unsigned int SUPPORTED_FW_MAJOR = 0x0;
+	unsigned int platform_id, manufacturer_id;
+	unsigned int firmware_id, build, major, minor, patch;
+	int ret;
+
+	ret = regmap_read(upboard->regmap, UPBOARD_REG_PLATFORM_ID, &platform_id);
+	if (ret)
+		return ret;
+
+	manufacturer_id = platform_id & 0xff;
+	if (manufacturer_id != AAEON_MANUFACTURER_ID) {
+		dev_dbg(upboard->dev,
+			"unsupported FPGA firmware from manufacturer 0x%02x",
+			manufacturer_id);
+		return -ENODEV;
+	}
+
+	ret = regmap_read(upboard->regmap, UPBOARD_REG_FIRMWARE_ID, &firmware_id);
+	if (ret)
+		return ret;
+
+	build = (firmware_id >> 12) & 0xf;
+	major = (firmware_id >> 8) & 0xf;
+	minor = (firmware_id >> 4) & 0xf;
+	patch = firmware_id & 0xf;
+	if (major != SUPPORTED_FW_MAJOR) {
+		dev_dbg(upboard->dev, "unsupported FPGA firmware v%u.%u.%u.%u",
+			major, minor, patch, build);
+		return -ENODEV;
+	}
+
+	dev_dbg(upboard->dev, "supported FPGA firmware v%u.%u.%u.%u",
+		major, minor, patch, build);
+	return 0;
+}
+
+static const struct acpi_device_id upboard_acpi_match[] = {
+	{ "AANT0F01", (kernel_ulong_t) &upboard_up2_data },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, upboard_acpi_match);
+
+static int upboard_probe(struct platform_device *pdev)
+{
+	struct upboard *upboard;
+	const struct acpi_device_id *id;
+	const struct upboard_data *upboard_data;
+	int ret;
+
+	id = acpi_match_device(upboard_acpi_match, &pdev->dev);
+	if (!id)
+		return -ENODEV;
+
+	upboard_data = (const struct upboard_data *) id->driver_data;
+
+	upboard = devm_kzalloc(&pdev->dev, sizeof(*upboard), GFP_KERNEL);
+	if (!upboard)
+		return -ENOMEM;
+
+	dev_set_drvdata(&pdev->dev, upboard);
+	upboard->dev = &pdev->dev;
+	upboard->regmap = devm_regmap_init(&pdev->dev, NULL, upboard,
+					   upboard_data->regmapconf);
+	if (IS_ERR(upboard->regmap))
+		return PTR_ERR(upboard->regmap);
+
+	ret = upboard_init_gpio(upboard);
+	if (ret && ret != -EPROBE_DEFER)
+		dev_err(&pdev->dev, "failed to init controller GPIOs: %d", ret);
+	if (ret)
+		return ret;
+
+	ret = upboard_check_supported(upboard);
+	if (ret)
+		return ret;
+
+	return devm_mfd_add_devices(&pdev->dev, PLATFORM_DEVID_AUTO,
+				    upboard_data->cells, upboard_data->ncells,
+				    NULL, 0, NULL);
+}
+
+static struct platform_driver upboard_driver = {
+	.probe = upboard_probe,
+	.driver = {
+		.name = "upboard",
+		.acpi_match_table = upboard_acpi_match,
+	},
+};
+
+module_platform_driver(upboard_driver);
+
+MODULE_AUTHOR("Javier Arteaga <javier@emutex.com>");
+MODULE_DESCRIPTION("UP Board platform controller driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/mfd/upboard.h b/include/linux/mfd/upboard.h
new file mode 100644
index 000000000000..d9dd214f4d29
--- /dev/null
+++ b/include/linux/mfd/upboard.h
@@ -0,0 +1,65 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * UP Board MFD driver interface
+ *
+ * Copyright (c) 2018, Emutex Ltd.
+ *
+ * Author: Javier Arteaga <javier@emutex.com>
+ */
+
+#ifndef __LINUX_MFD_UPBOARD_H
+#define __LINUX_MFD_UPBOARD_H
+
+#define UPBOARD_ADDRESS_SIZE  7
+#define UPBOARD_REGISTER_SIZE 16
+#define UPBOARD_READ_FLAG     BIT(UPBOARD_ADDRESS_SIZE)
+
+/**
+ * enum upboard_reg - addresses for 16-bit controller registers
+ *
+ * @UPBOARD_REG_PLATFORM_ID:    [RO] BOARD_ID | MANUFACTURER_ID
+ * @UPBOARD_REG_FIRMWARE_ID:    [RO] BUILD | MAJOR | MINOR | PATCH
+ * @UPBOARD_REG_FUNC_EN0:       [RW] Toggles for board functions (bank 0)
+ * @UPBOARD_REG_FUNC_EN1:       [RW] Toggles for board functions (bank 1)
+ * @UPBOARD_REG_GPIO_EN0:       [RW] Hi-Z (0) / enabled (1) GPIO (bank 0)
+ * @UPBOARD_REG_GPIO_EN1:       [RW] Hi-Z (0) / enabled (1) GPIO (bank 1)
+ * @UPBOARD_REG_GPIO_EN2:       [RW] Hi-Z (0) / enabled (1) GPIO (bank 2)
+ * @UPBOARD_REG_GPIO_DIR0:      [RW] SoC- (0) / FPGA- (1) driven GPIO (bank 0)
+ * @UPBOARD_REG_GPIO_DIR1:      [RW] SoC- (0) / FPGA- (1) driven GPIO (bank 1)
+ * @UPBOARD_REG_GPIO_DIR2:      [RW] SoC- (0) / FPGA- (1) driven GPIO (bank 2)
+ * @UPBOARD_REG_MAX: one past the last valid address
+ */
+enum upboard_reg {
+	UPBOARD_REG_PLATFORM_ID   = 0x10,
+	UPBOARD_REG_FIRMWARE_ID   = 0x11,
+	UPBOARD_REG_FUNC_EN0      = 0x20,
+	UPBOARD_REG_FUNC_EN1      = 0x21,
+	UPBOARD_REG_GPIO_EN0      = 0x30,
+	UPBOARD_REG_GPIO_EN1      = 0x31,
+	UPBOARD_REG_GPIO_EN2      = 0x32,
+	UPBOARD_REG_GPIO_DIR0     = 0x40,
+	UPBOARD_REG_GPIO_DIR1     = 0x41,
+	UPBOARD_REG_GPIO_DIR2     = 0x42,
+	UPBOARD_REG_MAX,
+};
+
+/**
+ * struct upboard - internal data shared by the UP MFD and its child drivers
+ *
+ * @dev: pointer to the MFD device
+ * @regmap: pointer to the regmap of 16-bit control registers
+ * @clear_gpio: descriptor for the CLEAR line on the controller
+ * @strobe_gpio: descriptor for the STROBE line on the controller
+ * @datain_gpio: descriptor for the DATAIN line on the controller
+ * @dataout_gpio: descriptor for the DATAOUT line on the controller
+ */
+struct upboard {
+	struct device *dev;
+	struct regmap *regmap;
+	struct gpio_desc *clear_gpio;
+	struct gpio_desc *strobe_gpio;
+	struct gpio_desc *datain_gpio;
+	struct gpio_desc *dataout_gpio;
+};
+
+#endif /*  __LINUX_MFD_UPBOARD_H */
-- 
2.17.0
