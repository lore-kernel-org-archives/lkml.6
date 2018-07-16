Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF52CECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 14:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F8B920877
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 14:34:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F8B920877
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbeGPPCZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 11:02:25 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:4238 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727342AbeGPPCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 11:02:25 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1, AES128-SHA)
        id <B5b4cacd10000>; Mon, 16 Jul 2018 07:33:53 -0700
Received: from HQMAIL106.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 16 Jul 2018 07:34:42 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 16 Jul 2018 07:34:42 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 16 Jul
 2018 14:34:42 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1347.2 via Frontend
 Transport; Mon, 16 Jul 2018 14:34:42 +0000
Received: from dhcp-10-21-25-168.Nvidia.com (Not Verified[10.21.25.201]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5b4cad000000>; Mon, 16 Jul 2018 07:34:42 -0700
From:   Aapo Vienamo <avienamo@nvidia.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Stefan Agner <stefan@agner.ch>
CC:     <linux-mmc@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Aapo Vienamo <avienamo@nvidia.com>
Subject: [PATCH] mmc: tegra: Force correct divider calculation on DDR50/52
Date:   Mon, 16 Jul 2018 17:34:29 +0300
Message-ID: <1531751669-26584-1-git-send-email-avienamo@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra SDHCI controllers require the SDHCI clock divider to be configured
to divide the clock by two in DDR50/52 modes. Incorrectly configured
clock divider results in corrupted data.

Prevent the possibility of incorrectly calculating the divider value due
to clock rate rounding or low parent clock frequency by not assigning
host->max_clk to clk_get_rate() on tegra_sdhci_set_clock().

See the comments for further details.

Fixes: a8e326a ("mmc: tegra: implement module external clock change")
Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index ddf00166..908b23e 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -210,9 +210,24 @@ static void tegra_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
 	if (!clock)
 		return sdhci_set_clock(host, clock);
 
+	/*
+	 * In DDR50/52 modes the Tegra SDHCI controllers require the SDHCI
+	 * divider to be configured to divided the host clock by two. The SDHCI
+	 * clock divider is calculated as part of sdhci_set_clock() by
+	 * sdhci_calc_clk(). The divider is calculated from host->max_clk and
+	 * the requested clock rate.
+	 *
+	 * By setting the host->max_clk to clock * 2 the divider calculation
+	 * will always result in the correct value for DDR50/52 modes,
+	 * regardless of clock rate rounding, which may happen if the value
+	 * from clk_get_rate() is used.
+	 */
 	host_clk = tegra_host->ddr_signaling ? clock * 2 : clock;
 	clk_set_rate(pltfm_host->clk, host_clk);
-	host->max_clk = clk_get_rate(pltfm_host->clk);
+	if (tegra_host->ddr_signaling)
+		host->max_clk = host_clk;
+	else
+		host->max_clk = clk_get_rate(pltfm_host->clk);
 
 	sdhci_set_clock(host, clock);
 
-- 
2.7.4

