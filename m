Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8174C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 13:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8AF8208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 13:25:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8AF8208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbeK1AX3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 19:23:29 -0500
Received: from ms.tdt.de ([195.243.126.94]:58672 "EHLO mail.dev.tdt.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726961AbeK1AX2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 19:23:28 -0500
Received: from feckert01.dev.tdt.de (unknown [10.2.3.40])
        by mail.dev.tdt.de (Postfix) with ESMTPSA id C09D321C57;
        Tue, 27 Nov 2018 13:25:30 +0000 (UTC)
From:   Florian Eckert <fe@dev.tdt.de>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        dvhart@infradead.org, andy@infradead.org,
        Eckert.Florian@googlemail.com
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, Florian Eckert <fe@dev.tdt.de>
Subject: [PATCH v5 1/2] gpio: Add driver for PC Engines APU boards
Date:   Tue, 27 Nov 2018 14:25:07 +0100
Message-Id: <20181127132508.5501-2-fe@dev.tdt.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181127132508.5501-1-fe@dev.tdt.de>
References: <20181127132508.5501-1-fe@dev.tdt.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new device driver "gpio-apu" which will handle the GPIOs on APU2
and APU3 devices from PC Engines.

APU2 (https://pcengines.ch/schema/apu2c.pdf page 7):
- G32 is "button_reset" connected to the smd-button on the frontpanel
- G50 is "mpcie2_reset" connected to mPCIe2 reset line
- G51 is "mpcie3_reset" connected to mPCIe3 reset line

APU3 (https://pcengines.ch/schema/apu3c.pdf page 7):
- G32 is "button_reset" connected to the smd-button on the frontpanel
- G50 is "mpcie2_reset" connected to mPCIe2 reset line
- G51 is "mpcie3_reset" connected to mPCIe3 reset line
- G33 is "simswap" connected to SIM switch IC to swap the SIM between
  mPCIe2 and mPCIe3 slot

Signed-off-by: Florian Eckert <fe@dev.tdt.de>
---
 drivers/gpio/Kconfig    |   7 ++
 drivers/gpio/Makefile   |   1 +
 drivers/gpio/gpio-apu.c | 288 ++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 296 insertions(+)
 create mode 100644 drivers/gpio/gpio-apu.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 833a1b51c948..e89937f6051e 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -117,6 +117,13 @@ config GPIO_AMDPT
 	  driver for GPIO functionality on Promontory IOHub
 	  Require ACPI ASL code to enumerate as a platform device.
 
+config GPIO_APU
+	tristate "PC Engines APU2/APU3 GPIO support"
+	depends on X86
+	help
+	  Say Y here to support GPIO functionality on APU2/APU3 boards
+	  from PC Engines.
+
 config GPIO_ASPEED
 	tristate "Aspeed GPIO support"
 	depends on (ARCH_ASPEED || COMPILE_TEST) && OF_GPIO
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 671c4477c951..9c27523fb189 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -29,6 +29,7 @@ obj-$(CONFIG_GPIO_ALTERA)  	+= gpio-altera.o
 obj-$(CONFIG_GPIO_ALTERA_A10SR)	+= gpio-altera-a10sr.o
 obj-$(CONFIG_GPIO_AMD8111)	+= gpio-amd8111.o
 obj-$(CONFIG_GPIO_AMDPT)	+= gpio-amdpt.o
+obj-$(CONFIG_GPIO_APU)		+= gpio-apu.o
 obj-$(CONFIG_GPIO_ARIZONA)	+= gpio-arizona.o
 obj-$(CONFIG_GPIO_ATH79)	+= gpio-ath79.o
 obj-$(CONFIG_GPIO_ASPEED)	+= gpio-aspeed.o
diff --git a/drivers/gpio/gpio-apu.c b/drivers/gpio/gpio-apu.c
new file mode 100644
index 000000000000..609972d11847
--- /dev/null
+++ b/drivers/gpio/gpio-apu.c
@@ -0,0 +1,288 @@
+// SPDX-License-Identifier: GPL-2.0
+/* PC Engines APU2/APU3 GPIO device driver
+ *
+ * Copyright (C) 2018 Florian Eckert <fe@dev.tdt.de>
+ */
+
+#include <linux/bits.h>
+#include <linux/dmi.h>
+#include <linux/err.h>
+#include <linux/gpio/driver.h>
+#include <linux/input.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#define APU_FCH_ACPI_MMIO_BASE 0xFED80000
+#define APU_FCH_GPIO_BASE      (APU_FCH_ACPI_MMIO_BASE + 0x1500)
+#define APU_GPIO_BIT_RD        16
+#define APU_GPIO_BIT_WR        22
+#define APU_GPIO_BIT_DIR       23
+
+struct apu_gpio_pdata {
+	struct gpio_chip chip;
+	unsigned long *offset;		/* base register offset */
+	void __iomem **addr;		/* remapped iomem addresses */
+	spinlock_t lock;		/* lock register access */
+};
+
+static struct platform_device *apu_gpio_pdev;
+
+/* APU2 */
+static unsigned long apu2_gpio_offset[] = {
+	APU_FCH_GPIO_BASE + 89 * sizeof(u32),
+	APU_FCH_GPIO_BASE + 67 * sizeof(u32),
+	APU_FCH_GPIO_BASE + 66 * sizeof(u32),
+};
+static const char * const apu2_gpio_names[] = {
+	"button_reset",
+	"mpcie2_reset",
+	"mpcie3_reset",
+};
+
+/* APU3 */
+static unsigned long apu3_gpio_offset[] = {
+	APU_FCH_GPIO_BASE + 89 * sizeof(u32),
+	APU_FCH_GPIO_BASE + 67 * sizeof(u32),
+	APU_FCH_GPIO_BASE + 66 * sizeof(u32),
+	APU_FCH_GPIO_BASE + 90 * sizeof(u32),
+};
+static const char * const apu3_gpio_names[] = {
+	"button_reset",
+	"mpcie2_reset",
+	"mpcie3_reset",
+	"simswap",
+};
+
+static int gpio_apu_get_dir(struct gpio_chip *chip, unsigned int offset)
+{
+	u32 val;
+	struct apu_gpio_pdata *apu_gpio = gpiochip_get_data(chip);
+
+	spin_lock(&apu_gpio->lock);
+
+	val = ~ioread32(apu_gpio->addr[offset]);
+
+	spin_unlock(&apu_gpio->lock);
+
+	return !!(val & BIT(APU_GPIO_BIT_DIR));
+}
+
+static int gpio_apu_dir_in(struct gpio_chip *chip, unsigned int offset)
+{
+	u32 val;
+	struct apu_gpio_pdata *apu_gpio = gpiochip_get_data(chip);
+
+	spin_lock(&apu_gpio->lock);
+
+	val = ioread32(apu_gpio->addr[offset]);
+	val &= ~BIT(APU_GPIO_BIT_DIR);
+	iowrite32(val, apu_gpio->addr[offset]);
+
+	spin_unlock(&apu_gpio->lock);
+
+	return 0;
+}
+
+static int gpio_apu_dir_out(struct gpio_chip *chip, unsigned int offset,
+		int value)
+{
+	u32 val;
+	struct apu_gpio_pdata *apu_gpio = gpiochip_get_data(chip);
+
+	spin_lock(&apu_gpio->lock);
+
+	val = ioread32(apu_gpio->addr[offset]);
+	val |= BIT(APU_GPIO_BIT_DIR);
+	iowrite32(val, apu_gpio->addr[offset]);
+
+	spin_unlock(&apu_gpio->lock);
+
+	return 0;
+}
+
+static int gpio_apu_get_data(struct gpio_chip *chip, unsigned int offset)
+{
+	u32 val;
+	struct apu_gpio_pdata *apu_gpio = gpiochip_get_data(chip);
+
+	spin_lock(&apu_gpio->lock);
+
+	val = ioread32(apu_gpio->addr[offset]);
+
+	spin_unlock(&apu_gpio->lock);
+
+	return !!(val & BIT(APU_GPIO_BIT_RD));
+}
+
+static void gpio_apu_set_data(struct gpio_chip *chip, unsigned int offset,
+		int value)
+{
+	u32 val;
+	struct apu_gpio_pdata *apu_gpio = gpiochip_get_data(chip);
+
+	spin_lock(&apu_gpio->lock);
+
+	val = ioread32(apu_gpio->addr[offset]);
+	if (value)
+		val |= BIT(APU_GPIO_BIT_WR);
+	else
+		val &= ~BIT(APU_GPIO_BIT_WR);
+	iowrite32(val, apu_gpio->addr[offset]);
+
+	spin_unlock(&apu_gpio->lock);
+}
+
+static const struct dmi_system_id apu2_gpio_dmi_table[] __initconst = {
+	/* PC Engines APU2 with "Legacy" bios < 4.0.8 */
+	{
+		.ident = "apu2",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "PC Engines"),
+			DMI_MATCH(DMI_BOARD_NAME, "APU2")
+		}
+	},
+	/* PC Engines APU2 with "Legacy" bios >= 4.0.8 */
+	{
+		.ident = "apu2",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "PC Engines"),
+			DMI_MATCH(DMI_BOARD_NAME, "apu2")
+		}
+	},
+	/* PC Engines APU2 with "Mainline" bios */
+	{
+		.ident = "apu2",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "PC Engines"),
+			DMI_MATCH(DMI_BOARD_NAME, "PC Engines apu2")
+		}
+	},
+	{}
+}
+MODULE_DEVICE_TABLE(dmi, apu2_gpio_dmi_table);
+
+static const struct dmi_system_id apu3_gpio_dmi_table[] __initconst = {
+	/* PC Engines APU3 with "Legacy" bios < 4.0.8 */
+	{
+		.ident = "apu3",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "PC Engines"),
+			DMI_MATCH(DMI_BOARD_NAME, "APU3")
+		}
+	},
+	/* PC Engines APU3 with "Legacy" bios >= 4.0.8 */
+	{
+		.ident = "apu3",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "PC Engines"),
+			DMI_MATCH(DMI_BOARD_NAME, "apu3")
+		}
+	},
+	/* PC Engines APU3 with "Mainline" bios */
+	{
+		.ident = "apu3",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "PC Engines"),
+			DMI_MATCH(DMI_BOARD_NAME, "PC Engines apu3")
+		}
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(dmi, apu3_gpio_dmi_table);
+
+static int __init apu_gpio_probe(struct platform_device *pdev)
+{
+	unsigned int i;
+	struct apu_gpio_pdata *apu_gpio;
+
+	apu_gpio = devm_kzalloc(&pdev->dev, sizeof(*apu_gpio), GFP_KERNEL);
+	if (!apu_gpio)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, apu_gpio);
+	spin_lock_init(&apu_gpio->lock);
+
+	apu_gpio->chip.label = KBUILD_MODNAME;
+	apu_gpio->chip.base = 20;
+	apu_gpio->chip.get_direction = gpio_apu_get_dir;
+	apu_gpio->chip.direction_input = gpio_apu_dir_in;
+	apu_gpio->chip.direction_output = gpio_apu_dir_out;
+	apu_gpio->chip.get = gpio_apu_get_data;
+	apu_gpio->chip.set = gpio_apu_set_data;
+
+	if (dmi_check_system(apu3_gpio_dmi_table)) {
+		apu_gpio->addr = devm_kzalloc(&pdev->dev,
+				sizeof(apu3_gpio_offset),
+				GFP_KERNEL);
+
+		if (!apu_gpio->addr)
+			return -ENOMEM;
+
+		apu_gpio->offset = apu3_gpio_offset;
+		apu_gpio->chip.names = apu3_gpio_names;
+		apu_gpio->chip.ngpio = ARRAY_SIZE(apu3_gpio_offset);
+		for (i = 0; i < ARRAY_SIZE(apu3_gpio_offset); i++) {
+			apu_gpio->addr[i] = devm_ioremap(&pdev->dev,
+					apu_gpio->offset[i], sizeof(u32));
+			if (!apu_gpio->addr[i])
+				return -ENOMEM;
+		}
+	} else if (dmi_check_system(apu2_gpio_dmi_table)) {
+		apu_gpio->addr = devm_kzalloc(&pdev->dev,
+				sizeof(apu2_gpio_offset),
+				GFP_KERNEL);
+
+		if (!apu_gpio->addr)
+			return -ENOMEM;
+
+		apu_gpio->offset = apu2_gpio_offset;
+		apu_gpio->chip.names = apu2_gpio_names;
+		apu_gpio->chip.ngpio = ARRAY_SIZE(apu2_gpio_offset);
+		for (i = 0; i < ARRAY_SIZE(apu2_gpio_offset); i++) {
+			apu_gpio->addr[i] = devm_ioremap(&pdev->dev,
+					apu_gpio->offset[i], sizeof(u32));
+			if (!apu_gpio->addr[i])
+				return -ENOMEM;
+		}
+	}
+
+	return devm_gpiochip_add_data(&pdev->dev, &apu_gpio->chip, apu_gpio);
+}
+
+static struct platform_driver apu_gpio_driver = {
+	.driver = {
+		.name = KBUILD_MODNAME,
+	},
+	.probe = apu_gpio_probe,
+};
+
+static int __init apu_gpio_init(void)
+{
+	if (!(dmi_check_system(apu2_gpio_dmi_table)) &&
+		!(dmi_check_system(apu3_gpio_dmi_table))) {
+		pr_err("No PC Engines board detected\n");
+		return -ENODEV;
+	}
+
+	apu_gpio_pdev = platform_device_register_simple(KBUILD_MODNAME,
+			-1, NULL, 0);
+	if (IS_ERR(apu_gpio_pdev))
+		return PTR_ERR(apu_gpio_pdev);
+
+
+	return platform_driver_register(&apu_gpio_driver);
+}
+
+static void __exit apu_gpio_exit(void)
+{
+	platform_device_unregister(apu_gpio_pdev);
+	platform_driver_unregister(&apu_gpio_driver);
+}
+
+module_init(apu_gpio_init);
+module_exit(apu_gpio_exit);
+
+MODULE_AUTHOR("Florian Eckert");
+MODULE_DESCRIPTION("PC Engines APU2/APU3 family GPIO driver");
+MODULE_LICENSE("GPL v2");
-- 
2.11.0

