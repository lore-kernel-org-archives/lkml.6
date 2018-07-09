Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FAD2C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 03:20:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F3A2208DB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 03:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ex1D9utX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F3A2208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754430AbeGIDUc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 23:20:32 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37103 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754375AbeGIDUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 23:20:31 -0400
Received: by mail-pg1-f196.google.com with SMTP id n15-v6so960931pgv.4
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jul 2018 20:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=e9htUHOXH6pRtdx80yK6/PzAujm/Es8HEwNeNuNluZo=;
        b=Ex1D9utXes1uPrRx2VxEUPT2pZEFzTvfMeN5G/H3Ogj/XoedmHmvC51B6zT9EbdOVe
         tq+2xAznj99hEEGEHZ+El0FXcANuo0Pr9xPWxtJhKoBz9jAl7oJIIwmyzEx48YX7FkI2
         aY5LG4iForuPKFcTILYarHBBPQUCaCDgah688=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=e9htUHOXH6pRtdx80yK6/PzAujm/Es8HEwNeNuNluZo=;
        b=GZ9AQQO2BLTjgoWvqRBgbG8SuXz72phA/UK50Acpy6SgHoQ+k3/0CMXJH5DSwO6C7n
         4oGZSxAgwTOBi1RhDmb38v4lREbSeUqb13xFGLb1e+UqZztUdmxjO5Mnjaa7+wsPmt3p
         r2pogEdYonIYkvXheLvo7Pan9vKUG6h/cl1cD3nwyXhyZ82oTnUQQ6PzplODlDxVQAcF
         IlYQPMiy8HIPNYQblGIjGbcIAYXjx/KFf4ugFnB6UCeMQC6U1fmTgyCD0VL7AUyxaOmy
         wuJ7maDF1npAlH5RSmMP7H0jTy/yjyBktxu9iCq4m7FKv2wIEk119KHt547V5GnURbz/
         TMcA==
X-Gm-Message-State: APt69E1WTt2XpFpX88r3lFuhaVlqJ08GM4SRNkykbSEqR+MIdED+RjZ6
        u3aslK+NmHzrovfD02rNKYwvpw==
X-Google-Smtp-Source: AAOMgpe+wGYdchvseCgGPcbWyW1B5raqx0dPFd4U/iFSSvbfPZoUfzXJdV3PDQ/IjDEMGokD5P624A==
X-Received: by 2002:a63:d15:: with SMTP id c21-v6mr17636555pgl.322.1531106430664;
        Sun, 08 Jul 2018 20:20:30 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id e82-v6sm41458950pfk.87.2018.07.08.20.20.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 08 Jul 2018 20:20:29 -0700 (PDT)
From:   Chunyan Zhang <zhang.chunyan@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Billows Wu <billows.wu@spreadtrum.com>, zhang.lyra@gmail.com
Subject: [PATCH V3 0/7] mmc: add support for sdhci 4.0
Date:   Mon,  9 Jul 2018 11:19:51 +0800
Message-Id: <1531106398-14062-1-git-send-email-zhang.chunyan@linaro.org>
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

Changes from V2:
* Addressed comments from Adrian:
- Added sdhci_enable_v4_mode() for enabling v4 mode instead of determining by reading from registers;
- Added support for 64-bit SDMA address in v4 mode;
- Dropped the changes of ADMA2 data aglinment;
- Added support for "Auto Cmd Auto Select".
* Rebased on v4.18-rc2.
* Dealt with a few issues in sdhci-sprd:
- Save return value of mmc_of_parse();
- Add checking for clk_prepare_enable();
- Use BIT() macro instead.

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
  mmc: sdhci: add Auto CMD Auto Select support
  mmc: sdhci-sprd: added Spreadtrum's initial host controller
  dt-bindings: sdhci-sprd: Add bindings for the sdhci-sprd controller

 .../devicetree/bindings/mmc/sdhci-sprd.txt         |  41 ++
 drivers/mmc/host/Kconfig                           |  13 +
 drivers/mmc/host/Makefile                          |   1 +
 drivers/mmc/host/sdhci-sprd.c                      | 437 +++++++++++++++++++++
 drivers/mmc/host/sdhci.c                           | 107 +++--
 drivers/mmc/host/sdhci.h                           |  22 +-
 6 files changed, 596 insertions(+), 25 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-sprd.txt
 create mode 100644 drivers/mmc/host/sdhci-sprd.c

-- 
2.7.4

