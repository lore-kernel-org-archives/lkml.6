Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 6B495C5CFC0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 02:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22A7B20891
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 02:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hd8DOIb1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22A7B20891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965444AbeFOCE5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 22:04:57 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:46080 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965401AbeFOCEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 22:04:53 -0400
Received: by mail-pl0-f67.google.com with SMTP id 30-v6so4522068pld.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 19:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HweywlkV3W7hX6j4jAziXnB8202QrrYYO0FfXOW5ydM=;
        b=Hd8DOIb1VuXzTzCRG00r3F7KyoIp6qzwSDWD10+FgpacBq615zkgwJMx/NESKdxh9x
         bbhe+SJPEhLTFVBYPt9fmsT+7oxAB4YdUq2e4u1SJpz6oN+GtGvV6DzYLXIdxMPA0krI
         Ds/XBBX8oyipU8HJLCrdxFqbwKtWm82cEMdWU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HweywlkV3W7hX6j4jAziXnB8202QrrYYO0FfXOW5ydM=;
        b=pRlmWBy4kuSvOlNQk55b2qtVQp/pgeueAOAhWg+Ynv5yrW0kgH7h1gZL4uo+Qo4QpV
         hA1Op0Iy8YbIwFB4thjRpbd35JJQijiy8Ff7PhiiUFU/NApoFWrt9EL+G8ckQsrVJ08G
         44j5QWi5wQ1+nO+3XTnzhHdeRp9R0Cfn1eG7RSzcF05eSyCmg35Sp+ISopx7dNR/fvj4
         s/0jQwudJuywm7PAnGvqnojRNSvKYNRt2dsft1h3H2GmK+IpuYnwOjYwfWU9Q858d3TK
         EeccpH1sauh9wgDGiHekvlkrYTxSWi0h/IDJo1xmvAcDcVvc0k5jy5NKWgekoRuzNh2+
         VBBA==
X-Gm-Message-State: APt69E3QAgSeDnax58SJBfKBHzDDECt6O2M+ctbwE00hg1A3fkRSw1Gj
        mRU6mblUwgtgJhKKMutdZhcdDA==
X-Google-Smtp-Source: ADUXVKIjXT7QE6HFzE8v0nP5qGM4Hn6atlWyp4Tovh5ANbxr6WP4WdXeqamgDQ9sA1gV5yrDyhZPlQ==
X-Received: by 2002:a17:902:c6b:: with SMTP id 98-v6mr5695123pls.37.1529028293264;
        Thu, 14 Jun 2018 19:04:53 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id k69-v6sm9504953pgc.39.2018.06.14.19.04.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 14 Jun 2018 19:04:52 -0700 (PDT)
From:   Chunyan Zhang <zhang.chunyan@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Billows Wu <billows.wu@spreadtrum.com>, zhang.lyra@gmail.com
Subject: [PATCH V2 2/7] mmc: sdhci: made changes for System Address register of SDMA
Date:   Fri, 15 Jun 2018 10:04:10 +0800
Message-Id: <1529028255-6022-3-git-send-email-zhang.chunyan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529028255-6022-1-git-send-email-zhang.chunyan@linaro.org>
References: <1529028255-6022-1-git-send-email-zhang.chunyan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the SD host controller specification version 4.10, when
Host Version 4 is enabled, SDMA uses ADMA System Address register
(05Fh-058h) instead of using SDMA System Address register to
support both 32-bit and 64-bit addressing.

Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
---
 drivers/mmc/host/sdhci.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index cf5695f..f57201f 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -805,6 +805,7 @@ static void sdhci_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
 static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 {
 	u8 ctrl;
+	u32 reg;
 	struct mmc_data *data = cmd->data;
 
 	if (sdhci_data_line_cmd(cmd))
@@ -894,8 +895,10 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 					     SDHCI_ADMA_ADDRESS_HI);
 		} else {
 			WARN_ON(sg_cnt != 1);
+			reg = host->v4_mode ? SDHCI_ADMA_ADDRESS :
+				SDHCI_DMA_ADDRESS;
 			sdhci_writel(host, sdhci_sdma_address(host),
-				     SDHCI_DMA_ADDRESS);
+				     reg);
 		}
 	}
 
@@ -2721,6 +2724,7 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
 		 */
 		if (intmask & SDHCI_INT_DMA_END) {
 			u32 dmastart, dmanow;
+			u32 reg;
 
 			dmastart = sdhci_sdma_address(host);
 			dmanow = dmastart + host->data->bytes_xfered;
@@ -2733,7 +2737,9 @@ static void sdhci_data_irq(struct sdhci_host *host, u32 intmask)
 			host->data->bytes_xfered = dmanow - dmastart;
 			DBG("DMA base 0x%08x, transferred 0x%06x bytes, next 0x%08x\n",
 			    dmastart, host->data->bytes_xfered, dmanow);
-			sdhci_writel(host, dmanow, SDHCI_DMA_ADDRESS);
+			reg = host->v4_mode ? SDHCI_ADMA_ADDRESS :
+				SDHCI_DMA_ADDRESS;
+			sdhci_writel(host, dmanow, reg);
 		}
 
 		if (intmask & SDHCI_INT_DATA_END) {
-- 
2.7.4

