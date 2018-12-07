Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E47D5C64EB1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 08:09:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5B6720892
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 08:09:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="N3U/keQs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5B6720892
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbeLGIJD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 03:09:03 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:35908 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbeLGII7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 03:08:59 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wB788ZCk070032;
        Fri, 7 Dec 2018 02:08:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1544170115;
        bh=rO+aPqD6+w1cIFgTW+ceCmjLX88dliF5vIUwiBWgSDA=;
        h=From:To:CC:Subject:Date;
        b=N3U/keQs8z6nJd2nTXQ6kna5YP/1Lthuhiw8V+YdMRTynFjbQcaw6lYnEPKGblwWl
         Bxaw2wB/4wExYpI34E6MHc4jSaWniH6aQEdGKYfeNQ1H0v7V1he+rcZqV5qx6wj8NU
         q56YcBBOGfgBpACJE8k8G/CW5cxqFAj1kSdsMpgg=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wB788Z3Y122743
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 7 Dec 2018 02:08:35 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Fri, 7
 Dec 2018 02:08:34 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Fri, 7 Dec 2018 02:08:34 -0600
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wB788Vud010977;
        Fri, 7 Dec 2018 02:08:31 -0600
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <adrian.hunter@intel.com>,
        <michal.simek@xilinx.com>, <kishon@ti.com>, <faiz_abbas@ti.com>
Subject: [PATCH v2 0/3] Add driver Support for MMCSD on AM654x
Date:   Fri, 7 Dec 2018 13:41:16 +0530
Message-ID: <20181207081119.29162-1-faiz_abbas@ti.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following patches add driver support for MMCSD on TI's AM654
platforms.

Previously I had added the support to sdhci-of-arasan driver with
a separate phy driver[1]. Since then it has turned out that tuning
operation (for HS200, HS400 and SDR104 speed modes) will require
configuration of phy registers. This completely breaks the model of
the sdhci-of-arasan driver which relies on a separate driver to
configure the phy register space.

Because of this, I am creating a new driver with both the sdhci and
phy register spaces. This helps me use the phy registers in a future
patch that adds tuning support.

DT patches will be posted in a separate series.

Changes in v2:
 1. Reset OTAP delay back to default value in init.
 2. Improved patch description for patch 2.
 3. Minor style fixes.

[1] driver and phy patches posted before
    https://patchwork.kernel.org/project/linux-mmc/list/?series=26623

Faiz Abbas (3):
  dt-bindings: mmc: sdhci-am654: Document bindings for the host
    controllers on TI's AM654 SOCs
  dt-bindings: mmc: sdhci-of-arasan: Add deprecated message for am65
  mmc: sdhci_am654: Add Initial Support for AM654 SDHCI driver

 .../devicetree/bindings/mmc/arasan,sdhci.txt  |   4 +
 .../devicetree/bindings/mmc/sdhci-am654.txt   |  37 ++
 drivers/mmc/host/Kconfig                      |  12 +
 drivers/mmc/host/Makefile                     |   1 +
 drivers/mmc/host/sdhci-of-arasan.c            |  46 ---
 drivers/mmc/host/sdhci_am654.c                | 381 ++++++++++++++++++
 6 files changed, 435 insertions(+), 46 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-am654.txt
 create mode 100644 drivers/mmc/host/sdhci_am654.c

-- 
2.19.2

