Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB30C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 07:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 777D0214C5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 07:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ET1fJ3XN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 777D0214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389619AbeHPKwQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 06:52:16 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:41071 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389605AbeHPKwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 06:52:16 -0400
Received: by mail-pl0-f66.google.com with SMTP id w19-v6so1690041ply.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 00:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CShGfILZiCj5oq6dXKbYu8VopCD8AIo780MxeAwT1rs=;
        b=ET1fJ3XNrpoP6VvxveLLPrrofgZYY0LYfb7d89l0/SjPQIAHzRTJf2AhElQBXvTqqt
         myh19JfuCZmQVf9SgtMGzUNsCsPh/oQ+olmfVTylcOGPvKF5p3K6EI+ARGtan0PQISeK
         aVqDJAPPONlHV9TpScmes2BmeTkYBAZGRSF68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CShGfILZiCj5oq6dXKbYu8VopCD8AIo780MxeAwT1rs=;
        b=MRhP7BQVvaOL4ovDqFyR292X9++2GXjW1Jb57XX3ViXV84IG+k3SgTLtY1mHeILtUm
         CutA4mnx+Q3rrvJ2LXCwJquHLDJ3PmxunB71qtri+hEvaq2H6TkY2Mfzrh8EHXt0AvoH
         W2jc5UUT7rtoEQ0ghYaSKKV6j5zf0vZ35ltlpRAIddZC/x7h9840/tnPPmmYh9/uAu2D
         5Aac/XtilzkAm6LrGAYGfBd8fw0NDuGuMSn3OjmOQPMBj70h3SEs8calRmT/g/TlENw9
         7bL4NVcfwe9HWxwxLzNDyhzz8AqFdffq5oZHzmCtY02P/fBm20VobDELyIQOz3EqBBEk
         xJmQ==
X-Gm-Message-State: AOUpUlH6dlVtAsA8Swpi+g5kuQzQu5XnD2ZN/19qzgDiIN7qBbJfjD42
        tRWf5uDBtRTVkKfwfC5oOC8zEA==
X-Google-Smtp-Source: AA+uWPxnkmRKWKG3Z9TqR8yDUp9HXGJsGVq2C8sFgaSD5K+6hQAqbbLFOKOlpDLJZxPge6gX8Y3P/g==
X-Received: by 2002:a17:902:9348:: with SMTP id g8-v6mr27568080plp.302.1534406134469;
        Thu, 16 Aug 2018 00:55:34 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id i25-v6sm50838137pfi.150.2018.08.16.00.55.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 16 Aug 2018 00:55:33 -0700 (PDT)
From:   Chunyan Zhang <zhang.chunyan@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Billows Wu <billows.wu@unisoc.com>,
        Jason Wu <jason.wu@unisoc.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH V5 04/10] mmc: sdhci: Add ADMA2 64-bit addressing support for V4 mode
Date:   Thu, 16 Aug 2018 15:54:18 +0800
Message-Id: <1534406064-10065-5-git-send-email-zhang.chunyan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534406064-10065-1-git-send-email-zhang.chunyan@linaro.org>
References: <1534406064-10065-1-git-send-email-zhang.chunyan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ADMA2 64-bit addressing support is divided into V3 mode and V4 mode.
So there are two kinds of descriptors for ADMA2 64-bit addressing
i.e. 96-bit Descriptor for V3 mode, and 128-bit Descriptor for V4
mode. 128-bit Descriptor is aligned to 8-byte.

For V4 mode, ADMA2 64-bit addressing is enabled via Host Control 2
register.

Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
---
 drivers/mmc/host/sdhci.c | 92 +++++++++++++++++++++++++++++++++++-------------
 drivers/mmc/host/sdhci.h | 12 +++++--
 2 files changed, 78 insertions(+), 26 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 1f0f1e4..1dea1c4 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -266,6 +266,52 @@ static void sdhci_set_default_irqs(struct sdhci_host *host)
 	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE);
 }
 
+static void sdhci_config_dma(struct sdhci_host *host)
+{
+	u8 ctrl;
+	u16 ctrl2;
+
+	if (host->version < SDHCI_SPEC_200)
+		return;
+
+	ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
+
+	/*
+	 * Always adjust the DMA selection as some controllers
+	 * (e.g. JMicron) can't do PIO properly when the selection
+	 * is ADMA.
+	 */
+	ctrl &= ~SDHCI_CTRL_DMA_MASK;
+	if (!(host->flags & SDHCI_REQ_USE_DMA))
+		goto out;
+
+	/* Note if DMA Select is zero then SDMA is selected */
+	if (host->flags & SDHCI_USE_ADMA)
+		ctrl |= SDHCI_CTRL_ADMA32;
+
+	if (host->flags & SDHCI_USE_64_BIT_DMA) {
+		/*
+		 * If v4 mode, all supported DMA can be 64-bit addressing if
+		 * controller supports 64-bit system address, otherwise only
+		 * ADMA can support 64-bit addressing.
+		 */
+		if (host->v4_mode) {
+			ctrl2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+			ctrl2 |= SDHCI_CTRL_64BIT_ADDR;
+			sdhci_writew(host, ctrl2, SDHCI_HOST_CONTROL2);
+		} else if (host->flags & SDHCI_USE_ADMA) {
+			/*
+			 * Don't need to undo SDHCI_CTRL_ADMA32 in order to
+			 * set SDHCI_CTRL_ADMA64.
+			 */
+			ctrl |= SDHCI_CTRL_ADMA64;
+		}
+	}
+
+out:
+	sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
+}
+
 static void sdhci_init(struct sdhci_host *host, int soft)
 {
 	struct mmc_host *mmc = host->mmc;
@@ -913,7 +959,6 @@ static void sdhci_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
 
 static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 {
-	u8 ctrl;
 	struct mmc_data *data = cmd->data;
 
 	host->data_timeout = 0;
@@ -1009,25 +1054,7 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 		}
 	}
 
-	/*
-	 * Always adjust the DMA selection as some controllers
-	 * (e.g. JMicron) can't do PIO properly when the selection
-	 * is ADMA.
-	 */
-	if (host->version >= SDHCI_SPEC_200) {
-		ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
-		ctrl &= ~SDHCI_CTRL_DMA_MASK;
-		if ((host->flags & SDHCI_REQ_USE_DMA) &&
-			(host->flags & SDHCI_USE_ADMA)) {
-			if (host->flags & SDHCI_USE_64_BIT_DMA)
-				ctrl |= SDHCI_CTRL_ADMA64;
-			else
-				ctrl |= SDHCI_CTRL_ADMA32;
-		} else {
-			ctrl |= SDHCI_CTRL_SDMA;
-		}
-		sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
-	}
+	sdhci_config_dma(host);
 
 	if (!(host->flags & SDHCI_REQ_USE_DMA)) {
 		int flags;
@@ -3503,6 +3530,19 @@ static int sdhci_allocate_bounce_buffer(struct sdhci_host *host)
 	return 0;
 }
 
+static inline bool sdhci_can_64bit_dma(struct sdhci_host *host)
+{
+	/*
+	 * According to SD Host Controller spec v4.10, bit[27] added from
+	 * version 4.10 in Capabilities Register is used as 64-bit System
+	 * Address support for V4 mode.
+	 */
+	if (host->version >= SDHCI_SPEC_410 && host->v4_mode)
+		return host->caps & SDHCI_CAN_64BIT_V4;
+
+	return host->caps & SDHCI_CAN_64BIT;
+}
+
 int sdhci_setup_host(struct sdhci_host *host)
 {
 	struct mmc_host *mmc;
@@ -3574,7 +3614,7 @@ int sdhci_setup_host(struct sdhci_host *host)
 	 * SDHCI_QUIRK2_BROKEN_64_BIT_DMA must be left to the drivers to
 	 * implement.
 	 */
-	if (host->caps & SDHCI_CAN_64BIT)
+	if (sdhci_can_64bit_dma(host))
 		host->flags |= SDHCI_USE_64_BIT_DMA;
 
 	if (host->flags & (SDHCI_USE_SDMA | SDHCI_USE_ADMA)) {
@@ -3608,8 +3648,8 @@ int sdhci_setup_host(struct sdhci_host *host)
 		 */
 		if (host->flags & SDHCI_USE_64_BIT_DMA) {
 			host->adma_table_sz = (SDHCI_MAX_SEGS * 2 + 1) *
-					      SDHCI_ADMA2_64_DESC_SZ;
-			host->desc_sz = SDHCI_ADMA2_64_DESC_SZ;
+					      SDHCI_ADMA2_64_DESC_SZ(host);
+			host->desc_sz = SDHCI_ADMA2_64_DESC_SZ(host);
 		} else {
 			host->adma_table_sz = (SDHCI_MAX_SEGS * 2 + 1) *
 					      SDHCI_ADMA2_32_DESC_SZ;
@@ -3617,7 +3657,11 @@ int sdhci_setup_host(struct sdhci_host *host)
 		}
 
 		host->align_buffer_sz = SDHCI_MAX_SEGS * SDHCI_ADMA2_ALIGN;
-		buf = dma_alloc_coherent(mmc_dev(mmc), host->align_buffer_sz +
+		/*
+		 * Use zalloc to zero the reserved high 32-bits of 128-bit
+		 * descriptors so that they never need to be written.
+		 */
+		buf = dma_zalloc_coherent(mmc_dev(mmc), host->align_buffer_sz +
 					 host->adma_table_sz, &dma, GFP_KERNEL);
 		if (!buf) {
 			pr_warn("%s: Unable to allocate ADMA buffers - falling back to standard DMA\n",
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 5042c23..f95eda2 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -185,6 +185,7 @@
 #define  SDHCI_CTRL_EXEC_TUNING		0x0040
 #define  SDHCI_CTRL_TUNED_CLK		0x0080
 #define  SDHCI_CTRL_V4_MODE		0x1000
+#define  SDHCI_CTRL_64BIT_ADDR		0x2000
 #define  SDHCI_CTRL_PRESET_VAL_ENABLE	0x8000
 
 #define SDHCI_CAPABILITIES	0x40
@@ -205,6 +206,7 @@
 #define  SDHCI_CAN_VDD_330	0x01000000
 #define  SDHCI_CAN_VDD_300	0x02000000
 #define  SDHCI_CAN_VDD_180	0x04000000
+#define  SDHCI_CAN_64BIT_V4	0x08000000
 #define  SDHCI_CAN_64BIT	0x10000000
 
 #define  SDHCI_SUPPORT_SDR50	0x00000001
@@ -309,8 +311,14 @@ struct sdhci_adma2_32_desc {
  */
 #define SDHCI_ADMA2_DESC_ALIGN	8
 
-/* ADMA2 64-bit DMA descriptor size */
-#define SDHCI_ADMA2_64_DESC_SZ	12
+/*
+ * ADMA2 64-bit DMA descriptor size
+ * According to SD Host Controller spec v4.10, there are two kinds of
+ * descriptors for 64-bit addressing mode: 96-bit Descriptor and 128-bit
+ * Descriptor, if Host Version 4 Enable is set in the Host Control 2
+ * register, 128-bit Descriptor will be selected.
+ */
+#define SDHCI_ADMA2_64_DESC_SZ(host)	((host)->v4_mode ? 16 : 12)
 
 /*
  * ADMA2 64-bit descriptor. Note 12-byte descriptor can't always be 8-byte
-- 
2.7.4

