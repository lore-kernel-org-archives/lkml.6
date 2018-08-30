Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CED3C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 08:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 307702082B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 08:22:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ci2esfNn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 307702082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbeH3MX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 08:23:28 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38981 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728068AbeH3MX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 08:23:27 -0400
Received: by mail-pg1-f193.google.com with SMTP id g20-v6so3565829pgv.6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 01:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ah8c1s4NQMeDLK8VDxuLb0Way+MTHYiFrnLMxjLrOic=;
        b=Ci2esfNnkrultBR2JC8oOpP8798ra5xy2lQVamINyr0vxNV8Va0QyFMobOXx5BrTzh
         6AYTQroAWBjY4/dEK9n5xbBTh1ejAtr+e3CihREeL95NRivmUT87sZVVp+HWAHO8tLJb
         gQM80n7RDnruyd9l43yPB0goqCGQYGKbd3n5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ah8c1s4NQMeDLK8VDxuLb0Way+MTHYiFrnLMxjLrOic=;
        b=liml2WMh12h40TF8sjpuPpoTFNwCjsIRoP2OHsyqDUq5wO7Y2MuZYLKT/4o9U2cZDH
         stESk/krcJyeUE36qLbh4iDkvKMBEFIlHG2gRI+ztaTsg12bBh4/bdHd0Ot3+9ikIgob
         rZinNp64dkU0UMaLMfEayqILP56bX0Do2VIZ6t8VeCScNI6TXPHePv91wA+dnF5LAc9h
         OF4kyG6ODn9MMDy/jzTTJUx2+wk9gBS29QJVSaOkRLzqFW0RGJwL06bo6ZTbsYDmSpKu
         HvFlkHv6iAj+2AjubpgIEyxw1gweUkvvwHTmCoWuSiXycYtqJSBfpKZadse6BP9313jx
         qgKQ==
X-Gm-Message-State: APzg51C2bcczmlcGMHFSmYnEMwQ6YRbkaE4OFY2vAKT1YXNi20wUKgjy
        blHuaPvPsJjQlx9RVbzcvK1s/A==
X-Google-Smtp-Source: ANB0VdZWBTJncpy1V6TzMRLY09UI0jsGKsfJJUJOENWY9BCVBqUYzIaws57rmTIUpRm0yRuyWySlqg==
X-Received: by 2002:aa7:88d3:: with SMTP id p19-v6mr9499481pfo.160.1535617349542;
        Thu, 30 Aug 2018 01:22:29 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id j22-v6sm8224885pfh.45.2018.08.30.01.22.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 30 Aug 2018 01:22:28 -0700 (PDT)
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
Subject: [PATCH V8 7/9] mmc: sdhci: SDMA may use Auto-CMD23 in v4 mode
Date:   Thu, 30 Aug 2018 16:21:43 +0800
Message-Id: <1535617305-16952-8-git-send-email-zhang.chunyan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535617305-16952-1-git-send-email-zhang.chunyan@linaro.org>
References: <1535617305-16952-1-git-send-email-zhang.chunyan@linaro.org>
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
 drivers/mmc/host/sdhci.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 62d843ac90..606d331 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3834,10 +3834,13 @@ int sdhci_setup_host(struct sdhci_host *host)
 	if (host->quirks & SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12)
 		host->flags |= SDHCI_AUTO_CMD12;
 
-	/* Auto-CMD23 stuff only works in ADMA or PIO. */
+	/*
+	 * For v3 mode, Auto-CMD23 stuff only works in ADMA or PIO.
+	 * For v4 mode, SDMA may use Auto-CMD23 as well.
+	 */
 	if ((host->version >= SDHCI_SPEC_300) &&
 	    ((host->flags & SDHCI_USE_ADMA) ||
-	     !(host->flags & SDHCI_USE_SDMA)) &&
+	     !(host->flags & SDHCI_USE_SDMA) || host->v4_mode) &&
 	     !(host->quirks2 & SDHCI_QUIRK2_ACMD23_BROKEN)) {
 		host->flags |= SDHCI_AUTO_CMD23;
 		DBG("Auto-CMD23 available\n");
-- 
2.7.4

