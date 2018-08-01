Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6235C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 16:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6571D208A4
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 16:33:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6571D208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403797AbeHASU2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 14:20:28 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:2994 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403781AbeHASU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 14:20:27 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b61e0ee0006>; Wed, 01 Aug 2018 09:33:50 -0700
Received: from HQMAIL108.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 01 Aug 2018 09:33:55 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 01 Aug 2018 09:33:55 -0700
Received: from HQMAIL108.nvidia.com (172.18.146.13) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 1 Aug
 2018 16:33:54 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1347.2 via Frontend
 Transport; Wed, 1 Aug 2018 16:33:54 +0000
Received: from dhcp-10-21-25-168.Nvidia.com (Not Verified[10.21.25.201]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5b61e0f00000>; Wed, 01 Aug 2018 09:33:55 -0700
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
Subject: [PATCH 24/40] mmc: tegra: Use standard SDHCI tuning on Tegra210 and Tegra186
Date:   Wed, 1 Aug 2018 19:32:14 +0300
Message-ID: <1533141150-10511-25-git-send-email-avienamo@nvidia.com>
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

Add a new sdhci_ops struct for Tegra210 and Tegra186 which doesn't
set the custom tuning callback used on previous SoC generations.

Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 4cef437..7e6f928 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -814,6 +814,18 @@ static const struct sdhci_tegra_soc_data soc_data_tegra124 = {
 	.pdata = &sdhci_tegra124_pdata,
 };
 
+static const struct sdhci_ops tegra210_sdhci_ops = {
+	.get_ro     = tegra_sdhci_get_ro,
+	.read_w     = tegra_sdhci_readw,
+	.write_w    = tegra_sdhci_writew,
+	.write_l    = tegra_sdhci_writel,
+	.set_clock  = tegra_sdhci_set_clock,
+	.set_bus_width = sdhci_set_bus_width,
+	.reset      = tegra_sdhci_reset,
+	.set_uhs_signaling = tegra_sdhci_set_uhs_signaling,
+	.get_max_clock = tegra_sdhci_get_max_clock,
+};
+
 static const struct sdhci_pltfm_data sdhci_tegra210_pdata = {
 	.quirks = SDHCI_QUIRK_BROKEN_TIMEOUT_VAL |
 		  SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK |
@@ -822,7 +834,7 @@ static const struct sdhci_pltfm_data sdhci_tegra210_pdata = {
 		  SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC |
 		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
 	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
-	.ops  = &tegra114_sdhci_ops,
+	.ops  = &tegra210_sdhci_ops,
 };
 
 static const struct sdhci_tegra_soc_data soc_data_tegra210 = {
@@ -848,7 +860,7 @@ static const struct sdhci_pltfm_data sdhci_tegra186_pdata = {
 		    * But it is not supported as of now.
 		    */
 		   SDHCI_QUIRK2_BROKEN_64_BIT_DMA,
-	.ops  = &tegra114_sdhci_ops,
+	.ops  = &tegra210_sdhci_ops,
 };
 
 static const struct sdhci_tegra_soc_data soc_data_tegra186 = {
-- 
2.7.4

