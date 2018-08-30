Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E60AC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 13:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 263622073D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 13:20:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 263622073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728982AbeH3RWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 13:22:34 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:56770 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728955AbeH3RWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 13:22:33 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w7UDJVeF030914;
        Thu, 30 Aug 2018 08:20:16 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=rf@opensource.cirrus.com
Received: from mail3.cirrus.com ([87.246.76.56])
        by mx0b-001ae601.pphosted.com with ESMTP id 2m33hnprmg-1;
        Thu, 30 Aug 2018 08:20:15 -0500
Received: from EX17.ad.cirrus.com (ex17.ad.cirrus.com [172.20.9.81])
        by mail3.cirrus.com (Postfix) with ESMTP id DA4F8611CE60;
        Thu, 30 Aug 2018 08:21:55 -0500 (CDT)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Thu, 30 Aug 2018
 14:20:14 +0100
Received: from edi-sw-dsktp006.ad.cirrus.com (edi-sw-dsktp006.ad.cirrus.com
 [198.90.251.121])      by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id
 w7UDK5Te025647;        Thu, 30 Aug 2018 14:20:06 +0100
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>, <lee.jones@linaro.org>
CC:     <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        "Richard Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH v11 2/2] irqchip: Add driver for Cirrus Logic Madera codecs
Date:   Thu, 30 Aug 2018 14:20:05 +0100
Message-ID: <20180830132005.19500-2-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180830132005.19500-1-rf@opensource.cirrus.com>
References: <20180830132005.19500-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1807170000
 definitions=main-1808300139
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Cirrus Logic Madera codecs (Cirrus Logic CS47L35/85/90/91 and WM1840)
are highly complex devices containing up to 7 programmable DSPs and many
other internal sources of interrupts plus a number of GPIOs that can be
used as interrupt inputs. The large number (>150) of internal interrupt
sources are managed by an on-board interrupt controller.

This driver provides the handling for the interrupt controller. As the
codec is accessed via regmap, we can make use of the generic IRQ
functionality from regmap to do most of the work. Only around half of
the possible interrupt source are currently of interest from the driver
so only this subset is defined. Others can be added in future if needed.

The KConfig options are not user-configurable because this driver is
mandatory so is automatically included when the parent MFD driver is
selected.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 MAINTAINERS                        |   2 +
 drivers/irqchip/Kconfig            |   3 +
 drivers/irqchip/Makefile           |   1 +
 drivers/irqchip/irq-madera.c       | 259 +++++++++++++++++++++++++++++++++++++
 include/linux/irqchip/irq-madera.h | 135 +++++++++++++++++++
 5 files changed, 400 insertions(+)
 create mode 100644 drivers/irqchip/irq-madera.c
 create mode 100644 include/linux/irqchip/irq-madera.h

diff --git a/MAINTAINERS b/MAINTAINERS
index a5b256b25905..d20b81fcbc53 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3594,8 +3594,10 @@ W:	https://github.com/CirrusLogic/linux-drivers/wiki
 S:	Supported
 F:	Documentation/devicetree/bindings/mfd/madera.txt
 F:	Documentation/devicetree/bindings/pinctrl/cirrus,madera-pinctrl.txt
+F:	include/linux/irqchip/irq-madera*
 F:	include/linux/mfd/madera/*
 F:	drivers/gpio/gpio-madera*
+F:	drivers/irqchip/irq-madera*
 F:	drivers/mfd/madera*
 F:	drivers/mfd/cs47l*
 F:	drivers/pinctrl/cirrus/*
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 383e7b70221d..0afe6bdd2074 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -150,6 +150,9 @@ config IMGPDC_IRQ
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
 
+config MADERA_IRQ
+	tristate
+
 config IRQ_MIPS_CPU
 	bool
 	select GENERIC_IRQ_CHIP
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index fbd1ec8070ef..97838212d8e4 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -88,3 +88,4 @@ obj-$(CONFIG_GOLDFISH_PIC) 		+= irq-goldfish-pic.o
 obj-$(CONFIG_NDS32)			+= irq-ativic32.o
 obj-$(CONFIG_QCOM_PDC)			+= qcom-pdc.o
 obj-$(CONFIG_SIFIVE_PLIC)		+= irq-sifive-plic.o
+obj-$(CONFIG_MADERA_IRQ)		+= irq-madera.o
diff --git a/drivers/irqchip/irq-madera.c b/drivers/irqchip/irq-madera.c
new file mode 100644
index 000000000000..f8944d107400
--- /dev/null
+++ b/drivers/irqchip/irq-madera.c
@@ -0,0 +1,259 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Interrupt support for Cirrus Logic Madera codecs
+ *
+ * Copyright (C) 2015-2018 Cirrus Logic
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; version 2.
+ */
+
+#include <linux/module.h>
+#include <linux/gpio.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_gpio.h>
+#include <linux/of_irq.h>
+#include <linux/irqchip/irq-madera.h>
+#include <linux/mfd/madera/core.h>
+#include <linux/mfd/madera/pdata.h>
+#include <linux/mfd/madera/registers.h>
+
+#define MADERA_IRQ(_irq, _reg)					\
+	[MADERA_IRQ_ ## _irq] = {				\
+		.reg_offset = (_reg) - MADERA_IRQ1_STATUS_2,	\
+		.mask = MADERA_ ## _irq ## _EINT1		\
+	}
+
+/* Mappings are the same for all Madera codecs */
+static const struct regmap_irq madera_irqs[MADERA_NUM_IRQ] = {
+	MADERA_IRQ(FLL1_LOCK,		MADERA_IRQ1_STATUS_2),
+	MADERA_IRQ(FLL2_LOCK,		MADERA_IRQ1_STATUS_2),
+	MADERA_IRQ(FLL3_LOCK,		MADERA_IRQ1_STATUS_2),
+	MADERA_IRQ(FLLAO_LOCK,		MADERA_IRQ1_STATUS_2),
+
+	MADERA_IRQ(MICDET1,		MADERA_IRQ1_STATUS_6),
+	MADERA_IRQ(MICDET2,		MADERA_IRQ1_STATUS_6),
+	MADERA_IRQ(HPDET,		MADERA_IRQ1_STATUS_6),
+
+	MADERA_IRQ(MICD_CLAMP_RISE,	MADERA_IRQ1_STATUS_7),
+	MADERA_IRQ(MICD_CLAMP_FALL,	MADERA_IRQ1_STATUS_7),
+	MADERA_IRQ(JD1_RISE,		MADERA_IRQ1_STATUS_7),
+	MADERA_IRQ(JD1_FALL,		MADERA_IRQ1_STATUS_7),
+
+	MADERA_IRQ(ASRC2_IN1_LOCK,	MADERA_IRQ1_STATUS_9),
+	MADERA_IRQ(ASRC2_IN2_LOCK,	MADERA_IRQ1_STATUS_9),
+	MADERA_IRQ(ASRC1_IN1_LOCK,	MADERA_IRQ1_STATUS_9),
+	MADERA_IRQ(ASRC1_IN2_LOCK,	MADERA_IRQ1_STATUS_9),
+	MADERA_IRQ(DRC2_SIG_DET,	MADERA_IRQ1_STATUS_9),
+	MADERA_IRQ(DRC1_SIG_DET,	MADERA_IRQ1_STATUS_9),
+
+	MADERA_IRQ(DSP_IRQ1,		MADERA_IRQ1_STATUS_11),
+	MADERA_IRQ(DSP_IRQ2,		MADERA_IRQ1_STATUS_11),
+	MADERA_IRQ(DSP_IRQ3,		MADERA_IRQ1_STATUS_11),
+	MADERA_IRQ(DSP_IRQ4,		MADERA_IRQ1_STATUS_11),
+	MADERA_IRQ(DSP_IRQ5,		MADERA_IRQ1_STATUS_11),
+	MADERA_IRQ(DSP_IRQ6,		MADERA_IRQ1_STATUS_11),
+	MADERA_IRQ(DSP_IRQ7,		MADERA_IRQ1_STATUS_11),
+	MADERA_IRQ(DSP_IRQ8,		MADERA_IRQ1_STATUS_11),
+	MADERA_IRQ(DSP_IRQ9,		MADERA_IRQ1_STATUS_11),
+	MADERA_IRQ(DSP_IRQ10,		MADERA_IRQ1_STATUS_11),
+	MADERA_IRQ(DSP_IRQ11,		MADERA_IRQ1_STATUS_11),
+	MADERA_IRQ(DSP_IRQ12,		MADERA_IRQ1_STATUS_11),
+	MADERA_IRQ(DSP_IRQ13,		MADERA_IRQ1_STATUS_11),
+	MADERA_IRQ(DSP_IRQ14,		MADERA_IRQ1_STATUS_11),
+	MADERA_IRQ(DSP_IRQ15,		MADERA_IRQ1_STATUS_11),
+	MADERA_IRQ(DSP_IRQ16,		MADERA_IRQ1_STATUS_11),
+
+	MADERA_IRQ(HP3R_SC,		MADERA_IRQ1_STATUS_12),
+	MADERA_IRQ(HP3L_SC,		MADERA_IRQ1_STATUS_12),
+	MADERA_IRQ(HP2R_SC,		MADERA_IRQ1_STATUS_12),
+	MADERA_IRQ(HP2L_SC,		MADERA_IRQ1_STATUS_12),
+	MADERA_IRQ(HP1R_SC,		MADERA_IRQ1_STATUS_12),
+	MADERA_IRQ(HP1L_SC,		MADERA_IRQ1_STATUS_12),
+
+	MADERA_IRQ(SPK_OVERHEAT_WARN,	MADERA_IRQ1_STATUS_15),
+	MADERA_IRQ(SPK_OVERHEAT,	MADERA_IRQ1_STATUS_15),
+
+	MADERA_IRQ(DSP1_BUS_ERR,	MADERA_IRQ1_STATUS_33),
+	MADERA_IRQ(DSP2_BUS_ERR,	MADERA_IRQ1_STATUS_33),
+	MADERA_IRQ(DSP3_BUS_ERR,	MADERA_IRQ1_STATUS_33),
+	MADERA_IRQ(DSP4_BUS_ERR,	MADERA_IRQ1_STATUS_33),
+	MADERA_IRQ(DSP5_BUS_ERR,	MADERA_IRQ1_STATUS_33),
+	MADERA_IRQ(DSP6_BUS_ERR,	MADERA_IRQ1_STATUS_33),
+	MADERA_IRQ(DSP7_BUS_ERR,	MADERA_IRQ1_STATUS_33),
+};
+
+static const struct regmap_irq_chip madera_irq_chip = {
+	.name		= "madera IRQ",
+	.status_base	= MADERA_IRQ1_STATUS_2,
+	.mask_base	= MADERA_IRQ1_MASK_2,
+	.ack_base	= MADERA_IRQ1_STATUS_2,
+	.runtime_pm	= true,
+	.num_regs	= 32,
+	.irqs		= madera_irqs,
+	.num_irqs	= ARRAY_SIZE(madera_irqs),
+};
+
+#ifdef CONFIG_PM_SLEEP
+static int madera_suspend(struct device *dev)
+{
+	struct madera *madera = dev_get_drvdata(dev->parent);
+
+	dev_dbg(madera->irq_dev, "Suspend, disabling IRQ\n");
+
+	/*
+	 * A runtime resume would be needed to access the chip interrupt
+	 * controller but runtime pm doesn't function during suspend.
+	 * Temporarily disable interrupts until we reach suspend_noirq state.
+	 */
+	disable_irq(madera->irq);
+
+	return 0;
+}
+
+static int madera_suspend_noirq(struct device *dev)
+{
+	struct madera *madera = dev_get_drvdata(dev->parent);
+
+	dev_dbg(madera->irq_dev, "No IRQ suspend, reenabling IRQ\n");
+
+	/* Re-enable interrupts to service wakeup interrupts from the chip */
+	enable_irq(madera->irq);
+
+	return 0;
+}
+
+static int madera_resume_noirq(struct device *dev)
+{
+	struct madera *madera = dev_get_drvdata(dev->parent);
+
+	dev_dbg(madera->irq_dev, "No IRQ resume, disabling IRQ\n");
+
+	/*
+	 * We can't handle interrupts until runtime pm is available again.
+	 * Disable them temporarily.
+	 */
+	disable_irq(madera->irq);
+
+	return 0;
+}
+
+static int madera_resume(struct device *dev)
+{
+	struct madera *madera = dev_get_drvdata(dev->parent);
+
+	dev_dbg(madera->irq_dev, "Resume, reenabling IRQ\n");
+
+	/* Interrupts can now be handled */
+	enable_irq(madera->irq);
+
+	return 0;
+}
+#endif
+
+static const struct dev_pm_ops madera_irq_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(madera_suspend, madera_resume)
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(madera_suspend_noirq,
+				      madera_resume_noirq)
+};
+
+static int madera_irq_probe(struct platform_device *pdev)
+{
+	struct madera *madera = dev_get_drvdata(pdev->dev.parent);
+	struct irq_data *irq_data;
+	unsigned int irq_flags = 0;
+	int ret;
+
+	dev_dbg(&pdev->dev, "probe\n");
+
+	/*
+	 * Read the flags from the interrupt controller if not specified
+	 * by pdata
+	 */
+	irq_flags = madera->pdata.irq_flags;
+	if (!irq_flags) {
+		irq_data = irq_get_irq_data(madera->irq);
+		if (!irq_data) {
+			dev_err(&pdev->dev, "Invalid IRQ: %d\n", madera->irq);
+			return -EINVAL;
+		}
+
+		irq_flags = irqd_get_trigger_type(irq_data);
+
+		/* Codec defaults to trigger low, use this if no flags given */
+		if (irq_flags == IRQ_TYPE_NONE)
+			irq_flags = IRQF_TRIGGER_LOW;
+	}
+
+	if (irq_flags & (IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING)) {
+		dev_err(&pdev->dev, "Host interrupt not level-triggered\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * The silicon always starts at active-low, check if we need to
+	 * switch to active-high.
+	 */
+	if (irq_flags & IRQF_TRIGGER_HIGH) {
+		ret = regmap_update_bits(madera->regmap, MADERA_IRQ1_CTRL,
+					 MADERA_IRQ_POL_MASK, 0);
+		if (ret) {
+			dev_err(&pdev->dev,
+				"Failed to set IRQ polarity: %d\n", ret);
+			return ret;
+		}
+	}
+
+	/*
+	 * NOTE: regmap registers this against the OF node of the parent of
+	 * the regmap - that is, against the mfd driver
+	 */
+	ret = regmap_add_irq_chip(madera->regmap, madera->irq, IRQF_ONESHOT, 0,
+				  &madera_irq_chip, &madera->irq_data);
+	if (ret) {
+		dev_err(&pdev->dev, "add_irq_chip failed: %d\n", ret);
+		return ret;
+	}
+
+	/* Save dev in parent MFD struct so it is accessible to siblings */
+	madera->irq_dev = &pdev->dev;
+
+	return 0;
+}
+
+static int madera_irq_remove(struct platform_device *pdev)
+{
+	struct madera *madera = dev_get_drvdata(pdev->dev.parent);
+
+	/*
+	 * The IRQ is disabled by the parent MFD driver before
+	 * it starts cleaning up all child drivers
+	 */
+	madera->irq_dev = NULL;
+	regmap_del_irq_chip(madera->irq, madera->irq_data);
+
+	return 0;
+}
+
+static struct platform_driver madera_irq_driver = {
+	.probe	= &madera_irq_probe,
+	.remove = &madera_irq_remove,
+	.driver = {
+		.name	= "madera-irq",
+		.pm	= &madera_irq_pm_ops,
+	}
+};
+module_platform_driver(madera_irq_driver);
+
+MODULE_SOFTDEP("pre: madera");
+MODULE_DESCRIPTION("Madera IRQ driver");
+MODULE_AUTHOR("Richard Fitzgerald <rf@opensource.cirrus.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/irqchip/irq-madera.h b/include/linux/irqchip/irq-madera.h
new file mode 100644
index 000000000000..5aeb7e6adc82
--- /dev/null
+++ b/include/linux/irqchip/irq-madera.h
@@ -0,0 +1,135 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Interrupt support for Cirrus Logic Madera codecs
+ *
+ * Copyright 2016-2018 Cirrus Logic
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; version 2.
+ */
+
+#ifndef IRQCHIP_MADERA_H
+#define IRQCHIP_MADERA_H
+
+#include <linux/interrupt.h>
+#include <linux/mfd/madera/core.h>
+
+#define MADERA_IRQ_FLL1_LOCK		0
+#define MADERA_IRQ_FLL2_LOCK		1
+#define MADERA_IRQ_FLL3_LOCK		2
+#define MADERA_IRQ_FLLAO_LOCK		3
+#define MADERA_IRQ_CLK_SYS_ERR		4
+#define MADERA_IRQ_CLK_ASYNC_ERR	5
+#define MADERA_IRQ_CLK_DSP_ERR		6
+#define MADERA_IRQ_HPDET		7
+#define MADERA_IRQ_MICDET1		8
+#define MADERA_IRQ_MICDET2		9
+#define MADERA_IRQ_JD1_RISE		10
+#define MADERA_IRQ_JD1_FALL		11
+#define MADERA_IRQ_JD2_RISE		12
+#define MADERA_IRQ_JD2_FALL		13
+#define MADERA_IRQ_MICD_CLAMP_RISE	14
+#define MADERA_IRQ_MICD_CLAMP_FALL	15
+#define MADERA_IRQ_DRC2_SIG_DET		16
+#define MADERA_IRQ_DRC1_SIG_DET		17
+#define MADERA_IRQ_ASRC1_IN1_LOCK	18
+#define MADERA_IRQ_ASRC1_IN2_LOCK	19
+#define MADERA_IRQ_ASRC2_IN1_LOCK	20
+#define MADERA_IRQ_ASRC2_IN2_LOCK	21
+#define MADERA_IRQ_DSP_IRQ1		22
+#define MADERA_IRQ_DSP_IRQ2		23
+#define MADERA_IRQ_DSP_IRQ3		24
+#define MADERA_IRQ_DSP_IRQ4		25
+#define MADERA_IRQ_DSP_IRQ5		26
+#define MADERA_IRQ_DSP_IRQ6		27
+#define MADERA_IRQ_DSP_IRQ7		28
+#define MADERA_IRQ_DSP_IRQ8		29
+#define MADERA_IRQ_DSP_IRQ9		30
+#define MADERA_IRQ_DSP_IRQ10		31
+#define MADERA_IRQ_DSP_IRQ11		32
+#define MADERA_IRQ_DSP_IRQ12		33
+#define MADERA_IRQ_DSP_IRQ13		34
+#define MADERA_IRQ_DSP_IRQ14		35
+#define MADERA_IRQ_DSP_IRQ15		36
+#define MADERA_IRQ_DSP_IRQ16		37
+#define MADERA_IRQ_HP1L_SC		38
+#define MADERA_IRQ_HP1R_SC		39
+#define MADERA_IRQ_HP2L_SC		40
+#define MADERA_IRQ_HP2R_SC		41
+#define MADERA_IRQ_HP3L_SC		42
+#define MADERA_IRQ_HP3R_SC		43
+#define MADERA_IRQ_SPKOUTL_SC		44
+#define MADERA_IRQ_SPKOUTR_SC		45
+#define MADERA_IRQ_HP1L_ENABLE_DONE	46
+#define MADERA_IRQ_HP1R_ENABLE_DONE	47
+#define MADERA_IRQ_HP2L_ENABLE_DONE	48
+#define MADERA_IRQ_HP2R_ENABLE_DONE	49
+#define MADERA_IRQ_HP3L_ENABLE_DONE	50
+#define MADERA_IRQ_HP3R_ENABLE_DONE	51
+#define MADERA_IRQ_SPKOUTL_ENABLE_DONE	52
+#define MADERA_IRQ_SPKOUTR_ENABLE_DONE	53
+#define MADERA_IRQ_SPK_SHUTDOWN		54
+#define MADERA_IRQ_SPK_OVERHEAT		55
+#define MADERA_IRQ_SPK_OVERHEAT_WARN	56
+#define MADERA_IRQ_GPIO1		57
+#define MADERA_IRQ_GPIO2		58
+#define MADERA_IRQ_GPIO3		59
+#define MADERA_IRQ_GPIO4		60
+#define MADERA_IRQ_GPIO5		61
+#define MADERA_IRQ_GPIO6		62
+#define MADERA_IRQ_GPIO7		63
+#define MADERA_IRQ_GPIO8		64
+#define MADERA_IRQ_DSP1_BUS_ERR		65
+#define MADERA_IRQ_DSP2_BUS_ERR		66
+#define MADERA_IRQ_DSP3_BUS_ERR		67
+#define MADERA_IRQ_DSP4_BUS_ERR		68
+#define MADERA_IRQ_DSP5_BUS_ERR		69
+#define MADERA_IRQ_DSP6_BUS_ERR		70
+#define MADERA_IRQ_DSP7_BUS_ERR		71
+
+#define MADERA_NUM_IRQ			72
+
+/*
+ * These wrapper functions are for use by other child drivers of the
+ * same parent MFD.
+ */
+static inline int madera_get_irq_mapping(struct madera *madera, int irq)
+{
+	if (!madera->irq_dev)
+		return -ENODEV;
+
+	return regmap_irq_get_virq(madera->irq_data, irq);
+}
+
+static inline int madera_request_irq(struct madera *madera, int irq,
+				     const char *name,
+				     irq_handler_t handler, void *data)
+{
+	irq = madera_get_irq_mapping(madera, irq);
+	if (irq < 0)
+		return irq;
+
+	return request_threaded_irq(irq, NULL, handler, IRQF_ONESHOT, name,
+				    data);
+}
+
+static inline void madera_free_irq(struct madera *madera, int irq, void *data)
+{
+	irq = madera_get_irq_mapping(madera, irq);
+	if (irq < 0)
+		return;
+
+	free_irq(irq, data);
+}
+
+static inline int madera_set_irq_wake(struct madera *madera, int irq, int on)
+{
+	irq = madera_get_irq_mapping(madera, irq);
+	if (irq < 0)
+		return irq;
+
+	return irq_set_irq_wake(irq, on);
+}
+
+#endif
-- 
2.11.0

