Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817B9C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40CF1205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:08:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40CF1205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729927AbeH3TKl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 15:10:41 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:13542 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728709AbeH3TKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 15:10:40 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5b8808520000>; Thu, 30 Aug 2018 08:08:02 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 30 Aug 2018 08:08:03 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 30 Aug 2018 08:08:03 -0700
Received: from HQMAIL104.nvidia.com (172.18.146.11) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 30 Aug
 2018 15:08:03 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Thu, 30 Aug 2018 15:08:03 +0000
Received: from dhcp-10-21-25-168.Nvidia.com (Not Verified[10.21.25.201]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5b8808500000>; Thu, 30 Aug 2018 08:08:03 -0700
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
Subject: [PATCH v3 25/38] mmc: tegra: Disable card clock during tuning cmd on Tegra210
Date:   Thu, 30 Aug 2018 18:06:26 +0300
Message-ID: <20180830150639.21048-26-avienamo@nvidia.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180830150639.21048-1-avienamo@nvidia.com>
References: <20180830150639.21048-1-avienamo@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement tegra210_sdhci_writew() to disable card clock and issue a
reset when the tuning command is sent. This is done to prevent an
intermittent hang with around 10 % failure rate during tuning.

Add tegra186_sdhci_ops because this workaround is specific to Tegra210.

Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 81 ++++++++++++++++++++++++----------
 1 file changed, 58 insertions(+), 23 deletions(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 0bdce437e752..aa1574b8d96c 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -177,6 +177,50 @@ static void tegra_sdhci_writel(struct sdhci_host *host, u32 val, int reg)
 	}
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
+static void tegra210_sdhci_writew(struct sdhci_host *host, u16 val, int reg)
+{
+	bool is_tuning_cmd = 0;
+	bool clk_enabled;
+	u8 cmd;
+
+	if (reg == SDHCI_COMMAND) {
+		cmd = SDHCI_GET_CMD(val);
+		is_tuning_cmd = cmd == MMC_SEND_TUNING_BLOCK ||
+				cmd == MMC_SEND_TUNING_BLOCK_HS200;
+	}
+
+	if (is_tuning_cmd)
+		clk_enabled = tegra_sdhci_configure_card_clk(host, 0);
+
+	writew(val, host->ioaddr + reg);
+
+	if (is_tuning_cmd) {
+		udelay(1);
+		tegra_sdhci_configure_card_clk(host, clk_enabled);
+	}
+}
+
 static unsigned int tegra_sdhci_get_ro(struct sdhci_host *host)
 {
 	return mmc_gpio_get_ro(host->mmc);
@@ -215,28 +259,6 @@ static bool tegra_sdhci_is_pad_and_regulator_valid(struct sdhci_host *host)
 	return true;
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
-
 static void tegra_sdhci_set_tap(struct sdhci_host *host, unsigned int tap)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -834,6 +856,7 @@ static const struct sdhci_tegra_soc_data soc_data_tegra124 = {
 static const struct sdhci_ops tegra210_sdhci_ops = {
 	.get_ro     = tegra_sdhci_get_ro,
 	.read_w     = tegra_sdhci_readw,
+	.write_w    = tegra210_sdhci_writew,
 	.write_l    = tegra_sdhci_writel,
 	.set_clock  = tegra_sdhci_set_clock,
 	.set_bus_width = sdhci_set_bus_width,
@@ -861,6 +884,18 @@ static const struct sdhci_tegra_soc_data soc_data_tegra210 = {
 		    NVQUIRK_DIS_CARD_CLK_CONFIG_TAP,
 };
 
+static const struct sdhci_ops tegra186_sdhci_ops = {
+	.get_ro     = tegra_sdhci_get_ro,
+	.read_w     = tegra_sdhci_readw,
+	.write_l    = tegra_sdhci_writel,
+	.set_clock  = tegra_sdhci_set_clock,
+	.set_bus_width = sdhci_set_bus_width,
+	.reset      = tegra_sdhci_reset,
+	.set_uhs_signaling = tegra_sdhci_set_uhs_signaling,
+	.voltage_switch = tegra_sdhci_voltage_switch,
+	.get_max_clock = tegra_sdhci_get_max_clock,
+};
+
 static const struct sdhci_pltfm_data sdhci_tegra186_pdata = {
 	.quirks = SDHCI_QUIRK_BROKEN_TIMEOUT_VAL |
 		  SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
@@ -877,7 +912,7 @@ static const struct sdhci_pltfm_data sdhci_tegra186_pdata = {
 		    * But it is not supported as of now.
 		    */
 		   SDHCI_QUIRK2_BROKEN_64_BIT_DMA,
-	.ops  = &tegra210_sdhci_ops,
+	.ops  = &tegra186_sdhci_ops,
 };
 
 static const struct sdhci_tegra_soc_data soc_data_tegra186 = {
-- 
2.18.0

