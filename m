Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DFF9C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 03:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2802208DB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 03:21:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OUnNmxnd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2802208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933432AbeGIDVi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 23:21:38 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:46130 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933267AbeGIDVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 23:21:35 -0400
Received: by mail-pf0-f193.google.com with SMTP id l123-v6so12582854pfl.13
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jul 2018 20:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fRGwE55C+87JEZEZfreG1eB0oRkGj0Cu0G2/o3bFsd8=;
        b=OUnNmxnd90/PL36RCvFkWozRxm7UTfigLaMXM3FirfZ7oOT3/eHLbSW6cX9XvGiyaf
         WkExAtzjRHJJmvefN0ZP3mzEagykZlarSt7j6/svK4Whf10OLQVfImXnG3/vTpgyFYIw
         CvZfsbG/JVMyAc0D7iowiyu33sDetSIom+PSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fRGwE55C+87JEZEZfreG1eB0oRkGj0Cu0G2/o3bFsd8=;
        b=e113JePKwDyJsbU1r2Eqz5QvKWtOib/IEbUVHe+Er+lpMZm/ubNrVshu8NrmFYlwe1
         ATRoKECjetR2Uo+uzmPkbpxnssDmLlLosYziAdJLNq0quQtdudtpzNXZG4/9cMlvT09p
         iR8LAIN8MG1ryJwDF+LXfK7OYM1drAsAZYRmAKul0uAAPcJEDUSFvjc+PJ53hBjW4kz5
         DhsVbSlAm3uuAKJCfU3BxG0UIGMYrEQuyfZdh88buFY308FBS2Q/Ffu2cav9G16Qggwf
         ZOr1okqyCNKBia+0qykMtRHsUuh2AuvId0Eb/luSa3Krn8PzFtUBD+IIrVOaUAyMO0P1
         ez0g==
X-Gm-Message-State: APt69E3J08zqjHyoerk8O73LKHkGsD9J3UyB8Wn5eQRDoLmqJZ64JGJJ
        IyjXxmZ6BKVqDNyaDdEndr1jdw==
X-Google-Smtp-Source: AAOMgpcPpHPN08eCwjv2XWZfcVYoXa6jiCLOPcoFX56eKwmAlTPglLBKF1sHHoibiIOsT8aRl7/SIg==
X-Received: by 2002:a62:2c46:: with SMTP id s67-v6mr19152809pfs.153.1531106495238;
        Sun, 08 Jul 2018 20:21:35 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id e82-v6sm41458950pfk.87.2018.07.08.20.21.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 08 Jul 2018 20:21:34 -0700 (PDT)
From:   Chunyan Zhang <zhang.chunyan@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Billows Wu <billows.wu@spreadtrum.com>, zhang.lyra@gmail.com
Subject: [PATCH V3 3/7] mmc: sdhci: add ADMA2 64-bit addressing support for V4 mode
Date:   Mon,  9 Jul 2018 11:19:54 +0800
Message-Id: <1531106398-14062-4-git-send-email-zhang.chunyan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531106398-14062-1-git-send-email-zhang.chunyan@linaro.org>
References: <1531106398-14062-1-git-send-email-zhang.chunyan@linaro.org>
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
 drivers/mmc/host/sdhci.c | 28 ++++++++++++++++++++++++----
 drivers/mmc/host/sdhci.h | 14 ++++++++++++--
 2 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index c7de6a5..7871ae2 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3486,6 +3486,26 @@ static int sdhci_allocate_bounce_buffer(struct sdhci_host *host)
 	return 0;
 }
 
+static inline bool sdhci_use_64bit_dma(struct sdhci_host *host)
+{
+	u32 addr64bit_en;
+
+	/*
+	 * According to SD Host Controller spec v4.10, bit[27] added from
+	 * version 4.10 in Capabilities Register is used as 64-bit System
+	 * Address support for V4 mode, 64-bit DMA Addressing for V4 mode
+	 * is enabled only if 64-bit Addressing =1 in the Host Control 2
+	 * register.
+	 */
+	if (host->version == SDHCI_SPEC_410 && host->v4_mode) {
+		addr64bit_en = (sdhci_readw(host, SDHCI_HOST_CONTROL2) &
+				SDHCI_CTRL_64BIT_ADDR);
+		return addr64bit_en && (host->caps & SDHCI_CAN_64BIT_V4);
+	}
+
+	return host->caps & SDHCI_CAN_64BIT;
+}
+
 int sdhci_setup_host(struct sdhci_host *host)
 {
 	struct mmc_host *mmc;
@@ -3557,7 +3577,7 @@ int sdhci_setup_host(struct sdhci_host *host)
 	 * SDHCI_QUIRK2_BROKEN_64_BIT_DMA must be left to the drivers to
 	 * implement.
 	 */
-	if (host->caps & SDHCI_CAN_64BIT)
+	if (sdhci_use_64bit_dma(host))
 		host->flags |= SDHCI_USE_64_BIT_DMA;
 
 	if (host->flags & (SDHCI_USE_SDMA | SDHCI_USE_ADMA)) {
@@ -3591,8 +3611,8 @@ int sdhci_setup_host(struct sdhci_host *host)
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
@@ -3600,7 +3620,7 @@ int sdhci_setup_host(struct sdhci_host *host)
 		}
 
 		host->align_buffer_sz = SDHCI_MAX_SEGS * SDHCI_ADMA2_ALIGN;
-		buf = dma_alloc_coherent(mmc_dev(mmc), host->align_buffer_sz +
+		buf = dma_zalloc_coherent(mmc_dev(mmc), host->align_buffer_sz +
 					 host->adma_table_sz, &dma, GFP_KERNEL);
 		if (!buf) {
 			pr_warn("%s: Unable to allocate ADMA buffers - falling back to standard DMA\n",
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index e98249b..24fa58a 100644
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
@@ -271,6 +273,8 @@
 #define   SDHCI_SPEC_100	0
 #define   SDHCI_SPEC_200	1
 #define   SDHCI_SPEC_300	2
+#define   SDHCI_SPEC_400	3
+#define   SDHCI_SPEC_410	4
 
 /*
  * End of controller registers.
@@ -306,8 +310,14 @@ struct sdhci_adma2_32_desc {
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

