Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54405C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 18:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ED5621EFB
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 18:10:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ED5621EFB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730282AbeHJUkx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 16:40:53 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:3597 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728257AbeHJUkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 16:40:52 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b6dd4f10000>; Fri, 10 Aug 2018 11:09:53 -0700
Received: from HQMAIL105.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 10 Aug 2018 11:09:50 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 10 Aug 2018 11:09:50 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 10 Aug
 2018 18:09:56 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1347.2 via Frontend
 Transport; Fri, 10 Aug 2018 18:09:56 +0000
Received: from dhcp-10-21-25-168.Nvidia.com (Not Verified[10.21.25.201]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5b6dd4f10004>; Fri, 10 Aug 2018 11:09:56 -0700
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
Subject: [PATCH v2 22/40] mmc: tegra: Configure default tap values
Date:   Fri, 10 Aug 2018 21:08:24 +0300
Message-ID: <1533924522-1037-23-git-send-email-avienamo@nvidia.com>
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

Set the default inbound timing adjustment tap value on reset and on
non-tunable modes.

The default tap value is not programmed on tunable modes because the
tuning sequence is used instead to determine the tap value.

Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 132 ++++++++++++++++++++++++-----------------
 1 file changed, 77 insertions(+), 55 deletions(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 0c39c54..208a269 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -213,6 +213,58 @@ static bool tegra_sdhci_is_pad_and_regulator_valid(struct sdhci_host *host)
 	return true;
 }
 
+static bool tegra_sdhci_configure_card_clk(struct sdhci_host *host, bool enable)
+{
+	bool status;
+	u32 reg;
+
+	reg = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+	status = !!(reg & SDHCI_CLOCK_CARD_EN);
+
+	if (status == enable)
+		return status;
+
+	if (enable)
+		reg |= SDHCI_CLOCK_CARD_EN;
+	else
+		reg &= ~SDHCI_CLOCK_CARD_EN;
+
+	sdhci_writew(host, reg, SDHCI_CLOCK_CONTROL);
+
+	return status;
+}
+
+
+static void tegra_sdhci_set_tap(struct sdhci_host *host, unsigned int tap)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
+	const struct sdhci_tegra_soc_data *soc_data = tegra_host->soc_data;
+	bool card_clk_enabled = false;
+	u32 reg;
+
+	/*
+	 * Touching the tap values is a bit tricky on some SoC generations.
+	 * The quirk enables a workaround for a glitch that sometimes occurs if
+	 * the tap values are changed.
+	 */
+
+	if (soc_data->nvquirks & NVQUIRK_DIS_CARD_CLK_CONFIG_TAP)
+		card_clk_enabled = tegra_sdhci_configure_card_clk(host, false);
+
+	reg = sdhci_readl(host, SDHCI_TEGRA_VENDOR_CLOCK_CTRL);
+	reg &= ~SDHCI_CLOCK_CTRL_TAP_MASK;
+	reg |= tap << SDHCI_CLOCK_CTRL_TAP_SHIFT;
+	sdhci_writel(host, reg, SDHCI_TEGRA_VENDOR_CLOCK_CTRL);
+
+	if (soc_data->nvquirks & NVQUIRK_DIS_CARD_CLK_CONFIG_TAP &&
+	    card_clk_enabled) {
+		udelay(1);
+		sdhci_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
+		tegra_sdhci_configure_card_clk(host, card_clk_enabled);
+	}
+}
+
 static void tegra_sdhci_reset(struct sdhci_host *host, u8 mask)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -225,6 +277,8 @@ static void tegra_sdhci_reset(struct sdhci_host *host, u8 mask)
 	if (!(mask & SDHCI_RESET_ALL))
 		return;
 
+	tegra_sdhci_set_tap(host, tegra_host->default_tap);
+
 	misc_ctrl = sdhci_readl(host, SDHCI_TEGRA_VENDOR_MISC_CTRL);
 	clk_ctrl = sdhci_readl(host, SDHCI_TEGRA_VENDOR_CLOCK_CTRL);
 
@@ -286,27 +340,6 @@ static void tegra_sdhci_configure_cal_pad(struct sdhci_host *host, bool enable)
 		usleep_range(1, 2);
 }
 
-static bool tegra_sdhci_configure_card_clk(struct sdhci_host *host, bool enable)
-{
-	bool status;
-	u32 reg;
-
-	reg = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
-	status = !!(reg & SDHCI_CLOCK_CARD_EN);
-
-	if (status == enable)
-		return status;
-
-	if (enable)
-		reg |= SDHCI_CLOCK_CARD_EN;
-	else
-		reg &= ~SDHCI_CLOCK_CARD_EN;
-
-	sdhci_writew(host, reg, SDHCI_CLOCK_CONTROL);
-
-	return status;
-}
-
 static void tegra_sdhci_set_pad_autocal_offset(struct sdhci_host *host,
 					       u16 pdpu)
 {
@@ -502,19 +535,6 @@ static void tegra_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 	}
 }
 
-static void tegra_sdhci_set_uhs_signaling(struct sdhci_host *host,
-					  unsigned timing)
-{
-	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
-
-	if (timing == MMC_TIMING_UHS_DDR50 ||
-	    timing == MMC_TIMING_MMC_DDR52)
-		tegra_host->ddr_signaling = true;
-
-	sdhci_set_uhs_signaling(host, timing);
-}
-
 static unsigned int tegra_sdhci_get_max_clock(struct sdhci_host *host)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -522,34 +542,36 @@ static unsigned int tegra_sdhci_get_max_clock(struct sdhci_host *host)
 	return clk_round_rate(pltfm_host->clk, UINT_MAX);
 }
 
-static void tegra_sdhci_set_tap(struct sdhci_host *host, unsigned int tap)
+static void tegra_sdhci_set_uhs_signaling(struct sdhci_host *host,
+					  unsigned timing)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
-	const struct sdhci_tegra_soc_data *soc_data = tegra_host->soc_data;
-	bool card_clk_enabled = false;
-	u32 reg;
+	bool set_default_tap = false;
 
-	/*
-	 * Touching the tap values is a bit tricky on some SoC generations.
-	 * The quirk enables a workaround for a glitch that sometimes occurs if
-	 * the tap values are changed.
-	 */
+	switch (timing) {
+	case MMC_TIMING_UHS_SDR50:
+	case MMC_TIMING_UHS_SDR104:
+	case MMC_TIMING_MMC_HS200:
+	case MMC_TIMING_MMC_HS400:
+		/* Don't set default tap on tunable modes. */
+		break;
+	case MMC_TIMING_MMC_DDR52:
+	case MMC_TIMING_UHS_DDR50:
+		tegra_host->ddr_signaling = true;
+		set_default_tap = true;
+		break;
+	default:
+		set_default_tap = true;
+		break;
+	}
 
-	if (soc_data->nvquirks & NVQUIRK_DIS_CARD_CLK_CONFIG_TAP)
-		card_clk_enabled = tegra_sdhci_configure_card_clk(host, false);
+	sdhci_set_uhs_signaling(host, timing);
 
-	reg = sdhci_readl(host, SDHCI_TEGRA_VENDOR_CLOCK_CTRL);
-	reg &= ~SDHCI_CLOCK_CTRL_TAP_MASK;
-	reg |= tap << SDHCI_CLOCK_CTRL_TAP_SHIFT;
-	sdhci_writel(host, reg, SDHCI_TEGRA_VENDOR_CLOCK_CTRL);
+	tegra_sdhci_pad_autocalib(host);
 
-	if (soc_data->nvquirks & NVQUIRK_DIS_CARD_CLK_CONFIG_TAP &&
-	    card_clk_enabled) {
-		usleep_range(1, 2);
-		sdhci_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
-		tegra_sdhci_configure_card_clk(host, card_clk_enabled);
-	}
+	if (set_default_tap)
+		tegra_sdhci_set_tap(host, tegra_host->default_tap);
 }
 
 static int tegra_sdhci_execute_tuning(struct sdhci_host *host, u32 opcode)
-- 
2.7.4

