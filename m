Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C397C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 09:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33EE320676
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 09:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TE1oNf5h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33EE320676
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbeHXMzU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 08:55:20 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33820 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbeHXMzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 08:55:19 -0400
Received: by mail-pg1-f194.google.com with SMTP id u10-v6so2320444pgr.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 02:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V5KxzKbPEKh15VckZhi+wrWCuks4RPVSThG8QwbL0Z8=;
        b=TE1oNf5hN18R8DBmmI2wVeB1mB7plVYjeYeFN2BImp3b2ZMEGYjuZBTaXoxKaQaPHv
         3JuUqWALeppdZ5MNaB+TsWGz/gQV8w0oH5eOmC1kPQ57c68+uCUXoWey/KPlnhHJyGA4
         LpuWF/2NPyRO4w6PWfWweE0eObmZdh7o+y+so=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V5KxzKbPEKh15VckZhi+wrWCuks4RPVSThG8QwbL0Z8=;
        b=Db5uwDfDbAqtLDcQl8cKde+NbKfMeW4WccStR3n3KqdldasJUH3LHgtxs2Zkz1r13H
         sp6FCNgE7fZPy2FMutfgwvcB+8A2ZRLga+oRg5DUUfj+pfoEq58iVGKh1E01p8coz0LS
         vpG0cEpE3EtKpURITDhlxTbS4PonK9kUrWqbz7QFGcKc4zOIK6uJVH3K7fmTnJJVSCZk
         Y3mk4TUl3l0Fuvfqyg0L3zU+kIt6FG+QDp1srSqS7uvHoBdRT/ulX+DP8MfItG4qyfmZ
         CwvJ828aUoNg84yxxqe601LRUe13VBhyJ8UL+jY3+x/BdGYED8EnpdpciBOXnAgn3YAg
         6fsA==
X-Gm-Message-State: APzg51C65H1BKCwcz+BZgnNMUzWR3VUykdtjJ5o8NtqtENULR8XpEJXu
        PSw6fXFhrEeQvOC4mhzKwi5EGA==
X-Google-Smtp-Source: ANB0VdZ49uxTiwGT9G7UZr2TDV6ZsVA0hb0PvEul1UFojpdmg2G+QgZoMblGQNtg7ZjU1R5nzPh3Dg==
X-Received: by 2002:a63:4104:: with SMTP id o4-v6mr905316pga.146.1535102493307;
        Fri, 24 Aug 2018 02:21:33 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id g6-v6sm9520314pfb.11.2018.08.24.02.21.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 24 Aug 2018 02:21:32 -0700 (PDT)
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
Subject: [PATCH V6 4/9] mmc: sdhci: Add ADMA2 64-bit addressing support for V4 mode
Date:   Fri, 24 Aug 2018 17:20:23 +0800
Message-Id: <1535102428-20332-5-git-send-email-zhang.chunyan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535102428-20332-1-git-send-email-zhang.chunyan@linaro.org>
References: <1535102428-20332-1-git-send-email-zhang.chunyan@linaro.org>
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
index df283ca..38d083c 100644
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
@@ -3504,6 +3531,19 @@ static int sdhci_allocate_bounce_buffer(struct sdhci_host *host)
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
@@ -3575,7 +3615,7 @@ int sdhci_setup_host(struct sdhci_host *host)
 	 * SDHCI_QUIRK2_BROKEN_64_BIT_DMA must be left to the drivers to
 	 * implement.
 	 */
-	if (host->caps & SDHCI_CAN_64BIT)
+	if (sdhci_can_64bit_dma(host))
 		host->flags |= SDHCI_USE_64_BIT_DMA;
 
 	if (host->flags & (SDHCI_USE_SDMA | SDHCI_USE_ADMA)) {
@@ -3609,8 +3649,8 @@ int sdhci_setup_host(struct sdhci_host *host)
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
@@ -3618,7 +3658,11 @@ int sdhci_setup_host(struct sdhci_host *host)
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
index 131d869..f3b9ebc 100644
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

