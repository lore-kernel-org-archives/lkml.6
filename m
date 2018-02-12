Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753228AbeBLRHd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 12:07:33 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:37726 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752274AbeBLRHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 12:07:06 -0500
X-Google-Smtp-Source: AH8x225q8ygYmpsith3z/izK6lU24i2JJKwslEzeFtE/eAN8Q4CFXZuZI0u3hRL7m7Pg+hxQ7hu7lg==
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] memory: tegra: Squash tegra20-mc into common tegra-mc driver
Date: Mon, 12 Feb 2018 20:06:30 +0300
Message-Id: <148ce8c56ad764fc8133e0d97e43f9639cae15ff.1518452709.git.digetx@gmail.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <cover.1518452709.git.digetx@gmail.com>
References: <cover.1518452709.git.digetx@gmail.com>
In-Reply-To: <cover.1518452709.git.digetx@gmail.com>
References: <cover.1518452709.git.digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra30+ has some minor differences in registers / bits layout compared
to Tegra20. Let's squash Tegra20 driver into the common tegra-mc driver
to reduce code a tad, this also will be useful for the upcoming Tegra's MC
reset API.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/Kconfig         |  10 --
 drivers/memory/Makefile        |   1 -
 drivers/memory/tegra/Makefile  |   1 +
 drivers/memory/tegra/mc.c      | 184 +++++++++++++++++++----------
 drivers/memory/tegra/mc.h      |  10 ++
 drivers/memory/tegra/tegra20.c |  72 ++++++++++++
 drivers/memory/tegra20-mc.c    | 254 -----------------------------------------
 include/soc/tegra/mc.h         |   4 +-
 8 files changed, 211 insertions(+), 325 deletions(-)
 create mode 100644 drivers/memory/tegra/tegra20.c
 delete mode 100644 drivers/memory/tegra20-mc.c

diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
index 19a0e83f260d..8d731d6c3e54 100644
--- a/drivers/memory/Kconfig
+++ b/drivers/memory/Kconfig
@@ -104,16 +104,6 @@ config MVEBU_DEVBUS
 	  Armada 370 and Armada XP. This controller allows to handle flash
 	  devices such as NOR, NAND, SRAM, and FPGA.
 
-config TEGRA20_MC
-	bool "Tegra20 Memory Controller(MC) driver"
-	default y
-	depends on ARCH_TEGRA_2x_SOC
-	help
-	  This driver is for the Memory Controller(MC) module available
-	  in Tegra20 SoCs, mainly for a address translation fault
-	  analysis, especially for IOMMU/GART(Graphics Address
-	  Relocation Table) module.
-
 config FSL_CORENET_CF
 	tristate "Freescale CoreNet Error Reporting"
 	depends on FSL_SOC_BOOKE
diff --git a/drivers/memory/Makefile b/drivers/memory/Makefile
index 66f55240830e..a01ab3e22f94 100644
--- a/drivers/memory/Makefile
+++ b/drivers/memory/Makefile
@@ -16,7 +16,6 @@ obj-$(CONFIG_OMAP_GPMC)		+= omap-gpmc.o
 obj-$(CONFIG_FSL_CORENET_CF)	+= fsl-corenet-cf.o
 obj-$(CONFIG_FSL_IFC)		+= fsl_ifc.o
 obj-$(CONFIG_MVEBU_DEVBUS)	+= mvebu-devbus.o
-obj-$(CONFIG_TEGRA20_MC)	+= tegra20-mc.o
 obj-$(CONFIG_JZ4780_NEMC)	+= jz4780-nemc.o
 obj-$(CONFIG_MTK_SMI)		+= mtk-smi.o
 obj-$(CONFIG_DA8XX_DDRCTL)	+= da8xx-ddrctl.o
diff --git a/drivers/memory/tegra/Makefile b/drivers/memory/tegra/Makefile
index ce87a9470034..94ab16ba075b 100644
--- a/drivers/memory/tegra/Makefile
+++ b/drivers/memory/tegra/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 tegra-mc-y := mc.o
 
+tegra-mc-$(CONFIG_ARCH_TEGRA_2x_SOC)  += tegra20.o
 tegra-mc-$(CONFIG_ARCH_TEGRA_3x_SOC)  += tegra30.o
 tegra-mc-$(CONFIG_ARCH_TEGRA_114_SOC) += tegra114.o
 tegra-mc-$(CONFIG_ARCH_TEGRA_124_SOC) += tegra124.o
diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index a4803ac192bb..187a9005351b 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -27,6 +27,7 @@
 #define  MC_INT_INVALID_SMMU_PAGE (1 << 10)
 #define  MC_INT_ARBITRATION_EMEM (1 << 9)
 #define  MC_INT_SECURITY_VIOLATION (1 << 8)
+#define  MC_INT_INVALID_GART_PAGE (1 << 7)
 #define  MC_INT_DECERR_EMEM (1 << 6)
 
 #define MC_INTMASK 0x004
@@ -53,7 +54,14 @@
 #define MC_EMEM_ADR_CFG 0x54
 #define MC_EMEM_ADR_CFG_EMEM_NUMDEV BIT(0)
 
+#define MC_GART_ERROR_REQ		0x30
+#define MC_DECERR_EMEM_OTHERS_STATUS	0x58
+#define MC_SECURITY_VIOLATION_STATUS	0x74
+
 static const struct of_device_id tegra_mc_of_match[] = {
+#ifdef CONFIG_ARCH_TEGRA_2x_SOC
+	{ .compatible = "nvidia,tegra20-mc", .data = &tegra20_mc_soc },
+#endif
 #ifdef CONFIG_ARCH_TEGRA_3x_SOC
 	{ .compatible = "nvidia,tegra30-mc", .data = &tegra30_mc_soc },
 #endif
@@ -79,6 +87,9 @@ static int tegra_mc_setup_latency_allowance(struct tegra_mc *mc)
 	unsigned int i;
 	u32 value;
 
+	if (mc->soc->tegra20)
+		return 0;
+
 	/* compute the number of MC clock cycles per tick */
 	tick = mc->tick * clk_get_rate(mc->clk);
 	do_div(tick, NSEC_PER_SEC);
@@ -229,6 +240,7 @@ static int tegra_mc_setup_timings(struct tegra_mc *mc)
 static const char *const status_names[32] = {
 	[ 1] = "External interrupt",
 	[ 6] = "EMEM address decode error",
+	[ 7] = "GART page fault",
 	[ 8] = "Security violation",
 	[ 9] = "EMEM arbitration error",
 	[10] = "Page fault",
@@ -257,78 +269,124 @@ static irqreturn_t tegra_mc_irq(int irq, void *data)
 
 	for_each_set_bit(bit, &status, 32) {
 		const char *error = status_names[bit] ?: "unknown";
-		const char *client = "unknown", *desc;
-		const char *direction, *secure;
+		const char *client = "unknown", *desc = "";
+		const char *direction = "read", *secure = "";
 		phys_addr_t addr = 0;
 		unsigned int i;
-		char perm[7];
+		char perm[7] = { 0 };
 		u8 id, type;
-		u32 value;
+		u32 value, reg;
 
-		value = mc_readl(mc, MC_ERR_STATUS);
+		if (mc->soc->tegra20) {
+			switch (bit) {
+			case 6:
+				reg = MC_DECERR_EMEM_OTHERS_STATUS;
+				value = mc_readl(mc, reg);
 
-#ifdef CONFIG_PHYS_ADDR_T_64BIT
-		if (mc->soc->num_address_bits > 32) {
-			addr = ((value >> MC_ERR_STATUS_ADR_HI_SHIFT) &
-				MC_ERR_STATUS_ADR_HI_MASK);
-			addr <<= 32;
-		}
-#endif
+				id = value & mc->soc->client_id_mask;
+				desc = error_names[2];
 
-		if (value & MC_ERR_STATUS_RW)
-			direction = "write";
-		else
-			direction = "read";
+				if (value & BIT(31))
+					direction = "write";
+				break;
 
-		if (value & MC_ERR_STATUS_SECURITY)
-			secure = "secure ";
-		else
-			secure = "";
+			case 7:
+				reg = MC_GART_ERROR_REQ;
+				value = mc_readl(mc, reg);
 
-		id = value & mc->soc->client_id_mask;
+				id = (value >> 1) & mc->soc->client_id_mask;
+				desc = error_names[2];
 
-		for (i = 0; i < mc->soc->num_clients; i++) {
-			if (mc->soc->clients[i].id == id) {
-				client = mc->soc->clients[i].name;
+				if (value & BIT(0))
+					direction = "write";
+				break;
+
+			case 8:
+				reg = MC_SECURITY_VIOLATION_STATUS;
+				value = mc_readl(mc, reg);
+
+				id = value & mc->soc->client_id_mask;
+				type = (value & BIT(30)) ? 4 : 3;
+				desc = error_names[type];
+				secure = "secure ";
+
+				if (value & BIT(31))
+					direction = "write";
+				break;
+
+			default:
+				reg = 0;
+				direction = "";
+				id = mc->soc->num_clients;
 				break;
 			}
-		}
 
-		type = (value & MC_ERR_STATUS_TYPE_MASK) >>
-		       MC_ERR_STATUS_TYPE_SHIFT;
-		desc = error_names[type];
+			if (id < mc->soc->num_clients)
+				client = mc->soc->clients[id].name;
 
-		switch (value & MC_ERR_STATUS_TYPE_MASK) {
-		case MC_ERR_STATUS_TYPE_INVALID_SMMU_PAGE:
-			perm[0] = ' ';
-			perm[1] = '[';
+			if (reg)
+				addr = mc_readl(mc, reg + sizeof(u32));
+		} else {
+			value = mc_readl(mc, MC_ERR_STATUS);
 
-			if (value & MC_ERR_STATUS_READABLE)
-				perm[2] = 'R';
-			else
-				perm[2] = '-';
+#ifdef CONFIG_PHYS_ADDR_T_64BIT
+			if (mc->soc->num_address_bits > 32) {
+				addr = ((value >> MC_ERR_STATUS_ADR_HI_SHIFT) &
+					MC_ERR_STATUS_ADR_HI_MASK);
+				addr <<= 32;
+			}
+#endif
+			if (value & MC_ERR_STATUS_RW)
+				direction = "write";
 
-			if (value & MC_ERR_STATUS_WRITABLE)
-				perm[3] = 'W';
-			else
-				perm[3] = '-';
+			if (value & MC_ERR_STATUS_SECURITY)
+				secure = "secure ";
 
-			if (value & MC_ERR_STATUS_NONSECURE)
-				perm[4] = '-';
-			else
-				perm[4] = 'S';
+			id = value & mc->soc->client_id_mask;
 
-			perm[5] = ']';
-			perm[6] = '\0';
-			break;
+			for (i = 0; i < mc->soc->num_clients; i++) {
+				if (mc->soc->clients[i].id == id) {
+					client = mc->soc->clients[i].name;
+					break;
+				}
+			}
 
-		default:
-			perm[0] = '\0';
-			break;
-		}
+			type = (value & MC_ERR_STATUS_TYPE_MASK) >>
+			       MC_ERR_STATUS_TYPE_SHIFT;
+			desc = error_names[type];
+
+			switch (value & MC_ERR_STATUS_TYPE_MASK) {
+			case MC_ERR_STATUS_TYPE_INVALID_SMMU_PAGE:
+				perm[0] = ' ';
+				perm[1] = '[';
+
+				if (value & MC_ERR_STATUS_READABLE)
+					perm[2] = 'R';
+				else
+					perm[2] = '-';
+
+				if (value & MC_ERR_STATUS_WRITABLE)
+					perm[3] = 'W';
+				else
+					perm[3] = '-';
 
-		value = mc_readl(mc, MC_ERR_ADR);
-		addr |= value;
+				if (value & MC_ERR_STATUS_NONSECURE)
+					perm[4] = '-';
+				else
+					perm[4] = 'S';
+
+				perm[5] = ']';
+				perm[6] = '\0';
+				break;
+
+			default:
+				perm[0] = '\0';
+				break;
+			}
+
+			value = mc_readl(mc, MC_ERR_ADR);
+			addr |= value;
+		}
 
 		dev_err_ratelimited(mc->dev, "%s: %s%s @%pa: %s (%s%s)\n",
 				    client, secure, direction, &addr, error,
@@ -369,11 +427,18 @@ static int tegra_mc_probe(struct platform_device *pdev)
 	if (IS_ERR(mc->regs))
 		return PTR_ERR(mc->regs);
 
-	mc->clk = devm_clk_get(&pdev->dev, "mc");
-	if (IS_ERR(mc->clk)) {
-		dev_err(&pdev->dev, "failed to get MC clock: %ld\n",
-			PTR_ERR(mc->clk));
-		return PTR_ERR(mc->clk);
+	if (mc->soc->tegra20) {
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+		mc->regs2 = devm_ioremap_resource(&pdev->dev, res);
+		if (IS_ERR(mc->regs2))
+			return PTR_ERR(mc->regs2);
+	} else {
+		mc->clk = devm_clk_get(&pdev->dev, "mc");
+		if (IS_ERR(mc->clk)) {
+			dev_err(&pdev->dev, "failed to get MC clock: %ld\n",
+				PTR_ERR(mc->clk));
+			return PTR_ERR(mc->clk);
+		}
 	}
 
 	err = tegra_mc_setup_latency_allowance(mc);
@@ -416,7 +481,8 @@ static int tegra_mc_probe(struct platform_device *pdev)
 
 	value = MC_INT_DECERR_MTS | MC_INT_SECERR_SEC | MC_INT_DECERR_VPR |
 		MC_INT_INVALID_APB_ASID_UPDATE | MC_INT_INVALID_SMMU_PAGE |
-		MC_INT_SECURITY_VIOLATION | MC_INT_DECERR_EMEM;
+		MC_INT_SECURITY_VIOLATION | MC_INT_DECERR_EMEM |
+		MC_INT_INVALID_GART_PAGE;
 
 	mc_writel(mc, value, MC_INTMASK);
 
diff --git a/drivers/memory/tegra/mc.h b/drivers/memory/tegra/mc.h
index ddb16676c3af..1642fbea5ce3 100644
--- a/drivers/memory/tegra/mc.h
+++ b/drivers/memory/tegra/mc.h
@@ -16,15 +16,25 @@
 
 static inline u32 mc_readl(struct tegra_mc *mc, unsigned long offset)
 {
+	if (mc->soc->tegra20 && offset >= 0x24)
+		return readl(mc->regs2 + offset - 0x3c);
+
 	return readl(mc->regs + offset);
 }
 
 static inline void mc_writel(struct tegra_mc *mc, u32 value,
 			     unsigned long offset)
 {
+	if (mc->soc->tegra20 && offset >= 0x24)
+		return writel(value, mc->regs2 + offset - 0x3c);
+
 	writel(value, mc->regs + offset);
 }
 
+#ifdef CONFIG_ARCH_TEGRA_2x_SOC
+extern const struct tegra_mc_soc tegra20_mc_soc;
+#endif
+
 #ifdef CONFIG_ARCH_TEGRA_3x_SOC
 extern const struct tegra_mc_soc tegra30_mc_soc;
 #endif
diff --git a/drivers/memory/tegra/tegra20.c b/drivers/memory/tegra/tegra20.c
new file mode 100644
index 000000000000..81a082bdba19
--- /dev/null
+++ b/drivers/memory/tegra/tegra20.c
@@ -0,0 +1,72 @@
+/*
+ * Copyright (C) 2012 NVIDIA CORPORATION.  All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include "mc.h"
+
+static const struct tegra_mc_client tegra20_mc_clients[] = {
+	{ .name = "display0a" },
+	{ .name = "display0ab" },
+	{ .name = "display0b" },
+	{ .name = "display0bb" },
+	{ .name = "display0c" },
+	{ .name = "display0cb" },
+	{ .name = "display1b" },
+	{ .name = "display1bb" },
+	{ .name = "eppup" },
+	{ .name = "g2pr" },
+	{ .name = "g2sr" },
+	{ .name = "mpeunifbr" },
+	{ .name = "viruv" },
+	{ .name = "avpcarm7r" },
+	{ .name = "displayhc" },
+	{ .name = "displayhcb" },
+	{ .name = "fdcdrd" },
+	{ .name = "g2dr" },
+	{ .name = "host1xdmar" },
+	{ .name = "host1xr" },
+	{ .name = "idxsrd" },
+	{ .name = "mpcorer" },
+	{ .name = "mpe_ipred" },
+	{ .name = "mpeamemrd" },
+	{ .name = "mpecsrd" },
+	{ .name = "ppcsahbdmar" },
+	{ .name = "ppcsahbslvr" },
+	{ .name = "texsrd" },
+	{ .name = "vdebsevr" },
+	{ .name = "vdember" },
+	{ .name = "vdemcer" },
+	{ .name = "vdetper" },
+	{ .name = "eppu" },
+	{ .name = "eppv" },
+	{ .name = "eppy" },
+	{ .name = "mpeunifbw" },
+	{ .name = "viwsb" },
+	{ .name = "viwu" },
+	{ .name = "viwv" },
+	{ .name = "viwy" },
+	{ .name = "g2dw" },
+	{ .name = "avpcarm7w" },
+	{ .name = "fdcdwr" },
+	{ .name = "host1xw" },
+	{ .name = "ispw" },
+	{ .name = "mpcorew" },
+	{ .name = "mpecswr" },
+	{ .name = "ppcsahbdmaw" },
+	{ .name = "ppcsahbslvw" },
+	{ .name = "vdebsevw" },
+	{ .name = "vdembew" },
+	{ .name = "vdetpmw" },
+};
+
+const struct tegra_mc_soc tegra20_mc_soc = {
+	.clients = tegra20_mc_clients,
+	.num_clients = ARRAY_SIZE(tegra20_mc_clients),
+	.num_address_bits = 32,
+	.client_id_mask = 0x3f,
+	.tegra20 = true,
+};
diff --git a/drivers/memory/tegra20-mc.c b/drivers/memory/tegra20-mc.c
deleted file mode 100644
index cc309a05289a..000000000000
--- a/drivers/memory/tegra20-mc.c
+++ /dev/null
@@ -1,254 +0,0 @@
-/*
- * Tegra20 Memory Controller
- *
- * Copyright (c) 2012, NVIDIA CORPORATION.  All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
- *
- * You should have received a copy of the GNU General Public License along with
- * this program; if not, write to the Free Software Foundation, Inc.,
- * 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
- */
-
-#include <linux/err.h>
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/ratelimit.h>
-#include <linux/platform_device.h>
-#include <linux/interrupt.h>
-#include <linux/io.h>
-
-#define DRV_NAME "tegra20-mc"
-
-#define MC_INTSTATUS			0x0
-#define MC_INTMASK			0x4
-
-#define MC_INT_ERR_SHIFT		6
-#define MC_INT_ERR_MASK			(0x1f << MC_INT_ERR_SHIFT)
-#define MC_INT_DECERR_EMEM		BIT(MC_INT_ERR_SHIFT)
-#define MC_INT_INVALID_GART_PAGE	BIT(MC_INT_ERR_SHIFT + 1)
-#define MC_INT_SECURITY_VIOLATION	BIT(MC_INT_ERR_SHIFT + 2)
-#define MC_INT_ARBITRATION_EMEM		BIT(MC_INT_ERR_SHIFT + 3)
-
-#define MC_GART_ERROR_REQ		0x30
-#define MC_DECERR_EMEM_OTHERS_STATUS	0x58
-#define MC_SECURITY_VIOLATION_STATUS	0x74
-
-#define SECURITY_VIOLATION_TYPE		BIT(30)	/* 0=TRUSTZONE, 1=CARVEOUT */
-
-#define MC_CLIENT_ID_MASK		0x3f
-
-#define NUM_MC_REG_BANKS		2
-
-struct tegra20_mc {
-	void __iomem *regs[NUM_MC_REG_BANKS];
-	struct device *dev;
-};
-
-static inline u32 mc_readl(struct tegra20_mc *mc, u32 offs)
-{
-	u32 val = 0;
-
-	if (offs < 0x24)
-		val = readl(mc->regs[0] + offs);
-	else if (offs < 0x400)
-		val = readl(mc->regs[1] + offs - 0x3c);
-
-	return val;
-}
-
-static inline void mc_writel(struct tegra20_mc *mc, u32 val, u32 offs)
-{
-	if (offs < 0x24)
-		writel(val, mc->regs[0] + offs);
-	else if (offs < 0x400)
-		writel(val, mc->regs[1] + offs - 0x3c);
-}
-
-static const char * const tegra20_mc_client[] = {
-	"cbr_display0a",
-	"cbr_display0ab",
-	"cbr_display0b",
-	"cbr_display0bb",
-	"cbr_display0c",
-	"cbr_display0cb",
-	"cbr_display1b",
-	"cbr_display1bb",
-	"cbr_eppup",
-	"cbr_g2pr",
-	"cbr_g2sr",
-	"cbr_mpeunifbr",
-	"cbr_viruv",
-	"csr_avpcarm7r",
-	"csr_displayhc",
-	"csr_displayhcb",
-	"csr_fdcdrd",
-	"csr_g2dr",
-	"csr_host1xdmar",
-	"csr_host1xr",
-	"csr_idxsrd",
-	"csr_mpcorer",
-	"csr_mpe_ipred",
-	"csr_mpeamemrd",
-	"csr_mpecsrd",
-	"csr_ppcsahbdmar",
-	"csr_ppcsahbslvr",
-	"csr_texsrd",
-	"csr_vdebsevr",
-	"csr_vdember",
-	"csr_vdemcer",
-	"csr_vdetper",
-	"cbw_eppu",
-	"cbw_eppv",
-	"cbw_eppy",
-	"cbw_mpeunifbw",
-	"cbw_viwsb",
-	"cbw_viwu",
-	"cbw_viwv",
-	"cbw_viwy",
-	"ccw_g2dw",
-	"csw_avpcarm7w",
-	"csw_fdcdwr",
-	"csw_host1xw",
-	"csw_ispw",
-	"csw_mpcorew",
-	"csw_mpecswr",
-	"csw_ppcsahbdmaw",
-	"csw_ppcsahbslvw",
-	"csw_vdebsevw",
-	"csw_vdembew",
-	"csw_vdetpmw",
-};
-
-static void tegra20_mc_decode(struct tegra20_mc *mc, int n)
-{
-	u32 addr, req;
-	const char *client = "Unknown";
-	int idx, cid;
-	const struct reg_info {
-		u32 offset;
-		u32 write_bit;	/* 0=READ, 1=WRITE */
-		int cid_shift;
-		char *message;
-	} reg[] = {
-		{
-			.offset = MC_DECERR_EMEM_OTHERS_STATUS,
-			.write_bit = 31,
-			.message = "MC_DECERR",
-		},
-		{
-			.offset	= MC_GART_ERROR_REQ,
-			.cid_shift = 1,
-			.message = "MC_GART_ERR",
-
-		},
-		{
-			.offset = MC_SECURITY_VIOLATION_STATUS,
-			.write_bit = 31,
-			.message = "MC_SECURITY_ERR",
-		},
-	};
-
-	idx = n - MC_INT_ERR_SHIFT;
-	if ((idx < 0) || (idx >= ARRAY_SIZE(reg))) {
-		dev_err_ratelimited(mc->dev, "Unknown interrupt status %08lx\n",
-				    BIT(n));
-		return;
-	}
-
-	req = mc_readl(mc, reg[idx].offset);
-	cid = (req >> reg[idx].cid_shift) & MC_CLIENT_ID_MASK;
-	if (cid < ARRAY_SIZE(tegra20_mc_client))
-		client = tegra20_mc_client[cid];
-
-	addr = mc_readl(mc, reg[idx].offset + sizeof(u32));
-
-	dev_err_ratelimited(mc->dev, "%s (0x%08x): 0x%08x %s (%s %s)\n",
-			   reg[idx].message, req, addr, client,
-			   (req & BIT(reg[idx].write_bit)) ? "write" : "read",
-			   (reg[idx].offset == MC_SECURITY_VIOLATION_STATUS) ?
-			   ((req & SECURITY_VIOLATION_TYPE) ?
-			    "carveout" : "trustzone") : "");
-}
-
-static const struct of_device_id tegra20_mc_of_match[] = {
-	{ .compatible = "nvidia,tegra20-mc", },
-	{},
-};
-
-static irqreturn_t tegra20_mc_isr(int irq, void *data)
-{
-	u32 stat, mask, bit;
-	struct tegra20_mc *mc = data;
-
-	stat = mc_readl(mc, MC_INTSTATUS);
-	mask = mc_readl(mc, MC_INTMASK);
-	mask &= stat;
-	if (!mask)
-		return IRQ_NONE;
-	while ((bit = ffs(mask)) != 0) {
-		tegra20_mc_decode(mc, bit - 1);
-		mask &= ~BIT(bit - 1);
-	}
-
-	mc_writel(mc, stat, MC_INTSTATUS);
-	return IRQ_HANDLED;
-}
-
-static int tegra20_mc_probe(struct platform_device *pdev)
-{
-	struct resource *irq;
-	struct tegra20_mc *mc;
-	int i, err;
-	u32 intmask;
-
-	mc = devm_kzalloc(&pdev->dev, sizeof(*mc), GFP_KERNEL);
-	if (!mc)
-		return -ENOMEM;
-	mc->dev = &pdev->dev;
-
-	for (i = 0; i < ARRAY_SIZE(mc->regs); i++) {
-		struct resource *res;
-
-		res = platform_get_resource(pdev, IORESOURCE_MEM, i);
-		mc->regs[i] = devm_ioremap_resource(&pdev->dev, res);
-		if (IS_ERR(mc->regs[i]))
-			return PTR_ERR(mc->regs[i]);
-	}
-
-	irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!irq)
-		return -ENODEV;
-	err = devm_request_irq(&pdev->dev, irq->start, tegra20_mc_isr,
-			       IRQF_SHARED, dev_name(&pdev->dev), mc);
-	if (err)
-		return -ENODEV;
-
-	platform_set_drvdata(pdev, mc);
-
-	intmask = MC_INT_INVALID_GART_PAGE |
-		MC_INT_DECERR_EMEM | MC_INT_SECURITY_VIOLATION;
-	mc_writel(mc, intmask, MC_INTMASK);
-	return 0;
-}
-
-static struct platform_driver tegra20_mc_driver = {
-	.probe = tegra20_mc_probe,
-	.driver = {
-		.name = DRV_NAME,
-		.of_match_table = tegra20_mc_of_match,
-	},
-};
-module_platform_driver(tegra20_mc_driver);
-
-MODULE_AUTHOR("Hiroshi DOYU <hdoyu@nvidia.com>");
-MODULE_DESCRIPTION("Tegra20 MC driver");
-MODULE_LICENSE("GPL v2");
-MODULE_ALIAS("platform:" DRV_NAME);
diff --git a/include/soc/tegra/mc.h b/include/soc/tegra/mc.h
index 233bae954970..6cfc1dfa3a40 100644
--- a/include/soc/tegra/mc.h
+++ b/include/soc/tegra/mc.h
@@ -108,12 +108,14 @@ struct tegra_mc_soc {
 	u8 client_id_mask;
 
 	const struct tegra_smmu_soc *smmu;
+
+	bool tegra20;
 };
 
 struct tegra_mc {
 	struct device *dev;
 	struct tegra_smmu *smmu;
-	void __iomem *regs;
+	void __iomem *regs, *regs2;
 	struct clk *clk;
 	int irq;
 
-- 
2.15.1
