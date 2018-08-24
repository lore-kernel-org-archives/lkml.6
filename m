Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 386A0C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 09:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE3F621710
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 09:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="dQlu8mCy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE3F621710
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbeHXMz3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 08:55:29 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40891 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727019AbeHXMz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 08:55:29 -0400
Received: by mail-pl1-f193.google.com with SMTP id s17-v6so849187plp.7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 02:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bgWiDR0Rsg/hAoQ1TRN+MoB6IBhSRF8+l9TyLcN+DOA=;
        b=dQlu8mCy9PynuxJxGRTq5n4yo8HJnuuAE3i7I+H5Yrl7TSVz/5S9QQgS8IfLnWBVXJ
         fq8/ZyMnYNLNMSSxnqY+itXHZZ2XeM5GvfBg4zjFIy1ERnafyE+xSvZQsOPOJg8TOSYf
         XmMpSN06mp4EezwEoPRs42LQ0oLefdPtafJ9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bgWiDR0Rsg/hAoQ1TRN+MoB6IBhSRF8+l9TyLcN+DOA=;
        b=jm4KzvoixGuSS6J3FvRy204GR3JsCiybd3pQ74eW1a78fLc/L5gDGLeDGJ41QggA6S
         3c0rU6yrjJ64aYuMpqxEsPpHGaoy49rlEyQ17QeRyngyjI9Bi51CT9Dnjc+tZeq6Cc2U
         4MUCFmUstp/kkAoIxljL+QOGh0FJyTrMtUJmKhOMrTmRRGkfRSniUYOVckq2BNoR7yoC
         eAZGxph8LUownWnRZ8JFN0dLNnlpf9+95shiVqTa688XK/GYJgAbpDa8SQ6MhEDRXe2o
         /oK7a66vNFV2rEfogbxo1ZI7kyEHbv83drTO4hGfsQJLffbXjiH4izOqW0c4PtVBTcsU
         0yww==
X-Gm-Message-State: APzg51B8KwK2Pso6EJ6s5pkbkuLJlIbMIYCRAwMRBUQCQmTWHhPtYZmS
        mAQP420Ow3/+o/NBHQT5kdswsA==
X-Google-Smtp-Source: ANB0VdbaPIfdDH9ZB3+lShQV5SO70RgdhXHVeVCXU2MDCEWJ5AUPyCob1W1g3lUlwfa3hBPOEKAs4Q==
X-Received: by 2002:a17:902:32f:: with SMTP id 44-v6mr873421pld.15.1535102503504;
        Fri, 24 Aug 2018 02:21:43 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id g6-v6sm9520314pfb.11.2018.08.24.02.21.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 24 Aug 2018 02:21:42 -0700 (PDT)
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
Subject: [PATCH V6 6/9] mmc: sdhci: Add Auto CMD Auto Select support
Date:   Fri, 24 Aug 2018 17:20:25 +0800
Message-Id: <1535102428-20332-7-git-send-email-zhang.chunyan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535102428-20332-1-git-send-email-zhang.chunyan@linaro.org>
References: <1535102428-20332-1-git-send-email-zhang.chunyan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As SD Host Controller Specification v4.10 documents:
Host Controller Version 4.10 defines this "Auto CMD Auto Select" mode.
Selection of Auto CMD depends on setting of CMD23 Enable in the Host
Control 2 register which indicates whether card supports CMD23. If CMD23
Enable =1, Auto CMD23 is used and if CMD23 Enable =0, Auto CMD12 is
used. In case of Version 4.10 or later, use of Auto CMD Auto Select is
recommended rather than use of Auto CMD12 Enable or Auto CMD23
Enable.

This patch add this new mode support.

Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
---
 drivers/mmc/host/sdhci.c | 49 ++++++++++++++++++++++++++++++++++++++----------
 drivers/mmc/host/sdhci.h |  2 ++
 2 files changed, 41 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 05f9fff..7e01601 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1096,6 +1096,43 @@ static inline bool sdhci_auto_cmd12(struct sdhci_host *host,
 	       !mrq->cap_cmd_during_tfr;
 }
 
+static inline void sdhci_auto_cmd_select(struct sdhci_host *host,
+					 struct mmc_command *cmd,
+					 u16 *mode)
+{
+	bool use_cmd12 = sdhci_auto_cmd12(host, cmd->mrq) &&
+			 (cmd->opcode != SD_IO_RW_EXTENDED);
+	bool use_cmd23 = cmd->mrq->sbc && (host->flags & SDHCI_AUTO_CMD23);
+	u16 ctrl2;
+
+	/*
+	 * In case of Version 4.10 or later, use of 'Auto CMD Auto
+	 * Select' is recommended rather than use of 'Auto CMD12
+	 * Enable' or 'Auto CMD23 Enable'.
+	 */
+	if (host->version >= SDHCI_SPEC_410 && (use_cmd12 || use_cmd23)) {
+		*mode |= SDHCI_TRNS_AUTO_SEL;
+
+		ctrl2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+		if (use_cmd23)
+			ctrl2 |= SDHCI_CMD23_ENABLE;
+		else
+			ctrl2 &= ~SDHCI_CMD23_ENABLE;
+		sdhci_writew(host, ctrl2, SDHCI_HOST_CONTROL2);
+
+		return;
+	}
+
+	/*
+	 * If we are sending CMD23, CMD12 never gets sent
+	 * on successful completion (so no Auto-CMD12).
+	 */
+	if (use_cmd12)
+		*mode |= SDHCI_TRNS_AUTO_CMD12;
+	else if (use_cmd23)
+		*mode |= SDHCI_TRNS_AUTO_CMD23;
+}
+
 static void sdhci_set_transfer_mode(struct sdhci_host *host,
 	struct mmc_command *cmd)
 {
@@ -1122,17 +1159,9 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
 
 	if (mmc_op_multi(cmd->opcode) || data->blocks > 1) {
 		mode = SDHCI_TRNS_BLK_CNT_EN | SDHCI_TRNS_MULTI;
-		/*
-		 * If we are sending CMD23, CMD12 never gets sent
-		 * on successful completion (so no Auto-CMD12).
-		 */
-		if (sdhci_auto_cmd12(host, cmd->mrq) &&
-		    (cmd->opcode != SD_IO_RW_EXTENDED))
-			mode |= SDHCI_TRNS_AUTO_CMD12;
-		else if (cmd->mrq->sbc && (host->flags & SDHCI_AUTO_CMD23)) {
-			mode |= SDHCI_TRNS_AUTO_CMD23;
+		sdhci_auto_cmd_select(host, cmd, &mode);
+		if (cmd->mrq->sbc && (host->flags & SDHCI_AUTO_CMD23))
 			sdhci_writel(host, cmd->mrq->sbc->arg, SDHCI_ARGUMENT2);
-		}
 	}
 
 	if (data->flags & MMC_DATA_READ)
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 0a1e25f..4913d75 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -42,6 +42,7 @@
 #define  SDHCI_TRNS_BLK_CNT_EN	0x02
 #define  SDHCI_TRNS_AUTO_CMD12	0x04
 #define  SDHCI_TRNS_AUTO_CMD23	0x08
+#define  SDHCI_TRNS_AUTO_SEL	0x0C
 #define  SDHCI_TRNS_READ	0x10
 #define  SDHCI_TRNS_MULTI	0x20
 
@@ -185,6 +186,7 @@
 #define   SDHCI_CTRL_DRV_TYPE_D		0x0030
 #define  SDHCI_CTRL_EXEC_TUNING		0x0040
 #define  SDHCI_CTRL_TUNED_CLK		0x0080
+#define  SDHCI_CMD23_ENABLE		0x0800
 #define  SDHCI_CTRL_V4_MODE		0x1000
 #define  SDHCI_CTRL_64BIT_ADDR		0x2000
 #define  SDHCI_CTRL_PRESET_VAL_ENABLE	0x8000
-- 
2.7.4

