Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2819ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 10:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D21C20875
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 10:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="G0siyRfk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D21C20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388426AbeGWLJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 07:09:59 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44474 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388375AbeGWLJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 07:09:59 -0400
Received: by mail-pg1-f196.google.com with SMTP id r1-v6so40946pgp.11
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 03:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+pDYdrEU5zydj6TS5ZAbh5dlUzb5zJaLCom/C7No0Jg=;
        b=G0siyRfkolwXWKyBmUvy2lCI4X+2feBbUMTqQ6wkNeqqQeL/KCJl2Nmkxr3lCw/N/h
         5hxVs0UfcC5xN3AqzmilFILJKMPQzrDMfKoCEQdpUiOM3rkDLn9wH9m2gF/2C/WwA9px
         PQEbMttAA747HAgB42DORmFvQ0HySvq38m81I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+pDYdrEU5zydj6TS5ZAbh5dlUzb5zJaLCom/C7No0Jg=;
        b=WUK4Yckf4H9bIBNyhKGNXusNZvh1Fw7aKtFR2T3uUDXdwHSx8Z+OUVjUjkQ1TbFCsP
         hJEMGCIBH5Gm2tkSV2B7B3/7OwY5smIOwNkxgG+VDK3UzppAIDUgYUV4Nk+o183+lqvU
         x+WP0gw+uGMK68Zn+6N31Lg4Iiyar0ADTEUO6VhPCQJWhy3MsiVm2zDal0uGBb+8q9/F
         G+zY07DMgTxEoXYo9BhAj2tTUe+wekk6UNAJ1mcZFmHqJxY1NVow8S2PI745gN681M7D
         1m4a/yqISKKMjdJMr6pJBDTn05PbdAW6fWOHPEyXMjUiGgF2hyi4BNCLai+1WosnOYC5
         XNIw==
X-Gm-Message-State: AOUpUlHFaqK42AFCMpeb0jtTh3dv8YgjgEJUQe968sySUvR7d0/sUyUY
        cE38oCwkTKIcAH+uO9NxSrxA3g==
X-Google-Smtp-Source: AAOMgpciZN1dkZXLtrOkC8c3pIkB1LYswdn5j50eBBJiuHFD5/MzjVi4lRSfYY+n/x7qdz109WorpQ==
X-Received: by 2002:a62:ccd0:: with SMTP id j77-v6mr12554876pfk.22.1532340572214;
        Mon, 23 Jul 2018 03:09:32 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id e82-v6sm13470698pfk.87.2018.07.23.03.09.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 23 Jul 2018 03:09:31 -0700 (PDT)
From:   Chunyan Zhang <zhang.chunyan@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Billows Wu <billows.wu@spreadtrum.com>,
        Jason Wu <jason.wu@unisoc.com>, zhang.lyra@gmail.com
Subject: [PATCH V4 5/7] mmc: sdhci: add Auto CMD Auto Select support
Date:   Mon, 23 Jul 2018 18:08:26 +0800
Message-Id: <1532340508-8749-6-git-send-email-zhang.chunyan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1532340508-8749-1-git-send-email-zhang.chunyan@linaro.org>
References: <1532340508-8749-1-git-send-email-zhang.chunyan@linaro.org>
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
 drivers/mmc/host/sdhci.c | 61 +++++++++++++++++++++++++++++++++++++++---------
 drivers/mmc/host/sdhci.h |  2 ++
 2 files changed, 52 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 5acea3d..5c60590 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -311,6 +311,23 @@ static void sdhci_config_dma(struct sdhci_host *host)
 	sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
 }
 
+static void sdhci_enable_cmd23(struct sdhci_host *host)
+{
+	u16 ctrl2;
+
+	/*
+	 * This is used along with "Auto CMD Auto Select" feature,
+	 * which is introduced from v4.10, if card supports CMD23,
+	 * Auto CMD23 should be used instead of Auto CMD12.
+	 */
+	if (host->version >= SDHCI_SPEC_410 &&
+	    (host->mmc->caps & MMC_CAP_CMD23)) {
+		ctrl2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+		ctrl2 |= SDHCI_CMD23_ENABLE;
+		sdhci_writew(host, ctrl2, SDHCI_HOST_CONTROL2);
+	}
+}
+
 static void sdhci_init(struct sdhci_host *host, int soft)
 {
 	struct mmc_host *mmc = host->mmc;
@@ -329,6 +346,8 @@ static void sdhci_init(struct sdhci_host *host, int soft)
 		host->clock = 0;
 		mmc->ops->set_ios(mmc, &mmc->ios);
 	}
+
+	sdhci_enable_cmd23(host);
 }
 
 static void sdhci_reinit(struct sdhci_host *host)
@@ -1093,6 +1112,36 @@ static inline bool sdhci_auto_cmd12(struct sdhci_host *host,
 	       !mrq->cap_cmd_during_tfr;
 }
 
+static inline void sdhci_auto_cmd_select(struct sdhci_host *host,
+					 struct mmc_command *cmd,
+					 u16 *mode)
+{
+	bool use_cmd12 = sdhci_auto_cmd12(host, cmd->mrq) &&
+			 (cmd->opcode != SD_IO_RW_EXTENDED);
+	bool use_cmd23 = cmd->mrq->sbc && (host->flags & SDHCI_AUTO_CMD23);
+
+	/*
+	 * In case of Version 4.10 or later, use of 'Auto CMD Auto
+	 * Select' is recommended rather than use of 'Auto CMD12
+	 * Enable' or 'Auto CMD23 Enable'.
+	 */
+	if (host->version >= SDHCI_SPEC_410 && (use_cmd12 || use_cmd23)) {
+		*mode |= SDHCI_TRNS_AUTO_SEL;
+		return;
+	}
+
+	/*
+	 * If we are sending CMD23, CMD12 never gets sent
+	 * on successful completion (so no Auto-CMD12).
+	 */
+	if (use_cmd12) {
+		*mode |= SDHCI_TRNS_AUTO_CMD12;
+	} else if (use_cmd23) {
+		*mode |= SDHCI_TRNS_AUTO_CMD23;
+		sdhci_writel(host, cmd->mrq->sbc->arg, SDHCI_ARGUMENT2);
+	}
+}
+
 static void sdhci_set_transfer_mode(struct sdhci_host *host,
 	struct mmc_command *cmd)
 {
@@ -1119,17 +1168,7 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
 
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
+		sdhci_auto_cmd_select(host, cmd, &mode);
 	}
 
 	if (data->flags & MMC_DATA_READ)
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 81aae07..a8f4ec2 100644
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

