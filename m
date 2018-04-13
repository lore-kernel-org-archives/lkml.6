Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754589AbeDMLgL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 07:36:11 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:37262 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753238AbeDMLgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 07:36:08 -0400
X-Google-Smtp-Source: AIpwx4/7PCPt1soDPaVQGfNV3jvDNalzY2TxiTtFE8IjAIXB+07Ol8zc82uBP8rsE/6iPtGGTBb7nA==
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc: Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 10/15] memory: tegra: Introduce memory client hot reset
Date: Fri, 13 Apr 2018 14:33:49 +0300
Message-Id: <b063a7d44509189495825e73942329aca51e9e69.1523301400.git.digetx@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <cover.1523301400.git.digetx@gmail.com>
References: <cover.1523301400.git.digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to reset busy HW properly, memory controller needs to be
involved, otherwise it is possible to get corrupted memory or hang machine
if HW was reset during DMA. Introduce memory client 'hot reset' that will
be used for resetting of busy HW.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/mc.c | 210 ++++++++++++++++++++++++++++++++++++++
 drivers/memory/tegra/mc.h |   2 +
 include/soc/tegra/mc.h    |  33 ++++++
 3 files changed, 245 insertions(+)

diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index 5932ab33202a..6b211daa99bf 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
@@ -72,6 +73,207 @@ static const struct of_device_id tegra_mc_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, tegra_mc_of_match);
 
+static int terga_mc_block_dma_common(struct tegra_mc *mc,
+				     const struct tegra_mc_reset *rst)
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
+static bool terga_mc_dma_idling_common(struct tegra_mc *mc,
+				       const struct tegra_mc_reset *rst)
+{
+	return (mc_readl(mc, rst->status) & BIT(rst->bit)) != 0;
+}
+
+static int terga_mc_unblock_dma_common(struct tegra_mc *mc,
+				       const struct tegra_mc_reset *rst)
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
+static int terga_mc_reset_status_common(struct tegra_mc *mc,
+					const struct tegra_mc_reset *rst)
+{
+	return (mc_readl(mc, rst->control) & BIT(rst->bit)) != 0;
+}
+
+const struct tegra_mc_reset_ops terga_mc_reset_ops_common = {
+	.block_dma = terga_mc_block_dma_common,
+	.dma_idling = terga_mc_dma_idling_common,
+	.unblock_dma = terga_mc_unblock_dma_common,
+	.reset_status = terga_mc_reset_status_common,
+};
+
+static inline struct tegra_mc *reset_to_mc(struct reset_controller_dev *rcdev)
+{
+	return container_of(rcdev, struct tegra_mc, reset);
+}
+
+static const struct tegra_mc_reset *tegra_mc_reset_find(struct tegra_mc *mc,
+							unsigned long id)
+{
+	unsigned int i;
+
+	for (i = 0; i < mc->soc->num_resets; i++)
+		if (mc->soc->resets[i].id == id)
+			return &mc->soc->resets[i];
+
+	return NULL;
+}
+
+static int tegra_mc_hotreset_assert(struct reset_controller_dev *rcdev,
+				    unsigned long id)
+{
+	struct tegra_mc *mc = reset_to_mc(rcdev);
+	const struct tegra_mc_reset_ops *rst_ops;
+	const struct tegra_mc_reset *rst;
+	int retries = 500;
+	int err;
+
+	rst = tegra_mc_reset_find(mc, id);
+	if (!rst)
+		return -ENODEV;
+
+	rst_ops = mc->soc->reset_ops;
+	if (!rst_ops)
+		return -ENODEV;
+
+	if (rst_ops->block_dma) {
+		/* block clients DMA requests */
+		err = rst_ops->block_dma(mc, rst);
+		if (err) {
+			dev_err(mc->dev, "Failed to block %s DMA: %d\n",
+				rst->name, err);
+			return err;
+		}
+	}
+
+	if (rst_ops->dma_idling) {
+		/* wait for completion of the outstanding DMA requests */
+		while (!rst_ops->dma_idling(mc, rst)) {
+			if (!retries--) {
+				dev_err(mc->dev, "Failed to flush %s DMA\n",
+					rst->name);
+				return -EBUSY;
+			}
+
+			usleep_range(10, 100);
+		}
+	}
+
+	if (rst_ops->hotreset_assert) {
+		/* clear clients DMA requests sitting before arbitration */
+		err = rst_ops->hotreset_assert(mc, rst);
+		if (err) {
+			dev_err(mc->dev, "Failed to hot reset %s: %d\n",
+				rst->name, err);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+static int tegra_mc_hotreset_deassert(struct reset_controller_dev *rcdev,
+				      unsigned long id)
+{
+	struct tegra_mc *mc = reset_to_mc(rcdev);
+	const struct tegra_mc_reset_ops *rst_ops;
+	const struct tegra_mc_reset *rst;
+	int err;
+
+	rst = tegra_mc_reset_find(mc, id);
+	if (!rst)
+		return -ENODEV;
+
+	rst_ops = mc->soc->reset_ops;
+	if (!rst_ops)
+		return -ENODEV;
+
+	if (rst_ops->hotreset_deassert) {
+		/* take out client from hot reset */
+		err = rst_ops->hotreset_deassert(mc, rst);
+		if (err) {
+			dev_err(mc->dev, "Failed to deassert hot reset %s: %d\n",
+				rst->name, err);
+			return err;
+		}
+	}
+
+	if (rst_ops->unblock_dma) {
+		/* allow new DMA requests to proceed to arbitration */
+		err = rst_ops->unblock_dma(mc, rst);
+		if (err) {
+			dev_err(mc->dev, "Failed to unblock %s DMA : %d\n",
+				rst->name, err);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+static int tegra_mc_hotreset_status(struct reset_controller_dev *rcdev,
+				    unsigned long id)
+{
+	struct tegra_mc *mc = reset_to_mc(rcdev);
+	const struct tegra_mc_reset_ops *rst_ops;
+	const struct tegra_mc_reset *rst;
+
+	rst = tegra_mc_reset_find(mc, id);
+	if (!rst)
+		return -ENODEV;
+
+	rst_ops = mc->soc->reset_ops;
+	if (!rst_ops)
+		return -ENODEV;
+
+	return rst_ops->reset_status(mc, rst);
+}
+
+static const struct reset_control_ops tegra_mc_reset_ops = {
+	.assert = tegra_mc_hotreset_assert,
+	.deassert = tegra_mc_hotreset_deassert,
+	.status = tegra_mc_hotreset_status,
+};
+
+static int tegra_mc_reset_setup(struct tegra_mc *mc)
+{
+	int err;
+
+	mc->reset.ops = &tegra_mc_reset_ops;
+	mc->reset.owner = THIS_MODULE;
+	mc->reset.of_node = mc->dev->of_node;
+	mc->reset.of_reset_n_cells = 1;
+	mc->reset.nr_resets = mc->soc->num_resets;
+
+	err = reset_controller_register(&mc->reset);
+	if (err < 0)
+		return err;
+
+	return 0;
+}
+
 static int tegra_mc_setup_latency_allowance(struct tegra_mc *mc)
 {
 	unsigned long long tick;
@@ -432,6 +634,7 @@ static int tegra_mc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	platform_set_drvdata(pdev, mc);
+	spin_lock_init(&mc->lock);
 	mc->soc = match->data;
 	mc->dev = &pdev->dev;
 
@@ -486,6 +689,13 @@ static int tegra_mc_probe(struct platform_device *pdev)
 		}
 	}
 
+	err = tegra_mc_reset_setup(mc);
+	if (err < 0) {
+		dev_err(&pdev->dev, "failed to register reset controller: %d\n",
+			err);
+		return err;
+	}
+
 	mc->irq = platform_get_irq(pdev, 0);
 	if (mc->irq < 0) {
 		dev_err(&pdev->dev, "interrupt not specified\n");
diff --git a/drivers/memory/tegra/mc.h b/drivers/memory/tegra/mc.h
index cdd6911f4079..01065f12ebeb 100644
--- a/drivers/memory/tegra/mc.h
+++ b/drivers/memory/tegra/mc.h
@@ -41,6 +41,8 @@ static inline void mc_writel(struct tegra_mc *mc, u32 value,
 	writel(value, mc->regs + offset);
 }
 
+extern const struct tegra_mc_reset_ops terga_mc_reset_ops_common;
+
 #ifdef CONFIG_ARCH_TEGRA_2x_SOC
 extern const struct tegra_mc_soc tegra20_mc_soc;
 #endif
diff --git a/include/soc/tegra/mc.h b/include/soc/tegra/mc.h
index bea7fe776825..b43f37fea096 100644
--- a/include/soc/tegra/mc.h
+++ b/include/soc/tegra/mc.h
@@ -9,6 +9,7 @@
 #ifndef __SOC_TEGRA_MC_H__
 #define __SOC_TEGRA_MC_H__
 
+#include <linux/reset-controller.h>
 #include <linux/types.h>
 
 struct clk;
@@ -95,6 +96,30 @@ static inline void tegra_smmu_remove(struct tegra_smmu *smmu)
 }
 #endif
 
+struct tegra_mc_reset {
+	const char *name;
+	unsigned long id;
+	unsigned int control;
+	unsigned int status;
+	unsigned int reset;
+	unsigned int bit;
+};
+
+struct tegra_mc_reset_ops {
+	int (*hotreset_assert)(struct tegra_mc *mc,
+			       const struct tegra_mc_reset *rst);
+	int (*hotreset_deassert)(struct tegra_mc *mc,
+				 const struct tegra_mc_reset *rst);
+	int (*block_dma)(struct tegra_mc *mc,
+			 const struct tegra_mc_reset *rst);
+	bool (*dma_idling)(struct tegra_mc *mc,
+			   const struct tegra_mc_reset *rst);
+	int (*unblock_dma)(struct tegra_mc *mc,
+			   const struct tegra_mc_reset *rst);
+	int (*reset_status)(struct tegra_mc *mc,
+			    const struct tegra_mc_reset *rst);
+};
+
 struct tegra_mc_soc {
 	const struct tegra_mc_client *clients;
 	unsigned int num_clients;
@@ -110,6 +135,10 @@ struct tegra_mc_soc {
 	const struct tegra_smmu_soc *smmu;
 
 	u32 intmask;
+
+	const struct tegra_mc_reset_ops *reset_ops;
+	const struct tegra_mc_reset *resets;
+	unsigned int num_resets;
 };
 
 struct tegra_mc {
@@ -124,6 +153,10 @@ struct tegra_mc {
 
 	struct tegra_mc_timing *timings;
 	unsigned int num_timings;
+
+	struct reset_controller_dev reset;
+
+	spinlock_t lock;
 };
 
 void tegra_mc_write_emem_configuration(struct tegra_mc *mc, unsigned long rate);
-- 
2.17.0
