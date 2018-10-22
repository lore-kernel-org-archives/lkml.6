Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA8E0C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 13:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A97F420853
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 13:35:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A97F420853
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728947AbeJVVxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 17:53:38 -0400
Received: from mail.bootlin.com ([62.4.15.54]:51046 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728788AbeJVVxG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 17:53:06 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id A250820DFA; Mon, 22 Oct 2018 15:34:26 +0200 (CEST)
Received: from localhost.localdomain (aaubervilliers-681-1-25-52.w90-88.abo.wanadoo.fr [90.88.145.52])
        by mail.bootlin.com (Postfix) with ESMTPSA id 61B992090A;
        Mon, 22 Oct 2018 15:34:10 +0200 (CEST)
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Przemyslaw Sroka <psroka@cadence.com>,
        Arkadiusz Golec <agolec@cadence.com>,
        Alan Douglas <adouglas@cadence.com>,
        Bartosz Folta <bfolta@cadence.com>,
        Damian Kos <dkos@cadence.com>,
        Alicja Jurasik-Urbaniak <alicja@cadence.com>,
        Cyprian Wronka <cwronka@cadence.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vitor Soares <Vitor.Soares@synopsys.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>,
        linux-gpio@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>,
        Przemyslaw Gaj <pgaj@cadence.com>,
        Peter Rosin <peda@axentia.se>,
        Mike Shettel <mshettel@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Joe Perches <joe@perches.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH v9 8/9] gpio: Add a driver for Cadence I3C GPIO expander
Date:   Mon, 22 Oct 2018 15:34:03 +0200
Message-Id: <20181022133404.2061-9-boris.brezillon@bootlin.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181022133404.2061-1-boris.brezillon@bootlin.com>
References: <20181022133404.2061-1-boris.brezillon@bootlin.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a driver for Cadence I3C GPIO expander.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
Changes in v9:
- None

Changes in v8:
- None

Changes in v7:
- None

Changes in v6:
- Use kmalloc_array() instead of kmalloc(N * sizeof(X))
- Add Linus' ack

Changes in v5:
- Use the !! operator to return 0 or 1 in cdns_i3c_gpio_get_direction()
- Use a scratch buffer to make sure the buffers passed to
  i3c_device_do_priv_xfers() are DMA-able
- Fix errors reported by checkpatch

Changes in v4:
- none

Changes in v3:
- new
---
 drivers/gpio/Kconfig         |  11 +
 drivers/gpio/Makefile        |   1 +
 drivers/gpio/gpio-cdns-i3c.c | 411 +++++++++++++++++++++++++++++++++++
 3 files changed, 423 insertions(+)
 create mode 100644 drivers/gpio/gpio-cdns-i3c.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 4f52c3a8ec99..a941601bf448 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -908,6 +908,17 @@ config GPIO_TS4900
 
 endmenu
 
+menu "I3C GPIO expanders"
+	depends on I3C
+
+config GPIO_CDNS_I3C
+	tristate "Cadence I3C GPIO expander"
+	select GPIOLIB_IRQCHIP
+	help
+	  Say yes here to enabled the driver for Cadence I3C GPIO expander.
+
+endmenu
+
 menu "MFD GPIO expanders"
 
 config GPIO_ADP5520
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index c256aff66a65..12fa0ace618e 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -37,6 +37,7 @@ obj-$(CONFIG_GPIO_BCM_KONA)	+= gpio-bcm-kona.o
 obj-$(CONFIG_GPIO_BD9571MWV)	+= gpio-bd9571mwv.o
 obj-$(CONFIG_GPIO_BRCMSTB)	+= gpio-brcmstb.o
 obj-$(CONFIG_GPIO_BT8XX)	+= gpio-bt8xx.o
+obj-$(CONFIG_GPIO_CDNS_I3C)	+= gpio-cdns-i3c.o
 obj-$(CONFIG_GPIO_CLPS711X)	+= gpio-clps711x.o
 obj-$(CONFIG_GPIO_CS5535)	+= gpio-cs5535.o
 obj-$(CONFIG_GPIO_CRYSTAL_COVE)	+= gpio-crystalcove.o
diff --git a/drivers/gpio/gpio-cdns-i3c.c b/drivers/gpio/gpio-cdns-i3c.c
new file mode 100644
index 000000000000..37c9d57a2fbb
--- /dev/null
+++ b/drivers/gpio/gpio-cdns-i3c.c
@@ -0,0 +1,411 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018 Cadence Design Systems Inc.
+ *
+ * Author: Boris Brezillon <boris.brezillon@bootlin.com>
+ */
+
+#include <linux/gpio/driver.h>
+#include <linux/i3c/device.h>
+#include <linux/module.h>
+
+#define OVR		0x0
+#define IVR		0x1
+#define DIR_MODE	0x2
+#define IMR		0x3
+#define ISR		0x4
+#define ITR(x)		(0x5 + (x))
+
+struct cdns_i3c_gpio {
+	struct gpio_chip gpioc;
+	struct irq_chip irqc;
+	struct i3c_device *i3cdev;
+	struct mutex irq_lock;
+	u8 dir;
+	u8 ovr;
+	u8 imr;
+	u8 itr[3];
+};
+
+static struct cdns_i3c_gpio *gpioc_to_cdns_gpioc(struct gpio_chip *gpioc)
+{
+	return container_of(gpioc, struct cdns_i3c_gpio, gpioc);
+}
+
+static int cdns_i3c_gpio_read_reg(struct cdns_i3c_gpio *gpioc, u8 reg,
+				  u8 *val)
+{
+	struct i3c_priv_xfer xfers[2] = { };
+	u8 *scratchbuf;
+	int ret;
+
+	/*
+	 * i3c_device_do_priv_xfers() mandates that buffers passed in xfers be
+	 * DMA-able. This prevents us from using reg and val directly since
+	 * reg is on the stack, and val might be too.
+	 * Allocate a temporary buffer with kmalloc() to solve the problem.
+	 */
+	scratchbuf = kmalloc(sizeof(*scratchbuf), GFP_KERNEL);
+	if (!scratchbuf)
+		return -ENOMEM;
+
+	scratchbuf[0] = reg;
+	xfers[0].data.out = scratchbuf;
+	xfers[0].len = 1;
+	xfers[1].data.in = scratchbuf;
+	xfers[1].len = 1;
+	xfers[1].rnw = true;
+
+	ret = i3c_device_do_priv_xfers(gpioc->i3cdev, xfers,
+				       ARRAY_SIZE(xfers));
+	if (!ret)
+		*val = *scratchbuf;
+
+	kfree(scratchbuf);
+
+	return ret;
+}
+
+static int cdns_i3c_gpio_write_reg(struct cdns_i3c_gpio *gpioc, u8 reg,
+				   u8 val)
+{
+	struct i3c_priv_xfer xfers[2] = { };
+	u8 *scratchbuf;
+	int ret;
+
+	/*
+	 * i3c_device_do_priv_xfers() mandates that buffers passed in xfers be
+	 * DMA-able. This prevents us from using reg and val directly since
+	 * reg is on the stack, and val might be too.
+	 * Allocate a temporary buffer with kmalloc() to solve the problem.
+	 */
+	scratchbuf = kmalloc_array(2, sizeof(*scratchbuf), GFP_KERNEL);
+	if (!scratchbuf)
+		return -ENOMEM;
+
+	scratchbuf[0] = reg;
+	scratchbuf[1] = val;
+	xfers[0].data.out = scratchbuf;
+	xfers[0].len = 1;
+	xfers[1].data.out = scratchbuf + 1;
+	xfers[1].len = 1;
+
+	ret = i3c_device_do_priv_xfers(gpioc->i3cdev, xfers,
+				       ARRAY_SIZE(xfers));
+
+	kfree(scratchbuf);
+
+	return ret;
+}
+
+static int cdns_i3c_gpio_get_direction(struct gpio_chip *g,
+				       unsigned int offset)
+{
+	struct cdns_i3c_gpio *gpioc = gpioc_to_cdns_gpioc(g);
+
+	return !!(gpioc->dir & BIT(offset));
+}
+
+static void cdns_i3c_gpio_set_multiple(struct gpio_chip *g,
+				       unsigned long *mask,
+				       unsigned long *bits)
+{
+	struct cdns_i3c_gpio *gpioc = gpioc_to_cdns_gpioc(g);
+	u8 newovr;
+	int ret;
+
+	newovr = (gpioc->ovr & ~(*mask)) | (*bits & *mask);
+	if (newovr == gpioc->ovr)
+		return;
+
+	ret = cdns_i3c_gpio_write_reg(gpioc, OVR, newovr);
+	if (!ret)
+		gpioc->ovr = newovr;
+}
+
+static void cdns_i3c_gpio_set(struct gpio_chip *g, unsigned int offset,
+			      int value)
+{
+	unsigned long mask = BIT(offset), bits = value ? BIT(offset) : 0;
+
+	cdns_i3c_gpio_set_multiple(g, &mask, &bits);
+}
+
+static int cdns_i3c_gpio_set_dir(struct cdns_i3c_gpio *gpioc, unsigned int pin,
+				 bool in)
+{
+	u8 newdir;
+	int ret;
+
+	newdir = gpioc->dir;
+	if (in)
+		newdir |= BIT(pin);
+	else
+		newdir &= ~BIT(pin);
+
+	if (newdir == gpioc->dir)
+		return 0;
+
+	gpioc->dir = newdir;
+	ret = cdns_i3c_gpio_write_reg(gpioc, DIR_MODE, newdir);
+	if (!ret)
+		gpioc->dir = newdir;
+
+	return ret;
+}
+
+static int cdns_i3c_gpio_dir_input(struct gpio_chip *g, unsigned int offset)
+{
+	struct cdns_i3c_gpio *gpioc = gpioc_to_cdns_gpioc(g);
+
+	return cdns_i3c_gpio_set_dir(gpioc, offset, true);
+}
+
+static int cdns_i3c_gpio_dir_output(struct gpio_chip *g, unsigned int offset,
+				    int val)
+{
+	struct cdns_i3c_gpio *gpioc = gpioc_to_cdns_gpioc(g);
+
+	cdns_i3c_gpio_set(g, offset, val);
+
+	return cdns_i3c_gpio_set_dir(gpioc, offset, true);
+}
+
+static int cdns_i3c_gpio_get_multiple(struct gpio_chip *g,
+				      unsigned long *mask,
+				      unsigned long *bits)
+{
+	struct cdns_i3c_gpio *gpioc = gpioc_to_cdns_gpioc(g);
+	int ret;
+	u8 ivr;
+
+	ret = cdns_i3c_gpio_read_reg(gpioc, IVR, &ivr);
+	if (ret)
+		return ret;
+
+	*bits = ivr & *mask & gpioc->dir;
+	*bits |= gpioc->ovr & *mask & ~gpioc->dir;
+
+	return 0;
+}
+
+static int cdns_i3c_gpio_get(struct gpio_chip *g, unsigned int offset)
+{
+	unsigned long mask = BIT(offset), bits = 0;
+	int ret;
+
+	ret = cdns_i3c_gpio_get_multiple(g, &mask, &bits);
+	if (ret)
+		return ret;
+
+	return mask & bits;
+}
+
+static void cdns_i3c_gpio_ibi_handler(struct i3c_device *i3cdev,
+				      const struct i3c_ibi_payload *payload)
+{
+	struct cdns_i3c_gpio *gpioc = i3cdev_get_drvdata(i3cdev);
+	u8 isr = 0;
+	int i;
+
+	cdns_i3c_gpio_read_reg(gpioc, ISR, &isr);
+	for (i = 0; i < 8; i++) {
+		unsigned int irq;
+
+		if (!(BIT(i) & isr & gpioc->imr))
+			continue;
+
+		irq = irq_find_mapping(gpioc->gpioc.irq.domain, i);
+		handle_nested_irq(irq);
+	}
+}
+
+static void cdns_i3c_gpio_irq_lock(struct irq_data *data)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(data);
+	struct cdns_i3c_gpio *gpioc = gpiochip_get_data(gc);
+
+	mutex_lock(&gpioc->irq_lock);
+}
+
+static void cdns_i3c_gpio_irq_sync_unlock(struct irq_data *data)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(data);
+	struct cdns_i3c_gpio *gpioc = gpiochip_get_data(gc);
+	int i;
+
+	cdns_i3c_gpio_write_reg(gpioc, IMR, gpioc->imr);
+	for (i = 0; i < 3; i++)
+		cdns_i3c_gpio_write_reg(gpioc, ITR(i), gpioc->itr[i]);
+
+	mutex_unlock(&gpioc->irq_lock);
+}
+
+static void cdns_i3c_gpio_irq_unmask(struct irq_data *data)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(data);
+	struct cdns_i3c_gpio *gpioc = gpiochip_get_data(gc);
+
+	gpioc->imr |= BIT(data->hwirq);
+}
+
+static void cdns_i3c_gpio_irq_mask(struct irq_data *data)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(data);
+	struct cdns_i3c_gpio *gpioc = gpiochip_get_data(gc);
+
+	gpioc->imr &= ~BIT(data->hwirq);
+}
+
+static int cdns_i3c_gpio_irq_set_type(struct irq_data *data, unsigned int type)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(data);
+	struct cdns_i3c_gpio *gpioc = gpiochip_get_data(gc);
+
+	switch (type) {
+	case IRQ_TYPE_LEVEL_HIGH:
+		gpioc->itr[0] |= BIT(data->hwirq);
+		gpioc->itr[1] |= BIT(data->hwirq);
+		break;
+
+	case IRQ_TYPE_LEVEL_LOW:
+		gpioc->itr[0] |= BIT(data->hwirq);
+		gpioc->itr[1] &= ~BIT(data->hwirq);
+		break;
+
+	case IRQ_TYPE_EDGE_BOTH:
+		gpioc->itr[0] &= ~BIT(data->hwirq);
+		gpioc->itr[2] |= BIT(data->hwirq);
+		break;
+
+	case IRQ_TYPE_EDGE_RISING:
+		gpioc->itr[0] &= ~BIT(data->hwirq);
+		gpioc->itr[1] |= BIT(data->hwirq);
+		gpioc->itr[2] &= ~BIT(data->hwirq);
+		break;
+
+	case IRQ_TYPE_EDGE_FALLING:
+		gpioc->itr[0] &= ~BIT(data->hwirq);
+		gpioc->itr[1] &= ~BIT(data->hwirq);
+		gpioc->itr[2] &= ~BIT(data->hwirq);
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int cdns_i3c_gpio_probe(struct i3c_device *i3cdev)
+{
+	struct cdns_i3c_gpio *gpioc;
+	struct device *parent = i3cdev_to_dev(i3cdev);
+	struct i3c_ibi_setup ibisetup = {
+		.max_payload_len = 2,
+		.num_slots = 1,
+		.handler = cdns_i3c_gpio_ibi_handler,
+	};
+	int ret;
+
+	gpioc = devm_kzalloc(parent, sizeof(*gpioc), GFP_KERNEL);
+	if (!gpioc)
+		return -ENOMEM;
+
+	gpioc->i3cdev = i3cdev;
+	i3cdev_set_drvdata(i3cdev, gpioc);
+
+	/* Mask all interrupts. */
+	ret = cdns_i3c_gpio_write_reg(gpioc, IMR, 0);
+	if (ret)
+		return ret;
+
+	/*
+	 * Clear the ISR after reading it, not when the IBI is is Acked by the
+	 * I3C master. This way we make sure we don't lose events.
+	 */
+	ret = cdns_i3c_gpio_write_reg(gpioc, ITR(3), 0xff);
+	if (ret)
+		return ret;
+
+	ret = cdns_i3c_gpio_read_reg(gpioc, DIR_MODE, &gpioc->dir);
+	if (ret)
+		return ret;
+
+	ret = cdns_i3c_gpio_read_reg(gpioc, OVR, &gpioc->ovr);
+	if (ret)
+		return ret;
+
+	ret = i3c_device_request_ibi(i3cdev, &ibisetup);
+	if (ret)
+		return ret;
+
+	gpioc->gpioc.label = dev_name(parent);
+	gpioc->gpioc.owner = THIS_MODULE;
+	gpioc->gpioc.parent = parent;
+	gpioc->gpioc.base = -1;
+	gpioc->gpioc.ngpio = 8;
+	gpioc->gpioc.can_sleep = true;
+	gpioc->gpioc.get_direction = cdns_i3c_gpio_get_direction;
+	gpioc->gpioc.direction_input = cdns_i3c_gpio_dir_input;
+	gpioc->gpioc.direction_output = cdns_i3c_gpio_dir_output;
+	gpioc->gpioc.get = cdns_i3c_gpio_get;
+	gpioc->gpioc.get_multiple = cdns_i3c_gpio_get_multiple;
+	gpioc->gpioc.set = cdns_i3c_gpio_set;
+	gpioc->gpioc.set_multiple = cdns_i3c_gpio_set_multiple;
+
+	ret = devm_gpiochip_add_data(parent, &gpioc->gpioc, gpioc);
+	if (ret)
+		return ret;
+
+	gpioc->irqc.name = dev_name(parent);
+	gpioc->irqc.parent_device = parent;
+	gpioc->irqc.irq_unmask = cdns_i3c_gpio_irq_unmask;
+	gpioc->irqc.irq_mask = cdns_i3c_gpio_irq_mask;
+	gpioc->irqc.irq_bus_lock = cdns_i3c_gpio_irq_lock;
+	gpioc->irqc.irq_bus_sync_unlock = cdns_i3c_gpio_irq_sync_unlock;
+	gpioc->irqc.irq_set_type = cdns_i3c_gpio_irq_set_type;
+	gpioc->irqc.flags = IRQCHIP_SET_TYPE_MASKED | IRQCHIP_MASK_ON_SUSPEND;
+
+	ret = gpiochip_irqchip_add_nested(&gpioc->gpioc, &gpioc->irqc, 0,
+					  handle_simple_irq, IRQ_TYPE_NONE);
+	if (ret)
+		goto err_free_ibi;
+
+	ret = i3c_device_enable_ibi(i3cdev);
+	if (ret)
+		goto err_free_ibi;
+
+	return 0;
+
+err_free_ibi:
+	i3c_device_free_ibi(i3cdev);
+
+	return ret;
+}
+
+static int cdns_i3c_gpio_remove(struct i3c_device *i3cdev)
+{
+	i3c_device_disable_ibi(i3cdev);
+	i3c_device_free_ibi(i3cdev);
+
+	return 0;
+}
+
+static const struct i3c_device_id cdns_i3c_gpio_ids[] = {
+	I3C_DEVICE(0x1c9, 0x0, NULL),
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(i3c, cdns_i3c_gpio_ids);
+
+static struct i3c_driver cdns_i3c_gpio = {
+	.driver.name = "cdns-i3c-gpio",
+	.id_table = cdns_i3c_gpio_ids,
+	.probe = cdns_i3c_gpio_probe,
+	.remove = cdns_i3c_gpio_remove,
+};
+module_i3c_driver(cdns_i3c_gpio);
+
+MODULE_AUTHOR("Boris Brezillon <boris.brezillon@bootlin.com>");
+MODULE_DESCRIPTION("Driver for Cadence I3C GPIO expander");
+MODULE_LICENSE("GPL v2");
-- 
2.17.1

