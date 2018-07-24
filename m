Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E53CECDE5F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 02:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06A5E20779
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 02:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jAgXze0d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06A5E20779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388448AbeGXDzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 23:55:40 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41987 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388263AbeGXDzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 23:55:40 -0400
Received: by mail-pf1-f196.google.com with SMTP id l9-v6so487566pff.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 19:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=txKumXrCwsJ2SBxzMOb/NbZpSTq91k1tqQrJZCO3LMM=;
        b=jAgXze0dSOw2UANSA7IwGq5NpfuKN4Nf/E0pten2rnmMdhVreDCpXlIEiVkk/Fv3ag
         wgCzpi1gRsfGnwmTV+IQLtGukfMPehZAa++vgBYG2Iu3il0VhaSHnOdexDq5DLgeV33q
         Se8mXgxA3Sn0UYxhYgDf49bnA6DQTiirhBfmc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=txKumXrCwsJ2SBxzMOb/NbZpSTq91k1tqQrJZCO3LMM=;
        b=QB+SKZZ3jq21Jvs8qz8+105bAjqXrTsu19FlzEvKQTfhQetii+1sy4lHOEIXSFXrjf
         jPe70dWg0cDnOvphB7svD0ZTmvUCkxWuceH5S7ubasSoAafPMxb15eV360AnanW6cfGP
         4AFZs+mdDfTLC3PuIEC2nKZQy/VCBnywBp4A4dqEuNTSaUsgHIpKnyNJtjtUudRzmfqR
         +CiZM+q1V63SIItkQ9BfSq5VMvgmfKXzQ3c7Ykgyfmb7neLv0XmrrrURi/6CXAtvC+gC
         zFn+i9oPkJuKCDWiaoVBBtaZgNmDDZsXafzB8sczmIFrd07oVyV2R/0VvLvShk6TT6wx
         a8sA==
X-Gm-Message-State: AOUpUlHDMJS28V5GGPsTrzA09xkOMTuxA38U81lJMKfJ89oF7KK2rXJe
        Ip6kyQw7wvS0XGMwqXqNnYErxA==
X-Google-Smtp-Source: AAOMgpdrPug9ZVEM4BCmvIUvDupVO4ZtfZb0J1uuLzcnnsGXStxBmXXRG1eIzhwfh/Gd9RDcqg3Q1A==
X-Received: by 2002:a62:c4c3:: with SMTP id h64-v6mr15714313pfk.39.1532400688351;
        Mon, 23 Jul 2018 19:51:28 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id y132-v6sm14770373pfb.91.2018.07.23.19.51.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 23 Jul 2018 19:51:27 -0700 (PDT)
From:   Chunyan Zhang <zhang.chunyan@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Billows Wu <billows.wu@spreadtrum.com>,
        Jason Wu <jason.wu@unisoc.com>, zhang.lyra@gmail.com
Subject: [PATCH V4 4/7] mmc: sdhci: add 32-bit block count support for v4 mode
Date:   Tue, 24 Jul 2018 10:51:11 +0800
Message-Id: <1532400671-23429-1-git-send-email-zhang.chunyan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532340508-8749-5-git-send-email-zhang.chunyan@linaro.org>
References: <1532340508-8749-5-git-send-email-zhang.chunyan@linaro.org>
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
index 920d8ec..c272a2b 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1070,7 +1070,19 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
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
index 23318ff..81aae07 100644
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

