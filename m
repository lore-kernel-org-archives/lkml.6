Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58CDCC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 11:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28FC021783
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 11:06:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="T/B2qKbx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732122AbfAKLGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 06:06:12 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:60364 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731527AbfAKLGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 06:06:09 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0BB63oN075058;
        Fri, 11 Jan 2019 05:06:03 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547204763;
        bh=C0won+NvEdG4iTGqEmjwHRU4GONsikpEz+5b2IectDM=;
        h=From:To:CC:Subject:Date;
        b=T/B2qKbxluctCl1OO9sq+VRJcGnWjqSj8D+vxC/p8oV80LZCO8BXE1f8UZjdKNDgA
         a7fyVL4zoFUfLuLHE/8hs24QxduENfmWKEtp4dA2a2mzEBF3Rg0yJ3MlcMjXqb4G0f
         m8JdUYft51JHr9SIPusltfsynTzFu+u1gT6KSWxo=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0BB63YY106838
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Jan 2019 05:06:03 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 11
 Jan 2019 05:06:03 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 11 Jan 2019 05:06:03 -0600
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0BB5xEq024503;
        Fri, 11 Jan 2019 05:06:00 -0600
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>
CC:     <zhang.chunyan@linaro.org>, <kishon@ti.com>,
        <adrian.hunter@intel.com>, <mark.rutland@arm.com>,
        <robh+dt@kernel.org>, <ulf.hansson@linaro.org>, <faiz_abbas@ti.com>
Subject: [PATCH 0/7] Port am335 and am437 devices to sdhci-omap
Date:   Fri, 11 Jan 2019 16:38:44 +0530
Message-ID: <20190111110851.6805-1-faiz_abbas@ti.com>
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

[1] https://patchwork.kernel.org/project/linux-mmc/list/?series=54897

Chunyan Zhang (3):
  mmc: sdhci: add support for using external DMA devices
  mmc: sdhci-omap: Add using external dma
  dt-bindings: sdhci-omap: Add example for using external dma

Faiz Abbas (4):
  mmc: sdhci: Add quirk for disabling DTO during erase command
  mmc: sdhci_omap: Add DISABLE_DTO_FOR_ERASE Quirk
  dt-bindings: sdhci-omap: Add am335x and am437x specific bindings
  mmc: sdhci-omap: Add am335x and am437x specific compatibles

 .../devicetree/bindings/mmc/sdhci-omap.txt    |   9 +
 drivers/mmc/host/Kconfig                      |   4 +
 drivers/mmc/host/sdhci-omap.c                 |  27 +-
 drivers/mmc/host/sdhci.c                      | 274 +++++++++++++++++-
 drivers/mmc/host/sdhci.h                      |  10 +
 5 files changed, 319 insertions(+), 5 deletions(-)

-- 
2.19.2

