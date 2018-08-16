Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B2F4C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 07:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D32C6214C5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 07:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="iDGPLbmI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D32C6214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389648AbeHPKwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 06:52:24 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:45427 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387985AbeHPKwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 06:52:24 -0400
Received: by mail-pl0-f65.google.com with SMTP id j8-v6so1688931pll.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 00:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NP825gJ8JNuiSBQ93C487DDun4LcomGeoIeRKjPEd4E=;
        b=iDGPLbmIJ0zPSpBy4lvB8EsQDHX7bRIdNAnDQFxtLduf3kOyfVH3f5adiNBSpZKDBF
         xc9JfZ8EY3ZitZ6p8O7WEMmc+zDD3UHkLp1TQehl7w+U3SRwy50JXNAeh2P7vY43BRSr
         gZ10x2M0XlKL5jaMHAvZ4vh37FymuwrLdcOuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NP825gJ8JNuiSBQ93C487DDun4LcomGeoIeRKjPEd4E=;
        b=fv0Smzx6cnrNhNLa3EL6F7Ihjz3DPPYgzqADMBoWVHxv9hoRAsoY15mNqHNR40yy5L
         I+wJ5nMhXJvoDJOp5fqW/YTQz4jzVAwJ7itjeENCbRz/J2vnIzXSBgRq2X2CSHa+e24s
         cXie0lmJw7Hapl/mJPPxvbUoM6F0siHUbBG7sj2m/kDzPgzWnBYlS+fS1+pzTO9bHldv
         w8H0iRlaP1Rz4OZTiUBx5sMiR+r35PxofVmX6VvDaSkZhPa+KtpobAB3IMA0FMuFeixx
         UHsAC9k4fyhqjNCru9BnqVoOF+qsL2sybrPwMxULSpel0S8KKKgtHUq/zm2oFE3Tl17Y
         xl2g==
X-Gm-Message-State: AOUpUlEwUV8t3Q5vvoWGgpQpMpQtO7OVdSqj0Fd7PWiFfx0VMvncJo5f
        VMGHqGuvbz8rugmNUb1p4bWvHg==
X-Google-Smtp-Source: AA+uWPx4HeTA6+2pB6luZJ4BqcVERBCFyrad8p+nJ8BxdjzecRBrzkWLG1ZeiND+cazDSEZGoJhS0g==
X-Received: by 2002:a17:902:7d94:: with SMTP id a20-v6mr21648113plm.19.1534406142962;
        Thu, 16 Aug 2018 00:55:42 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id i25-v6sm50838137pfi.150.2018.08.16.00.55.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 16 Aug 2018 00:55:42 -0700 (PDT)
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
Date:   Thu, 16 Aug 2018 15:54:20 +0800
Message-Id: <1534406064-10065-7-git-send-email-zhang.chunyan@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1534406064-10065-1-git-send-email-zhang.chunyan@linaro.org>
References: <1534406064-10065-1-git-send-email-zhang.chunyan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For version 4.10 and aboves, SDHCI_ARGUMENT2 is also uses to indicate
32-bit number of blocks, it doesn't support stuff bits in argument of
CMD23, but only block count for the following command (CMD18/25).

Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
---
 drivers/mmc/host/sdhci.c | 9 +++++++++
 drivers/mmc/host/sdhci.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index b3328ee..a72ad0d 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1729,6 +1729,15 @@ static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 		}
 	}
 
+	/*
+	 * For version 4.10 and above, ARGUMENT2 register is also used as 32-bit
+	 * block count register which don't support stuff bits of CMD23 argument
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

