Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E08C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DFB52086B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 07:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y0XC3Blt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DFB52086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbeH2K6i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 06:58:38 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43171 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbeH2K6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 06:58:38 -0400
Received: by mail-pg1-f193.google.com with SMTP id v66-v6so1907565pgb.10
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 00:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=CYM0/IgCTNi0j08mXrPy6EH4E4EJhMeWQe7qtV0tC/s=;
        b=Y0XC3BltKBhBdHloP8sD/ChdyJYbSd1gytbONLcSoDfs1zCNBU+cw59AcQYc2QReXG
         PJJ2PagW4onXTb52h3GUd95SqT9qlJkM+iJy3l5Z8rYq8HKCJrWY+a6H6pYf0No3zSdm
         gy1KQHaghelHo0PP0gqtiOfU8aLHao2uwrG3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CYM0/IgCTNi0j08mXrPy6EH4E4EJhMeWQe7qtV0tC/s=;
        b=QxsWXIh/5yKMpSNLSHo+OBUV7pC9lISIhCll94zARLfCkbXAXb4j5gkZQ6PaFSf72d
         gXQG5v80i/CPyR25cf2bR+ZxjbRRZyR6ZNTgrMQeRqIWDHk8SU5XMGFlXg6YLWgIjOmK
         9pnP4+LMKxT4Dlq3g0Dx8Yhbp+o6hG7GksYqV0abPDvHVDiffHNcFN99ztgp7CSw1qrY
         T4rior6JldkxXgRW3jksXt0ntbjwYYDyKhSCDU7yuso6ToODZraiE/29XSdKEcpCXW0v
         WyYAAFr5ACQaigbFPquOO6K9We0sAbrDD+BalkD9iN0mQVWdVTV/WnouVRfySI5Zuqon
         WqBA==
X-Gm-Message-State: APzg51ClQ7j+yBtRgSuMJ79xoO8xBYKRIiW/NE2BA453qeW9FTq578iJ
        e1xwD8bpJYbZGdKm6Uh1psQ4BA==
X-Google-Smtp-Source: ANB0VdZAhoP48i6Qw0EFvmTqdQMyAGXeou5pqopQ5fVFANczUokQpxDElwpVNrWjF6HTqgNYlwM/Aw==
X-Received: by 2002:a63:a112:: with SMTP id b18-v6mr4555541pgf.384.1535526193329;
        Wed, 29 Aug 2018 00:03:13 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id d81-v6sm4317342pfj.122.2018.08.29.00.03.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 29 Aug 2018 00:03:12 -0700 (PDT)
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
Subject: [PATCH V7 0/9] mmc: add support for sdhci 4.0
Date:   Wed, 29 Aug 2018 15:02:55 +0800
Message-Id: <1535526184-32718-1-git-send-email-zhang.chunyan@linaro.org>
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

Changes from V6:
- Rebased to the next branch of Ulf' mmc tree;
- Replaced SDHCI_QUIRK2_BROKEN_32BIT_BLK_CNT with SDHCI_QUIRK2_USE_32BIT_BLK_CNT,
  also added a comment to its definition;
- Added a 'flags' in sprd_host for recovering host->flags in mmc_host_ops.request.

Previous patch series:
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
 drivers/mmc/host/sdhci.c                           | 224 +++++++--
 drivers/mmc/host/sdhci.h                           |  28 +-
 6 files changed, 755 insertions(+), 50 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-sprd.txt
 create mode 100644 drivers/mmc/host/sdhci-sprd.c

-- 
2.7.4

