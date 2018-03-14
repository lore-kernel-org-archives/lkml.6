Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751961AbeCNQaw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 12:30:52 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:39233 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751660AbeCNQaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 12:30:30 -0400
From: <gabriel.fernandez@st.com>
To: Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>, <gabriel.fernandez@st.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <gabriel.fernandez.st@gmail.com>, Loic PALLARDY <loic.pallardy@st.com>,
        benjamin GAIGNARD <benjamin.gaignard@st.com>,
        Michael Turquette <mturquette@baylibre.com>, <sboyd@kernel.org>,
        Gabriel Fernandez <gabriel.fernandez@st.com>
Subject: [PATCH v2 2/2] reset: stm32mp1: Enable stm32mp1 reset driver
Date: Wed, 14 Mar 2018 17:30:01 +0100
Message-ID: <1521045001-30788-3-git-send-email-gabriel.fernandez@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1521045001-30788-1-git-send-email-gabriel.fernandez@st.com>
References: <1521045001-30788-1-git-send-email-gabriel.fernandez@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG4NODE1.st.com (10.75.127.10) To SFHDAG4NODE2.st.com
 (10.75.127.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-14_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

stm32mp1 RCC IP 1 has a reset SET register and a reset CLEAR register.

Writing '0' on reset SET register has no effect
Writing '1' on reset SET register
	activates the reset of the corresponding peripheral

Writing '0' on reset CLEAR register	has no effect
Writing '1' on reset CLEAR register
	releases the reset of the corresponding peripheral

See Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.txt

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
---
 drivers/reset/Kconfig          |   6 ++
 drivers/reset/Makefile         |   1 +
 drivers/reset/reset-stm32mp1.c | 122 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 129 insertions(+)
 create mode 100644 drivers/reset/reset-stm32mp1.c

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 1efbc6c..c0b292b 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -97,6 +97,12 @@ config RESET_SIMPLE
 	   - Allwinner SoCs
 	   - ZTE's zx2967 family
 
+config RESET_STM32MP157
+	bool "STM32MP157 Reset Driver" if COMPILE_TEST
+	default MACH_STM32MP157
+	help
+	  This enables the RCC reset controller driver for STM32 MPUs.
+
 config RESET_SUNXI
 	bool "Allwinner SoCs Reset Driver" if COMPILE_TEST && !ARCH_SUNXI
 	default ARCH_SUNXI
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index 132c24f..c1261dc 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_RESET_MESON) += reset-meson.o
 obj-$(CONFIG_RESET_OXNAS) += reset-oxnas.o
 obj-$(CONFIG_RESET_PISTACHIO) += reset-pistachio.o
 obj-$(CONFIG_RESET_SIMPLE) += reset-simple.o
+obj-$(CONFIG_RESET_STM32MP157) += reset-stm32mp1.o
 obj-$(CONFIG_RESET_SUNXI) += reset-sunxi.o
 obj-$(CONFIG_RESET_TI_SCI) += reset-ti-sci.o
 obj-$(CONFIG_RESET_TI_SYSCON) += reset-ti-syscon.o
diff --git a/drivers/reset/reset-stm32mp1.c b/drivers/reset/reset-stm32mp1.c
new file mode 100644
index 0000000..5e25388
--- /dev/null
+++ b/drivers/reset/reset-stm32mp1.c
@@ -0,0 +1,122 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) STMicroelectronics 2018 - All Rights Reserved
+ * Author: Gabriel Fernandez <gabriel.fernandez@st.com> for STMicroelectronics.
+ */
+
+#include <linux/arm-smccc.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/reset-controller.h>
+
+#define CLR_OFFSET 0x4
+
+struct stm32_reset_data {
+	struct reset_controller_dev	rcdev;
+	void __iomem			*membase;
+};
+
+static inline struct stm32_reset_data *
+to_stm32_reset_data(struct reset_controller_dev *rcdev)
+{
+	return container_of(rcdev, struct stm32_reset_data, rcdev);
+}
+
+static int stm32_reset_update(struct reset_controller_dev *rcdev,
+			      unsigned long id, bool assert)
+{
+	struct stm32_reset_data *data = to_stm32_reset_data(rcdev);
+	int reg_width = sizeof(u32);
+	int bank = id / (reg_width * BITS_PER_BYTE);
+	int offset = id % (reg_width * BITS_PER_BYTE);
+	void __iomem *addr;
+
+	addr = data->membase + (bank * reg_width);
+	if (!assert)
+		addr += CLR_OFFSET;
+
+	writel(BIT(offset), addr);
+
+	return 0;
+}
+
+static int stm32_reset_assert(struct reset_controller_dev *rcdev,
+			      unsigned long id)
+{
+	return stm32_reset_update(rcdev, id, true);
+}
+
+static int stm32_reset_deassert(struct reset_controller_dev *rcdev,
+				unsigned long id)
+{
+	return stm32_reset_update(rcdev, id, false);
+}
+
+static int stm32_reset_status(struct reset_controller_dev *rcdev,
+			      unsigned long id)
+{
+	struct stm32_reset_data *data = to_stm32_reset_data(rcdev);
+	int reg_width = sizeof(u32);
+	int bank = id / (reg_width * BITS_PER_BYTE);
+	int offset = id % (reg_width * BITS_PER_BYTE);
+	u32 reg;
+
+	reg = readl(data->membase + (bank * reg_width));
+
+	return !(reg & BIT(offset));
+}
+
+const struct reset_control_ops stm32_reset_ops = {
+	.assert		= stm32_reset_assert,
+	.deassert	= stm32_reset_deassert,
+	.status		= stm32_reset_status,
+};
+
+static const struct of_device_id stm32_reset_dt_ids[] = {
+	{ .compatible = "st,stm32mp1-rcc"},
+	{ /* sentinel */ },
+};
+
+static int stm32_reset_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct stm32_reset_data *data;
+	void __iomem *membase;
+	struct resource *res;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	membase = devm_ioremap_resource(dev, res);
+	if (IS_ERR(membase))
+		return PTR_ERR(membase);
+
+	data->membase = membase;
+	data->rcdev.owner = THIS_MODULE;
+	data->rcdev.nr_resets = resource_size(res) * BITS_PER_BYTE;
+	data->rcdev.ops = &stm32_reset_ops;
+	data->rcdev.of_node = dev->of_node;
+
+	return devm_reset_controller_register(dev, &data->rcdev);
+}
+
+static struct platform_driver stm32_reset_driver = {
+	.probe	= stm32_reset_probe,
+	.driver = {
+		.name		= "stm32mp1-reset",
+		.of_match_table	= stm32_reset_dt_ids,
+	},
+};
+
+static int __init stm32_reset_init(void)
+{
+	return platform_driver_register(&stm32_reset_driver);
+}
+
+postcore_initcall(stm32_reset_init);
-- 
1.9.1
