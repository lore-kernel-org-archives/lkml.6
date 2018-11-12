Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B572EC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 07:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E9C021722
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 07:27:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IIygXA0t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E9C021722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbeKLRS4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 12:18:56 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40786 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbeKLRS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 12:18:56 -0500
Received: by mail-pg1-f195.google.com with SMTP id z10so3655717pgp.7
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 23:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=n0shTLWVLOWZOTUoAQC89gB739nczZpYRMifTlqhkHs=;
        b=IIygXA0tF9qJAE2izQ37wk1wcPh87EQXM16RBKrjk9N+p1Mw5MDagA9ZZeN6jARZuj
         GzQJjqynG15eJ+1gkowjAU9KlzV4lkekuHnfcEnPLhrzxANGyG7+cmpQsGvmCMxFmEEQ
         fMqE+T6xEHykx96tzZqb5T8FwB6zp2W8KE3k4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=n0shTLWVLOWZOTUoAQC89gB739nczZpYRMifTlqhkHs=;
        b=Ug4b2xBnc7SNo1LXMJMO3aQBp8QE4MK/zoCj28iSnpRDTxinmidA0bNd5cLFGau1FM
         BZtdsyZtfwgK+or4ifcupzBnrXLwlisWgy8RWwX077U0uxFL6WBskD2GtzwtvuXXHzUq
         ZrClUkCdZY/Cay1DcixXS2uVW1kcJ2F3XX919rbqFcCXdS0Mw637jSWI1WE3axcFfIj4
         H3w6N7H4NjxITZ6qJIdnmRyYMsaQOct5uR6ioLscV5Uslq+mMs6B3+0gH61aXQg90bhn
         biGuaZeS0bFHMu2Qwg07vwKrLgdRHgPjapydY77Rl9F9+94ASw1dK09LseANvErheCL5
         on5Q==
X-Gm-Message-State: AGRZ1gLCq2j2Ca1QqI8jpI+DAss1INl0LF0pS8gJb/NTzYK5uG8PWa24
        0gpR6lfnfmgjOMga5vk7WXQyoQ==
X-Google-Smtp-Source: AJdET5eg18xihxCao0FKTiZg3r7SGN5HBBMcqQahCcy5YQadayTS+gwPfp6XeDwllpjLwtyfT/u7cQ==
X-Received: by 2002:a62:b802:: with SMTP id p2-v6mr18830394pfe.1.1542007617556;
        Sun, 11 Nov 2018 23:26:57 -0800 (PST)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id w2-v6sm18668331pfn.89.2018.11.11.23.26.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 11 Nov 2018 23:26:56 -0800 (PST)
From:   Chunyan Zhang <zhang.chunyan@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH v2 2/3] mmc: sdhci-omap: Add using external dma
Date:   Mon, 12 Nov 2018 15:26:05 +0800
Message-Id: <1542007566-9449-3-git-send-email-zhang.chunyan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542007566-9449-1-git-send-email-zhang.chunyan@linaro.org>
References: <1542007566-9449-1-git-send-email-zhang.chunyan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sdhci-omap can support both external dma controller via dmaengine framework
as well as ADMA which standard SD host controller provides.

Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
---
 drivers/mmc/host/sdhci-omap.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index 88347ce..ccc79f2 100644
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
@@ -991,6 +997,7 @@ static int sdhci_omap_probe(struct platform_device *pdev)
 	host->mmc_host_ops.execute_tuning = sdhci_omap_execute_tuning;
 	host->mmc_host_ops.enable_sdio_irq = sdhci_omap_enable_sdio_irq;
 
+	sdhci_switch_external_dma(host, true);
 	ret = sdhci_setup_host(host);
 	if (ret)
 		goto err_put_sync;
-- 
2.7.4

