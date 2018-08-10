Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 352E1C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 18:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF3BC21EFB
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 18:09:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF3BC21EFB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730073AbeHJUke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 16:40:34 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:11356 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729666AbeHJUkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 16:40:33 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b6dd4d30002>; Fri, 10 Aug 2018 11:09:23 -0700
Received: from HQMAIL107.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 10 Aug 2018 11:09:38 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 10 Aug 2018 11:09:38 -0700
Received: from HQMAIL110.nvidia.com (172.18.146.15) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 10 Aug
 2018 18:09:38 +0000
Received: from HQMAIL102.nvidia.com (172.18.146.10) by hqmail110.nvidia.com
 (172.18.146.15) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 10 Aug
 2018 18:09:37 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1347.2 via Frontend
 Transport; Fri, 10 Aug 2018 18:09:37 +0000
Received: from dhcp-10-21-25-168.Nvidia.com (Not Verified[10.21.25.201]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5b6dd4de0002>; Fri, 10 Aug 2018 11:09:37 -0700
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
Subject: [PATCH v2 16/40] mmc: tegra: Disable card clock during pad calibration
Date:   Fri, 10 Aug 2018 21:08:18 +0300
Message-ID: <1533924522-1037-17-git-send-email-avienamo@nvidia.com>
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

Disable the card clock during automatic pad drive strength calibration
and re-enable it afterwards.

Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index a00e366..f1eda0c 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -260,11 +260,35 @@ static void tegra_sdhci_configure_cal_pad(struct sdhci_host *host, bool enable)
 		usleep_range(1, 2);
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
 static void tegra_sdhci_pad_autocalib(struct sdhci_host *host)
 {
+	bool card_clk_enabled;
 	u32 reg;
 	int ret;
 
+	card_clk_enabled = tegra_sdhci_configure_card_clk(host, false);
+
 	tegra_sdhci_configure_cal_pad(host, true);
 
 	reg = sdhci_readl(host, SDHCI_TEGRA_AUTO_CAL_CONFIG);
@@ -279,6 +303,8 @@ static void tegra_sdhci_pad_autocalib(struct sdhci_host *host)
 
 	tegra_sdhci_configure_cal_pad(host, false);
 
+	tegra_sdhci_configure_card_clk(host, card_clk_enabled);
+
 	if (ret)
 		dev_err(mmc_dev(host->mmc), "Pad autocal timed out\n");
 }
-- 
2.7.4

