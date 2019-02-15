Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A48C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB1BF222D0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 19:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CuUoUmvM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732959AbfBOTRm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 14:17:42 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:59548 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbfBOTRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 14:17:41 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1FJHZYJ128839;
        Fri, 15 Feb 2019 13:17:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1550258255;
        bh=u9zH9gfwCuO4qb0wkF+/Yvr1zIGmXnlp+UZi2pS6yjA=;
        h=From:To:CC:Subject:Date;
        b=CuUoUmvMo7y1F21PbRI7wApRS45H6HwU1Wu0Lq2xNYK3UjTmUeLKQXufPNdjnrXGy
         VUTApLzLm+8N7ityp7VDYtaVVC3F4F+Lvlbe/2tcsHW8yM1Pf5/psR+i07m36lACql
         IxDxVtYHmwH+/ZAaL+iyjIi7Fi82aJNzDWDJEKAA=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1FJHZd6091598
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 15 Feb 2019 13:17:35 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 15
 Feb 2019 13:17:34 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 15 Feb 2019 13:17:34 -0600
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1FJHV0u025256;
        Fri, 15 Feb 2019 13:17:31 -0600
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, <linux-omap@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <adrian.hunter@intel.com>, <kishon@ti.com>,
        <zhang.chunyan@linaro.org>, <faiz_abbas@ti.com>
Subject: [PATCH v2 0/8] Port am335 and am437 devices to sdhci-omap
Date:   Sat, 16 Feb 2019 00:50:25 +0530
Message-ID: <20190215192033.24203-1-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following add driver patches for porting TI's am335x and am437x
devices to the sdhci-omap driver.

This involves adding external DMA support to sdhci (first 3 patches from
Chunyan) plus some miscellaneous patches to take care of deviations of
the controllers from the sdhci model.

DT changes will be posted in a separate series.

Untested versions of Chunyan's patches were posted before[1].

Tested on: am335x-evm, am335x-boneblack, am335x-sk, am437x-gpevm,
am43xx-gpevm, am437x-idk, dra7xx-evm, dra72x-evm

v2:
1. sdhci is using two bottom halves. One threaded_rq for card detect and a
   tasklet for finishing mmc requests. Patch 1 removes the tasklet and
   moves its function to the threaded_irq. This enables me to
   terminate_sync() in sdhci_request_done()

2. Factored out common code for between the normal adn external dma case

3. Using existing API sdhci_data_timeout_irq for disabling DTO during
   erase commands.

4. Fixed subject line for dt-bindings patch.

[1] https://patchwork.kernel.org/project/linux-mmc/list/?series=54897

Chunyan Zhang (3):
  mmc: sdhci: add support for using external DMA devices
  dt-bindings: sdhci-omap: Add properties for using external dma
  mmc: sdhci-omap: Add using external dma

Faiz Abbas (5):
  mmc: sdhci: Get rid of finish_tasklet
  mmc: sdhci: Add quirk for disabling DTO during erase command
  mmc: sdhci-omap: Add DISABLE_DTO_FOR_ERASE Quirk
  dt-bindings: sdhci-omap: Add am335x and am437x specific bindings
  mmc: sdhci-omap: Add am335x and am437x specific compatibles

 .../devicetree/bindings/mmc/sdhci-omap.txt    |   9 +
 drivers/mmc/host/Kconfig                      |   4 +
 drivers/mmc/host/sdhci-omap.c                 |  27 +-
 drivers/mmc/host/sdhci.c                      | 333 +++++++++++++++---
 drivers/mmc/host/sdhci.h                      |  12 +-
 5 files changed, 328 insertions(+), 57 deletions(-)

-- 
2.19.2

