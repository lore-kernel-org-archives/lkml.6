Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04FEFC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 07:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE5A6214C5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 07:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kBJ4VkwC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE5A6214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389636AbeHPKwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 06:52:21 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36315 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389621AbeHPKwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 06:52:20 -0400
Received: by mail-pg1-f194.google.com with SMTP id h12-v6so1693612pgs.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 00:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tfDeQ46/C06dDmQGL2FRTZ/CLblF/VG3NSDxyH8wH4w=;
        b=kBJ4VkwC9a9Fbirw66Hnp5sdsmCCI8q0uYUhXaBz6N7sE/jng7Q+QbtCGZzCCHbqR6
         yCdkD7I0t2B3TkhuYvCfqu0Vz+RZKwo8GIxZk7IIRzt1xu3nY95aYKrQk9ZoeAjsKJdG
         gGILVBBogtccB3JDBgR6S1crxtgk79kenIIHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tfDeQ46/C06dDmQGL2FRTZ/CLblF/VG3NSDxyH8wH4w=;
        b=oPu/jxs9ZfOXlYHtx41DqcfbZwstfc5QLousjZ1F+72IYRmTWZ5ncp2jjaG9Q+3i7i
         +P9ed7YCKLYZ3WtXLtGhUyRlMjMpqYP5DTlxBwtwjPHmMVcZ7Knoysb3QvFq6EzSgcWy
         giPnQ/ofk0A1HyJailODDlNddOntIcAZzOzv+nxQawaDRVmHv/jVloTOYBOz/dG+Cs+H
         Q9Aplnhq2xkvlNPuT0vnHetylsO42kzLEJhGdzxtmXF5doP5Fbu0mF3fUa7adVZJt5qb
         OGjXJ0oQiIxB+iq6dGBUN9Ic9ulszJ/vyWQnTgGDMFR/3G1W0tb88vW08F2LKzmAk41k
         l7cA==
X-Gm-Message-State: AOUpUlFAsgXKlnq5ibsNkWQEHK8gpQD2yAM+UCFRsn/yLQbQRFV+ZDky
        Ket5DQHkxcRpBLb4WRCnzuJabA==
X-Google-Smtp-Source: AA+uWPzg7XELkEZ389CWyO/8KUv4FEn13Z5vDDhFooYS78lvERTjk0sHnpp8pvkOV0lKJr+Z9BhPoA==
X-Received: by 2002:a63:5a5e:: with SMTP id k30-v6mr28479313pgm.123.1534406138967;
        Thu, 16 Aug 2018 00:55:38 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id i25-v6sm50838137pfi.150.2018.08.16.00.55.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 16 Aug 2018 00:55:38 -0700 (PDT)
From:   Chunyan Zhang <zhang.chunyan@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Billows Wu <billows.wu@unisoc.com>,
        Jason Wu <jason.wu@unisoc.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH V5 05/10] mmc: sdhci: Add 32-bit block count support for v4 mode
Date:   Thu, 16 Aug 2018 15:54:19 +0800
Message-Id: <1534406064-10065-6-git-send-email-zhang.chunyan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534406064-10065-1-git-send-email-zhang.chunyan@linaro.org>
References: <1534406064-10065-1-git-send-email-zhang.chunyan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Host Controller Version 4.10 re-defines SDMA System Address register
as 32-bit Block Count for v4 mode, and SDMA uses ADMA System
Address register (05Fh-058h) instead if v4 mode is enabled. Also
when using 32-bit block count, 16-bit block count register need
to be set to zero.

Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
---
 drivers/mmc/host/sdhci.c | 14 +++++++++++++-
 drivers/mmc/host/sdhci.h |  1 +
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 1dea1c4..b3328ee 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1073,7 +1073,19 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 	/* Set the DMA boundary value and block size */
 	sdhci_writew(host, SDHCI_MAKE_BLKSZ(host->sdma_boundary, data->blksz),
 		     SDHCI_BLOCK_SIZE);
-	sdhci_writew(host, data->blocks, SDHCI_BLOCK_COUNT);
+
+	/*
+	 * For Version 4.10 onwards, if v4 mode is enabled, 16-bit Block Count
+	 * register need to be set to zero, 32-bit Block Count register would
+	 * be selected.
+	 */
+	if (host->version >= SDHCI_SPEC_410 && host->v4_mode) {
+		if (sdhci_readw(host, SDHCI_BLOCK_COUNT))
+			sdhci_writew(host, 0, SDHCI_BLOCK_COUNT);
+		sdhci_writew(host, data->blocks, SDHCI_32BIT_BLK_CNT);
+	} else {
+		sdhci_writew(host, data->blocks, SDHCI_BLOCK_COUNT);
+	}
 }
 
 static inline bool sdhci_auto_cmd12(struct sdhci_host *host,
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index f95eda2..d34971ac 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -28,6 +28,7 @@
 
 #define SDHCI_DMA_ADDRESS	0x00
 #define SDHCI_ARGUMENT2		SDHCI_DMA_ADDRESS
+#define SDHCI_32BIT_BLK_CNT	SDHCI_DMA_ADDRESS
 
 #define SDHCI_BLOCK_SIZE	0x04
 #define  SDHCI_MAKE_BLKSZ(dma, blksz) (((dma & 0x7) << 12) | (blksz & 0xFFF))
-- 
2.7.4

