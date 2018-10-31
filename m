Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98561C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 20:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 425B82054F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 20:45:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 425B82054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=emutex.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730169AbeKAFp1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 01:45:27 -0400
Received: from mr35.theemaillaundry.net ([109.169.43.43]:38008 "EHLO
        mr35.theemaillaundry.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730055AbeKAFpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 01:45:21 -0400
Received: from localhost (localhost [127.0.0.1])
        by mr35.theemaillaundry.net (Postfix) with ESMTP id 439D5A10C0;
        Wed, 31 Oct 2018 20:45:35 +0000 (GMT)
X-Amavis-Modified: Mail body modified (using disclaimer) -
        mr35.theemaillaundry.net
X-Virus-Scanned: amavisd-new at theemaillaundry.net
Received: from mr35.theemaillaundry.net ([127.0.0.1])
        by localhost (mr35.theemaillaundry.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id amE82gqRV-Dw; Wed, 31 Oct 2018 20:45:28 +0000 (GMT)
Received: from statler.emutex.com (unknown [92.51.199.138])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mr35.theemaillaundry.net (Postfix) with ESMTPS id EBEB19FF0A;
        Wed, 31 Oct 2018 20:45:27 +0000 (GMT)
Received: from [10.10.68.81] (helo=dan-Latitude-E5450.emutex.com)
        by statler.emutex.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA256:128)
        (Exim 4.84)
        (envelope-from <dan@emutex.com>)
        id 1gHxMk-0007KU-5V; Wed, 31 Oct 2018 20:45:27 +0000
From:   Dan O'Donovan <dan@emutex.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, linux-gpio@vger.kernel.org,
        linux-leds@vger.kernel.org,
        Carlos Iglesias <carlos.iglesias@emutex.com>,
        Dan O'Donovan <dan@emutex.com>
Subject: [PATCH v3 1/3] mfd: upboard: Add UP2 platform controller driver
Date:   Wed, 31 Oct 2018 20:44:47 +0000
Message-Id: <1541018689-20625-2-git-send-email-dan@emutex.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541018689-20625-1-git-send-email-dan@emutex.com>
References: <1539969334-24577-1-git-send-email-dan@emutex.com>
 <1541018689-20625-1-git-send-email-dan@emutex.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
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

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Dan O'Donovan <dan@emutex.com>
---
 drivers/mfd/Kconfig         |  17 +++
 drivers/mfd/Makefile        |   1 +
 drivers/mfd/upboard.c       | 336 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/upboard.h |  44 ++++++
 4 files changed, 398 insertions(+)
 create mode 100644 drivers/mfd/upboard.c
 create mode 100644 include/linux/mfd/upboard.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 8c5dfdc..cccb901 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1871,6 +1871,23 @@ config MFD_STM32_TIMERS
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
+	  will be called "upboard".
+
 menu "Multimedia Capabilities Port drivers"
 	depends on ARCH_SA1100
 
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 12980a4..593b86f 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -242,3 +242,4 @@ obj-$(CONFIG_MFD_SC27XX_PMIC)	+= sprd-sc27xx-spi.o
 obj-$(CONFIG_RAVE_SP_CORE)	+= rave-sp.o
 obj-$(CONFIG_MFD_ROHM_BD718XX)	+= rohm-bd718x7.o
 
+obj-$(CONFIG_MFD_UPBOARD)  += upboard.o
diff --git a/drivers/mfd/upboard.c b/drivers/mfd/upboard.c
new file mode 100644
index 0000000..8b88731
--- /dev/null
+++ b/drivers/mfd/upboard.c
@@ -0,0 +1,336 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// UP Board platform controller driver
+//
+// Copyright (c) 2018, Emutex Ltd.
+//
+// Author: Javier Arteaga <javier@emutex.com>
+//
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
+#define UPBOARD_FW_BUILD_SHIFT 12
+#define UPBOARD_FW_MAJOR_SHIFT 8
+#define UPBOARD_FW_MINOR_SHIFT 4
+#define UPBOARD_FW_PATCH_SHIFT 0
+
+#define UPBOARD_FW_BUILD(id) (((id) >> UPBOARD_FW_BUILD_SHIFT) & 0x0f)
+#define UPBOARD_FW_MAJOR(id) (((id) >> UPBOARD_FW_MAJOR_SHIFT) & 0x0f)
+#define UPBOARD_FW_MINOR(id) (((id) >> UPBOARD_FW_MINOR_SHIFT) & 0x0f)
+#define UPBOARD_FW_PATCH(id) (((id) >> UPBOARD_FW_PATCH_SHIFT) & 0x0f)
+
+#define AAEON_MANUFACTURER_ID 0x01
+#define SUPPORTED_FW_MAJOR 0x0
+
+/* MSb of 8-bit address is an R/W flag */
+#define UPBOARD_ADDRESS_SIZE  8
+#define UPBOARD_READ_FLAG     BIT(7)
+
+enum upboard_id {
+	UPBOARD_ID_UP2 = 1,
+};
+
+struct upboard_ddata {
+	struct gpio_desc *clear_gpio;
+	struct gpio_desc *strobe_gpio;
+	struct gpio_desc *datain_gpio;
+	struct gpio_desc *dataout_gpio;
+	const struct regmap_config *regmapconf;
+	const struct mfd_cell *cells;
+	size_t ncells;
+};
+
+/*
+ * UP boards include a platform controller with a proprietary GPIO-bitbanged
+ * control interface to access its configuration registers.
+ *
+ * The following macros and functions implement the read/write handlers for
+ * that interface, to provide a regmap-based abstraction for the controller.
+ */
+
+#define set_clear(u, x) gpiod_set_value((u)->clear_gpio, (x))
+#define set_strobe(u, x) gpiod_set_value((u)->strobe_gpio, (x))
+#define set_datain(u, x) gpiod_set_value((u)->datain_gpio, (x))
+#define get_dataout(u) gpiod_get_value((u)->dataout_gpio)
+
+static void __reg_io_start(const struct upboard_ddata * const ddata)
+{
+	/*
+	 * CLEAR signal must be pulsed low before any register access.
+	 * This resets internal counters in the controller and marks
+	 * the start of a new register access.
+	 */
+	set_clear(ddata, 0);
+	set_clear(ddata, 1);
+}
+
+static void __reg_io_end(const struct upboard_ddata * const ddata)
+{
+	/*
+	 * STROBE signal must be cycled again to mark the end of a register
+	 * access.  Partial register accesses are discarded harmlessly
+	 * by the controller if this final strobe cycle is not sent
+	 */
+	set_strobe(ddata, 0);
+	set_strobe(ddata, 1);
+}
+
+static void __reg_io_write(const struct upboard_ddata * const ddata,
+			   unsigned int size, unsigned int val)
+{
+	/*
+	 * DATAIN is latched on each rising edge of the STROBE signal.
+	 * Data (register address or value) is sent MSb first.
+	 */
+	while (size--) {
+		set_strobe(ddata, 0);
+		set_datain(ddata, (val >> size) & 0x1);
+		set_strobe(ddata, 1);
+	}
+}
+
+static void __reg_io_read(const struct upboard_ddata * const ddata,
+			  unsigned int size, unsigned int *val)
+{
+	/*
+	 * DATAOUT is latched on on each rising edge of the STROBE signal.
+	 * Data (register value) is received MSb first.
+	 */
+	*val = 0;
+	while (size--) {
+		set_strobe(ddata, 0);
+		set_strobe(ddata, 1);
+		*val |= get_dataout(ddata) << size;
+	}
+}
+
+static int upboard_reg_read(void *context, unsigned int reg, unsigned int *val)
+{
+	const struct upboard_ddata * const ddata = context;
+
+	__reg_io_start(ddata);
+	__reg_io_write(ddata, UPBOARD_ADDRESS_SIZE, reg | UPBOARD_READ_FLAG);
+	__reg_io_read(ddata, UPBOARD_REGISTER_SIZE, val);
+	__reg_io_end(ddata);
+
+	return 0;
+}
+
+static int upboard_reg_write(void *context, unsigned int reg, unsigned int val)
+{
+	const struct upboard_ddata * const ddata = context;
+
+	__reg_io_start(ddata);
+	__reg_io_write(ddata, UPBOARD_ADDRESS_SIZE, reg);
+	__reg_io_write(ddata, UPBOARD_REGISTER_SIZE, val);
+	__reg_io_end(ddata);
+
+	return 0;
+}
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
+	.reg_read = upboard_reg_read,
+	.reg_write = upboard_reg_write,
+	.fast_io = false,
+	.cache_type = REGCACHE_RBTREE,
+	.rd_table = &upboard_up2_readable_table,
+	.wr_table = &upboard_up2_writable_table,
+};
+
+static const struct mfd_cell upboard_up2_mfd_cells[] = {
+	{
+		.name = "upboard-led",
+		.id = 0,
+	},
+	{
+		.name = "upboard-led",
+		.id = 1,
+	},
+	{
+		.name = "upboard-led",
+		.id = 2,
+	},
+	{
+		.name = "upboard-led",
+		.id = 3,
+	},
+	{
+		.name = "upboard-pinctrl"
+	},
+};
+
+static int upboard_init_gpio(struct device *dev)
+{
+	struct upboard_ddata *ddata = dev_get_drvdata(dev);
+	struct gpio_desc *enable_gpio;
+
+	ddata->clear_gpio = devm_gpiod_get(dev, "clear", GPIOD_OUT_LOW);
+	if (IS_ERR(ddata->clear_gpio))
+		return PTR_ERR(ddata->clear_gpio);
+
+	ddata->strobe_gpio = devm_gpiod_get(dev, "strobe", GPIOD_OUT_LOW);
+	if (IS_ERR(ddata->strobe_gpio))
+		return PTR_ERR(ddata->strobe_gpio);
+
+	ddata->datain_gpio = devm_gpiod_get(dev, "datain", GPIOD_OUT_LOW);
+	if (IS_ERR(ddata->datain_gpio))
+		return PTR_ERR(ddata->datain_gpio);
+
+	ddata->dataout_gpio = devm_gpiod_get(dev, "dataout", GPIOD_IN);
+	if (IS_ERR(ddata->dataout_gpio))
+		return PTR_ERR(ddata->dataout_gpio);
+
+	/* External I/O signals are gated by ENABLE - ensure this is high */
+	enable_gpio = devm_gpiod_get(dev, "enable", GPIOD_OUT_HIGH);
+	if (IS_ERR(enable_gpio))
+		return PTR_ERR(enable_gpio);
+
+	return 0;
+}
+
+static int upboard_check_supported(struct device *dev, struct regmap *regmap)
+{
+	uint8_t manufacturer_id, build, major, minor, patch;
+	unsigned int platform_id, firmware_id;
+	int ret;
+
+	ret = regmap_read(regmap, UPBOARD_REG_PLATFORM_ID, &platform_id);
+	if (ret)
+		return ret;
+
+	manufacturer_id = platform_id;
+	if (manufacturer_id != AAEON_MANUFACTURER_ID) {
+		dev_err(dev,
+			"unsupported FPGA firmware from manufacturer 0x%02x",
+			manufacturer_id);
+		return -ENODEV;
+	}
+
+	ret = regmap_read(regmap, UPBOARD_REG_FIRMWARE_ID, &firmware_id);
+	if (ret)
+		return ret;
+
+	build = UPBOARD_FW_BUILD(firmware_id);
+	major = UPBOARD_FW_MAJOR(firmware_id);
+	minor = UPBOARD_FW_MINOR(firmware_id);
+	patch = UPBOARD_FW_PATCH(firmware_id);
+	if (major != SUPPORTED_FW_MAJOR) {
+		dev_err(dev, "unsupported FPGA firmware v%u.%u.%u.%u",
+			 major, minor, patch, build);
+		return -ENODEV;
+	}
+
+	dev_dbg(dev, "supported FPGA firmware v%u.%u.%u.%u",
+		major, minor, patch, build);
+	return 0;
+}
+
+static const struct acpi_device_id upboard_acpi_match[] = {
+	{ "AANT0F01", (kernel_ulong_t)UPBOARD_ID_UP2 },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, upboard_acpi_match);
+
+static int upboard_match_device(struct device *dev)
+{
+	struct upboard_ddata *ddata = dev_get_drvdata(dev);
+	enum upboard_id id = (kernel_ulong_t)device_get_match_data(dev);
+
+	switch (id) {
+	case UPBOARD_ID_UP2:
+		ddata->regmapconf = &upboard_up2_regmap_config;
+		ddata->cells = upboard_up2_mfd_cells;
+		ddata->ncells = ARRAY_SIZE(upboard_up2_mfd_cells);
+		break;
+	default:
+		dev_err(dev, "unsupported ID %u\n", id);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int upboard_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct upboard_ddata *ddata;
+	struct regmap *regmap;
+	int ret;
+
+	ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
+	if (!ddata)
+		return -ENOMEM;
+
+	dev_set_drvdata(dev, ddata);
+
+	ret = upboard_match_device(dev);
+	if (ret)
+		return ret;
+
+	regmap = devm_regmap_init(dev, NULL, ddata, ddata->regmapconf);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	ret = upboard_init_gpio(dev);
+	if (ret) {
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "failed to init GPIOs: %d", ret);
+		return ret;
+	}
+
+	ret = upboard_check_supported(dev, regmap);
+	if (ret)
+		return ret;
+
+	return devm_mfd_add_devices(dev, 0, ddata->cells, ddata->ncells,
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
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/mfd/upboard.h b/include/linux/mfd/upboard.h
new file mode 100644
index 0000000..63e677f
--- /dev/null
+++ b/include/linux/mfd/upboard.h
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// UP Board MFD driver interface
+//
+// Copyright (c) 2018, Emutex Ltd.
+//
+// Author: Javier Arteaga <javier@emutex.com>
+//
+
+#ifndef __LINUX_MFD_UPBOARD_H
+#define __LINUX_MFD_UPBOARD_H
+
+#define UPBOARD_REGISTER_SIZE 16
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
+#endif /*  __LINUX_MFD_UPBOARD_H */
-- 
2.7.4


------
This email has been scanned for spam and malware by The Email Laundry.

