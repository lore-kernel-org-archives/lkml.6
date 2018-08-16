Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97535C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 07:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54A56214D5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 07:55:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="da46NtEU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54A56214D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389680AbeHPKwd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 06:52:33 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39113 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389650AbeHPKwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 06:52:32 -0400
Received: by mail-pg1-f196.google.com with SMTP id a11-v6so1686416pgw.6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 00:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SEBlkogmEohz2U3nc5fI7y654TSOo9JJM7mLC82YFnA=;
        b=da46NtEU5Ug4Om6wZtWuQHwd+hFF2zllHKs+JbYzsDUlbBfD0xGlpAhZf3CM3ZA5x/
         +4VSvJ9xt1t5xOgkBwQ8atBx50t44vVkq+hRsOS1eLcbyjXhStvdLGuIrmee0HFgmhOG
         /VJllXsKy0CVv3XGxjujRG0vKJxMwhtkg+fqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SEBlkogmEohz2U3nc5fI7y654TSOo9JJM7mLC82YFnA=;
        b=ss9jpua7krjNNZrcIgvGcXzUdDas1nEslCHMC7K2cRYWhvyiY3V4N4ssgLMDHx+Ujj
         TVNP2XUXErxadxdZWEIZ2F6XHOF0bWymlqnBfEcvBDawX/WboCakz1jS9AGHeSXmx85y
         2s3Go1BjqNJfqIqhFSGm+egEyRl+Sn4iildkb1XseThuMow6JEdg3XHLXqjbRUeMEtrX
         BTG1T3QgPrJfXj/ghGazPZ5A6e4/LuoiQi4jC+GDSMPjDoYN7IpADhaHREKkGcQqRX6J
         S40iHmZMAzTyCMJMym4CJdX85+9HpUVnZaRQgdusK1aC6/qaf9zr52V4rqb587/idDEX
         8zuQ==
X-Gm-Message-State: AOUpUlGsmNgR8mMouy9xExXUFXALFzGKYdgcSG17Uq8Q6FbcM0FA9Zt9
        nutSaYLlmfOt8C2hRa+ubgerpg==
X-Google-Smtp-Source: AA+uWPzlcbT5agAYfCTKx4r1YANXlQE/rtCgPp31mzV7469q6rKMW2SDKCL2xzPnKPDG3nTILu9HIA==
X-Received: by 2002:a63:28c1:: with SMTP id o184-v6mr27929422pgo.225.1534406151671;
        Thu, 16 Aug 2018 00:55:51 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id i25-v6sm50838137pfi.150.2018.08.16.00.55.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 16 Aug 2018 00:55:50 -0700 (PDT)
From:   Chunyan Zhang <zhang.chunyan@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Billows Wu <billows.wu@unisoc.com>,
        Jason Wu <jason.wu@unisoc.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH V5 08/10] mmc: sdhci: SDMA may use Auto-CMD23 in v4 mode
Date:   Thu, 16 Aug 2018 15:54:22 +0800
Message-Id: <1534406064-10065-9-git-send-email-zhang.chunyan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534406064-10065-1-git-send-email-zhang.chunyan@linaro.org>
References: <1534406064-10065-1-git-send-email-zhang.chunyan@linaro.org>
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
index 06c2ae9..4e375ba 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3851,10 +3851,14 @@ int sdhci_setup_host(struct sdhci_host *host)
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

