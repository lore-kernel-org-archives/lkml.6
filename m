Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E24C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 18:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6273821EFB
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 18:09:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6273821EFB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730211AbeHJUkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 16:40:47 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:3586 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728257AbeHJUkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 16:40:46 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b6dd4eb0000>; Fri, 10 Aug 2018 11:09:47 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 10 Aug 2018 11:09:44 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 10 Aug 2018 11:09:44 -0700
Received: from HQMAIL104.nvidia.com (172.18.146.11) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 10 Aug
 2018 18:09:49 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1347.2 via Frontend
 Transport; Fri, 10 Aug 2018 18:09:49 +0000
Received: from dhcp-10-21-25-168.Nvidia.com (Not Verified[10.21.25.201]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5b6dd4eb0000>; Fri, 10 Aug 2018 11:09:49 -0700
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
Subject: [PATCH v2 20/40] mmc: tegra: Add a workaround for tap value change glitch
Date:   Fri, 10 Aug 2018 21:08:22 +0300
Message-ID: <1533924522-1037-21-git-send-email-avienamo@nvidia.com>
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

Add quirk to disable the card clock during configuration of the tap
value in tegra_sdhci_set_tap() and issue sdhci_reset() after value
change. This is a workaround to avoid propagation of a potential
glitch caused by setting the tap value.

Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 955c317..e82fb92 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -47,6 +47,9 @@
 #define SDHCI_MISC_CTRL_ENABLE_SDHCI_SPEC_300		0x20
 #define SDHCI_MISC_CTRL_ENABLE_DDR50			0x200
 
+#define SDHCI_VNDR_TUN_CTRL0_0				0x1c0
+#define SDHCI_VNDR_TUN_CTRL0_TUN_HW_TAP			0x20000
+
 #define SDHCI_TEGRA_AUTO_CAL_CONFIG			0x1e4
 #define SDHCI_AUTO_CAL_START				BIT(31)
 #define SDHCI_AUTO_CAL_ENABLE				BIT(29)
@@ -68,6 +71,7 @@
 #define NVQUIRK_ENABLE_DDR50				BIT(5)
 #define NVQUIRK_HAS_PADCALIB				BIT(6)
 #define NVQUIRK_NEEDS_PAD_CONTROL			BIT(7)
+#define NVQUIRK_DIS_CARD_CLK_CONFIG_TAP			BIT(8)
 
 struct sdhci_tegra_soc_data {
 	const struct sdhci_pltfm_data *pdata;
@@ -500,12 +504,32 @@ static unsigned int tegra_sdhci_get_max_clock(struct sdhci_host *host)
 
 static void tegra_sdhci_set_tap(struct sdhci_host *host, unsigned int tap)
 {
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
+	const struct sdhci_tegra_soc_data *soc_data = tegra_host->soc_data;
+	bool card_clk_enabled = false;
 	u32 reg;
 
+	/*
+	 * Touching the tap values is a bit tricky on some SoC generations.
+	 * The quirk enables a workaround for a glitch that sometimes occurs if
+	 * the tap values are changed.
+	 */
+
+	if (soc_data->nvquirks & NVQUIRK_DIS_CARD_CLK_CONFIG_TAP)
+		card_clk_enabled = tegra_sdhci_configure_card_clk(host, false);
+
 	reg = sdhci_readl(host, SDHCI_TEGRA_VENDOR_CLOCK_CTRL);
 	reg &= ~SDHCI_CLOCK_CTRL_TAP_MASK;
 	reg |= tap << SDHCI_CLOCK_CTRL_TAP_SHIFT;
 	sdhci_writel(host, reg, SDHCI_TEGRA_VENDOR_CLOCK_CTRL);
+
+	if (soc_data->nvquirks & NVQUIRK_DIS_CARD_CLK_CONFIG_TAP &&
+	    card_clk_enabled) {
+		usleep_range(1, 2);
+		sdhci_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
+		tegra_sdhci_configure_card_clk(host, card_clk_enabled);
+	}
 }
 
 static int tegra_sdhci_execute_tuning(struct sdhci_host *host, u32 opcode)
@@ -759,7 +783,8 @@ static const struct sdhci_pltfm_data sdhci_tegra210_pdata = {
 static const struct sdhci_tegra_soc_data soc_data_tegra210 = {
 	.pdata = &sdhci_tegra210_pdata,
 	.nvquirks = NVQUIRK_NEEDS_PAD_CONTROL |
-		    NVQUIRK_HAS_PADCALIB,
+		    NVQUIRK_HAS_PADCALIB |
+		    NVQUIRK_DIS_CARD_CLK_CONFIG_TAP,
 };
 
 static const struct sdhci_pltfm_data sdhci_tegra186_pdata = {
@@ -784,7 +809,8 @@ static const struct sdhci_pltfm_data sdhci_tegra186_pdata = {
 static const struct sdhci_tegra_soc_data soc_data_tegra186 = {
 	.pdata = &sdhci_tegra186_pdata,
 	.nvquirks = NVQUIRK_NEEDS_PAD_CONTROL |
-		    NVQUIRK_HAS_PADCALIB,
+		    NVQUIRK_HAS_PADCALIB |
+		    NVQUIRK_DIS_CARD_CLK_CONFIG_TAP,
 };
 
 static const struct of_device_id sdhci_tegra_dt_match[] = {
-- 
2.7.4

