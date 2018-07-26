Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C30BC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 12:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA32020894
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 12:27:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA32020894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731504AbeGZNnu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 09:43:50 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:12197 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730175AbeGZNnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 09:43:49 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b59be150002>; Thu, 26 Jul 2018 05:27:01 -0700
Received: from HQMAIL106.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 26 Jul 2018 05:27:12 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 26 Jul 2018 05:27:12 -0700
Received: from HQMAIL112.nvidia.com (172.18.146.18) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 26 Jul
 2018 12:27:11 +0000
Received: from HQMAIL108.nvidia.com (172.18.146.13) by HQMAIL112.nvidia.com
 (172.18.146.18) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 26 Jul
 2018 12:27:11 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1347.2 via Frontend
 Transport; Thu, 26 Jul 2018 12:27:11 +0000
Received: from dhcp-10-21-25-168.Nvidia.com (Not Verified[10.21.25.201]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5b59be1c0002>; Thu, 26 Jul 2018 05:27:10 -0700
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
Subject: [PATCH v2 03/10] mmc: tegra: Power on the calibration pad
Date:   Thu, 26 Jul 2018 15:26:49 +0300
Message-ID: <1532608016-14319-4-git-send-email-avienamo@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532608016-14319-1-git-send-email-avienamo@nvidia.com>
References: <1532608016-14319-1-git-send-email-avienamo@nvidia.com>
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
 drivers/mmc/host/sdhci-tegra.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 51eda20..363490e 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -53,6 +53,7 @@
 #define SDHCI_TEGRA_SDMEM_COMP_PADCTRL			0x1e0
 #define SDHCI_TEGRA_SDMEM_COMP_PADCTRL_VREF_SEL_MASK	0x0000000f
 #define SDHCI_TEGRA_SDMEM_COMP_PADCTRL_VREF_SEL_VAL	0x7
+#define SDHCI_TEGRA_SDMEM_COMP_PADCTRL_E_INPUT_E_PWRD	BIT(31)
 
 #define SDHCI_TEGRA_AUTO_CAL_STATUS			0x1ec
 #define SDHCI_TEGRA_AUTO_CAL_ACTIVE			BIT(31)
@@ -241,11 +242,30 @@ static void tegra_sdhci_reset(struct sdhci_host *host, u8 mask)
 	tegra_host->ddr_signaling = false;
 }
 
+static void tegra_sdhci_configure_cal_pad(struct sdhci_host *host, bool enable)
+{
+	u32 reg;
+
+	/*
+	 * Enable or disable the additional I/O pad used by the drive strength
+	 * calibration process.
+	 */
+	reg = sdhci_readl(host, SDHCI_TEGRA_SDMEM_COMP_PADCTRL);
+	if (enable)
+		reg |= SDHCI_TEGRA_SDMEM_COMP_PADCTRL_E_INPUT_E_PWRD;
+	else
+		reg &= ~SDHCI_TEGRA_SDMEM_COMP_PADCTRL_E_INPUT_E_PWRD;
+	sdhci_writel(host, reg, SDHCI_TEGRA_SDMEM_COMP_PADCTRL);
+	udelay(1);
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
@@ -255,6 +275,8 @@ static void tegra_sdhci_pad_autocalib(struct sdhci_host *host)
 				 reg, !(reg & SDHCI_TEGRA_AUTO_CAL_ACTIVE),
 				 1, 10000);
 
+	tegra_sdhci_configure_cal_pad(host, false);
+
 	if (ret)
 		dev_err(mmc_dev(host->mmc), "Pad autocal timed out\n");
 }
-- 
2.7.4

