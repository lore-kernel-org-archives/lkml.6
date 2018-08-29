Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D119C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 552A52086B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BOj+JRQH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 552A52086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbeH2K6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 06:58:43 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42606 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727625AbeH2K6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 06:58:42 -0400
Received: by mail-pl1-f196.google.com with SMTP id g23-v6so1880038plq.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 00:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=++1fRQNMnXH0A0SYZtvAp1/7snJJJbIXHOql7gVNj04=;
        b=BOj+JRQH3cjH6wss3IOQ35mX1jeAxamz9/uZJmdsbxWmm8KX/Rp3UoDa1j1JhJRtmq
         3NEjRJjtNz6LmV4aE689SdAkmmOZ6AUknrsB0demBYZRj3AF5mzdXvaRRaYk9dVkjhdH
         ExNN38rlF0LpYG3eCiIpXP/GnYUrpuIag7HeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=++1fRQNMnXH0A0SYZtvAp1/7snJJJbIXHOql7gVNj04=;
        b=SMo8Y8fHR4S785VK5819o8J8RaGMqNy9gdj0FM0FW+ojr+4B4BkltkFl4XucJKTKbx
         Qx/RT4Ehx6eeFbHraaA5P/njH/9D8PQc6ehkPScr5EOYMSlRKmqBtLw0nC+xQN3TBI2J
         Jam4Yfckb0AtkJDC09daq2H2wdiIdFM55D0A/ub0PAwQWTPKG5j1z926Yse4ehccUYAd
         8oT5B+K/9PCbhFrDT9NHmeOyTvBlHTzSC1SkvgAZgBG2FaTSC+WrFthCWc/jg8zlQISv
         WiO80JH4lAlErh2MvkXARbUynvCdMLmpVLoUwX9PdSyoj0j5Ox1SxfwEaoEjzScxmffw
         p0XQ==
X-Gm-Message-State: APzg51B4W8cuRd1UkC0C2VihQbXxTT65//VAiMQhjdDVswMBNfmvs3oe
        lhqBcSQvpKvCEC+CwwPAYqHI0Q==
X-Google-Smtp-Source: ANB0VdYfwop77x7SvQssysqKAm1fS3YxqyDxo4rrsvM/3Mc1e09RyFk0HbhXniSmJycGnccSk8uoUg==
X-Received: by 2002:a17:902:1ab:: with SMTP id b40-v6mr4825100plb.55.1535526197764;
        Wed, 29 Aug 2018 00:03:17 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id d81-v6sm4317342pfj.122.2018.08.29.00.03.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 Aug 2018 00:03:16 -0700 (PDT)
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
Subject: [PATCH V7 1/9] mmc: sdhci: Add version V4 definition
Date:   Wed, 29 Aug 2018 15:02:56 +0800
Message-Id: <1535526184-32718-2-git-send-email-zhang.chunyan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535526184-32718-1-git-send-email-zhang.chunyan@linaro.org>
References: <1535526184-32718-1-git-send-email-zhang.chunyan@linaro.org>
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

