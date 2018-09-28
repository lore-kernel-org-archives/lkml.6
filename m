Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FFB8C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 13:15:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E1AB2168B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 13:15:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="NrLoGA9M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E1AB2168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=synopsys.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728910AbeI1TjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 15:39:23 -0400
Received: from smtprelay.synopsys.com ([198.182.47.9]:57424 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbeI1TjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 15:39:22 -0400
Received: from mailhost.synopsys.com (mailhost1.synopsys.com [10.12.238.239])
        by smtprelay.synopsys.com (Postfix) with ESMTP id CF3D924E24A0;
        Fri, 28 Sep 2018 06:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1538140538; bh=ir8NLnz8x/hpdrPyR7/SncTfi5RWu+XLjNmmgkYUJ8M=;
        h=From:To:Cc:Subject:Date:From;
        b=NrLoGA9MMOGz6au6Ldfn5MnW7eLPJTDJjUP4hRynHcgKCg7gDpvhLFT6k+E7iIExr
         6B7Cny6TGCcuqz1w8jJZM7otj4MZXwYQUmplbq56hBZzcTc0q6X/qP3f/j6dQG+IPn
         Pa/u34nwjb6QXuK430ZrjfX4JpzTNMgCTtJwid/AufRbz7zRj3M8zdKz1fhTWOF6/J
         bcbQ+SbPxi2ZQRUqWjbi2334fPbq8qmX+l54/bpUT9FIAwHkjkJlU40HyWdTz7jBfp
         3aVVyVs+3Pul12KzgdvuLqMPKlRJOB582lBt5f0d7EATWTpwoxkS0kFvFvGdwyBVkP
         cUFVWPEXGTXFA==
Received: from paltsev-e7480.internal.synopsys.com (paltsev-e7480.internal.synopsys.com [10.121.3.38])
        by mailhost.synopsys.com (Postfix) with ESMTP id 1D5645928;
        Fri, 28 Sep 2018 06:15:34 -0700 (PDT)
From:   Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To:     linux-snps-arc@lists.infradead.org, linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Vineet Gupta <vineet.gupta1@synopsys.com>,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Subject: [PATCH v4 1/2] GPIO: add single-register GPIO via CREG driver
Date:   Fri, 28 Sep 2018 16:15:30 +0300
Message-Id: <20180928131531.4598-1-Eugeniy.Paltsev@synopsys.com>
X-Mailer: git-send-email 2.14.4
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
Changes v3->v4:
 * Cleanup 'include' section.
 * Get rid of 'of_mm_gpio_chip' using.
 * Get rid of custom 'creg_gpio_xlate' function.
 * Get rid of dummy 'creg_gpio_get_direction' function.
 * Small fixies.

Changes v2->v3:
 * Move parameters into a lookup table instead of device tree.
 * Use the ngpios attribute for instead of snps,ngpios.

 MAINTAINERS                   |   6 ++
 drivers/gpio/Kconfig          |  10 +++
 drivers/gpio/Makefile         |   1 +
 drivers/gpio/gpio-creg-snps.c | 191 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 208 insertions(+)
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
index 000000000000..8cbc94d0d424
--- /dev/null
+++ b/drivers/gpio/gpio-creg-snps.c
@@ -0,0 +1,191 @@
+// SPDX-License-Identifier: GPL-2.0+
+//
+// Synopsys CREG (Control REGisters) GPIO driver
+//
+// Copyright (C) 2018 Synopsys
+// Author: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
+
+#include <linux/gpio/driver.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
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
+	struct gpio_chip gc;
+	void __iomem *regs;
+	spinlock_t lock;
+	const struct creg_layout *layout;
+};
+
+static void creg_gpio_set(struct gpio_chip *gc, unsigned int offset, int val)
+{
+	struct creg_gpio *hcg = gpiochip_get_data(gc);
+	const struct creg_layout *layout = hcg->layout;
+	u32 reg, reg_shift, value;
+	unsigned long flags;
+	int i;
+
+	value = val ? hcg->layout->on[offset] : hcg->layout->off[offset];
+
+	reg_shift = layout->shift[offset];
+	for (i = 0; i < offset; i++)
+		reg_shift += layout->bit_per_gpio[i] + layout->shift[i];
+
+	spin_lock_irqsave(&hcg->lock, flags);
+	reg = readl(hcg->regs);
+	reg &= ~(GENMASK(layout->bit_per_gpio[i] - 1, 0) << reg_shift);
+	reg |=  (value << reg_shift);
+	writel(reg, hcg->regs);
+	spin_unlock_irqrestore(&hcg->lock, flags);
+}
+
+static int creg_gpio_dir_out(struct gpio_chip *gc, unsigned int offset, int val)
+{
+	creg_gpio_set(gc, offset, val);
+
+	return 0;
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
+	/* Check that on valiue fits it's placeholder */
+	if (GENMASK(31, layout->bit_per_gpio[i]) & layout->on[i])
+		return -EINVAL;
+
+	/* Check that off valiue fits it's placeholder */
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
+	/* Check that we fit in 32 bit register */
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
+	struct resource *mem;
+	u32 ngpios;
+	int ret;
+
+	hcg = devm_kzalloc(dev, sizeof(struct creg_gpio), GFP_KERNEL);
+	if (!hcg)
+		return -ENOMEM;
+
+	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	hcg->regs = devm_ioremap_resource(dev, mem);
+	if (IS_ERR(hcg->regs))
+		return PTR_ERR(hcg->regs);
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
+	hcg->gc.label = dev_name(dev);
+	hcg->gc.base = -1;
+	hcg->gc.ngpio = ngpios;
+	hcg->gc.set = creg_gpio_set;
+	hcg->gc.direction_output = creg_gpio_dir_out;
+	hcg->gc.of_node = dev->of_node;
+
+	ret = devm_gpiochip_add_data(dev, &hcg->gc, hcg);
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

