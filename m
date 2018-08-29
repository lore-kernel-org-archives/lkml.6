Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC8BFC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A0452089B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QBFWRQX0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A0452089B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbeH2K7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 06:59:06 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46926 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727172AbeH2K7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 06:59:05 -0400
Received: by mail-pg1-f194.google.com with SMTP id b129-v6so1903607pga.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 00:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9gO45GPUCiWNoJSPPW5yykw6lOn1on3+rP/v8SuzWGk=;
        b=QBFWRQX0gaMKEq94OiPVi2I1NokcHktXgosg718cMFPkhord4M7chknNgxq8A2jmQj
         x06VfYu0EJETEi2z/cDBCJCJ0siqFU0S5OPRdYA9iXvj1SgN9zgcWt3HBSVW8vWLILlz
         2OvFYmmAM+K2bS4ZEIoUgPzpEeGwH0MVRT/tI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9gO45GPUCiWNoJSPPW5yykw6lOn1on3+rP/v8SuzWGk=;
        b=F2JhdB7VslOG0Fpf5CpjEZZWUYrMR1Hg0ZufA1L0fXrtuotIF/c5kBrXwdF8xUF3Ew
         9cC220mHXuIGtRaw2Jzx7Uk4nk79MPaxzeC/EVMx8D8HPl8CI6GBJ+9V6tcHEmYGXaQn
         0onG5r3G7A1pzQm8MhUvmrvkWtf7WsSLoHBHWvLCfhmAXA+l0YfA+3DiipQmkHVqrhKr
         b1/unn1xp1h+xRQhyKUOWYVA4q9bKziDX42axLYvl/u8HSZFuNYKRWb8oU9YFG4XnaxK
         QY4FYOOKBZg8Zbwq9dy8/R7o7z2F7RuMB+QvxNM5kEAFAphsDEc99dYkVPviRKLYqbSE
         dCIA==
X-Gm-Message-State: APzg51CpT5Si0bZUiZ8Bao/fxG7ImLLsLMetsXr+Wk+fSxsJLJPrS5nh
        yAJvHjC2nYbhQSR4Cn2N0ElHJg==
X-Google-Smtp-Source: ANB0Vdbc4wwz0uzRwiVT7NbKw1p/EJqLtGX1ATiEULmbHmrh+hKWJdGAzxncAeeB5pSr061df78yow==
X-Received: by 2002:a65:5189:: with SMTP id h9-v6mr4598889pgq.13.1535526220465;
        Wed, 29 Aug 2018 00:03:40 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id d81-v6sm4317342pfj.122.2018.08.29.00.03.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 Aug 2018 00:03:39 -0700 (PDT)
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
Subject: [PATCH V7 6/9] mmc: sdhci: Add Auto CMD Auto Select support
Date:   Wed, 29 Aug 2018 15:03:01 +0800
Message-Id: <1535526184-32718-7-git-send-email-zhang.chunyan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535526184-32718-1-git-send-email-zhang.chunyan@linaro.org>
References: <1535526184-32718-1-git-send-email-zhang.chunyan@linaro.org>
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
index 604bf4c..62d843ac90 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1095,6 +1095,43 @@ static inline bool sdhci_auto_cmd12(struct sdhci_host *host,
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
@@ -1123,17 +1160,9 @@ static void sdhci_set_transfer_mode(struct sdhci_host *host,
 
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
index f7a1079..4a19ff8 100644
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

