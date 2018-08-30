Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD5CC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:44:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 339D520834
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 14:44:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nic.cz header.i=@nic.cz header.b="xaPdb6DK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 339D520834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nic.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729720AbeH3SrB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 14:47:01 -0400
Received: from mail.nic.cz ([217.31.204.67]:39894 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729425AbeH3SrA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 14:47:00 -0400
Received: from dellmb.labs.office.nic.cz (unknown [IPv6:2001:1488:fffe:6:cac7:3539:7f1f:463])
        by mail.nic.cz (Postfix) with ESMTP id 5DF33600EA;
        Thu, 30 Aug 2018 16:44:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1535640269; bh=wx88YtoiDGYVuZxRRalY4AaNgxymEIbZFzpjGYG29m4=;
        h=From:To:Date;
        b=xaPdb6DKCg3yN9wbXD9ikXGcl2PpP8l8UJG0rLN+X9rfS7yzgLYm/3lG/9q9dezhn
         rd5HFUzIw4yPnp+NfepVDSP9PzDVcPzAmkSz1AehjwC0CaJnklEkVvYYe2rcxJa60l
         +68DbQblfUOMCtvqdF1lWlA1MJhrkx3AENbLuwwE=
From:   =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
Subject: [PATCH mfd+gpio 2/2] drivers: gpio: Add support for GPIOs over Moxtet bus
Date:   Thu, 30 Aug 2018 16:41:51 +0200
Message-Id: <20180830144151.13417-2-marek.behun@nic.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180830144151.13417-1-marek.behun@nic.cz>
References: <20180830144151.13417-1-marek.behun@nic.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.99.2 at mail
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for interpreting the input and output bits of one
device on Moxtet bus as GPIOs.
This is needed for example by the SFP cage module of Turris Mox.

Signed-off-by: Marek Behún <marek.behun@nic.cz>
---
 .../devicetree/bindings/gpio/gpio-moxtet.txt       |  31 +++
 MAINTAINERS                                        |   1 +
 drivers/gpio/Kconfig                               |   9 +
 drivers/gpio/Makefile                              |   1 +
 drivers/gpio/gpio-moxtet.c                         | 209 +++++++++++++++++++++
 5 files changed, 251 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-moxtet.txt
 create mode 100644 drivers/gpio/gpio-moxtet.c

diff --git a/Documentation/devicetree/bindings/gpio/gpio-moxtet.txt b/Documentation/devicetree/bindings/gpio/gpio-moxtet.txt
new file mode 100644
index 000000000000..64a9a1bfd4cf
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/gpio-moxtet.txt
@@ -0,0 +1,31 @@
+Turris Mox Moxtet GPIO expander
+
+Required properties:
+ - compatible		: Should be "cznic,moxtet-gpio".
+ - gpio-controller	: Marks the device node as a GPIO controller.
+ - #gpio-cells		: Should be two. For consumer use see gpio.txt.
+ - moxtet,input-mask	: Bitmask. Those bits which correspond to input GPIOs
+			  when read from Moxtet bus should be set here.
+			  For example if bit 0 and bit 3 are input GPIO bits,
+			  this should be set to 0x9.
+			  Since there are only 4 input bits, 0xf is max value.
+ - moxtet,output-mask	: Bitmask. Those bits which correspond to output GPIOs
+			  when written to Moxtet bus should be set here.
+			  For example if bit 1 and bit 6 are output GPIO bits,
+			  this should be set to 0x41.
+			  Since there are at most 8 output bits, 0xff is max
+			  value.
+Other properties are required for a moxtet bus device, please refer to
+Documentation/devicetree/bindings/mfd/moxtet.txt.
+
+Example:
+
+	moxtet_sfp: moxtet-sfp@0 {
+		compatible = "cznic,moxtet-gpio";
+		gpio-controller;
+		#gpio-cells;
+		reg = <0>;
+		moxtet,id = <1>;
+		moxtet,input-mask = <0x7>;
+		moxtet,output-mask = <0x3>;
+	}
diff --git a/MAINTAINERS b/MAINTAINERS
index 84e60ee83951..0ca4e5302054 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1417,6 +1417,7 @@ M:	Marek Behun <marek.behun@nic.cz>
 W:	http://mox.turris.cz
 S:	Maintained
 F:	include/mfd/moxtet.h
+F:	drivers/gpio/gpio-moxtet.c
 F:	drivers/mfd/moxtet.c
 
 ARM/EBSA110 MACHINE SUPPORT
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index b8cbf5081389..2c0202aa91d0 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1055,6 +1055,15 @@ config GPIO_MAX77620
 	  driver also provides interrupt support for each of the gpios.
 	  Say yes here to enable the max77620 to be used as gpio controller.
 
+config GPIO_MOXTET
+	tristate "Turris Mox Moxtet bus GPIO expander"
+	depends on MFD_MOXTET
+	help
+	  Say yes here if you are building for the Turris Mox router.
+	  This is the driver needed for configuring the GPIOs via the Moxtet
+	  bus. For example the Mox module with SFP cage needs this driver
+	  so that phylink can use corresponding GPIOs.
+
 config GPIO_MSIC
 	bool "Intel MSIC mixed signal gpio support"
 	depends on (X86 || COMPILE_TEST) && MFD_INTEL_MSIC
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 80d58c2de730..e119b3b87f1f 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -85,6 +85,7 @@ obj-$(CONFIG_GPIO_MC9S08DZ60)	+= gpio-mc9s08dz60.o
 obj-$(CONFIG_GPIO_ML_IOH)	+= gpio-ml-ioh.o
 obj-$(CONFIG_GPIO_MM_LANTIQ)	+= gpio-mm-lantiq.o
 obj-$(CONFIG_GPIO_MOCKUP)      += gpio-mockup.o
+obj-$(CONFIG_GPIO_MOXTET)	+= gpio-moxtet.o
 obj-$(CONFIG_GPIO_MPC5200)	+= gpio-mpc5200.o
 obj-$(CONFIG_GPIO_MPC8XXX)	+= gpio-mpc8xxx.o
 obj-$(CONFIG_GPIO_MSIC)		+= gpio-msic.o
diff --git a/drivers/gpio/gpio-moxtet.c b/drivers/gpio/gpio-moxtet.c
new file mode 100644
index 000000000000..d0b50581118d
--- /dev/null
+++ b/drivers/gpio/gpio-moxtet.c
@@ -0,0 +1,209 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  Turris Mox Moxtet GPIO expander
+ *
+ *  Copyright (C) 2018 Marek Behun <marek.behun@nic.cz>
+ */
+
+#include <linux/gpio/consumer.h>
+#include <linux/gpio.h>
+#include <linux/mfd/moxtet.h>
+#include <linux/module.h>
+#include <linux/of_gpio.h>
+
+struct moxtet_gpio_chip {
+	struct device		*dev;
+	struct gpio_chip	gpio_chip;
+	u8			in_mask;
+	u8			out_mask;
+};
+
+static int moxtet_gpio_dir_mask(struct gpio_chip *gc, unsigned int offset,
+				int *dir, u8 *mask)
+{
+	struct moxtet_gpio_chip *chip = gpiochip_get_data(gc);
+	int i;
+
+	*dir = 0;
+	for (i = 0; i < 4; ++i) {
+		*mask = 1 << i;
+		if (*mask & chip->in_mask) {
+			if (offset == 0)
+				return 0;
+			--offset;
+		}
+	}
+
+	*dir = 1;
+	for (i = 0; i < 8; ++i) {
+		*mask = 1 << i;
+		if (*mask & chip->out_mask) {
+			if (offset == 0)
+				return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+
+static int moxtet_gpio_get_value(struct gpio_chip *gc, unsigned int offset)
+{
+	struct moxtet_gpio_chip *chip = gpiochip_get_data(gc);
+	int ret, dir;
+	u8 mask;
+
+	if (moxtet_gpio_dir_mask(gc, offset, &dir, &mask) < 0)
+		return -EINVAL;
+
+	if (dir)
+		ret = moxtet_device_written(chip->dev);
+	else
+		ret = moxtet_device_read(chip->dev);
+
+	if (ret < 0)
+		return ret;
+
+	return (ret & mask) ? 1 : 0;
+}
+
+static void moxtet_gpio_set_value(struct gpio_chip *gc, unsigned int offset,
+				  int val)
+{
+	struct moxtet_gpio_chip *chip = gpiochip_get_data(gc);
+	int state, dir;
+	u8 mask;
+
+	if (moxtet_gpio_dir_mask(gc, offset, &dir, &mask) < 0)
+		return;
+
+	/* cannot change input GPIO */
+	if (!dir)
+		return;
+
+	state = moxtet_device_written(chip->dev);
+	if (state < 0)
+		return;
+
+	if (val)
+		state |= mask;
+	else
+		state &= ~mask;
+
+	moxtet_device_write(chip->dev, state);
+}
+
+static int moxtet_gpio_get_direction(struct gpio_chip *gc, unsigned int offset)
+{
+	int dir;
+	u8 mask;
+
+	if (moxtet_gpio_dir_mask(gc, offset, &dir, &mask) < 0)
+		return -EINVAL;
+
+	return dir;
+}
+
+static int moxtet_gpio_direction_input(struct gpio_chip *gc,
+				       unsigned int offset)
+{
+	int dir;
+	u8 mask;
+
+	if (moxtet_gpio_dir_mask(gc, offset, &dir, &mask) < 0)
+		return -EINVAL;
+
+	if (dir)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int moxtet_gpio_direction_output(struct gpio_chip *gc,
+					unsigned int offset, int val)
+{
+	int dir;
+	u8 mask;
+
+	if (moxtet_gpio_dir_mask(gc, offset, &dir, &mask) < 0)
+		return -EINVAL;
+
+	if (!dir)
+		return -EINVAL;
+
+	moxtet_gpio_set_value(gc, offset, val);
+	return 0;
+}
+
+static int moxtet_gpio_probe(struct device *dev)
+{
+	struct moxtet_gpio_chip *chip;
+	struct device_node *nc = dev->of_node;
+	int ret;
+	u32 val;
+
+	chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
+	if (!chip)
+		return -ENOMEM;
+
+	chip->dev = dev;
+	chip->gpio_chip.parent = dev;
+
+	ret = of_property_read_u32(nc, "moxtet,input-mask", &val);
+	if (ret < 0 || val > 0xf) {
+		dev_err(dev,
+			"%pOF has no valid 'moxtet,input-mask' property\n", nc);
+		return ret < 0 ? ret : -ERANGE;
+	}
+	chip->in_mask = val;
+
+	ret = of_property_read_u32(nc, "moxtet,output-mask", &val);
+	if (ret < 0 || val > 0xff) {
+		dev_err(dev,
+			"%pOF has no valid 'moxtet,output-mask' property\n",
+			nc);
+		return ret < 0 ? ret : -ERANGE;
+	}
+	chip->out_mask = val;
+
+	if (!chip->in_mask && !chip->out_mask) {
+		dev_err(dev, "%pOF has zero GPIOs defined\n", nc);
+		return -EINVAL;
+	}
+
+	dev_set_drvdata(dev, chip);
+
+	chip->gpio_chip.label = dev_name(dev);
+	chip->gpio_chip.get_direction = moxtet_gpio_get_direction;
+	chip->gpio_chip.direction_input = moxtet_gpio_direction_input;
+	chip->gpio_chip.direction_output = moxtet_gpio_direction_output;
+	chip->gpio_chip.get = moxtet_gpio_get_value;
+	chip->gpio_chip.set = moxtet_gpio_set_value;
+	chip->gpio_chip.base = -1;
+
+	chip->gpio_chip.ngpio = hweight8(chip->in_mask) +
+				hweight8(chip->out_mask);
+
+	chip->gpio_chip.can_sleep = true;
+	chip->gpio_chip.owner = THIS_MODULE;
+
+	return devm_gpiochip_add_data(dev, &chip->gpio_chip, chip);
+}
+
+static const struct of_device_id moxtet_gpio_dt_ids[] = {
+	{ .compatible = "cznic,moxtet-gpio" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, moxtet_gpio_dt_ids);
+
+static struct moxtet_driver moxtet_gpio_driver = {
+	.driver = {
+		.name		= "moxtet-gpio",
+		.of_match_table	= moxtet_gpio_dt_ids,
+		.probe		= moxtet_gpio_probe,
+	},
+};
+module_moxtet_driver(moxtet_gpio_driver);
+
+MODULE_AUTHOR("Marek Behun <marek.behun@nic.cz>");
+MODULE_DESCRIPTION("Turris Mox Moxtet GPIO expander");
+MODULE_LICENSE("GPL v2");
-- 
2.16.4

