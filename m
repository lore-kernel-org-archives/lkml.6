Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA90C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 08:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 294CE21480
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 08:20:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bLj/nD3r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 294CE21480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389927AbeHPLQ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 07:16:59 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:32841 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388202AbeHPLQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 07:16:59 -0400
Received: by mail-pf1-f193.google.com with SMTP id d4-v6so1694045pfn.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 01:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V0eY6+fmzUQEUNfRvyKK9lRfPheki8Rb1IGP5PMneFw=;
        b=bLj/nD3rp1RfeE5UYgimzR2WHJE4fpT+zsTYAZzvev6SFAh5luFtsamINuMnkG3bzt
         F1hs2F+zI5h9xxtTWtFyRJUUKdI6ni5zwKAwG7tZ8d7QawZHHkFE9EsZgK1uYZEi4jAG
         fERG9oaC+Df0T77lhlZ239cqWPGgCZ9ao1z7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V0eY6+fmzUQEUNfRvyKK9lRfPheki8Rb1IGP5PMneFw=;
        b=C2m3/oU4bZlwSBfYz179lzimKHumjz5PcmjJV3o9wnU/y6tboS1dqCbwXdPxMNTDzn
         N8kTnZJaoU4xRsa8foNKt0XgaQiQauhoJkjo2ycKkeiz1YpQcChWd8Qbp+8h6jkYd2fn
         iQlVHogBdHor3FO9/u7Jm0qT3NlSUYb44XQquSt2lVbK7u0335ZijzVcZPNgdnOxk2za
         FpTrg9XQJABVqluVcyelljnXffWLhHzK+SHUGhqVPelqtZXiS38U9vmuY1hWPBqe7GWJ
         cmTl8I9Be+v1Ik2m+9UToqUTAe0/a/NabqPstWIMXXzM0JxYxC7RX6HwqRnnt9paGL4+
         j/GA==
X-Gm-Message-State: AOUpUlHNePngKNxGKjoYLk2ZUosMbFPU7yB33ur9p6vvohLwoolzFweT
        g9n5tbckW0HMSgsrN8fFsLonhA==
X-Google-Smtp-Source: AA+uWPwQ1ZE1VFgpIoXQnLQtOmMZJXkR/CnoEHly2rXLDIeAI6qaR0XYRnGr3ViCSg8Yci3eaA7ArQ==
X-Received: by 2002:a63:b504:: with SMTP id y4-v6mr28595656pge.247.1534407609928;
        Thu, 16 Aug 2018 01:20:09 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id s66-v6sm24406279pgc.67.2018.08.16.01.20.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 16 Aug 2018 01:20:08 -0700 (PDT)
From:   Chunyan Zhang <zhang.chunyan@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Billows Wu <billows.wu@unisoc.com>,
        Jason Wu <jason.wu@unisoc.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH V5 06/10] mmc: sdhci: Disable auto-CMD23 if stuff bits is set in CMD23 argument
Date:   Thu, 16 Aug 2018 16:19:56 +0800
Message-Id: <1534407596-29696-1-git-send-email-zhang.chunyan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534406064-10065-7-git-send-email-zhang.chunyan@linaro.org>
References: <1534406064-10065-7-git-send-email-zhang.chunyan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For version 4.10 and aboves, SDHCI_ARGUMENT2 is also used to indicate
32-bit number of blocks, so it doesn't support stuff bits in argument
of CMD23, but only block count for the following command (CMD18/25).

Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
---
 drivers/mmc/host/sdhci.c | 10 ++++++++++
 drivers/mmc/host/sdhci.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index b3328ee..04e0904 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1729,6 +1729,16 @@ static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 		}
 	}
 
+	/*
+	 * From version 4.10 onward, ARGUMENT2 register is also used as 32-bit
+	 * block count register which doesn't support stuff bits of
+	 * CMD23 argument.
+	 */
+	if (host->version >= SDHCI_SPEC_410 &&
+	    mrq->sbc && (mrq->sbc->arg & SDHCI_ARG2_STUFF) &&
+	    (host->flags & SDHCI_AUTO_CMD23))
+		host->flags &= ~SDHCI_AUTO_CMD23;
+
 	if (!present || host->flags & SDHCI_DEVICE_DEAD) {
 		mrq->cmd->error = -ENOMEDIUM;
 		sdhci_finish_mrq(host, mrq);
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index d34971ac..daf8c1e 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -28,6 +28,7 @@
 
 #define SDHCI_DMA_ADDRESS	0x00
 #define SDHCI_ARGUMENT2		SDHCI_DMA_ADDRESS
+#define  SDHCI_ARG2_STUFF	GENMASK(31, 16)
 #define SDHCI_32BIT_BLK_CNT	SDHCI_DMA_ADDRESS
 
 #define SDHCI_BLOCK_SIZE	0x04
-- 
2.7.4

