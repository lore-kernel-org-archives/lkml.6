Return-Path: <boris.brezillon@bootlin.com>
X-Google-Smtp-Source: AIpwx4+35k01KgrVydeEOG2f5HDHlW93Hved51xrZShfS4K8JDuhoDSah0QS4iF5c1gm7g+u/lL6
ARC-Seal: i=1; a=rsa-sha256; t=1522396081; cv=none;
        d=google.com; s=arc-20160816;
        b=BFwThx127sQwtP7loBB0oMrmQ6GxyDFeGEVoNc9oqAutpdAvKQ7ry1b81dPY3SymXq
         QyzaLcVdVKOd0UnOEmMcM5W+M6oCax12d8g3tL/o6Elt5giP7SR9HakrI07twvcRVkMm
         b6OvWsmlHfewg3M5jdIHy5x+idj4/1GSX8MBz7YyUv4uZE5LNPWRG8UOf2RHb71lZcfS
         UgXTBblRyXXq9HH+qwHjLL119aEAi9IgXKhvT8oeaR7CSvcCtq8V/9VFQJ7m4ujVQ0pY
         8KnfDIO5w490dzzmeRck0YL5RtZ/4e26UIeUkbRei+ILymvIno4Edd7JLR69K3eiGZSf
         30fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=vi8ILNfwg5FpVwWo/mZOzaBN63zlaIF641+bxD9kk1k=;
        b=G0Y5zMbajQsEJSaU/XeWz8g+tYD7zFT6C90GVJJyHewjmRmjHmE7kn9Xcfgvh8iH+7
         Vh1uYm8XdgJT/o7FOX81g8Xg3nucsKK6HjDB5QiJYiso9XBlE8nVa2U1RSM49kO/SkZk
         zh0N89VPVcT9edh1EOZ784hfKFV4YZul4d5YrBT3jJaV4F6nFozned6Uf50M32n0CEhA
         QF4E3wceIzdTCfpCLSqRB4Jy1bHq5/HUcmMkxExun8ZMKSd4WQHiw/WlZ0GFzeZRFB11
         DkBAaI1X8v6mqe6LEgBngh2paf3xv2tfi5KTHH6ATHrWMGQIeNAPkjKPeO6i42snniTL
         BzKQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of boris.brezillon@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=boris.brezillon@bootlin.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of boris.brezillon@bootlin.com designates 62.4.15.54 as permitted sender) smtp.mailfrom=boris.brezillon@bootlin.com
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: Wolfram Sang <wsa@the-dreams.de>,
	linux-i2c@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>
Cc: Przemyslaw Sroka <psroka@cadence.com>,
	Arkadiusz Golec <agolec@cadence.com>,
	Alan Douglas <adouglas@cadence.com>,
	Bartosz Folta <bfolta@cadence.com>,
	Damian Kos <dkos@cadence.com>,
	Alicja Jurasik-Urbaniak <alicja@cadence.com>,
	Cyprian Wronka <cwronka@cadence.com>,
	Suresh Punnoose <sureshp@cadence.com>,
	Rafal Ciepiela <rafalc@cadence.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Nishanth Menon <nm@ti.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vitor Soares <Vitor.Soares@synopsys.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Xiang Lin <Xiang.Lin@synaptics.com>,
	linux-gpio@vger.kernel.org,
	Boris Brezillon <boris.brezillon@bootlin.com>
Subject: [PATCH v4 09/10] gpio: Add a driver for Cadence I3C GPIO expander
Date: Fri, 30 Mar 2018 09:47:50 +0200
Message-Id: <20180330074751.25987-10-boris.brezillon@bootlin.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180330074751.25987-1-boris.brezillon@bootlin.com>
References: <20180330074751.25987-1-boris.brezillon@bootlin.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596347993252647140?=
X-GMAIL-MSGID: =?utf-8?q?1596347993252647140?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add a driver for Cadence I3C GPIO expander.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 drivers/gpio/Kconfig         |  11 ++
 drivers/gpio/Makefile        |   1 +
 drivers/gpio/gpio-cdns-i3c.c | 380 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 392 insertions(+)
 create mode 100644 drivers/gpio/gpio-cdns-i3c.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 8dbb2280538d..87b7083179ff 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -862,6 +862,17 @@ config GPIO_TS4900
 
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
index cccb0d40846c..22a7151fc565 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -36,6 +36,7 @@ obj-$(CONFIG_GPIO_BCM_KONA)	+= gpio-bcm-kona.o
 obj-$(CONFIG_GPIO_BD9571MWV)	+= gpio-bd9571mwv.o
 obj-$(CONFIG_GPIO_BRCMSTB)	+= gpio-brcmstb.o
 obj-$(CONFIG_GPIO_BT8XX)	+= gpio-bt8xx.o
+obj-$(CONFIG_GPIO_CDNS_I3C)	+= gpio-cdns-i3c.o
 obj-$(CONFIG_GPIO_CLPS711X)	+= gpio-clps711x.o
 obj-$(CONFIG_GPIO_CS5535)	+= gpio-cs5535.o
 obj-$(CONFIG_GPIO_CRYSTAL_COVE)	+= gpio-crystalcove.o
diff --git a/drivers/gpio/gpio-cdns-i3c.c b/drivers/gpio/gpio-cdns-i3c.c
new file mode 100644
index 000000000000..58a903fabb0a
--- /dev/null
+++ b/drivers/gpio/gpio-cdns-i3c.c
@@ -0,0 +1,380 @@
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
+	struct i3c_priv_xfer xfers[] = {
+		{
+			.len = sizeof(reg),
+			.data.out = &reg,
+		},
+		{
+			.rnw = true,
+			.len = sizeof(*val),
+			.data.in = val,
+		},
+	};
+
+	return i3c_device_do_priv_xfers(gpioc->i3cdev, xfers,
+					ARRAY_SIZE(xfers));
+}
+
+static int cdns_i3c_gpio_write_reg(struct cdns_i3c_gpio *gpioc, u8 reg,
+				   u8 val)
+{
+	struct i3c_priv_xfer xfers[] = {
+		{
+			.len = sizeof(reg),
+			.data.out = &reg,
+		},
+		{
+			.len = sizeof(val),
+			.data.out = &val,
+		},
+	};
+
+	return i3c_device_do_priv_xfers(gpioc->i3cdev, xfers,
+					ARRAY_SIZE(xfers));
+}
+
+static int cdns_i3c_gpio_get_direction(struct gpio_chip *g, unsigned offset)
+{
+	struct cdns_i3c_gpio *gpioc = gpioc_to_cdns_gpioc(g);
+
+	return gpioc->dir & BIT(offset);
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
+static void cdns_i3c_gpio_set(struct gpio_chip *g, unsigned offset, int value)
+{
+	unsigned long mask = BIT(offset), bits = value ? BIT(offset) : 0;
+
+	cdns_i3c_gpio_set_multiple(g, &mask, &bits);
+}
+
+static int cdns_i3c_gpio_set_dir(struct cdns_i3c_gpio *gpioc, unsigned pin,
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
+static int cdns_i3c_gpio_dir_input(struct gpio_chip *g, unsigned offset)
+{
+	struct cdns_i3c_gpio *gpioc = gpioc_to_cdns_gpioc(g);
+
+	return cdns_i3c_gpio_set_dir(gpioc, offset, true);
+}
+
+static int cdns_i3c_gpio_dir_output(struct gpio_chip *g, unsigned offset,
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
+static int cdns_i3c_gpio_get(struct gpio_chip *g, unsigned offset)
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
+static int cdns_i3c_gpio_irq_set_type(struct irq_data *data, unsigned type)
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
2.14.1
