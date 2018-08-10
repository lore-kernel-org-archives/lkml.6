Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC9EEC4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 18:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B380921EFB
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 18:09:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B380921EFB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729979AbeHJUkY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 16:40:24 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:3543 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729666AbeHJUkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 16:40:24 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b6dd4d50000>; Fri, 10 Aug 2018 11:09:25 -0700
Received: from HQMAIL108.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 10 Aug 2018 11:09:28 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 10 Aug 2018 11:09:28 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 10 Aug
 2018 18:09:28 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1347.2 via Frontend
 Transport; Fri, 10 Aug 2018 18:09:28 +0000
Received: from dhcp-10-21-25-168.Nvidia.com (Not Verified[10.21.25.201]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5b6dd4d50000>; Fri, 10 Aug 2018 11:09:28 -0700
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
Subject: [PATCH v2 13/40] mmc: tegra: Poll for calibration completion
Date:   Fri, 10 Aug 2018 21:08:15 +0300
Message-ID: <1533924522-1037-14-git-send-email-avienamo@nvidia.com>
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

Implement polling with 10 ms timeout for automatic pad drive strength
calibration.

Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 5e7f9ba..a62a3fc 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -16,6 +16,7 @@
 #include <linux/err.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/iopoll.h>
 #include <linux/platform_device.h>
 #include <linux/clk.h>
 #include <linux/io.h>
@@ -50,6 +51,9 @@
 #define SDHCI_AUTO_CAL_START			BIT(31)
 #define SDHCI_AUTO_CAL_ENABLE			BIT(29)
 
+#define SDHCI_TEGRA_AUTO_CAL_STATUS		0x1ec
+#define SDHCI_TEGRA_AUTO_CAL_ACTIVE		BIT(31)
+
 #define NVQUIRK_FORCE_SDHCI_SPEC_200	BIT(0)
 #define NVQUIRK_ENABLE_BLOCK_GAP_DET	BIT(1)
 #define NVQUIRK_ENABLE_SDHCI_SPEC_300	BIT(2)
@@ -226,13 +230,21 @@ static void tegra_sdhci_reset(struct sdhci_host *host, u8 mask)
 
 static void tegra_sdhci_pad_autocalib(struct sdhci_host *host)
 {
-	u32 val;
+	u32 reg;
+	int ret;
+
+	reg = sdhci_readl(host, SDHCI_TEGRA_AUTO_CAL_CONFIG);
+	reg |= SDHCI_AUTO_CAL_ENABLE | SDHCI_AUTO_CAL_START;
+	sdhci_writel(host, reg, SDHCI_TEGRA_AUTO_CAL_CONFIG);
 
-	mdelay(1);
+	usleep_range(1, 2);
+	/* 10 ms timeout */
+	ret = readl_poll_timeout(host->ioaddr + SDHCI_TEGRA_AUTO_CAL_STATUS,
+				 reg, !(reg & SDHCI_TEGRA_AUTO_CAL_ACTIVE),
+				 1000, 10000);
 
-	val = sdhci_readl(host, SDHCI_TEGRA_AUTO_CAL_CONFIG);
-	val |= SDHCI_AUTO_CAL_ENABLE | SDHCI_AUTO_CAL_START;
-	sdhci_writel(host,val, SDHCI_TEGRA_AUTO_CAL_CONFIG);
+	if (ret)
+		dev_err(mmc_dev(host->mmc), "Pad autocal timed out\n");
 }
 
 static void tegra_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
-- 
2.7.4

