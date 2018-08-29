Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 187C2C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B44452086B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:03:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iGDms1bG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B44452086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbeH2K64 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 06:58:56 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36420 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbeH2K64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 06:58:56 -0400
Received: by mail-pl1-f196.google.com with SMTP id e11-v6so1897217plb.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 00:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=c/eV9ZN7dNN0gTb1HotdKJUB+PKAX41PZSlC9GVsCR4=;
        b=iGDms1bGEXHVyC9Lz1Sq6+1gpZzMe7gRddF7OC5SiZxFn0I6odf01I53tcgHGUoYAr
         FGCEIHaBbBx9WvaAmiDSZAh2yA0gcHdq1kxOcPhvLEIcWgbJpXVxj0CbJ+SQpvnhUZMR
         h14i/JmOVODpA7RWBlp8Br/W1vdl635OZ/Cag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=c/eV9ZN7dNN0gTb1HotdKJUB+PKAX41PZSlC9GVsCR4=;
        b=cj4kB5CAEB5FTcVZI39HyJOXyJd0VH+FBR78jPmUz4OIKcT5UKi6VxL+6nuNjkcdkZ
         K7+hIPsitcpwGmMuFCGVouM2aj+0yMQMR0aRjLBhrFkIrakCKqWXrU+FycVpmWTH1MTt
         8nZXTt8j5pSIiZT1VdmtRqbivVipTVOttgWOvyZdgcUvZq1LJSDzsgohiAsYi+uo0Igz
         NETFJs2wKQurjIrX5nQNDLj6dt3sXOm1l9kh61g6lCaDiCDQn9Obb369QBSIFyZ3m27r
         U02T/B2ppuKnfLdByGJJRahPDgAREyX+OX2RuFdo9wXszjtoKZRLVc3l8BOC+xHyIJAp
         xYZg==
X-Gm-Message-State: APzg51BrAyb+aLsIIly50Prpc+GiAu+fbxlwy1Zq6OLB+1UoC7RPm6SC
        ojn/wml8XzO898k8nx1Pa76Z+g==
X-Google-Smtp-Source: ANB0VdayDGUFWhXeMt02HOw11tTEfYXRYVUB4L8wBliJJchqIa9Vk1vFs2miREtzhYeMNl+dvnp5/A==
X-Received: by 2002:a17:902:4401:: with SMTP id k1-v6mr4562523pld.97.1535526210900;
        Wed, 29 Aug 2018 00:03:30 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id d81-v6sm4317342pfj.122.2018.08.29.00.03.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 Aug 2018 00:03:30 -0700 (PDT)
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
Subject: [PATCH V7 4/9] mmc: sdhci: Add ADMA2 64-bit addressing support for V4 mode
Date:   Wed, 29 Aug 2018 15:02:59 +0800
Message-Id: <1535526184-32718-5-git-send-email-zhang.chunyan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535526184-32718-1-git-send-email-zhang.chunyan@linaro.org>
References: <1535526184-32718-1-git-send-email-zhang.chunyan@linaro.org>
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
index 6fb70da..17345b6 100644
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
@@ -3511,6 +3538,19 @@ static int sdhci_allocate_bounce_buffer(struct sdhci_host *host)
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
@@ -3582,7 +3622,7 @@ int sdhci_setup_host(struct sdhci_host *host)
 	 * SDHCI_QUIRK2_BROKEN_64_BIT_DMA must be left to the drivers to
 	 * implement.
 	 */
-	if (host->caps & SDHCI_CAN_64BIT)
+	if (sdhci_can_64bit_dma(host))
 		host->flags |= SDHCI_USE_64_BIT_DMA;
 
 	if (host->flags & (SDHCI_USE_SDMA | SDHCI_USE_ADMA)) {
@@ -3616,8 +3656,8 @@ int sdhci_setup_host(struct sdhci_host *host)
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
@@ -3625,7 +3665,11 @@ int sdhci_setup_host(struct sdhci_host *host)
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
index 61611e3..c5cc513 100644
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

