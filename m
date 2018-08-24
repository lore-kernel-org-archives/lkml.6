Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7365FC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 09:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2375320676
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 09:21:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="cxqy8bF4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2375320676
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbeHXMyq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 08:54:46 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46109 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbeHXMyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 08:54:45 -0400
Received: by mail-pf1-f193.google.com with SMTP id u24-v6so4252393pfn.13
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 02:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vGFW0eksYTgAicHNEinOVTwkCq1QSfxHTkyhgrrD8X0=;
        b=cxqy8bF4frF/YyPA7ZMy11XROdwuJUAytF1f546o4eP/E87a262731O8XyfvKfwWOU
         bV86wioiIhKP8hF1CTAfgDrUjHXdsFAUw5aeRCJBKJwjZPJn/zVBSAJxFsvbnzdtJIHq
         5NgTJ77HP4yI5DukUy8XHZZeJoTP03agdCXnY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vGFW0eksYTgAicHNEinOVTwkCq1QSfxHTkyhgrrD8X0=;
        b=EMQqJDTS4jHcymCfg1LC5buQJoQHTuKPdAxc9dsx/gd/NQTc8+0vLf6g9X3E/VGygJ
         IrtkQQFWKvPYQYsxQZyWWk0f0aLCURFIQsp4u1gT5Z5k4TBg7UIVAUj9W3Z/YhdmsOVo
         W+QTHb/H9W0s1xGpJLuwnDd2+t0/6IzvOImjl2kFWs7SZqOliyLv25toM1ak/UrAPLyR
         0owA8+jTquG2eJe6p3y3FU0UDinJO/wcM6+SSClAXtZK9I441fwUX8rmGNZeuY2mBekJ
         cHyKzmHExmlNO5uFxbWoAMv60BX1LG4dpUuD/a5Bf7RIDQqfJjWTlyIZ8HhGeUypME2v
         TAiA==
X-Gm-Message-State: APzg51DMCnLvw/VBujw5HHoMg+yQtRTLQ8HumcTWkyEydt1nBz8OwMmO
        9KSUMXlgcU/Je+iA/hPtk6mTyg==
X-Google-Smtp-Source: ANB0VdbhVdFbMEIV4G1xiXT0rVpet9otrL/gHhOBBDdgos8A1OsBQp/DhuSF+u9Tl26wf4sq8b2KdA==
X-Received: by 2002:a63:d946:: with SMTP id e6-v6mr910039pgj.24.1535102458765;
        Fri, 24 Aug 2018 02:20:58 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id g6-v6sm9520314pfb.11.2018.08.24.02.20.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 24 Aug 2018 02:20:57 -0700 (PDT)
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
Subject: [PATCH V6 2/9] mmc: sdhci: Add sd host v4 mode
Date:   Fri, 24 Aug 2018 17:20:21 +0800
Message-Id: <1535102428-20332-3-git-send-email-zhang.chunyan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535102428-20332-1-git-send-email-zhang.chunyan@linaro.org>
References: <1535102428-20332-1-git-send-email-zhang.chunyan@linaro.org>
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
index f70135c..a50842c 100644
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
@@ -3371,6 +3397,9 @@ void __sdhci_read_caps(struct sdhci_host *host, u16 *ver, u32 *caps, u32 *caps1)
 
 	sdhci_do_reset(host, SDHCI_RESET_ALL);
 
+	if (host->v4_mode)
+		sdhci_do_enable_v4_mode(host);
+
 	of_property_read_u64(mmc_dev(host->mmc)->of_node,
 			     "sdhci-caps-mask", &dt_caps_mask);
 	of_property_read_u64(mmc_dev(host->mmc)->of_node,
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 7ae95f8..131d869 100644
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
@@ -751,5 +753,6 @@ bool sdhci_cqe_irq(struct sdhci_host *host, u32 intmask, int *cmd_error,
 		   int *data_error);
 
 void sdhci_dumpregs(struct sdhci_host *host);
+void sdhci_enable_v4_mode(struct sdhci_host *host);
 
 #endif /* __SDHCI_HW_H */
-- 
2.7.4

