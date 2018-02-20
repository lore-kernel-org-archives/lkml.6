Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752963AbeBTQ0C (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 11:26:02 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:42104 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752912AbeBTQZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 11:25:58 -0500
X-Google-Smtp-Source: AH8x226gMsZwiEAHRqhfRNium0SgqmVa2scM5gmkzX2unQ9ISpihOwM6AGPPIz167czsTryuS0Cvqg==
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 09/15] memory: tegra: Squash tegra20-mc into common tegra-mc driver
Date: Tue, 20 Feb 2018 19:25:22 +0300
Message-Id: <de9a1f991d32ad01643ae2bc66aa59e231e51e4f.1519141896.git.digetx@gmail.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <cover.1519141896.git.digetx@gmail.com>
References: <cover.1519141896.git.digetx@gmail.com>
In-Reply-To: <cover.1519141896.git.digetx@gmail.com>
References: <cover.1519141896.git.digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra30+ has some minor differences in registers / bits layout compared
to Tegra20. Let's squash Tegra20 driver into the common tegra-mc driver
in a preparation for the upcoming MC hot reset controls implementation,
avoiding code duplication.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/Kconfig         |  10 --
 drivers/memory/Makefile        |   1 -
 drivers/memory/tegra/Makefile  |   1 +
 drivers/memory/tegra/mc.c      | 120 +++++++++++++++++--
 drivers/memory/tegra/mc.h      |  11 ++
 drivers/memory/tegra/tegra20.c | 178 +++++++++++++++++++++++++++++
 drivers/memory/tegra20-mc.c    | 254 -----------------------------------------
 include/soc/tegra/mc.h         |   2 +-
 8 files changed, 299 insertions(+), 278 deletions(-)
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
index 60509f0a386b..10011d61d08c 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -37,6 +37,10 @@
 
 #define MC_ERR_ADR 0x0c
 
+#define MC_GART_ERROR_REQ		0x30
+#define MC_DECERR_EMEM_OTHERS_STATUS	0x58
+#define MC_SECURITY_VIOLATION_STATUS	0x74
+
 #define MC_EMEM_ARB_CFG 0x90
 #define  MC_EMEM_ARB_CFG_CYCLES_PER_UPDATE(x)	(((x) & 0x1ff) << 0)
 #define  MC_EMEM_ARB_CFG_CYCLES_PER_UPDATE_MASK	0x1ff
@@ -46,6 +50,9 @@
 #define MC_EMEM_ADR_CFG_EMEM_NUMDEV BIT(0)
 
 static const struct of_device_id tegra_mc_of_match[] = {
+#ifdef CONFIG_ARCH_TEGRA_2x_SOC
+	{ .compatible = "nvidia,tegra20-mc", .data = &tegra20_mc_soc },
+#endif
 #ifdef CONFIG_ARCH_TEGRA_3x_SOC
 	{ .compatible = "nvidia,tegra30-mc", .data = &tegra30_mc_soc },
 #endif
@@ -221,6 +228,7 @@ static int tegra_mc_setup_timings(struct tegra_mc *mc)
 static const char *const status_names[32] = {
 	[ 1] = "External interrupt",
 	[ 6] = "EMEM address decode error",
+	[ 7] = "GART page fault",
 	[ 8] = "Security violation",
 	[ 9] = "EMEM arbitration error",
 	[10] = "Page fault",
@@ -334,11 +342,85 @@ static irqreturn_t tegra_mc_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t tegra20_mc_irq(int irq, void *data)
+{
+	struct tegra_mc *mc = data;
+	unsigned long status;
+	unsigned int bit;
+
+	/* mask all interrupts to avoid flooding */
+	status = mc_readl(mc, MC_INTSTATUS) & mc->soc->intmask;
+	if (!status)
+		return IRQ_NONE;
+
+	for_each_set_bit(bit, &status, 32) {
+		const char *direction = "read", *secure = "";
+		const char *error = status_names[bit];
+		const char *client, *desc;
+		phys_addr_t addr;
+		u32 value, reg;
+		u8 id, type;
+
+		switch (BIT(bit)) {
+		case MC_INT_DECERR_EMEM:
+			reg = MC_DECERR_EMEM_OTHERS_STATUS;
+			value = mc_readl(mc, reg);
+
+			id = value & mc->soc->client_id_mask;
+			desc = error_names[2];
+
+			if (value & BIT(31))
+				direction = "write";
+			break;
+
+		case MC_INT_INVALID_GART_PAGE:
+			reg = MC_GART_ERROR_REQ;
+			value = mc_readl(mc, reg);
+
+			id = (value >> 1) & mc->soc->client_id_mask;
+			desc = error_names[2];
+
+			if (value & BIT(0))
+				direction = "write";
+			break;
+
+		case MC_INT_SECURITY_VIOLATION:
+			reg = MC_SECURITY_VIOLATION_STATUS;
+			value = mc_readl(mc, reg);
+
+			id = value & mc->soc->client_id_mask;
+			type = (value & BIT(30)) ? 4 : 3;
+			desc = error_names[type];
+			secure = "secure ";
+
+			if (value & BIT(31))
+				direction = "write";
+			break;
+
+		default:
+			continue;
+		}
+
+		client = mc->soc->clients[id].name;
+		addr = mc_readl(mc, reg + sizeof(u32));
+
+		dev_err_ratelimited(mc->dev, "%s: %s%s @%pa: %s (%s)\n",
+				    client, secure, direction, &addr, error,
+				    desc);
+	}
+
+	/* clear interrupts */
+	mc_writel(mc, status, MC_INTSTATUS);
+
+	return IRQ_HANDLED;
+}
+
 static int tegra_mc_probe(struct platform_device *pdev)
 {
 	const struct of_device_id *match;
 	struct resource *res;
 	struct tegra_mc *mc;
+	void *isr;
 	int err;
 
 	match = of_match_node(tegra_mc_of_match, pdev->dev.of_node);
@@ -361,18 +443,32 @@ static int tegra_mc_probe(struct platform_device *pdev)
 	if (IS_ERR(mc->regs))
 		return PTR_ERR(mc->regs);
 
-	mc->clk = devm_clk_get(&pdev->dev, "mc");
-	if (IS_ERR(mc->clk)) {
-		dev_err(&pdev->dev, "failed to get MC clock: %ld\n",
-			PTR_ERR(mc->clk));
-		return PTR_ERR(mc->clk);
-	}
+#ifdef CONFIG_ARCH_TEGRA_2x_SOC
+	if (mc->soc == &tegra20_mc_soc) {
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+		mc->regs2 = devm_ioremap_resource(&pdev->dev, res);
+		if (IS_ERR(mc->regs2))
+			return PTR_ERR(mc->regs2);
 
-	err = tegra_mc_setup_latency_allowance(mc);
-	if (err < 0) {
-		dev_err(&pdev->dev, "failed to setup latency allowance: %d\n",
-			err);
-		return err;
+		isr = tegra20_mc_irq;
+	} else
+#endif
+	{
+		mc->clk = devm_clk_get(&pdev->dev, "mc");
+		if (IS_ERR(mc->clk)) {
+			dev_err(&pdev->dev, "failed to get MC clock: %ld\n",
+				PTR_ERR(mc->clk));
+			return PTR_ERR(mc->clk);
+		}
+
+		err = tegra_mc_setup_latency_allowance(mc);
+		if (err < 0) {
+			dev_err(&pdev->dev, "failed to setup latency allowance: %d\n",
+				err);
+			return err;
+		}
+
+		isr = tegra_mc_irq;
 	}
 
 	err = tegra_mc_setup_timings(mc);
@@ -400,7 +496,7 @@ static int tegra_mc_probe(struct platform_device *pdev)
 
 	mc_writel(mc, mc->soc->intmask, MC_INTMASK);
 
-	err = devm_request_irq(&pdev->dev, mc->irq, tegra_mc_irq, IRQF_SHARED,
+	err = devm_request_irq(&pdev->dev, mc->irq, isr, IRQF_SHARED,
 			       dev_name(&pdev->dev), mc);
 	if (err < 0) {
 		dev_err(&pdev->dev, "failed to request IRQ#%u: %d\n", mc->irq,
diff --git a/drivers/memory/tegra/mc.h b/drivers/memory/tegra/mc.h
index 24e020b4609b..cdd6911f4079 100644
--- a/drivers/memory/tegra/mc.h
+++ b/drivers/memory/tegra/mc.h
@@ -21,19 +21,30 @@
 #define MC_INT_INVALID_SMMU_PAGE (1 << 10)
 #define MC_INT_ARBITRATION_EMEM (1 << 9)
 #define MC_INT_SECURITY_VIOLATION (1 << 8)
+#define MC_INT_INVALID_GART_PAGE (1 << 7)
 #define MC_INT_DECERR_EMEM (1 << 6)
 
 static inline u32 mc_readl(struct tegra_mc *mc, unsigned long offset)
 {
+	if (mc->regs2 && offset >= 0x24)
+		return readl(mc->regs2 + offset - 0x3c);
+
 	return readl(mc->regs + offset);
 }
 
 static inline void mc_writel(struct tegra_mc *mc, u32 value,
 			     unsigned long offset)
 {
+	if (mc->regs2 && offset >= 0x24)
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
index 000000000000..512a3418cb80
--- /dev/null
+++ b/drivers/memory/tegra/tegra20.c
@@ -0,0 +1,178 @@
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
+	{
+		.id = 0x00,
+		.name = "display0a",
+	}, {
+		.id = 0x01,
+		.name = "display0ab",
+	}, {
+		.id = 0x02,
+		.name = "display0b",
+	}, {
+		.id = 0x03,
+		.name = "display0bb",
+	}, {
+		.id = 0x04,
+		.name = "display0c",
+	}, {
+		.id = 0x05,
+		.name = "display0cb",
+	}, {
+		.id = 0x06,
+		.name = "display1b",
+	}, {
+		.id = 0x07,
+		.name = "display1bb",
+	}, {
+		.id = 0x08,
+		.name = "eppup",
+	}, {
+		.id = 0x09,
+		.name = "g2pr",
+	}, {
+		.id = 0x0a,
+		.name = "g2sr",
+	}, {
+		.id = 0x0b,
+		.name = "mpeunifbr",
+	}, {
+		.id = 0x0c,
+		.name = "viruv",
+	}, {
+		.id = 0x0d,
+		.name = "avpcarm7r",
+	}, {
+		.id = 0x0e,
+		.name = "displayhc",
+	}, {
+		.id = 0x0f,
+		.name = "displayhcb",
+	}, {
+		.id = 0x10,
+		.name = "fdcdrd",
+	}, {
+		.id = 0x11,
+		.name = "g2dr",
+	}, {
+		.id = 0x12,
+		.name = "host1xdmar",
+	}, {
+		.id = 0x13,
+		.name = "host1xr",
+	}, {
+		.id = 0x14,
+		.name = "idxsrd",
+	}, {
+		.id = 0x15,
+		.name = "mpcorer",
+	}, {
+		.id = 0x16,
+		.name = "mpe_ipred",
+	}, {
+		.id = 0x17,
+		.name = "mpeamemrd",
+	}, {
+		.id = 0x18,
+		.name = "mpecsrd",
+	}, {
+		.id = 0x19,
+		.name = "ppcsahbdmar",
+	}, {
+		.id = 0x1a,
+		.name = "ppcsahbslvr",
+	}, {
+		.id = 0x1b,
+		.name = "texsrd",
+	}, {
+		.id = 0x1c,
+		.name = "vdebsevr",
+	}, {
+		.id = 0x1d,
+		.name = "vdember",
+	}, {
+		.id = 0x1e,
+		.name = "vdemcer",
+	}, {
+		.id = 0x1f,
+		.name = "vdetper",
+	}, {
+		.id = 0x20,
+		.name = "eppu",
+	}, {
+		.id = 0x21,
+		.name = "eppv",
+	}, {
+		.id = 0x22,
+		.name = "eppy",
+	}, {
+		.id = 0x23,
+		.name = "mpeunifbw",
+	}, {
+		.id = 0x24,
+		.name = "viwsb",
+	}, {
+		.id = 0x25,
+		.name = "viwu",
+	}, {
+		.id = 0x26,
+		.name = "viwv",
+	}, {
+		.id = 0x27,
+		.name = "viwy",
+	}, {
+		.id = 0x28,
+		.name = "g2dw",
+	}, {
+		.id = 0x29,
+		.name = "avpcarm7w",
+	}, {
+		.id = 0x2a,
+		.name = "fdcdwr",
+	}, {
+		.id = 0x2b,
+		.name = "host1xw",
+	}, {
+		.id = 0x2c,
+		.name = "ispw",
+	}, {
+		.id = 0x2d,
+		.name = "mpcorew",
+	}, {
+		.id = 0x2e,
+		.name = "mpecswr",
+	}, {
+		.id = 0x2f,
+		.name = "ppcsahbdmaw",
+	}, {
+		.id = 0x30,
+		.name = "ppcsahbslvw",
+	}, {
+		.id = 0x31,
+		.name = "vdebsevw",
+	}, {
+		.id = 0x32,
+		.name = "vdembew",
+	}, {
+		.id = 0x33,
+		.name = "vdetpmw",
+	},
+};
+
+const struct tegra_mc_soc tegra20_mc_soc = {
+	.clients = tegra20_mc_clients,
+	.num_clients = ARRAY_SIZE(tegra20_mc_clients),
+	.num_address_bits = 32,
+	.client_id_mask = 0x3f,
+	.intmask = MC_INT_SECURITY_VIOLATION | MC_INT_INVALID_GART_PAGE |
+		   MC_INT_DECERR_EMEM,
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
index be6e49124c6d..bea7fe776825 100644
--- a/include/soc/tegra/mc.h
+++ b/include/soc/tegra/mc.h
@@ -115,7 +115,7 @@ struct tegra_mc_soc {
 struct tegra_mc {
 	struct device *dev;
 	struct tegra_smmu *smmu;
-	void __iomem *regs;
+	void __iomem *regs, *regs2;
 	struct clk *clk;
 	int irq;
 
-- 
2.16.1
