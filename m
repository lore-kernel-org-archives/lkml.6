Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751511AbeBWKYd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 05:24:33 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:38475 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751645AbeBWKY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 05:24:29 -0500
X-Google-Smtp-Source: AH8x22493rRg9ODUNjYE/QF7hruvMruQZnFOncXVgkxrQIf1hjsKPXcvkcPd5+DmaJ0hocY8rrrPYQ==
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, robdclark@gmail.com,
        s.hauer@pengutronix.de, l.stach@pengutronix.de, shawnguo@kernel.org,
        fabio.estevam@nxp.com, nm@ti.com, xuwei5@hisilicon.com,
        robh+dt@kernel.org, olof@lixom.net
Subject: [PATCH V7 09/13] boot_constraint: Add support for Hisilicon platforms
Date: Fri, 23 Feb 2018 15:53:48 +0530
Message-Id: <0fc2fdf3744e1a0215a42c87759598db4160b659.1519380923.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.15.0.194.g9af6a3dea062
In-Reply-To: <cover.1519380923.git.viresh.kumar@linaro.org>
References: <cover.1519380923.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1519380923.git.viresh.kumar@linaro.org>
References: <cover.1519380923.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds boot constraint support for Hisilicon platforms. Currently
only one use case is supported: earlycon. One of the UART is enabled by
the bootloader and is used for early console in the kernel. The boot
constraint core handles it properly and removes constraints once the
serial device is probed by its driver.

This is tested on hi6220-hikey 96board.

Cc: Wei Xu <xuwei5@hisilicon.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/soc/Kconfig                     |   1 +
 drivers/soc/Makefile                    |   1 +
 drivers/soc/hisilicon/Kconfig           |  15 +++
 drivers/soc/hisilicon/Makefile          |   3 +
 drivers/soc/hisilicon/boot_constraint.c | 158 ++++++++++++++++++++++++++++++++
 5 files changed, 178 insertions(+)
 create mode 100644 drivers/soc/hisilicon/Kconfig
 create mode 100644 drivers/soc/hisilicon/Makefile
 create mode 100644 drivers/soc/hisilicon/boot_constraint.c

diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
index c07b4a85253f..7fd6d59f15bd 100644
--- a/drivers/soc/Kconfig
+++ b/drivers/soc/Kconfig
@@ -5,6 +5,7 @@ source "drivers/soc/amlogic/Kconfig"
 source "drivers/soc/atmel/Kconfig"
 source "drivers/soc/bcm/Kconfig"
 source "drivers/soc/fsl/Kconfig"
+source "drivers/soc/hisilicon/Kconfig"
 source "drivers/soc/imx/Kconfig"
 source "drivers/soc/mediatek/Kconfig"
 source "drivers/soc/qcom/Kconfig"
diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index 40523577bdaa..2daf7c1a52ee 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -10,6 +10,7 @@ obj-$(CONFIG_ARCH_DOVE)		+= dove/
 obj-$(CONFIG_MACH_DOVE)		+= dove/
 obj-y				+= fsl/
 obj-$(CONFIG_ARCH_GEMINI)	+= gemini/
+obj-$(CONFIG_ARCH_HISI)		+= hisilicon/
 obj-$(CONFIG_ARCH_MXC)		+= imx/
 obj-$(CONFIG_SOC_XWAY)		+= lantiq/
 obj-y				+= mediatek/
diff --git a/drivers/soc/hisilicon/Kconfig b/drivers/soc/hisilicon/Kconfig
new file mode 100644
index 000000000000..7247b13a60a2
--- /dev/null
+++ b/drivers/soc/hisilicon/Kconfig
@@ -0,0 +1,15 @@
+#
+# Hisilicon Soc drivers
+#
+
+menu "Hisilicon SoC drivers"
+
+config HISI_BOOT_CONSTRAINT
+	bool "Hisilicon Boot Constraints"
+	depends on ARCH_HISI
+	select DEV_BOOT_CONSTRAINT
+	default y
+	help
+	  Say y here to enable Boot Constraints on Hisilicon platforms.
+
+endmenu
diff --git a/drivers/soc/hisilicon/Makefile b/drivers/soc/hisilicon/Makefile
new file mode 100644
index 000000000000..c63cb9b17bed
--- /dev/null
+++ b/drivers/soc/hisilicon/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_HISI_BOOT_CONSTRAINT) += boot_constraint.o
diff --git a/drivers/soc/hisilicon/boot_constraint.c b/drivers/soc/hisilicon/boot_constraint.c
new file mode 100644
index 000000000000..fa0b25d6ab8e
--- /dev/null
+++ b/drivers/soc/hisilicon/boot_constraint.c
@@ -0,0 +1,158 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * This takes care of Hisilicon boot time device constraints, normally set by
+ * the Bootloader.
+ *
+ * Copyright (c) 2018 Linaro.
+ * Viresh Kumar <viresh.kumar@linaro.org>
+ */
+
+#include <linux/boot_constraint.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+
+static bool earlycon_boot_constraints_enabled __initdata;
+
+static int __init enable_earlycon_boot_constraints(char *str)
+{
+	earlycon_boot_constraints_enabled = true;
+
+	return 0;
+}
+
+__setup_param("earlycon", boot_constraint_earlycon,
+	      enable_earlycon_boot_constraints, 0);
+__setup_param("earlyprintk", boot_constraint_earlyprintk,
+	      enable_earlycon_boot_constraints, 0);
+
+
+struct hikey_machine_constraints {
+	struct dev_boot_constraint_of *dev_constraints;
+	unsigned int count;
+};
+
+static struct dev_boot_constraint_clk_info uart_iclk_info = {
+	.name = "uartclk",
+};
+
+static struct dev_boot_constraint_clk_info uart_pclk_info = {
+	.name = "apb_pclk",
+};
+
+static struct dev_boot_constraint hikey3660_uart_constraints[] = {
+	{
+		.type = DEV_BOOT_CONSTRAINT_CLK,
+		.data = &uart_iclk_info,
+	}, {
+		.type = DEV_BOOT_CONSTRAINT_CLK,
+		.data = &uart_pclk_info,
+	},
+};
+
+static const char * const uarts_hikey3660[] = {
+	"serial@fff32000",	/* UART 6 */
+};
+
+static struct dev_boot_constraint_of hikey3660_dev_constraints[] = {
+	{
+		.compat = "arm,pl011",
+		.constraints = hikey3660_uart_constraints,
+		.count = ARRAY_SIZE(hikey3660_uart_constraints),
+
+		.dev_names = uarts_hikey3660,
+		.dev_names_count = ARRAY_SIZE(uarts_hikey3660),
+	},
+};
+
+static struct hikey_machine_constraints hikey3660_constraints = {
+	.dev_constraints = hikey3660_dev_constraints,
+	.count = ARRAY_SIZE(hikey3660_dev_constraints),
+};
+
+static const char * const uarts_hikey6220[] = {
+	"uart@f7113000",	/* UART 3 */
+};
+
+static struct dev_boot_constraint_of hikey6220_dev_constraints[] = {
+	{
+		.compat = "arm,pl011",
+		.constraints = hikey3660_uart_constraints,
+		.count = ARRAY_SIZE(hikey3660_uart_constraints),
+
+		.dev_names = uarts_hikey6220,
+		.dev_names_count = ARRAY_SIZE(uarts_hikey6220),
+	},
+};
+
+static struct hikey_machine_constraints hikey6220_constraints = {
+	.dev_constraints = hikey6220_dev_constraints,
+	.count = ARRAY_SIZE(hikey6220_dev_constraints),
+};
+
+static struct dev_boot_constraint hikey3798cv200_uart_constraints[] = {
+	{
+		.type = DEV_BOOT_CONSTRAINT_CLK,
+		.data = &uart_pclk_info,
+	},
+};
+
+static const char * const uarts_hikey3798cv200[] = {
+	"serial@8b00000",	/* UART 0 */
+};
+
+static struct dev_boot_constraint_of hikey3798cv200_dev_constraints[] = {
+	{
+		.compat = "arm,pl011",
+		.constraints = hikey3798cv200_uart_constraints,
+		.count = ARRAY_SIZE(hikey3798cv200_uart_constraints),
+
+		.dev_names = uarts_hikey3798cv200,
+		.dev_names_count = ARRAY_SIZE(uarts_hikey3798cv200),
+	},
+};
+
+static struct hikey_machine_constraints hikey3798cv200_constraints = {
+	.dev_constraints = hikey3798cv200_dev_constraints,
+	.count = ARRAY_SIZE(hikey3798cv200_dev_constraints),
+};
+
+static const struct of_device_id machines[] __initconst = {
+	{ .compatible = "hisilicon,hi3660", .data = &hikey3660_constraints },
+	{ .compatible = "hisilicon,hi3798cv200", .data = &hikey3798cv200_constraints },
+	{ .compatible = "hisilicon,hi6220", .data = &hikey6220_constraints },
+	{ }
+};
+
+static int __init hikey_constraints_init(void)
+{
+	const struct hikey_machine_constraints *constraints;
+	const struct of_device_id *match;
+	struct device_node *np;
+
+	if (!earlycon_boot_constraints_enabled)
+		return 0;
+
+	np = of_find_node_by_path("/");
+	if (!np)
+		return -ENODEV;
+
+	match = of_match_node(machines, np);
+	of_node_put(np);
+
+	if (!match)
+		return 0;
+
+	constraints = match->data;
+
+	dev_boot_constraint_add_deferrable_of(constraints->dev_constraints,
+					      constraints->count);
+
+	return 0;
+}
+
+/*
+ * The amba-pl011 driver registers itself from arch_initcall level. Setup the
+ * serial boot constraints before that in order not to miss any boot messages.
+ */
+postcore_initcall_sync(hikey_constraints_init);
-- 
2.15.0.194.g9af6a3dea062
