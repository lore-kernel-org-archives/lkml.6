Return-Path: <neil@brown.name>
X-Google-Smtp-Source: AG47ELs3gqF5p14UZfSoHepnFjBmmWXVWvsRSFYMQmbUChldY/R7UDe0dD1d3gyi71x19wm4DtxI
ARC-Seal: i=1; a=rsa-sha256; t=1521059000; cv=none;
        d=google.com; s=arc-20160816;
        b=RcMu3biLW3yDW3Kx2bcap/FzFE3LFpO78fQMEAHUmDiC7l/l4iM3LuE+h8bNIZAKx9
         Puplt7lkYO1pCpB7QpD8rk0oe4ogpf7/94UyU5QOm9EBQK8wyRsq5SiFQFcThPCkDNWS
         cHf6oy/NnJyc3A5iNY3OpPWZF9BGfVwtobAOujVIBo1GfwWgLWU2gL/SCHSYTz3CP0Yf
         7yfTrjIRtj1BGtSVQLitqZpCB7sEZbrp9xMnqGrwApJFl9mFoeGOSguOGgOsNZGkeFV3
         NNKT1oTOh8c+3YNa+nsQ9RTTiqOUkcz6xwCITzgfJrDH+tieV3c5pOkEbwM12+P+xXpz
         EunQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:cc:subject:date:to:from
         :arc-authentication-results;
        bh=ClDB1mXtF7A58/rF1uVofthSXNPrRdqMKNDgYKXC1iw=;
        b=pKC4zrd1JEGmroyC+4Av9kG9W+B2ydwW4mROgIZ6KGC0hnIWH7AL72MCxz99jAavxm
         8R4RfpyZbRiLhU+ykAnHfkKUQJ0gePrHLlE9MHMg0mu82pxsZ6P7CHSwluM9ShMH03eF
         IisshwDlIn0AS7DiNrMPAD3EyIFVEWYjxH3sjEfZs8GxI7UgjqrrpfuLVt5x0pvjzH6J
         CsOcAgQQDcwzEZC78uya1xDm8s3cXVBR9ZVSwQCDuh2eBqfNrK+3/fE8vYBpT4qkjvdS
         DkiKEOcNQYFB38C0kVIDwzqIgs/yALcARb3sX3tOjACIz/gHEC78Cb1M1OY7StXdVgCO
         MEDg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 195.135.220.15 is neither permitted nor denied by best guess record for domain of neil@brown.name) smtp.mailfrom=neil@brown.name
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 195.135.220.15 is neither permitted nor denied by best guess record for domain of neil@brown.name) smtp.mailfrom=neil@brown.name
From: NeilBrown <neil@brown.name>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Thu, 15 Mar 2018 07:22:35 +1100
Subject: [PATCH 03/13] staging: mt7621-gpio: ralink: add mt7621 gpio
 controller
Cc: devel@driverdev.osuosl.org, lkml <linux-kernel@vger.kernel.org>,
 John Crispin <blogic@openwrt.org>
Message-ID: <152105895531.22262.9532375775617636739.stgit@noble>
In-Reply-To: <152105892255.22262.1902152685410223215.stgit@noble>
References: <152105892255.22262.1902152685410223215.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594945961885150899?=
X-GMAIL-MSGID: =?utf-8?q?1594945961885150899?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: John Crispin <blogic@openwrt.org>

Signed-off-by: John Crispin <blogic@openwrt.org>
Signed-off-by: NeilBrown <neil@brown.name>
---
 drivers/staging/Kconfig                   |    2 
 drivers/staging/Makefile                  |    1 
 drivers/staging/mt7621-gpio/Kconfig       |    6 
 drivers/staging/mt7621-gpio/Makefile      |    3 
 drivers/staging/mt7621-gpio/TODO          |    5 
 drivers/staging/mt7621-gpio/gpio-mt7621.c |  353 +++++++++++++++++++++++++++++
 6 files changed, 370 insertions(+)
 create mode 100644 drivers/staging/mt7621-gpio/Kconfig
 create mode 100644 drivers/staging/mt7621-gpio/Makefile
 create mode 100644 drivers/staging/mt7621-gpio/TODO
 create mode 100644 drivers/staging/mt7621-gpio/gpio-mt7621.c

diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
index cdd04c8b4445..7568e10399fa 100644
--- a/drivers/staging/Kconfig
+++ b/drivers/staging/Kconfig
@@ -124,4 +124,6 @@ source "drivers/staging/pi433/Kconfig"
 
 source "drivers/staging/mt7621-pinctrl/Kconfig"
 
+source "drivers/staging/mt7621-gpio/Kconfig"
+
 endif # STAGING
diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
index db90d85a80d3..609fdb218985 100644
--- a/drivers/staging/Makefile
+++ b/drivers/staging/Makefile
@@ -54,3 +54,4 @@ obj-$(CONFIG_DRM_VBOXVIDEO)	+= vboxvideo/
 obj-$(CONFIG_PI433)		+= pi433/
 obj-$(CONFIG_SOC_MT7621)	+= mt7621-pci/
 obj-$(CONFIG_SOC_MT7621)	+= mt7621-pinctrl/
+obj-$(CONFIG_SOC_MT7621)	+= mt7621-gpio/
diff --git a/drivers/staging/mt7621-gpio/Kconfig b/drivers/staging/mt7621-gpio/Kconfig
new file mode 100644
index 000000000000..c741ec3f4e50
--- /dev/null
+++ b/drivers/staging/mt7621-gpio/Kconfig
@@ -0,0 +1,6 @@
+config GPIO_MT7621
+	bool "Mediatek GPIO Support"
+	depends on SOC_MT7620 || SOC_MT7621
+	select ARCH_REQUIRE_GPIOLIB
+	help
+	  Say yes here to support the Mediatek SoC GPIO device
diff --git a/drivers/staging/mt7621-gpio/Makefile b/drivers/staging/mt7621-gpio/Makefile
new file mode 100644
index 000000000000..e269ab1b8717
--- /dev/null
+++ b/drivers/staging/mt7621-gpio/Makefile
@@ -0,0 +1,3 @@
+obj-$(CONFIG_GPIO_MT7621)	+= gpio-mt7621.o
+
+ccflags-y += -I$(srctree)/$(src)/include
diff --git a/drivers/staging/mt7621-gpio/TODO b/drivers/staging/mt7621-gpio/TODO
new file mode 100644
index 000000000000..71439054e2e4
--- /dev/null
+++ b/drivers/staging/mt7621-gpio/TODO
@@ -0,0 +1,5 @@
+
+- general code review and clean up
+- ensure device-tree requirements are documented
+
+Cc:  NeilBrown <neil@brown.name>
diff --git a/drivers/staging/mt7621-gpio/gpio-mt7621.c b/drivers/staging/mt7621-gpio/gpio-mt7621.c
new file mode 100644
index 000000000000..5c57abea853f
--- /dev/null
+++ b/drivers/staging/mt7621-gpio/gpio-mt7621.c
@@ -0,0 +1,353 @@
+/*
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ *
+ * Copyright (C) 2009-2011 Gabor Juhos <juhosg@openwrt.org>
+ * Copyright (C) 2013 John Crispin <blogic@openwrt.org>
+ */
+
+#include <linux/io.h>
+#include <linux/err.h>
+#include <linux/gpio.h>
+#include <linux/module.h>
+#include <linux/of_irq.h>
+#include <linux/spinlock.h>
+#include <linux/irqdomain.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+
+#define MTK_MAX_BANK		3
+#define MTK_BANK_WIDTH		32
+
+enum mediatek_gpio_reg {
+	GPIO_REG_CTRL = 0,
+	GPIO_REG_POL,
+	GPIO_REG_DATA,
+	GPIO_REG_DSET,
+	GPIO_REG_DCLR,
+	GPIO_REG_REDGE,
+	GPIO_REG_FEDGE,
+	GPIO_REG_HLVL,
+	GPIO_REG_LLVL,
+	GPIO_REG_STAT,
+	GPIO_REG_EDGE,
+};
+
+static void __iomem *mediatek_gpio_membase;
+static int mediatek_gpio_irq;
+static struct irq_domain *mediatek_gpio_irq_domain;
+
+struct mtk_gc {
+	struct gpio_chip chip;
+	spinlock_t lock;
+	int bank;
+	u32 rising;
+	u32 falling;
+} *gc_map[MTK_MAX_BANK];
+
+static inline struct mtk_gc
+*to_mediatek_gpio(struct gpio_chip *chip)
+{
+	struct mtk_gc *mgc;
+
+	mgc = container_of(chip, struct mtk_gc, chip);
+
+	return mgc;
+}
+
+static inline void
+mtk_gpio_w32(struct mtk_gc *rg, u8 reg, u32 val)
+{
+	iowrite32(val, mediatek_gpio_membase + (reg * 0x10) + (rg->bank * 0x4));
+}
+
+static inline u32
+mtk_gpio_r32(struct mtk_gc *rg, u8 reg)
+{
+	return ioread32(mediatek_gpio_membase + (reg * 0x10) + (rg->bank * 0x4));
+}
+
+static void
+mediatek_gpio_set(struct gpio_chip *chip, unsigned offset, int value)
+{
+	struct mtk_gc *rg = to_mediatek_gpio(chip);
+
+	mtk_gpio_w32(rg, (value) ? GPIO_REG_DSET : GPIO_REG_DCLR, BIT(offset));
+}
+
+static int
+mediatek_gpio_get(struct gpio_chip *chip, unsigned offset)
+{
+	struct mtk_gc *rg = to_mediatek_gpio(chip);
+
+	return !!(mtk_gpio_r32(rg, GPIO_REG_DATA) & BIT(offset));
+}
+
+static int
+mediatek_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
+{
+	struct mtk_gc *rg = to_mediatek_gpio(chip);
+	unsigned long flags;
+	u32 t;
+
+	spin_lock_irqsave(&rg->lock, flags);
+	t = mtk_gpio_r32(rg, GPIO_REG_CTRL);
+	t &= ~BIT(offset);
+	mtk_gpio_w32(rg, GPIO_REG_CTRL, t);
+	spin_unlock_irqrestore(&rg->lock, flags);
+
+	return 0;
+}
+
+static int
+mediatek_gpio_direction_output(struct gpio_chip *chip,
+					unsigned offset, int value)
+{
+	struct mtk_gc *rg = to_mediatek_gpio(chip);
+	unsigned long flags;
+	u32 t;
+
+	spin_lock_irqsave(&rg->lock, flags);
+	t = mtk_gpio_r32(rg, GPIO_REG_CTRL);
+	t |= BIT(offset);
+	mtk_gpio_w32(rg, GPIO_REG_CTRL, t);
+	mediatek_gpio_set(chip, offset, value);
+	spin_unlock_irqrestore(&rg->lock, flags);
+
+	return 0;
+}
+
+static int
+mediatek_gpio_get_direction(struct gpio_chip *chip, unsigned offset)
+{
+	struct mtk_gc *rg = to_mediatek_gpio(chip);
+	unsigned long flags;
+	u32 t;
+
+	spin_lock_irqsave(&rg->lock, flags);
+	t = mtk_gpio_r32(rg, GPIO_REG_CTRL);
+	spin_unlock_irqrestore(&rg->lock, flags);
+
+	if (t & BIT(offset))
+		return 0;
+
+	return 1;
+}
+
+static int
+mediatek_gpio_to_irq(struct gpio_chip *chip, unsigned pin)
+{
+	struct mtk_gc *rg = to_mediatek_gpio(chip);
+
+	return irq_create_mapping(mediatek_gpio_irq_domain, pin + (rg->bank * MTK_BANK_WIDTH));
+}
+
+static int
+mediatek_gpio_bank_probe(struct platform_device *pdev, struct device_node *bank)
+{
+	const __be32 *id = of_get_property(bank, "reg", NULL);
+	struct mtk_gc *rg = devm_kzalloc(&pdev->dev,
+				sizeof(struct mtk_gc), GFP_KERNEL);
+
+	if (!rg || !id || be32_to_cpu(*id) > MTK_MAX_BANK)
+		return -ENOMEM;
+
+	gc_map[be32_to_cpu(*id)] = rg;
+
+	memset(rg, 0, sizeof(struct mtk_gc));
+
+	spin_lock_init(&rg->lock);
+
+	rg->chip.parent = &pdev->dev;
+	rg->chip.label = dev_name(&pdev->dev);
+	rg->chip.of_node = bank;
+	rg->chip.base = MTK_BANK_WIDTH * be32_to_cpu(*id);
+	rg->chip.ngpio = MTK_BANK_WIDTH;
+	rg->chip.direction_input = mediatek_gpio_direction_input;
+	rg->chip.direction_output = mediatek_gpio_direction_output;
+	rg->chip.get_direction = mediatek_gpio_get_direction;
+	rg->chip.get = mediatek_gpio_get;
+	rg->chip.set = mediatek_gpio_set;
+	if (mediatek_gpio_irq_domain)
+		rg->chip.to_irq = mediatek_gpio_to_irq;
+	rg->bank = be32_to_cpu(*id);
+
+	/* set polarity to low for all gpios */
+	mtk_gpio_w32(rg, GPIO_REG_POL, 0);
+
+	dev_info(&pdev->dev, "registering %d gpios\n", rg->chip.ngpio);
+
+	return gpiochip_add(&rg->chip);
+}
+
+static void
+mediatek_gpio_irq_handler(struct irq_desc *desc)
+{
+	int i;
+
+	for (i = 0; i < MTK_MAX_BANK; i++) {
+		struct mtk_gc *rg = gc_map[i];
+		unsigned long pending;
+		int bit;
+
+		if (!rg)
+			continue;
+
+		pending = mtk_gpio_r32(rg, GPIO_REG_STAT);
+
+		for_each_set_bit(bit, &pending, MTK_BANK_WIDTH) {
+			u32 map = irq_find_mapping(mediatek_gpio_irq_domain, (MTK_BANK_WIDTH * i) + bit);
+
+			generic_handle_irq(map);
+			mtk_gpio_w32(rg, GPIO_REG_STAT, BIT(bit));
+		}
+	}
+}
+
+static void
+mediatek_gpio_irq_unmask(struct irq_data *d)
+{
+	int pin = d->hwirq;
+	int bank = pin / 32;
+	struct mtk_gc *rg = gc_map[bank];
+	unsigned long flags;
+	u32 rise, fall;
+
+	if (!rg)
+		return;
+
+	rise = mtk_gpio_r32(rg, GPIO_REG_REDGE);
+	fall = mtk_gpio_r32(rg, GPIO_REG_FEDGE);
+
+	spin_lock_irqsave(&rg->lock, flags);
+	mtk_gpio_w32(rg, GPIO_REG_REDGE, rise | (BIT(d->hwirq) & rg->rising));
+	mtk_gpio_w32(rg, GPIO_REG_FEDGE, fall | (BIT(d->hwirq) & rg->falling));
+	spin_unlock_irqrestore(&rg->lock, flags);
+}
+
+static void
+mediatek_gpio_irq_mask(struct irq_data *d)
+{
+	int pin = d->hwirq;
+	int bank = pin / 32;
+	struct mtk_gc *rg = gc_map[bank];
+	unsigned long flags;
+	u32 rise, fall;
+
+	if (!rg)
+		return;
+
+	rise = mtk_gpio_r32(rg, GPIO_REG_REDGE);
+	fall = mtk_gpio_r32(rg, GPIO_REG_FEDGE);
+
+	spin_lock_irqsave(&rg->lock, flags);
+	mtk_gpio_w32(rg, GPIO_REG_FEDGE, fall & ~BIT(d->hwirq));
+	mtk_gpio_w32(rg, GPIO_REG_REDGE, rise & ~BIT(d->hwirq));
+	spin_unlock_irqrestore(&rg->lock, flags);
+}
+
+static int
+mediatek_gpio_irq_type(struct irq_data *d, unsigned int type)
+{
+	int pin = d->hwirq;
+	int bank = pin / 32;
+	struct mtk_gc *rg = gc_map[bank];
+	u32 mask = BIT(d->hwirq);
+
+	if (!rg)
+		return -1;
+
+	if (type == IRQ_TYPE_PROBE) {
+		if ((rg->rising | rg->falling) & mask)
+			return 0;
+
+		type = IRQ_TYPE_EDGE_RISING | IRQ_TYPE_EDGE_FALLING;
+	}
+
+	if (type & IRQ_TYPE_EDGE_RISING)
+		rg->rising |= mask;
+	else
+		rg->rising &= ~mask;
+
+	if (type & IRQ_TYPE_EDGE_FALLING)
+		rg->falling |= mask;
+	else
+		rg->falling &= ~mask;
+
+	return 0;
+}
+
+static struct irq_chip mediatek_gpio_irq_chip = {
+	.name		= "GPIO",
+	.irq_unmask	= mediatek_gpio_irq_unmask,
+	.irq_mask	= mediatek_gpio_irq_mask,
+	.irq_mask_ack	= mediatek_gpio_irq_mask,
+	.irq_set_type	= mediatek_gpio_irq_type,
+};
+
+static int
+mediatek_gpio_gpio_map(struct irq_domain *d, unsigned int irq, irq_hw_number_t hw)
+{
+	irq_set_chip_and_handler(irq, &mediatek_gpio_irq_chip, handle_level_irq);
+	irq_set_handler_data(irq, d);
+
+	return 0;
+}
+
+static const struct irq_domain_ops irq_domain_ops = {
+	.xlate = irq_domain_xlate_onecell,
+	.map = mediatek_gpio_gpio_map,
+};
+
+static int
+mediatek_gpio_probe(struct platform_device *pdev)
+{
+	struct device_node *bank, *np = pdev->dev.of_node;
+	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
+	mediatek_gpio_membase = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(mediatek_gpio_membase))
+		return PTR_ERR(mediatek_gpio_membase);
+
+	mediatek_gpio_irq = irq_of_parse_and_map(np, 0);
+	if (mediatek_gpio_irq) {
+		mediatek_gpio_irq_domain = irq_domain_add_linear(np,
+			MTK_MAX_BANK * MTK_BANK_WIDTH,
+			&irq_domain_ops, NULL);
+		if (!mediatek_gpio_irq_domain)
+			dev_err(&pdev->dev, "irq_domain_add_linear failed\n");
+	}
+
+	for_each_child_of_node(np, bank)
+		if (of_device_is_compatible(bank, "mtk,mt7621-gpio-bank"))
+			mediatek_gpio_bank_probe(pdev, bank);
+
+	if (mediatek_gpio_irq_domain)
+		irq_set_chained_handler(mediatek_gpio_irq, mediatek_gpio_irq_handler);
+
+	return 0;
+}
+
+static const struct of_device_id mediatek_gpio_match[] = {
+	{ .compatible = "mtk,mt7621-gpio" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, mediatek_gpio_match);
+
+static struct platform_driver mediatek_gpio_driver = {
+	.probe = mediatek_gpio_probe,
+	.driver = {
+		.name = "mt7621_gpio",
+		.owner = THIS_MODULE,
+		.of_match_table = mediatek_gpio_match,
+	},
+};
+
+static int __init
+mediatek_gpio_init(void)
+{
+	return platform_driver_register(&mediatek_gpio_driver);
+}
+
+subsys_initcall(mediatek_gpio_init);
