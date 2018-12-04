Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74073C07E85
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 07:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3678820834
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 07:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="k0TSNWXA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3678820834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbeLDHYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 02:24:49 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43901 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbeLDHYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 02:24:47 -0500
Received: by mail-pg1-f195.google.com with SMTP id v28so6958685pgk.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 23:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9T3V3dRQcYZgkMYQsaWnQOC7H3nxxKjjTTP7EfZrByg=;
        b=k0TSNWXA1pKNHh104J00rWYmpAj4FKrnGnLun6XCF1eOaQatkGs90ue1mlDa2cJyuI
         7dnCnn9jTc8Mnsy1wZ85q3AGOcNUWn9Xo73xywZ8thNVoXqJTFZ8mMw2F5YWQUklAis8
         o6ITSE4VScLdhstGOATI+ozbdwOg72Yfm/7lU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9T3V3dRQcYZgkMYQsaWnQOC7H3nxxKjjTTP7EfZrByg=;
        b=lyJn5weyl1BJNlfzfz4FcBKWCbEB9R9g3toE5XOnUpTor3ZjY0xv7J+cSTDi2CnN7Y
         +OWoJyBWr8s1r8bxy8+FSd2hLQI9SbYekHxobLjojDbuLlSv0EkSYdjo1oE7k6uIJmbA
         kV6noa/N+NfOKX72ds03IAIYDbRnAjQzq6nWcJxLA+fX3jYhlvokPrfAXEu1x2xPP5Gy
         AQw+de2Tnrf/X+LRj32dbg8K1/t7X1SNrBhxvQWJqXaYiMuJCUdv+tvV0kuljU9JX3Yq
         bn+YxcaIpnl/6L5+I2PwOstYjV688607oijOmQVwyxs4GF5wIIKHfs5i6cdL+cAH2ntn
         Z13w==
X-Gm-Message-State: AA+aEWZd2D/XZfsmXWiC2gJ5NqujgXDs7athkjd0EjxmBz3dA/kmGZXx
        QaEqt2kklgoOsQL73Ya9EYNyew==
X-Google-Smtp-Source: AFSGD/XvIC4oM7kvOcorRXOqfINqb7hABgd2hgJpo8IjzByofLxFxgpfu8nCiCNGa7O1cKZGB+dFMQ==
X-Received: by 2002:a63:dd55:: with SMTP id g21mr15647484pgj.86.1543908286818;
        Mon, 03 Dec 2018 23:24:46 -0800 (PST)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id g136sm22705943pfb.154.2018.12.03.23.24.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 03 Dec 2018 23:24:46 -0800 (PST)
From:   Chunyan Zhang <zhang.chunyan@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Faiz Abbas <faiz_abbas@ti.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH V3 2/3] mmc: sdhci-omap: Add using external dma
Date:   Tue,  4 Dec 2018 15:24:29 +0800
Message-Id: <1543908270-13953-3-git-send-email-zhang.chunyan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543908270-13953-1-git-send-email-zhang.chunyan@linaro.org>
References: <1543908270-13953-1-git-send-email-zhang.chunyan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sdhci-omap can support both external dma controller via dmaengine framework
as well as ADMA which standard SD host controller provides.

Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
---
 drivers/mmc/host/Kconfig      |  1 +
 drivers/mmc/host/sdhci-omap.c | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 3101da6..7846754 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -969,6 +969,7 @@ config MMC_SDHCI_XENON
 config MMC_SDHCI_OMAP
 	tristate "TI SDHCI Controller Support"
 	depends on MMC_SDHCI_PLTFM && OF
+	select MMC_SDHCI_EXTERNAL_DMA if DMA_ENGINE
 	help
 	  This selects the Secure Digital Host Controller Interface (SDHCI)
 	  support present in TI's DRA7 SOCs. The controller supports
diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index 88347ce..b164fcc 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -896,6 +896,7 @@ static int sdhci_omap_probe(struct platform_device *pdev)
 	const struct of_device_id *match;
 	struct sdhci_omap_data *data;
 	const struct soc_device_attribute *soc;
+	struct resource *regs;
 
 	match = of_match_device(omap_sdhci_match, dev);
 	if (!match)
@@ -908,6 +909,10 @@ static int sdhci_omap_probe(struct platform_device *pdev)
 	}
 	offset = data->offset;
 
+	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!regs)
+		return -ENXIO;
+
 	host = sdhci_pltfm_init(pdev, &sdhci_omap_pdata,
 				sizeof(*omap_host));
 	if (IS_ERR(host)) {
@@ -924,6 +929,7 @@ static int sdhci_omap_probe(struct platform_device *pdev)
 	omap_host->timing = MMC_TIMING_LEGACY;
 	omap_host->flags = data->flags;
 	host->ioaddr += offset;
+	host->mapbase = regs->start;
 
 	mmc = host->mmc;
 	sdhci_get_of_property(pdev);
@@ -991,6 +997,10 @@ static int sdhci_omap_probe(struct platform_device *pdev)
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
2.7.4

