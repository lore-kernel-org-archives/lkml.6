Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753076AbeDKJs0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 05:48:26 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:48219 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752959AbeDKJr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 05:47:58 -0400
From: Amelie Delaunay <amelie.delaunay@st.com>
To: Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        "Maxime Coquelin" <mcoquelin.stm32@gmail.com>
CC: <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        "Lee Jones" <lee.jones@linaro.org>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH 2/5] pinctrl: Add STMFX GPIO expander Pinctrl/GPIO driver
Date: Wed, 11 Apr 2018 11:47:02 +0200
Message-ID: <1523440025-18077-3-git-send-email-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523440025-18077-1-git-send-email-amelie.delaunay@st.com>
References: <1523440025-18077-1-git-send-email-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.5]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-11_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds pinctrl/GPIO driver for STMicroelectronics
Multi-Function eXpander (STMFX) GPIO expander.
STMFX is an I2C slave controller, offering up to 24 GPIOs.
The driver relies on generic pin config interface to configure the GPIOs.

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
---
 drivers/pinctrl/Kconfig         |  13 +
 drivers/pinctrl/Makefile        |   1 +
 drivers/pinctrl/pinctrl-stmfx.c | 985 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 999 insertions(+)
 create mode 100644 drivers/pinctrl/pinctrl-stmfx.c

diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
index 0f254b3..4ab07aa 100644
--- a/drivers/pinctrl/Kconfig
+++ b/drivers/pinctrl/Kconfig
@@ -263,6 +263,19 @@ config PINCTRL_ST
 	select PINCONF
 	select GPIOLIB_IRQCHIP
 
+config PINCTRL_STMFX
+	tristate "STMicroelectronics STMFX I2C GPIO expander pinctrl driver"
+	depends on GPIOLIB && I2C=y
+	select GENERIC_PINCONF
+	select GPIOLIB_IRQCHIP
+	select REGMAP_I2C
+	help
+	  I2C driver for STMicroelectronics Multi-Function eXpander (STMFX)
+	  GPIO expander.
+	  This provides a GPIO interface supporting inputs and outputs,
+	  and configuring push-pull, open-drain, and can also be used as
+	  interrupt-controller.
+
 config PINCTRL_TZ1090
 	bool "Toumaz Xenif TZ1090 pin control driver"
 	depends on SOC_TZ1090
diff --git a/drivers/pinctrl/Makefile b/drivers/pinctrl/Makefile
index d369263..271c464 100644
--- a/drivers/pinctrl/Makefile
+++ b/drivers/pinctrl/Makefile
@@ -43,6 +43,7 @@ obj-$(CONFIG_PINCTRL_LANTIQ)	+= pinctrl-lantiq.o
 obj-$(CONFIG_PINCTRL_LPC18XX)	+= pinctrl-lpc18xx.o
 obj-$(CONFIG_PINCTRL_TB10X)	+= pinctrl-tb10x.o
 obj-$(CONFIG_PINCTRL_ST) 	+= pinctrl-st.o
+obj-$(CONFIG_PINCTRL_STMFX) 	+= pinctrl-stmfx.o
 obj-$(CONFIG_PINCTRL_ZYNQ)	+= pinctrl-zynq.o
 obj-$(CONFIG_PINCTRL_INGENIC)	+= pinctrl-ingenic.o
 obj-$(CONFIG_PINCTRL_RK805)	+= pinctrl-rk805.o
diff --git a/drivers/pinctrl/pinctrl-stmfx.c b/drivers/pinctrl/pinctrl-stmfx.c
new file mode 100644
index 0000000..d59a7bc
--- /dev/null
+++ b/drivers/pinctrl/pinctrl-stmfx.c
@@ -0,0 +1,985 @@
+// SPDX-Licence-Identifier: GPL-2.0
+/*
+ * Driver for STMicroelectronics Multi-Function eXpander (STMFX) GPIO expander
+ *
+ * Copyright (C) 2018 STMicroelectronics
+ * Author(s): Amelie Delaunay <amelie.delaunay@st.com>.
+ */
+#include <linux/bitfield.h>
+#include <linux/gpio.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/pinctrl/pinconf.h>
+#include <linux/pinctrl/pinmux.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+
+#include "core.h"
+#include "pinctrl-utils.h"
+
+/* General */
+#define STMFX_REG_CHIP_ID		0x00 /* R */
+#define STMFX_REG_FW_VERSION_MSB	0x01 /* R */
+#define STMFX_REG_FW_VERSION_LSB	0x02 /* R */
+#define STMFX_REG_SYS_CTRL		0x40 /* RW */
+/* IRQ output management */
+#define STMFX_REG_IRQ_OUT_PIN		0x41 /* RW */
+#define STMFX_REG_IRQ_SRC_EN		0x42 /* RW */
+#define STMFX_REG_IRQ_PENDING		0x08 /* R */
+#define STMFX_REG_IRQ_ACK		0x44 /* RW */
+
+/* MFX boot time is around 10ms, so after reset, we have to wait this delay */
+#define STMFX_BOOT_TIME_MS 10
+
+/* GPIOs expander */
+/* GPIO_STATE1 0x10, GPIO_STATE2 0x11, GPIO_STATE3 0x12 */
+#define STMFX_REG_GPIO_STATE		0x10 /* R */
+/* GPIO_DIR1 0x60, GPIO_DIR2 0x61, GPIO_DIR3 0x63 */
+#define STMFX_REG_GPIO_DIR		0x60 /* RW */
+/* GPIO_TYPE1 0x64, GPIO_TYPE2 0x65, GPIO_TYPE3 0x66 */
+#define STMFX_REG_GPIO_TYPE		0x64 /* RW */
+/* GPIO_PUPD1 0x68, GPIO_PUPD2 0x69, GPIO_PUPD3 0x6A */
+#define STMFX_REG_GPIO_PUPD		0x68 /* RW */
+/* GPO_SET1 0x6C, GPO_SET2 0x6D, GPO_SET3 0x6E */
+#define STMFX_REG_GPO_SET		0x6C /* RW */
+/* GPO_CLR1 0x70, GPO_CLR2 0x71, GPO_CLR3 0x72 */
+#define STMFX_REG_GPO_CLR		0x70 /* RW */
+/* IRQ_GPI_SRC1 0x48, IRQ_GPI_SRC2 0x49, IRQ_GPI_SRC3 0x4A */
+#define STMFX_REG_IRQ_GPI_SRC		0x48 /* RW */
+/* IRQ_GPI_EVT1 0x4C, IRQ_GPI_EVT2 0x4D, IRQ_GPI_EVT3 0x4E */
+#define STMFX_REG_IRQ_GPI_EVT		0x4C /* RW */
+/* IRQ_GPI_TYPE1 0x50, IRQ_GPI_TYPE2 0x51, IRQ_GPI_TYPE3 0x52 */
+#define STMFX_REG_IRQ_GPI_TYPE		0x50 /* RW */
+/* IRQ_GPI_PENDING1 0x0C, IRQ_GPI_PENDING2 0x0D, IRQ_GPI_PENDING3 0x0E*/
+#define STMFX_REG_IRQ_GPI_PENDING	0x0C /* R */
+/* IRQ_GPI_ACK1 0x54, IRQ_GPI_ACK2 0x55, IRQ_GPI_ACK3 0x56 */
+#define STMFX_REG_IRQ_GPI_ACK		0x54 /* RW */
+
+/* STMFX_REG_CHIP_ID bitfields */
+#define STMFX_REG_CHIP_ID_MASK		GENMASK(7, 0)
+
+/* STMFX_REG_SYS_CTRL bitfields */
+#define STMFX_REG_SYS_CTRL_GPIO_EN	BIT(0)
+#define STMFX_REG_SYS_CTRL_ALTGPIO_EN	BIT(3)
+#define STMFX_REG_SYS_CTRL_SWRST	BIT(7)
+
+/* STMFX_REG_IRQ_OUT_PIN bitfields */
+#define STMFX_REG_IRQ_OUT_PIN_TYPE	BIT(0) /* 0-OD 1-PP */
+#define STMFX_REG_IRQ_OUT_PIN_POL	BIT(1) /* 0-active LOW 1-active HIGH */
+
+/* STMFX_REG_IRQ_SRC_EN bitfields */
+#define STMFX_REG_IRQ_SRC_EN_GPIO	BIT(0)
+
+/* STMFX_REG_IRQ_PENDING bitfields */
+#define STMFX_REG_IRQ_PENDING_GPIO	BIT(0)
+
+#define NR_GPIO_REGS			3
+#define NR_GPIOS_PER_REG		8
+#define get_reg(offset)			((offset) / NR_GPIOS_PER_REG)
+#define get_shift(offset)		((offset) % NR_GPIOS_PER_REG)
+#define get_mask(offset)		(BIT(get_shift(offset)))
+
+static const struct pinctrl_pin_desc stmfx_pins[] = {
+	PINCTRL_PIN(0, "gpio0"),
+	PINCTRL_PIN(1, "gpio1"),
+	PINCTRL_PIN(2, "gpio2"),
+	PINCTRL_PIN(3, "gpio3"),
+	PINCTRL_PIN(4, "gpio4"),
+	PINCTRL_PIN(5, "gpio5"),
+	PINCTRL_PIN(6, "gpio6"),
+	PINCTRL_PIN(7, "gpio7"),
+	PINCTRL_PIN(8, "gpio8"),
+	PINCTRL_PIN(9, "gpio9"),
+	PINCTRL_PIN(10, "gpio10"),
+	PINCTRL_PIN(11, "gpio11"),
+	PINCTRL_PIN(12, "gpio12"),
+	PINCTRL_PIN(13, "gpio13"),
+	PINCTRL_PIN(14, "gpio14"),
+	PINCTRL_PIN(15, "gpio15"),
+	PINCTRL_PIN(16, "agpio0"),
+	PINCTRL_PIN(17, "agpio1"),
+	PINCTRL_PIN(18, "agpio2"),
+	PINCTRL_PIN(19, "agpio3"),
+	PINCTRL_PIN(20, "agpio4"),
+	PINCTRL_PIN(21, "agpio5"),
+	PINCTRL_PIN(22, "agpio6"),
+	PINCTRL_PIN(23, "agpio7"),
+};
+
+struct stmfx {
+	struct device *dev;
+	struct regmap *regmap;
+	struct regulator *vdd;
+	struct stmfx_pinctrl *pctl;
+	int irq;
+};
+
+struct stmfx_pinctrl {
+	struct device *dev;
+	struct regmap *regmap;
+	struct pinctrl_dev *pctl_dev;
+	struct pinctrl_desc pctl_desc;
+	struct gpio_chip gpio_chip;
+	struct irq_chip irq_chip;
+	struct mutex lock; /* IRQ bus lock */
+	u8 irq_gpi_src[NR_GPIO_REGS];
+	u8 irq_gpi_type[NR_GPIO_REGS];
+	u8 irq_gpi_evt[NR_GPIO_REGS];
+	u8 irq_toggle_edge[NR_GPIO_REGS];
+#ifdef CONFIG_PM
+	u8 bkp_gpio_state[NR_GPIO_REGS];
+	u8 bkp_gpio_dir[NR_GPIO_REGS];
+	u8 bkp_gpio_type[NR_GPIO_REGS];
+	u8 bkp_gpio_pupd[NR_GPIO_REGS];
+#endif
+};
+
+static int stmfx_gpio_get(struct gpio_chip *gc, unsigned int offset)
+{
+	struct stmfx_pinctrl *pctl = gpiochip_get_data(gc);
+	u32 reg = STMFX_REG_GPIO_STATE + get_reg(offset);
+	u32 mask = get_mask(offset);
+	u32 value;
+	int ret;
+
+	ret = regmap_read(pctl->regmap, reg, &value);
+
+	return ret ? ret : !!(value & mask);
+}
+
+static void stmfx_gpio_set(struct gpio_chip *gc, unsigned int offset, int value)
+{
+	struct stmfx_pinctrl *pctl = gpiochip_get_data(gc);
+	u32 reg = value ? STMFX_REG_GPO_SET : STMFX_REG_GPO_CLR;
+	u32 mask = get_mask(offset);
+
+	regmap_write_bits(pctl->regmap, reg + get_reg(offset), mask, mask);
+}
+
+static int stmfx_gpio_get_direction(struct gpio_chip *gc, unsigned int offset)
+{
+	struct stmfx_pinctrl *pctl = gpiochip_get_data(gc);
+	u32 reg = STMFX_REG_GPIO_DIR + get_reg(offset);
+	u32 mask = get_mask(offset);
+	u32 val;
+	int ret;
+
+	ret = regmap_read(pctl->regmap, reg, &val);
+	/*
+	 * On stmfx, gpio pins direction is (0)input, (1)output.
+	 * .get_direction returns 0=out, 1=in
+	 */
+
+	return ret ? ret : !(val & mask);
+}
+
+static int stmfx_gpio_direction_input(struct gpio_chip *gc, unsigned int offset)
+{
+	struct stmfx_pinctrl *pctl = gpiochip_get_data(gc);
+	u32 reg = STMFX_REG_GPIO_DIR + get_reg(offset);
+	u32 mask = get_mask(offset);
+
+	return regmap_write_bits(pctl->regmap, reg, mask, 0);
+}
+
+static int stmfx_gpio_direction_output(struct gpio_chip *gc,
+				       unsigned int offset, int value)
+{
+	struct stmfx_pinctrl *pctl = gpiochip_get_data(gc);
+	u32 reg = STMFX_REG_GPIO_DIR + get_reg(offset);
+	u32 mask = get_mask(offset);
+
+	stmfx_gpio_set(gc, offset, value);
+
+	return regmap_write_bits(pctl->regmap, reg, mask, mask);
+}
+
+static int stmfx_pinconf_get_pupd(struct stmfx_pinctrl *pctl,
+				  unsigned int offset)
+{
+	u32 reg = STMFX_REG_GPIO_PUPD + get_reg(offset);
+	u32 pupd;
+	int ret;
+
+	ret = regmap_read(pctl->regmap, reg, &pupd);
+	if (ret)
+		return ret;
+
+	return (pupd & get_mask(offset));
+}
+
+static int stmfx_pinconf_set_pupd(struct stmfx_pinctrl *pctl,
+				  unsigned int offset, u32 pupd)
+{
+	u32 reg = STMFX_REG_GPIO_PUPD + get_reg(offset);
+	u32 mask = get_mask(offset);
+
+	return regmap_write_bits(pctl->regmap, reg, mask, pupd ? mask : 0);
+}
+
+static int stmfx_pinconf_get_type(struct stmfx_pinctrl *pctl,
+				  unsigned int offset)
+{
+	u32 reg = STMFX_REG_GPIO_TYPE + get_reg(offset);
+	u32 type;
+	int ret;
+
+	ret = regmap_read(pctl->regmap, reg, &type);
+	if (ret)
+		return 0;
+
+	return (type & get_mask(offset));
+}
+
+static int stmfx_pinconf_set_type(struct stmfx_pinctrl *pctl,
+				  unsigned int offset, u32 type)
+{
+	u32 reg = STMFX_REG_GPIO_TYPE + get_reg(offset);
+	u32 mask = get_mask(offset);
+
+	return regmap_write_bits(pctl->regmap, reg, mask, type ? mask : 0);
+}
+
+static int stmfx_pinconf_get(struct pinctrl_dev *pctldev,
+			     unsigned int pin, unsigned long *config)
+{
+	struct stmfx_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
+	u32 param = pinconf_to_config_param(*config);
+	u32 dir, type, pupd;
+	u32 arg = 0;
+	int ret;
+
+	dir = stmfx_gpio_get_direction(&pctl->gpio_chip, pin);
+	if (dir < 0)
+		return dir;
+	type = stmfx_pinconf_get_type(pctl, pin);
+	if (type < 0)
+		return type;
+	pupd = stmfx_pinconf_get_pupd(pctl, pin);
+	if (pupd < 0)
+		return pupd;
+
+	switch (param) {
+	case PIN_CONFIG_BIAS_DISABLE:
+		if (dir == GPIOF_DIR_OUT) {
+			if (type & pupd)
+				arg = 0;
+			else
+				arg = 1;
+		} else {
+			if (!type)
+				arg = 1;
+		}
+		break;
+	case PIN_CONFIG_BIAS_PULL_DOWN:
+		if (dir == GPIOF_DIR_IN && type && !pupd)
+			arg = 1;
+		break;
+	case PIN_CONFIG_BIAS_PULL_UP:
+		if (type && pupd)
+			arg = 1;
+		break;
+	case PIN_CONFIG_DRIVE_OPEN_DRAIN:
+		if ((dir == GPIOF_DIR_OUT && type) ||
+		    (dir == GPIOF_DIR_IN && !type))
+			arg = 1;
+		break;
+	case PIN_CONFIG_DRIVE_PUSH_PULL:
+		if ((dir == GPIOF_DIR_OUT && !type) ||
+		    (dir == GPIOF_DIR_IN && type))
+			arg = 1;
+		break;
+	case PIN_CONFIG_OUTPUT:
+		if (dir == GPIOF_DIR_IN)
+			return -EINVAL;
+
+		ret = stmfx_gpio_get(&pctl->gpio_chip, pin);
+		if (ret < 0)
+			return ret;
+
+		arg = ret;
+		break;
+	default:
+		return -ENOTSUPP;
+	}
+
+	*config = pinconf_to_config_packed(param, arg);
+
+	return 0;
+}
+
+static int stmfx_pinconf_set(struct pinctrl_dev *pctldev, unsigned int pin,
+			     unsigned long *configs, unsigned int num_configs)
+{
+	struct stmfx_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
+	enum pin_config_param param;
+	u32 arg;
+	int dir, i, ret;
+
+	dir = stmfx_gpio_get_direction(&pctl->gpio_chip, pin);
+	if (dir < 0)
+		return dir;
+
+	for (i = 0; i < num_configs; i++) {
+		param = pinconf_to_config_param(configs[i]);
+		arg = pinconf_to_config_argument(configs[i]);
+
+		switch (param) {
+		case PIN_CONFIG_BIAS_PULL_PIN_DEFAULT:
+		case PIN_CONFIG_BIAS_DISABLE:
+		case PIN_CONFIG_BIAS_PULL_DOWN:
+			ret = stmfx_pinconf_set_pupd(pctl, pin, 0);
+			if (ret)
+				return ret;
+			break;
+		case PIN_CONFIG_BIAS_PULL_UP:
+			ret = stmfx_pinconf_set_pupd(pctl, pin, 1);
+			if (ret)
+				return ret;
+			break;
+		case PIN_CONFIG_DRIVE_OPEN_DRAIN:
+			if (dir == GPIOF_DIR_OUT)
+				ret = stmfx_pinconf_set_type(pctl, pin, 1);
+			else
+				ret = stmfx_pinconf_set_type(pctl, pin, 0);
+			if (ret)
+				return ret;
+			break;
+		case PIN_CONFIG_DRIVE_PUSH_PULL:
+			if (dir == GPIOF_DIR_OUT)
+				ret = stmfx_pinconf_set_type(pctl, pin, 0);
+			else
+				ret = stmfx_pinconf_set_type(pctl, pin, 1);
+			if (ret)
+				return ret;
+			break;
+		case PIN_CONFIG_OUTPUT:
+			ret = stmfx_gpio_direction_output(&pctl->gpio_chip,
+							  pin, arg);
+			if (ret)
+				return ret;
+			break;
+		default:
+			return -ENOTSUPP;
+		}
+	}
+
+	return 0;
+}
+
+static void stmfx_pinconf_dbg_show(struct pinctrl_dev *pctldev,
+				   struct seq_file *s, unsigned int offset)
+{
+	struct stmfx_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
+	int dir, type, pupd, val;
+
+	dir = stmfx_gpio_get_direction(&pctl->gpio_chip, offset);
+	if (dir < 0)
+		return;
+	type = stmfx_pinconf_get_type(pctl, offset);
+	if (type < 0)
+		return;
+	pupd = stmfx_pinconf_get_pupd(pctl, offset);
+	if (pupd < 0)
+		return;
+	val = stmfx_gpio_get(&pctl->gpio_chip, offset);
+	if (val < 0)
+		return;
+
+	if (dir == GPIOF_DIR_IN) {
+		seq_printf(s, "input %s ", val ? "high" : "low");
+		if (type)
+			seq_printf(s, "with internal pull-%s ",
+				   pupd ? "up" : "down");
+		else
+			seq_printf(s, "%s ", pupd ? "floating" : "analog");
+	} else {
+		seq_printf(s, "output %s ", val ? "high" : "low");
+		if (type)
+			seq_printf(s, "open drain %s internal pull-up ",
+				   pupd ? "with" : "without");
+		else
+			seq_puts(s, "push pull no pull ");
+	}
+}
+
+static const struct pinconf_ops stmfx_pinconf_ops = {
+	.pin_config_get		= stmfx_pinconf_get,
+	.pin_config_set		= stmfx_pinconf_set,
+	.pin_config_dbg_show	= stmfx_pinconf_dbg_show,
+};
+
+static int stmfx_pinctrl_get_groups_count(struct pinctrl_dev *pctldev)
+{
+	return 0;
+}
+
+static const char *stmfx_pinctrl_get_group_name(struct pinctrl_dev *pctldev,
+						unsigned int selector)
+{
+	return NULL;
+}
+
+static int stmfx_pinctrl_get_group_pins(struct pinctrl_dev *pctldev,
+					unsigned int selector,
+					const unsigned int **pins,
+					unsigned int *num_pins)
+{
+	return -ENOTSUPP;
+}
+
+static const struct pinctrl_ops stmfx_pinctrl_ops = {
+	.get_groups_count = stmfx_pinctrl_get_groups_count,
+	.get_group_name = stmfx_pinctrl_get_group_name,
+	.get_group_pins = stmfx_pinctrl_get_group_pins,
+	.dt_node_to_map = pinconf_generic_dt_node_to_map_pin,
+	.dt_free_map = pinctrl_utils_free_map,
+};
+
+static void stmfx_gpio_irq_mask(struct irq_data *data)
+{
+	struct gpio_chip *gpio_chip = irq_data_get_irq_chip_data(data);
+	struct stmfx_pinctrl *pctl = gpiochip_get_data(gpio_chip);
+	u32 reg = get_reg(data->hwirq);
+	u32 mask = get_mask(data->hwirq);
+
+	pctl->irq_gpi_src[reg] &= ~mask;
+}
+
+static void stmfx_gpio_irq_unmask(struct irq_data *data)
+{
+	struct gpio_chip *gpio_chip = irq_data_get_irq_chip_data(data);
+	struct stmfx_pinctrl *pctl = gpiochip_get_data(gpio_chip);
+	u32 reg = get_reg(data->hwirq);
+	u32 mask = get_mask(data->hwirq);
+
+	pctl->irq_gpi_src[reg] |= mask;
+}
+
+static int stmfx_gpio_irq_set_type(struct irq_data *data,
+				   unsigned int type)
+{
+	struct gpio_chip *gpio_chip = irq_data_get_irq_chip_data(data);
+	struct stmfx_pinctrl *pctl = gpiochip_get_data(gpio_chip);
+	u32 reg = get_reg(data->hwirq);
+	u32 mask = get_mask(data->hwirq);
+
+	if (type & IRQ_TYPE_NONE)
+		return -EINVAL;
+
+	if (type & IRQ_TYPE_EDGE_BOTH) {
+		pctl->irq_gpi_evt[reg] |= mask;
+		irq_set_handler_locked(data, handle_edge_irq);
+	} else {
+		pctl->irq_gpi_evt[reg] &= ~mask;
+		irq_set_handler_locked(data, handle_level_irq);
+	}
+
+	if ((type & IRQ_TYPE_EDGE_RISING) || (type & IRQ_TYPE_LEVEL_HIGH))
+		pctl->irq_gpi_type[reg] |= mask;
+	else
+		pctl->irq_gpi_type[reg] &= ~mask;
+
+	/*
+	 * In case of (type & IRQ_TYPE_EDGE_BOTH), we need to know current
+	 * GPIO value to set the right edge trigger. But in atomic context
+	 * here we can't access registers over I2C. That's why (type &
+	 * IRQ_TYPE_EDGE_BOTH) will be managed in .irq_sync_unlock.
+	 */
+
+	if ((type & IRQ_TYPE_EDGE_BOTH) == IRQ_TYPE_EDGE_BOTH)
+		pctl->irq_toggle_edge[reg] |= mask;
+	else
+		pctl->irq_toggle_edge[reg] &= mask;
+
+	return 0;
+}
+
+static void stmfx_gpio_irq_bus_lock(struct irq_data *data)
+{
+	struct gpio_chip *gpio_chip = irq_data_get_irq_chip_data(data);
+	struct stmfx_pinctrl *pctl = gpiochip_get_data(gpio_chip);
+
+	mutex_lock(&pctl->lock);
+}
+
+static void stmfx_gpio_irq_bus_sync_unlock(struct irq_data *data)
+{
+	struct gpio_chip *gpio_chip = irq_data_get_irq_chip_data(data);
+	struct stmfx_pinctrl *pctl = gpiochip_get_data(gpio_chip);
+	u32 reg = get_reg(data->hwirq);
+	u32 mask = get_mask(data->hwirq);
+
+	/*
+	 * In case of IRQ_TYPE_EDGE_BOTH), read the current GPIO value
+	 * (this couldn't be done in .irq_set_type because of atomic context)
+	 * to set the right irq trigger type.
+	 */
+	if (pctl->irq_toggle_edge[reg] & mask) {
+		if (stmfx_gpio_get(gpio_chip, data->hwirq))
+			pctl->irq_gpi_type[reg] &= ~mask;
+		else
+			pctl->irq_gpi_type[reg] |= mask;
+	}
+
+	regmap_bulk_write(pctl->regmap, STMFX_REG_IRQ_GPI_EVT,
+			  pctl->irq_gpi_evt, NR_GPIO_REGS);
+	regmap_bulk_write(pctl->regmap, STMFX_REG_IRQ_GPI_TYPE,
+			  pctl->irq_gpi_type, NR_GPIO_REGS);
+	regmap_bulk_write(pctl->regmap, STMFX_REG_IRQ_GPI_SRC,
+			  pctl->irq_gpi_src, NR_GPIO_REGS);
+
+	/*
+	 * If at least one GPIO irq is enabled among the 24 available,
+	 * enable global GPIO irq
+	 */
+	if (*(u32 *)pctl->irq_gpi_src & GENMASK(23, 0))
+		regmap_write_bits(pctl->regmap, STMFX_REG_IRQ_SRC_EN,
+				  STMFX_REG_IRQ_SRC_EN_GPIO,
+				  STMFX_REG_IRQ_SRC_EN_GPIO);
+	else
+		regmap_write_bits(pctl->regmap, STMFX_REG_IRQ_SRC_EN,
+				  STMFX_REG_IRQ_SRC_EN_GPIO, 0);
+
+	mutex_unlock(&pctl->lock);
+}
+
+static void stmfx_gpio_irq_toggle_trigger(struct stmfx_pinctrl *pctl,
+					  unsigned int offset)
+{
+	u32 reg = get_reg(offset);
+	u32 mask = get_mask(offset);
+	int val;
+
+	if (!(pctl->irq_toggle_edge[reg] & mask))
+		return;
+
+	val = stmfx_gpio_get(&pctl->gpio_chip, offset);
+	if (val < 0)
+		return;
+
+	if (val) {
+		pctl->irq_gpi_type[reg] &= mask;
+		regmap_write_bits(pctl->regmap, STMFX_REG_IRQ_GPI_TYPE + reg,
+				  get_mask(offset), 0);
+
+	} else {
+		pctl->irq_gpi_type[reg] |= mask;
+		regmap_write_bits(pctl->regmap, STMFX_REG_IRQ_GPI_TYPE + reg,
+				  get_mask(offset), get_mask(offset));
+	}
+}
+
+static irqreturn_t stmfx_gpio_irq_thread_fn(int irq, void *dev_id)
+{
+	struct stmfx_pinctrl *pctl = (struct stmfx_pinctrl *)dev_id;
+	struct gpio_chip *gc = &pctl->gpio_chip;
+	u8 pending[NR_GPIO_REGS];
+	unsigned long n, status;
+	int ret;
+
+	ret = regmap_bulk_read(pctl->regmap, STMFX_REG_IRQ_GPI_PENDING,
+			       &pending, NR_GPIO_REGS);
+	if (ret)
+		return IRQ_NONE;
+
+	ret = regmap_bulk_write(pctl->regmap, STMFX_REG_IRQ_GPI_ACK,
+				pending, NR_GPIO_REGS);
+	if (ret)
+		return IRQ_NONE;
+
+	status = *(unsigned long *)pending;
+	for_each_set_bit(n, &status, gc->ngpio) {
+		handle_nested_irq(irq_find_mapping(gc->irq.domain, n));
+		stmfx_gpio_irq_toggle_trigger(pctl, n);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int stmfx_gpio_irq_init(struct stmfx_pinctrl *pctl, int irq)
+{
+	u32 irqtrigger;
+	int ret;
+
+	irqtrigger = irq_get_trigger_type(irq);
+	ret = devm_request_threaded_irq(pctl->dev, irq, NULL,
+					stmfx_gpio_irq_thread_fn,
+					irqtrigger | IRQF_ONESHOT | IRQF_SHARED,
+					pctl->irq_chip.name, pctl);
+	if (ret) {
+		dev_err(pctl->dev, "cannot request irq%d\n", irq);
+		return ret;
+	}
+
+	pctl->irq_chip.name = "stmfxgpio";
+	pctl->irq_chip.irq_mask = stmfx_gpio_irq_mask;
+	pctl->irq_chip.irq_unmask = stmfx_gpio_irq_unmask;
+	pctl->irq_chip.irq_set_type = stmfx_gpio_irq_set_type;
+	pctl->irq_chip.irq_bus_lock = stmfx_gpio_irq_bus_lock;
+	pctl->irq_chip.irq_bus_sync_unlock = stmfx_gpio_irq_bus_sync_unlock;
+
+	ret = gpiochip_irqchip_add_nested(&pctl->gpio_chip, &pctl->irq_chip,
+					  0, handle_simple_irq, IRQ_TYPE_NONE);
+	if (ret) {
+		dev_err(pctl->dev, "cannot add irqchip to gpiochip\n");
+		return ret;
+	}
+
+	gpiochip_set_nested_irqchip(&pctl->gpio_chip, &pctl->irq_chip, irq);
+
+	return 0;
+}
+
+static int stmfx_gpio_function_enable(struct stmfx *stmfx, u32 npins)
+{
+	u32 mask = STMFX_REG_SYS_CTRL_GPIO_EN;
+
+	if (npins > 16)
+		mask += STMFX_REG_SYS_CTRL_ALTGPIO_EN;
+
+	return regmap_write_bits(stmfx->regmap, STMFX_REG_SYS_CTRL, mask, mask);
+}
+
+static int stmfx_gpio_init(struct stmfx *stmfx, struct device_node *np)
+{
+	struct stmfx_pinctrl *pctl;
+	int ret;
+
+	pctl = devm_kzalloc(stmfx->dev, sizeof(*pctl), GFP_KERNEL);
+	if (!pctl)
+		return -ENOMEM;
+
+	pctl->dev = stmfx->dev;
+	pctl->regmap = stmfx->regmap;
+	stmfx->pctl = pctl;
+
+	mutex_init(&pctl->lock);
+
+	/* Register pin controller */
+	pctl->pctl_desc.name = "stmfx-pinctrl";
+	pctl->pctl_desc.pctlops = &stmfx_pinctrl_ops;
+	pctl->pctl_desc.confops = &stmfx_pinconf_ops;
+	pctl->pctl_desc.pins = stmfx_pins;
+	pctl->pctl_desc.npins = ARRAY_SIZE(stmfx_pins);
+	pctl->pctl_desc.owner = THIS_MODULE;
+
+	ret = devm_pinctrl_register_and_init(pctl->dev, &pctl->pctl_desc,
+					     pctl, &pctl->pctl_dev);
+	if (ret) {
+		dev_err(pctl->dev, "pinctrl registration failed\n");
+		return ret;
+	}
+
+	ret = pinctrl_enable(pctl->pctl_dev);
+	if (ret) {
+		dev_err(pctl->dev, "pinctrl enable failed\n");
+		return ret;
+	}
+
+	/* Register gpio controller */
+	pctl->gpio_chip.label = "stmfx-gpio";
+	pctl->gpio_chip.parent = pctl->dev;
+	pctl->gpio_chip.get_direction = stmfx_gpio_get_direction;
+	pctl->gpio_chip.direction_input = stmfx_gpio_direction_input;
+	pctl->gpio_chip.direction_output = stmfx_gpio_direction_output;
+	pctl->gpio_chip.get = stmfx_gpio_get;
+	pctl->gpio_chip.set = stmfx_gpio_set;
+	pctl->gpio_chip.set_config = gpiochip_generic_config;
+	pctl->gpio_chip.base = -1;
+	pctl->gpio_chip.ngpio = pctl->pctl_desc.npins;
+	pctl->gpio_chip.can_sleep = true;
+	pctl->gpio_chip.of_node = np;
+
+	ret = stmfx_gpio_irq_init(pctl, stmfx->irq);
+	if (ret)
+		return ret;
+
+	ret = devm_gpiochip_add_data(pctl->dev, &pctl->gpio_chip, pctl);
+	if (ret) {
+		dev_err(pctl->dev, "gpio_chip registration failed\n");
+		return ret;
+	}
+
+	if (!of_find_property(np, "gpio-ranges", NULL)) {
+		ret = gpiochip_add_pin_range(&pctl->gpio_chip,
+					     dev_name(pctl->dev),
+					     0, 0, pctl->pctl_desc.npins);
+		if (ret)
+			return ret;
+	}
+
+	ret = stmfx_gpio_function_enable(stmfx, pctl->gpio_chip.ngpio);
+	if (ret)
+		return ret;
+
+	dev_info(pctl->dev, "%d GPIOs available\n", pctl->gpio_chip.ngpio);
+
+	return 0;
+}
+
+static int stmfx_irq_init(struct stmfx *stmfx)
+{
+	u32 irqoutpin = 0, irqtrigger;
+
+	if (stmfx->irq < 0) {
+		dev_err(stmfx->dev, "failed to get irq: %d\n", stmfx->irq);
+		return stmfx->irq;
+	}
+
+	if (!of_property_read_bool(stmfx->dev->of_node, "drive-open-drain"))
+		irqoutpin |= STMFX_REG_IRQ_OUT_PIN_TYPE;
+
+	irqtrigger = irq_get_trigger_type(stmfx->irq);
+	if ((irqtrigger & IRQ_TYPE_EDGE_RISING) ||
+	    (irqtrigger & IRQ_TYPE_LEVEL_HIGH))
+		irqoutpin |= STMFX_REG_IRQ_OUT_PIN_POL;
+
+	return regmap_write(stmfx->regmap, STMFX_REG_IRQ_OUT_PIN, irqoutpin);
+}
+
+static int stmfx_chip_reset(struct stmfx *stmfx)
+{
+	int ret;
+
+	ret = regmap_update_bits(stmfx->regmap, STMFX_REG_SYS_CTRL,
+				 STMFX_REG_SYS_CTRL_SWRST,
+				 STMFX_REG_SYS_CTRL_SWRST);
+	if (ret)
+		return ret;
+
+	msleep(STMFX_BOOT_TIME_MS);
+
+	return ret;
+}
+
+static int stmfx_chip_init(struct stmfx *stmfx, struct i2c_client *client)
+{
+	u32 id;
+	u8 version[2];
+	int ret;
+
+	stmfx->vdd = devm_regulator_get_optional(stmfx->dev, "vdd");
+	if (IS_ERR(stmfx->vdd)) {
+		ret = PTR_ERR(stmfx->vdd);
+		if (ret != -ENODEV) {
+			if (ret != -EPROBE_DEFER)
+				dev_err(stmfx->dev,
+					"no vdd regulator found:%d\n", ret);
+			return ret;
+		}
+	}
+
+	if (!IS_ERR(stmfx->vdd)) {
+		ret = regulator_enable(stmfx->vdd);
+		if (ret) {
+			dev_err(stmfx->dev, "vdd enable failed: %d\n", ret);
+			return ret;
+		}
+	}
+
+	ret = regmap_read(stmfx->regmap, STMFX_REG_CHIP_ID, &id);
+	if (ret) {
+		dev_err(stmfx->dev, "error reading chip id: %d\n", ret);
+		return ret;
+	}
+
+	/*
+	 * Check that ID is the complement of the I2C address:
+	 * STMFX I2C address follows the 7-bit format (MSB), that's why
+	 * client->addr is shifted.
+	 *
+	 * STMFX_I2C_ADDR|       STMFX         |        Linux
+	 *   input pin   | I2C device address  | I2C device address
+	 *---------------------------------------------------------
+	 *       0       | b: 1000 010x h:0x84 |       0x42
+	 *       1       | b: 1000 011x h:0x86 |       0x43
+	 */
+	if (FIELD_GET(STMFX_REG_CHIP_ID_MASK, ~id) != (client->addr << 1)) {
+		dev_err(stmfx->dev, "unknown chip id: %#x\n", id);
+		return -EINVAL;
+	}
+
+	ret = regmap_bulk_read(stmfx->regmap, STMFX_REG_FW_VERSION_MSB,
+			       version, ARRAY_SIZE(version));
+	if (ret) {
+		dev_err(stmfx->dev, "error reading fw version: %d\n", ret);
+		return ret;
+	}
+
+	dev_info(stmfx->dev, "STMFX id: %#x, fw version: %x.%02x\n",
+		 id, version[0], version[1]);
+
+	return stmfx_chip_reset(stmfx);
+}
+
+static void stmfx_chip_exit(struct stmfx *stmfx)
+{
+	regmap_write(stmfx->regmap, STMFX_REG_IRQ_SRC_EN, 0);
+	regmap_write(stmfx->regmap, STMFX_REG_SYS_CTRL, 0);
+
+	if (!IS_ERR(stmfx->vdd))
+		regulator_disable(stmfx->vdd);
+}
+
+static const struct regmap_config stmfx_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+};
+
+static int stmfx_probe(struct i2c_client *client,
+		       const struct i2c_device_id *id)
+{
+	struct device_node *np = client->dev.of_node, *child;
+	struct stmfx *stmfx;
+	int ret;
+
+	stmfx = devm_kzalloc(&client->dev, sizeof(*stmfx), GFP_KERNEL);
+	if (!stmfx)
+		return -ENOMEM;
+
+	i2c_set_clientdata(client, stmfx);
+
+	stmfx->dev = &client->dev;
+
+	stmfx->regmap = devm_regmap_init_i2c(client, &stmfx_regmap_config);
+	if (IS_ERR(stmfx->regmap)) {
+		ret = PTR_ERR(stmfx->regmap);
+		dev_err(stmfx->dev,
+			"Failed to allocate register map: %d\n", ret);
+		return ret;
+	}
+
+	ret = stmfx_chip_init(stmfx, client);
+	if (ret) {
+		if (ret == -ETIMEDOUT)
+			return -EPROBE_DEFER;
+		return ret;
+	}
+
+	stmfx->irq = client->irq;
+	ret = stmfx_irq_init(stmfx);
+	if (ret)
+		return ret;
+
+	for_each_available_child_of_node(np, child) {
+		if (of_property_read_bool(child, "gpio-controller")) {
+			ret = stmfx_gpio_init(stmfx, child);
+			if (ret)
+				goto err;
+		}
+	}
+
+	return 0;
+
+err:
+	stmfx_chip_exit(stmfx);
+
+	return ret;
+}
+
+static int stmfx_remove(struct i2c_client *client)
+{
+	struct stmfx *stmfx = i2c_get_clientdata(client);
+
+	stmfx_chip_exit(stmfx);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static void stmfx_gpio_backup_regs(struct stmfx_pinctrl *pctl)
+{
+	regmap_bulk_read(pctl->regmap, STMFX_REG_GPIO_STATE,
+			 &pctl->bkp_gpio_state, NR_GPIO_REGS);
+	regmap_bulk_read(pctl->regmap, STMFX_REG_GPIO_DIR,
+			 &pctl->bkp_gpio_dir, NR_GPIO_REGS);
+	regmap_bulk_read(pctl->regmap, STMFX_REG_GPIO_TYPE,
+			 &pctl->bkp_gpio_type, NR_GPIO_REGS);
+	regmap_bulk_read(pctl->regmap, STMFX_REG_GPIO_PUPD,
+			 &pctl->bkp_gpio_pupd, NR_GPIO_REGS);
+}
+
+static void stmfx_gpio_restore_regs(struct stmfx_pinctrl *pctl)
+{
+	regmap_bulk_write(pctl->regmap, STMFX_REG_GPIO_STATE,
+			  pctl->bkp_gpio_state, NR_GPIO_REGS);
+	regmap_bulk_write(pctl->regmap, STMFX_REG_GPIO_DIR,
+			  pctl->bkp_gpio_dir, NR_GPIO_REGS);
+	regmap_bulk_write(pctl->regmap, STMFX_REG_GPIO_TYPE,
+			  pctl->bkp_gpio_type, NR_GPIO_REGS);
+	regmap_bulk_write(pctl->regmap, STMFX_REG_GPIO_PUPD,
+			  pctl->bkp_gpio_pupd, NR_GPIO_REGS);
+
+	regmap_bulk_write(pctl->regmap, STMFX_REG_IRQ_GPI_EVT,
+			  pctl->irq_gpi_evt, NR_GPIO_REGS);
+	regmap_bulk_write(pctl->regmap, STMFX_REG_IRQ_GPI_TYPE,
+			  pctl->irq_gpi_type, NR_GPIO_REGS);
+	regmap_bulk_write(pctl->regmap, STMFX_REG_IRQ_GPI_SRC,
+			  pctl->irq_gpi_src, NR_GPIO_REGS);
+
+	/*
+	 * If at least one GPIO irq is enabled among the 24 available,
+	 * enable global GPIO irq
+	 */
+	if (*(u32 *)pctl->irq_gpi_src & GENMASK(23, 0))
+		regmap_write_bits(pctl->regmap, STMFX_REG_IRQ_SRC_EN,
+				  STMFX_REG_IRQ_SRC_EN_GPIO,
+				  STMFX_REG_IRQ_SRC_EN_GPIO);
+}
+
+static int stmfx_suspend(struct device *dev)
+{
+	struct stmfx *stmfx = dev_get_drvdata(dev);
+
+	stmfx_gpio_backup_regs(stmfx->pctl);
+
+	if (!IS_ERR(stmfx->vdd))
+		regulator_disable(stmfx->vdd);
+
+	return 0;
+}
+
+static int stmfx_resume(struct device *dev)
+{
+	struct stmfx *stmfx = dev_get_drvdata(dev);
+
+	if (!IS_ERR(stmfx->vdd))
+		regulator_enable(stmfx->vdd);
+
+	/* Restore IRQ_OUT_PIN register */
+	stmfx_irq_init(stmfx);
+
+	/* Restore SYS_CTRL register */
+	stmfx_gpio_function_enable(stmfx, stmfx->pctl->gpio_chip.ngpio);
+
+	/* Restore all GPIO expander function relative registers */
+	stmfx_gpio_restore_regs(stmfx->pctl);
+
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(stmfx_dev_pm_ops, stmfx_suspend, stmfx_resume);
+
+static const struct of_device_id stmfx_of_match[] = {
+	{ .compatible = "st,stmfx-0300", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, stmfx_of_match);
+
+static struct i2c_driver stmfx_driver = {
+	.driver = {
+		.name = "stmfx-pinctrl",
+		.of_match_table = of_match_ptr(stmfx_of_match),
+		.pm = &stmfx_dev_pm_ops,
+	},
+	.probe = stmfx_probe,
+	.remove = stmfx_remove,
+};
+module_i2c_driver(stmfx_driver);
+
+MODULE_DESCRIPTION("STMFX pinctrl/GPIO driver");
+MODULE_AUTHOR("Amelie Delaunay <amelie.delaunay@st.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4
