Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE63C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 09:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4787821710
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 09:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HW/zP1Vd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4787821710
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbeHXMzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 08:55:25 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45313 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727019AbeHXMzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 08:55:24 -0400
Received: by mail-pf1-f195.google.com with SMTP id i26-v6so4256766pfo.12
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 02:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=j9zEFOBvZaYd5PykWUcd1ipE5wmyuWnJ3HC4tyHGzkY=;
        b=HW/zP1VdMj6MBoVw9xKNI+nYNP6zvNBrt/Vw3LvtzXSqatWycimbp72OPeXOFS4OQf
         B7iupeF9wdC8ma3S1haLL8zfWMEnZi+98UArQ9dCEhykz01n2tZqWn+tAPNNVH2HFgo5
         TrvbK8ZPKliceAL/OkIIe45679yCiHpweGAIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=j9zEFOBvZaYd5PykWUcd1ipE5wmyuWnJ3HC4tyHGzkY=;
        b=pf90GkovYUnO4+YtwqXey/6CQw6ErccWhpeP5r7mwWMZvXLiXnlelw05u4BtzlUJ6A
         GpmJL99bZiHYIPLmwR5RlHFJDZ5Njhb9WknsK2OChL2VHnycDYi1CS7eWSL6QAfmJF9I
         VoKDHLqBQ6MtJUbXwZ8cbrq1bjOOhIKarZZ+9B7v1+WHEN2p6Xn/4RCi1xJYQAWZdWl2
         1c3kOPIBXEAwHO6K+G5OJC7SSqNoUhNrJkV6AknfRCPSVT43f6Pgx+QPVVolbyjqdBjo
         xg7OTbVqPZW8rb39qD/Zc1KlyoOQX/JbAX/DKqe9dir01uh/UKS6NpXnq+dr0GDlcx1a
         vQ0A==
X-Gm-Message-State: APzg51AvXr/oc0cjkzQPQr+zJqUMmxDkz0hvd44oVnAQ4MTmWrZmjAdu
        TG00a4TCJTCSGuaZiHt6oIoifw==
X-Google-Smtp-Source: ANB0VdYbOndXYMFBINDItUnJ4xlUWggl799BKeZ5OUXQdm+CpeP6E1hYtHzDgXAeu9Me5BhHWmkmPA==
X-Received: by 2002:a65:6086:: with SMTP id t6-v6mr900441pgu.424.1535102498729;
        Fri, 24 Aug 2018 02:21:38 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id g6-v6sm9520314pfb.11.2018.08.24.02.21.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 24 Aug 2018 02:21:37 -0700 (PDT)
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
Subject: [PATCH V6 5/9] mmc: sdhci: Add 32-bit block count support for v4 mode
Date:   Fri, 24 Aug 2018 17:20:24 +0800
Message-Id: <1535102428-20332-6-git-send-email-zhang.chunyan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535102428-20332-1-git-send-email-zhang.chunyan@linaro.org>
References: <1535102428-20332-1-git-send-email-zhang.chunyan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Host Controller Version 4.10 re-defines SDMA System Address register
as 32-bit Block Count for v4 mode, and SDMA uses ADMA System
Address register (05Fh-058h) instead if v4 mode is enabled. Also
when using 32-bit block count, 16-bit block count register need
to be set to zero.

Since using 32-bit Block Count would cause problems for auto-cmd23,
it can be chosen via host->quirk2.

Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
---
 drivers/mmc/host/sdhci.c | 15 ++++++++++++++-
 drivers/mmc/host/sdhci.h |  3 +++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 38d083c..05f9fff 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1073,7 +1073,20 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
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
+	if (host->version >= SDHCI_SPEC_410 && host->v4_mode &&
+	    !(host->quirks2 & SDHCI_QUIRK2_BROKEN_32BIT_BLK_CNT)) {
+		if (sdhci_readw(host, SDHCI_BLOCK_COUNT))
+			sdhci_writew(host, 0, SDHCI_BLOCK_COUNT);
+		sdhci_writew(host, data->blocks, SDHCI_32BIT_BLK_CNT);
+	} else {
+		sdhci_writew(host, data->blocks, SDHCI_BLOCK_COUNT);
+	}
 }
 
 static inline bool sdhci_auto_cmd12(struct sdhci_host *host,
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index f3b9ebc..0a1e25f 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -28,6 +28,7 @@
 
 #define SDHCI_DMA_ADDRESS	0x00
 #define SDHCI_ARGUMENT2		SDHCI_DMA_ADDRESS
+#define SDHCI_32BIT_BLK_CNT	SDHCI_DMA_ADDRESS
 
 #define SDHCI_BLOCK_SIZE	0x04
 #define  SDHCI_MAKE_BLKSZ(dma, blksz) (((dma & 0x7) << 12) | (blksz & 0xFFF))
@@ -462,6 +463,8 @@ struct sdhci_host {
  * obtainable timeout.
  */
 #define SDHCI_QUIRK2_DISABLE_HW_TIMEOUT			(1<<17)
+/* Controller broken with using 32-bit block count in v4_mode */
+#define SDHCI_QUIRK2_BROKEN_32BIT_BLK_CNT		(1<<18)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
-- 
2.7.4

