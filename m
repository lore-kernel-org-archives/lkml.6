Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 542F9C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10912205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:07:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10912205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729537AbeH3TJ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 15:09:58 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:13469 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728550AbeH3TJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 15:09:57 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5b8808260000>; Thu, 30 Aug 2018 08:07:18 -0700
Received: from HQMAIL108.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 30 Aug 2018 08:07:20 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 30 Aug 2018 08:07:20 -0700
Received: from HQMAIL103.nvidia.com (172.20.187.11) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 30 Aug
 2018 15:07:19 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Thu, 30 Aug 2018 15:07:19 +0000
Received: from dhcp-10-21-25-168.Nvidia.com (Not Verified[10.21.25.201]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5b8808240000>; Thu, 30 Aug 2018 08:07:19 -0700
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
Subject: [PATCH v3 11/38] mmc: tegra: Reconfigure pad voltages during voltage switching
Date:   Thu, 30 Aug 2018 18:06:12 +0300
Message-ID: <20180830150639.21048-12-avienamo@nvidia.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180830150639.21048-1-avienamo@nvidia.com>
References: <20180830150639.21048-1-avienamo@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Parse the pinctrl state and nvidia,only-1-8-v properties from the device
tree. Validate the pinctrl and regulator configuration before unmasking
UHS modes. Implement pad voltage state reconfiguration in the mmc
start_signal_voltage_switch() callback. Add NVQUIRK_NEEDS_PAD_CONTROL
and add set it for Tegra210 and Tegra186.

The pad configuration is done in the mmc callback because the order of
pad reconfiguration and sdhci voltage switch depend on the voltage to
which the transition occurs.

Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 136 +++++++++++++++++++++++++++++++--
 1 file changed, 129 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 908b23e6a03c..11185e96f3c3 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -21,6 +21,8 @@
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/pinctrl/consumer.h>
+#include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 #include <linux/mmc/card.h>
 #include <linux/mmc/host.h>
@@ -55,6 +57,7 @@
 #define NVQUIRK_ENABLE_SDR104		BIT(4)
 #define NVQUIRK_ENABLE_DDR50		BIT(5)
 #define NVQUIRK_HAS_PADCALIB		BIT(6)
+#define NVQUIRK_NEEDS_PAD_CONTROL	BIT(7)
 
 struct sdhci_tegra_soc_data {
 	const struct sdhci_pltfm_data *pdata;
@@ -66,8 +69,12 @@ struct sdhci_tegra {
 	struct gpio_desc *power_gpio;
 	bool ddr_signaling;
 	bool pad_calib_required;
+	bool pad_control_available;
 
 	struct reset_control *rst;
+	struct pinctrl *pinctrl_sdmmc;
+	struct pinctrl_state *pinctrl_state_3v3;
+	struct pinctrl_state *pinctrl_state_1v8;
 };
 
 static u16 tegra_sdhci_readw(struct sdhci_host *host, int reg)
@@ -138,6 +145,39 @@ static unsigned int tegra_sdhci_get_ro(struct sdhci_host *host)
 	return mmc_gpio_get_ro(host->mmc);
 }
 
+static bool tegra_sdhci_is_pad_and_regulator_valid(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
+	int has_1v8, has_3v3;
+
+	/*
+	 * The SoCs which have NVQUIRK_NEEDS_PAD_CONTROL require software pad
+	 * voltage configuration in order to perform voltage switching. This
+	 * means that valid pinctrl info is required on SDHCI instances capable
+	 * of performing voltage switching. Whether or not an SDHCI instance is
+	 * capable of voltage switching is determined based on the regulator.
+	 */
+
+	if (!(tegra_host->soc_data->nvquirks & NVQUIRK_NEEDS_PAD_CONTROL))
+		return true;
+
+	if (IS_ERR(host->mmc->supply.vqmmc))
+		return false;
+
+	has_1v8 = regulator_is_supported_voltage(host->mmc->supply.vqmmc,
+						 1700000, 1950000);
+
+	has_3v3 = regulator_is_supported_voltage(host->mmc->supply.vqmmc,
+						 2700000, 3600000);
+
+	if (has_1v8 == 1 && has_3v3 == 1)
+		return tegra_host->pad_control_available;
+
+	/* Fixed voltage, no pad control required. */
+	return true;
+}
+
 static void tegra_sdhci_reset(struct sdhci_host *host, u8 mask)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -160,13 +200,7 @@ static void tegra_sdhci_reset(struct sdhci_host *host, u8 mask)
 
 	clk_ctrl &= ~SDHCI_CLOCK_CTRL_SPI_MODE_CLKEN_OVERRIDE;
 
-	/*
-	 * If the board does not define a regulator for the SDHCI
-	 * IO voltage, then don't advertise support for UHS modes
-	 * even if the device supports it because the IO voltage
-	 * cannot be configured.
-	 */
-	if (!IS_ERR(host->mmc->supply.vqmmc)) {
+	if (tegra_sdhci_is_pad_and_regulator_valid(host)) {
 		/* Erratum: Enable SDHCI spec v3.00 support */
 		if (soc_data->nvquirks & NVQUIRK_ENABLE_SDHCI_SPEC_300)
 			misc_ctrl |= SDHCI_MISC_CTRL_ENABLE_SDHCI_SPEC_300;
@@ -301,6 +335,84 @@ static int tegra_sdhci_execute_tuning(struct sdhci_host *host, u32 opcode)
 	return mmc_send_tuning(host->mmc, opcode, NULL);
 }
 
+static int tegra_sdhci_set_padctrl(struct sdhci_host *host, int voltage)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
+	int ret;
+
+	if (!tegra_host->pad_control_available)
+		return 0;
+
+	if (voltage == MMC_SIGNAL_VOLTAGE_180) {
+		ret = pinctrl_select_state(tegra_host->pinctrl_sdmmc,
+					   tegra_host->pinctrl_state_1v8);
+		if (ret < 0)
+			dev_err(mmc_dev(host->mmc),
+				"setting 1.8V failed, ret: %d\n", ret);
+	} else {
+		ret = pinctrl_select_state(tegra_host->pinctrl_sdmmc,
+					   tegra_host->pinctrl_state_3v3);
+		if (ret < 0)
+			dev_err(mmc_dev(host->mmc),
+				"setting 3.3V failed, ret: %d\n", ret);
+	}
+
+	return ret;
+}
+
+static int sdhci_tegra_start_signal_voltage_switch(struct mmc_host *mmc,
+						   struct mmc_ios *ios)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	int ret = 0;
+
+	if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_330) {
+		ret = tegra_sdhci_set_padctrl(host, ios->signal_voltage);
+		if (ret < 0)
+			return ret;
+		ret = sdhci_start_signal_voltage_switch(mmc, ios);
+	} else if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_180) {
+		ret = sdhci_start_signal_voltage_switch(mmc, ios);
+		if (ret < 0)
+			return ret;
+		ret = tegra_sdhci_set_padctrl(host, ios->signal_voltage);
+	}
+
+	return ret;
+}
+
+static int tegra_sdhci_init_pinctrl_info(struct device *dev,
+					 struct sdhci_tegra *tegra_host)
+{
+	tegra_host->pinctrl_sdmmc = devm_pinctrl_get(dev);
+	if (IS_ERR(tegra_host->pinctrl_sdmmc)) {
+		dev_dbg(dev, "No pinctrl info, err: %ld\n",
+			PTR_ERR(tegra_host->pinctrl_sdmmc));
+		return -1;
+	}
+
+	tegra_host->pinctrl_state_3v3 =
+		pinctrl_lookup_state(tegra_host->pinctrl_sdmmc, "sdmmc-3v3");
+	if (IS_ERR(tegra_host->pinctrl_state_3v3)) {
+		dev_warn(dev, "Missing 3.3V pad state, err: %ld\n",
+			 PTR_ERR(tegra_host->pinctrl_state_3v3));
+		return -1;
+	}
+
+	tegra_host->pinctrl_state_1v8 =
+		pinctrl_lookup_state(tegra_host->pinctrl_sdmmc, "sdmmc-1v8");
+	if (IS_ERR(tegra_host->pinctrl_state_1v8)) {
+		dev_warn(dev, "Missing 1.8V pad state, err: %ld\n",
+			 PTR_ERR(tegra_host->pinctrl_state_3v3));
+		return -1;
+	}
+
+	tegra_host->pad_control_available = true;
+
+	return 0;
+}
+
 static void tegra_sdhci_voltage_switch(struct sdhci_host *host)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -434,6 +546,7 @@ static const struct sdhci_pltfm_data sdhci_tegra210_pdata = {
 
 static const struct sdhci_tegra_soc_data soc_data_tegra210 = {
 	.pdata = &sdhci_tegra210_pdata,
+	.nvquirks = NVQUIRK_NEEDS_PAD_CONTROL,
 };
 
 static const struct sdhci_pltfm_data sdhci_tegra186_pdata = {
@@ -457,6 +570,7 @@ static const struct sdhci_pltfm_data sdhci_tegra186_pdata = {
 
 static const struct sdhci_tegra_soc_data soc_data_tegra186 = {
 	.pdata = &sdhci_tegra186_pdata,
+	.nvquirks = NVQUIRK_NEEDS_PAD_CONTROL,
 };
 
 static const struct of_device_id sdhci_tegra_dt_match[] = {
@@ -493,8 +607,16 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
 	tegra_host = sdhci_pltfm_priv(pltfm_host);
 	tegra_host->ddr_signaling = false;
 	tegra_host->pad_calib_required = false;
+	tegra_host->pad_control_available = false;
 	tegra_host->soc_data = soc_data;
 
+	if (soc_data->nvquirks & NVQUIRK_NEEDS_PAD_CONTROL) {
+		rc = tegra_sdhci_init_pinctrl_info(&pdev->dev, tegra_host);
+		if (rc == 0)
+			host->mmc_host_ops.start_signal_voltage_switch =
+				sdhci_tegra_start_signal_voltage_switch;
+	}
+
 	rc = mmc_of_parse(host->mmc);
 	if (rc)
 		goto err_parse_dt;
-- 
2.18.0

