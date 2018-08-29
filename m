Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5FE1C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C2592086B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bnWksmN6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C2592086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbeH2K6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 06:58:52 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37629 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbeH2K6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 06:58:51 -0400
Received: by mail-pg1-f196.google.com with SMTP id 2-v6so1392731pgo.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 00:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BASbtQme+9NYFc4kTckiwE+4eWZRxL4aqBbLe9Llj1Q=;
        b=bnWksmN6GQj35dKzO4xh6PQHDeTHjXqRX/50rR0UJsPqMDLeO6PJ8Y3I8b484TM3i9
         /oobJYzs2wrpgQl+XdL82G6I4HKhf2nhTwYEWtMza29xB7v54kMbwGUmLwG6+mCQ6X3d
         +JrJD3xSTr9McuDvh6oHF8wdznp0iTc7o0zuc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BASbtQme+9NYFc4kTckiwE+4eWZRxL4aqBbLe9Llj1Q=;
        b=jR7X5rwg+St9IYIEgLGEessXhq7pWxUr8GQ6eQOgazF/BX5vi8LWlig4f7DggzNv1u
         /Alu6amAlutVzz6koMCaQGFeYeGVRljkOgD9dPWPzHPPfo5usVlFYd/TFIR1zIgxddE0
         sxpKwiBvwJGQk/D68rnckHR0ncr6BEGfs3xQPTdAOpKSiBNksdVBHNvkGdCDS5UsNLrR
         rpR3+voiG5ONUvXtnQjRJygqDZv1PyQRFR46R5/C1unzUGCB+9jKtm1wU+fP52C+EnD9
         DLXH92pm4SEBlkKIy0syOonEi9e0y89AjFcxdXy9AqUoJuUwnRh135SC3wqMabAmvYNf
         Qxhw==
X-Gm-Message-State: APzg51BxQAhTNnSrfdw81Kxaimz8DyXg86dz/IHIRwibK/SsSkUi5Gkt
        fHndfPjjeGZjEgnIFXKLvhDZPbxCFwQ=
X-Google-Smtp-Source: ANB0VdapLOnzBLMKH/431ZdVn3ej3fh6U0Bxr9zGARMNkcigjM9RmytYnb5hwkCqRcIfCdHZbcECXQ==
X-Received: by 2002:a63:444d:: with SMTP id t13-v6mr4541487pgk.102.1535526206262;
        Wed, 29 Aug 2018 00:03:26 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id d81-v6sm4317342pfj.122.2018.08.29.00.03.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 Aug 2018 00:03:25 -0700 (PDT)
From:   Chunyan Zhang <zhang.chunyan@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Billows Wu <billows.wu@unisoc.com>,
        Jason Wu <jason.wu@unisoc.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH V7 3/9] mmc: sdhci: Change SDMA address register for v4 mode
Date:   Wed, 29 Aug 2018 15:02:58 +0800
Message-Id: <1535526184-32718-4-git-send-email-zhang.chunyan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535526184-32718-1-git-send-email-zhang.chunyan@linaro.org>
References: <1535526184-32718-1-git-send-email-zhang.chunyan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the SD host controller specification version 4.10, when
Host Version 4 is enabled, SDMA uses ADMA System Address register
(05Fh-058h) instead of using SDMA System Address register to
support both 32-bit and 64-bit addressing.

Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
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

