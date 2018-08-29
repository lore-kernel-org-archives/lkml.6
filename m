Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E95C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D3912089B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FTt8+uiI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D3912089B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbeH2K7K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 06:59:10 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37307 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727785AbeH2K7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 06:59:09 -0400
Received: by mail-pl1-f193.google.com with SMTP id d12-v6so1893802pls.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 00:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F6JNjnqOBxraoAmJ2G9nQq3A9aaEWZWPodCkmFELEA4=;
        b=FTt8+uiIDtMNr76i4SHHbEdmo3x0fQckM4/6nQz3cKegXczL/kS8xRQ86loF+ym1uP
         3Fpd5LHKwS30oEPpmqKE/5WBxvTynx6qm7zdYVXJzSnMnivIcq/YIMSSdvCqnFxpwflb
         ohKMYLCNY5PjsqLIsr49T3uTBongbaNEe/jJg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F6JNjnqOBxraoAmJ2G9nQq3A9aaEWZWPodCkmFELEA4=;
        b=UydP+YzQ4Agt3W67qlrekxq4/q9sasFw1w3btTTFHzcmbyp0JUGO4+jjuzyOrv0f05
         MaLd20NkklNibnDWkAtbao7GX7bBaHdRVgCqUkDt17c93Sp/ZKbKOtac883Z7lZ8QZKZ
         EhZ6jcKFPa96L/MolL+qwL8UeVeWM1Obmsg7l3uRsFMiL243ELLS0x/msKD71xh/MeIt
         U/xowuQ4PxexWVnNKonl9/BzsR7KutzFwHcwgatRi4sFXqC/nVcVAGbqQzWpVdFYybTK
         G+aM4wHaWU0tquew9kYsNmf02bFGsIpUKQM/5gxH6e4pJRS3SPUE8+y+oCDUoIQ/WhaF
         OXdw==
X-Gm-Message-State: APzg51Aiwfq/dsvwVCboYtMD1t1lJbRRvfOgQpJb7IO4DgH/1UJOSwz1
        jA1nAqB7aH/QYXjrkB4AI034UA==
X-Google-Smtp-Source: ANB0Vdb9jhj0ILPiroZ4dZvMX4HK1fY7gO+RlY8olSezD7WgLyIVb3OxW7/irkjFgdX7242wF/scqA==
X-Received: by 2002:a17:902:a987:: with SMTP id bh7-v6mr4834081plb.182.1535526224623;
        Wed, 29 Aug 2018 00:03:44 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id d81-v6sm4317342pfj.122.2018.08.29.00.03.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 Aug 2018 00:03:43 -0700 (PDT)
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
Subject: [PATCH V7 7/9] mmc: sdhci: SDMA may use Auto-CMD23 in v4 mode
Date:   Wed, 29 Aug 2018 15:03:02 +0800
Message-Id: <1535526184-32718-8-git-send-email-zhang.chunyan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535526184-32718-1-git-send-email-zhang.chunyan@linaro.org>
References: <1535526184-32718-1-git-send-email-zhang.chunyan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When Host Version 4 Enable is set to 1, SDMA uses ADMA System Address
register (05Fh-058h) instead of using register (000h-004h) to indicate
its system address of data location. The register (000h-004h) is
re-assigned to 32-bit Block Count and Auto CMD23 argument, so then SDMA
may use Auto CMD23.

Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
---
 drivers/mmc/host/sdhci.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 62d843ac90..ac92e0f 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3834,10 +3834,14 @@ int sdhci_setup_host(struct sdhci_host *host)
 	if (host->quirks & SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12)
 		host->flags |= SDHCI_AUTO_CMD12;
 
-	/* Auto-CMD23 stuff only works in ADMA or PIO. */
+	/*
+	 * For v3 mode, Auto-CMD23 stuff only works in ADMA or PIO;
+	 * For v4 mode, SDMA may use Auto-CMD23 as well.
+	 */
 	if ((host->version >= SDHCI_SPEC_300) &&
 	    ((host->flags & SDHCI_USE_ADMA) ||
-	     !(host->flags & SDHCI_USE_SDMA)) &&
+	     (!host->v4_mode && !(host->flags & SDHCI_USE_SDMA)) ||
+	     (host->v4_mode && (host->flags & SDHCI_USE_SDMA))) &&
 	     !(host->quirks2 & SDHCI_QUIRK2_ACMD23_BROKEN)) {
 		host->flags |= SDHCI_AUTO_CMD23;
 		DBG("Auto-CMD23 available\n");
-- 
2.7.4

