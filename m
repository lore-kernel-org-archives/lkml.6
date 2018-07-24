Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03578C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2B7B20874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:34:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2B7B20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388655AbeGXPl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 11:41:29 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:17781 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388373AbeGXPl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 11:41:29 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b5738fa0001>; Tue, 24 Jul 2018 07:34:34 -0700
Received: from HQMAIL105.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 24 Jul 2018 07:34:38 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 24 Jul 2018 07:34:38 -0700
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 24 Jul
 2018 14:34:42 +0000
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 24 Jul
 2018 14:34:41 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1347.2 via Frontend
 Transport; Tue, 24 Jul 2018 14:34:41 +0000
Received: from dhcp-10-21-25-168.Nvidia.com (Not Verified[10.21.25.201]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5b5738ff0000>; Tue, 24 Jul 2018 07:34:41 -0700
From:   Aapo Vienamo <avienamo@nvidia.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Adrian Hunter" <adrian.hunter@intel.com>,
        Mikko Perttunen <mperttunen@nvidia.com>
CC:     <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Aapo Vienamo <avienamo@nvidia.com>
Subject: [PATCH 06/10] mmc: tegra: Program pad autocal offsets from dt
Date:   Tue, 24 Jul 2018 17:34:22 +0300
Message-ID: <1532442865-6391-5-git-send-email-avienamo@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532442865-6391-1-git-send-email-avienamo@nvidia.com>
References: <1532442591-5640-1-git-send-email-avienamo@nvidia.com>
 <1532442865-6391-1-git-send-email-avienamo@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Parse the pad drive strength calibration offsets from the device tree.
Program the calibration offsets in accordance with the current signaling
mode.

Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 147 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 146 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 0de74f4..78781bd 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -48,6 +48,7 @@
 #define SDHCI_TEGRA_AUTO_CAL_CONFIG		0x1e4
 #define SDHCI_AUTO_CAL_START			BIT(31)
 #define SDHCI_AUTO_CAL_ENABLE			BIT(29)
+#define SDHCI_AUTO_CAL_PDPU_OFFSET_MASK		0x0000ffff
 
 #define SDHCI_TEGRA_SDMEM_COMP_PADCTRL			0x1e0
 #define SDHCI_TEGRA_SDMEM_COMP_PADCTRL_VREF_SEL_MASK	0x0000000f
@@ -71,6 +72,22 @@ struct sdhci_tegra_soc_data {
 	u32 nvquirks;
 };
 
+/* Magic pull up and pull down pad calibration offsets */
+struct sdhci_tegra_autocal_offsets {
+	u8 pull_up_3v3;
+	u8 pull_down_3v3;
+	u8 pull_up_3v3_timeout;
+	u8 pull_down_3v3_timeout;
+	u8 pull_up_1v8;
+	u8 pull_down_1v8;
+	u8 pull_up_1v8_timeout;
+	u8 pull_down_1v8_timeout;
+	u8 pull_up_sdr104;
+	u8 pull_down_sdr104;
+	u8 pull_up_hs400;
+	u8 pull_down_hs400;
+};
+
 struct sdhci_tegra {
 	const struct sdhci_tegra_soc_data *soc_data;
 	struct gpio_desc *power_gpio;
@@ -82,6 +99,8 @@ struct sdhci_tegra {
 	struct pinctrl *pinctrl_sdmmc;
 	struct pinctrl_state *pinctrl_state_3v3;
 	struct pinctrl_state *pinctrl_state_1v8;
+
+	struct sdhci_tegra_autocal_offsets autocal_offsets;
 };
 
 static u16 tegra_sdhci_readw(struct sdhci_host *host, int reg)
@@ -248,12 +267,45 @@ static bool tegra_sdhci_configure_card_clk(struct sdhci_host *host, bool enable)
 	return orig_enabled;
 }
 
+static void tegra_sdhci_set_pad_autocal_offset(struct sdhci_host *host,
+					       u16 pdpu)
+{
+	u32 reg;
+
+	reg = sdhci_readl(host, SDHCI_TEGRA_AUTO_CAL_CONFIG);
+	reg &= ~SDHCI_AUTO_CAL_PDPU_OFFSET_MASK;
+	reg |= pdpu;
+	sdhci_writel(host, reg, SDHCI_TEGRA_AUTO_CAL_CONFIG);
+}
+
 static void tegra_sdhci_pad_autocalib(struct sdhci_host *host)
 {
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
+	struct sdhci_tegra_autocal_offsets offsets =
+			tegra_host->autocal_offsets;
+	struct mmc_ios *ios = &host->mmc->ios;
 	unsigned timeout = 10;
 	bool card_clk_enabled;
+	u16 pdpu;
 	u32 reg;
 
+	switch (ios->timing) {
+	case MMC_TIMING_UHS_SDR104:
+		pdpu = offsets.pull_down_sdr104 << 8 | offsets.pull_up_sdr104;
+		break;
+	case MMC_TIMING_MMC_HS400:
+		pdpu = offsets.pull_down_hs400 << 8 | offsets.pull_up_hs400;
+		break;
+	default:
+		if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_180)
+			pdpu = offsets.pull_down_1v8 << 8 | offsets.pull_up_1v8;
+		else
+			pdpu = offsets.pull_down_3v3 << 8 | offsets.pull_up_3v3;
+	}
+
+	tegra_sdhci_set_pad_autocal_offset(host, pdpu);
+
 	card_clk_enabled = tegra_sdhci_configure_card_clk(host, false);
 
 	tegra_sdhci_configure_cal_pad(host, true);
@@ -275,8 +327,99 @@ static void tegra_sdhci_pad_autocalib(struct sdhci_host *host)
 
 	tegra_sdhci_configure_card_clk(host, card_clk_enabled);
 
-	if (timeout == 0)
+	if (timeout == 0) {
 		dev_err(mmc_dev(host->mmc), "Pad autocal timed out\n");
+
+		if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_180)
+			pdpu = offsets.pull_down_1v8_timeout << 8 |
+			       offsets.pull_up_1v8_timeout;
+		else
+			pdpu = offsets.pull_down_3v3_timeout << 8 |
+			       offsets.pull_up_3v3_timeout;
+
+		tegra_sdhci_set_pad_autocal_offset(host, pdpu);
+	}
+}
+
+static void tegra_sdhci_parse_pad_autocal_dt(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
+	struct sdhci_tegra_autocal_offsets *autocal =
+			&tegra_host->autocal_offsets;
+	int err;
+
+	err = device_property_read_u8(host->mmc->parent,
+				      "pad-autocal-pull-up-offset-3v3",
+				      &autocal->pull_up_3v3);
+	if (err)
+		autocal->pull_up_3v3 = 0;
+
+	err = device_property_read_u8(host->mmc->parent,
+				      "pad-autocal-pull-down-offset-3v3",
+				      &autocal->pull_down_3v3);
+	if (err)
+		autocal->pull_down_3v3 = 0;
+
+	err = device_property_read_u8(host->mmc->parent,
+				      "pad-autocal-pull-up-offset-1v8",
+				      &autocal->pull_up_1v8);
+	if (err)
+		autocal->pull_up_1v8 = 0;
+
+	err = device_property_read_u8(host->mmc->parent,
+				      "pad-autocal-pull-down-offset-1v8",
+				      &autocal->pull_down_1v8);
+	if (err)
+		autocal->pull_down_1v8 = 0;
+
+	err = device_property_read_u8(host->mmc->parent,
+				      "pad-autocal-pull-up-offset-3v3-timeout",
+				      &autocal->pull_up_3v3);
+	if (err)
+		autocal->pull_up_3v3_timeout = 0;
+
+	err = device_property_read_u8(host->mmc->parent,
+			"pad-autocal-pull-down-offset-3v3-timeout",
+			&autocal->pull_down_3v3);
+	if (err)
+		autocal->pull_down_3v3_timeout = 0;
+
+	err = device_property_read_u8(host->mmc->parent,
+				      "pad-autocal-pull-up-offset-1v8-timeout",
+				      &autocal->pull_up_1v8);
+	if (err)
+		autocal->pull_up_1v8_timeout = 0;
+
+	err = device_property_read_u8(host->mmc->parent,
+			"pad-autocal-pull-down-offset-1v8-timeout",
+			&autocal->pull_down_1v8);
+	if (err)
+		autocal->pull_down_1v8_timeout = 0;
+
+	err = device_property_read_u8(host->mmc->parent,
+				      "pad-autocal-pull-up-offset-sdr104",
+				      &autocal->pull_up_sdr104);
+	if (err)
+		autocal->pull_up_sdr104 = autocal->pull_up_1v8;
+
+	err = device_property_read_u8(host->mmc->parent,
+				      "pad-autocal-pull-down-offset-sdr104",
+				      &autocal->pull_down_sdr104);
+	if (err)
+		autocal->pull_down_sdr104 = autocal->pull_down_1v8;
+
+	err = device_property_read_u8(host->mmc->parent,
+				      "pad-autocal-pull-up-offset-hs400",
+				      &autocal->pull_up_hs400);
+	if (err)
+		autocal->pull_up_hs400 = autocal->pull_up_1v8;
+
+	err = device_property_read_u8(host->mmc->parent,
+				      "pad-autocal-pull-down-offset-hs400",
+				      &autocal->pull_down_hs400);
+	if (err)
+		autocal->pull_down_hs400 = autocal->pull_down_1v8;
 }
 
 static void tegra_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
@@ -638,6 +781,8 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
 	if (tegra_host->soc_data->nvquirks & NVQUIRK_ENABLE_DDR50)
 		host->mmc->caps |= MMC_CAP_1_8V_DDR;
 
+	tegra_sdhci_parse_pad_autocal_dt(host);
+
 	tegra_host->power_gpio = devm_gpiod_get_optional(&pdev->dev, "power",
 							 GPIOD_OUT_HIGH);
 	if (IS_ERR(tegra_host->power_gpio)) {
-- 
2.7.4

