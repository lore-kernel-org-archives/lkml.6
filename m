Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19CF0C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 07:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE73E21722
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 07:26:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="i6FQS/oW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE73E21722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbeKLRSg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 12:18:36 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37028 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbeKLRSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 12:18:35 -0500
Received: by mail-pg1-f194.google.com with SMTP id 80so3660202pge.4
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 23:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=MaJ6kGoogNk7TlYPNyNVU1hBPKpkcHrSdo7gFd6mNXY=;
        b=i6FQS/oWgUbqWL4dd2fuReD/+kt+Dk/1X6VQtG5Wk9UZtD1KfMPh4987+yMuD0tAwd
         9i8j/dVBixAFFS6DmupIKtFvbupUhbNVM37e2hVFyFAgwTjbUcDCQZBrtVI/ehX+jlgf
         cL0MsQtSSQZw0AYHZnYZEFpZmb+qi/vSz+94k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MaJ6kGoogNk7TlYPNyNVU1hBPKpkcHrSdo7gFd6mNXY=;
        b=CF+C6cbC6D2/K5xbmuSEIC75ubqLbxdA9iaeFpqS1fVt/btwhYFx7bT5X5pGcCecmg
         UclO3S0rdpS5AWXUHZVptbSSWQgtJ4RCFXWAbgiyWZSigE5ooloBdbLn6s3exRecIOFn
         ruyYvghL7PHLZ/Mq06wt2ZjqqbbOZHH6lIWb18/1IPMCH24u6mCJKcS+VrhgElwQ/YJk
         /p6Ym4r2+jaTGEShhDTlXSbV3iRQSemWhthfguiRljQm+uwggsel3MHHkGtEuc/bs038
         WpnVXeA1leiN5kBcTrIZGraH70+zqGTxTeR2qhYay/UwZUpRYc4EtwcMZR9MHinxrsvd
         bxcA==
X-Gm-Message-State: AGRZ1gIQZhN5loza3+UJY3nSdaYTBKeS/0zmOD6KK/aSK1wTghx3w+WG
        NgUf/JruvZIfmGfPvGBsraB+pw==
X-Google-Smtp-Source: AJdET5cLO7KYTyB7oCe/atnGxEnJUZ6W4Zog8y7eCTajPEDYHTsDO/7AC2cgPPCxZk6uSXu/A2yz9g==
X-Received: by 2002:a63:7418:: with SMTP id p24mr16668600pgc.196.1542007596852;
        Sun, 11 Nov 2018 23:26:36 -0800 (PST)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id w2-v6sm18668331pfn.89.2018.11.11.23.26.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 11 Nov 2018 23:26:36 -0800 (PST)
From:   Chunyan Zhang <zhang.chunyan@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH v2 0/3] Add support for using external dma in SDHCI
Date:   Mon, 12 Nov 2018 15:26:03 +0800
Message-Id: <1542007566-9449-1-git-send-email-zhang.chunyan@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the generic SDHCI code in the Linux kernel supports the SD
standard DMA integrated into the host controller but does not have any
support for external DMA controllers implemented using dmaengine meaning
that custom code is needed for any systems that use a generic DMA
controller with SDHCI which in practice means any SDHCI controller that
doesn't have an integrated DMA controller so we should have this as a
generic feature.

There are already a number of controller specific drivers that have dmaengine
code, and some could use sdhci.c actually, but needed to implement mmc_ops->request()
in their specific driver for sending command with external dma using dmaengine
framework, with this patchset, them will take advantage of the generic support.
TI's omap controller is the case as an example.

Any comments are very appreciated.

Thanks,
Chunyan

Changes from v1 (https://lkml.org/lkml/2018/11/5/110):
(The code on patch 1/3 only was revised)
* Address comments from Arnd:
- Release channel when failed to request it unconditionally;
- Skip warning message if get EPROBE_DEFER;
* Address Andrian's comments:
- Replace extdma with external_dma;
- Add release dma resources in sdhci_cleanup_host() and sdhci_remove_host();
- Release dma resources once dmaengine_submit() failed.
- Put rx/tx_chan in struct sdhci_host, and removed unused structure.
* Fall back to the DMA/PIO which standard SDHCI supports, if sdhci_external_dma_setup()
  or sdhci_external_dma_init failed;

Chunyan Zhang (3):
  mmc: sdhci: add support for using external DMA devices
  mmc: sdhci-omap: Add using external dma
  dt-bindings: sdhci-omap: Add example for using external dma

 .../devicetree/bindings/mmc/sdhci-omap.txt         |   7 +
 drivers/mmc/host/Kconfig                           |  13 ++
 drivers/mmc/host/sdhci-omap.c                      |   7 +
 drivers/mmc/host/sdhci.c                           | 181 ++++++++++++++++++++-
 drivers/mmc/host/sdhci.h                           |   8 +
 5 files changed, 215 insertions(+), 1 deletion(-)

-- 
2.7.4

