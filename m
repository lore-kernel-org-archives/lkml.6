Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 307D1C5CFC0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 02:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5CD3208AF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 02:04:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HW9zZO7h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5CD3208AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965418AbeFOCEt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 22:04:49 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:44124 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965317AbeFOCEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 22:04:46 -0400
Received: by mail-pl0-f68.google.com with SMTP id z9-v6so4524435plk.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 19:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3FkQjw0tnznQzkqhNl9915wjCXW19DdBddES+/u0pdI=;
        b=HW9zZO7hejz4TlVe51+27U2fh7I5Dalfh8DeArj+79MNzXuIuQKK5UVBqsy5zGzGnN
         +ld7wC66ouHlRr0BQqIyEeThpwkxG+A0PMhLIkQ9ZXo6AkdXw8xJRi3X0bpZy0oR2Fyn
         Cm0gerReU3XWKqHLfnkAux0dDXy8USsYuZwl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3FkQjw0tnznQzkqhNl9915wjCXW19DdBddES+/u0pdI=;
        b=LS1mUEJr5VhYYXIMhdv4dO7EPWSZwdtj+JHlc3ydHogicAsrD0N9o6W+pp3eNKnMgc
         kbM5e6D7ld1fTn0iqnWgNMRhp6K4E9Huras5AHVw/rJRJ/quzfW/77uBU1F8TKJVy5yQ
         5bZ3ituKLvOUdOtdkH84RySlKsw/Sghg8aGDNBRXDXOUlJFx1ObwZBlK5NQbOo+M7WFw
         1lj6BawLcf5FdEv8h/9aJCgVyDYH4lJbQCQv/qhnSx3pxfoLdPJGD28MtZ84GQHOLDC5
         I03uJ52Ln+yeL7X5gg4YIQ18cMYfoENkx/vO3fJjNXiXUrZVDZypy0lPrrQ8LXe0cDPB
         e3KA==
X-Gm-Message-State: APt69E00HM/JJZNxj2jeVhoEWOXpkB9tqpiAYRHU4aG5SVXMoGFVp//N
        MFCvPWJGgYk00EL0FYMJvs2OFA==
X-Google-Smtp-Source: ADUXVKKaCGsR6vcY1oFH2LGwVuyJlxvnQIl5CQosV3hG+22Y4qWGZNQo/AT05p/En4elcHTmpZ66Og==
X-Received: by 2002:a17:902:4203:: with SMTP id g3-v6mr5588112pld.315.1529028286198;
        Thu, 14 Jun 2018 19:04:46 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id k69-v6sm9504953pgc.39.2018.06.14.19.04.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 14 Jun 2018 19:04:45 -0700 (PDT)
From:   Chunyan Zhang <zhang.chunyan@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Billows Wu <billows.wu@spreadtrum.com>, zhang.lyra@gmail.com
Subject: [PATCH V2 1/7] mmc: sdhci: add sd host v4 mode
Date:   Fri, 15 Jun 2018 10:04:09 +0800
Message-Id: <1529028255-6022-2-git-send-email-zhang.chunyan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529028255-6022-1-git-send-email-zhang.chunyan@linaro.org>
References: <1529028255-6022-1-git-send-email-zhang.chunyan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For SD host controller version 4.00 or later ones, there're two
modes of implementation - Version 3.00 compatible mode or
Version 4 mode.  This patch introduces a flag to record this.

Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
---
 drivers/mmc/host/sdhci.c | 6 ++++++
 drivers/mmc/host/sdhci.h | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 2ededa7f..cf5695f 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3302,6 +3302,12 @@ void __sdhci_read_caps(struct sdhci_host *host, u16 *ver, u32 *caps, u32 *caps1)
 	v = ver ? *ver : sdhci_readw(host, SDHCI_HOST_VERSION);
 	host->version = (v & SDHCI_SPEC_VER_MASK) >> SDHCI_SPEC_VER_SHIFT;
 
+	if (host->version >= SDHCI_SPEC_400) {
+		if (sdhci_readw(host, SDHCI_HOST_CONTROL2) &
+			SDHCI_CTRL_V4_MODE)
+			host->v4_mode = true;
+	}
+
 	if (host->quirks & SDHCI_QUIRK_MISSING_CAPS)
 		return;
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index c95b0a4..128b0ba 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -184,6 +184,7 @@
 #define   SDHCI_CTRL_DRV_TYPE_D		0x0030
 #define  SDHCI_CTRL_EXEC_TUNING		0x0040
 #define  SDHCI_CTRL_TUNED_CLK		0x0080
+#define  SDHCI_CTRL_V4_MODE		0x1000
 #define  SDHCI_CTRL_PRESET_VAL_ENABLE	0x8000
 
 #define SDHCI_CAPABILITIES	0x40
@@ -270,6 +271,8 @@
 #define   SDHCI_SPEC_100	0
 #define   SDHCI_SPEC_200	1
 #define   SDHCI_SPEC_300	2
+#define   SDHCI_SPEC_400	3
+#define   SDHCI_SPEC_410	4
 
 /*
  * End of controller registers.
@@ -551,6 +554,9 @@ struct sdhci_host {
 	u32			sdma_boundary;
 
 	unsigned long private[0] ____cacheline_aligned;
+
+	/* Host Version 4 Enable */
+	bool			v4_mode;
 };
 
 struct sdhci_ops {
-- 
2.7.4

