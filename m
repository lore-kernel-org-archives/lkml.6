Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC11C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 11:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A6892184B
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 11:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Sh4bRYuz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732144AbfAKLGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 06:06:16 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:34568 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732130AbfAKLGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 06:06:15 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0BB69Pe113754;
        Fri, 11 Jan 2019 05:06:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547204769;
        bh=wteOl5uvyjVk6GljbaTc8Q2ud1451fQf4mi1LazvlsQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Sh4bRYuz11FsU3Pp5rUZ0Z/N0FGCI7O8e0VIUU9QhUaogIh9BNLJCT6ZSdjXKdEbJ
         1GIeGFL1s0AhG57TaTzT1wEh5wps71AM9VwXGQzOLugPmaCS51qzzibWqU0+TI7yW0
         9c0jTNoJUUXSEFzJiONl9avej6d78SsvcUgsWUhs=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0BB698T119264
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Jan 2019 05:06:09 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 11
 Jan 2019 05:06:09 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 11 Jan 2019 05:06:09 -0600
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0BB5xEs024503;
        Fri, 11 Jan 2019 05:06:06 -0600
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>
CC:     <zhang.chunyan@linaro.org>, <kishon@ti.com>,
        <adrian.hunter@intel.com>, <mark.rutland@arm.com>,
        <robh+dt@kernel.org>, <ulf.hansson@linaro.org>, <faiz_abbas@ti.com>
Subject: [PATCH 2/7] mmc: sdhci-omap: Add using external dma
Date:   Fri, 11 Jan 2019 16:38:46 +0530
Message-ID: <20190111110851.6805-3-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190111110851.6805-1-faiz_abbas@ti.com>
References: <20190111110851.6805-1-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <zhang.chunyan@linaro.org>

sdhci-omap can support both external dma controller via dmaengine framework
as well as ADMA which standard SD host controller provides.

Fixes by Faiz Abbas <fazi_abbas@ti.com>:
1. Switch to DMA slave mode when using external DMA
2. Add offset to mapbase

Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 drivers/mmc/host/Kconfig      |  1 +
 drivers/mmc/host/sdhci-omap.c | 16 +++++++++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 333292e8ecdd..70e90b00cb37 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -979,6 +979,7 @@ config MMC_SDHCI_OMAP
 	depends on MMC_SDHCI_PLTFM && OF
 	select THERMAL
 	select TI_SOC_THERMAL
+	select MMC_SDHCI_EXTERNAL_DMA if DMA_ENGINE
 	help
 	  This selects the Secure Digital Host Controller Interface (SDHCI)
 	  support present in TI's DRA7 SOCs. The controller supports
diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index c11c18a9aacb..8a05e94fe612 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -696,7 +696,11 @@ static int sdhci_omap_enable_dma(struct sdhci_host *host)
 	struct sdhci_omap_host *omap_host = sdhci_pltfm_priv(pltfm_host);
 
 	reg = sdhci_omap_readl(omap_host, SDHCI_OMAP_CON);
-	reg |= CON_DMA_MASTER;
+	reg &= ~CON_DMA_MASTER;
+	/* Switch to DMA slave mode when using external DMA */
+	if (!host->use_external_dma)
+		reg |= CON_DMA_MASTER;
+
 	sdhci_omap_writel(omap_host, SDHCI_OMAP_CON, reg);
 
 	return 0;
@@ -1010,6 +1014,7 @@ static int sdhci_omap_probe(struct platform_device *pdev)
 	const struct of_device_id *match;
 	struct sdhci_omap_data *data;
 	const struct soc_device_attribute *soc;
+	struct resource *regs;
 
 	match = of_match_device(omap_sdhci_match, dev);
 	if (!match)
@@ -1022,6 +1027,10 @@ static int sdhci_omap_probe(struct platform_device *pdev)
 	}
 	offset = data->offset;
 
+	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!regs)
+		return -ENXIO;
+
 	host = sdhci_pltfm_init(pdev, &sdhci_omap_pdata,
 				sizeof(*omap_host));
 	if (IS_ERR(host)) {
@@ -1038,6 +1047,7 @@ static int sdhci_omap_probe(struct platform_device *pdev)
 	omap_host->timing = MMC_TIMING_LEGACY;
 	omap_host->flags = data->flags;
 	host->ioaddr += offset;
+	host->mapbase = regs->start + offset;
 
 	mmc = host->mmc;
 	sdhci_get_of_property(pdev);
@@ -1105,6 +1115,10 @@ static int sdhci_omap_probe(struct platform_device *pdev)
 	host->mmc_host_ops.execute_tuning = sdhci_omap_execute_tuning;
 	host->mmc_host_ops.enable_sdio_irq = sdhci_omap_enable_sdio_irq;
 
+	/* Switch to external DMA only if there is the "dmas" property */
+	if (of_find_property(dev->of_node, "dmas", NULL))
+		sdhci_switch_external_dma(host, true);
+
 	ret = sdhci_setup_host(host);
 	if (ret)
 		goto err_put_sync;
-- 
2.19.2

