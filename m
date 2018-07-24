Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B24C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8355B20874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:34:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8355B20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388564AbeGXPlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 11:41:21 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:16539 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388373AbeGXPlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 11:41:20 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b5738ef0000>; Tue, 24 Jul 2018 07:34:24 -0700
Received: from HQMAIL101.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 24 Jul 2018 07:34:33 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 24 Jul 2018 07:34:33 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 24 Jul
 2018 14:34:33 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1347.2 via Frontend
 Transport; Tue, 24 Jul 2018 14:34:33 +0000
Received: from dhcp-10-21-25-168.Nvidia.com (Not Verified[10.21.25.201]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5b5738f60000>; Tue, 24 Jul 2018 07:34:33 -0700
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
Subject: [PATCH 03/10] mmc: tegra: Power on the calibration pad
Date:   Tue, 24 Jul 2018 17:34:19 +0300
Message-ID: <1532442865-6391-2-git-send-email-avienamo@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532442865-6391-1-git-send-email-avienamo@nvidia.com>
References: <1532442591-5640-1-git-send-email-avienamo@nvidia.com>
 <1532442865-6391-1-git-send-email-avienamo@nvidia.com>
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
---
 drivers/mmc/host/sdhci-tegra.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 6008e2f..61067b7 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -209,11 +209,30 @@ static void tegra_sdhci_reset(struct sdhci_host *host, u8 mask)
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
+		reg |= SDHCI_TEGRA_PAD_E_INPUT_OR_E_PWRD;
+	else
+		reg &= ~SDHCI_TEGRA_PAD_E_INPUT_OR_E_PWRD;
+	sdhci_writel(host, reg, SDHCI_TEGRA_SDMEM_COMP_PADCTRL);
+	udelay(1);
+}
+
 static void tegra_sdhci_pad_autocalib(struct sdhci_host *host)
 {
 	unsigned timeout = 10;
 	u32 reg;
 
+	tegra_sdhci_configure_cal_pad(host, true);
+
 	reg = sdhci_readl(host, SDHCI_TEGRA_AUTO_CAL_CONFIG);
 	reg |= SDHCI_AUTO_CAL_ENABLE | SDHCI_AUTO_CAL_START;
 	sdhci_writel(host, reg, SDHCI_TEGRA_AUTO_CAL_CONFIG);
@@ -227,6 +246,8 @@ static void tegra_sdhci_pad_autocalib(struct sdhci_host *host)
 		timeout--;
 	} while (timeout);
 
+	tegra_sdhci_configure_cal_pad(host, false);
+
 	if (timeout == 0)
 		dev_err(mmc_dev(host->mmc), "Pad autocal timed out\n");
 }
-- 
2.7.4

