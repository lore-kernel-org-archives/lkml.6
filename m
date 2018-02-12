Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752773AbeBLRHH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 12:07:07 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:42002 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751364AbeBLRHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 12:07:05 -0500
X-Google-Smtp-Source: AH8x226MEbp/R2tbOJDXVlcBZoFz2yR/2W0gBRTHxXTSSrXjxSAT0rD9pGx2NxzT+G8/bazYRHrKMg==
From: Dmitry Osipenko <digetx@gmail.com>
To: Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Memory controller hot reset
Date: Mon, 12 Feb 2018 20:06:29 +0300
Message-Id: <cover.1518452709.git.digetx@gmail.com>
X-Mailer: git-send-email 2.15.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Tegra's memory controller has a "memory hot reset" functionality that
blocks all memory transactions for the memory client. During reset of HW,
it could perform DMA and resetting HW during DMA could lead to a system
hang or memory corruption, so here comes the memory hot reset that blocks
all interactions of HW with memory so that it could be reset safely. Memory
hot reset is urgently required for multimedia, like GPU or video decoder,
as it is quite easy to get into trouble without a proper HW reset.

The short series introduces a custom Tegra-specific memory hot reset API.

Since first revision of this patchset haven't got any comment, I'm trying
again with a V2 that has one minor correction compared to V1, I've added
terga_mc_hotreset_assert()/deassert() functions as in V1 there was only
tegra_mc_hot_reset() and turned out it is not enough.

Please review, thanks.

Dmitry Osipenko (2):
  memory: tegra: Squash tegra20-mc into common tegra-mc driver
  memory: tegra: Introduce memory client hot reset API

 drivers/memory/Kconfig          |  10 -
 drivers/memory/Makefile         |   1 -
 drivers/memory/tegra/Makefile   |   1 +
 drivers/memory/tegra/mc.c       | 433 ++++++++++++++++++++++++++++++++++------
 drivers/memory/tegra/mc.h       |  10 +
 drivers/memory/tegra/tegra114.c |  25 +++
 drivers/memory/tegra/tegra124.c |  32 +++
 drivers/memory/tegra/tegra20.c  |  95 +++++++++
 drivers/memory/tegra/tegra210.c |  27 +++
 drivers/memory/tegra/tegra30.c  |  25 +++
 drivers/memory/tegra20-mc.c     | 254 -----------------------
 include/soc/tegra/mc.h          |  81 +++++++-
 12 files changed, 669 insertions(+), 325 deletions(-)
 create mode 100644 drivers/memory/tegra/tegra20.c
 delete mode 100644 drivers/memory/tegra20-mc.c

-- 
2.15.1
