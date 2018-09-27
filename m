Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3392DC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 11:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5C54215E5
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 11:41:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5C54215E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbeI0R7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 13:59:17 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:16663 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727340AbeI0R7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 13:59:16 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w8RBXvcb003809;
        Thu, 27 Sep 2018 13:40:16 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx08-00178001.pphosted.com with ESMTP id 2mqd47qxpb-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 27 Sep 2018 13:40:16 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 65C6034;
        Thu, 27 Sep 2018 11:40:15 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas22.st.com [10.75.90.92])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 38CAC2986;
        Thu, 27 Sep 2018 11:40:15 +0000 (GMT)
Received: from SAFEX1HUBCAS24.st.com (10.75.90.95) by Safex1hubcas22.st.com
 (10.75.90.92) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 27 Sep
 2018 13:40:15 +0200
Received: from localhost (10.201.20.5) by webmail-ga.st.com (10.75.90.48) with
 Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 27 Sep 2018 13:40:14 +0200
From:   Amelie Delaunay <amelie.delaunay@st.com>
To:     Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        "Maxime Coquelin" <mcoquelin.stm32@gmail.com>
CC:     <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH v3 2/7] mfd: Add ST Multi-Function eXpander (STMFX) core driver
Date:   Thu, 27 Sep 2018 13:39:59 +0200
Message-ID: <1538048404-9041-3-git-send-email-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1538048404-9041-1-git-send-email-amelie.delaunay@st.com>
References: <1538048404-9041-1-git-send-email-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.5]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-27_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

STMicroelectronics Multi-Function eXpander (STMFX) is a slave controller
using I2C for communication with the main MCU. Main features are:
- 16 fast GPIOs individually configurable in input/output
- 8 alternate GPIOs individually configurable in input/output when other
STMFX functions are not used
- Main MCU IDD measurement
- Resistive touchscreen controller

Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mfd/Kconfig       |  14 ++
 drivers/mfd/Makefile      |   2 +-
 drivers/mfd/stmfx.c       | 626 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/stmfx.h |  27 ++
 4 files changed, 668 insertions(+), 1 deletion(-)
 create mode 100644 drivers/mfd/stmfx.c
 create mode 100644 include/linux/mfd/stmfx.h

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index f3a5f8d..8c41342 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1862,6 +1862,20 @@ config MFD_STM32_TIMERS
 	  for PWM and IIO Timer. This driver allow to share the
 	  registers between the others drivers.
 
+config MFD_STMFX
+	tristate "Support for STMicroelectronics Multi-Function eXpander (STMFX)"
+	depends on I2C
+	depends on OF || COMPILE_TEST
+	select MFD_CORE
+	select REGMAP_I2C
+	help
+	  Support for the STMicroelectronics Multi-Function eXpander.
+
+	  This driver provides common support for accessing the device,
+	  additional drivers must be enabled in order to use the functionality
+	  of the device.
+
+
 menu "Multimedia Capabilities Port drivers"
 	depends on ARCH_SA1100
 
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 5856a94..282323b 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -240,4 +240,4 @@ obj-$(CONFIG_MFD_MXS_LRADC)     += mxs-lradc.o
 obj-$(CONFIG_MFD_SC27XX_PMIC)	+= sprd-sc27xx-spi.o
 obj-$(CONFIG_RAVE_SP_CORE)	+= rave-sp.o
 obj-$(CONFIG_MFD_ROHM_BD718XX)	+= rohm-bd718x7.o
-
+obj-$(CONFIG_MFD_STMFX) 	+= stmfx.o
diff --git a/drivers/mfd/stmfx.c b/drivers/mfd/stmfx.c
new file mode 100644
index 0000000..cfd4fca
--- /dev/null
+++ b/drivers/mfd/stmfx.c
@@ -0,0 +1,626 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for STMicroelectronics Multi-Function eXpander (STMFX) core
+ *
+ * Copyright (C) 2018 STMicroelectronics
+ * Author(s): Amelie Delaunay <amelie.delaunay@st.com>.
+ */
+#include <linux/bitfield.h>
+#include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/stmfx.h>
+#include <linux/module.h>
+#include <linux/regulator/consumer.h>
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
+/* GPIO management */
+#define STMFX_REG_IRQ_GPI_PENDING1	0x0C /* R */
+#define STMFX_REG_IRQ_GPI_PENDING2	0x0D /* R */
+#define STMFX_REG_IRQ_GPI_PENDING3	0x0E /* R */
+#define STMFX_REG_GPIO_STATE1		0x10 /* R */
+#define STMFX_REG_GPIO_STATE2		0x11 /* R */
+#define STMFX_REG_GPIO_STATE3		0x12 /* R */
+#define STMFX_REG_IRQ_GPI_SRC1		0x48 /* RW */
+#define STMFX_REG_IRQ_GPI_SRC2		0x49 /* RW */
+#define STMFX_REG_IRQ_GPI_SRC3		0x4A /* RW */
+#define STMFX_REG_GPO_SET1		0x6C /* RW */
+#define STMFX_REG_GPO_SET2		0x6D /* RW */
+#define STMFX_REG_GPO_SET3		0x6E /* RW */
+#define STMFX_REG_GPO_CLR1		0x70 /* RW */
+#define STMFX_REG_GPO_CLR2		0x71 /* RW */
+#define STMFX_REG_GPO_CLR3		0x72 /* RW */
+
+#define STMFX_REG_MAX			0xB0
+
+/* MFX boot time is around 10ms, so after reset, we have to wait this delay */
+#define STMFX_BOOT_TIME_MS 10
+
+/* STMFX_REG_CHIP_ID bitfields */
+#define STMFX_REG_CHIP_ID_MASK		GENMASK(7, 0)
+
+/* STMFX_REG_SYS_CTRL bitfields */
+#define STMFX_REG_SYS_CTRL_GPIO_EN	BIT(0)
+#define STMFX_REG_SYS_CTRL_TS_EN	BIT(1)
+#define STMFX_REG_SYS_CTRL_IDD_EN	BIT(2)
+#define STMFX_REG_SYS_CTRL_ALTGPIO_EN	BIT(3)
+#define STMFX_REG_SYS_CTRL_SWRST	BIT(7)
+
+/* STMFX_REG_IRQ_OUT_PIN bitfields */
+#define STMFX_REG_IRQ_OUT_PIN_TYPE	BIT(0) /* 0-OD 1-PP */
+#define STMFX_REG_IRQ_OUT_PIN_POL	BIT(1) /* 0-active LOW 1-active HIGH */
+
+/* STMFX_REG_IRQ_(SRC_EN/PENDING/ACK) bit shift */
+enum stmfx_irqs {
+	STMFX_REG_IRQ_SRC_EN_GPIO = 0,
+	STMFX_REG_IRQ_SRC_EN_IDD,
+	STMFX_REG_IRQ_SRC_EN_ERROR,
+	STMFX_REG_IRQ_SRC_EN_TS_DET,
+	STMFX_REG_IRQ_SRC_EN_TS_NE,
+	STMFX_REG_IRQ_SRC_EN_TS_TH,
+	STMFX_REG_IRQ_SRC_EN_TS_FULL,
+	STMFX_REG_IRQ_SRC_EN_TS_OVF,
+	STMFX_REG_IRQ_SRC_MAX,
+};
+
+/**
+ * struct stmfx_ddata - STMFX MFD private structure
+ * @stmfx:		state holder with device for logs and register map
+ * @vdd:		STMFX power supply
+ * @irq_domain:		IRQ domain
+ * @lock:		IRQ bus lock
+ * @irq_src:		cache of IRQ_SRC_EN register for bus_lock
+ * @bkp_sysctrl:	backup of SYS_CTRL register for suspend/resume
+ * @bkp_irqoutpin:	backup of IRQ_OUT_PIN register for suspend/resume
+ */
+struct stmfx_ddata {
+	struct stmfx *stmfx;
+	struct regulator *vdd;
+	struct irq_domain *irq_domain;
+	struct mutex lock; /* IRQ bus lock */
+	u8 irq_src;
+#ifdef CONFIG_PM
+	u8 bkp_sysctrl;
+	u8 bkp_irqoutpin;
+#endif
+};
+
+static u8 stmfx_func_to_mask(u32 func)
+{
+	u8 mask = 0;
+
+	if (func & STMFX_FUNC_GPIO)
+		mask |= STMFX_REG_SYS_CTRL_GPIO_EN;
+
+	if ((func & STMFX_FUNC_ALTGPIO_LOW) || (func & STMFX_FUNC_ALTGPIO_HIGH))
+		mask |= STMFX_REG_SYS_CTRL_ALTGPIO_EN;
+
+	if (func & STMFX_FUNC_TS)
+		mask |= STMFX_REG_SYS_CTRL_TS_EN;
+
+	if (func & STMFX_FUNC_IDD)
+		mask |= STMFX_REG_SYS_CTRL_IDD_EN;
+
+	return mask;
+}
+
+int stmfx_function_enable(struct stmfx *stmfx, u32 func)
+{
+	u32 sys_ctrl;
+	u8 mask;
+	int ret;
+
+	ret = regmap_read(stmfx->map, STMFX_REG_SYS_CTRL, &sys_ctrl);
+	if (ret)
+		return ret;
+
+	/*
+	 * IDD and TS have priority in STMFX FW, so if IDD and TS are enabled,
+	 * ALTGPIO function is disabled by STMFX FW. If IDD or TS is enabled,
+	 * the number of aGPIO available decreases. To avoid GPIO management
+	 * disturbance, abort IDD or TS function enable in this case.
+	 */
+	if (((func & STMFX_FUNC_IDD) || (func & STMFX_FUNC_TS)) &&
+	    (sys_ctrl & STMFX_REG_SYS_CTRL_ALTGPIO_EN)) {
+		dev_err(stmfx->dev, "ALTGPIO function already enabled\n");
+		return -EBUSY;
+	}
+
+	/* If TS is enabled, aGPIO[3:0] cannot be used */
+	if ((func & STMFX_FUNC_ALTGPIO_LOW) &&
+	    (sys_ctrl & STMFX_REG_SYS_CTRL_TS_EN)) {
+		dev_err(stmfx->dev, "TS in use, aGPIO[3:0] unavailable\n");
+		return -EBUSY;
+	}
+
+	/* If IDD is enabled, aGPIO[7:4] cannot be used */
+	if ((func & STMFX_FUNC_ALTGPIO_HIGH) &&
+	    (sys_ctrl & STMFX_REG_SYS_CTRL_IDD_EN)) {
+		dev_err(stmfx->dev, "IDD in use, aGPIO[7:4] unavailable\n");
+		return -EBUSY;
+	}
+
+	mask = stmfx_func_to_mask(func);
+
+	return regmap_update_bits(stmfx->map, STMFX_REG_SYS_CTRL, mask, mask);
+}
+EXPORT_SYMBOL_GPL(stmfx_function_enable);
+
+int stmfx_function_disable(struct stmfx *stmfx, u32 func)
+{
+	u8 mask = stmfx_func_to_mask(func);
+
+	return regmap_update_bits(stmfx->map, STMFX_REG_SYS_CTRL, mask, 0);
+}
+EXPORT_SYMBOL_GPL(stmfx_function_disable);
+
+static void stmfx_irq_bus_lock(struct irq_data *data)
+{
+	struct stmfx_ddata *ddata = irq_data_get_irq_chip_data(data);
+
+	mutex_lock(&ddata->lock);
+}
+
+static void stmfx_irq_bus_sync_unlock(struct irq_data *data)
+{
+	struct stmfx_ddata *ddata = irq_data_get_irq_chip_data(data);
+
+	regmap_write(ddata->stmfx->map, STMFX_REG_IRQ_SRC_EN, ddata->irq_src);
+
+	mutex_unlock(&ddata->lock);
+}
+
+static void stmfx_irq_mask(struct irq_data *data)
+{
+	struct stmfx_ddata *ddata = irq_data_get_irq_chip_data(data);
+
+	ddata->irq_src &= ~BIT(data->hwirq % 8);
+}
+
+static void stmfx_irq_unmask(struct irq_data *data)
+{
+	struct stmfx_ddata *ddata = irq_data_get_irq_chip_data(data);
+
+	ddata->irq_src |= BIT(data->hwirq % 8);
+}
+
+static struct irq_chip stmfx_irq_chip = {
+	.name			= "stmfx-core",
+	.irq_bus_lock		= stmfx_irq_bus_lock,
+	.irq_bus_sync_unlock	= stmfx_irq_bus_sync_unlock,
+	.irq_mask		= stmfx_irq_mask,
+	.irq_unmask		= stmfx_irq_unmask,
+};
+
+static irqreturn_t stmfx_irq_handler(int irq, void *data)
+{
+	struct stmfx_ddata *ddata = data;
+	unsigned long n, pending;
+	u32 ack;
+	int ret;
+
+	ret = regmap_read(ddata->stmfx->map, STMFX_REG_IRQ_PENDING,
+			  (u32 *)&pending);
+	if (ret)
+		return IRQ_NONE;
+
+	/*
+	 * There is no ACK for GPIO, MFX_REG_IRQ_PENDING_GPIO is a logical OR
+	 * of MFX_REG_IRQ_GPI _PENDING1/_PENDING2/_PENDING3
+	 */
+	ack = pending & ~BIT(STMFX_REG_IRQ_SRC_EN_GPIO);
+	if (ack) {
+		ret = regmap_write(ddata->stmfx->map, STMFX_REG_IRQ_ACK, ack);
+		if (ret)
+			return IRQ_NONE;
+	}
+
+	for_each_set_bit(n, &pending, STMFX_REG_IRQ_SRC_MAX)
+		handle_nested_irq(irq_find_mapping(ddata->irq_domain, n));
+
+	return IRQ_HANDLED;
+}
+
+static int stmfx_irq_map(struct irq_domain *d, unsigned int virq,
+			 irq_hw_number_t hwirq)
+{
+	irq_set_chip_data(virq, d->host_data);
+	irq_set_chip_and_handler(virq, &stmfx_irq_chip, handle_simple_irq);
+	irq_set_nested_thread(virq, 1);
+	irq_set_noprobe(virq);
+
+	return 0;
+}
+
+static void stmfx_irq_unmap(struct irq_domain *d, unsigned int virq)
+{
+	irq_set_chip_and_handler(virq, NULL, NULL);
+	irq_set_chip_data(virq, NULL);
+}
+
+static const struct irq_domain_ops stmfx_irq_ops = {
+	.map	= stmfx_irq_map,
+	.unmap	= stmfx_irq_unmap,
+};
+
+static void stmfx_irq_exit(struct stmfx_ddata *ddata)
+{
+	int hwirq;
+
+	for (hwirq = 0; hwirq < STMFX_REG_IRQ_SRC_MAX; hwirq++)
+		irq_dispose_mapping(irq_find_mapping(ddata->irq_domain, hwirq));
+	irq_domain_remove(ddata->irq_domain);
+}
+
+static int stmfx_irq_init(struct stmfx_ddata *ddata, int irq)
+{
+	struct device *dev = ddata->stmfx->dev;
+	u32 irqoutpin = 0, irqtrigger;
+	int ret;
+
+	ddata->irq_domain = irq_domain_add_simple(dev->of_node,
+						  STMFX_REG_IRQ_SRC_MAX, 0,
+						  &stmfx_irq_ops, ddata);
+	if (!ddata->irq_domain) {
+		dev_err(dev, "failed to create irq domain\n");
+		return -EINVAL;
+	}
+
+	if (!of_property_read_bool(dev->of_node, "drive-open-drain"))
+		irqoutpin |= STMFX_REG_IRQ_OUT_PIN_TYPE;
+
+	irqtrigger = irq_get_trigger_type(irq);
+	if ((irqtrigger & IRQ_TYPE_EDGE_RISING) ||
+	    (irqtrigger & IRQ_TYPE_LEVEL_HIGH))
+		irqoutpin |= STMFX_REG_IRQ_OUT_PIN_POL;
+
+	ret = regmap_write(ddata->stmfx->map, STMFX_REG_IRQ_OUT_PIN, irqoutpin);
+	if (ret)
+		return ret;
+
+	ret = devm_request_threaded_irq(dev, irq, NULL, stmfx_irq_handler,
+					irqtrigger | IRQF_ONESHOT,
+					"stmfx", ddata);
+	if (ret)
+		stmfx_irq_exit(ddata);
+
+	return ret;
+}
+
+static int stmfx_chip_reset(struct stmfx_ddata *ddata)
+{
+	int ret;
+
+	ret = regmap_write(ddata->stmfx->map, STMFX_REG_SYS_CTRL,
+			   STMFX_REG_SYS_CTRL_SWRST);
+	if (ret)
+		return ret;
+
+	msleep(STMFX_BOOT_TIME_MS);
+
+	return ret;
+}
+
+static int stmfx_chip_init(struct stmfx_ddata *ddata, struct i2c_client *client)
+{
+	u32 id;
+	u8 version[2];
+	int ret;
+
+	ddata->vdd = devm_regulator_get_optional(&client->dev, "vdd");
+	if (IS_ERR(ddata->vdd)) {
+		ret = PTR_ERR(ddata->vdd);
+		if (ret != -ENODEV) {
+			if (ret != -EPROBE_DEFER)
+				dev_err(&client->dev,
+					"no vdd regulator found:%d\n", ret);
+			return ret;
+		}
+	}
+
+	if (!IS_ERR(ddata->vdd)) {
+		ret = regulator_enable(ddata->vdd);
+		if (ret) {
+			dev_err(&client->dev, "vdd enable failed: %d\n", ret);
+			return ret;
+		}
+	}
+
+	ret = regmap_read(ddata->stmfx->map, STMFX_REG_CHIP_ID, &id);
+	if (ret) {
+		dev_err(&client->dev, "error reading chip id: %d\n", ret);
+		goto err;
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
+		dev_err(&client->dev, "unknown chip id: %#x\n", id);
+		ret = -EINVAL;
+		goto err;
+	}
+
+	ret = regmap_bulk_read(ddata->stmfx->map, STMFX_REG_FW_VERSION_MSB,
+			       version, ARRAY_SIZE(version));
+	if (ret) {
+		dev_err(&client->dev, "error reading fw version: %d\n", ret);
+		goto err;
+	}
+
+	dev_info(&client->dev, "STMFX id: %#x, fw version: %x.%02x\n",
+		 id, version[0], version[1]);
+
+	return stmfx_chip_reset(ddata);
+
+err:
+	if (!IS_ERR(ddata->vdd))
+		return regulator_disable(ddata->vdd);
+
+	return ret;
+}
+
+static int stmfx_chip_exit(struct stmfx_ddata *ddata)
+{
+	regmap_write(ddata->stmfx->map, STMFX_REG_IRQ_SRC_EN, 0);
+	regmap_write(ddata->stmfx->map, STMFX_REG_SYS_CTRL, 0);
+
+	if (!IS_ERR(ddata->vdd))
+		return regulator_disable(ddata->vdd);
+
+	return 0;
+}
+
+static const struct resource stmfx_pinctrl_resources[] = {
+	DEFINE_RES_IRQ(STMFX_REG_IRQ_SRC_EN_GPIO),
+};
+
+static struct mfd_cell stmfx_cells[] = {
+	{
+		.of_compatible = "st,stmfx-0300-pinctrl",
+		.name = "stmfx-pinctrl",
+		.resources = stmfx_pinctrl_resources,
+		.num_resources = ARRAY_SIZE(stmfx_pinctrl_resources),
+	}
+};
+
+static bool stmfx_reg_volatile(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case STMFX_REG_SYS_CTRL:
+	case STMFX_REG_IRQ_SRC_EN:
+	case STMFX_REG_IRQ_PENDING:
+	case STMFX_REG_IRQ_GPI_PENDING1:
+	case STMFX_REG_IRQ_GPI_PENDING2:
+	case STMFX_REG_IRQ_GPI_PENDING3:
+	case STMFX_REG_GPIO_STATE1:
+	case STMFX_REG_GPIO_STATE2:
+	case STMFX_REG_GPIO_STATE3:
+	case STMFX_REG_IRQ_GPI_SRC1:
+	case STMFX_REG_IRQ_GPI_SRC2:
+	case STMFX_REG_IRQ_GPI_SRC3:
+	case STMFX_REG_GPO_SET1:
+	case STMFX_REG_GPO_SET2:
+	case STMFX_REG_GPO_SET3:
+	case STMFX_REG_GPO_CLR1:
+	case STMFX_REG_GPO_CLR2:
+	case STMFX_REG_GPO_CLR3:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool stmfx_reg_writeable(struct device *dev, unsigned int reg)
+{
+	return (reg >= STMFX_REG_SYS_CTRL);
+}
+
+static const struct regmap_config stmfx_regmap_config = {
+	.reg_bits	= 8,
+	.reg_stride	= 1,
+	.val_bits	= 8,
+	.max_register	= STMFX_REG_MAX,
+	.volatile_reg	= stmfx_reg_volatile,
+	.writeable_reg	= stmfx_reg_writeable,
+	.cache_type	= REGCACHE_RBTREE,
+};
+
+static int stmfx_probe(struct i2c_client *client,
+		       const struct i2c_device_id *id)
+{
+	struct device *dev = &client->dev;
+	struct stmfx_ddata *ddata;
+	int i, ret;
+
+	ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
+	if (!ddata)
+		return -ENOMEM;
+	/* State holder */
+	ddata->stmfx = devm_kzalloc(dev, sizeof(*ddata->stmfx), GFP_KERNEL);
+	if (!ddata->stmfx)
+		return -ENOMEM;
+
+	i2c_set_clientdata(client, ddata);
+
+	ddata->stmfx->dev = dev;
+
+	ddata->stmfx->map = devm_regmap_init_i2c(client, &stmfx_regmap_config);
+	if (IS_ERR(ddata->stmfx->map)) {
+		ret = PTR_ERR(ddata->stmfx->map);
+		dev_err(dev, "failed to allocate register map: %d\n", ret);
+		return ret;
+	}
+
+	mutex_init(&ddata->lock);
+
+	ret = stmfx_chip_init(ddata, client);
+	if (ret) {
+		if (ret == -ETIMEDOUT)
+			return -EPROBE_DEFER;
+		return ret;
+	}
+
+	if (client->irq < 0) {
+		dev_err(dev, "failed to get irq: %d\n", client->irq);
+		ret = client->irq;
+		goto err_chip_exit;
+	}
+
+	ret = stmfx_irq_init(ddata, client->irq);
+	if (ret)
+		goto err_chip_exit;
+
+	for (i = 0; i < ARRAY_SIZE(stmfx_cells); i++) {
+		stmfx_cells[i].platform_data = ddata->stmfx;
+		stmfx_cells[i].pdata_size = sizeof(struct stmfx);
+	}
+
+	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_NONE,
+				   stmfx_cells, ARRAY_SIZE(stmfx_cells), NULL,
+				   0, ddata->irq_domain);
+	if (ret)
+		goto err_irq_exit;
+
+	return 0;
+
+err_irq_exit:
+	stmfx_irq_exit(ddata);
+err_chip_exit:
+	stmfx_chip_exit(ddata);
+
+	return ret;
+}
+
+static int stmfx_remove(struct i2c_client *client)
+{
+	struct stmfx_ddata *ddata = i2c_get_clientdata(client);
+
+	stmfx_irq_exit(ddata);
+
+	return stmfx_chip_exit(ddata);
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int stmfx_backup_regs(struct stmfx_ddata *ddata)
+{
+	int ret;
+
+	ret = regmap_raw_read(ddata->stmfx->map, STMFX_REG_SYS_CTRL,
+			      &ddata->bkp_sysctrl, sizeof(ddata->bkp_sysctrl));
+	if (ret)
+		return ret;
+	ret = regmap_raw_read(ddata->stmfx->map, STMFX_REG_IRQ_OUT_PIN,
+			      &ddata->bkp_irqoutpin,
+			      sizeof(ddata->bkp_irqoutpin));
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int stmfx_restore_regs(struct stmfx_ddata *ddata)
+{
+	int ret;
+
+	ret = regmap_raw_write(ddata->stmfx->map, STMFX_REG_SYS_CTRL,
+			       &ddata->bkp_sysctrl, sizeof(ddata->bkp_sysctrl));
+	if (ret)
+		return ret;
+	ret = regmap_raw_write(ddata->stmfx->map, STMFX_REG_IRQ_OUT_PIN,
+			       &ddata->bkp_irqoutpin,
+			       sizeof(ddata->bkp_irqoutpin));
+	if (ret)
+		return ret;
+	ret = regmap_raw_write(ddata->stmfx->map, STMFX_REG_IRQ_SRC_EN,
+			       &ddata->irq_src, sizeof(ddata->irq_src));
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int stmfx_suspend(struct device *dev)
+{
+	struct stmfx_ddata *ddata = dev_get_drvdata(dev);
+	int ret;
+
+	ret = stmfx_backup_regs(ddata);
+	if (ret) {
+		dev_err(ddata->stmfx->dev, "registers backup failure\n");
+		return ret;
+	}
+
+	if (!IS_ERR(ddata->vdd)) {
+		ret = regulator_disable(ddata->vdd);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int stmfx_resume(struct device *dev)
+{
+	struct stmfx_ddata *ddata = dev_get_drvdata(dev);
+	int ret;
+
+	if (!IS_ERR(ddata->vdd)) {
+		ret = regulator_enable(ddata->vdd);
+		if (ret) {
+			dev_err(ddata->stmfx->dev,
+				"vdd enable failed: %d\n", ret);
+			return ret;
+		}
+	}
+
+	ret = stmfx_restore_regs(ddata);
+	if (ret) {
+		dev_err(ddata->stmfx->dev, "registers restoration failure\n");
+		return ret;
+	}
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
+		.name = "stmfx-core",
+		.of_match_table = of_match_ptr(stmfx_of_match),
+		.pm = &stmfx_dev_pm_ops,
+	},
+	.probe = stmfx_probe,
+	.remove = stmfx_remove,
+};
+module_i2c_driver(stmfx_driver);
+
+MODULE_DESCRIPTION("STMFX core driver");
+MODULE_AUTHOR("Amelie Delaunay <amelie.delaunay@st.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/mfd/stmfx.h b/include/linux/mfd/stmfx.h
new file mode 100644
index 0000000..35c3d42
--- /dev/null
+++ b/include/linux/mfd/stmfx.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2018 STMicroelectronics
+ * Author(s): Amelie Delaunay <amelie.delaunay@st.com>.
+ */
+
+#ifndef MFD_STMFX_H
+#define MFX_STMFX_H
+
+#include <linux/regmap.h>
+
+enum stmfx_functions {
+	STMFX_FUNC_GPIO		= BIT(0), /* GPIO[15:0] */
+	STMFX_FUNC_ALTGPIO_LOW	= BIT(1), /* aGPIO[3:0] */
+	STMFX_FUNC_ALTGPIO_HIGH = BIT(2), /* aGPIO[7:4] */
+	STMFX_FUNC_TS		= BIT(3),
+	STMFX_FUNC_IDD		= BIT(4),
+};
+
+struct stmfx {
+	struct device *dev;
+	struct regmap *map;
+};
+
+int stmfx_function_enable(struct stmfx *stmfx, u32 func);
+int stmfx_function_disable(struct stmfx *stmfx, u32 func);
+#endif
-- 
2.7.4

