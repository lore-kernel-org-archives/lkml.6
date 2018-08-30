Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 441D4C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 08:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0BA72082B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 08:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="d7VvPGC+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0BA72082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbeH3MXA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 08:23:00 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45125 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727863AbeH3MW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 08:22:59 -0400
Received: by mail-pg1-f196.google.com with SMTP id m4-v6so3551701pgv.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 01:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wnkKMmT7/ywpaLhHSygUL9Mw6DLIQeVe394xHakWOIg=;
        b=d7VvPGC+1/HFqHyXuQoPiiW4fbwXzmA9LJvbwgHtrqQ8Km2dkiskXqyIxGTQm3HvvG
         F1x7ra2bE2P5ghqL+fb4c6IjrH6uznBqc6GDRvoUQMC+LjFCpZB8667VUCVdGRa4nlIs
         EV4Vo1iM5oWZYMzPqEBhGDFaXTYbR0DJ4iLhA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wnkKMmT7/ywpaLhHSygUL9Mw6DLIQeVe394xHakWOIg=;
        b=pkZhuv3nB4Rucj9rTM7NBwAoEHdM/EUYDDh1ybeD+vnmc8Ri6sD8FKIUI7N2bMOFqn
         73kg4VX29nluElTaN+XOnbHfI60/BtT6H+9VnZluhHkkLmLEGDCr3yKXQbXBDD9Pky4n
         UL27qly4X7CcGsylgiQ/PXRvMw8bgQYQeXucdXJ0bwRNR3aVb+6DTnYg7AcNk/azvxJx
         lha2LSjz3iw15mXh68o/f6SzTWNHHOPA0u9zq+6hj8re2dmc9PrKDYK/U20gkEUGprwq
         GxBfmQJCzqTZxKzPDqsA8h0dvYQQec+u6xkzxfe5Z4mirR/tGs0UdPW5Wyd0Q9GUDhNE
         MH7w==
X-Gm-Message-State: APzg51CmdcTjNPmNw9AvU+NENjlAf0UZ+iC+M3k9fi78q3C8YBqbn4Xn
        CeFe+6J6D7DTq18h6w6gSLsttg==
X-Google-Smtp-Source: ANB0VdbXykipFodsw0jNezTJBSLoZ0ll9H3eHa7+RBePHthnLdb9xicZU8tPQqt6fFu4QOTRloFaeA==
X-Received: by 2002:a63:5815:: with SMTP id m21-v6mr8742255pgb.78.1535617321554;
        Thu, 30 Aug 2018 01:22:01 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id j22-v6sm8224885pfh.45.2018.08.30.01.21.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 30 Aug 2018 01:22:00 -0700 (PDT)
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
Subject: [PATCH V8 1/9] mmc: sdhci: Add version V4 definition
Date:   Thu, 30 Aug 2018 16:21:37 +0800
Message-Id: <1535617305-16952-2-git-send-email-zhang.chunyan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535617305-16952-1-git-send-email-zhang.chunyan@linaro.org>
References: <1535617305-16952-1-git-send-email-zhang.chunyan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added definitions for v400, v410, v420.

Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/host/sdhci.c | 2 +-
 drivers/mmc/host/sdhci.h | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 97e4efa..01bf88c 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3508,7 +3508,7 @@ int sdhci_setup_host(struct sdhci_host *host)
 
 	override_timeout_clk = host->timeout_clk;
 
-	if (host->version > SDHCI_SPEC_300) {
+	if (host->version > SDHCI_SPEC_420) {
 		pr_err("%s: Unknown controller version (%d). You may experience problems.\n",
 		       mmc_hostname(mmc), host->version);
 	}
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 732d82f..dbd48a8 100644
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

