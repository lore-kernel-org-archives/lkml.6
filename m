Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED98ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 13:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48D7D208A4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 13:17:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48D7D208A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729762AbeGMNc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 09:32:28 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:18837 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729623AbeGMNc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 09:32:28 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b48a6500000>; Fri, 13 Jul 2018 06:17:04 -0700
Received: from HQMAIL103.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 13 Jul 2018 06:17:50 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 13 Jul 2018 06:17:50 -0700
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 13 Jul
 2018 13:17:49 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1347.2 via Frontend
 Transport; Fri, 13 Jul 2018 13:17:49 +0000
Received: from dhcp-10-21-25-168.Nvidia.com (Not Verified[10.21.25.201]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5b48a67c0000>; Fri, 13 Jul 2018 06:17:49 -0700
From:   Aapo Vienamo <avienamo@nvidia.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>
CC:     <linux-mmc@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Aapo Vienamo <avienamo@nvidia.com>
Subject: [PATCH] mmc: tegra: Add and use tegra_sdhci_get_max_clock()
Date:   Fri, 13 Jul 2018 16:17:45 +0300
Message-ID: <1531487865-17427-1-git-send-email-avienamo@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement and use tegra_sdhci_get_max_clock() which returns the true
maximum host clock rate. The issue with tegra_sdhci_get_max_clock() is
that it returns the current clock rate of the host instead of the
maximum one, which can lead to unnecessarily small clock rates.

This differs from the previous implementation of
tegra_sdhci_get_max_clock() in that it doesn't divide the result by two.

Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 28b98e2..ddf00166 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -235,6 +235,13 @@ static void tegra_sdhci_set_uhs_signaling(struct sdhci_host *host,
 	sdhci_set_uhs_signaling(host, timing);
 }
 
+static unsigned int tegra_sdhci_get_max_clock(struct sdhci_host *host)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+
+	return clk_round_rate(pltfm_host->clk, UINT_MAX);
+}
+
 static void tegra_sdhci_set_tap(struct sdhci_host *host, unsigned int tap)
 {
 	u32 reg;
@@ -299,7 +306,7 @@ static const struct sdhci_ops tegra_sdhci_ops = {
 	.platform_execute_tuning = tegra_sdhci_execute_tuning,
 	.set_uhs_signaling = tegra_sdhci_set_uhs_signaling,
 	.voltage_switch = tegra_sdhci_voltage_switch,
-	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
+	.get_max_clock = tegra_sdhci_get_max_clock,
 };
 
 static const struct sdhci_pltfm_data sdhci_tegra20_pdata = {
@@ -356,7 +363,7 @@ static const struct sdhci_ops tegra114_sdhci_ops = {
 	.platform_execute_tuning = tegra_sdhci_execute_tuning,
 	.set_uhs_signaling = tegra_sdhci_set_uhs_signaling,
 	.voltage_switch = tegra_sdhci_voltage_switch,
-	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
+	.get_max_clock = tegra_sdhci_get_max_clock,
 };
 
 static const struct sdhci_pltfm_data sdhci_tegra114_pdata = {
-- 
2.7.4

