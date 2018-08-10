Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91667C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 18:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 592E921EFB
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 18:09:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 592E921EFB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730007AbeHJUk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 16:40:28 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:19080 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729666AbeHJUk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 16:40:28 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b6dd4cd0000>; Fri, 10 Aug 2018 11:09:17 -0700
Received: from HQMAIL103.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 10 Aug 2018 11:09:25 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 10 Aug 2018 11:09:25 -0700
Received: from HQMAIL104.nvidia.com (172.18.146.11) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 10 Aug
 2018 18:09:31 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1347.2 via Frontend
 Transport; Fri, 10 Aug 2018 18:09:31 +0000
Received: from dhcp-10-21-25-168.Nvidia.com (Not Verified[10.21.25.201]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5b6dd4d80002>; Fri, 10 Aug 2018 11:09:31 -0700
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
Subject: [PATCH v2 14/40] mmc: tegra: Set calibration pad voltage reference
Date:   Fri, 10 Aug 2018 21:08:16 +0300
Message-ID: <1533924522-1037-15-git-send-email-avienamo@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533924522-1037-1-git-send-email-avienamo@nvidia.com>
References: <1533924522-1037-1-git-send-email-avienamo@nvidia.com>
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
index a62a3fc..6ddc7c2 100644
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
 
 	sdhci_reset(host, mask);
 
@@ -222,8 +226,14 @@ static void tegra_sdhci_reset(struct sdhci_host *host, u8 mask)
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

