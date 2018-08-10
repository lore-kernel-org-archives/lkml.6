Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEFA7C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 18:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 863C622453
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 18:09:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 863C622453
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730043AbeHJUkb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 16:40:31 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:3555 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729666AbeHJUka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 16:40:30 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b6dd4dc0000>; Fri, 10 Aug 2018 11:09:32 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 10 Aug 2018 11:09:29 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 10 Aug 2018 11:09:29 -0700
Received: from HQMAIL103.nvidia.com (172.20.187.11) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 10 Aug
 2018 18:09:34 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1347.2 via Frontend
 Transport; Fri, 10 Aug 2018 18:09:34 +0000
Received: from dhcp-10-21-25-168.Nvidia.com (Not Verified[10.21.25.201]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5b6dd4db0002>; Fri, 10 Aug 2018 11:09:34 -0700
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
Subject: [PATCH v2 15/40] mmc: tegra: Power on the calibration pad
Date:   Fri, 10 Aug 2018 21:08:17 +0300
Message-ID: <1533924522-1037-16-git-send-email-avienamo@nvidia.com>
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

Automatic pad drive strength calibration is performed on a separate pad
identical to the ones used for driving the actual bus. Power on the
calibration pad during the calibration procedure and power it off
afterwards to save power.

Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 6ddc7c2..a00e366 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -54,6 +54,7 @@
 #define SDHCI_TEGRA_SDMEM_COMP_PADCTRL			0x1e0
 #define SDHCI_TEGRA_SDMEM_COMP_PADCTRL_VREF_SEL_MASK	0x0000000f
 #define SDHCI_TEGRA_SDMEM_COMP_PADCTRL_VREF_SEL_VAL	0x7
+#define SDHCI_TEGRA_SDMEM_COMP_PADCTRL_E_INPUT_E_PWRD	BIT(31)
 
 #define SDHCI_TEGRA_AUTO_CAL_STATUS			0x1ec
 #define SDHCI_TEGRA_AUTO_CAL_ACTIVE			BIT(31)
@@ -238,11 +239,34 @@ static void tegra_sdhci_reset(struct sdhci_host *host, u8 mask)
 	tegra_host->ddr_signaling = false;
 }
 
+static void tegra_sdhci_configure_cal_pad(struct sdhci_host *host, bool enable)
+{
+	u32 val;
+
+	/*
+	 * Enable or disable the additional I/O pad used by the drive strength
+	 * calibration process.
+	 */
+	val = sdhci_readl(host, SDHCI_TEGRA_SDMEM_COMP_PADCTRL);
+
+	if (enable)
+		val |= SDHCI_TEGRA_SDMEM_COMP_PADCTRL_E_INPUT_E_PWRD;
+	else
+		val &= ~SDHCI_TEGRA_SDMEM_COMP_PADCTRL_E_INPUT_E_PWRD;
+
+	sdhci_writel(host, val, SDHCI_TEGRA_SDMEM_COMP_PADCTRL);
+
+	if (enable)
+		usleep_range(1, 2);
+}
+
 static void tegra_sdhci_pad_autocalib(struct sdhci_host *host)
 {
 	u32 reg;
 	int ret;
 
+	tegra_sdhci_configure_cal_pad(host, true);
+
 	reg = sdhci_readl(host, SDHCI_TEGRA_AUTO_CAL_CONFIG);
 	reg |= SDHCI_AUTO_CAL_ENABLE | SDHCI_AUTO_CAL_START;
 	sdhci_writel(host, reg, SDHCI_TEGRA_AUTO_CAL_CONFIG);
@@ -253,6 +277,8 @@ static void tegra_sdhci_pad_autocalib(struct sdhci_host *host)
 				 reg, !(reg & SDHCI_TEGRA_AUTO_CAL_ACTIVE),
 				 1000, 10000);
 
+	tegra_sdhci_configure_cal_pad(host, false);
+
 	if (ret)
 		dev_err(mmc_dev(host->mmc), "Pad autocal timed out\n");
 }
-- 
2.7.4

