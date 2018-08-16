Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F88C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 07:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9CF5214C5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 07:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aegRell/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9CF5214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389665AbeHPKwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 06:52:30 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45161 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389650AbeHPKw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 06:52:29 -0400
Received: by mail-pg1-f195.google.com with SMTP id f1-v6so1670214pgq.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 00:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zUSIlBoQBXb7x6oxFMIHoqh7Gy2b5VOn8aSKwFqgVZ4=;
        b=aegRell/uXSTpalhIJIjuAcM9LYAzHMKPIQkc/TH+PfYCpoFTAHL0w5kmKlf3btj15
         z51cHNN7F/XQ3vNsJoO8AGaXEiifDqDdtjW+7eUjPlyeNKuBoOHOsAGC3srxUwGoxP7V
         PwV9tkvrd2WXeLQU9ctdp09r4XKPf1lG0+6FI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zUSIlBoQBXb7x6oxFMIHoqh7Gy2b5VOn8aSKwFqgVZ4=;
        b=jRDABmzA0hn2MT62KNCAo8A0LpdF6a80Jx25H4a/sp5HkvZu/waoHzizNVnhCYvKKA
         C4lnw+YFCXTSG/p8Nr3AwDwQ60mgTZ4xmvM9Q1lNFaOY/eqYWsJtEO5S2IaupnptgELz
         0+Sh5sD1X0WD7CAQV80xlqFFnSeuC2LFJJ3XMgzgQDYlBUu2Aiwpv3DI1Hz0kWktH0YM
         +CX8vXMp62Rms3VjD+tfsXwUq4jxfkv68wYsolS8CpP9cyZMP/o12UsfhPWKhXsLE2fm
         pNgGwygXc2V/emidvpge4wZAzvmvcJ/PYHO2UGqzKCCUbJ4AuQCQlAmKzaqwzGLTa5kv
         aHRQ==
X-Gm-Message-State: AOUpUlG8GCqwWdynOoqjnOT6R2DDQPU49sb/p6gIvKShqcKvtqRNsJX4
        kYinDvTwwfVPv/AKvLGvfLSmDg==
X-Google-Smtp-Source: AA+uWPz0eWBe6MGaviXgC5TINyyOFCzEBdMrNTcYxtrQfKxCJWwmzC6TPnhfl0OBniqhjzjOtkDf/g==
X-Received: by 2002:a63:d002:: with SMTP id z2-v6mr28349949pgf.262.1534406147498;
        Thu, 16 Aug 2018 00:55:47 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id i25-v6sm50838137pfi.150.2018.08.16.00.55.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 16 Aug 2018 00:55:46 -0700 (PDT)
From:   Chunyan Zhang <zhang.chunyan@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Billows Wu <billows.wu@unisoc.com>,
        Jason Wu <jason.wu@unisoc.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH V5 07/10] mmc: sdhci: Add Auto CMD Auto Select support
Date:   Thu, 16 Aug 2018 15:54:21 +0800
Message-Id: <1534406064-10065-8-git-send-email-zhang.chunyan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534406064-10065-1-git-send-email-zhang.chunyan@linaro.org>
References: <1534406064-10065-1-git-send-email-zhang.chunyan@linaro.org>
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
 drivers/mmc/host/sdhci.c | 67 ++++++++++++++++++++++++++++++++++++++++--------
 drivers/mmc/host/sdhci.h |  2 ++
 2 files changed, 58 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index a72ad0d..06c2ae9 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -312,6 +312,23 @@ static void sdhci_config_dma(struct sdhci_host *host)
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
@@ -1095,6 +1112,44 @@ static inline bool sdhci_auto_cmd12(struct sdhci_host *host,
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
+		/*
+		 * Note no need to set SDHCI_ARGUMENT2 here, since for version
+		 * 4.10 and aboves, it doesn't support stuff bits of CMD23
+		 * argument but only number of blocks which have been set
+		 * already during prepare data.
+		 */
+		if (use_cmd23)
+			sdhci_enable_cmd23(host);
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
@@ -1121,17 +1176,7 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
 
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
index daf8c1e..a8d5be5 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -43,6 +43,7 @@
 #define  SDHCI_TRNS_BLK_CNT_EN	0x02
 #define  SDHCI_TRNS_AUTO_CMD12	0x04
 #define  SDHCI_TRNS_AUTO_CMD23	0x08
+#define  SDHCI_TRNS_AUTO_SEL	0x0C
 #define  SDHCI_TRNS_READ	0x10
 #define  SDHCI_TRNS_MULTI	0x20
 
@@ -186,6 +187,7 @@
 #define   SDHCI_CTRL_DRV_TYPE_D		0x0030
 #define  SDHCI_CTRL_EXEC_TUNING		0x0040
 #define  SDHCI_CTRL_TUNED_CLK		0x0080
+#define  SDHCI_CMD23_ENABLE		0x0800
 #define  SDHCI_CTRL_V4_MODE		0x1000
 #define  SDHCI_CTRL_64BIT_ADDR		0x2000
 #define  SDHCI_CTRL_PRESET_VAL_ENABLE	0x8000
-- 
2.7.4

