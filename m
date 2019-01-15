Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92376C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D5D520657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:29:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731515AbfAOQ3D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:29:03 -0500
Received: from mail.bootlin.com ([62.4.15.54]:57913 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731482AbfAOQ3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:29:02 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 9787C209EF; Tue, 15 Jan 2019 17:28:59 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-37-87.w90-88.abo.wanadoo.fr [90.88.156.87])
        by mail.bootlin.com (Postfix) with ESMTPSA id 69DBF20A7A;
        Tue, 15 Jan 2019 17:28:49 +0100 (CET)
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org,
        Gregory Clement <gregory.clement@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 0/3] Introduce support for WP GPIO in the core SDHCI
Date:   Tue, 15 Jan 2019 17:28:34 +0100
Message-Id: <20190115162837.5399-1-thomas.petazzoni@bootlin.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

While doing the bring up of a Zynq 7000 platform where the WP signal
of a SD slot is connected to a regular GPIO rather than through the
SDHCI WP pin, I realized that the GPIO described by wp-gpios was
properly requested, but it was in fact not used at all.

Indeed, the SDHCI core implements sdhci_check_ro() by:

 - Calling a controller-specific ->get_ro() callback if it exists. A
   few controller-specific drivers implement this, but not
   sdhci-of-arasan, which is used on Zynq 7000.

 - Using the SDHCI_PRESENT_STATE register, which reports the state of
   the SDHCI interface WP pin, and obvisouly not the state of a
   separate WP GPIO.

This patch series therefore changes sdhci_check_ro() to behave like
sdhci_get_cd(): use a GPIO first if available, and if not, fallback to
using the SDHCI_PRESENT_STATE register. Indeed, if there's a wp-gpios
described in the DT, it quite certainly indicates that the SDHCI WP
signal is not used, and the WP GPIO should be used instead.

As part of this series, two SDHCI drivers are modified to no longer
implement their custom ->get_ro() hook, since the core SDHCI now does
the right thing with the WP GPIO.

Best regards,

Thomas

Thomas Petazzoni (3):
  mmc: sdhci: use WP GPIO in sdhci_check_ro()
  mmc: sdhci-omap: drop ->get_ro() implementation
  mmc: sdhci-tegra: drop ->get_ro() implementation

 drivers/mmc/host/sdhci-omap.c  | 1 -
 drivers/mmc/host/sdhci-tegra.c | 9 ---------
 drivers/mmc/host/sdhci.c       | 9 ++++++---
 3 files changed, 6 insertions(+), 13 deletions(-)

-- 
2.20.1

