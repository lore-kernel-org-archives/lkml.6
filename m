Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F02BC43615
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 09:20:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34CD120676
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 09:20:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ABaxn2j6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34CD120676
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbeHXMyf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 08:54:35 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36656 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726842AbeHXMye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 08:54:34 -0400
Received: by mail-pl1-f195.google.com with SMTP id e11-v6so852464plb.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 02:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UBJImci8KZxRNTfmSw+GGOxU7hKy71vSboxL1xbPDzw=;
        b=ABaxn2j6d871/4FwgGuV1TemB+Sy+ByjCZoLtNYaOCY4r65N/0yqbPdRx4k7WA2VTx
         DiBxKmnrRFZvVdhWUJiJsDfnU8/6V5jp9EjHBuaUGH5iw6nKVxyLy9uI6Amvq6uu4t/J
         Ui9en7q0CdLA7oA8NkqgV8s8dNaFj2UWTF5uU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UBJImci8KZxRNTfmSw+GGOxU7hKy71vSboxL1xbPDzw=;
        b=XUOHsltBUvT1OLRsQGK81xUiSuG8cj5JWA316Kg71G7SrJVfDy5w6PnHyPBCIqWeNf
         WjsFL8LWowxK3r2weTAm4fIYavs6LRAIf4cDBNmbV4cmJR53WFfuVQ++nwni4MSLmqbz
         CMgyXU1LFNPVvzJgA2b1i/y6ags99O61xeTi1QsQoTlZxRSwoJHuYloF8djdbkMHO74s
         EO3PirJ5uBH6tIum6LPlupfQ2TY7eJoMidCt1/ucimDQnD0EsiWqFWStVCLOFw65xFd2
         IZG/T6phchRPKTVvA97n+B5FbwaelJL3TXjoVQvKur1cbXgY+v6R2ZiX87aa/LM0dx5v
         LUwQ==
X-Gm-Message-State: APzg51BVglWxlha+VGQl9Qg2y6PRq2DiCCV9qK92i1ua2pDHnjpb7E2c
        PmRiNO6hVRIVtmKBh9vEIHQK0g==
X-Google-Smtp-Source: ANB0VdbNtrXVU2u4R1AKvvO5pGnMVjFriIlqfCDBWqGF0ZWn8gBIGFz5Y6j5q4wkfvPUb98i+yEuMQ==
X-Received: by 2002:a17:902:7683:: with SMTP id m3-v6mr886597pll.255.1535102448934;
        Fri, 24 Aug 2018 02:20:48 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id g6-v6sm9520314pfb.11.2018.08.24.02.20.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 24 Aug 2018 02:20:48 -0700 (PDT)
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
Subject: [PATCH V6 1/9] mmc: sdhci: Add version V4 definition
Date:   Fri, 24 Aug 2018 17:20:20 +0800
Message-Id: <1535102428-20332-2-git-send-email-zhang.chunyan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535102428-20332-1-git-send-email-zhang.chunyan@linaro.org>
References: <1535102428-20332-1-git-send-email-zhang.chunyan@linaro.org>
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
index 8793340..f70135c 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3501,7 +3501,7 @@ int sdhci_setup_host(struct sdhci_host *host)
 
 	override_timeout_clk = host->timeout_clk;
 
-	if (host->version > SDHCI_SPEC_300) {
+	if (host->version > SDHCI_SPEC_420) {
 		pr_err("%s: Unknown controller version (%d). You may experience problems.\n",
 		       mmc_hostname(mmc), host->version);
 	}
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 5db81de..7ae95f8 100644
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

