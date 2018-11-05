Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E36ECDE44
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 03:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A9202082A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 03:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="B3ljs4mc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A9202082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729173AbeKEMeg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 07:34:36 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44849 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728283AbeKEMeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 07:34:36 -0500
Received: by mail-pl1-f194.google.com with SMTP id s5-v6so3699933plq.11
        for <linux-kernel@vger.kernel.org>; Sun, 04 Nov 2018 19:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yzwsoUSsA6n9GhAeRE9xmA2fjMci+vdbes/fUzU0UCs=;
        b=B3ljs4mch/YbPLxq6teeIIcfZpElrfsxLw96UNC8Yrr6yFsKCFzHANFw3fbsTCePIL
         b+KJCbQP5bUz2g2FCwCZH4NEHBujljf+5K4QpWA2ZHbCkBlm5YOisk/aS18LTOBveBjx
         f2sKFWhhmk/Xak51D5W4rG43ao222Mi59km9k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yzwsoUSsA6n9GhAeRE9xmA2fjMci+vdbes/fUzU0UCs=;
        b=fEcPe9CSYw1UC+umrgoTsUweadpBOXnSRpTc6/oyGNAt/9glZBY2/ZSNAx3AvRUETQ
         e6f63h4z12nW2jXPbnU/yzUxV6ZK3czLKvvJTFsubu1vybXXuzlRzDptBucmsor92YFO
         N7RdHnfEeLg4YnPkAw//+d0/HNnTc9zjtPpTWYhXjncAu3PLM4QVJ4pZS3fS81+UkaK3
         CU7vuX859x6kFfRUfbldVL/FZiVlngw/M6bgYcgXXopVOETqTIWzNQrtxaJr586Dhkyg
         c+cqED8Cugw3IiXzx+Y6gVWIPigckBq88Bgxx60D2C5IVUXgX2wi4YOG4v+dzCq97qus
         msiQ==
X-Gm-Message-State: AGRZ1gLgqm/nZzIwonbNnFXRBQEko8/P2JNC3LUOuVSKyFvZ6XQIu7Qz
        X5sXqVkI+dIbMefBILpuRztJEg==
X-Google-Smtp-Source: AJdET5cCA6lFFFVVmeBKuzXK1pCh33eOYofvuGw1nvLRkCowWy+vaMHTge+68zOWD2uvl0vqA4El3w==
X-Received: by 2002:a17:902:8d94:: with SMTP id v20-v6mr20757455plo.109.1541387827813;
        Sun, 04 Nov 2018 19:17:07 -0800 (PST)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id f10-v6sm40182773pgp.72.2018.11.04.19.17.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 04 Nov 2018 19:17:06 -0800 (PST)
From:   Chunyan Zhang <zhang.chunyan@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH RFC 2/3] mmc: sdhci-omap: Add using external dma
Date:   Mon,  5 Nov 2018 11:16:49 +0800
Message-Id: <1541387810-24867-3-git-send-email-zhang.chunyan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541387810-24867-1-git-send-email-zhang.chunyan@linaro.org>
References: <1541387810-24867-1-git-send-email-zhang.chunyan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sdhci-omap can support both external dma controllers via dmaengine
framework as well as ADMA in which the controller acts as DMA master.

Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
---
 drivers/mmc/host/sdhci-omap.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index 88347ce..0a8162c 100644
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
 
+	sdhci_switch_extdma(host, true);
 	ret = sdhci_setup_host(host);
 	if (ret)
 		goto err_put_sync;
-- 
2.7.4

