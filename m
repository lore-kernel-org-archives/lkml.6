Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F889C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 14:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 235AC20C0E
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 14:00:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 235AC20C0E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389482AbeHGQO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 12:14:57 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:1846 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389244AbeHGQO5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 12:14:57 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b69a5f10000>; Tue, 07 Aug 2018 07:00:17 -0700
Received: from HQMAIL104.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 07 Aug 2018 07:00:28 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 07 Aug 2018 07:00:28 -0700
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 7 Aug
 2018 14:00:27 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1347.2 via Frontend
 Transport; Tue, 7 Aug 2018 14:00:28 +0000
Received: from dhcp-10-21-25-168.Nvidia.com (Not Verified[10.21.25.201]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5b69a5f9000c>; Tue, 07 Aug 2018 07:00:28 -0700
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
Subject: [PATCH 4/8] mmc: tegra: Implement HS400 delay line calibration
Date:   Tue, 7 Aug 2018 17:00:00 +0300
Message-ID: <1533650404-18125-5-git-send-email-avienamo@nvidia.com>
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

Implement HS400 specific delay line calibration procedure.

Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index d81143b..d0b68b7 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -56,6 +56,12 @@
 #define SDHCI_MISC_CTRL_ENABLE_SDHCI_SPEC_300		0x20
 #define SDHCI_MISC_CTRL_ENABLE_DDR50			0x200
 
+#define SDHCI_TEGRA_VENDOR_DLLCAL_CFG			0x1b0
+#define SDHCI_TEGRA_DLLCAL_CALIBRATE			BIT(31)
+
+#define SDHCI_TEGRA_VENDOR_DLLCAL_STA			0x1bc
+#define SDHCI_TEGRA_DLLCAL_STA_ACTIVE			BIT(31)
+
 #define SDHCI_VNDR_TUN_CTRL0_0				0x1c0
 #define SDHCI_VNDR_TUN_CTRL0_TUN_HW_TAP			0x20000
 
@@ -584,6 +590,24 @@ static void tegra_sdhci_set_dqs_trim(struct sdhci_host *host, u8 val)
 	sdhci_writel(host, reg, SDHCI_TEGRA_VENDOR_CAP_OVERRIDES);
 }
 
+static void tegra_sdhci_hs400_dll_cal(struct sdhci_host *host)
+{
+	u32 reg;
+	int err;
+
+	reg = sdhci_readl(host, SDHCI_TEGRA_VENDOR_DLLCAL_CFG);
+	reg |= SDHCI_TEGRA_DLLCAL_CALIBRATE;
+	sdhci_writel(host, reg, SDHCI_TEGRA_VENDOR_DLLCAL_CFG);
+
+	/* 1 ms sleep, 5 ms timeout */
+	err = readl_poll_timeout(host->ioaddr + SDHCI_TEGRA_VENDOR_DLLCAL_STA,
+				 reg, !(reg & SDHCI_TEGRA_DLLCAL_STA_ACTIVE),
+				 1000, 5000);
+	if (err)
+		dev_err(mmc_dev(host->mmc),
+			"HS400 delay line calibration timed out\n");
+}
+
 static void tegra_sdhci_set_uhs_signaling(struct sdhci_host *host,
 					  unsigned timing)
 {
@@ -591,6 +615,7 @@ static void tegra_sdhci_set_uhs_signaling(struct sdhci_host *host,
 	struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
 	bool set_default_tap = false;
 	bool set_dqs_trim = false;
+	bool do_hs400_dll_cal = false;
 
 	switch (timing) {
 	case MMC_TIMING_UHS_SDR50:
@@ -600,6 +625,7 @@ static void tegra_sdhci_set_uhs_signaling(struct sdhci_host *host,
 		break;
 	case MMC_TIMING_MMC_HS400:
 		set_dqs_trim = true;
+		do_hs400_dll_cal = true;
 		break;
 	case MMC_TIMING_MMC_DDR52:
 	case MMC_TIMING_UHS_DDR50:
@@ -620,6 +646,9 @@ static void tegra_sdhci_set_uhs_signaling(struct sdhci_host *host,
 
 	if (set_dqs_trim)
 		tegra_sdhci_set_dqs_trim(host, tegra_host->dqs_trim);
+
+	if (do_hs400_dll_cal)
+		tegra_sdhci_hs400_dll_cal(host);
 }
 
 static int tegra_sdhci_execute_tuning(struct sdhci_host *host, u32 opcode)
-- 
2.7.4

