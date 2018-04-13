Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754700AbeDMLgc (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 07:36:32 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:32907 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754601AbeDMLgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 07:36:14 -0400
X-Google-Smtp-Source: AIpwx48+GTfOE6ueGktViInOLyxHSAOKbs+eWIJUT435yAdqa6FzmDJG8rkX1gfk7izCtmOMvvjN8A==
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc: Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 15/15] memory: tegra: Add Tegra20 memory controller hot resets
Date: Fri, 13 Apr 2018 14:33:54 +0300
Message-Id: <960c7443136f862e366df1d09d0513ec337eb30a.1523301400.git.digetx@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <b063a7d44509189495825e73942329aca51e9e69.1523301400.git.digetx@gmail.com>
References: <b063a7d44509189495825e73942329aca51e9e69.1523301400.git.digetx@gmail.com>
In-Reply-To: <cover.1523301400.git.digetx@gmail.com>
References: <cover.1523301400.git.digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define the table of memory controller hot resets for Tegra20 and add
specific to Tegra20 hot reset operations.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/tegra20.c | 118 +++++++++++++++++++++++++++++++++
 1 file changed, 118 insertions(+)

diff --git a/drivers/memory/tegra/tegra20.c b/drivers/memory/tegra/tegra20.c
index 512a3418cb80..7119e532471c 100644
--- a/drivers/memory/tegra/tegra20.c
+++ b/drivers/memory/tegra/tegra20.c
@@ -6,6 +6,8 @@
  * published by the Free Software Foundation.
  */
 
+#include <dt-bindings/memory/tegra20-mc.h>
+
 #include "mc.h"
 
 static const struct tegra_mc_client tegra20_mc_clients[] = {
@@ -168,6 +170,119 @@ static const struct tegra_mc_client tegra20_mc_clients[] = {
 	},
 };
 
+#define TEGRA20_MC_RESET(_name, _control, _status, _reset, _bit)	\
+	{								\
+		.name = #_name,						\
+		.id = TEGRA20_MC_RESET_##_name,				\
+		.control = _control,					\
+		.status = _status,					\
+		.reset = _reset,					\
+		.bit = _bit,						\
+	}
+
+static const struct tegra_mc_reset tegra20_mc_resets[] = {
+	TEGRA20_MC_RESET(AVPC,   0x100, 0x140, 0x104,  0),
+	TEGRA20_MC_RESET(DC,     0x100, 0x144, 0x104,  1),
+	TEGRA20_MC_RESET(DCB,    0x100, 0x148, 0x104,  2),
+	TEGRA20_MC_RESET(EPP,    0x100, 0x14c, 0x104,  3),
+	TEGRA20_MC_RESET(2D,     0x100, 0x150, 0x104,  4),
+	TEGRA20_MC_RESET(HC,     0x100, 0x154, 0x104,  5),
+	TEGRA20_MC_RESET(ISP,    0x100, 0x158, 0x104,  6),
+	TEGRA20_MC_RESET(MPCORE, 0x100, 0x15c, 0x104,  7),
+	TEGRA20_MC_RESET(MPEA,   0x100, 0x160, 0x104,  8),
+	TEGRA20_MC_RESET(MPEB,   0x100, 0x164, 0x104,  9),
+	TEGRA20_MC_RESET(MPEC,   0x100, 0x168, 0x104, 10),
+	TEGRA20_MC_RESET(3D,     0x100, 0x16c, 0x104, 11),
+	TEGRA20_MC_RESET(PPCS,   0x100, 0x170, 0x104, 12),
+	TEGRA20_MC_RESET(VDE,    0x100, 0x174, 0x104, 13),
+	TEGRA20_MC_RESET(VI,     0x100, 0x178, 0x104, 14),
+};
+
+static int terga20_mc_hotreset_assert(struct tegra_mc *mc,
+				      const struct tegra_mc_reset *rst)
+{
+	unsigned long flags;
+	u32 value;
+
+	spin_lock_irqsave(&mc->lock, flags);
+
+	value = mc_readl(mc, rst->reset);
+	mc_writel(mc, value & ~BIT(rst->bit), rst->reset);
+
+	spin_unlock_irqrestore(&mc->lock, flags);
+
+	return 0;
+}
+
+static int terga20_mc_hotreset_deassert(struct tegra_mc *mc,
+					const struct tegra_mc_reset *rst)
+{
+	unsigned long flags;
+	u32 value;
+
+	spin_lock_irqsave(&mc->lock, flags);
+
+	value = mc_readl(mc, rst->reset);
+	mc_writel(mc, value | BIT(rst->bit), rst->reset);
+
+	spin_unlock_irqrestore(&mc->lock, flags);
+
+	return 0;
+}
+
+static int terga20_mc_block_dma(struct tegra_mc *mc,
+				const struct tegra_mc_reset *rst)
+{
+	unsigned long flags;
+	u32 value;
+
+	spin_lock_irqsave(&mc->lock, flags);
+
+	value = mc_readl(mc, rst->control) & ~BIT(rst->bit);
+	mc_writel(mc, value, rst->control);
+
+	spin_unlock_irqrestore(&mc->lock, flags);
+
+	return 0;
+}
+
+static bool terga20_mc_dma_idling(struct tegra_mc *mc,
+				  const struct tegra_mc_reset *rst)
+{
+	return mc_readl(mc, rst->status) == 0;
+}
+
+static int terga20_mc_reset_status(struct tegra_mc *mc,
+				   const struct tegra_mc_reset *rst)
+{
+	return (mc_readl(mc, rst->reset) & BIT(rst->bit)) == 0;
+}
+
+static int terga20_mc_unblock_dma(struct tegra_mc *mc,
+				  const struct tegra_mc_reset *rst)
+{
+	unsigned long flags;
+	u32 value;
+
+	spin_lock_irqsave(&mc->lock, flags);
+
+	value = mc_readl(mc, rst->control) | BIT(rst->bit);
+	mc_writel(mc, value, rst->control);
+
+	spin_unlock_irqrestore(&mc->lock, flags);
+
+	return 0;
+}
+
+const struct tegra_mc_reset_ops terga20_mc_reset_ops = {
+	.hotreset_assert = terga20_mc_hotreset_assert,
+	.hotreset_deassert = terga20_mc_hotreset_deassert,
+	.block_dma = terga20_mc_block_dma,
+	.dma_idling = terga20_mc_dma_idling,
+	.unblock_dma = terga20_mc_unblock_dma,
+	.reset_status = terga20_mc_reset_status,
+};
+
 const struct tegra_mc_soc tegra20_mc_soc = {
 	.clients = tegra20_mc_clients,
 	.num_clients = ARRAY_SIZE(tegra20_mc_clients),
@@ -175,4 +290,7 @@ const struct tegra_mc_soc tegra20_mc_soc = {
 	.client_id_mask = 0x3f,
 	.intmask = MC_INT_SECURITY_VIOLATION | MC_INT_INVALID_GART_PAGE |
 		   MC_INT_DECERR_EMEM,
+	.reset_ops = &terga20_mc_reset_ops,
+	.resets = tegra20_mc_resets,
+	.num_resets = ARRAY_SIZE(tegra20_mc_resets),
 };
-- 
2.17.0
