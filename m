Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 98946C5CFC0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 02:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F3F320891
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 02:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="X42FyhXC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F3F320891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965486AbeFOCFM (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 22:05:12 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:44143 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965432AbeFOCFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 22:05:08 -0400
Received: by mail-pl0-f65.google.com with SMTP id z9-v6so4524854plk.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 19:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2kKdK2qZqm7YxqxQreraVLLw0s8TN4UgsB3k/YpdPQI=;
        b=X42FyhXCSenAv4Ga0WliOss8Cl4vi1DAOFgbG7LsvEkAlK+cozcgvYSxeKDBsForin
         n/y8/QlrCYewK5IuFj+O1Cq0LtADv76oEypKgWDIi6R1+WiSf2WPenAvItnsQ/Gpqweg
         m0nCrcwHPSKyp7nwaNgHYIfjmTmpw0qmJdoto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2kKdK2qZqm7YxqxQreraVLLw0s8TN4UgsB3k/YpdPQI=;
        b=ZzAks3tduzQPoI44czszOdHGTJK+6OExGns3FbsuK+T4bM5w24OXIZIjiXeIyt8Jxc
         4Fs4S9NA1/x9WXNlykGBOGqULysmUckn5oF/X7pa8rskMplg6u8M4JbWJ238u04Ju7P2
         F75GRkyGeq94oy5Agl3Ttfv2dVvXVqnSZQw5WPBOd9obCETluGEkYX1CQrc+aqyWG/Fl
         dYxtM2nSih0JnbpVfVgSjms1KfDVfcV39cEUb6dqQhjTBN7Dk9v+B1Wm8KfQNg4J0zNZ
         jp6gY/0ccf3ebTT26y/aVKHjybHubUQl9Seqz9+H4w++WHPH30i2oCzIRtUk4z4vdgC5
         kNAQ==
X-Gm-Message-State: APt69E3RbrK3ibmK0hGmS7y+nsymHumi/SafGS+2ayQVi0BRJgO60+yT
        Xq6TEGmmFTYHKL2C7FE8xusX4w==
X-Google-Smtp-Source: ADUXVKJQyXkd9ju5H3livOuUXi7QaxgJkMijK+Zp+vLdPBu9BYexJrSotcOqVnuqSiuFQoL+SMx+Tg==
X-Received: by 2002:a17:902:8206:: with SMTP id x6-v6mr5621199pln.220.1529028308184;
        Thu, 14 Jun 2018 19:05:08 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id k69-v6sm9504953pgc.39.2018.06.14.19.05.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 14 Jun 2018 19:05:07 -0700 (PDT)
From:   Chunyan Zhang <zhang.chunyan@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Billows Wu <billows.wu@spreadtrum.com>, zhang.lyra@gmail.com
Subject: [PATCH V2 4/7] mmc: sdhci: add 32-bit block count support for v4 mode
Date:   Fri, 15 Jun 2018 10:04:12 +0800
Message-Id: <1529028255-6022-5-git-send-email-zhang.chunyan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529028255-6022-1-git-send-email-zhang.chunyan@linaro.org>
References: <1529028255-6022-1-git-send-email-zhang.chunyan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When Host Version 4 is enabled, SDMA System Address register is
re-defined as 32-bit Block Count, and SDMA uses ADMA System
Address register (05Fh-058h) instead.

Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
---
 drivers/mmc/host/sdhci.c | 3 ++-
 drivers/mmc/host/sdhci.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 5d3b0d8..b8ee124 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -943,7 +943,8 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 	/* Set the DMA boundary value and block size */
 	sdhci_writew(host, SDHCI_MAKE_BLKSZ(host->sdma_boundary, data->blksz),
 		     SDHCI_BLOCK_SIZE);
-	sdhci_writew(host, data->blocks, SDHCI_BLOCK_COUNT);
+	reg = host->v4_mode ? SDHCI_32BIT_BLK_CNT : SDHCI_BLOCK_COUNT;
+	sdhci_writew(host, data->blocks, reg);
 }
 
 static inline bool sdhci_auto_cmd12(struct sdhci_host *host,
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 820a863..1e84539 100644
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

