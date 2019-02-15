Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 615A2C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3356F222D0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RZ8RBfje"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388217AbfBOTR5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 14:17:57 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:47158 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733289AbfBOTRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 14:17:54 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1FJHmlQ130918;
        Fri, 15 Feb 2019 13:17:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1550258268;
        bh=cVPL4EPCxVAoyNM/VAl32mgqPwnZGwN/+OPZ2kzGYpg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=RZ8RBfjeisGK9x0Q74k3I7IOqcVV7B78wrv5th3Ap1Z4xpLY95L5TctFm7TePJ22S
         3aLolHDgmImTuDL/gsbezlPO77yGKO2XWr6XUcOe5WezOf3WYD5ZAv7CIqfikKouBE
         qAUpOUnxrseNUJ1kQVShUXVMopAvu7HGlMLOVNQA=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1FJHmWc049261
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 15 Feb 2019 13:17:48 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 15
 Feb 2019 13:17:48 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 15 Feb 2019 13:17:48 -0600
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1FJHV10025256;
        Fri, 15 Feb 2019 13:17:45 -0600
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, <linux-omap@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <adrian.hunter@intel.com>, <kishon@ti.com>,
        <zhang.chunyan@linaro.org>, <faiz_abbas@ti.com>
Subject: [PATCH v2 4/8] mmc: sdhci-omap: Add using external dma
Date:   Sat, 16 Feb 2019 00:50:29 +0530
Message-ID: <20190215192033.24203-5-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190215192033.24203-1-faiz_abbas@ti.com>
References: <20190215192033.24203-1-faiz_abbas@ti.com>
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
index f3b442528ed8..5d1189478ee0 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -979,6 +979,7 @@ config MMC_SDHCI_OMAP
 	depends on MMC_SDHCI_PLTFM && OF
 	select THERMAL
 	imply TI_SOC_THERMAL
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

