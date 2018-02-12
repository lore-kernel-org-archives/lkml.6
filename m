Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753108AbeBLRHM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 12:07:12 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:44739 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751161AbeBLRHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 12:07:07 -0500
X-Google-Smtp-Source: AH8x227BaUv5bDRHjxmm5izQQ28P5XLfa6eNRbjJ8TAzbXUAAJ+UGhJQA1Wckg0jT2+lCIZZLFf0zg==
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] memory: tegra: Introduce memory client hot reset API
Date: Mon, 12 Feb 2018 20:06:31 +0300
Message-Id: <6eff4be25012d88595a9ef73d3d626e4707b032c.1518452709.git.digetx@gmail.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <cover.1518452709.git.digetx@gmail.com>
References: <cover.1518452709.git.digetx@gmail.com>
In-Reply-To: <cover.1518452709.git.digetx@gmail.com>
References: <cover.1518452709.git.digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to reset busy HW properly, memory controller needs to be
involved, otherwise it possible to get corrupted memory if HW was reset
during DMA. Introduce memory client 'hot reset' API that will be used
for resetting busy HW. The primary users are memory clients related to
video (decoder/encoder/camera) and graphics (2d/3d).

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/mc.c       | 249 ++++++++++++++++++++++++++++++++++++++++
 drivers/memory/tegra/tegra114.c |  25 ++++
 drivers/memory/tegra/tegra124.c |  32 ++++++
 drivers/memory/tegra/tegra20.c  |  23 ++++
 drivers/memory/tegra/tegra210.c |  27 +++++
 drivers/memory/tegra/tegra30.c  |  25 ++++
 include/soc/tegra/mc.h          |  77 +++++++++++++
 7 files changed, 458 insertions(+)

diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index 187a9005351b..9838f588d64d 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -7,11 +7,13 @@
  */
 
 #include <linux/clk.h>
+#include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/reset.h>
 #include <linux/slab.h>
 #include <linux/sort.h>
 
@@ -81,6 +83,172 @@ static const struct of_device_id tegra_mc_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, tegra_mc_of_match);
 
+static int terga_mc_flush_dma(struct tegra_mc *mc, unsigned int id)
+{
+	unsigned int hw_id = mc->soc->modules[id].hw_id;
+	u32 value, reg_poll = mc->soc->reg_client_flush_status;
+	int retries = 3;
+
+	value = mc_readl(mc, mc->soc->reg_client_ctrl);
+
+	if (mc->soc->tegra20)
+		value &= ~BIT(hw_id);
+	else
+		value |= BIT(hw_id);
+
+	/* block clients DMA requests */
+	mc_writel(mc, value, mc->soc->reg_client_ctrl);
+
+	/* wait for completion of the outstanding DMA requests */
+	if (mc->soc->tegra20) {
+		while (mc_readl(mc, reg_poll + hw_id * sizeof(u32)) != 0) {
+			if (!retries--)
+				return -EBUSY;
+
+			usleep_range(1000, 2000);
+		}
+	} else {
+		while ((mc_readl(mc, reg_poll) & BIT(hw_id)) == 0) {
+			if (!retries--)
+				return -EBUSY;
+
+			usleep_range(1000, 2000);
+		}
+	}
+
+	return 0;
+}
+
+static int terga_mc_unblock_dma(struct tegra_mc *mc, unsigned int id)
+{
+	unsigned int hw_id = mc->soc->modules[id].hw_id;
+	u32 value;
+
+	value = mc_readl(mc, mc->soc->reg_client_ctrl);
+
+	if (mc->soc->tegra20)
+		value |= BIT(hw_id);
+	else
+		value &= ~BIT(hw_id);
+
+	mc_writel(mc, value, mc->soc->reg_client_ctrl);
+
+	return 0;
+}
+
+static int terga_mc_hotreset_assert(struct tegra_mc *mc, unsigned int id)
+{
+	unsigned int hw_id = mc->soc->modules[id].hw_id;
+	u32 value;
+
+	if (mc->soc->tegra20) {
+		value = mc_readl(mc, mc->soc->reg_client_hotresetn);
+
+		mc_writel(mc, value & ~BIT(hw_id),
+			  mc->soc->reg_client_hotresetn);
+	}
+
+	return 0;
+}
+
+static int terga_mc_hotreset_deassert(struct tegra_mc *mc, unsigned int id)
+{
+	unsigned int hw_id = mc->soc->modules[id].hw_id;
+	u32 value;
+
+	if (mc->soc->tegra20) {
+		value = mc_readl(mc, mc->soc->reg_client_hotresetn);
+
+		mc_writel(mc, value | BIT(hw_id),
+			  mc->soc->reg_client_hotresetn);
+	}
+
+	return 0;
+}
+
+static int tegra_mc_hot_reset_assert(struct tegra_mc *mc, unsigned int id,
+				     struct reset_control *rst)
+{
+	int err;
+
+	/*
+	 * Block clients DMA requests and wait for completion of the
+	 * outstanding requests.
+	 */
+	err = terga_mc_flush_dma(mc, id);
+	if (err) {
+		dev_err(mc->dev, "Failed to flush DMA: %d\n", err);
+		return err;
+	}
+
+	/* put in reset HW that corresponds to the memory client */
+	err = reset_control_assert(rst);
+	if (err) {
+		dev_err(mc->dev, "Failed to assert HW reset: %d\n", err);
+		return err;
+	}
+
+	/* clear the client requests sitting before arbitration */
+	err = terga_mc_hotreset_assert(mc, id);
+	if (err) {
+		dev_err(mc->dev, "Failed to hot reset client: %d\n", err);
+		return err;
+	}
+
+	return 0;
+}
+
+static int tegra_mc_hot_reset_deassert(struct tegra_mc *mc, unsigned int id,
+				       struct reset_control *rst)
+{
+	int err;
+
+	/* take out client from hot reset */
+	err = terga_mc_hotreset_deassert(mc, id);
+	if (err) {
+		dev_err(mc->dev, "Failed to deassert hot reset: %d\n", err);
+		return err;
+	}
+
+	/* take out from reset corresponding clients HW */
+	err = reset_control_deassert(rst);
+	if (err) {
+		dev_err(mc->dev, "Failed to deassert HW reset: %d\n", err);
+		return err;
+	}
+
+	/* allow new DMA requests to proceed to arbitration */
+	err = terga_mc_unblock_dma(mc, id);
+	if (err) {
+		dev_err(mc->dev, "Failed to unblock client: %d\n", err);
+		return err;
+	}
+
+	return 0;
+}
+
+static int tegra_mc_hot_reset(struct tegra_mc *mc, unsigned int id,
+			      struct reset_control *rst, unsigned long usecs)
+{
+	int err;
+
+	err = tegra_mc_hot_reset_assert(mc, id, rst);
+	if (err)
+		return err;
+
+	/* make sure that reset is propagated */
+	if (usecs < 15)
+		udelay(usecs);
+	else
+		usleep_range(usecs, usecs + 500);
+
+	err = tegra_mc_hot_reset_deassert(mc, id, rst);
+	if (err)
+		return err;
+
+	return 0;
+}
+
 static int tegra_mc_setup_latency_allowance(struct tegra_mc *mc)
 {
 	unsigned long long tick;
@@ -416,6 +584,7 @@ static int tegra_mc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	platform_set_drvdata(pdev, mc);
+	mutex_init(&mc->lock);
 	mc->soc = match->data;
 	mc->dev = &pdev->dev;
 
@@ -499,6 +668,86 @@ static struct platform_driver tegra_mc_driver = {
 	.probe = tegra_mc_probe,
 };
 
+static int tegra_mc_match(struct device *dev, void *data)
+{
+	return of_match_node(tegra_mc_of_match, dev->of_node) != NULL;
+}
+
+static struct tegra_mc *tegra_mc_find_device(void)
+{
+	struct device *dev;
+
+	dev = driver_find_device(&tegra_mc_driver.driver, NULL, NULL,
+				 tegra_mc_match);
+	if (!dev)
+		return NULL;
+
+	return dev_get_drvdata(dev);
+}
+
+int tegra_memory_client_hot_reset(unsigned int id, struct reset_control *rst,
+				  unsigned long usecs)
+{
+	struct tegra_mc *mc;
+	int ret;
+
+	mc = tegra_mc_find_device();
+	if (!mc)
+		return -ENODEV;
+
+	if (id >= mc->soc->num_modules || !mc->soc->modules[id].valid)
+		return -EINVAL;
+
+	mutex_lock(&mc->lock);
+	ret = tegra_mc_hot_reset(mc, id, rst, usecs);
+	mutex_unlock(&mc->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(tegra_memory_client_hot_reset);
+
+int tegra_memory_client_hot_reset_assert(unsigned int id,
+					 struct reset_control *rst)
+{
+	struct tegra_mc *mc;
+	int ret;
+
+	mc = tegra_mc_find_device();
+	if (!mc)
+		return -ENODEV;
+
+	if (id >= mc->soc->num_modules || !mc->soc->modules[id].valid)
+		return -EINVAL;
+
+	mutex_lock(&mc->lock);
+	ret = tegra_mc_hot_reset_assert(mc, id, rst);
+	mutex_unlock(&mc->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(tegra_memory_client_hot_reset_assert);
+
+int tegra_memory_client_hot_reset_deassert(unsigned int id,
+					   struct reset_control *rst)
+{
+	struct tegra_mc *mc;
+	int ret;
+
+	mc = tegra_mc_find_device();
+	if (!mc)
+		return -ENODEV;
+
+	if (id >= mc->soc->num_modules || !mc->soc->modules[id].valid)
+		return -EINVAL;
+
+	mutex_lock(&mc->lock);
+	ret = tegra_mc_hot_reset_deassert(mc, id, rst);
+	mutex_unlock(&mc->lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(tegra_memory_client_hot_reset_deassert);
+
 static int tegra_mc_init(void)
 {
 	return platform_driver_register(&tegra_mc_driver);
diff --git a/drivers/memory/tegra/tegra114.c b/drivers/memory/tegra/tegra114.c
index b20e6e3e208e..d8ad269b6ff5 100644
--- a/drivers/memory/tegra/tegra114.c
+++ b/drivers/memory/tegra/tegra114.c
@@ -938,6 +938,27 @@ static const struct tegra_smmu_soc tegra114_smmu_soc = {
 	.num_asids = 4,
 };
 
+static const struct tegra_mc_module tegra114_mc_modules[] = {
+	[TEGRA_MEMORY_CLIENT_AFI]	= { .hw_id =  0, .valid = true },
+	[TEGRA_MEMORY_CLIENT_AVP]	= { .hw_id =  1, .valid = true },
+	[TEGRA_MEMORY_CLIENT_DC]	= { .hw_id =  2, .valid = true },
+	[TEGRA_MEMORY_CLIENT_DCB]	= { .hw_id =  3, .valid = true },
+	[TEGRA_MEMORY_CLIENT_EPP]	= { .hw_id =  4, .valid = true },
+	[TEGRA_MEMORY_CLIENT_2D]	= { .hw_id =  5, .valid = true },
+	[TEGRA_MEMORY_CLIENT_HOST1X]	= { .hw_id =  6, .valid = true },
+	[TEGRA_MEMORY_CLIENT_HDA]	= { .hw_id =  7, .valid = true },
+	[TEGRA_MEMORY_CLIENT_ISP]	= { .hw_id =  8, .valid = true },
+	[TEGRA_MEMORY_CLIENT_MPCORE]	= { .hw_id =  9, .valid = true },
+	[TEGRA_MEMORY_CLIENT_MPCORELP]	= { .hw_id = 10, .valid = true },
+	[TEGRA_MEMORY_CLIENT_MPE]	= { .hw_id = 11, .valid = true },
+	[TEGRA_MEMORY_CLIENT_3D0]	= { .hw_id = 12, .valid = true },
+	[TEGRA_MEMORY_CLIENT_3D1]	= { .hw_id = 13, .valid = true },
+	[TEGRA_MEMORY_CLIENT_PPCS]	= { .hw_id = 14, .valid = true },
+	[TEGRA_MEMORY_CLIENT_SATA]	= { .hw_id = 15, .valid = true },
+	[TEGRA_MEMORY_CLIENT_VDE]	= { .hw_id = 16, .valid = true },
+	[TEGRA_MEMORY_CLIENT_VI]	= { .hw_id = 17, .valid = true },
+};
+
 const struct tegra_mc_soc tegra114_mc_soc = {
 	.clients = tegra114_mc_clients,
 	.num_clients = ARRAY_SIZE(tegra114_mc_clients),
@@ -945,4 +966,8 @@ const struct tegra_mc_soc tegra114_mc_soc = {
 	.atom_size = 32,
 	.client_id_mask = 0x7f,
 	.smmu = &tegra114_smmu_soc,
+	.modules = tegra114_mc_modules,
+	.num_modules = ARRAY_SIZE(tegra114_mc_modules),
+	.reg_client_ctrl = 0x200,
+	.reg_client_flush_status = 0x204,
 };
diff --git a/drivers/memory/tegra/tegra124.c b/drivers/memory/tegra/tegra124.c
index 8b6360eabb8a..135012c74358 100644
--- a/drivers/memory/tegra/tegra124.c
+++ b/drivers/memory/tegra/tegra124.c
@@ -1012,6 +1012,30 @@ static const struct tegra_smmu_group_soc tegra124_groups[] = {
 	},
 };
 
+static const struct tegra_mc_module tegra124_mc_modules[] = {
+	[TEGRA_MEMORY_CLIENT_AFI]	= { .hw_id =  0, .valid = true },
+	[TEGRA_MEMORY_CLIENT_AVP]	= { .hw_id =  1, .valid = true },
+	[TEGRA_MEMORY_CLIENT_DC]	= { .hw_id =  2, .valid = true },
+	[TEGRA_MEMORY_CLIENT_DCB]	= { .hw_id =  3, .valid = true },
+	[TEGRA_MEMORY_CLIENT_HOST1X]	= { .hw_id =  6, .valid = true },
+	[TEGRA_MEMORY_CLIENT_HDA]	= { .hw_id =  7, .valid = true },
+	[TEGRA_MEMORY_CLIENT_ISP2]	= { .hw_id =  8, .valid = true },
+	[TEGRA_MEMORY_CLIENT_MPCORE]	= { .hw_id =  9, .valid = true },
+	[TEGRA_MEMORY_CLIENT_MPCORELP]	= { .hw_id = 10, .valid = true },
+	[TEGRA_MEMORY_CLIENT_MSENC]	= { .hw_id = 11, .valid = true },
+	[TEGRA_MEMORY_CLIENT_PPCS]	= { .hw_id = 14, .valid = true },
+	[TEGRA_MEMORY_CLIENT_SATA]	= { .hw_id = 15, .valid = true },
+	[TEGRA_MEMORY_CLIENT_VDE]	= { .hw_id = 16, .valid = true },
+	[TEGRA_MEMORY_CLIENT_VI]	= { .hw_id = 17, .valid = true },
+	[TEGRA_MEMORY_CLIENT_VIC]	= { .hw_id = 18, .valid = true },
+	[TEGRA_MEMORY_CLIENT_XUSB_HOST]	= { .hw_id = 19, .valid = true },
+	[TEGRA_MEMORY_CLIENT_XUSB_DEV]	= { .hw_id = 20, .valid = true },
+	[TEGRA_MEMORY_CLIENT_TSEC]	= { .hw_id = 22, .valid = true },
+	[TEGRA_MEMORY_CLIENT_SDMMC1]	= { .hw_id = 29, .valid = true },
+	[TEGRA_MEMORY_CLIENT_SDMMC2]	= { .hw_id = 30, .valid = true },
+	[TEGRA_MEMORY_CLIENT_SDMMC3]	= { .hw_id = 31, .valid = true },
+};
+
 #ifdef CONFIG_ARCH_TEGRA_124_SOC
 static const struct tegra_smmu_soc tegra124_smmu_soc = {
 	.clients = tegra124_mc_clients,
@@ -1035,6 +1059,10 @@ const struct tegra_mc_soc tegra124_mc_soc = {
 	.smmu = &tegra124_smmu_soc,
 	.emem_regs = tegra124_mc_emem_regs,
 	.num_emem_regs = ARRAY_SIZE(tegra124_mc_emem_regs),
+	.modules = tegra124_mc_modules,
+	.num_modules = ARRAY_SIZE(tegra124_mc_modules),
+	.reg_client_ctrl = 0x200,
+	.reg_client_flush_status = 0x204,
 };
 #endif /* CONFIG_ARCH_TEGRA_124_SOC */
 
@@ -1059,5 +1087,9 @@ const struct tegra_mc_soc tegra132_mc_soc = {
 	.atom_size = 32,
 	.client_id_mask = 0x7f,
 	.smmu = &tegra132_smmu_soc,
+	.modules = tegra124_mc_modules,
+	.num_modules = ARRAY_SIZE(tegra124_mc_modules),
+	.reg_client_ctrl = 0x200,
+	.reg_client_flush_status = 0x204,
 };
 #endif /* CONFIG_ARCH_TEGRA_132_SOC */
diff --git a/drivers/memory/tegra/tegra20.c b/drivers/memory/tegra/tegra20.c
index 81a082bdba19..4825013b948a 100644
--- a/drivers/memory/tegra/tegra20.c
+++ b/drivers/memory/tegra/tegra20.c
@@ -63,10 +63,33 @@ static const struct tegra_mc_client tegra20_mc_clients[] = {
 	{ .name = "vdetpmw" },
 };
 
+static const struct tegra_mc_module tegra20_mc_modules[] = {
+	[TEGRA_MEMORY_CLIENT_AVP]	= { .hw_id =  0, .valid = true },
+	[TEGRA_MEMORY_CLIENT_DC]	= { .hw_id =  1, .valid = true },
+	[TEGRA_MEMORY_CLIENT_DCB]	= { .hw_id =  2, .valid = true },
+	[TEGRA_MEMORY_CLIENT_EPP]	= { .hw_id =  3, .valid = true },
+	[TEGRA_MEMORY_CLIENT_2D]	= { .hw_id =  4, .valid = true },
+	[TEGRA_MEMORY_CLIENT_HOST1X]	= { .hw_id =  5, .valid = true },
+	[TEGRA_MEMORY_CLIENT_ISP]	= { .hw_id =  6, .valid = true },
+	[TEGRA_MEMORY_CLIENT_MPCORE]	= { .hw_id =  7, .valid = true },
+	[TEGRA_MEMORY_CLIENT_MPEA]	= { .hw_id =  8, .valid = true },
+	[TEGRA_MEMORY_CLIENT_MPEB]	= { .hw_id =  9, .valid = true },
+	[TEGRA_MEMORY_CLIENT_MPEC]	= { .hw_id = 10, .valid = true },
+	[TEGRA_MEMORY_CLIENT_3D]	= { .hw_id = 11, .valid = true },
+	[TEGRA_MEMORY_CLIENT_PPCS]	= { .hw_id = 12, .valid = true },
+	[TEGRA_MEMORY_CLIENT_VDE]	= { .hw_id = 13, .valid = true },
+	[TEGRA_MEMORY_CLIENT_VI]	= { .hw_id = 14, .valid = true },
+};
+
 const struct tegra_mc_soc tegra20_mc_soc = {
 	.clients = tegra20_mc_clients,
 	.num_clients = ARRAY_SIZE(tegra20_mc_clients),
 	.num_address_bits = 32,
 	.client_id_mask = 0x3f,
 	.tegra20 = true,
+	.modules = tegra20_mc_modules,
+	.num_modules = ARRAY_SIZE(tegra20_mc_modules),
+	.reg_client_ctrl = 0x100,
+	.reg_client_hotresetn = 0x104,
+	.reg_client_flush_status = 0x140,
 };
diff --git a/drivers/memory/tegra/tegra210.c b/drivers/memory/tegra/tegra210.c
index d398bcd3fc57..dfae0e72b632 100644
--- a/drivers/memory/tegra/tegra210.c
+++ b/drivers/memory/tegra/tegra210.c
@@ -1072,6 +1072,29 @@ static const struct tegra_smmu_group_soc tegra210_groups[] = {
 	},
 };
 
+static const struct tegra_mc_module tegra210_mc_modules[] = {
+	[TEGRA_MEMORY_CLIENT_AFI]	= { .hw_id =  0, .valid = true },
+	[TEGRA_MEMORY_CLIENT_AVP]	= { .hw_id =  1, .valid = true },
+	[TEGRA_MEMORY_CLIENT_DC]	= { .hw_id =  2, .valid = true },
+	[TEGRA_MEMORY_CLIENT_DCB]	= { .hw_id =  3, .valid = true },
+	[TEGRA_MEMORY_CLIENT_HOST1X]	= { .hw_id =  6, .valid = true },
+	[TEGRA_MEMORY_CLIENT_HDA]	= { .hw_id =  7, .valid = true },
+	[TEGRA_MEMORY_CLIENT_ISP2]	= { .hw_id =  8, .valid = true },
+	[TEGRA_MEMORY_CLIENT_MPCORE]	= { .hw_id =  9, .valid = true },
+	[TEGRA_MEMORY_CLIENT_MPCORELP]	= { .hw_id = 10, .valid = true },
+	[TEGRA_MEMORY_CLIENT_NVENC]	= { .hw_id = 11, .valid = true },
+	[TEGRA_MEMORY_CLIENT_PPCS]	= { .hw_id = 14, .valid = true },
+	[TEGRA_MEMORY_CLIENT_SATA]	= { .hw_id = 15, .valid = true },
+	[TEGRA_MEMORY_CLIENT_VI]	= { .hw_id = 17, .valid = true },
+	[TEGRA_MEMORY_CLIENT_VIC]	= { .hw_id = 18, .valid = true },
+	[TEGRA_MEMORY_CLIENT_XUSB_HOST]	= { .hw_id = 19, .valid = true },
+	[TEGRA_MEMORY_CLIENT_XUSB_DEV]	= { .hw_id = 20, .valid = true },
+	[TEGRA_MEMORY_CLIENT_TSEC]	= { .hw_id = 22, .valid = true },
+	[TEGRA_MEMORY_CLIENT_SDMMC1]	= { .hw_id = 29, .valid = true },
+	[TEGRA_MEMORY_CLIENT_SDMMC2]	= { .hw_id = 30, .valid = true },
+	[TEGRA_MEMORY_CLIENT_SDMMC3]	= { .hw_id = 31, .valid = true },
+};
+
 static const struct tegra_smmu_soc tegra210_smmu_soc = {
 	.clients = tegra210_mc_clients,
 	.num_clients = ARRAY_SIZE(tegra210_mc_clients),
@@ -1092,4 +1115,8 @@ const struct tegra_mc_soc tegra210_mc_soc = {
 	.atom_size = 64,
 	.client_id_mask = 0xff,
 	.smmu = &tegra210_smmu_soc,
+	.modules = tegra210_mc_modules,
+	.num_modules = ARRAY_SIZE(tegra210_mc_modules),
+	.reg_client_ctrl = 0x200,
+	.reg_client_flush_status = 0x204,
 };
diff --git a/drivers/memory/tegra/tegra30.c b/drivers/memory/tegra/tegra30.c
index d756c837f23e..10a90ae91e31 100644
--- a/drivers/memory/tegra/tegra30.c
+++ b/drivers/memory/tegra/tegra30.c
@@ -960,6 +960,27 @@ static const struct tegra_smmu_soc tegra30_smmu_soc = {
 	.num_asids = 4,
 };
 
+static const struct tegra_mc_module tegra30_mc_modules[] = {
+	[TEGRA_MEMORY_CLIENT_AFI]	= { .hw_id =  0, .valid = true },
+	[TEGRA_MEMORY_CLIENT_AVP]	= { .hw_id =  1, .valid = true },
+	[TEGRA_MEMORY_CLIENT_DC]	= { .hw_id =  2, .valid = true },
+	[TEGRA_MEMORY_CLIENT_DCB]	= { .hw_id =  3, .valid = true },
+	[TEGRA_MEMORY_CLIENT_EPP]	= { .hw_id =  4, .valid = true },
+	[TEGRA_MEMORY_CLIENT_2D]	= { .hw_id =  5, .valid = true },
+	[TEGRA_MEMORY_CLIENT_HOST1X]	= { .hw_id =  6, .valid = true },
+	[TEGRA_MEMORY_CLIENT_HDA]	= { .hw_id =  7, .valid = true },
+	[TEGRA_MEMORY_CLIENT_ISP]	= { .hw_id =  8, .valid = true },
+	[TEGRA_MEMORY_CLIENT_MPCORE]	= { .hw_id =  9, .valid = true },
+	[TEGRA_MEMORY_CLIENT_MPCORELP]	= { .hw_id = 10, .valid = true },
+	[TEGRA_MEMORY_CLIENT_MPE]	= { .hw_id = 11, .valid = true },
+	[TEGRA_MEMORY_CLIENT_3D0]	= { .hw_id = 12, .valid = true },
+	[TEGRA_MEMORY_CLIENT_3D1]	= { .hw_id = 13, .valid = true },
+	[TEGRA_MEMORY_CLIENT_PPCS]	= { .hw_id = 14, .valid = true },
+	[TEGRA_MEMORY_CLIENT_SATA]	= { .hw_id = 15, .valid = true },
+	[TEGRA_MEMORY_CLIENT_VDE]	= { .hw_id = 16, .valid = true },
+	[TEGRA_MEMORY_CLIENT_VI]	= { .hw_id = 17, .valid = true },
+};
+
 const struct tegra_mc_soc tegra30_mc_soc = {
 	.clients = tegra30_mc_clients,
 	.num_clients = ARRAY_SIZE(tegra30_mc_clients),
@@ -967,4 +988,8 @@ const struct tegra_mc_soc tegra30_mc_soc = {
 	.atom_size = 16,
 	.client_id_mask = 0x7f,
 	.smmu = &tegra30_smmu_soc,
+	.modules = tegra30_mc_modules,
+	.num_modules = ARRAY_SIZE(tegra30_mc_modules),
+	.reg_client_ctrl = 0x200,
+	.reg_client_flush_status = 0x204,
 };
diff --git a/include/soc/tegra/mc.h b/include/soc/tegra/mc.h
index 6cfc1dfa3a40..2d36db3ac659 100644
--- a/include/soc/tegra/mc.h
+++ b/include/soc/tegra/mc.h
@@ -9,11 +9,13 @@
 #ifndef __SOC_TEGRA_MC_H__
 #define __SOC_TEGRA_MC_H__
 
+#include <linux/mutex.h>
 #include <linux/types.h>
 
 struct clk;
 struct device;
 struct page;
+struct reset_control;
 
 struct tegra_smmu_enable {
 	unsigned int reg;
@@ -95,6 +97,11 @@ static inline void tegra_smmu_remove(struct tegra_smmu *smmu)
 }
 #endif
 
+struct tegra_mc_module {
+	unsigned int hw_id;
+	bool valid;
+};
+
 struct tegra_mc_soc {
 	const struct tegra_mc_client *clients;
 	unsigned int num_clients;
@@ -110,6 +117,13 @@ struct tegra_mc_soc {
 	const struct tegra_smmu_soc *smmu;
 
 	bool tegra20;
+
+	const struct tegra_mc_module *modules;
+	unsigned int num_modules;
+
+	u32 reg_client_ctrl;
+	u32 reg_client_hotresetn;
+	u32 reg_client_flush_status;
 };
 
 struct tegra_mc {
@@ -124,9 +138,72 @@ struct tegra_mc {
 
 	struct tegra_mc_timing *timings;
 	unsigned int num_timings;
+
+	struct mutex lock;
 };
 
 void tegra_mc_write_emem_configuration(struct tegra_mc *mc, unsigned long rate);
 unsigned int tegra_mc_get_emem_device_count(struct tegra_mc *mc);
 
+#define TEGRA_MEMORY_CLIENT_AVP		0
+#define TEGRA_MEMORY_CLIENT_DC		1
+#define TEGRA_MEMORY_CLIENT_DCB		2
+#define TEGRA_MEMORY_CLIENT_EPP		3
+#define TEGRA_MEMORY_CLIENT_2D		4
+#define TEGRA_MEMORY_CLIENT_HOST1X	5
+#define TEGRA_MEMORY_CLIENT_ISP		6
+#define TEGRA_MEMORY_CLIENT_MPCORE	7
+#define TEGRA_MEMORY_CLIENT_MPCORELP	8
+#define TEGRA_MEMORY_CLIENT_MPEA	9
+#define TEGRA_MEMORY_CLIENT_MPEB	10
+#define TEGRA_MEMORY_CLIENT_MPEC	11
+#define TEGRA_MEMORY_CLIENT_3D		12
+#define TEGRA_MEMORY_CLIENT_3D1		13
+#define TEGRA_MEMORY_CLIENT_PPCS	14
+#define TEGRA_MEMORY_CLIENT_VDE		15
+#define TEGRA_MEMORY_CLIENT_VI		16
+#define TEGRA_MEMORY_CLIENT_AFI		17
+#define TEGRA_MEMORY_CLIENT_HDA		18
+#define TEGRA_MEMORY_CLIENT_SATA	19
+#define TEGRA_MEMORY_CLIENT_MSENC	20
+#define TEGRA_MEMORY_CLIENT_VIC		21
+#define TEGRA_MEMORY_CLIENT_XUSB_HOST	22
+#define TEGRA_MEMORY_CLIENT_XUSB_DEV	23
+#define TEGRA_MEMORY_CLIENT_TSEC	24
+#define TEGRA_MEMORY_CLIENT_SDMMC1	25
+#define TEGRA_MEMORY_CLIENT_SDMMC2	26
+#define TEGRA_MEMORY_CLIENT_SDMMC3	27
+#define TEGRA_MEMORY_CLIENT_MAX		TEGRA_MEMORY_CLIENT_SDMMC3
+
+#define TEGRA_MEMORY_CLIENT_3D0		TEGRA_MEMORY_CLIENT_3D
+#define TEGRA_MEMORY_CLIENT_MPE		TEGRA_MEMORY_CLIENT_MPEA
+#define TEGRA_MEMORY_CLIENT_NVENC	TEGRA_MEMORY_CLIENT_MSENC
+#define TEGRA_MEMORY_CLIENT_ISP2	TEGRA_MEMORY_CLIENT_ISP
+
+#ifdef CONFIG_ARCH_TEGRA
+int tegra_memory_client_hot_reset(unsigned int id, struct reset_control *rst,
+				  unsigned long usecs);
+int tegra_memory_client_hot_reset_assert(unsigned int id,
+					 struct reset_control *rst);
+int tegra_memory_client_hot_reset_deassert(unsigned int id,
+					   struct reset_control *rst);
+#else
+int tegra_memory_client_hot_reset(unsigned int id, struct reset_control *rst)
+{
+	return -ENOSYS;
+}
+
+int tegra_memory_client_hot_reset_assert(unsigned int id,
+					 struct reset_control *rst)
+{
+	return -ENOSYS;
+}
+
+int tegra_memory_client_hot_reset_deassert(unsigned int id,
+					   struct reset_control *rst)
+{
+	return -ENOSYS;
+}
+#endif /* CONFIG_ARCH_TEGRA */
+
 #endif /* __SOC_TEGRA_MC_H__ */
-- 
2.15.1
