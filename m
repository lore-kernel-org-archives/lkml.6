Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752528AbeBHOaE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 09:30:04 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:42682 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751094AbeBHO2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 09:28:35 -0500
From: Amelie Delaunay <amelie.delaunay@st.com>
To: Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        "Alexandre Torgue" <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC: <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        "Amelie Delaunay" <amelie.delaunay@st.com>
Subject: [PATCH 3/6] gpio: Add GPIO support for the ST Multi-Function eXpander
Date: Thu, 8 Feb 2018 15:27:34 +0100
Message-ID: <1518100057-23234-4-git-send-email-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518100057-23234-1-git-send-email-amelie.delaunay@st.com>
References: <1518100057-23234-1-git-send-email-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.5]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-08_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ST Multi-Function eXpander (MFX) can be used as GPIO expander.
It has 16 fast GPIOs and can have 8 extra alternate GPIOs
when other MFX features are not enabled.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 drivers/gpio/Kconfig                   |  10 +
 drivers/gpio/Makefile                  |   1 +
 drivers/gpio/gpio-st-mfx.c             | 589 +++++++++++++++++++++++++++++++++
 include/dt-bindings/gpio/st-mfx-gpio.h |  24 ++
 4 files changed, 624 insertions(+)
 create mode 100644 drivers/gpio/gpio-st-mfx.c
 create mode 100644 include/dt-bindings/gpio/st-mfx-gpio.h

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index d6a8e85..7827af3 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1034,6 +1034,16 @@ config GPIO_STMPE
 	  This enables support for the GPIOs found on the STMPE I/O
 	  Expanders.
 
+config GPIO_ST_MFX
+	bool "ST-MFX GPIOs"
+	depends on MFD_ST_MFX
+	depends on OF_GPIO
+	select GPIOLIB_IRQCHIP
+	help
+	  GPIO driver for STMicroelectronics Multi-Function eXpander.
+
+	  This provides GPIO interface supporting inputs and outputs.
+
 config GPIO_TC3589X
 	bool "TC3589X GPIOs"
 	depends on MFD_TC3589X
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 4bc24fe..7013bfa 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -110,6 +110,7 @@ obj-$(CONFIG_GPIO_SODAVILLE)	+= gpio-sodaville.o
 obj-$(CONFIG_GPIO_SPEAR_SPICS)	+= gpio-spear-spics.o
 obj-$(CONFIG_GPIO_STA2X11)	+= gpio-sta2x11.o
 obj-$(CONFIG_GPIO_STMPE)	+= gpio-stmpe.o
+obj-$(CONFIG_GPIO_ST_MFX) 	+= gpio-st-mfx.o
 obj-$(CONFIG_GPIO_STP_XWAY)	+= gpio-stp-xway.o
 obj-$(CONFIG_GPIO_SYSCON)	+= gpio-syscon.o
 obj-$(CONFIG_GPIO_TB10X)	+= gpio-tb10x.o
diff --git a/drivers/gpio/gpio-st-mfx.c b/drivers/gpio/gpio-st-mfx.c
new file mode 100644
index 0000000..4e5235f
--- /dev/null
+++ b/drivers/gpio/gpio-st-mfx.c
@@ -0,0 +1,589 @@
+/*
+ * STMicroelectronics Multi-Function eXpander (ST-MFX) - GPIO expander driver.
+ *
+ * Copyright (C) 2017, STMicroelectronics - All Rights Reserved
+ * Author(s): Amelie Delaunay <amelie.delaunay@st.com> for STMicroelectronics.
+ *
+ * License terms: GPL V2.0.
+ *
+ * st-mfx-gpio is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published by
+ * the Free Software Foundation.
+ *
+ * st-mfx-gpio is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * st-mfx-gpio. If not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/interrupt.h>
+#include <linux/mfd/st-mfx.h>
+#include <linux/module.h>
+#include <linux/of_gpio.h>
+#include <linux/platform_device.h>
+#include <linux/seq_file.h>
+
+/* MFX has a maximum of 24 gpios, with 8 gpios per bank, so 3 banks maximum */
+#define NR_MAX_GPIOS		24
+#define NR_GPIOS_PER_BANK	8
+#define NR_MAX_BANKS		(NR_MAX_GPIOS / NR_GPIOS_PER_BANK)
+#define get_bank(offset)	((u8)((offset) / NR_GPIOS_PER_BANK))
+#define get_mask(offset)	((u8)BIT((offset) % NR_GPIOS_PER_BANK))
+
+/*
+ * These registers are modified under the .irq_bus_lock and cached to avoid
+ * unnecessary writes in .irq_bus_sync_unlock.
+ */
+enum { REG_IRQ_SRC, REG_IRQ_EVT, REG_IRQ_TYPE, NR_CACHE_IRQ_REGS };
+
+/*
+ * This is MFX-specific flags, overloading Linux-specific of_gpio_flags,
+ * needed in of_xlate callback.
+ * on MFX: - if GPIO is output:
+ *		* (0) means PUSH_PULL
+ *		* OF_GPIO_SINGLE_ENDED (=2) means OPEN-DRAIN
+ *	   - if GPIO is input:
+ *		* (0) means NO_PULL
+ *		* OF_MFX_GPI_PUSH_PULL (=2) means PUSH_PULL
+ *
+ *		* OF_MFX_GPIO_PULL_UP programs pull up resistor on the GPIO,
+ *		  whatever its direction, without this flag, depending on
+ *		  GPIO type and direction, it programs either no pull or
+ *		  pull down resistor.
+ */
+enum of_mfx_gpio_flags {
+	OF_MFX_GPI_PUSH_PULL = 0x2,
+	OF_MFX_GPIO_PULL_UP = 0x4,
+};
+
+struct mfx_gpio {
+	struct gpio_chip gc;
+	struct mfx *mfx;
+	struct device *dev;
+	struct mutex irq_lock; /* IRQ bus lock */
+	u32 flags[NR_MAX_GPIOS];
+	/* Caches of interrupt control registers for bus_lock */
+	u8 regs[NR_CACHE_IRQ_REGS][NR_MAX_BANKS];
+	u8 oldregs[NR_CACHE_IRQ_REGS][NR_MAX_BANKS];
+};
+
+static int mfx_gpio_get(struct gpio_chip *gc, unsigned int offset)
+{
+	struct mfx_gpio *mfx_gpio = gpiochip_get_data(gc);
+	struct mfx *mfx = mfx_gpio->mfx;
+	u8 reg = MFX_REG_GPIO_STATE + get_bank(offset);
+	u8 mask = get_mask(offset);
+	int ret;
+
+	ret = mfx_reg_read(mfx, reg);
+	if (ret < 0)
+		return ret;
+
+	return !!(ret & mask);
+}
+
+static void mfx_gpio_set(struct gpio_chip *gc, unsigned int offset, int val)
+{
+	struct mfx_gpio *mfx_gpio = gpiochip_get_data(gc);
+	struct mfx *mfx = mfx_gpio->mfx;
+	int which = val ? MFX_REG_GPO_SET : MFX_REG_GPO_CLR;
+	u8 reg = which + get_bank(offset);
+	u8 mask = get_mask(offset);
+
+	mfx_reg_write(mfx, reg, mask);
+}
+
+static int mfx_gpio_get_direction(struct gpio_chip *gc,
+				  unsigned int offset)
+{
+	struct mfx_gpio *mfx_gpio = gpiochip_get_data(gc);
+	struct mfx *mfx = mfx_gpio->mfx;
+	u8 reg = MFX_REG_GPIO_DIR + get_bank(offset);
+	u8 mask = get_mask(offset);
+	int ret;
+
+	ret = mfx_reg_read(mfx, reg);
+	if (ret < 0)
+		return ret;
+
+	return !(ret & mask);
+}
+
+static int mfx_gpio_direction_input(struct gpio_chip *gc,
+				    unsigned int offset)
+{
+	struct mfx_gpio *mfx_gpio = gpiochip_get_data(gc);
+	struct mfx *mfx = mfx_gpio->mfx;
+	u8 reg_type = MFX_REG_GPIO_TYPE + get_bank(offset);
+	u8 reg_pupd = MFX_REG_GPIO_PUPD + get_bank(offset);
+	u8 reg_dir = MFX_REG_GPIO_DIR + get_bank(offset);
+	u8 mask = get_mask(offset);
+	int ret;
+
+	/*
+	 * In case of input direction, there is actually no way to apply some
+	 * configuration in hardware, as it can be done with
+	 * .set_config in case of output direction. That's why we apply
+	 * here the MFX specific-flags.
+	 */
+	if (mfx_gpio->flags[offset] & OF_MFX_GPI_PUSH_PULL)
+		ret = mfx_set_bits(mfx, reg_type, mask, mask);
+	else
+		ret = mfx_set_bits(mfx, reg_type, mask, 0);
+
+	if (ret)
+		return ret;
+
+	if (mfx_gpio->flags[offset] & OF_MFX_GPIO_PULL_UP)
+		ret = mfx_set_bits(mfx, reg_pupd, mask, mask);
+	else
+		ret = mfx_set_bits(mfx, reg_pupd, mask, 0);
+
+	if (ret)
+		return ret;
+
+	return mfx_set_bits(mfx, reg_dir, mask, 0);
+}
+
+static int mfx_gpio_direction_output(struct gpio_chip *gc,
+				     unsigned int offset, int val)
+{
+	struct mfx_gpio *mfx_gpio = gpiochip_get_data(gc);
+	struct mfx *mfx = mfx_gpio->mfx;
+	u8 reg = MFX_REG_GPIO_DIR + get_bank(offset);
+	u8 mask = get_mask(offset);
+
+	mfx_gpio_set(gc, offset, val);
+
+	return mfx_set_bits(mfx, reg, mask, mask);
+}
+
+static int mfx_gpio_set_config(struct gpio_chip *gc, unsigned int offset,
+			       unsigned long config)
+{
+	struct mfx_gpio *mfx_gpio = gpiochip_get_data(gc);
+	struct mfx *mfx = mfx_gpio->mfx;
+	u8 reg_type = MFX_REG_GPIO_TYPE + get_bank(offset);
+	u8 reg_pupd = MFX_REG_GPIO_PUPD + get_bank(offset);
+	u8 mask = get_mask(offset);
+	int ret;
+
+	switch (pinconf_to_config_param(config)) {
+	case PIN_CONFIG_DRIVE_OPEN_DRAIN:
+		ret = mfx_set_bits(mfx, reg_type, mask, mask);
+		if (ret)
+			return ret;
+		return mfx_set_bits(mfx, reg_pupd, mask, 0);
+	case PIN_CONFIG_DRIVE_OPEN_SOURCE:
+		ret = mfx_set_bits(mfx, reg_type, mask, mask);
+		if (ret)
+			return ret;
+		return mfx_set_bits(mfx, reg_pupd, mask, mask);
+	case PIN_CONFIG_DRIVE_PUSH_PULL:
+		ret = mfx_set_bits(mfx, reg_type, mask, 0);
+		if (ret)
+			return ret;
+		return mfx_set_bits(mfx, reg_pupd, mask, 0);
+	default:
+		break;
+	}
+
+	return -ENOTSUPP;
+}
+
+static void mfx_gpio_dbg_show(struct seq_file *s, struct gpio_chip *gc)
+{
+	struct mfx_gpio *mfx_gpio = gpiochip_get_data(gc);
+	struct mfx *mfx = mfx_gpio->mfx;
+	u16 i;
+
+	for (i = 0; i < gc->ngpio; i++) {
+		int gpio = i + gc->base;
+		const char *label = gpiochip_is_requested(gc, i);
+		int dir = mfx_gpio_get_direction(gc, i);
+		int val = mfx_gpio_get(gc, i);
+		u8 mask = get_mask(i);
+		u8 reg;
+		int type, pupd;
+		int irqsrc, irqevt, irqtype, irqpending;
+
+		if (!label)
+			label = "Unrequested";
+
+		seq_printf(s, " gpio-%-3d (%-20.20s) ", gpio, label);
+
+		reg = MFX_REG_GPIO_TYPE + get_bank(i);
+		type = mfx_reg_read(mfx, reg);
+		if (type < 0)
+			return;
+		type = !!(type & mask);
+
+		reg = MFX_REG_GPIO_PUPD + get_bank(i);
+		pupd = mfx_reg_read(mfx, reg);
+		if (pupd < 0)
+			return;
+		pupd = !!(pupd & mask);
+
+		reg = MFX_REG_IRQ_GPI_SRC + get_bank(i);
+		irqsrc = mfx_reg_read(mfx, reg);
+		if (irqsrc < 0)
+			return;
+		irqsrc = !!(irqsrc & mask);
+
+		reg = MFX_REG_IRQ_GPI_EVT + get_bank(i);
+		irqevt = mfx_reg_read(mfx, reg);
+		if (irqevt < 0)
+			return;
+		irqevt = !!(irqevt & mask);
+
+		reg = MFX_REG_IRQ_GPI_TYPE + get_bank(i);
+		irqtype = mfx_reg_read(mfx, reg);
+		if (irqtype < 0)
+			return;
+		irqtype = !!(irqtype & mask);
+
+		reg = MFX_REG_IRQ_GPI_PENDING + get_bank(i);
+		irqpending = mfx_reg_read(mfx, reg);
+		if (irqpending < 0)
+			return;
+		irqpending = !!(irqpending & mask);
+
+		if (!dir) {
+			seq_printf(s, "out %s ", val ? "high" : "low");
+			if (type)
+				seq_puts(s, "open drain ");
+			else
+				seq_puts(s, "push pull ");
+			if (pupd && type)
+				seq_puts(s, "with internal pull-up ");
+			else
+				seq_puts(s, "without internal pull-up ");
+		} else {
+			seq_printf(s, "in %s ", val ? "high" : "low");
+			if (type)
+				seq_printf(s, "with internal pull-%s ",
+					   pupd ? "up" : "down");
+			else
+				seq_printf(s, "%s ",
+					   pupd ? "floating" : "analog");
+		}
+
+		if (irqsrc) {
+			seq_printf(s, "IRQ generated on %s %s",
+				   !irqevt ?
+				   (!irqtype ? "Low level" : "High level") :
+				   (!irqtype ? "Falling edge" : "Rising edge"),
+				   irqpending ? "(pending)" : "");
+		}
+
+		seq_puts(s, "\n");
+	}
+}
+
+int mfx_gpio_of_xlate(struct gpio_chip *gc,
+		      const struct of_phandle_args *gpiospec, u32 *flags)
+{
+	struct mfx_gpio *mfx_gpio = gpiochip_get_data(gc);
+	int ret;
+
+	ret = of_gpio_simple_xlate(gc, gpiospec, flags);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * In atomic context here, we can't access registers over I2C,
+	 * that's why gpio flags are stored to be applied later.
+	 */
+	mfx_gpio->flags[gpiospec->args[0]] = gpiospec->args[1];
+
+	return ret;
+}
+
+static const struct gpio_chip mfx_gpio_chip = {
+	.label			= "MFX_GPIO",
+	.owner			= THIS_MODULE,
+	.get_direction		= mfx_gpio_get_direction,
+	.direction_input	= mfx_gpio_direction_input,
+	.direction_output	= mfx_gpio_direction_output,
+	.get			= mfx_gpio_get,
+	.set			= mfx_gpio_set,
+	.set_config		= mfx_gpio_set_config,
+	.dbg_show		= mfx_gpio_dbg_show,
+	.can_sleep		= true,
+	.of_gpio_n_cells	= 2,
+	.of_xlate		= mfx_gpio_of_xlate,
+};
+
+static void mfx_gpio_irq_toggle_trigger(struct gpio_chip *gc, int offset)
+{
+	struct mfx_gpio *mfx_gpio = gpiochip_get_data(gc);
+	struct mfx *mfx = mfx_gpio->mfx;
+	u8 bank = get_bank(offset);
+	u8 mask = get_mask(offset);
+	int val = mfx_gpio_get(gc, offset);
+
+	if (val < 0) {
+		dev_err(mfx_gpio->dev, "can't get value of gpio%d: ret=%d\n",
+			offset, val);
+		return;
+	}
+
+	if (val) {
+		mfx_gpio->regs[REG_IRQ_TYPE][bank] &= ~mask;
+		mfx_set_bits(mfx, MFX_REG_IRQ_GPI_TYPE + bank, mask, 0);
+	} else {
+		mfx_gpio->regs[REG_IRQ_TYPE][bank] |= mask;
+		mfx_set_bits(mfx, MFX_REG_IRQ_GPI_TYPE + bank, mask, mask);
+	}
+}
+
+static int mfx_gpio_irq_set_type(struct irq_data *d, unsigned int type)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	struct mfx_gpio *mfx_gpio = gpiochip_get_data(gc);
+	int bank = get_bank(d->hwirq);
+	int mask = get_mask(d->hwirq);
+
+	if ((type & IRQ_TYPE_LEVEL_LOW) || (type & IRQ_TYPE_LEVEL_HIGH))
+		mfx_gpio->regs[REG_IRQ_EVT][bank] &= ~mask;
+	else
+		mfx_gpio->regs[REG_IRQ_EVT][bank] |= mask;
+
+	if ((type & IRQ_TYPE_EDGE_RISING) || (type & IRQ_TYPE_LEVEL_HIGH))
+		mfx_gpio->regs[REG_IRQ_TYPE][bank] |= mask;
+	else
+		mfx_gpio->regs[REG_IRQ_TYPE][bank] &= ~mask;
+
+	/*
+	 * In case of (type & IRQ_TYPE_EDGE_BOTH), we need to know current
+	 * GPIO value to set the right edge trigger. But in atomic context
+	 * here we can't access registers over I2C. That's why (type &
+	 * IRQ_TYPE_EDGE_BOTH) will be managed in .irq_sync_unlock.
+	 */
+
+	return 0;
+}
+
+static void mfx_gpio_irq_lock(struct irq_data *d)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	struct mfx_gpio *mfx_gpio = gpiochip_get_data(gc);
+
+	mutex_lock(&mfx_gpio->irq_lock);
+}
+
+static void mfx_gpio_irq_sync_unlock(struct irq_data *d)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	struct mfx_gpio *mfx_gpio = gpiochip_get_data(gc);
+	struct mfx *mfx = mfx_gpio->mfx;
+	static const u8 cache_regs[] = {
+		[REG_IRQ_SRC] = MFX_REG_IRQ_GPI_SRC,
+		[REG_IRQ_EVT] = MFX_REG_IRQ_GPI_EVT,
+		[REG_IRQ_TYPE] = MFX_REG_IRQ_GPI_TYPE,
+	};
+	u8 i, bank;
+
+	/*
+	 * In case of (type & IRQ_TYPE_EDGE_BOTH), read the current GPIO value
+	 * (this couldn't be done in .irq_set_type because of atomic context)
+	 * to set the right irq trigger type.
+	 */
+	if (irqd_get_trigger_type(d) & IRQ_TYPE_EDGE_BOTH) {
+		int type;
+
+		if (mfx_gpio_get(gc, d->hwirq))
+			type = IRQ_TYPE_EDGE_FALLING;
+		else
+			type = IRQ_TYPE_EDGE_RISING;
+
+		mfx_gpio_irq_set_type(d, type);
+	}
+
+	for (i = 0; i < NR_CACHE_IRQ_REGS; i++) {
+		for (bank = 0; bank < NR_MAX_BANKS; bank++) {
+			u8 old = mfx_gpio->oldregs[i][bank];
+			u8 new = mfx_gpio->regs[i][bank];
+
+			if (new == old)
+				continue;
+
+			mfx_gpio->oldregs[i][bank] = new;
+			mfx_reg_write(mfx, cache_regs[i] + bank, new);
+		}
+	}
+
+	mutex_unlock(&mfx_gpio->irq_lock);
+}
+
+static void mfx_gpio_irq_mask(struct irq_data *d)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	struct mfx_gpio *mfx_gpio = gpiochip_get_data(gc);
+	int offset = d->hwirq;
+	u8 bank = get_bank(offset);
+	u8 mask = get_mask(offset);
+
+	mfx_gpio->regs[REG_IRQ_SRC][bank] &= ~mask;
+}
+
+static void mfx_gpio_irq_unmask(struct irq_data *d)
+{
+	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
+	struct mfx_gpio *mfx_gpio = gpiochip_get_data(gc);
+	int offset = d->hwirq;
+	u8 bank = get_bank(offset);
+	u8 mask = get_mask(offset);
+
+	mfx_gpio->regs[REG_IRQ_SRC][bank] |= mask;
+}
+
+static struct irq_chip mfx_gpio_irq_chip = {
+	.name			= "mfx-gpio",
+	.irq_bus_lock		= mfx_gpio_irq_lock,
+	.irq_bus_sync_unlock	= mfx_gpio_irq_sync_unlock,
+	.irq_mask		= mfx_gpio_irq_mask,
+	.irq_unmask		= mfx_gpio_irq_unmask,
+	.irq_set_type		= mfx_gpio_irq_set_type,
+};
+
+static irqreturn_t mfx_gpio_irq(int irq, void *dev)
+{
+	struct mfx_gpio *mfx_gpio = dev;
+	struct mfx *mfx = mfx_gpio->mfx;
+	int num_banks = mfx->num_gpio / 8;
+	u8 status[num_banks];
+	int ret;
+	u8 bank;
+
+	ret = mfx_block_read(mfx, MFX_REG_IRQ_GPI_PENDING, ARRAY_SIZE(status),
+			     status);
+	if (ret < 0) {
+		dev_err(mfx_gpio->dev, "can't get IRQ_GPI_PENDING: %d\n", ret);
+		return IRQ_NONE;
+	}
+
+	for (bank = 0; bank < ARRAY_SIZE(status); bank++) {
+		u8 stat = status[bank];
+
+		if (!stat)
+			continue;
+
+		while (stat) {
+			int bit = __ffs(stat);
+			int offset = bank * NR_GPIOS_PER_BANK + bit;
+			int gpio_irq = irq_find_mapping(mfx_gpio->gc.irq.domain,
+							offset);
+			int irq_trigger = irq_get_trigger_type(gpio_irq);
+
+			handle_nested_irq(gpio_irq);
+			stat &= ~(BIT(bit));
+
+			if (irq_trigger & IRQ_TYPE_EDGE_BOTH)
+				mfx_gpio_irq_toggle_trigger(&mfx_gpio->gc,
+							    offset);
+		}
+
+		mfx_reg_write(mfx, MFX_REG_IRQ_GPI_ACK + bank, status[bank]);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int mfx_gpio_probe(struct platform_device *pdev)
+{
+	struct mfx *mfx = dev_get_drvdata(pdev->dev.parent);
+	struct mfx_gpio *mfx_gpio;
+	int irq;
+	int ret;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(&pdev->dev, "failed to get irq: %d\n", irq);
+
+		return irq;
+	}
+
+	mfx_gpio = devm_kzalloc(&pdev->dev, sizeof(struct mfx_gpio),
+				GFP_KERNEL);
+	if (!mfx_gpio)
+		return -ENOMEM;
+
+	mutex_init(&mfx_gpio->irq_lock);
+
+	mfx_gpio->dev = &pdev->dev;
+	mfx_gpio->mfx = mfx;
+
+	mfx_gpio->gc = mfx_gpio_chip;
+	mfx_gpio->gc.ngpio = mfx->num_gpio;
+	mfx_gpio->gc.parent = &pdev->dev;
+	mfx_gpio->gc.base = -1;
+	mfx_gpio->gc.of_node = pdev->dev.of_node;
+
+	if (mfx->blocks & MFX_BLOCK_ALTGPIO)
+		ret = mfx_enable(mfx, MFX_BLOCK_GPIO | MFX_BLOCK_ALTGPIO);
+	else
+		ret = mfx_enable(mfx, MFX_BLOCK_GPIO);
+
+	if (ret < 0)
+		return ret;
+
+	ret = devm_request_threaded_irq(&pdev->dev, irq,
+					NULL, mfx_gpio_irq, IRQF_ONESHOT,
+					"mfx-gpio", mfx_gpio);
+	if (ret) {
+		dev_err(&pdev->dev, "unable to request irq: %d\n", ret);
+		return ret;
+	}
+
+	ret = devm_gpiochip_add_data(&pdev->dev, &mfx_gpio->gc, mfx_gpio);
+	if (ret) {
+		dev_err(&pdev->dev, "unable to add gpiochip: %d\n", ret);
+		return ret;
+	}
+
+	ret = gpiochip_irqchip_add_nested(&mfx_gpio->gc, &mfx_gpio_irq_chip, 0,
+					  handle_simple_irq, IRQ_TYPE_NONE);
+	if (ret) {
+		dev_err(&pdev->dev, "could not connect irqchip to gpiochip\n");
+		return ret;
+	}
+
+	gpiochip_set_nested_irqchip(&mfx_gpio->gc, &mfx_gpio_irq_chip, irq);
+
+	platform_set_drvdata(pdev, mfx_gpio);
+
+	dev_info(&pdev->dev, "ST-MFX (GPIO) initialized\n");
+
+	return 0;
+}
+
+static int mfx_gpio_remove(struct platform_device *pdev)
+{
+	struct mfx *mfx = dev_get_drvdata(pdev->dev.parent);
+
+	return mfx_disable(mfx, MFX_BLOCK_GPIO | MFX_BLOCK_ALTGPIO);
+}
+
+static const struct of_device_id mfx_gpio_of_match[] = {
+	{ .compatible = "st,mfx-gpio" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, mfx_of_match);
+
+static struct platform_driver mfx_gpio_driver = {
+	.driver = {
+		.name	= "st-mfx-gpio",
+		.of_match_table = mfx_gpio_of_match,
+	},
+	.probe		= mfx_gpio_probe,
+	.remove		= mfx_gpio_remove,
+};
+module_platform_driver(mfx_gpio_driver);
+
+MODULE_DESCRIPTION("STMicroelectronics Multi-Function eXpander GPIO driver");
+MODULE_AUTHOR("Amelie Delaunay <amelie.delaunay@st.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/include/dt-bindings/gpio/st-mfx-gpio.h b/include/dt-bindings/gpio/st-mfx-gpio.h
new file mode 100644
index 0000000..78dc7c5
--- /dev/null
+++ b/include/dt-bindings/gpio/st-mfx-gpio.h
@@ -0,0 +1,24 @@
+/*
+ * This header provides constants for binding st,mfx-gpio.
+ *
+ * The first cell in ST MFX GPIO specifier is the gpio number.
+ *
+ * The second cell contains standard flag values specified in gpio.h and
+ * specific flag values described here.
+ */
+
+#ifndef _DT_BINDINGS_GPIO_ST_MFX_GPIO_H
+#define _DT_BINDINGS_GPIO_ST_MFX_GPIO_H
+
+#include <dt-bindings/gpio/gpio.h>
+
+#define GPIO_IN_NO_PULL		0
+#define GPIO_IN_PUSH_PULL	2
+#define GPIO_OUT_PUSH_PULL	GPIO_PUSH_PULL
+#define GPIO_OUT_OPEN_DRAIN	GPIO_SINGLE_ENDED
+
+#define GPIO_NO_PULL		0
+#define GPIO_PULL_DOWN		0
+#define GPIO_PULL_UP		4
+
+#endif
-- 
2.7.4
