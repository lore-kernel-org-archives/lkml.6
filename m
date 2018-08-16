Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1585FC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 07:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6EA0214C5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 07:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eujLU0C4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6EA0214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389561AbeHPKwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 06:52:03 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37784 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389543AbeHPKwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 06:52:03 -0400
Received: by mail-pg1-f196.google.com with SMTP id n7-v6so1690418pgq.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 00:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GsEzQ7lSqbmfxpWd258e2/q3aWNtngoojSJwB6WE4qw=;
        b=eujLU0C4+JUe/hyhRoQ5nTiOaYS1e29W4GzEUIREvLlyapwKrqbuSiIogff2g1m2zx
         TUeuQ3gz9UPGej9JO3AUWvbMmeE8kr+9ZHODhh8M2gkgaV3H39aDOCtRv6H+6dni01wX
         o92F0bEtJ/O0376BjbiEGphmyPsohCiedh0ug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GsEzQ7lSqbmfxpWd258e2/q3aWNtngoojSJwB6WE4qw=;
        b=qP5xaCsjC7BLFBx60WTOOixKSOyhSqF2Juf04WyqOHpGEy7QRe1HX2CaHPVcTG+auJ
         uoXNZ3MZAU9jB4MBDwyLpac1ql2pa61HBcNOnzAkwtZiifA1uhyj7UfblRhs9b2yBYOC
         wirKGG8ySYpGz5q9vubNQnAEfbmcnJr7b730V0GP52MJtOgp1M4sU6r6oxmtT0Wxa6Qv
         ZtG38At7eG21FbXYe2zREDT1qCDm8DMBKr22bRzOPzTjphWn7R6cse3FHbB9VS0mKzX2
         lhNqPbGdhe9RinxggnH6AL/RpFydfBLb5FSXRAKK4XfImHljchxSo8M3T5d5U8fwwFpt
         wCCw==
X-Gm-Message-State: AOUpUlFopwUabqCujz8VcqR/ZYYSyoatwe7uSkcOEst1Ppja/sNxOVI6
        nXIYI2/NqXvjmxVerpsJHc23HA==
X-Google-Smtp-Source: AA+uWPxHyKcVAzZjQQXbBhQm8Ucesos9++ExYYouP3dtFJGHH17KKNQwtDKCODl6u+8Vfnle3TzKpw==
X-Received: by 2002:a62:c0c4:: with SMTP id g65-v6mr30849687pfk.72.1534406122151;
        Thu, 16 Aug 2018 00:55:22 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id i25-v6sm50838137pfi.150.2018.08.16.00.55.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 16 Aug 2018 00:55:21 -0700 (PDT)
From:   Chunyan Zhang <zhang.chunyan@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Billows Wu <billows.wu@unisoc.com>,
        Jason Wu <jason.wu@unisoc.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH V5 01/10] mmc: sdhci: Add version V4 definition
Date:   Thu, 16 Aug 2018 15:54:15 +0800
Message-Id: <1534406064-10065-2-git-send-email-zhang.chunyan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534406064-10065-1-git-send-email-zhang.chunyan@linaro.org>
References: <1534406064-10065-1-git-send-email-zhang.chunyan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added definitions for v400, v410, v420.

Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
---
 drivers/mmc/host/sdhci.c | 2 +-
 drivers/mmc/host/sdhci.h | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 1c828e0..ca04834 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3500,7 +3500,7 @@ int sdhci_setup_host(struct sdhci_host *host)
 
 	override_timeout_clk = host->timeout_clk;
 
-	if (host->version > SDHCI_SPEC_300) {
+	if (host->version > SDHCI_SPEC_420) {
 		pr_err("%s: Unknown controller version (%d). You may experience problems.\n",
 		       mmc_hostname(mmc), host->version);
 	}
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 23966f8..31c865e 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -270,6 +270,9 @@
 #define   SDHCI_SPEC_100	0
 #define   SDHCI_SPEC_200	1
 #define   SDHCI_SPEC_300	2
+#define   SDHCI_SPEC_400	3
+#define   SDHCI_SPEC_410	4
+#define   SDHCI_SPEC_420	5
 
 /*
  * End of controller registers.
-- 
2.7.4

