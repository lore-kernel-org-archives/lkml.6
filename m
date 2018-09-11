Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4BB4C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74C102086E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 15:09:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="UicJwGy/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74C102086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbeIKUJU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 16:09:20 -0400
Received: from smtprelay2.synopsys.com ([198.182.60.111]:56916 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbeIKUJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 16:09:19 -0400
Received: from mailhost.synopsys.com (mailhost2.synopsys.com [10.13.184.66])
        by smtprelay.synopsys.com (Postfix) with ESMTP id BECA010C11FC;
        Tue, 11 Sep 2018 08:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1536678576; bh=xMSHcOiIaItLSdggoJXMEXa6c1Ia9PAljsqSYUuUu8o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UicJwGy/6pzyVCu4bPL+rOVd9UQKVOY4EMEbhWTFl7K4+pdURTcUCzarJw8LlMGDZ
         XaFLDIS98fVTMmnCWJf5ZAyBrofkTQdjuXKlqTVd08OQWSAMKqwCL+nZxe6lO9wNdj
         akn2w++MelnHAaSVJZp4W8FOkEoTkLWFsCDq7Mw2J+CuadbklW07vLdxT56qHgmMyo
         zauCQVwJyOV4o2wdKe0GJ7GMwuMQMFj4vA5aFtIkIer8P5notW/P9SyXkpcioUACCb
         g3vPb5FEC3f7OrOIJmgxFdRfSboylGdHPUwfXusKhL0XjG4O+a6N/m1n3N1VTtCWy0
         /At323yoCw1/g==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.3.37])
        by mailhost.synopsys.com (Postfix) with ESMTP id BC6BD3AE1;
        Tue, 11 Sep 2018 08:09:32 -0700 (PDT)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org, linux-gpio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH v3 1/2] GPIO: add single-register GPIO via CREG driver
Date:   Tue, 11 Sep 2018 18:09:24 +0300
Message-Id: <20180911150925.19460-2-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180911150925.19460-1-Eugeniy.Paltsev@synopsys.com>
References: <20180911150925.19460-1-Eugeniy.Paltsev@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add single-register MMIO GPIO driver for complex cases where
only several fields in register belong to GPIO lines and each GPIO
line owns a field with different length and on/off value.

Such CREG GPIOs are used in Synopsys AXS10x and HSDK boards.

Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
---
Changes v2->v3:
 * Move parameters into a lookup table instead of device tree.
 * Use the ngpios attribute for instead of snps,ngpios.

 MAINTAINERS                   |   6 ++
 drivers/gpio/Kconfig          |  10 ++
 drivers/gpio/Makefile         |   1 +
 drivers/gpio/gpio-creg-snps.c | 212 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 229 insertions(+)
 create mode 100644 drivers/gpio/gpio-creg-snps.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 544cac829cf4..e731f2f9648a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13734,6 +13734,12 @@ S:	Supported
 F:	drivers/reset/reset-axs10x.c
 F:	Documentation/devicetree/bindings/reset/snps,axs10x-reset.txt
 
+SYNOPSYS CREG GPIO DRIVER
+M:	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
+S:	Maintained
+F:	drivers/gpio/gpio-creg-snps.c
+F:	Documentation/devicetree/bindings/gpio/snps,creg-gpio.txt
+
 SYNOPSYS DESIGNWARE 8250 UART DRIVER
 R:	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
 S:	Maintained
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 71c0ab46f216..78155ac22b0c 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -430,6 +430,16 @@ config GPIO_REG
 	  A 32-bit single register GPIO fixed in/out implementation.  This
 	  can be used to represent any register as a set of GPIO signals.
 
+config GPIO_SNPS_CREG
+	bool "Synopsys GPIO via CREG (Control REGisters) driver"
+	depends on ARC || COMPILE_TEST
+	select OF_GPIO
+	help
+	  This driver supports GPIOs via CREG on various Synopsys SoCs.
+	  This is a single-register MMIO GPIO driver for complex cases
+	  where only several fields in register belong to GPIO lines and
+	  each GPIO line owns a field with different length and on/off value.
+
 config GPIO_SPEAR_SPICS
 	bool "ST SPEAr13xx SPI Chip Select as GPIO support"
 	depends on PLAT_SPEAR
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 1324c8f966a7..993f8ad54a19 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -109,6 +109,7 @@ obj-$(CONFIG_GPIO_REG)		+= gpio-reg.o
 obj-$(CONFIG_ARCH_SA1100)	+= gpio-sa1100.o
 obj-$(CONFIG_GPIO_SCH)		+= gpio-sch.o
 obj-$(CONFIG_GPIO_SCH311X)	+= gpio-sch311x.o
+obj-$(CONFIG_GPIO_SNPS_CREG)	+= gpio-creg-snps.o
 obj-$(CONFIG_GPIO_SODAVILLE)	+= gpio-sodaville.o
 obj-$(CONFIG_GPIO_SPEAR_SPICS)	+= gpio-spear-spics.o
 obj-$(CONFIG_GPIO_SPRD)		+= gpio-sprd.o
diff --git a/drivers/gpio/gpio-creg-snps.c b/drivers/gpio/gpio-creg-snps.c
new file mode 100644
index 000000000000..2400dec529b2
--- /dev/null
+++ b/drivers/gpio/gpio-creg-snps.c
@@ -0,0 +1,212 @@
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Synopsys CREG (Control REGisters) GPIO driver
+//
+// Copyright (C) 2018 Synopsys
+// Author: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
+
+#include <linux/of.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/of_gpio.h>
+#include <linux/io.h>
+#include <linux/of_platform.h>
+#include <linux/module.h>
+
+#include "gpiolib.h"
+
+#define MAX_GPIO	32
+
+struct creg_layout {
+	u8 ngpio;
+	u8 shift[MAX_GPIO];
+	u8 on[MAX_GPIO];
+	u8 off[MAX_GPIO];
+	u8 bit_per_gpio[MAX_GPIO];
+};
+
+struct creg_gpio {
+	struct of_mm_gpio_chip mmchip;
+	spinlock_t lock;
+	const struct creg_layout *layout;
+};
+
+static void creg_gpio_set(struct gpio_chip *gc, unsigned int gpio, int val)
+{
+	struct creg_gpio *hcg = gpiochip_get_data(gc);
+	const struct creg_layout *layout = hcg->layout;
+	u32 reg, reg_shift, value;
+	unsigned long flags;
+	int i;
+
+	value = val ? hcg->layout->on[gpio] : hcg->layout->off[gpio];
+
+	reg_shift = layout->shift[gpio];
+	for (i = 0; i < gpio; i++)
+		reg_shift += layout->bit_per_gpio[i] + layout->shift[i];
+
+	spin_lock_irqsave(&hcg->lock, flags);
+	reg = readl(hcg->mmchip.regs);
+	reg &= ~(GENMASK(layout->bit_per_gpio[i] - 1, 0) << reg_shift);
+	reg |=  (value << reg_shift);
+	writel(reg, hcg->mmchip.regs);
+	spin_unlock_irqrestore(&hcg->lock, flags);
+}
+
+static int creg_gpio_dir_out(struct gpio_chip *gc, unsigned int gpio, int val)
+{
+	creg_gpio_set(gc, gpio, val);
+
+	return 0;
+}
+
+static int creg_gpio_get_direction(struct gpio_chip *gc, unsigned int offset)
+{
+	return 0; /* output */
+}
+
+static int creg_gpio_xlate(struct gpio_chip *gc,
+			   const struct of_phandle_args *gpiospec, u32 *flags)
+{
+	if (gpiospec->args_count != 1) {
+		dev_err(&gc->gpiodev->dev, "invalid args_count: %d\n",
+			gpiospec->args_count);
+		return -EINVAL;
+	}
+
+	if (gpiospec->args[0] >= gc->ngpio) {
+		dev_err(&gc->gpiodev->dev, "gpio number is too big: %d\n",
+			gpiospec->args[0]);
+		return -EINVAL;
+	}
+
+	return gpiospec->args[0];
+}
+
+static int creg_gpio_validate_pg(struct device *dev, struct creg_gpio *hcg,
+				 int i)
+{
+	const struct creg_layout *layout = hcg->layout;
+
+	if (layout->bit_per_gpio[i] < 1 || layout->bit_per_gpio[i] > 8)
+		return -EINVAL;
+
+	/* Check that on valiue suits it's placeholder */
+	if (GENMASK(31, layout->bit_per_gpio[i]) & layout->on[i])
+		return -EINVAL;
+
+	/* Check that off valiue suits it's placeholder */
+	if (GENMASK(31, layout->bit_per_gpio[i]) & layout->off[i])
+		return -EINVAL;
+
+	if (layout->on[i] == layout->off[i])
+		return -EINVAL;
+
+	return 0;
+}
+
+static int creg_gpio_validate(struct device *dev, struct creg_gpio *hcg,
+			      u32 ngpios)
+{
+	u32 reg_len = 0;
+	int i;
+
+	if (hcg->layout->ngpio < 1 || hcg->layout->ngpio > MAX_GPIO)
+		return -EINVAL;
+
+	if (ngpios < 1 || ngpios > hcg->layout->ngpio) {
+		dev_err(dev, "ngpios must be in [1:%u]\n", hcg->layout->ngpio);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < hcg->layout->ngpio; i++) {
+		if (creg_gpio_validate_pg(dev, hcg, i))
+			return -EINVAL;
+
+		reg_len += hcg->layout->shift[i] + hcg->layout->bit_per_gpio[i];
+	}
+
+	/* Check that we suit in 32 bit register */
+	if (reg_len > 32)
+		return -EINVAL;
+
+	return 0;
+}
+
+static const struct creg_layout hsdk_cs_ctl = {
+	.ngpio		= 10,
+	.shift		= { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
+	.off		= { 2, 2, 2, 2, 2, 2, 2, 2, 2, 2 },
+	.on		= { 3, 3, 3, 3, 3, 3, 3, 3, 3, 3 },
+	.bit_per_gpio	= { 2, 2, 2, 2, 2, 2, 2, 2, 2, 2 }
+};
+
+static const struct creg_layout axs10x_flsh_cs_ctl = {
+	.ngpio		= 1,
+	.shift		= { 0 },
+	.off		= { 1 },
+	.on		= { 3 },
+	.bit_per_gpio	= { 2 }
+};
+
+static const struct of_device_id creg_gpio_ids[] = {
+	{
+		.compatible = "snps,creg-gpio-axs10x",
+		.data = &axs10x_flsh_cs_ctl
+	}, {
+		.compatible = "snps,creg-gpio-hsdk",
+		.data = &hsdk_cs_ctl
+	}, { /* sentinel */ }
+};
+
+static int creg_gpio_probe(struct platform_device *pdev)
+{
+	const struct of_device_id *match;
+	struct device *dev = &pdev->dev;
+	struct creg_gpio *hcg;
+	u32 ngpios;
+	int ret;
+
+	hcg = devm_kzalloc(dev, sizeof(struct creg_gpio), GFP_KERNEL);
+	if (!hcg)
+		return -ENOMEM;
+
+	match = of_match_node(creg_gpio_ids, pdev->dev.of_node);
+	hcg->layout = match->data;
+	if (!hcg->layout)
+		return -EINVAL;
+
+	ret = of_property_read_u32(dev->of_node, "ngpios", &ngpios);
+	if (ret)
+		return ret;
+
+	ret = creg_gpio_validate(dev, hcg, ngpios);
+	if (ret)
+		return ret;
+
+	spin_lock_init(&hcg->lock);
+
+	hcg->mmchip.gc.ngpio = ngpios;
+	hcg->mmchip.gc.set = creg_gpio_set;
+	hcg->mmchip.gc.get_direction = creg_gpio_get_direction;
+	hcg->mmchip.gc.direction_output = creg_gpio_dir_out;
+	hcg->mmchip.gc.of_xlate = creg_gpio_xlate;
+	hcg->mmchip.gc.of_gpio_n_cells = 1;
+
+	ret = of_mm_gpiochip_add_data(pdev->dev.of_node, &hcg->mmchip, hcg);
+	if (ret)
+		return ret;
+
+	dev_info(dev, "GPIO controller with %d gpios probed\n", ngpios);
+
+	return 0;
+}
+
+static struct platform_driver creg_gpio_snps_driver = {
+	.driver = {
+		.name = "snps-creg-gpio",
+		.of_match_table = creg_gpio_ids,
+	},
+	.probe  = creg_gpio_probe,
+};
+builtin_platform_driver(creg_gpio_snps_driver);
-- 
2.14.4

