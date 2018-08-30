Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB0B7C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 08:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85CD52082B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 08:22:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gUmkOhig"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85CD52082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbeH3MXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 08:23:05 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34033 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727863AbeH3MXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 08:23:04 -0400
Received: by mail-pg1-f194.google.com with SMTP id d19-v6so3573746pgv.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 01:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ergCaURol2Se4ESlok/cft+LAqO2WAQPcTbIx100RWc=;
        b=gUmkOhigOe2/KEpL5p6vHHpnCyfHlBwsNXrnY0EKBwAXD3TIIKF7RHDde5ALJapTsV
         Sj5cylNIoGJgrz6V0+zLPaxK2VKvcKnzhTDk7xjVIbdNsFt2ub6d4KmmCYFH8uFMjAxZ
         gRygHLiV/nwso6zawriYP/ykSHnmt5ehvZv/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ergCaURol2Se4ESlok/cft+LAqO2WAQPcTbIx100RWc=;
        b=GKzaYPWjsrAHCTdSLwRSKFKu9CdyMMFiHiY3G1a9vnzi3pES4l/ojYxLOhGFguyd/N
         Lukcl4KgGMcvOfznJh4sqDmZMLBuSnCkI1pCNYlDtEO5YEO6INtU8paZtNb1jK2xHOQU
         mRRdN9GnVeouovTNuTfKlzfRaeVQtoQqoOBaIIf9llP9rqhNE8oFQkAVbvfO263NvZhC
         6P3fhLpITbc3tg7u9ZWYv2jk0yMV3H6yByFXFczCvXmjv4sadcCQsiuuM2Sy9p6Z3Vk8
         H5YOXfaTTErziNgCFJmDp9kv0mngNCSS6VcdSN2oNMsTTQkKQ2aqt9cA0HvSKDwH/aE4
         scVw==
X-Gm-Message-State: APzg51DkKrkGQ7/uAMnpxbtCXboB369ISYZ3jJzFc95WZM/Id40JkHlO
        JxAOhkfBCqYPSP8fCqilDHhsbA==
X-Google-Smtp-Source: ANB0VdbbBUvITlsGQw04pON88OttwgF18SVomPTr6G7Ht2mjEoJepTKoE/ohUks5WFt7+j6N8ntKKw==
X-Received: by 2002:a63:4306:: with SMTP id q6-v6mr7371908pga.181.1535617326234;
        Thu, 30 Aug 2018 01:22:06 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id j22-v6sm8224885pfh.45.2018.08.30.01.22.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 30 Aug 2018 01:22:05 -0700 (PDT)
From:   Chunyan Zhang <zhang.chunyan@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Billows Wu <billows.wu@unisoc.com>,
        Jason Wu <jason.wu@unisoc.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH V8 2/9] mmc: sdhci: Add sd host v4 mode
Date:   Thu, 30 Aug 2018 16:21:38 +0800
Message-Id: <1535617305-16952-3-git-send-email-zhang.chunyan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535617305-16952-1-git-send-email-zhang.chunyan@linaro.org>
References: <1535617305-16952-1-git-send-email-zhang.chunyan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For SD host controller version 4.00 or later ones, there're two
modes of implementation - Version 3.00 compatible mode or
Version 4 mode.  This patch introduced an interface to enable
v4 mode.

Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 29 +++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci.h |  3 +++
 2 files changed, 32 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 01bf88c..0c61105 100644
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
@@ -3378,6 +3404,9 @@ void __sdhci_read_caps(struct sdhci_host *host, u16 *ver, u32 *caps, u32 *caps1)
 
 	sdhci_do_reset(host, SDHCI_RESET_ALL);
 
+	if (host->v4_mode)
+		sdhci_do_enable_v4_mode(host);
+
 	of_property_read_u64(mmc_dev(host->mmc)->of_node,
 			     "sdhci-caps-mask", &dt_caps_mask);
 	of_property_read_u64(mmc_dev(host->mmc)->of_node,
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index dbd48a8..61611e3 100644
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
@@ -752,6 +754,7 @@ bool sdhci_cqe_irq(struct sdhci_host *host, u32 intmask, int *cmd_error,
 		   int *data_error);
 
 void sdhci_dumpregs(struct sdhci_host *host);
+void sdhci_enable_v4_mode(struct sdhci_host *host);
 
 void sdhci_start_tuning(struct sdhci_host *host);
 void sdhci_end_tuning(struct sdhci_host *host);
-- 
2.7.4

