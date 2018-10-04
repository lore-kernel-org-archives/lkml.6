Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6526AC64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 11:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DEAB21473
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 11:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="D6Po1BXA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DEAB21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbeJDSFj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 14:05:39 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:60256 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727478AbeJDSFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 14:05:38 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w94BCkt9103648;
        Thu, 4 Oct 2018 06:12:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1538651566;
        bh=h0LDHdmxjiaw06MoNYiXsTQPaKYTwXh15HZCFu6Bskg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=D6Po1BXAeEup5n1WUH7MkKyG3XzjRa/0DtwhR6zFPbmc9mqCKYIDAyG3C/w7gUeyk
         SOfvrflp7UDXcpTj53enaXXst6LcInCcrar3/yv79yN9M7am1q8rDsWlCwJuErMfBv
         qESsP0EyVhcUU8cKbSXf+O0TEpIsuo5UUP2nzqak=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w94BCkI3020189;
        Thu, 4 Oct 2018 06:12:46 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 4 Oct
 2018 06:12:46 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 4 Oct 2018 06:12:46 -0500
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w94BCSLf027478;
        Thu, 4 Oct 2018 06:12:43 -0500
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>
CC:     <kishon@ti.com>, <faiz_abbas@ti.com>, <ulf.hansson@linaro.org>,
        <robh+dt@kernel.org>, <catalin.marinas@arm.com>,
        <adrian.hunter@intel.com>
Subject: [PATCH 5/6] mmc: sdhci-of-arasan: Add Support for AM654 MMC and PHY
Date:   Thu, 4 Oct 2018 16:44:50 +0530
Message-ID: <20181004111451.9539-6-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20181004111451.9539-1-faiz_abbas@ti.com>
References: <20181004111451.9539-1-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current arasan sdhci PHY configuration isn't compatible
with the PHY on TI's AM654 devices.

Therefore, add a new compatible, AM654 specific quirks
and a new AM654 specific set_clock function which
configures the PHY in a sane way.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 drivers/mmc/host/sdhci-of-arasan.c | 46 ++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index c9e3e050ccc8..142c4b802f31 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -231,6 +231,25 @@ static void sdhci_arasan_set_clock(struct sdhci_host *host, unsigned int clock)
 	}
 }
 
+static void sdhci_arasan_am654_set_clock(struct sdhci_host *host,
+					 unsigned int clock)
+{
+	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
+	struct sdhci_arasan_data *sdhci_arasan = sdhci_pltfm_priv(pltfm_host);
+
+	if (sdhci_arasan->is_phy_on) {
+		phy_power_off(sdhci_arasan->phy);
+		sdhci_arasan->is_phy_on = false;
+	}
+
+	sdhci_set_clock(host, clock);
+
+	if (clock > PHY_CLK_TOO_SLOW_HZ) {
+		phy_power_on(sdhci_arasan->phy);
+		sdhci_arasan->is_phy_on = true;
+	}
+}
+
 static void sdhci_arasan_hs400_enhanced_strobe(struct mmc_host *mmc,
 					struct mmc_ios *ios)
 {
@@ -316,6 +335,29 @@ static struct sdhci_arasan_of_data sdhci_arasan_data = {
 	.pdata = &sdhci_arasan_pdata,
 };
 
+static const struct sdhci_ops sdhci_arasan_am654_ops = {
+	.set_clock = sdhci_arasan_am654_set_clock,
+	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
+	.get_timeout_clock = sdhci_pltfm_clk_get_max_clock,
+	.set_bus_width = sdhci_set_bus_width,
+	.reset = sdhci_arasan_reset,
+	.set_uhs_signaling = sdhci_set_uhs_signaling,
+};
+
+static const struct sdhci_pltfm_data sdhci_arasan_am654_pdata = {
+	.ops = &sdhci_arasan_am654_ops,
+	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN  |
+		  SDHCI_QUIRK_INVERTED_WRITE_PROTECT |
+		  SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12,
+	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
+		   SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN |
+		   SDHCI_QUIRK2_CAPS_BIT63_FOR_HS400,
+};
+
+static const struct sdhci_arasan_of_data sdhci_arasan_am654_data = {
+	.pdata = &sdhci_arasan_am654_pdata,
+};
+
 static u32 sdhci_arasan_cqhci_irq(struct sdhci_host *host, u32 intmask)
 {
 	int cmd_error = 0;
@@ -478,6 +520,10 @@ static const struct of_device_id sdhci_arasan_of_match[] = {
 		.compatible = "rockchip,rk3399-sdhci-5.1",
 		.data = &sdhci_arasan_rk3399_data,
 	},
+	{
+		.compatible = "ti,am654-sdhci-5.1",
+		.data = &sdhci_arasan_am654_data,
+	},
 	/* Generic compatible below here */
 	{
 		.compatible = "arasan,sdhci-8.9a",
-- 
2.18.0

