Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754639AbeCGNWY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 08:22:24 -0500
Received: from fllnx209.ext.ti.com ([198.47.19.16]:62607 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754545AbeCGNVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 08:21:52 -0500
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Tony Lindgren <tony@atomide.com>,
        Adrian Hunter <adrian.hunter@intel.com>
CC: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>, <kishon@ti.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3 11/11] mmc: sdhci-omap: Add sdhci_omap specific ops for enable_sdio_irq
Date: Wed, 7 Mar 2018 18:50:20 +0530
Message-ID: <20180307132020.30951-12-kishon@ti.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180307132020.30951-1-kishon@ti.com>
References: <20180307132020.30951-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sdhci_omap_enable_sdio_irq to set CTPL and CLKEXTFREE bits in
MMCHS_CON register required to detect asynchronous card interrupt
on DAT[1].

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/mmc/host/sdhci-omap.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index 14dd51b51b41..8ceb3956b211 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -36,6 +36,7 @@
 #define CON_DDR			BIT(19)
 #define CON_CLKEXTFREE		BIT(16)
 #define CON_PADEN		BIT(15)
+#define CON_CTPL		BIT(11)
 #define CON_INIT		BIT(1)
 #define CON_OD			BIT(0)
 
@@ -226,6 +227,23 @@ static void sdhci_omap_conf_bus_power(struct sdhci_omap_host *omap_host,
 	}
 }
 
+static void sdhci_omap_enable_sdio_irq(struct mmc_host *mmc, int enable)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_omap_host *omap_host = sdhci_pltfm_priv(pltfm_host);
+	u32 reg;
+
+	reg = sdhci_omap_readl(omap_host, SDHCI_OMAP_CON);
+	if (enable)
+		reg |= (CON_CTPL | CON_CLKEXTFREE);
+	else
+		reg &= ~(CON_CTPL | CON_CLKEXTFREE);
+	sdhci_omap_writel(omap_host, SDHCI_OMAP_CON, reg);
+
+	sdhci_enable_sdio_irq(mmc, enable);
+}
+
 static inline void sdhci_omap_set_dll(struct sdhci_omap_host *omap_host,
 				      int count)
 {
@@ -962,6 +980,7 @@ static int sdhci_omap_probe(struct platform_device *pdev)
 	host->mmc_host_ops.set_ios = sdhci_omap_set_ios;
 	host->mmc_host_ops.card_busy = sdhci_omap_card_busy;
 	host->mmc_host_ops.execute_tuning = sdhci_omap_execute_tuning;
+	host->mmc_host_ops.enable_sdio_irq = sdhci_omap_enable_sdio_irq;
 
 	ret = sdhci_setup_host(host);
 	if (ret)
-- 
2.11.0
