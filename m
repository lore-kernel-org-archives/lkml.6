Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD303C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 09:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 931342154B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 09:23:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 931342154B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbeHTMie (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 08:38:34 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:5327 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbeHTMid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 08:38:33 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5b7a88850001>; Mon, 20 Aug 2018 02:23:17 -0700
Received: from HQMAIL103.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 20 Aug 2018 02:23:42 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 20 Aug 2018 02:23:42 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 20 Aug
 2018 09:23:41 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 20 Aug
 2018 09:23:41 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1347.2 via Frontend
 Transport; Mon, 20 Aug 2018 09:23:41 +0000
Received: from dhcp-10-21-25-168.Nvidia.com (Not Verified[10.21.25.201]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5b7a889b0002>; Mon, 20 Aug 2018 02:23:41 -0700
From:   Aapo Vienamo <avienamo@nvidia.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        "Jonathan Hunter" <jonathanh@nvidia.com>
CC:     <linux-mmc@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Aapo Vienamo <avienamo@nvidia.com>
Subject: [PATCH 2/2] mmc: tegra: Implement periodic pad calibration
Date:   Mon, 20 Aug 2018 12:23:33 +0300
Message-ID: <1534757013-4524-3-git-send-email-avienamo@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534757013-4524-1-git-send-email-avienamo@nvidia.com>
References: <1534757013-4524-1-git-send-email-avienamo@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rerun the pad calibration procedure before sdhci_request() if
the 100 ms recalibration interval has been exceeded.

Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
---
 drivers/mmc/host/sdhci-tegra.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index 94624ec..ef18a0c 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -30,6 +30,7 @@
 #include <linux/mmc/mmc.h>
 #include <linux/mmc/slot-gpio.h>
 #include <linux/gpio/consumer.h>
+#include <linux/ktime.h>
 
 #include "sdhci-pltfm.h"
 
@@ -122,6 +123,7 @@ struct sdhci_tegra {
 	struct pinctrl_state *pinctrl_state_1v8;
 
 	struct sdhci_tegra_autocal_offsets autocal_offsets;
+	ktime_t last_calib;
 
 	u32 default_tap;
 	u32 default_trim;
@@ -533,6 +535,22 @@ static void tegra_sdhci_parse_pad_autocal_dt(struct sdhci_host *host)
 		autocal->pull_down_hs400 = autocal->pull_down_1v8;
 }
 
+static void tegra_sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_tegra *tegra_host = sdhci_pltfm_priv(pltfm_host);
+	ktime_t since_calib = ktime_sub(ktime_get(), tegra_host->last_calib);
+
+	/* 100 ms calibration interval is specified in the TRM */
+	if (ktime_to_ms(since_calib) > 100) {
+		tegra_sdhci_pad_autocalib(host);
+		tegra_host->last_calib = ktime_get();
+	}
+
+	sdhci_request(mmc, mrq);
+}
+
 static void tegra_sdhci_parse_tap_and_trim(struct sdhci_host *host)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -1014,6 +1032,10 @@ static int sdhci_tegra_probe(struct platform_device *pdev)
 				sdhci_tegra_start_signal_voltage_switch;
 	}
 
+	/* Hook to periodically rerun pad calibration */
+	if (soc_data->nvquirks & NVQUIRK_HAS_PADCALIB)
+		host->mmc_host_ops.request = tegra_sdhci_request;
+
 	host->mmc_host_ops.hs400_enhanced_strobe =
 			tegra_sdhci_hs400_enhanced_strobe;
 
-- 
2.7.4

