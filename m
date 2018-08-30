Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A57AC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 08:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D803E2082B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 08:21:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EIRTyWY5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D803E2082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbeH3MWz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 08:22:55 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34916 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727688AbeH3MWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 08:22:55 -0400
Received: by mail-pg1-f194.google.com with SMTP id w8-v6so1979616pgs.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 01:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=QWmDPEdLUpyWw5hHCL9ae0thTLkKN/kT21prhaAp1tI=;
        b=EIRTyWY5uZjfZCI0IlZhpxZOdQkcWVx0Euxcq86o0/YCIQabFXJgQDZtz6GXQT4Xqh
         AL2KCZPmfUjYuiUnAN2g23cg4Ffkpgf5vvlkc+7XLN1LYVIW+30rNLpMTBXs/GW6BBKE
         MoN1mHtsdB0TcFJqqqXmBrU2bmUsHP4yA2Ea0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QWmDPEdLUpyWw5hHCL9ae0thTLkKN/kT21prhaAp1tI=;
        b=sa175xG0MXmAQtTu68n+PU8vfXOmbhRBvgXDCgFL3PpqXS2I8Y4gn9j1JmycZwEYam
         folStPRg9nXWC0PVpJnWfGeQZU9qGDYf3VEQx3U54OUIhYcp1rUxGJhRRWRJ6f9ZI8Kk
         wiAsPRyzMhCVVOrs+/j3LGslwbirrH9bXYKttw7rrxS/cYvljA0IyBNqOsquUB3/uU2I
         w8wO6Oz63GoYbcLToBGXaYZJZ6O/6JrMpmGkDQ1tFvqNYJBzdxzqlJWFp84hU9XfrcEC
         fFVMBbIZZE6ic8wUe7PrMPZ5gFMoq4t0d72B4Ro1BAkWRwx2WufjRi9J+kLIGwFLLo7b
         zcFw==
X-Gm-Message-State: APzg51BEocGOnh/DHQEc7YPoFV2nQhJswPzfdgfA9chFU/QudrTyqSPk
        02ieyc95nbf8CG+/kFIH+PybOg==
X-Google-Smtp-Source: ANB0VdauBMpDtiVVuzyWcilogTP8zXwJwP0Hrf4K5NrqIBQcKnOpjx/MoKRL4yWgGYIcs5YLF6O5hQ==
X-Received: by 2002:a62:cd3:: with SMTP id 80-v6mr9585491pfm.184.1535617317198;
        Thu, 30 Aug 2018 01:21:57 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id j22-v6sm8224885pfh.45.2018.08.30.01.21.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 30 Aug 2018 01:21:56 -0700 (PDT)
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
Subject: [PATCH V8 0/9] mmc: add support for sdhci 4.0
Date:   Thu, 30 Aug 2018 16:21:36 +0800
Message-Id: <1535617305-16952-1-git-send-email-zhang.chunyan@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From the SD host controller version 4.0 on, SDHCI implementation either
is version 3 compatible or version 4 mode. This patch-set covers those
changes which are common for SDHCI 4.0 version, regardless of whether
they are used with SD or eMMC storage devices.

This patchset also added a new sdhci driver for Spreadtrum's controller
which supports v4.0 mode.

This patchset has been tested on Spreadtrum's mobile phone, emmc can be
initialized, mounted, read and written, with these changes for common
sdhci framework and sdhci-sprd driver.

Changes from V7:
- Added Adrian's acked-by on patch 1-6;
- Addressed comments.

Previous patch series:
v7: https://lkml.org/lkml/2018/8/29/130
v6: http://lkml.org/lkml/2018/8/24/205
v5: https://lkml.org/lkml/2018/8/16/122
v4: https://lkml.org/lkml/2018/7/23/269
v3: https://lkml.org/lkml/2018/7/8/239
v2: https://lkml.org/lkml/2018/6/14/936
v1: https://lkml.org/lkml/2018/6/8/108

Chunyan Zhang (9):
  mmc: sdhci: Add version V4 definition
  mmc: sdhci: Add sd host v4 mode
  mmc: sdhci: Change SDMA address register for v4 mode
  mmc: sdhci: Add ADMA2 64-bit addressing support for V4 mode
  mmc: sdhci: Add 32-bit block count support for v4 mode
  mmc: sdhci: Add Auto CMD Auto Select support
  mmc: sdhci: SDMA may use Auto-CMD23 in v4 mode
  mmc: sdhci-sprd: Add Spreadtrum's initial host controller
  dt-bindings: sdhci-sprd: Add bindings for the sdhci-sprd controller

 .../devicetree/bindings/mmc/sdhci-sprd.txt         |  41 ++
 drivers/mmc/host/Kconfig                           |  13 +
 drivers/mmc/host/Makefile                          |   1 +
 drivers/mmc/host/sdhci-sprd.c                      | 498 +++++++++++++++++++++
 drivers/mmc/host/sdhci.c                           | 223 +++++++--
 drivers/mmc/host/sdhci.h                           |  28 +-
 6 files changed, 754 insertions(+), 50 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-sprd.txt
 create mode 100644 drivers/mmc/host/sdhci-sprd.c

-- 
2.7.4

