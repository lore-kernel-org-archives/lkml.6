Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 753F3C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 03:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F972208DB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 03:21:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NCwRjkju"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F972208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933336AbeGIDV2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 23:21:28 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:38468 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933267AbeGIDVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 23:21:25 -0400
Received: by mail-pl0-f66.google.com with SMTP id b1-v6so5344465pls.5
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jul 2018 20:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U2m4J5ZcFgcmYhx2M7R/05FBJ9kdju3nRv1lZnT2H/c=;
        b=NCwRjkjuDvXljol15IfJUAYGd5eP9IJLE6Xn4+R69HtiXMl/QbUfPKwKM8VIwBIU1c
         +fsRR91DTxuWi6ibW2lki58VeGggjf6JFsg7s8F1EauwYSlc1DPLYjyhjDQBZDFEM04G
         jnZ5IcWqgPgQhvZ9KGyi6pVsmhnkAoH/cXKD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=U2m4J5ZcFgcmYhx2M7R/05FBJ9kdju3nRv1lZnT2H/c=;
        b=j+JOS/iwJ6YOi22zMOfXmuTNIImxCC7ro5xTD024SSNqkSj8zyA0Gepns/U4YyI66h
         OqEkU8wIdmwi77hsJmsJ0An6Miwnx1V1WCfB3Ge5awl5rwR3NATBScHWkzCqKE/2AEnz
         G8ryEg6hCIq+Wxy5EIDVAwy/6Z0yMQ1+bZSCILRsgcwAoP+EDJByDB8xeg/6kvIqGr2S
         dr44d7RkFFthX30WYZKIIjY6DgM8f2cKYzVaqBTO3KtMBDLO3xz8XdfW+LUm8/75NF60
         FkImDAd/3wtA7jVMhSFPdjWiDpWkeUNuoRO+YPkEwq3LN5AM4Sq6LRalj6JK15U7T0qv
         9a3w==
X-Gm-Message-State: APt69E2BGUyL5ACtHNrHuLAsQ+PxQTrf4PBRvVkv4rBA2wweOa5EnSds
        EwuelA0h+uDKpuZN3I5lKqapXw==
X-Google-Smtp-Source: AAOMgpdpa0/5yv7Ppo6UOgIVbH93llnXvE33iSzIgDfY409kvtwHrADgrqcXHR9a4dGkleW8y1xDGA==
X-Received: by 2002:a17:902:7782:: with SMTP id o2-v6mr18925446pll.93.1531106485077;
        Sun, 08 Jul 2018 20:21:25 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id e82-v6sm41458950pfk.87.2018.07.08.20.21.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 08 Jul 2018 20:21:24 -0700 (PDT)
From:   Chunyan Zhang <zhang.chunyan@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Billows Wu <billows.wu@spreadtrum.com>, zhang.lyra@gmail.com
Subject: [PATCH V3 2/7] mmc: sdhci: made changes for System Address register of SDMA
Date:   Mon,  9 Jul 2018 11:19:53 +0800
Message-Id: <1531106398-14062-3-git-send-email-zhang.chunyan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531106398-14062-1-git-send-email-zhang.chunyan@linaro.org>
References: <1531106398-14062-1-git-send-email-zhang.chunyan@linaro.org>
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
 drivers/mmc/host/sdhci.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 525862f..c7de6a5 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -701,7 +701,7 @@ static void sdhci_adma_table_post(struct sdhci_host *host,
 	}
 }
 
-static u32 sdhci_sdma_address(struct sdhci_host *host)
+static dma_addr_t sdhci_sdma_address(struct sdhci_host *host)
 {
 	if (host->bounce_buffer)
 		return host->bounce_addr;
@@ -709,6 +709,18 @@ static u32 sdhci_sdma_address(struct sdhci_host *host)
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
+
+}
+
 static unsigned int sdhci_target_timeout(struct sdhci_host *host,
 					 struct mmc_command *cmd,
 					 struct mmc_data *data)
@@ -968,8 +980,7 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 					     SDHCI_ADMA_ADDRESS_HI);
 		} else {
 			WARN_ON(sg_cnt != 1);
-			sdhci_writel(host, sdhci_sdma_address(host),
-				     SDHCI_DMA_ADDRESS);
+			sdhci_set_sdma_addr(host, sdhci_sdma_address(host));
 		}
 	}
 
@@ -2796,7 +2807,7 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
 		 * some controllers are faulty, don't trust them.
 		 */
 		if (intmask & SDHCI_INT_DMA_END) {
-			u32 dmastart, dmanow;
+			dma_addr_t dmastart, dmanow;
 
 			dmastart = sdhci_sdma_address(host);
 			dmanow = dmastart + host->data->bytes_xfered;
@@ -2807,9 +2818,9 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
 				~(SDHCI_DEFAULT_BOUNDARY_SIZE - 1)) +
 				SDHCI_DEFAULT_BOUNDARY_SIZE;
 			host->data->bytes_xfered = dmanow - dmastart;
-			DBG("DMA base 0x%08x, transferred 0x%06x bytes, next 0x%08x\n",
-			    dmastart, host->data->bytes_xfered, dmanow);
-			sdhci_writel(host, dmanow, SDHCI_DMA_ADDRESS);
+			DBG("DMA base 0x%016llx, transferred 0x%06x bytes, next 0x%016llx\n",
+			    (u64)dmastart, host->data->bytes_xfered, (u64)dmanow);
+			sdhci_set_sdma_addr(host, dmanow);
 		}
 
 		if (intmask & SDHCI_INT_DATA_END) {
-- 
2.7.4

