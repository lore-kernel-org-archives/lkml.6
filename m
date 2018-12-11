Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F2FFC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:13:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 173E52082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:13:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="XuWfY9of"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 173E52082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbeLKJNR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 04:13:17 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:38301 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbeLKJNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 04:13:16 -0500
Received: by mail-pl1-f195.google.com with SMTP id e5so6643305plb.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Dec 2018 01:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9T3V3dRQcYZgkMYQsaWnQOC7H3nxxKjjTTP7EfZrByg=;
        b=XuWfY9ofLnr1STsykVT2f6eoB2JkAl3ZNwoIe+pEZ2xUaxDnRITERShTW48YrcWbhu
         MALOzWEJ1SpurS7tWGY0NtsM3SaK+2fDYu+fHGMjSPWH0doI2Smz00HcP+GWEkE1UhsC
         ls348AN7v11cGn4OLeT4dVsNwQFjW1m8O8EHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9T3V3dRQcYZgkMYQsaWnQOC7H3nxxKjjTTP7EfZrByg=;
        b=c00fGcJRTG7FJfU0rptOe6RvZJpR1LKXxqiLTjW5LsWwPcv5RPulOGV7SdtgpQAfEI
         O9G34K+5taUuCjHK5AgiFtaQHd2SUDzrHJAz6tcDVAvPwR2vr/0qWt6nekH9mAwHK100
         8+9sKY51KEMLLQjSvvniMLCQCMlQbjAxGyxi03S+/dOhmt2LV9vva1bkt92RUS497Bde
         M/d0CLNVrnAwOxlSWsFzJVwnV/xjjw/k6JAc0Iyj9pWP5iZIjanJitmhac48YjaZsFp1
         5YtbJTQQCrsXo85eg/2iSH6fCEO4r+HHphjfo0805nwTd3WBvUDyBVKLKxAOdcezmzFY
         gfDQ==
X-Gm-Message-State: AA+aEWbVoJWe7Ereg5nPQV+QRyb9xCpM61CnA6sx9zlzeaMp+n/6q7XH
        dX2xARVsF9FBX3M5fRcc7Hxs9A==
X-Google-Smtp-Source: AFSGD/Xt2RiuiE19qFTL3hwLlWn7LjvZj1X1wRWH5EaJH11V5Ar4ZmDEKfJms96yL6Por5X9gepWqA==
X-Received: by 2002:a17:902:50e3:: with SMTP id c32mr15506965plj.318.1544519595136;
        Tue, 11 Dec 2018 01:13:15 -0800 (PST)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id a90sm27202214pfj.109.2018.12.11.01.13.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 11 Dec 2018 01:13:14 -0800 (PST)
From:   Chunyan Zhang <zhang.chunyan@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Faiz Abbas <faiz_abbas@ti.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH V4 2/3] mmc: sdhci-omap: Add using external dma
Date:   Tue, 11 Dec 2018 17:12:51 +0800
Message-Id: <1544519572-21921-3-git-send-email-zhang.chunyan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544519572-21921-1-git-send-email-zhang.chunyan@linaro.org>
References: <1544519572-21921-1-git-send-email-zhang.chunyan@linaro.org>
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

