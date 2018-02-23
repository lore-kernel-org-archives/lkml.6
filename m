Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751824AbeBWKZ0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 05:25:26 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:40921 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751444AbeBWKYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 05:24:32 -0500
X-Google-Smtp-Source: AH8x2274OrY7NXd46PXiWfGbiFay2/6BukG8DA0GDNSvwxqSk7WlKOYmQ+S+750TCEPV4sTr/TMlQg==
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
Subject: [PATCH V7 10/13] boot_constraint: Add support for IMX platform
Date: Fri, 23 Feb 2018 15:53:49 +0530
Message-Id: <d422312bdcba54bb8d1c3c18b2b0e866c28e12ad.1519380923.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.15.0.194.g9af6a3dea062
In-Reply-To: <cover.1519380923.git.viresh.kumar@linaro.org>
References: <cover.1519380923.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1519380923.git.viresh.kumar@linaro.org>
References: <cover.1519380923.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds boot constraint support for IMX platforms. Currently only one
use case is supported: earlycon. Some of the UARTs are enabled by the
bootloader and are used for early console in the kernel. The boot
constraint core handles them properly and removes them once the serial
device is probed by its driver.

This gets rid of lots of hacky code in the clock drivers.

Cc: Sascha Hauer <s.hauer@pengutronix.de>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/clk/imx/clk-imx25.c       |  12 ----
 drivers/clk/imx/clk-imx27.c       |  13 ----
 drivers/clk/imx/clk-imx31.c       |  12 ----
 drivers/clk/imx/clk-imx35.c       |  10 ---
 drivers/clk/imx/clk-imx51-imx53.c |  16 -----
 drivers/clk/imx/clk-imx6q.c       |   8 ---
 drivers/clk/imx/clk-imx6sl.c      |   8 ---
 drivers/clk/imx/clk-imx6sx.c      |   8 ---
 drivers/clk/imx/clk-imx7d.c       |  14 -----
 drivers/clk/imx/clk.c             |  38 ------------
 drivers/clk/imx/clk.h             |   1 -
 drivers/soc/imx/Kconfig           |   8 +++
 drivers/soc/imx/Makefile          |   1 +
 drivers/soc/imx/boot_constraint.c | 126 ++++++++++++++++++++++++++++++++++++++
 14 files changed, 135 insertions(+), 140 deletions(-)
 create mode 100644 drivers/soc/imx/boot_constraint.c

diff --git a/drivers/clk/imx/clk-imx25.c b/drivers/clk/imx/clk-imx25.c
index 23686f756b5e..4df652cd912c 100644
--- a/drivers/clk/imx/clk-imx25.c
+++ b/drivers/clk/imx/clk-imx25.c
@@ -86,16 +86,6 @@ enum mx25_clks {
 
 static struct clk *clk[clk_max];
 
-static struct clk ** const uart_clks[] __initconst = {
-	&clk[uart_ipg_per],
-	&clk[uart1_ipg],
-	&clk[uart2_ipg],
-	&clk[uart3_ipg],
-	&clk[uart4_ipg],
-	&clk[uart5_ipg],
-	NULL
-};
-
 static int __init __mx25_clocks_init(void __iomem *ccm_base)
 {
 	BUG_ON(!ccm_base);
@@ -241,8 +231,6 @@ static int __init __mx25_clocks_init(void __iomem *ccm_base)
 	 */
 	clk_set_parent(clk[cko_sel], clk[ipg]);
 
-	imx_register_uart_clocks(uart_clks);
-
 	return 0;
 }
 
diff --git a/drivers/clk/imx/clk-imx27.c b/drivers/clk/imx/clk-imx27.c
index 0a0ab95d16fe..379709d21b04 100644
--- a/drivers/clk/imx/clk-imx27.c
+++ b/drivers/clk/imx/clk-imx27.c
@@ -48,17 +48,6 @@ static const char *ssi_sel_clks[] = { "spll_gate", "mpll", };
 static struct clk *clk[IMX27_CLK_MAX];
 static struct clk_onecell_data clk_data;
 
-static struct clk ** const uart_clks[] __initconst = {
-	&clk[IMX27_CLK_PER1_GATE],
-	&clk[IMX27_CLK_UART1_IPG_GATE],
-	&clk[IMX27_CLK_UART2_IPG_GATE],
-	&clk[IMX27_CLK_UART3_IPG_GATE],
-	&clk[IMX27_CLK_UART4_IPG_GATE],
-	&clk[IMX27_CLK_UART5_IPG_GATE],
-	&clk[IMX27_CLK_UART6_IPG_GATE],
-	NULL
-};
-
 static void __init _mx27_clocks_init(unsigned long fref)
 {
 	BUG_ON(!ccm);
@@ -175,8 +164,6 @@ static void __init _mx27_clocks_init(unsigned long fref)
 
 	clk_prepare_enable(clk[IMX27_CLK_EMI_AHB_GATE]);
 
-	imx_register_uart_clocks(uart_clks);
-
 	imx_print_silicon_rev("i.MX27", mx27_revision());
 }
 
diff --git a/drivers/clk/imx/clk-imx31.c b/drivers/clk/imx/clk-imx31.c
index cbce308aad04..d0a720b61aca 100644
--- a/drivers/clk/imx/clk-imx31.c
+++ b/drivers/clk/imx/clk-imx31.c
@@ -63,16 +63,6 @@ enum mx31_clks {
 static struct clk *clk[clk_max];
 static struct clk_onecell_data clk_data;
 
-static struct clk ** const uart_clks[] __initconst = {
-	&clk[ipg],
-	&clk[uart1_gate],
-	&clk[uart2_gate],
-	&clk[uart3_gate],
-	&clk[uart4_gate],
-	&clk[uart5_gate],
-	NULL
-};
-
 static void __init _mx31_clocks_init(void __iomem *base, unsigned long fref)
 {
 	clk[dummy] = imx_clk_fixed("dummy", 0);
@@ -208,8 +198,6 @@ int __init mx31_clocks_init(unsigned long fref)
 	clk_register_clkdev(clk[sdma_gate], NULL, "imx31-sdma");
 	clk_register_clkdev(clk[iim_gate], "iim", NULL);
 
-
-	imx_register_uart_clocks(uart_clks);
 	mxc_timer_init(MX31_GPT1_BASE_ADDR, MX31_INT_GPT, GPT_TYPE_IMX31);
 
 	return 0;
diff --git a/drivers/clk/imx/clk-imx35.c b/drivers/clk/imx/clk-imx35.c
index 203cad6c9aab..081aacd2335b 100644
--- a/drivers/clk/imx/clk-imx35.c
+++ b/drivers/clk/imx/clk-imx35.c
@@ -86,14 +86,6 @@ enum mx35_clks {
 
 static struct clk *clk[clk_max];
 
-static struct clk ** const uart_clks[] __initconst = {
-	&clk[ipg],
-	&clk[uart1_gate],
-	&clk[uart2_gate],
-	&clk[uart3_gate],
-	NULL
-};
-
 static void __init _mx35_clocks_init(void)
 {
 	void __iomem *base;
@@ -247,8 +239,6 @@ static void __init _mx35_clocks_init(void)
 	 */
 	clk_prepare_enable(clk[scc_gate]);
 
-	imx_register_uart_clocks(uart_clks);
-
 	imx_print_silicon_rev("i.MX35", mx35_revision());
 }
 
diff --git a/drivers/clk/imx/clk-imx51-imx53.c b/drivers/clk/imx/clk-imx51-imx53.c
index c864992e6983..d6af06129491 100644
--- a/drivers/clk/imx/clk-imx51-imx53.c
+++ b/drivers/clk/imx/clk-imx51-imx53.c
@@ -131,20 +131,6 @@ static const char *ieee1588_sels[] = { "pll3_sw", "pll4_sw", "dummy" /* usbphy2_
 static struct clk *clk[IMX5_CLK_END];
 static struct clk_onecell_data clk_data;
 
-static struct clk ** const uart_clks[] __initconst = {
-	&clk[IMX5_CLK_UART1_IPG_GATE],
-	&clk[IMX5_CLK_UART1_PER_GATE],
-	&clk[IMX5_CLK_UART2_IPG_GATE],
-	&clk[IMX5_CLK_UART2_PER_GATE],
-	&clk[IMX5_CLK_UART3_IPG_GATE],
-	&clk[IMX5_CLK_UART3_PER_GATE],
-	&clk[IMX5_CLK_UART4_IPG_GATE],
-	&clk[IMX5_CLK_UART4_PER_GATE],
-	&clk[IMX5_CLK_UART5_IPG_GATE],
-	&clk[IMX5_CLK_UART5_PER_GATE],
-	NULL
-};
-
 static void __init mx5_clocks_common_init(void __iomem *ccm_base)
 {
 	clk[IMX5_CLK_DUMMY]		= imx_clk_fixed("dummy", 0);
@@ -321,8 +307,6 @@ static void __init mx5_clocks_common_init(void __iomem *ccm_base)
 	clk_prepare_enable(clk[IMX5_CLK_TMAX1]);
 	clk_prepare_enable(clk[IMX5_CLK_TMAX2]); /* esdhc2, fec */
 	clk_prepare_enable(clk[IMX5_CLK_TMAX3]); /* esdhc1, esdhc4 */
-
-	imx_register_uart_clocks(uart_clks);
 }
 
 static void __init mx50_clocks_init(struct device_node *np)
diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
index 8d518ad5dc13..255f571c0b0d 100644
--- a/drivers/clk/imx/clk-imx6q.c
+++ b/drivers/clk/imx/clk-imx6q.c
@@ -150,12 +150,6 @@ static inline int clk_on_imx6dl(void)
 	return of_machine_is_compatible("fsl,imx6dl");
 }
 
-static struct clk ** const uart_clks[] __initconst = {
-	&clk[IMX6QDL_CLK_UART_IPG],
-	&clk[IMX6QDL_CLK_UART_SERIAL],
-	NULL
-};
-
 static int ldb_di_sel_by_clock_id(int clock_id)
 {
 	switch (clock_id) {
@@ -918,7 +912,5 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 		clk_set_parent(clk[IMX6QDL_CLK_GPU2D_CORE_SEL],
 			       clk[IMX6QDL_CLK_PLL3_USB_OTG]);
 	}
-
-	imx_register_uart_clocks(uart_clks);
 }
 CLK_OF_DECLARE(imx6q, "fsl,imx6q-ccm", imx6q_clocks_init);
diff --git a/drivers/clk/imx/clk-imx6sl.c b/drivers/clk/imx/clk-imx6sl.c
index 9642cdf0fb88..97ab67783609 100644
--- a/drivers/clk/imx/clk-imx6sl.c
+++ b/drivers/clk/imx/clk-imx6sl.c
@@ -185,12 +185,6 @@ void imx6sl_set_wait_clk(bool enter)
 		imx6sl_enable_pll_arm(false);
 }
 
-static struct clk ** const uart_clks[] __initconst = {
-	&clks[IMX6SL_CLK_UART],
-	&clks[IMX6SL_CLK_UART_SERIAL],
-	NULL
-};
-
 static void __init imx6sl_clocks_init(struct device_node *ccm_node)
 {
 	struct device_node *np;
@@ -447,7 +441,5 @@ static void __init imx6sl_clocks_init(struct device_node *ccm_node)
 
 	clk_set_parent(clks[IMX6SL_CLK_LCDIF_AXI_SEL],
 		       clks[IMX6SL_CLK_PLL2_PFD2]);
-
-	imx_register_uart_clocks(uart_clks);
 }
 CLK_OF_DECLARE(imx6sl, "fsl,imx6sl-ccm", imx6sl_clocks_init);
diff --git a/drivers/clk/imx/clk-imx6sx.c b/drivers/clk/imx/clk-imx6sx.c
index e6d389e333d7..e38dfb855ae8 100644
--- a/drivers/clk/imx/clk-imx6sx.c
+++ b/drivers/clk/imx/clk-imx6sx.c
@@ -137,12 +137,6 @@ static u32 share_count_ssi3;
 static u32 share_count_sai1;
 static u32 share_count_sai2;
 
-static struct clk ** const uart_clks[] __initconst = {
-	&clks[IMX6SX_CLK_UART_IPG],
-	&clks[IMX6SX_CLK_UART_SERIAL],
-	NULL
-};
-
 static void __init imx6sx_clocks_init(struct device_node *ccm_node)
 {
 	struct device_node *np;
@@ -566,7 +560,5 @@ static void __init imx6sx_clocks_init(struct device_node *ccm_node)
 
 	clk_set_parent(clks[IMX6SX_CLK_QSPI1_SEL], clks[IMX6SX_CLK_PLL2_BUS]);
 	clk_set_parent(clks[IMX6SX_CLK_QSPI2_SEL], clks[IMX6SX_CLK_PLL2_BUS]);
-
-	imx_register_uart_clocks(uart_clks);
 }
 CLK_OF_DECLARE(imx6sx, "fsl,imx6sx-ccm", imx6sx_clocks_init);
diff --git a/drivers/clk/imx/clk-imx7d.c b/drivers/clk/imx/clk-imx7d.c
index 80dc211eb74b..91e5bda48df2 100644
--- a/drivers/clk/imx/clk-imx7d.c
+++ b/drivers/clk/imx/clk-imx7d.c
@@ -387,17 +387,6 @@ static int const clks_init_on[] __initconst = {
 
 static struct clk_onecell_data clk_data;
 
-static struct clk ** const uart_clks[] __initconst = {
-	&clks[IMX7D_UART1_ROOT_CLK],
-	&clks[IMX7D_UART2_ROOT_CLK],
-	&clks[IMX7D_UART3_ROOT_CLK],
-	&clks[IMX7D_UART4_ROOT_CLK],
-	&clks[IMX7D_UART5_ROOT_CLK],
-	&clks[IMX7D_UART6_ROOT_CLK],
-	&clks[IMX7D_UART7_ROOT_CLK],
-	NULL
-};
-
 static void __init imx7d_clocks_init(struct device_node *ccm_node)
 {
 	struct device_node *np;
@@ -884,8 +873,5 @@ static void __init imx7d_clocks_init(struct device_node *ccm_node)
 
 	/* set uart module clock's parent clock source that must be great then 80MHz */
 	clk_set_parent(clks[IMX7D_UART1_ROOT_SRC], clks[IMX7D_OSC_24M_CLK]);
-
-	imx_register_uart_clocks(uart_clks);
-
 }
 CLK_OF_DECLARE(imx7d, "fsl,imx7d-ccm", imx7d_clocks_init);
diff --git a/drivers/clk/imx/clk.c b/drivers/clk/imx/clk.c
index 9074e6974b6d..d8a64367a061 100644
--- a/drivers/clk/imx/clk.c
+++ b/drivers/clk/imx/clk.c
@@ -74,41 +74,3 @@ void imx_cscmr1_fixup(u32 *val)
 	*val ^= CSCMR1_FIXUP;
 	return;
 }
-
-static int imx_keep_uart_clocks __initdata;
-static struct clk ** const *imx_uart_clocks __initdata;
-
-static int __init imx_keep_uart_clocks_param(char *str)
-{
-	imx_keep_uart_clocks = 1;
-
-	return 0;
-}
-__setup_param("earlycon", imx_keep_uart_earlycon,
-	      imx_keep_uart_clocks_param, 0);
-__setup_param("earlyprintk", imx_keep_uart_earlyprintk,
-	      imx_keep_uart_clocks_param, 0);
-
-void __init imx_register_uart_clocks(struct clk ** const clks[])
-{
-	if (imx_keep_uart_clocks) {
-		int i;
-
-		imx_uart_clocks = clks;
-		for (i = 0; imx_uart_clocks[i]; i++)
-			clk_prepare_enable(*imx_uart_clocks[i]);
-	}
-}
-
-static int __init imx_clk_disable_uart(void)
-{
-	if (imx_keep_uart_clocks && imx_uart_clocks) {
-		int i;
-
-		for (i = 0; imx_uart_clocks[i]; i++)
-			clk_disable_unprepare(*imx_uart_clocks[i]);
-	}
-
-	return 0;
-}
-late_initcall_sync(imx_clk_disable_uart);
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index d69c4bbf3597..c5edde073cea 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -8,7 +8,6 @@
 extern spinlock_t imx_ccm_lock;
 
 void imx_check_clocks(struct clk *clks[], unsigned int count);
-void imx_register_uart_clocks(struct clk ** const clks[]);
 
 extern void imx_cscmr1_fixup(u32 *val);
 
diff --git a/drivers/soc/imx/Kconfig b/drivers/soc/imx/Kconfig
index a5b86a28f343..7a3fbdfa9db9 100644
--- a/drivers/soc/imx/Kconfig
+++ b/drivers/soc/imx/Kconfig
@@ -7,4 +7,12 @@ config IMX7_PM_DOMAINS
 	select PM_GENERIC_DOMAINS
 	default y if SOC_IMX7D
 
+config IMX_BOOT_CONSTRAINT
+	bool "i.MX Boot Constraints"
+	depends on ARCH_MXC
+	select DEV_BOOT_CONSTRAINT
+	default y
+	help
+	  Say y here to enable Boot Constraints on i.MX platforms.
+
 endmenu
diff --git a/drivers/soc/imx/Makefile b/drivers/soc/imx/Makefile
index aab41a5cc317..49663200faac 100644
--- a/drivers/soc/imx/Makefile
+++ b/drivers/soc/imx/Makefile
@@ -1,2 +1,3 @@
+obj-$(IMXIG_IMX_BOOT_CONSTRAINT) += boot_constraint.o
 obj-$(CONFIG_HAVE_IMX_GPC) += gpc.o
 obj-$(CONFIG_IMX7_PM_DOMAINS) += gpcv2.o
diff --git a/drivers/soc/imx/boot_constraint.c b/drivers/soc/imx/boot_constraint.c
new file mode 100644
index 000000000000..4c52fe3794be
--- /dev/null
+++ b/drivers/soc/imx/boot_constraint.c
@@ -0,0 +1,126 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * This takes care of IMX boot time device constraints, normally set by the
+ * Bootloader.
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
+struct imx_machine_constraints {
+	struct dev_boot_constraint_of *dev_constraints;
+	unsigned int count;
+};
+
+static struct dev_boot_constraint_clk_info uart_ipg_clk_info = {
+	.name = "ipg",
+};
+
+static struct dev_boot_constraint_clk_info uart_per_clk_info = {
+	.name = "per",
+};
+
+static struct dev_boot_constraint imx_uart_constraints[] = {
+	{
+		.type = DEV_BOOT_CONSTRAINT_CLK,
+		.data = &uart_ipg_clk_info,
+	}, {
+		.type = DEV_BOOT_CONSTRAINT_CLK,
+		.data = &uart_per_clk_info,
+	},
+};
+
+static struct dev_boot_constraint_of imx_dev_constraints[] = {
+	{
+		.compat = "fsl,imx21-uart",
+		.constraints = imx_uart_constraints,
+		.count = ARRAY_SIZE(imx_uart_constraints),
+	},
+};
+
+static struct imx_machine_constraints imx_constraints = {
+	.dev_constraints = imx_dev_constraints,
+	.count = ARRAY_SIZE(imx_dev_constraints),
+};
+
+/* imx7 */
+static struct dev_boot_constraint_of imx7_dev_constraints[] = {
+	{
+		.compat = "fsl,imx6q-uart",
+		.constraints = imx_uart_constraints,
+		.count = ARRAY_SIZE(imx_uart_constraints),
+	},
+};
+
+static struct imx_machine_constraints imx7_constraints = {
+	.dev_constraints = imx7_dev_constraints,
+	.count = ARRAY_SIZE(imx7_dev_constraints),
+};
+
+static const struct of_device_id machines[] __initconst = {
+	{ .compatible = "fsl,imx25", .data = &imx_constraints },
+	{ .compatible = "fsl,imx27", .data = &imx_constraints },
+	{ .compatible = "fsl,imx31", .data = &imx_constraints },
+	{ .compatible = "fsl,imx35", .data = &imx_constraints },
+	{ .compatible = "fsl,imx50", .data = &imx_constraints },
+	{ .compatible = "fsl,imx51", .data = &imx_constraints },
+	{ .compatible = "fsl,imx53", .data = &imx_constraints },
+	{ .compatible = "fsl,imx6dl", .data = &imx_constraints },
+	{ .compatible = "fsl,imx6q", .data = &imx_constraints },
+	{ .compatible = "fsl,imx6qp", .data = &imx_constraints },
+	{ .compatible = "fsl,imx6sl", .data = &imx_constraints },
+	{ .compatible = "fsl,imx6sx", .data = &imx_constraints },
+	{ .compatible = "fsl,imx6ul", .data = &imx_constraints },
+	{ .compatible = "fsl,imx6ull", .data = &imx_constraints },
+	{ .compatible = "fsl,imx7d", .data = &imx7_constraints },
+	{ .compatible = "fsl,imx7s", .data = &imx7_constraints },
+	{ }
+};
+
+static int __init imx_constraints_init(void)
+{
+	const struct imx_machine_constraints *constraints;
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
+subsys_initcall(imx_constraints_init);
-- 
2.15.0.194.g9af6a3dea062
