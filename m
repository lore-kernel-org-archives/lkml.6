Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07DE0C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 16:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B974A208A4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 16:33:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B974A208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390481AbeHAST6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 14:19:58 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:3276 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390465AbeHAST5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 14:19:57 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b61e0c90007>; Wed, 01 Aug 2018 09:33:13 -0700
Received: from HQMAIL105.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 01 Aug 2018 09:33:25 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 01 Aug 2018 09:33:25 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 1 Aug
 2018 16:33:24 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1347.2 via Frontend
 Transport; Wed, 1 Aug 2018 16:33:24 +0000
Received: from dhcp-10-21-25-168.Nvidia.com (Not Verified[10.21.25.201]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5b61e0d10002>; Wed, 01 Aug 2018 09:33:24 -0700
From:   Aapo Vienamo <avienamo@nvidia.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Stefan Agner <stefan@agner.ch>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        Aapo Vienamo <avienamo@nvidia.com>
Subject: [PATCH 14/40] mmc: tegra: Set calibration pad voltage reference
Date:   Wed, 1 Aug 2018 19:32:04 +0300
Message-ID: <1533141150-10511-15-git-send-email-avienamo@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533141150-10511-1-git-send-email-avienamo@nvidia.com>
References: <1533141150-10511-1-git-send-email-avienamo@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Configure the voltage reference used by the automatic pad drive strength
calibration procedure. The value is a magic number from the TRM.

Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 56 +++++++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 23 deletions(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index c8ff267..53c035b9 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -41,27 +41,31 @@
 #define SDHCI_CLOCK_CTRL_PADPIPE_CLKEN_OVERRIDE		BIT(3)
 #define SDHCI_CLOCK_CTRL_SPI_MODE_CLKEN_OVERRIDE	BIT(2)
 
-#define SDHCI_TEGRA_VENDOR_MISC_CTRL		0x120
-#define SDHCI_MISC_CTRL_ENABLE_SDR104		0x8
-#define SDHCI_MISC_CTRL_ENABLE_SDR50		0x10
-#define SDHCI_MISC_CTRL_ENABLE_SDHCI_SPEC_300	0x20
-#define SDHCI_MISC_CTRL_ENABLE_DDR50		0x200
-
-#define SDHCI_TEGRA_AUTO_CAL_CONFIG		0x1e4
-#define SDHCI_AUTO_CAL_START			BIT(31)
-#define SDHCI_AUTO_CAL_ENABLE			BIT(29)
-
-#define SDHCI_TEGRA_AUTO_CAL_STATUS		0x1ec
-#define SDHCI_TEGRA_AUTO_CAL_ACTIVE		BIT(31)
-
-#define NVQUIRK_FORCE_SDHCI_SPEC_200	BIT(0)
-#define NVQUIRK_ENABLE_BLOCK_GAP_DET	BIT(1)
-#define NVQUIRK_ENABLE_SDHCI_SPEC_300	BIT(2)
-#define NVQUIRK_ENABLE_SDR50		BIT(3)
-#define NVQUIRK_ENABLE_SDR104		BIT(4)
-#define NVQUIRK_ENABLE_DDR50		BIT(5)
-#define NVQUIRK_HAS_PADCALIB		BIT(6)
-#define NVQUIRK_NEEDS_PAD_CONTROL	BIT(7)
+#define SDHCI_TEGRA_VENDOR_MISC_CTRL			0x120
+#define SDHCI_MISC_CTRL_ENABLE_SDR104			0x8
+#define SDHCI_MISC_CTRL_ENABLE_SDR50			0x10
+#define SDHCI_MISC_CTRL_ENABLE_SDHCI_SPEC_300		0x20
+#define SDHCI_MISC_CTRL_ENABLE_DDR50			0x200
+
+#define SDHCI_TEGRA_AUTO_CAL_CONFIG			0x1e4
+#define SDHCI_AUTO_CAL_START				BIT(31)
+#define SDHCI_AUTO_CAL_ENABLE				BIT(29)
+
+#define SDHCI_TEGRA_SDMEM_COMP_PADCTRL			0x1e0
+#define SDHCI_TEGRA_SDMEM_COMP_PADCTRL_VREF_SEL_MASK	0x0000000f
+#define SDHCI_TEGRA_SDMEM_COMP_PADCTRL_VREF_SEL_VAL	0x7
+
+#define SDHCI_TEGRA_AUTO_CAL_STATUS			0x1ec
+#define SDHCI_TEGRA_AUTO_CAL_ACTIVE			BIT(31)
+
+#define NVQUIRK_FORCE_SDHCI_SPEC_200			BIT(0)
+#define NVQUIRK_ENABLE_BLOCK_GAP_DET			BIT(1)
+#define NVQUIRK_ENABLE_SDHCI_SPEC_300			BIT(2)
+#define NVQUIRK_ENABLE_SDR50				BIT(3)
+#define NVQUIRK_ENABLE_SDR104				BIT(4)
+#define NVQUIRK_ENABLE_DDR50				BIT(5)
+#define NVQUIRK_HAS_PADCALIB				BIT(6)
+#define NVQUIRK_NEEDS_PAD_CONTROL			BIT(7)
 
 struct sdhci_tegra_soc_data {
 	const struct sdhci_pltfm_data *pdata;
@@ -187,7 +191,7 @@ static void tegra_sdhci_reset(struct sdhci_host *host, u8 mask)
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
 	const struct sdhci_tegra_soc_data *soc_data = tegra_host->soc_data;
-	u32 misc_ctrl, clk_ctrl;
+	u32 misc_ctrl, clk_ctrl, pad_ctrl;
 	bool pad_and_regulators_valid;
 
 	sdhci_reset(host, mask);
@@ -224,8 +228,14 @@ static void tegra_sdhci_reset(struct sdhci_host *host, u8 mask)
 	sdhci_writel(host, misc_ctrl, SDHCI_TEGRA_VENDOR_MISC_CTRL);
 	sdhci_writel(host, clk_ctrl, SDHCI_TEGRA_VENDOR_CLOCK_CTRL);
 
-	if (soc_data->nvquirks & NVQUIRK_HAS_PADCALIB)
+	if (soc_data->nvquirks & NVQUIRK_HAS_PADCALIB) {
+		pad_ctrl = sdhci_readl(host, SDHCI_TEGRA_SDMEM_COMP_PADCTRL);
+		pad_ctrl &= ~SDHCI_TEGRA_SDMEM_COMP_PADCTRL_VREF_SEL_MASK;
+		pad_ctrl |= SDHCI_TEGRA_SDMEM_COMP_PADCTRL_VREF_SEL_VAL;
+		sdhci_writel(host, pad_ctrl, SDHCI_TEGRA_SDMEM_COMP_PADCTRL);
+
 		tegra_host->pad_calib_required = true;
+	}
 
 	tegra_host->ddr_signaling = false;
 }
-- 
2.7.4

