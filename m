Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E6CC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 22:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 479EF2086C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 22:58:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="dgpNdq8n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729406AbeLSW61 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 17:58:27 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:13503 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728307AbeLSW6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 17:58:17 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c1acd010001>; Wed, 19 Dec 2018 14:58:09 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 19 Dec 2018 14:58:15 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 19 Dec 2018 14:58:15 -0800
Received: from HQMAIL106.nvidia.com (172.18.146.12) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Wed, 19 Dec
 2018 22:58:15 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Wed, 19 Dec 2018 22:58:14 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.103.52]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c1acc840004>; Wed, 19 Dec 2018 14:56:04 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <mperttunen@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <adrian.hunter@intel.com>,
        <ulf.hansson@linaro.org>, <pchandru@nvidia.com>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V2 3/3] mmc: tegra: SDMMC pads auto-calibration
Date:   Wed, 19 Dec 2018 14:55:53 -0800
Message-ID: <1545260153-11338-3-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545260153-11338-1-git-send-email-skomatineni@nvidia.com>
References: <1545260153-11338-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1545260289; bh=tavZPryP9hpCrx4xFldGTcLpWrEs1LaHRmLHHTWogwc=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=dgpNdq8n9bEZq8BSXrjKDVCcDey8nzpC7z654rv2/bFUkZ7va3F7HPt1/D/Hrrlh/
         ZQV5gihlEt+8OCaeyLZabU4JhdO4mrtvHZ7ERqW9z7z/px8vkkQlRd+jLttvRENNPl
         fFi9hC/MKuwYaPinYMib8Wf8FgFCLxqqUIiuxLj81N1RlPE/5u/alWj0b7iAa1zg10
         xLGDMq40giS+v6GL0hSvkd+pcTr4NGqvZ3s0a2kE3h1SzfpVtRCjldPsAc+3D7JQNC
         V7BhreruNb/UkoqgglwrChSZaizvYUlU4nUS/EmQIYctTBwL+YRJBGs9jW04fSB9M4
         E2TJJy6xLEnZw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Programs initial drive code offsets which will be used by auto
calibration process.

Programs fixed drive strengths for SDMMC pads when auto cal
timeouts. Fixed settings are based on Pre-SI analysis of the
pad design.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 107 +++++++++++++++++++++++++++++++----------
 1 file changed, 81 insertions(+), 26 deletions(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 7b95d088fdef..f8361249cf57 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -75,6 +75,7 @@
 #define SDHCI_TEGRA_SDMEM_COMP_PADCTRL_VREF_SEL_MASK	0x0000000f
 #define SDHCI_TEGRA_SDMEM_COMP_PADCTRL_VREF_SEL_VAL	0x7
 #define SDHCI_TEGRA_SDMEM_COMP_PADCTRL_E_INPUT_E_PWRD	BIT(31)
+#define SDHCI_COMP_PADCTRL_DRVUPDN_OFFSET_MASK		0x07FFF000
 
 #define SDHCI_TEGRA_AUTO_CAL_STATUS			0x1ec
 #define SDHCI_TEGRA_AUTO_CAL_ACTIVE			BIT(31)
@@ -121,6 +122,8 @@ struct sdhci_tegra {
 	struct pinctrl *pinctrl_sdmmc;
 	struct pinctrl_state *pinctrl_state_3v3;
 	struct pinctrl_state *pinctrl_state_1v8;
+	struct pinctrl_state *pinctrl_state_3v3_drv;
+	struct pinctrl_state *pinctrl_state_1v8_drv;
 
 	struct sdhci_tegra_autocal_offsets autocal_offsets;
 	ktime_t last_calib;
@@ -130,6 +133,9 @@ struct sdhci_tegra {
 	u32 dqs_trim;
 };
 
+static int tegra_sdhci_set_padctrl(struct sdhci_host *host, int voltage,
+							bool state_drvupdn);
+
 static u16 tegra_sdhci_readw(struct sdhci_host *host, int reg)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -437,6 +443,7 @@ static void tegra_sdhci_pad_autocalib(struct sdhci_host *host)
 			pdpu = offsets.pull_down_3v3 << 8 | offsets.pull_up_3v3;
 	}
 
+	/* Set initial offset before auto-calibration */
 	tegra_sdhci_set_pad_autocal_offset(host, pdpu);
 
 	card_clk_enabled = tegra_sdhci_configure_card_clk(host, false);
@@ -460,19 +467,15 @@ static void tegra_sdhci_pad_autocalib(struct sdhci_host *host)
 	if (ret) {
 		dev_err(mmc_dev(host->mmc), "Pad autocal timed out\n");
 
-		if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_180)
-			pdpu = offsets.pull_down_1v8_timeout << 8 |
-			       offsets.pull_up_1v8_timeout;
-		else
-			pdpu = offsets.pull_down_3v3_timeout << 8 |
-			       offsets.pull_up_3v3_timeout;
-
-		/* Disable automatic calibration and use fixed offsets */
+		/* Disable automatic cal and use fixed Drive Strengths */
 		reg = sdhci_readl(host, SDHCI_TEGRA_AUTO_CAL_CONFIG);
 		reg &= ~SDHCI_AUTO_CAL_ENABLE;
 		sdhci_writel(host, reg, SDHCI_TEGRA_AUTO_CAL_CONFIG);
 
-		tegra_sdhci_set_pad_autocal_offset(host, pdpu);
+		ret = tegra_sdhci_set_padctrl(host, ios->signal_voltage, false);
+		if (ret < 0)
+			dev_err(mmc_dev(host->mmc),
+			"Setting drive strengths failed %d\n", PTR_ERR(ret));
 	}
 }
 
@@ -743,27 +746,73 @@ static int tegra_sdhci_execute_tuning(struct sdhci_host *host, u32 opcode)
 	return mmc_send_tuning(host->mmc, opcode, NULL);
 }
 
-static int tegra_sdhci_set_padctrl(struct sdhci_host *host, int voltage)
+static int tegra_sdhci_set_padctrl(struct sdhci_host *host, int voltage,
+							bool state_drvupdn)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
-	int ret;
+	struct sdhci_tegra_autocal_offsets offsets =
+					tegra_host->autocal_offsets;
+	struct pinctrl_state *pinctrl_drvupdn = NULL;
+	int ret = 0;
+	u8 drvup = 0, drvdn = 0;
+	u32 reg;
 
-	if (!tegra_host->pad_control_available)
-		return 0;
+	if (!state_drvupdn) {
+		/* PADS Drive Strength */
+		if (voltage == MMC_SIGNAL_VOLTAGE_180) {
+			if (!IS_ERR(tegra_host->pinctrl_state_1v8_drv) &&
+				(tegra_host->pinctrl_state_1v8_drv != NULL)) {
+				pinctrl_drvupdn =
+					tegra_host->pinctrl_state_1v8_drv;
+			} else {
+				drvup = offsets.pull_up_1v8_timeout;
+				drvdn = offsets.pull_down_1v8_timeout;
+			}
+		} else {
+			if (!IS_ERR(tegra_host->pinctrl_state_3v3_drv) &&
+				(tegra_host->pinctrl_state_3v3_drv != NULL)) {
+				pinctrl_drvupdn =
+					tegra_host->pinctrl_state_3v3_drv;
+			} else {
+				drvup = offsets.pull_up_3v3_timeout;
+				drvdn = offsets.pull_down_3v3_timeout;
+			}
+		}
+
+		if (pinctrl_drvupdn != NULL) {
+			ret = pinctrl_select_state(tegra_host->pinctrl_sdmmc,
+							pinctrl_drvupdn);
+			if (ret < 0)
+				dev_err(mmc_dev(host->mmc),
+					"failed pads drvupdn, ret: %d\n", ret);
+		} else if ((drvup) || (drvdn)) {
+			reg = sdhci_readl(host,
+					SDHCI_TEGRA_SDMEM_COMP_PADCTRL);
+			reg &= ~SDHCI_COMP_PADCTRL_DRVUPDN_OFFSET_MASK;
+			reg |= (drvup << 20) | (drvdn << 12);
+			sdhci_writel(host, reg,
+					SDHCI_TEGRA_SDMEM_COMP_PADCTRL);
+		}
 
-	if (voltage == MMC_SIGNAL_VOLTAGE_180) {
-		ret = pinctrl_select_state(tegra_host->pinctrl_sdmmc,
-					   tegra_host->pinctrl_state_1v8);
-		if (ret < 0)
-			dev_err(mmc_dev(host->mmc),
-				"setting 1.8V failed, ret: %d\n", ret);
 	} else {
-		ret = pinctrl_select_state(tegra_host->pinctrl_sdmmc,
-					   tegra_host->pinctrl_state_3v3);
-		if (ret < 0)
-			dev_err(mmc_dev(host->mmc),
-				"setting 3.3V failed, ret: %d\n", ret);
+		/* Dual Voltage PADS Voltage selection */
+		if (!tegra_host->pad_control_available)
+			return 0;
+
+		if (voltage == MMC_SIGNAL_VOLTAGE_180) {
+			ret = pinctrl_select_state(tegra_host->pinctrl_sdmmc,
+						tegra_host->pinctrl_state_1v8);
+			if (ret < 0)
+				dev_err(mmc_dev(host->mmc),
+					"setting 1.8V failed, ret: %d\n", ret);
+		} else {
+			ret = pinctrl_select_state(tegra_host->pinctrl_sdmmc,
+						tegra_host->pinctrl_state_3v3);
+			if (ret < 0)
+				dev_err(mmc_dev(host->mmc),
+					"setting 3.3V failed, ret: %d\n", ret);
+		}
 	}
 
 	return ret;
@@ -778,7 +827,7 @@ static int sdhci_tegra_start_signal_voltage_switch(struct mmc_host *mmc,
 	int ret = 0;
 
 	if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_330) {
-		ret = tegra_sdhci_set_padctrl(host, ios->signal_voltage);
+		ret = tegra_sdhci_set_padctrl(host, ios->signal_voltage, true);
 		if (ret < 0)
 			return ret;
 		ret = sdhci_start_signal_voltage_switch(mmc, ios);
@@ -786,7 +835,7 @@ static int sdhci_tegra_start_signal_voltage_switch(struct mmc_host *mmc,
 		ret = sdhci_start_signal_voltage_switch(mmc, ios);
 		if (ret < 0)
 			return ret;
-		ret = tegra_sdhci_set_padctrl(host, ios->signal_voltage);
+		ret = tegra_sdhci_set_padctrl(host, ios->signal_voltage, true);
 	}
 
 	if (tegra_host->pad_calib_required)
@@ -805,6 +854,12 @@ static int tegra_sdhci_init_pinctrl_info(struct device *dev,
 		return -1;
 	}
 
+	tegra_host->pinctrl_state_1v8_drv = pinctrl_lookup_state(
+				tegra_host->pinctrl_sdmmc, "sdmmc-1v8-drv");
+
+	tegra_host->pinctrl_state_3v3_drv = pinctrl_lookup_state(
+				tegra_host->pinctrl_sdmmc, "sdmmc-3v3-drv");
+
 	tegra_host->pinctrl_state_3v3 =
 		pinctrl_lookup_state(tegra_host->pinctrl_sdmmc, "sdmmc-3v3");
 	if (IS_ERR(tegra_host->pinctrl_state_3v3)) {
-- 
2.7.4

