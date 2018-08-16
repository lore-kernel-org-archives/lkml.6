Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EE76C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 07:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F087214C5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 07:54:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YqU269qC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F087214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389539AbeHPKvZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 06:51:25 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:33852 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbeHPKvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 06:51:25 -0400
Received: by mail-pl0-f68.google.com with SMTP id f6-v6so1706562plo.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 00:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=FIdLgY0zruSsyBRB+jlR99n4k0RGFju7v2eM0n3VOrY=;
        b=YqU269qCRl9VeyBS1YUIbrUIyUH0gdWoImVQo8c+DJWVeu9ibifMaJJIoDXOKS6LfU
         0hUHIoYOvILymPYlgk3EpL/sdhNThpzZgo63q5TgVIDV3d99WyLwcR+YxFc8jfNTSaP2
         w4qHNJi3ugQqOntKYInBibW3w9m0HOtkDVRoo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FIdLgY0zruSsyBRB+jlR99n4k0RGFju7v2eM0n3VOrY=;
        b=TNkZ09TDlgM9opKO+xa3LtF2B7FY2Rl8inyr3Pfp5z6QpDpfpeBjLZ9KEEVBXOPs9+
         8+qTknH8MYKUgs4YwAXkdj+zDXI6vEZbqWDhF+/78mq89sNnWD5WdU4uZ1hjiiw4lD+W
         G8IKcdS2K/qlEjWUtBX9cNftK7VtzEJ6IF5XQpkFb5k2PVpiqH+st8uu7LkRX4LDnNkB
         0tDBlNn+lp6R7H09vvoO+0y2YcGgBiDO6zo0bxe5aSlBK0r9Mo5IsMbK9qgsN2Cvbr4C
         aUYpsCQbUOKQzTqRHuIo0jd+4v+MK9yRIEQixSm6Hi0GRklEQ6EkmCbGk5VwKc1NgB9b
         lPYw==
X-Gm-Message-State: AOUpUlFvhKiuaC2H997liEJWAUd8ndu/7sEJIQcFyri1JhLDMsloX224
        AeMLPZQZCDVWBTa8cClFeoclAA==
X-Google-Smtp-Source: AA+uWPzD8oaKbVjvAj+qgvtR9sUVZ0TxYu0dYDd0Kfz1ldQ9UoS2UbXAP7rHYvhHdR7voRr6A6HzRA==
X-Received: by 2002:a17:902:7446:: with SMTP id e6-v6mr28122209plt.161.1534406084089;
        Thu, 16 Aug 2018 00:54:44 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id i25-v6sm50838137pfi.150.2018.08.16.00.54.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 16 Aug 2018 00:54:43 -0700 (PDT)
From:   Chunyan Zhang <zhang.chunyan@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Billows Wu <billows.wu@unisoc.com>,
        Jason Wu <jason.wu@unisoc.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Subject: [PATCH V5 00/10] mmc: add support for sdhci 4.0
Date:   Thu, 16 Aug 2018 15:54:14 +0800
Message-Id: <1534406064-10065-1-git-send-email-zhang.chunyan@linaro.org>
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

Changes from V4:
* Addressed Adrian's comments:
- Enable v4 mode in __sdhci_read_caps() and sdhci_init() instead of sdhci_do_reset();
- Move the added member 'v4_mode' to following with other bools;
- Add more comments in the added function sdhci_config_dma();
- Instead of enabling auto-CMD23 in init, enabled it only if receiving sbc from
  cards and the argument is suitable for host to deal with;
- Make the addition of the SDHCI_SPEC_4xx defines a separate patch;
- Disable auto-CMD23 if stuff bits is set in the argument of CMD23 in sdhci_request().

* For V4 mode, SDMA also can use auto-CMD23, adjusted host->flags in sdhci_setup_host().

Previous patch series:
v4: https://lkml.org/lkml/2018/7/23/269
v3: https://lkml.org/lkml/2018/7/8/239
v2: https://lkml.org/lkml/2018/6/14/936
v1: https://lkml.org/lkml/2018/6/8/108

Chunyan Zhang (10):
  mmc: sdhci: Add version V4 definition
  mmc: sdhci: Add sd host v4 mode
  mmc: sdhci: Change SDMA address register for v4 mode
  mmc: sdhci: Add ADMA2 64-bit addressing support for V4 mode
  mmc: sdhci: Add 32-bit block count support for v4 mode
  mmc: sdhci: Disable auto-CMD23 if stuff bits is set in CMD23 argument
  mmc: sdhci: Add Auto CMD Auto Select support
  mmc: sdhci: SDMA may use Auto-CMD23 in v4 mode
  mmc: sdhci-sprd: Add Spreadtrum's initial host controller
  dt-bindings: sdhci-sprd: Add bindings for the sdhci-sprd controller

 .../devicetree/bindings/mmc/sdhci-sprd.txt         |  41 ++
 drivers/mmc/host/Kconfig                           |  13 +
 drivers/mmc/host/Makefile                          |   1 +
 drivers/mmc/host/sdhci-sprd.c                      | 464 +++++++++++++++++++++
 drivers/mmc/host/sdhci.c                           | 251 ++++++++---
 drivers/mmc/host/sdhci.h                           |  22 +-
 6 files changed, 741 insertions(+), 51 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-sprd.txt
 create mode 100644 drivers/mmc/host/sdhci-sprd.c

-- 
2.7.4

