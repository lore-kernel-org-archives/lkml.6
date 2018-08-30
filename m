Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1497EC433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 08:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B78052082B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 08:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="erG8ml1N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B78052082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728046AbeH3MXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 08:23:14 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36379 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728007AbeH3MXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 08:23:13 -0400
Received: by mail-pf1-f195.google.com with SMTP id b11-v6so3565200pfo.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 01:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=A+NKJyWIAuCP+cRhS5RHzcAWBSzMQjHaPTkiXZajSsU=;
        b=erG8ml1NfIFcTgKHagMT8IlB29/NqmBs6Xh7xejZyUwmUNZZhjol5DTtWSITl3pg+l
         IojgaAK8HwnpleXeh+W9mDZGfejysoCKQ6FBNCHjN4b2EX/k7uhO/0lGdD+iAQGVZVSG
         ytg3G9encNge1RDO5hLFf148r8z0cbEWKKiZo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=A+NKJyWIAuCP+cRhS5RHzcAWBSzMQjHaPTkiXZajSsU=;
        b=T/JuqbKgEScc8AOkOKuXfyJgkzMkaaf9AAr+iVyevc82s3MInU8PK2gq202oKBw+eI
         oOccBcUjyYUJS2SWFQSCZBiQOHCmtIdT2XJagjSstS/L1WAPt9SOj2oR7PWvup2Tifbn
         BI4cfKXXOI2NhmJSkR1UG0Jl3f3oXOR+85Ho1eMkDkaEyMTTm2mo+M9otyLa7PFyDGTr
         08GuiY1avQDrPhFinjcmiqb5VvQkpvBeNTNQB7FCT+RPsDZhHzbkQ52gm8jUiC3rx6b9
         Ggy0k+sSFMpcLvCrZZec5ZpgrCEA9uHmawTm10sZMcKwtb2dvl3A6yR2HfyDXPEHHVxC
         JV6Q==
X-Gm-Message-State: APzg51CYnn3WJOpINnNNMfTVX83kOPFjvwC07LdZuZ86VkmJ4WvZ11dB
        qEp4BMyHmDRLfX2F7NKQzUMOug==
X-Google-Smtp-Source: ANB0VdZN4JCuQRXZP8yBNBXzsrDbU5oYlhGatjODxRQ7LJa9KBQhyWe0suwzYya4X5nTqe9z1XD2EA==
X-Received: by 2002:a63:6183:: with SMTP id v125-v6mr8964116pgb.242.1535617335287;
        Thu, 30 Aug 2018 01:22:15 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id j22-v6sm8224885pfh.45.2018.08.30.01.22.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 30 Aug 2018 01:22:14 -0700 (PDT)
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
Subject: [PATCH V8 4/9] mmc: sdhci: Add ADMA2 64-bit addressing support for V4 mode
Date:   Thu, 30 Aug 2018 16:21:40 +0800
Message-Id: <1535617305-16952-5-git-send-email-zhang.chunyan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535617305-16952-1-git-send-email-zhang.chunyan@linaro.org>
References: <1535617305-16952-1-git-send-email-zhang.chunyan@linaro.org>
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
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
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

