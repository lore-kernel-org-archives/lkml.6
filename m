Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 262B6C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCA1220835
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:07:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCA1220835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729728AbeH3TKT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 15:10:19 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:11558 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728787AbeH3TKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 15:10:17 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5b88083a0000>; Thu, 30 Aug 2018 08:07:38 -0700
Received: from HQMAIL105.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 30 Aug 2018 08:07:42 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 30 Aug 2018 08:07:42 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 30 Aug
 2018 15:07:41 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 30 Aug
 2018 15:07:41 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Thu, 30 Aug 2018 15:07:41 +0000
Received: from dhcp-10-21-25-168.Nvidia.com (Not Verified[10.21.25.201]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5b88083b0000>; Thu, 30 Aug 2018 08:07:41 -0700
From:   Aapo Vienamo <avienamo@nvidia.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        "Stefan Agner" <stefan@agner.ch>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        Aapo Vienamo <avienamo@nvidia.com>
Subject: [PATCH v3 18/38] mmc: tegra: Enable pad calibration on Tegra210 and Tegra186
Date:   Thu, 30 Aug 2018 18:06:19 +0300
Message-ID: <20180830150639.21048-19-avienamo@nvidia.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180830150639.21048-1-avienamo@nvidia.com>
References: <20180830150639.21048-1-avienamo@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set NVQUIRK_HAS_PADCALIB on Tegra210 and Tegra186 to enable automatic
pad drive strength calibration.

Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 71b3b3e1c648..caa9a1b30d2e 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -773,7 +773,8 @@ static const struct sdhci_pltfm_data sdhci_tegra210_pdata = {
 
 static const struct sdhci_tegra_soc_data soc_data_tegra210 = {
 	.pdata = &sdhci_tegra210_pdata,
-	.nvquirks = NVQUIRK_NEEDS_PAD_CONTROL,
+	.nvquirks = NVQUIRK_NEEDS_PAD_CONTROL |
+		    NVQUIRK_HAS_PADCALIB,
 };
 
 static const struct sdhci_pltfm_data sdhci_tegra186_pdata = {
@@ -797,7 +798,8 @@ static const struct sdhci_pltfm_data sdhci_tegra186_pdata = {
 
 static const struct sdhci_tegra_soc_data soc_data_tegra186 = {
 	.pdata = &sdhci_tegra186_pdata,
-	.nvquirks = NVQUIRK_NEEDS_PAD_CONTROL,
+	.nvquirks = NVQUIRK_NEEDS_PAD_CONTROL |
+		    NVQUIRK_HAS_PADCALIB,
 };
 
 static const struct of_device_id sdhci_tegra_dt_match[] = {
-- 
2.18.0

