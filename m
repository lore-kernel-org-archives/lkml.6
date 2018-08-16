Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B28C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 07:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48961214C5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 07:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dp1aCAmZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48961214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389579AbeHPKwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 06:52:08 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36299 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389564AbeHPKwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 06:52:07 -0400
Received: by mail-pg1-f193.google.com with SMTP id h12-v6so1693330pgs.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 00:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gWRkaXKJ7LnuvmIuqtMHfNjquIfkm3r7MkZBwNfZ4Eo=;
        b=Dp1aCAmZk2tDAJO6azlL9KmSn+SkRgrTxgYkDy8Z6Ba6V3AZdLgT8kzpdo6yiR59PK
         mGSyRkjPTeu7fbXESpC5b3sJFqSQUBkOE4TkpuoKbljZzgafdEqlTUKP/wC1YLvtZJPP
         2nIFcVpdkLj0LqF+Z0RZPI76QEEtO0mo4o2y0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gWRkaXKJ7LnuvmIuqtMHfNjquIfkm3r7MkZBwNfZ4Eo=;
        b=DaIVv/BB6hacFngo5Wbv9fV5kMsUVKPvuXj+H2Jmdg17dlJ4zHvthDhtmFeMg8+lZm
         ygnEFLBP0jQmbvM9Jrcf6sOZUbxNE5P5UheMKtMuYKMkMEFb+vqtN8l0Bvf8T06kdA0h
         AMNtixIg1bSP2zjJoyvBlZCjLw6HlrC60XBu5whQ7e+jfnWt3h98jGdo7grVHYDfSa1U
         gZ+47rr7BuigvIU1fmBabxfuSipy8Btc5JIaMqKPlgdNlJr8x+oyjdmgyKKtMlzPh9jW
         iDfMCve8rQFyoJlwqy9OuPOV4C3AM66Vrh9xvYBrrYi8x5+Xixr2QKfsghbdLNEUSL6J
         NI8Q==
X-Gm-Message-State: AOUpUlGvQpLP9z8Pk5HyFFNraFCO82zyUwjy/r+CRC/Tl8YURSyY3bpo
        N5fJNhPVHf4dafuVWBzwLAfekA==
X-Google-Smtp-Source: AA+uWPxeqcqnt4jhpkdobiizobJTeVx3q1LajaQZaBFm0dc8iJY6WFuT/VzfKNPjdmmhfVIephNALQ==
X-Received: by 2002:a63:2506:: with SMTP id l6-v6mr27713658pgl.237.1534406126103;
        Thu, 16 Aug 2018 00:55:26 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id i25-v6sm50838137pfi.150.2018.08.16.00.55.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 16 Aug 2018 00:55:25 -0700 (PDT)
From:   Chunyan Zhang <zhang.chunyan@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Billows Wu <billows.wu@unisoc.com>,
        Jason Wu <jason.wu@unisoc.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH V5 02/10] mmc: sdhci: Add sd host v4 mode
Date:   Thu, 16 Aug 2018 15:54:16 +0800
Message-Id: <1534406064-10065-3-git-send-email-zhang.chunyan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534406064-10065-1-git-send-email-zhang.chunyan@linaro.org>
References: <1534406064-10065-1-git-send-email-zhang.chunyan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For SD host controller version 4.00 or later ones, there're two
modes of implementation - Version 3.00 compatible mode or
Version 4 mode.  This patch introduced an interface to enable
v4 mode.

Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
---
 drivers/mmc/host/sdhci.c | 29 +++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci.h |  3 +++
 2 files changed, 32 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index ca04834..d808a1f 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -123,6 +123,29 @@ EXPORT_SYMBOL_GPL(sdhci_dumpregs);
  *                                                                           *
 \*****************************************************************************/
 
+static void sdhci_do_enable_v4_mode(struct sdhci_host *host)
+{
+	u16 ctrl2;
+
+	ctrl2 = sdhci_readb(host, SDHCI_HOST_CONTROL2);
+	if (ctrl2 & SDHCI_CTRL_V4_MODE)
+		return;
+
+	ctrl2 |= SDHCI_CTRL_V4_MODE;
+	sdhci_writeb(host, ctrl2, SDHCI_HOST_CONTROL);
+}
+
+/*
+ * This can be called before sdhci_add_host() by Vendor's host controller
+ * driver to enable v4 mode if supported.
+ */
+void sdhci_enable_v4_mode(struct sdhci_host *host)
+{
+	host->v4_mode = true;
+	sdhci_do_enable_v4_mode(host);
+}
+EXPORT_SYMBOL_GPL(sdhci_enable_v4_mode);
+
 static inline bool sdhci_data_line_cmd(struct mmc_command *cmd)
 {
 	return cmd->data || cmd->flags & MMC_RSP_BUSY;
@@ -252,6 +275,9 @@ static void sdhci_init(struct sdhci_host *host, int soft)
 	else
 		sdhci_do_reset(host, SDHCI_RESET_ALL);
 
+	if (host->v4_mode)
+		sdhci_do_enable_v4_mode(host);
+
 	sdhci_set_default_irqs(host);
 
 	host->cqe_on = false;
@@ -3370,6 +3396,9 @@ void __sdhci_read_caps(struct sdhci_host *host, u16 *ver, u32 *caps, u32 *caps1)
 
 	sdhci_do_reset(host, SDHCI_RESET_ALL);
 
+	if (host->v4_mode)
+		sdhci_do_enable_v4_mode(host);
+
 	of_property_read_u64(mmc_dev(host->mmc)->of_node,
 			     "sdhci-caps-mask", &dt_caps_mask);
 	of_property_read_u64(mmc_dev(host->mmc)->of_node,
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 31c865e..5042c23 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -184,6 +184,7 @@
 #define   SDHCI_CTRL_DRV_TYPE_D		0x0030
 #define  SDHCI_CTRL_EXEC_TUNING		0x0040
 #define  SDHCI_CTRL_TUNED_CLK		0x0080
+#define  SDHCI_CTRL_V4_MODE		0x1000
 #define  SDHCI_CTRL_PRESET_VAL_ENABLE	0x8000
 
 #define SDHCI_CAPABILITIES	0x40
@@ -504,6 +505,7 @@ struct sdhci_host {
 	bool preset_enabled;	/* Preset is enabled */
 	bool pending_reset;	/* Cmd/data reset is pending */
 	bool irq_wake_enabled;	/* IRQ wakeup is enabled */
+	bool v4_mode;		/* Host Version 4 Enable */
 
 	struct mmc_request *mrqs_done[SDHCI_MAX_MRQS];	/* Requests done */
 	struct mmc_command *cmd;	/* Current command */
@@ -750,5 +752,6 @@ bool sdhci_cqe_irq(struct sdhci_host *host, u32 intmask, int *cmd_error,
 		   int *data_error);
 
 void sdhci_dumpregs(struct sdhci_host *host);
+void sdhci_enable_v4_mode(struct sdhci_host *host);
 
 #endif /* __SDHCI_HW_H */
-- 
2.7.4

