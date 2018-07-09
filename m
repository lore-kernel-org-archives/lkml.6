Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 743A1C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 03:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DF4E208DB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 03:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eExNJfwr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DF4E208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754458AbeGIDWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 23:22:02 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:37753 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754413AbeGIDWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 23:22:00 -0400
Received: by mail-pl0-f65.google.com with SMTP id 31-v6so5343990plc.4
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jul 2018 20:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ey789fHEvUYxMIfFWvZa0+J79sna2Fb1Og/8oPpUtLc=;
        b=eExNJfwrcCCDcUfslT48vdm3LZaaKmHx7HmOx8tCxk8d+e++fQyDtDmNGDCLgIKRAk
         CsG3xcfTCHM31RHCebwLP8iaD2cfetFa9cQ0cLoHrwdwxV7LwD/36lPt8sryH0efLYDM
         KVvERUpn913AFY875wb6IB7XVBbXfeGrQ19Aw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ey789fHEvUYxMIfFWvZa0+J79sna2Fb1Og/8oPpUtLc=;
        b=fr+LIeWZln04KG1qCXxMXiYiAh1qf1hCG7PJbuozk575pA7JzhidcNBHQJjQfYkGK6
         3DWUPd6d873LXshvwmwNvfrqZMB+1bfxCYysRqwxl5ZqSFeGQ7jzIvx+NlIBXvW1hgpV
         5BId+1Z35bk+ZlPS34RaaEXNnM3aI3SJJFOVBoM/nKtxCAGOwdI9MUq3lpmx+BvMcteK
         TfsrcWO50Q+R9gI/cZxO+/E6XtmJCMByAj7JLP4fTv1kM8b3XRtn767iLtA9jKCRFV92
         NoM9CHSpLXbErcte4w9txADuE0SutnVldMeSoj6F1wBUj8vS1qVtBfMqWjczmitnBwTL
         1nUg==
X-Gm-Message-State: APt69E2LyJmT2iPjIZmb3pIljtfYLTdchYVLvzTJD5qaNoCjTE3UH4BP
        xr0YNCbhFsQRbxD5DV9rI6Ovgw==
X-Google-Smtp-Source: AAOMgpeDFw40p/n4kg5iW+GxWBCIRrvTN8sdKHGGpDGqCeCdXl0Ewre3JszgTcxVMkcpBXX0zZGuYw==
X-Received: by 2002:a17:902:2006:: with SMTP id n6-v6mr18808377pla.325.1531106519740;
        Sun, 08 Jul 2018 20:21:59 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id e82-v6sm41458950pfk.87.2018.07.08.20.21.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 08 Jul 2018 20:21:58 -0700 (PDT)
From:   Chunyan Zhang <zhang.chunyan@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Billows Wu <billows.wu@spreadtrum.com>, zhang.lyra@gmail.com
Subject: [PATCH V3 5/7] mmc: sdhci: add Auto CMD Auto Select support
Date:   Mon,  9 Jul 2018 11:19:56 +0800
Message-Id: <1531106398-14062-6-git-send-email-zhang.chunyan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531106398-14062-1-git-send-email-zhang.chunyan@linaro.org>
References: <1531106398-14062-1-git-send-email-zhang.chunyan@linaro.org>
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
 drivers/mmc/host/sdhci.c | 39 ++++++++++++++++++++++++++++-----------
 drivers/mmc/host/sdhci.h |  2 ++
 2 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index f64e766..1ca3871 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1033,6 +1033,33 @@ static inline bool sdhci_auto_cmd12(struct sdhci_host *host,
 	       !mrq->cap_cmd_during_tfr;
 }
 
+static inline void sdhci_auto_cmd_enable(struct sdhci_host *host,
+					 struct mmc_command *cmd,
+					 u16 *mode)
+{
+	/*
+	 * In case of Version 4.10 or later, use of 'Auto CMD Auto
+	 * Select' is recommended rather than use of 'Auto CMD12
+	 * Enable' or 'Auto CMD23 Enable'.
+	 */
+	if (host->version >= SDHCI_SPEC_410) {
+		*mode |= SDHCI_TRNS_AUTO_SEL;
+		return;
+	}
+
+	/*
+	 * If we are sending CMD23, CMD12 never gets sent
+	 * on successful completion (so no Auto-CMD12).
+	 */
+	if (sdhci_auto_cmd12(host, cmd->mrq) &&
+	    (cmd->opcode != SD_IO_RW_EXTENDED)) {
+		*mode |= SDHCI_TRNS_AUTO_CMD12;
+	} else if (cmd->mrq->sbc && (host->flags & SDHCI_AUTO_CMD23)) {
+		*mode |= SDHCI_TRNS_AUTO_CMD23;
+		sdhci_writel(host, cmd->mrq->sbc->arg, SDHCI_ARGUMENT2);
+	}
+}
+
 static void sdhci_set_transfer_mode(struct sdhci_host *host,
 	struct mmc_command *cmd)
 {
@@ -1059,17 +1086,7 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
 
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
-			sdhci_writel(host, cmd->mrq->sbc->arg, SDHCI_ARGUMENT2);
-		}
+		sdhci_auto_cmd_enable(host, cmd, &mode);
 	}
 
 	if (data->flags & MMC_DATA_READ)
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 889e48b..8263ac6 100644
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

