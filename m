Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9823DC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 508AA2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:03:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZgS7aX3G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 508AA2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727749AbeH2K7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 06:59:01 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43704 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727172AbeH2K7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 06:59:01 -0400
Received: by mail-pl1-f195.google.com with SMTP id x6-v6so1879566plv.10
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 00:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gVnMBXKc4i1JKgy6ffbRwQOZ0ThpKQAJZ1YKfPm++hw=;
        b=ZgS7aX3Gd161MtYIFxe4+J6bndokBsbo5aXCfXNj3pxipKi+TVYcErEWiGn27HJGHL
         UWVYIe2mMiv4As65G44FqFrne5ummVTBxIV0F+IQ0LUUVXUVOi6kTX0Bpo8aLatbXUaY
         f526m9PouwRhPGgltyy115t1Q9tRqkrsiwdBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gVnMBXKc4i1JKgy6ffbRwQOZ0ThpKQAJZ1YKfPm++hw=;
        b=GBp2yYC3/JAlJLzo4JiLPI3jKi72BTetCrzDSAwlMVXZCldwpBDTS9EIB6PZVb1qw/
         L32VbbWdYIUqJ+/sHV4RxZjhd3yHHw6URAYEEEvl6gWpYK9DhIeYeCABXHZrrpsjIiSo
         olU8G8josTreLXrSih38G2mD968fbKwfI4pLLet2/30sUxrgM8LHUXHknCjN/uubbneu
         AItThwx+wG1H9F50m3h6TsyjHmn6AOZkdJUsGPjBdcq9t4DjE6aVHEsMxqc7xgUDV0m/
         0KarsPecuHMvBZMpwq55SwpKidYFd/fEP6vx8YYnemDC01KON2asKpW1dvfWIUNCVk6W
         0gdw==
X-Gm-Message-State: APzg51Atbx+SK/rMTxMeuvT9Ci5w4WYdH1zyN+doLh/7WkoG4kiZxlrR
        jUDzRGF2k5AVzoMjod+0FZLAIg==
X-Google-Smtp-Source: ANB0VdYbGWA74Z8v2IKITWrbHgu4J5amSQZUqvpBvoSQL5Yg9YyRcsKJaX+vwYhSI7PJ7kURqFcV7g==
X-Received: by 2002:a17:902:850c:: with SMTP id bj12-v6mr4823484plb.330.1535526216022;
        Wed, 29 Aug 2018 00:03:36 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id d81-v6sm4317342pfj.122.2018.08.29.00.03.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 Aug 2018 00:03:35 -0700 (PDT)
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
Subject: [PATCH V7 5/9] mmc: sdhci: Add 32-bit block count support for v4 mode
Date:   Wed, 29 Aug 2018 15:03:00 +0800
Message-Id: <1535526184-32718-6-git-send-email-zhang.chunyan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535526184-32718-1-git-send-email-zhang.chunyan@linaro.org>
References: <1535526184-32718-1-git-send-email-zhang.chunyan@linaro.org>
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
 drivers/mmc/host/sdhci.c | 14 +++++++++++++-
 drivers/mmc/host/sdhci.h |  8 ++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 17345b6..604bf4c 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1073,7 +1073,19 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 	/* Set the DMA boundary value and block size */
 	sdhci_writew(host, SDHCI_MAKE_BLKSZ(host->sdma_boundary, data->blksz),
 		     SDHCI_BLOCK_SIZE);
-	sdhci_writew(host, data->blocks, SDHCI_BLOCK_COUNT);
+
+	/*
+	 * For Version 4.10 onwards, if v4 mode is enabled, 32-bit Block Count
+	 * can be supported, in that case 16-bit block count register must be 0.
+	 */
+	if (host->version >= SDHCI_SPEC_410 && host->v4_mode &&
+	    (host->quirks2 & SDHCI_QUIRK2_USE_32BIT_BLK_CNT)) {
+		if (sdhci_readw(host, SDHCI_BLOCK_COUNT))
+			sdhci_writew(host, 0, SDHCI_BLOCK_COUNT);
+		sdhci_writew(host, data->blocks, SDHCI_32BIT_BLK_CNT);
+	} else {
+		sdhci_writew(host, data->blocks, SDHCI_BLOCK_COUNT);
+	}
 }
 
 static inline bool sdhci_auto_cmd12(struct sdhci_host *host,
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index c5cc513..f7a1079 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -28,6 +28,7 @@
 
 #define SDHCI_DMA_ADDRESS	0x00
 #define SDHCI_ARGUMENT2		SDHCI_DMA_ADDRESS
+#define SDHCI_32BIT_BLK_CNT	SDHCI_DMA_ADDRESS
 
 #define SDHCI_BLOCK_SIZE	0x04
 #define  SDHCI_MAKE_BLKSZ(dma, blksz) (((dma & 0x7) << 12) | (blksz & 0xFFF))
@@ -462,6 +463,13 @@ struct sdhci_host {
  * obtainable timeout.
  */
 #define SDHCI_QUIRK2_DISABLE_HW_TIMEOUT			(1<<17)
+/*
+ * 32-bit block count may not support eMMC where upper bits of CMD23 are used
+ * for other purposes.  Consequently we support 16-bit block count by default.
+ * Otherwise, SDHCI_QUIRK2_USE_32BIT_BLK_CNT can be selected to use 32-bit
+ * block count.
+ */
+#define SDHCI_QUIRK2_USE_32BIT_BLK_CNT			(1<<18)
 
 	int irq;		/* Device IRQ */
 	void __iomem *ioaddr;	/* Mapped address */
-- 
2.7.4

