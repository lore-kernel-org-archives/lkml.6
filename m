Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1690ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 02:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5034C20831
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 02:13:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sz9GRZx/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5034C20831
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbeJYKn1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 06:43:27 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43502 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbeJYKn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 06:43:26 -0400
Received: by mail-pg1-f193.google.com with SMTP id n10-v6so2509209pgv.10
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 19:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LU33Gsa2HCKv9HOvNZu+bYf6MApf/+vgJR72mmhToLI=;
        b=Sz9GRZx/Z3W1V9DG8tnhf1G3va/hoZE4OzcWh0q2cIGBJ7IEycmiIrXPXwnDNDYZbm
         p6v0IT1Qg+oq3ski7EE/oAK6GWBRlHT4kpoh3WSPxXG3XxToQzZ7HMr/60F976U1gxel
         n8PfrBaPC72Ye5aNbW3BPh5j6yKMbxRc3emA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LU33Gsa2HCKv9HOvNZu+bYf6MApf/+vgJR72mmhToLI=;
        b=PGbuRC/YZdvF4mDJSUGNln1V1LREd9hmq1r51gcEuVL0zsNsMFLL6w7fdusp7OjBz1
         9B0YwlcuPfjFQ3qa2UIyEoA8UacG+S80PU7HdO7AzjRadX5kBcygoWtq349x5z20eguZ
         OZBpZKF2r0ZkDTwSjKQxHwxHM8wY5BxDauWzY95cUA+CKgzmihA6ZH5k1+1RvZyFmKf6
         L3fs/9wkl92Eg6wgJ9XaUbaRxuNAUdtuL1+wG+ASc/G978N2kG0didCdH9fTmnZ2PORO
         o5co+ENgT0yJmEz9lj5Sn0MA7yZzV1uQZPCXp2ktnB8M9SMosliI7kIlUOXo8941p5vH
         dm3A==
X-Gm-Message-State: AGRZ1gJUSy7wXgTFBdS+f4wWNaYfyUoOQEAExLxxke/VryWnOdpKwU13
        Hdd5WaRHD78f+g3mM4g+fo88WA==
X-Google-Smtp-Source: AJdET5fy1SO4iwXT2/6T/z6PXWU9JeKdSa9PSzxHQxP1p30/5bXUXykRSim6QCpWQT7MeqoABqK0hg==
X-Received: by 2002:a63:a612:: with SMTP id t18-v6mr4752671pge.338.1540433570183;
        Wed, 24 Oct 2018 19:12:50 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id i5-v6sm6661824pgs.10.2018.10.24.19.12.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 24 Oct 2018 19:12:49 -0700 (PDT)
From:   Chunyan Zhang <zhang.chunyan@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH] mmc: sdhci: Convert sdhci_allocate_bounce_buffer() to return void
Date:   Thu, 25 Oct 2018 10:12:36 +0800
Message-Id: <1540433556-12261-1-git-send-email-zhang.chunyan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1540368084-32202-1-git-send-email-zhang.chunyan@linaro.org>
References: <1540368084-32202-1-git-send-email-zhang.chunyan@linaro.org>
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

