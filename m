Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F9D0C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 07:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F5F2214C5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 07:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="D2gkwNP2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F5F2214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389603AbeHPKwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 06:52:11 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34661 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389589AbeHPKwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 06:52:11 -0400
Received: by mail-pf1-f196.google.com with SMTP id k19-v6so1661889pfi.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 00:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oQ908iqEE1J6YcVEb5PbZH8Isswa4HYhkkDHD7JZWDk=;
        b=D2gkwNP27FNp+EIKCqhP6epjkXpR5xzFg9eMhHtCo4XC8wZnYznPqLr5aLbF1vvd6t
         M0Y5Dq3TzQhV2E7PbI2DrDwUZVC2fAgyuQklN5swoPKW0hKTWeo+mK6Bz7yB9d2eN+Sl
         c7d/hBaFOdlaskHAglMaZQwS8T46GtUmZ4La4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oQ908iqEE1J6YcVEb5PbZH8Isswa4HYhkkDHD7JZWDk=;
        b=JpiqX0a6BTReEKSaYdAw6AW9pzLnwTSm0fWHOuwaSFST6QoQZ8sLA9Wf652sEJTBpY
         vsS7Inq8+U9yX7DuejIbmBZ6+AxzHGQePhHaDXkXttvFwAbmNTqjRXgCuGdXu8PVCU2J
         CHIE3dhId9c8yYc7BdeVkStl09qIfuzRGIX/UUGVw3NxlMcsT9PEtPxmZje5EqbnHGi0
         bxx/KiORYAz0BYD/S1HSCxFRmHC5wUtuW7SmWP315xYqTPv2cJks2UYzf1QX6jv3JLla
         0Gbw/1CqOiuKkxUBfCNP9e+1Ig+mdLKj0SxUrHRvH9AUiPgZ/8vRRDKI8oE9+50gZ4z9
         ZkmQ==
X-Gm-Message-State: AOUpUlGe2tPwl3lSTJNxysMkXEDDxwUpehk99bSrIDn0VdevjeF+mJyc
        vwBEp6nAN33Yw+NXQNJq+YaTaA==
X-Google-Smtp-Source: AA+uWPzd0JTDB3u1jNacsKiM3A7xZwm8IioTkLNlUxbh37xDwPLbPJheYAxAHTOftbRvyMZEZ+r4FA==
X-Received: by 2002:a65:5288:: with SMTP id y8-v6mr4307694pgp.284.1534406129869;
        Thu, 16 Aug 2018 00:55:29 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id i25-v6sm50838137pfi.150.2018.08.16.00.55.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 16 Aug 2018 00:55:28 -0700 (PDT)
From:   Chunyan Zhang <zhang.chunyan@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Billows Wu <billows.wu@unisoc.com>,
        Jason Wu <jason.wu@unisoc.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH V5 03/10] mmc: sdhci: Change SDMA address register for v4 mode
Date:   Thu, 16 Aug 2018 15:54:17 +0800
Message-Id: <1534406064-10065-4-git-send-email-zhang.chunyan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534406064-10065-1-git-send-email-zhang.chunyan@linaro.org>
References: <1534406064-10065-1-git-send-email-zhang.chunyan@linaro.org>
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
index d808a1f..1f0f1e4 100644
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
 
@@ -2822,7 +2832,7 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
 		 * some controllers are faulty, don't trust them.
 		 */
 		if (intmask & SDHCI_INT_DMA_END) {
-			u32 dmastart, dmanow;
+			dma_addr_t dmastart, dmanow;
 
 			dmastart = sdhci_sdma_address(host);
 			dmanow = dmastart + host->data->bytes_xfered;
@@ -2830,12 +2840,12 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
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
@@ -3582,8 +3592,8 @@ int sdhci_setup_host(struct sdhci_host *host)
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

