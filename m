Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E377ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 10:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C963020854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 10:08:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NgKHu3kR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C963020854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388336AbeGWLJR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 07:09:17 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:40877 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388043AbeGWLJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 07:09:17 -0400
Received: by mail-pl0-f65.google.com with SMTP id s17-v6so27714plp.7
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jul 2018 03:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Rw9RlSwjc5mOTeGzIBOBPdNtEr8wmRWOL0Zk2nBVV8g=;
        b=NgKHu3kRW4/opugi3BxT8NhpinvQYdpyqkNjbdJO5ONhnKhreef797WiZ4bGBWoccc
         7Zh+KrqERsSvkC1v9gJK/5HK9MGwzbO/ESaXmRNnrtnsKWGcYQggxeeWg7dPoWLckQV8
         sjtKfqLyR2vSKuWIhmRJP112W6yAbJOLuaCJ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Rw9RlSwjc5mOTeGzIBOBPdNtEr8wmRWOL0Zk2nBVV8g=;
        b=iueF2997ioX3VZC7dpbet6N4zZc4WVRpl1I9KacQzo67uFCWwpAk0cL6NX56iW7Kqj
         8661bKrlzWWjRLXzR8jH1WUjgaaHRAjWMpBufjqrkU4tGocp9EV5hsfg6QRNvWFhL8Gr
         IRpd5wbze1ObJ9k+ox9DUBdmcbo6k0u1lRodII1ZqTOxSGqI6EuZdVr7+KYexoQ3V5G1
         oJLueZPcDE6Gq5ZRd8jZsmu66Fc3WtFQ/SCAqGIe+C7lNm3Lv8smCf1MMlyG3r6SmT+T
         vKCmjJohenwUB7LvKWeevaCZf5oh0mky3aqxc71q+1uOnJkQV4maN879BScY3K0wfi+w
         XkYA==
X-Gm-Message-State: AOUpUlE6ci3yst6ivem6PDFuqLeY0MxK8ob1gsdVEubz4FkXSsLqPlv1
        MVqUd37YYZG33wfFeLyf1H83iQ==
X-Google-Smtp-Source: AAOMgpemRWIlXBz74CA98czO8QuT3D6IfsWqr3URwqmrrXe/repw3w0pcKBI8DE4xBkW8T+1UG84YQ==
X-Received: by 2002:a17:902:7688:: with SMTP id m8-v6mr12228669pll.338.1532340530835;
        Mon, 23 Jul 2018 03:08:50 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id e82-v6sm13470698pfk.87.2018.07.23.03.08.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 23 Jul 2018 03:08:49 -0700 (PDT)
From:   Chunyan Zhang <zhang.chunyan@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Billows Wu <billows.wu@spreadtrum.com>,
        Jason Wu <jason.wu@unisoc.com>, zhang.lyra@gmail.com
Subject: [PATCH V4 0/7] mmc: add support for sdhci 4.0
Date:   Mon, 23 Jul 2018 18:08:21 +0800
Message-Id: <1532340508-8749-1-git-send-email-zhang.chunyan@linaro.org>
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

Changes from V3:
* Addressed comments from Adrian:
- set "Host Control 2" when enabled v4 mode, and do the same for reset-for-all in sdhci_do_reset();
- Moved "v4_mode" above to the private;
- Change the subject of patch 2/7;
- Use %pad to pirnt dma_addr_t;
- Adjusted to not clear SDHCI_USE_SDMA for v4 mode in sdhci_setup_host();
- Changed the function name to sdhci_can_64bit_dma() instead of sdhci_use_64bit_dma;
- Adjusted to write SDHCI_CTRL_64BIT_ADDR when we decide to use 64-bit DMA in V4 mode,
  rather than check the register to decide if use 64-bit DMA;
- Added a comments for using dma_zalloc_coherent() to replace dma_alloc_coherent();
- Added SDHCI_SPEC_420;
- Set 16-bit block count register to zero conditionally when using 32-bit block count;
- Adjusted to Use 32-bit block count register only for v4.10 v4 mode;
- Added the rules used for AUTO CMD23/12 to AUTO CMD as well;
- Moved the selection of Host Control 2 register CMD23 Enable to sdhci_init() from Spreadtrum's driver;
- Used usleep_range() to replace udelay();
- Added the checks for clk_prepare_enable().
* Added comments for Spreadtrum's specific changes to the register SDHCI_SOFTWARE_RESET;

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
  mmc: sdhci: Change SDMA address register for v4 mode
  mmc: sdhci: add ADMA2 64-bit addressing support for V4 mode
  mmc: sdhci: add 32-bit block count support for v4 mode
  mmc: sdhci: add Auto CMD Auto Select support
  mmc: sdhci-sprd: added Spreadtrum's initial host controller
  dt-bindings: sdhci-sprd: Add bindings for the sdhci-sprd controller

 .../devicetree/bindings/mmc/sdhci-sprd.txt         |  41 ++
 drivers/mmc/host/Kconfig                           |  13 +
 drivers/mmc/host/Makefile                          |   1 +
 drivers/mmc/host/sdhci-sprd.c                      | 455 +++++++++++++++++++++
 drivers/mmc/host/sdhci.c                           | 223 +++++++---
 drivers/mmc/host/sdhci.h                           |  23 +-
 6 files changed, 708 insertions(+), 48 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-sprd.txt
 create mode 100644 drivers/mmc/host/sdhci-sprd.c

-- 
2.7.4

