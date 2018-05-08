Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933523AbeEHSRe (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 14:17:34 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:33359 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933187AbeEHSRa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 14:17:30 -0400
X-Google-Smtp-Source: AB8JxZpmdJPCgutJ+lN0mC0RvhTB/DBEXM0n/F7Tt8bSM6NC14Jr1FyrLneBG7CNBC4/p6bozXv9fg==
From: Dmitry Osipenko <digetx@gmail.com>
To: Joerg Roedel <joro@8bytes.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/9] memory: tegra: Provide facility for integration with the GART driver
Date: Tue,  8 May 2018 21:16:52 +0300
Message-Id: <20180508181700.5169-2-digetx@gmail.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180508181700.5169-1-digetx@gmail.com>
References: <20180508181700.5169-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to report clients name and access direction on GART page fault,
MC driver needs to access GART registers. Add facility that provides
access to the GART.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/mc.c | 26 +++++++++++++++++++++++---
 include/soc/tegra/mc.h    | 13 +++++++++++++
 2 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
index c81d01caf1a8..49dd7ad1459f 100644
--- a/drivers/memory/tegra/mc.c
+++ b/drivers/memory/tegra/mc.c
@@ -72,6 +72,8 @@ static const struct of_device_id tegra_mc_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, tegra_mc_of_match);
 
+static struct tegra_mc_gart_handle *gart_handle;
+
 static int terga_mc_block_dma_common(struct tegra_mc *mc,
 				     const struct tegra_mc_reset *rst)
 {
@@ -543,6 +545,11 @@ static irqreturn_t tegra_mc_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+void tegra_mc_register_gart(struct tegra_mc_gart_handle *handle)
+{
+	WRITE_ONCE(gart_handle, handle);
+}
+
 static __maybe_unused irqreturn_t tegra20_mc_irq(int irq, void *data)
 {
 	struct tegra_mc *mc = data;
@@ -565,6 +572,7 @@ static __maybe_unused irqreturn_t tegra20_mc_irq(int irq, void *data)
 		switch (BIT(bit)) {
 		case MC_INT_DECERR_EMEM:
 			reg = MC_DECERR_EMEM_OTHERS_STATUS;
+			addr = mc_readl(mc, reg + sizeof(u32));
 			value = mc_readl(mc, reg);
 
 			id = value & mc->soc->client_id_mask;
@@ -575,11 +583,24 @@ static __maybe_unused irqreturn_t tegra20_mc_irq(int irq, void *data)
 			break;
 
 		case MC_INT_INVALID_GART_PAGE:
-			dev_err_ratelimited(mc->dev, "%s\n", error);
-			continue;
+			if (READ_ONCE(gart_handle) == NULL) {
+				dev_err_ratelimited(mc->dev, "%s\n", error);
+				continue;
+			}
+
+			addr = gart_handle->error_addr(gart_handle);
+			value = gart_handle->error_req(gart_handle);
+
+			id = (value >> 1) & mc->soc->client_id_mask;
+			desc = error_names[2];
+
+			if (value & BIT(0))
+				direction = "write";
+			break;
 
 		case MC_INT_SECURITY_VIOLATION:
 			reg = MC_SECURITY_VIOLATION_STATUS;
+			addr = mc_readl(mc, reg + sizeof(u32));
 			value = mc_readl(mc, reg);
 
 			id = value & mc->soc->client_id_mask;
@@ -596,7 +617,6 @@ static __maybe_unused irqreturn_t tegra20_mc_irq(int irq, void *data)
 		}
 
 		client = mc->soc->clients[id].name;
-		addr = mc_readl(mc, reg + sizeof(u32));
 
 		dev_err_ratelimited(mc->dev, "%s: %s%s @%pa: %s (%s)\n",
 				    client, secure, direction, &addr, error,
diff --git a/include/soc/tegra/mc.h b/include/soc/tegra/mc.h
index b43f37fea096..5bf72eb4dd51 100644
--- a/include/soc/tegra/mc.h
+++ b/include/soc/tegra/mc.h
@@ -162,4 +162,17 @@ struct tegra_mc {
 void tegra_mc_write_emem_configuration(struct tegra_mc *mc, unsigned long rate);
 unsigned int tegra_mc_get_emem_device_count(struct tegra_mc *mc);
 
+struct tegra_mc_gart_handle {
+	u32 (*error_addr)(struct tegra_mc_gart_handle *handle);
+	u32 (*error_req)(struct tegra_mc_gart_handle *handle);
+};
+
+#ifdef CONFIG_TEGRA_MC
+void tegra_mc_register_gart(struct tegra_mc_gart_handle *handle);
+#else
+static inline void tegra_mc_register_gart(struct tegra_mc_gart_handle *handle)
+{
+}
+#endif
+
 #endif /* __SOC_TEGRA_MC_H__ */
-- 
2.17.0
