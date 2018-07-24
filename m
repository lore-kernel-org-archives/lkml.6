Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 918DCC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BDFD20852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 14:30:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BDFD20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388673AbeGXPgp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 11:36:45 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:17536 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388519AbeGXPgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 11:36:44 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b5737df0002>; Tue, 24 Jul 2018 07:29:51 -0700
Received: from HQMAIL106.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 24 Jul 2018 07:29:59 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 24 Jul 2018 07:29:59 -0700
Received: from HQMAIL104.nvidia.com (172.18.146.11) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 24 Jul
 2018 14:29:59 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1347.2 via Frontend
 Transport; Tue, 24 Jul 2018 14:29:58 +0000
Received: from dhcp-10-21-25-168.Nvidia.com (Not Verified[10.21.25.201]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5b5737e40001>; Tue, 24 Jul 2018 07:29:59 -0700
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
Subject: [PATCH 01/10] mmc: tegra: Poll for calibration completion
Date:   Tue, 24 Jul 2018 17:29:42 +0300
Message-ID: <1532442591-5640-2-git-send-email-avienamo@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532442591-5640-1-git-send-email-avienamo@nvidia.com>
References: <1532442591-5640-1-git-send-email-avienamo@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement polling with 10 ms timeout for automatic pad drive strength
calibration.

Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index f108c48..e40ca43 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -49,6 +49,9 @@
 #define SDHCI_AUTO_CAL_START			BIT(31)
 #define SDHCI_AUTO_CAL_ENABLE			BIT(29)
 
+#define SDHCI_TEGRA_AUTO_CAL_STATUS     0x1ec
+#define SDHCI_TEGRA_AUTO_CAL_ACTIVE     BIT(31)
+
 #define NVQUIRK_FORCE_SDHCI_SPEC_200	BIT(0)
 #define NVQUIRK_ENABLE_BLOCK_GAP_DET	BIT(1)
 #define NVQUIRK_ENABLE_SDHCI_SPEC_300	BIT(2)
@@ -198,13 +201,24 @@ static void tegra_sdhci_reset(struct sdhci_host *host, u8 mask)
 
 static void tegra_sdhci_pad_autocalib(struct sdhci_host *host)
 {
-	u32 val;
+	unsigned timeout = 10;
+	u32 reg;
 
-	mdelay(1);
+	reg = sdhci_readl(host, SDHCI_TEGRA_AUTO_CAL_CONFIG);
+	reg |= SDHCI_AUTO_CAL_ENABLE | SDHCI_AUTO_CAL_START;
+	sdhci_writel(host, reg, SDHCI_TEGRA_AUTO_CAL_CONFIG);
+	udelay(1);
+
+	do {
+		reg = sdhci_readl(host, SDHCI_TEGRA_AUTO_CAL_STATUS);
+		if (!(reg & SDHCI_TEGRA_AUTO_CAL_ACTIVE))
+			break;
+		mdelay(1);
+		timeout--;
+	} while (timeout);
 
-	val = sdhci_readl(host, SDHCI_TEGRA_AUTO_CAL_CONFIG);
-	val |= SDHCI_AUTO_CAL_ENABLE | SDHCI_AUTO_CAL_START;
-	sdhci_writel(host,val, SDHCI_TEGRA_AUTO_CAL_CONFIG);
+	if (timeout == 0)
+		dev_err(mmc_dev(host->mmc), "Pad autocal timed out\n");
 }
 
 static void tegra_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
-- 
2.7.4

