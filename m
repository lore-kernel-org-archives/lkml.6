Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A7FDC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 14:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D0AC217B7
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 14:00:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D0AC217B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389439AbeHGQOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 12:14:53 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:8884 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389244AbeHGQOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 12:14:52 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b69a5e90000>; Tue, 07 Aug 2018 07:00:09 -0700
Received: from HQMAIL106.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 07 Aug 2018 07:00:23 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 07 Aug 2018 07:00:23 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 7 Aug
 2018 14:00:22 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1347.2 via Frontend
 Transport; Tue, 7 Aug 2018 14:00:22 +0000
Received: from dhcp-10-21-25-168.Nvidia.com (Not Verified[10.21.25.201]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5b69a5f40003>; Tue, 07 Aug 2018 07:00:22 -0700
From:   Aapo Vienamo <avienamo@nvidia.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mikko Perttunen <mperttunen@nvidia.com>
CC:     <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Aapo Vienamo <avienamo@nvidia.com>
Subject: [PATCH 2/8] mmc: tegra: Parse and program DQS trim value
Date:   Tue, 7 Aug 2018 16:59:58 +0300
Message-ID: <1533650404-18125-3-git-send-email-avienamo@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533650404-18125-1-git-send-email-avienamo@nvidia.com>
References: <1533650404-18125-1-git-send-email-avienamo@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Parse and program the HS400 DQS trim value from dt. Program a fallback
value in case the property is missing.

Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 7f1ac4a..426f7ea 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -43,6 +43,10 @@
 #define SDHCI_CLOCK_CTRL_PADPIPE_CLKEN_OVERRIDE		BIT(3)
 #define SDHCI_CLOCK_CTRL_SPI_MODE_CLKEN_OVERRIDE	BIT(2)
 
+#define SDHCI_TEGRA_VENDOR_CAP_OVERRIDES		0x10c
+#define SDHCI_TEGRA_CAP_OVERRIDES_DQS_TRIM_MASK		0x00003f00
+#define SDHCI_TEGRA_CAP_OVERRIDES_DQS_TRIM_SHIFT	8
+
 #define SDHCI_TEGRA_VENDOR_MISC_CTRL			0x120
 #define SDHCI_MISC_CTRL_ENABLE_SDR104			0x8
 #define SDHCI_MISC_CTRL_ENABLE_SDR50			0x10
@@ -112,6 +116,7 @@ struct sdhci_tegra {
 
 	u32 default_tap;
 	u32 default_trim;
+	u32 dqs_trim;
 };
 
 static u16 tegra_sdhci_readw(struct sdhci_host *host, int reg)
@@ -500,7 +505,7 @@ static void tegra_sdhci_parse_pad_autocal_dt(struct sdhci_host *host)
 		autocal->pull_down_hs400 = autocal->pull_down_1v8;
 }
 
-static void tegra_sdhci_parse_default_tap_and_trim(struct sdhci_host *host)
+static void tegra_sdhci_parse_tap_and_trim(struct sdhci_host *host)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
@@ -515,6 +520,11 @@ static void tegra_sdhci_parse_default_tap_and_trim(struct sdhci_host *host)
 				       &tegra_host->default_trim);
 	if (err)
 		tegra_host->default_trim = 0;
+
+	err = device_property_read_u32(host->mmc->parent, "nvidia,dqs-trim",
+				       &tegra_host->dqs_trim);
+	if (err)
+		tegra_host->dqs_trim = 0x11;
 }
 
 static void tegra_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
@@ -545,20 +555,33 @@ static unsigned int tegra_sdhci_get_max_clock(struct sdhci_host *host)
 	return clk_round_rate(pltfm_host->clk, UINT_MAX);
 }
 
+static void tegra_sdhci_set_dqs_trim(struct sdhci_host *host, u8 val)
+{
+	u32 reg;
+
+	reg = sdhci_readl(host, SDHCI_TEGRA_VENDOR_CAP_OVERRIDES);
+	reg &= ~SDHCI_TEGRA_CAP_OVERRIDES_DQS_TRIM_MASK;
+	reg |= val<<SDHCI_TEGRA_CAP_OVERRIDES_DQS_TRIM_SHIFT;
+	sdhci_writel(host, reg, SDHCI_TEGRA_VENDOR_CAP_OVERRIDES);
+}
+
 static void tegra_sdhci_set_uhs_signaling(struct sdhci_host *host,
 					  unsigned timing)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
 	bool set_default_tap = false;
+	bool set_dqs_trim = false;
 
 	switch (timing) {
 	case MMC_TIMING_UHS_SDR50:
 	case MMC_TIMING_UHS_SDR104:
 	case MMC_TIMING_MMC_HS200:
-	case MMC_TIMING_MMC_HS400:
 		/* Don't set default tap on tunable modes. */
 		break;
+	case MMC_TIMING_MMC_HS400:
+		set_dqs_trim = true;
+		break;
 	case MMC_TIMING_MMC_DDR52:
 	case MMC_TIMING_UHS_DDR50:
 		tegra_host->ddr_signaling = true;
@@ -575,6 +598,9 @@ static void tegra_sdhci_set_uhs_signaling(struct sdhci_host *host,
 
 	if (set_default_tap)
 		tegra_sdhci_set_tap(host, tegra_host->default_tap);
+
+	if (set_dqs_trim)
+		tegra_sdhci_set_dqs_trim(host, tegra_host->dqs_trim);
 }
 
 static int tegra_sdhci_execute_tuning(struct sdhci_host *host, u32 opcode)
@@ -930,7 +956,7 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
 
 	tegra_sdhci_parse_pad_autocal_dt(host);
 
-	tegra_sdhci_parse_default_tap_and_trim(host);
+	tegra_sdhci_parse_tap_and_trim(host);
 
 	tegra_host->power_gpio = devm_gpiod_get_optional(&pdev->dev, "power",
 							 GPIOD_OUT_HIGH);
-- 
2.7.4

