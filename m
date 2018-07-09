Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 870C4C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 03:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43072208DF
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 03:21:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SnDeB14O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43072208DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933207AbeGIDVP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 23:21:15 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:35073 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933040AbeGIDVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 23:21:13 -0400
Received: by mail-pl0-f68.google.com with SMTP id k1-v6so5347610plt.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jul 2018 20:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=m8EGOwYzbAaIOxZaEvnUYFUSYffN46UUlc+QT9vs7J0=;
        b=SnDeB14O4ouu5FqBo7ZA6JwLGffg1pBsdrCcsOZKb+5AUdmAmtItFbIWWm1ARuQy+0
         Y+JwbECOQRn8SikMb7kBQtTxuJFuGs33ZLQ5yrEWWVuFg8lGD53ncXevzAiHwO59483l
         280KN37WNutY8dBL7Cci/QzL3X8gHXTQkXZ7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=m8EGOwYzbAaIOxZaEvnUYFUSYffN46UUlc+QT9vs7J0=;
        b=VuJ79QItoZ5daLfXaT6V+N6zaf50VPs4O56qRflDSAcpObNcAqV66sqhYN91zT6ISK
         95vq4f+ghmNH9OivDyrsN7jlo3YQc1jGuofqOJ5JBeHQgYxsv8pOlvPk1ilzW30ZcqmR
         SX+yzxZBeR+/NYeUEkjb4siWco1dcGeCrQWm5ZcSudjMvC5EyRMjnIm7GMMkonMiIMay
         sLEvy0JVcd9x6s40Bj75txlt4qH2xDZJCfUwpwbxgPrROciWej8vcMtI9Kpopvqpe35I
         AnYl251sKfTLoRL3CrwgM6tLnatEUijBkpNvwHrmC4FcpBN4onBM2UV0CUu/ypTAu5f/
         dGHA==
X-Gm-Message-State: APt69E2VpMLtxEq4wd4vkzGTVc3fj1JWrwqt8xkgDokjtCkPyXVVmzoW
        xjBSuNUC5bgWGawzAyNkJMmbwA==
X-Google-Smtp-Source: AAOMgpcvIZqF1XmIZ2qrJ5YamTpfMyvmW08M/BfvtGwM9KhW0Q8A8R/0+QbZ1ytyo96XFazHgT080A==
X-Received: by 2002:a17:902:294a:: with SMTP id g68-v6mr19351024plb.58.1531106473171;
        Sun, 08 Jul 2018 20:21:13 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id e82-v6sm41458950pfk.87.2018.07.08.20.20.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 08 Jul 2018 20:21:12 -0700 (PDT)
From:   Chunyan Zhang <zhang.chunyan@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Billows Wu <billows.wu@spreadtrum.com>, zhang.lyra@gmail.com
Subject: [PATCH V3 1/7] mmc: sdhci: add sd host v4 mode
Date:   Mon,  9 Jul 2018 11:19:52 +0800
Message-Id: <1531106398-14062-2-git-send-email-zhang.chunyan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531106398-14062-1-git-send-email-zhang.chunyan@linaro.org>
References: <1531106398-14062-1-git-send-email-zhang.chunyan@linaro.org>
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
 drivers/mmc/host/sdhci.c | 11 +++++++++++
 drivers/mmc/host/sdhci.h |  5 +++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 1c828e0..525862f 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3321,6 +3321,17 @@ struct sdhci_host *sdhci_alloc_host(struct device *dev,
 
 EXPORT_SYMBOL_GPL(sdhci_alloc_host);
 
+/*
+ * Vendor's Host Controller which supports v4 mode can call
+ * this function to enable v4 mode before calling
+ * __sdhci_add_host().
+ */
+void sdhci_enable_v4_mode(struct sdhci_host *host)
+{
+	host->v4_mode = true;
+}
+EXPORT_SYMBOL_GPL(sdhci_enable_v4_mode);
+
 static int sdhci_set_dma_mask(struct sdhci_host *host)
 {
 	struct mmc_host *mmc = host->mmc;
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 23966f8..e98249b 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -184,6 +184,7 @@
 #define   SDHCI_CTRL_DRV_TYPE_D		0x0030
 #define  SDHCI_CTRL_EXEC_TUNING		0x0040
 #define  SDHCI_CTRL_TUNED_CLK		0x0080
+#define  SDHCI_CTRL_V4_MODE		0x1000
 #define  SDHCI_CTRL_PRESET_VAL_ENABLE	0x8000
 
 #define SDHCI_CAPABILITIES	0x40
@@ -566,6 +567,9 @@ struct sdhci_host {
 	u64			data_timeout;
 
 	unsigned long private[0] ____cacheline_aligned;
+
+	/* Host Version 4 Enable */
+	bool			v4_mode;
 };
 
 struct sdhci_ops {
@@ -747,5 +751,6 @@ bool sdhci_cqe_irq(struct sdhci_host *host, u32 intmask, int *cmd_error,
 		   int *data_error);
 
 void sdhci_dumpregs(struct sdhci_host *host);
+void sdhci_enable_v4_mode(struct sdhci_host *host);
 
 #endif /* __SDHCI_HW_H */
-- 
2.7.4

