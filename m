Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBEF3C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 08:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 834072082B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 08:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jon+xq5T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 834072082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbeH3MXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 08:23:09 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34037 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728007AbeH3MXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 08:23:09 -0400
Received: by mail-pg1-f194.google.com with SMTP id d19-v6so3573822pgv.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 01:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wj6LwXf/jUT8nmKoqSVJBo3vcF/egS7nUByoGr88L4Q=;
        b=jon+xq5Tky6PYU/p0fvDZeq0yrKRr3lHslFiLxKk450BYuaRzVEsYsxXsAsYXegIG5
         8Kmzr+9KpbIYCYhKyFpVSoniiB021+DE5InFWFWTz0N7ZqWdy6Xbch6prxLHJM86+3ZS
         z0KfP3QTQSkvbD8m2VW7QwF8dd3dJm48hmAfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wj6LwXf/jUT8nmKoqSVJBo3vcF/egS7nUByoGr88L4Q=;
        b=bkcNfbExZVbwzepXt3OW3CLqYnTyEwchBsh2JOIhEbGAymaSaWrzvwNAvWwuw5EfCP
         elkjYuOzRdbY9qnoeUHp5tsn2GFh94lBQX3fqqET+kPHnXkvmBJVk4wnhmQaMkrvzJii
         E+b/IG5VL6tjZeh6KuAimqocye/6KkQ4tQlPFjC8vFl6u6iLEJiHUniReDWNC+OKjRah
         A1bMVpvPNuwMuaM+uycbAkw3wN/k3Q9hdonZL2XPSHieg2dbpdHZTe+o6KJhOkvIwTrI
         gx+rZ05d0VDSfoF9MZyXKgTocWTit9ktjfvQr3T0/MxJ+Yuqg10hpjFoEy46XuHbwkPN
         uWeA==
X-Gm-Message-State: APzg51CJ7StVMDarRCO5vqF0yfu7cy4+FavjniDoPLTX7ghsmUxu6aL0
        wKCQHRb1yyb7TIGQDt/Y4E+aDw==
X-Google-Smtp-Source: ANB0Vdb2ZOJXye9JpAFNod3ghvGg3x4jXQkbwc2ngjsgtzUxaxYfacWmcHRNZ/hqEhndvAOswqMK/A==
X-Received: by 2002:a65:650f:: with SMTP id x15-v6mr8942680pgv.127.1535617330612;
        Thu, 30 Aug 2018 01:22:10 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id j22-v6sm8224885pfh.45.2018.08.30.01.22.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 30 Aug 2018 01:22:09 -0700 (PDT)
From:   Chunyan Zhang <zhang.chunyan@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Billows Wu <billows.wu@unisoc.com>,
        Jason Wu <jason.wu@unisoc.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH V8 3/9] mmc: sdhci: Change SDMA address register for v4 mode
Date:   Thu, 30 Aug 2018 16:21:39 +0800
Message-Id: <1535617305-16952-4-git-send-email-zhang.chunyan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535617305-16952-1-git-send-email-zhang.chunyan@linaro.org>
References: <1535617305-16952-1-git-send-email-zhang.chunyan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the SD host controller specification version 4.10, when
Host Version 4 is enabled, SDMA uses ADMA System Address register
(05Fh-058h) instead of using SDMA System Address register to
support both 32-bit and 64-bit addressing.

Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 0c61105..6fb70da 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -727,7 +727,7 @@ static void sdhci_adma_table_post(struct sdhci_host *host,
 	}
 }
 
-static u32 sdhci_sdma_address(struct sdhci_host *host)
+static dma_addr_t sdhci_sdma_address(struct sdhci_host *host)
 {
 	if (host->bounce_buffer)
 		return host->bounce_addr;
@@ -735,6 +735,17 @@ static u32 sdhci_sdma_address(struct sdhci_host *host)
 		return sg_dma_address(host->data->sg);
 }
 
+static void sdhci_set_sdma_addr(struct sdhci_host *host, dma_addr_t addr)
+{
+	if (host->v4_mode) {
+		sdhci_writel(host, addr, SDHCI_ADMA_ADDRESS);
+		if (host->flags & SDHCI_USE_64_BIT_DMA)
+			sdhci_writel(host, (u64)addr >> 32, SDHCI_ADMA_ADDRESS_HI);
+	} else {
+		sdhci_writel(host, addr, SDHCI_DMA_ADDRESS);
+	}
+}
+
 static unsigned int sdhci_target_timeout(struct sdhci_host *host,
 					 struct mmc_command *cmd,
 					 struct mmc_data *data)
@@ -994,8 +1005,7 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 					     SDHCI_ADMA_ADDRESS_HI);
 		} else {
 			WARN_ON(sg_cnt != 1);
-			sdhci_writel(host, sdhci_sdma_address(host),
-				     SDHCI_DMA_ADDRESS);
+			sdhci_set_sdma_addr(host, sdhci_sdma_address(host));
 		}
 	}
 
@@ -2830,7 +2840,7 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
 		 * some controllers are faulty, don't trust them.
 		 */
 		if (intmask & SDHCI_INT_DMA_END) {
-			u32 dmastart, dmanow;
+			dma_addr_t dmastart, dmanow;
 
 			dmastart = sdhci_sdma_address(host);
 			dmanow = dmastart + host->data->bytes_xfered;
@@ -2838,12 +2848,12 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
 			 * Force update to the next DMA block boundary.
 			 */
 			dmanow = (dmanow &
-				~(SDHCI_DEFAULT_BOUNDARY_SIZE - 1)) +
+				~((dma_addr_t)SDHCI_DEFAULT_BOUNDARY_SIZE - 1)) +
 				SDHCI_DEFAULT_BOUNDARY_SIZE;
 			host->data->bytes_xfered = dmanow - dmastart;
-			DBG("DMA base 0x%08x, transferred 0x%06x bytes, next 0x%08x\n",
-			    dmastart, host->data->bytes_xfered, dmanow);
-			sdhci_writel(host, dmanow, SDHCI_DMA_ADDRESS);
+			DBG("DMA base %pad, transferred 0x%06x bytes, next %pad\n",
+			    &dmastart, host->data->bytes_xfered, &dmanow);
+			sdhci_set_sdma_addr(host, dmanow);
 		}
 
 		if (intmask & SDHCI_INT_DATA_END) {
@@ -3590,8 +3600,8 @@ int sdhci_setup_host(struct sdhci_host *host)
 		}
 	}
 
-	/* SDMA does not support 64-bit DMA */
-	if (host->flags & SDHCI_USE_64_BIT_DMA)
+	/* SDMA does not support 64-bit DMA if v4 mode not set */
+	if ((host->flags & SDHCI_USE_64_BIT_DMA) && !host->v4_mode)
 		host->flags &= ~SDHCI_USE_SDMA;
 
 	if (host->flags & SDHCI_USE_ADMA) {
-- 
2.7.4

