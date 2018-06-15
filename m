Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E2FA5C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 02:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A90C20891
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 02:04:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fdYqL0R6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A90C20891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965386AbeFOCEk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 22:04:40 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36579 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965072AbeFOCEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 22:04:38 -0400
Received: by mail-pf0-f193.google.com with SMTP id a12-v6so4132240pfi.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jun 2018 19:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=mPKWL9UMIBCOFFeaeSmeMWAFA+4kcTMiI6+Bye4gr10=;
        b=fdYqL0R6v/5tZf4iZSGp/CEIsLQefMFgve+9MdGdhlCTmBIrkVEUiFF3yPkHA+KRn2
         n7FaA74OHcIDrhR9VyZ0rM+iaZVJZDdeT7h/FqjBPq4wnzE+0gEU1XZQLEf9eUu7J4ya
         AA2zm/qJPYBwopMmHMSbxFAhUTggZ03Q5zkAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mPKWL9UMIBCOFFeaeSmeMWAFA+4kcTMiI6+Bye4gr10=;
        b=mYrmyRkKO7brCodsHYNBve/T9lH9Hnoyv+9sEKbRiqRBz9P36exg0pinWZc1elPzWk
         pQ6QxLdeyqgshACTH0ToH2iTGxzUzsC5eQKQYELZ9IWi9xov1KTi0R9nj5Do5eeTvfFe
         fwfzunHDoIZYqfaE8gg/iWmKtkeqRa1jsrQK5xRyEUvphd97FUEzj2TzXoaBkYVHFyGe
         TQyk00o9b3Ox0wKBjt8MRNEHxhjvpBCKMmONmZ55weQMnvudtUdZsiIITmTpCNm36hCa
         ra7KDMu0LW9RYMS1usvbNyAKMJIaSIa4gi7ysh+1NFhUyn7yKD/71VostRBCht3KvKZp
         GIhg==
X-Gm-Message-State: APt69E11nwHZrgXsEq6+Qlk0cFx51yMD/kFxHA47hkqMAWwrl1pyBrhl
        T8oheJdFznP0W6SCXPZHB4t8i6bFmDI=
X-Google-Smtp-Source: ADUXVKJFkkG2PTakuGTy3Por4BdFq+b2esLwl+RcGJB+Nlfew+dA2r8ZGh5hnt74w71lXeM7udWkqA==
X-Received: by 2002:a62:ab0e:: with SMTP id p14-v6mr11893558pff.211.1529028278425;
        Thu, 14 Jun 2018 19:04:38 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id k69-v6sm9504953pgc.39.2018.06.14.19.04.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 14 Jun 2018 19:04:37 -0700 (PDT)
From:   Chunyan Zhang <zhang.chunyan@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Billows Wu <billows.wu@spreadtrum.com>, zhang.lyra@gmail.com
Subject: [PATCH V2 0/7] mmc: add support for sdhci 4.0
Date:   Fri, 15 Jun 2018 10:04:08 +0800
Message-Id: <1529028255-6022-1-git-send-email-zhang.chunyan@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chunyan Zhang <chunyan.zhang@spreadtrum.com>

From the SD host controller version 4.0 on, SDHCI implementation either
is version 3 compatible or version 4 mode. This patch-set covers those
changes which are common for SDHCI 4.0 version, regardless of whether
they are used with SD or eMMC storage devices.

This patchset also added a new sdhci driver for Spreadtrum's controller
which supports v4.0 mode.

This patchset has been tested on Spreadtrum's mobile phone, emmc can be
initialized, mounted, read and written, with these changes for common
sdhci framework and sdhci-sprd driver.

Changes from v1:
* Addressed comments from Ulf:
 - Add dt-bindings for Spreadtrum sdhci;
 - Use assigned-clocks* DT bindings to set default source of sdio clock;
 - Removed unuseful print;
 - Removed two functions which are not used;
 - Add back the missing pm_runtime_put_autosuspend() after adding sdhci host.

* Changed Spreadtrum sdhci driver name to sdhci-sprd.

Chunyan Zhang (7):
  mmc: sdhci: add sd host v4 mode
  mmc: sdhci: made changes for System Address register of SDMA
  mmc: sdhci: add ADMA2 64-bit addressing support for V4 mode
  mmc: sdhci: add 32-bit block count support for v4 mode
  mmc: sdhci: add CMD23 support for v4 mode
  mmc: sdhci-sprd: added Spreadtrum's initial host controller
  dt-bindings: sdhci-sprd: Add bindings for the sdhci-sprd controller

 .../devicetree/bindings/mmc/sdhci-sprd.txt         |  41 ++
 drivers/mmc/host/Kconfig                           |  13 +
 drivers/mmc/host/Makefile                          |   1 +
 drivers/mmc/host/sdhci-sprd.c                      | 426 +++++++++++++++++++++
 drivers/mmc/host/sdhci.c                           |  85 +++-
 drivers/mmc/host/sdhci.h                           |  31 +-
 6 files changed, 575 insertions(+), 22 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-sprd.txt
 create mode 100644 drivers/mmc/host/sdhci-sprd.c

-- 
2.7.4

