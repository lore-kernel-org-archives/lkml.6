Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F9C6C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 08:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41BDD206B5
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 08:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xcn/jYWX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41BDD206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbeJXQ2n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 12:28:43 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35970 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726964AbeJXQ2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 12:28:42 -0400
Received: by mail-pl1-f194.google.com with SMTP id y11-v6so1889742plt.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 01:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=LU33Gsa2HCKv9HOvNZu+bYf6MApf/+vgJR72mmhToLI=;
        b=Xcn/jYWXh81tB7zFOyRmQkfxygest239hGEdHnATb5SOizedBC5t28MrgBM+OvJ2LY
         V9xSr96BjCgJZFKKEMP/E1u0oZ6mFhoP5Rc6zvVtVdP1WFf+FTXNTjSQ/iywaOyM2SMD
         G/+CfIc8BZE06H0e11kDQ0o44c8oskH79sHGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LU33Gsa2HCKv9HOvNZu+bYf6MApf/+vgJR72mmhToLI=;
        b=kCtpkWPd+sv9sgBpshjlwXb00xvolKVEPkSkewutF4kD0UjRiao2Ddu8jBQ0Pb0yWn
         fg/9RlO0+KHkPgdVMed7PCrZyNmxtXpxj5j3Irbpzn8w0/2A0q5O4VJPieZQEOdWf1up
         furGYpVn7WsJ3mNPZPX21EVhyjje0mfqEP2HqmaPvSBbwI77jZly+wV4FzNfCHLo7wjY
         3ihce7KLjgsQ7bPe+kRqr/P/r/Q25aDrf6/ofMgS9GOxkshftS1K/c+K7ulanHzHxhrK
         SSpaqSO82YcpXWCOcQLUhHPKSegHLaFObrLfCT7A97NJ4CqWcfGGp+1L+bh4X2r9HzgR
         UDzg==
X-Gm-Message-State: AGRZ1gKHLcyNnsXWEDTvBitrbJP1E8kCFl+Xpah6GQpCYa2tTlw8mDZb
        EZsYqIxyVtfebhpT4+mLvmuHag==
X-Google-Smtp-Source: AJdET5eWg+JGFllyer/VRZzTkHRck+UOgANGR+FdeV2oSWN9KhcIjdIoWhfQfEJHCfNULczATbqASg==
X-Received: by 2002:a17:902:bf44:: with SMTP id u4-v6mr1591650pls.48.1540368101663;
        Wed, 24 Oct 2018 01:01:41 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id d2-v6sm4299086pfn.118.2018.10.24.01.01.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 24 Oct 2018 01:01:40 -0700 (PDT)
From:   Chunyan Zhang <zhang.chunyan@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH] mmc: sdhci: Convert sdhci_allocate_bounce_buffer() to return void
Date:   Wed, 24 Oct 2018 16:01:24 +0800
Message-Id: <1540368084-32202-1-git-send-email-zhang.chunyan@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function sdhci_allocate_bounce_buffer() always return zero at
present, so there's no need to have a return value, that will also make
error path easier.

CC: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
---
 drivers/mmc/host/sdhci.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 1b3fbd9..e94f4aa 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3408,7 +3408,7 @@ void __sdhci_read_caps(struct sdhci_host *host, u16 *ver, u32 *caps, u32 *caps1)
 }
 EXPORT_SYMBOL_GPL(__sdhci_read_caps);
 
-static int sdhci_allocate_bounce_buffer(struct sdhci_host *host)
+static void sdhci_allocate_bounce_buffer(struct sdhci_host *host)
 {
 	struct mmc_host *mmc = host->mmc;
 	unsigned int max_blocks;
@@ -3446,7 +3446,7 @@ static int sdhci_allocate_bounce_buffer(struct sdhci_host *host)
 		 * Exiting with zero here makes sure we proceed with
 		 * mmc->max_segs == 1.
 		 */
-		return 0;
+		return;
 	}
 
 	host->bounce_addr = dma_map_single(mmc->parent,
@@ -3456,7 +3456,7 @@ static int sdhci_allocate_bounce_buffer(struct sdhci_host *host)
 	ret = dma_mapping_error(mmc->parent, host->bounce_addr);
 	if (ret)
 		/* Again fall back to max_segs == 1 */
-		return 0;
+		return;
 	host->bounce_buffer_size = bounce_size;
 
 	/* Lie about this since we're bouncing */
@@ -3466,8 +3466,6 @@ static int sdhci_allocate_bounce_buffer(struct sdhci_host *host)
 
 	pr_info("%s bounce up to %u segments into one, max segment size %u bytes\n",
 		mmc_hostname(mmc), max_blocks, bounce_size);
-
-	return 0;
 }
 
 int sdhci_setup_host(struct sdhci_host *host)
@@ -3987,12 +3985,9 @@ int sdhci_setup_host(struct sdhci_host *host)
 	 */
 	mmc->max_blk_count = (host->quirks & SDHCI_QUIRK_NO_MULTIBLOCK) ? 1 : 65535;
 
-	if (mmc->max_segs == 1) {
+	if (mmc->max_segs == 1)
 		/* This may alter mmc->*_blk_* parameters */
-		ret = sdhci_allocate_bounce_buffer(host);
-		if (ret)
-			return ret;
-	}
+		sdhci_allocate_bounce_buffer(host);
 
 	return 0;
 
-- 
2.7.4

