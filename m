Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3431C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 21:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A50492147C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 21:30:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440182AbfBNVae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 16:30:34 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:48313 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388241AbfBNVad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 16:30:33 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from sramani@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 14 Feb 2019 23:30:25 +0200
Received: from farm-0002.mtbu.labs.mlnx (farm-0002.mtbu.labs.mlnx [10.15.2.32])
        by mtbu-labmailer.labs.mlnx (8.14.4/8.14.4) with ESMTP id x1ELUOqC028415;
        Thu, 14 Feb 2019 16:30:24 -0500
Received: (from sramani@localhost)
        by farm-0002.mtbu.labs.mlnx (8.14.7/8.13.8/Submit) id x1ELUHWJ031067;
        Thu, 14 Feb 2019 16:30:17 -0500
From:   Shravan Kumar Ramani <sramani@mellanox.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Shravan Kumar Ramani <sramani@mellanox.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/1] gpio: add driver for Mellanox BlueField GPIO controller
Date:   Thu, 14 Feb 2019 16:29:50 -0500
Message-Id: <db046221591c037713a7e6994798c3b01e1fca20.1550178875.git.sramani@mellanox.com>
X-Mailer: git-send-email 2.1.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for the GPIO controller used by Mellanox
BlueField SOCs.

Reviewed-by: David Woods <dwoods@mellanox.com>
Signed-off-by: Shravan Kumar Ramani <sramani@mellanox.com>
---
 drivers/gpio/Kconfig      |   7 ++
 drivers/gpio/Makefile     |   1 +
 drivers/gpio/gpio-mlxbf.c | 287 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 295 insertions(+)
 create mode 100644 drivers/gpio/gpio-mlxbf.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index b5a2845..2bebe92 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1292,6 +1292,13 @@ config GPIO_MERRIFIELD
 	help
 	  Say Y here to support Intel Merrifield GPIO.
 
+config GPIO_MLXBF
+	tristate "Mellanox BlueField SoC GPIO"
+	depends on (MELLANOX_PLATFORM && ARM64 && ACPI) || COMPILE_TEST
+	select GPIO_GENERIC
+	help
+	  Say Y here if you want GPIO support on Mellanox BlueField SoC.
+
 config GPIO_ML_IOH
 	tristate "OKI SEMICONDUCTOR ML7213 IOH GPIO support"
 	depends on X86 || COMPILE_TEST
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 37628f8..8d54279 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -83,6 +83,7 @@ obj-$(CONFIG_GPIO_MENZ127)	+= gpio-menz127.o
 obj-$(CONFIG_GPIO_MERRIFIELD)	+= gpio-merrifield.o
 obj-$(CONFIG_GPIO_MC33880)	+= gpio-mc33880.o
 obj-$(CONFIG_GPIO_MC9S08DZ60)	+= gpio-mc9s08dz60.o
+obj-$(CONFIG_GPIO_MLXBF)	+= gpio-mlxbf.o
 obj-$(CONFIG_GPIO_ML_IOH)	+= gpio-ml-ioh.o
 obj-$(CONFIG_GPIO_MM_LANTIQ)	+= gpio-mm-lantiq.o
 obj-$(CONFIG_GPIO_MOCKUP)      += gpio-mockup.o
diff --git a/drivers/gpio/gpio-mlxbf.c b/drivers/gpio/gpio-mlxbf.c
new file mode 100644
index 0000000..e5c50db
--- /dev/null
+++ b/drivers/gpio/gpio-mlxbf.c
@@ -0,0 +1,287 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/acpi.h>
+#include <linux/bitops.h>
+#include <linux/device.h>
+#include <linux/gpio/driver.h>
+#include <linux/io.h>
+#include <linux/ioport.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/pinctrl/consumer.h>
+#include <linux/platform_device.h>
+#include <linux/pm.h>
+#include <linux/resource.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+#include <linux/version.h>
+
+/* Number of pins on BlueField */
+#define MLXBF_GPIO_NR 54
+
+/* Pad Electrical Controls. */
+#define GPIO_PAD_CONTROL__FIRST_WORD 0x0700
+#define GPIO_PAD_CONTROL_1__FIRST_WORD 0x0708
+#define GPIO_PAD_CONTROL_2__FIRST_WORD 0x0710
+#define GPIO_PAD_CONTROL_3__FIRST_WORD 0x0718
+
+#define GPIO_PIN_DIR_I 0x1040
+#define GPIO_PIN_DIR_O 0x1048
+#define GPIO_PIN_STATE 0x1000
+#define GPIO_SCRATCHPAD 0x20
+
+#ifdef CONFIG_PM
+struct bluefield_context_save_regs {
+	u64 gpio_scratchpad;
+	u64 gpio_pad_control[MLXBF_GPIO_NR];
+	u64 gpio_pin_dir_i;
+	u64 gpio_pin_dir_o;
+};
+#endif
+
+/* Device state structure. */
+struct gpio_state {
+	struct list_head node;
+	struct platform_device *pdev;
+
+	struct gpio_chip gc;
+
+	/* Must hold this lock to modify shared data. */
+	spinlock_t lock;
+
+	/* Memory Address */
+	void __iomem *dc_base;
+
+#ifdef CONFIG_PM
+	struct bluefield_context_save_regs csave_regs;
+#endif
+};
+
+/* GPIO driver set input pins */
+static int gpio_bf_set_input(struct gpio_chip *chip, unsigned int offset)
+{
+	struct gpio_state *gs = gpiochip_get_data(chip);
+	u64 in;
+	u64 out;
+
+	if (offset > MLXBF_GPIO_NR - 1) {
+		dev_err(chip->parent, "gpio input pins: Invalid offset %d\n",
+			offset);
+		return -EINVAL;
+	}
+
+	out = readq(gs->dc_base + GPIO_PIN_DIR_O);
+	in = readq(gs->dc_base + GPIO_PIN_DIR_I);
+
+	writeq(out & ~BIT(offset), gs->dc_base + GPIO_PIN_DIR_O);
+	writeq(in | BIT(offset), gs->dc_base + GPIO_PIN_DIR_I);
+
+	return 0;
+}
+
+/* GPIO driver set output pins */
+static int gpio_bf_set_output(struct gpio_chip *chip, unsigned int offset)
+{
+	struct gpio_state *gs = gpiochip_get_data(chip);
+	u64 in;
+	u64 out;
+
+	if (offset > MLXBF_GPIO_NR - 1) {
+		dev_err(chip->parent, "gpio output pins: Invalid offset %d\n",
+			offset);
+		return -EINVAL;
+	}
+
+	out = readq(gs->dc_base + GPIO_PIN_DIR_O);
+	in = readq(gs->dc_base + GPIO_PIN_DIR_I);
+
+	writeq(out | BIT(offset), gs->dc_base + GPIO_PIN_DIR_O);
+	writeq(in & ~BIT(offset), gs->dc_base + GPIO_PIN_DIR_I);
+
+	return 0;
+}
+
+/* GPIO driver output direction */
+static int gpio_bf_set_output_lock(struct gpio_chip *chip,
+				   unsigned int offset, int value)
+{
+	struct gpio_state *gs = gpiochip_get_data(chip);
+
+	spin_lock(&gs->lock);
+	gpio_bf_set_output(chip, offset);
+	spin_unlock(&gs->lock);
+
+	return 0;
+}
+
+/* GPIO driver input direction */
+static int gpio_bf_set_input_lock(struct gpio_chip *chip, unsigned int offset)
+{
+	struct gpio_state *gs = gpiochip_get_data(chip);
+
+	spin_lock(&gs->lock);
+	gpio_bf_set_input(chip, offset);
+	spin_unlock(&gs->lock);
+
+	return 0;
+}
+
+/* GPIO driver read routine. */
+static int gpio_bf_get(struct gpio_chip *chip, unsigned int offset)
+{
+	u64 value;
+	struct gpio_state *gs = gpiochip_get_data(chip);
+
+	value = readq(gs->dc_base + GPIO_PIN_STATE);
+
+	return (value >> offset) & 1;
+}
+
+/* GPIO driver write routine. */
+static void gpio_bf_set(struct gpio_chip *chip, unsigned int offset, int value)
+{
+	u64 data;
+	struct gpio_state *gs = gpiochip_get_data(chip);
+
+	spin_lock(&gs->lock);
+	data = readq(gs->dc_base + GPIO_PIN_STATE);
+
+	if (value)
+		data |= BIT(offset);
+	else
+		data &= ~BIT(offset);
+	writeq(data, gs->dc_base + GPIO_PIN_STATE);
+	spin_unlock(&gs->lock);
+}
+
+/* GPIO driver initialization routine. */
+static int gpiodrv_probe(struct platform_device *pdev)
+{
+	struct gpio_state *gs;
+	struct device *dev = &pdev->dev;
+	struct gpio_chip *gc;
+	struct resource *dc_res;
+	int ret;
+
+	dc_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!dc_res)
+		return -EINVAL;
+
+	if (devm_request_mem_region(&pdev->dev, dc_res->start,
+				    resource_size(dc_res), "gpiodrv") == NULL)
+		return -EBUSY;
+
+	gs = devm_kzalloc(&pdev->dev, sizeof(struct gpio_state), GFP_KERNEL);
+	if (!gs)
+		return -ENOMEM;
+
+	gs->dc_base = devm_ioremap(&pdev->dev, dc_res->start,
+				   resource_size(dc_res));
+	if (!gs->dc_base)
+		return -ENOMEM;
+
+	gc = &gs->gc;
+	gc->direction_input = gpio_bf_set_input_lock;
+	gc->get = gpio_bf_get;
+	gc->direction_output = gpio_bf_set_output_lock;
+	gc->set = gpio_bf_set;
+	gc->label = dev_name(dev);
+	gc->parent = &pdev->dev;
+	gc->owner = THIS_MODULE;
+	gc->base = 0;
+	gc->ngpio = MLXBF_GPIO_NR;
+
+	ret = gpiochip_add_data(&gs->gc, gs);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed adding memory mapped gpiochip\n");
+		goto err;
+	}
+
+	spin_lock_init(&gs->lock);
+	platform_set_drvdata(pdev, gs);
+	dev_info(&pdev->dev, "registered Mellanox BlueField GPIO");
+	return 0;
+
+err:
+	dev_err(&pdev->dev, "Probe, Failed\n");
+	return ret;
+}
+
+#ifdef CONFIG_PM
+/* GPIO driver suspend routine. */
+static int gpiodrv_suspend(struct platform_device *pdev, pm_message_t state)
+{
+	struct gpio_state *gs = platform_get_drvdata(pdev);
+
+	gs->csave_regs.gpio_scratchpad = readq(gs->dc_base + GPIO_SCRATCHPAD);
+	gs->csave_regs.gpio_pad_control[0] =
+		readq(gs->dc_base + GPIO_PAD_CONTROL__FIRST_WORD);
+	gs->csave_regs.gpio_pad_control[1] =
+		readq(gs->dc_base + GPIO_PAD_CONTROL_1__FIRST_WORD);
+	gs->csave_regs.gpio_pad_control[2] =
+		readq(gs->dc_base + GPIO_PAD_CONTROL_2__FIRST_WORD);
+	gs->csave_regs.gpio_pad_control[3] =
+		readq(gs->dc_base + GPIO_PAD_CONTROL_3__FIRST_WORD);
+	gs->csave_regs.gpio_pin_dir_i = readq(gs->dc_base + GPIO_PIN_DIR_I);
+	gs->csave_regs.gpio_pin_dir_o = readq(gs->dc_base + GPIO_PIN_DIR_O);
+
+	return 0;
+}
+
+/* GPIO driver resume routine. */
+static int gpiodrv_resume(struct platform_device *pdev)
+{
+	struct gpio_state *gs = platform_get_drvdata(pdev);
+
+	writeq(gs->csave_regs.gpio_scratchpad, gs->dc_base + GPIO_SCRATCHPAD);
+	writeq(gs->csave_regs.gpio_pad_control[0], gs->dc_base +
+	       GPIO_PAD_CONTROL__FIRST_WORD);
+	writeq(gs->csave_regs.gpio_pad_control[1], gs->dc_base +
+	       GPIO_PAD_CONTROL_1__FIRST_WORD);
+	writeq(gs->csave_regs.gpio_pad_control[2], gs->dc_base +
+	       GPIO_PAD_CONTROL_2__FIRST_WORD);
+	writeq(gs->csave_regs.gpio_pad_control[3], gs->dc_base +
+	       GPIO_PAD_CONTROL_3__FIRST_WORD);
+	writeq(gs->csave_regs.gpio_pin_dir_i, gs->dc_base + GPIO_PIN_DIR_I);
+	writeq(gs->csave_regs.gpio_pin_dir_o, gs->dc_base + GPIO_PIN_DIR_O);
+
+	return 0;
+}
+#endif
+
+/* GPIO driver exit routine. */
+static int gpiodrv_remove(struct platform_device *pdev)
+{
+	struct gpio_state *gs = platform_get_drvdata(pdev);
+
+	gpiochip_remove(&gs->gc);
+	iounmap(gs->dc_base);
+
+	return 0;
+}
+
+static const struct acpi_device_id gpiodrv_acpi_match[] = {
+	{ "MLNXBF02", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, gpiodrv_acpi_match);
+
+static struct platform_driver gpiodrv_gpio_driver = {
+	.driver = {
+		.name = "gpiodrv",
+		.acpi_match_table = ACPI_PTR(gpiodrv_acpi_match),
+	},
+	.probe    = gpiodrv_probe,
+	.remove   = gpiodrv_remove,
+#ifdef CONFIG_PM
+	.suspend  = gpiodrv_suspend,
+	.resume   = gpiodrv_resume,
+#endif
+};
+
+module_platform_driver(gpiodrv_gpio_driver);
+
+MODULE_DESCRIPTION("Mellanox BlueField GPIO Driver");
+MODULE_AUTHOR("Mellanox Technologies");
+MODULE_LICENSE("GPL");
-- 
2.1.2

