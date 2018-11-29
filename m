Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44AB8C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2DE2213A2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="dHvhIxuD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2DE2213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729235AbeK3DSo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 22:18:44 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:39730 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728423AbeK3DSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 22:18:43 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wATGCUeP100606;
        Thu, 29 Nov 2018 10:12:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1543507950;
        bh=DzpJ1kEuso3OgtTOxn+AuN5ExFYrgskLKARggFaKFpg=;
        h=From:To:CC:Subject:Date;
        b=dHvhIxuDNfQoJISL2359W/gj4XPPGqtWuJzGigNG6AbbRdvGpdqJLVoRkM2zB50XR
         kLWNStXk2nm+ahsVB9uTFfONH3zLF0lTuBkR4Z/Yw8ENo358vpLSw3zxC+EZd5WBDC
         MCymbaNZj56JL4r7iX9a9n/w/x8TL2teRPZQmdpo=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wATGCULE025519
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 29 Nov 2018 10:12:30 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 29
 Nov 2018 10:12:30 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 29 Nov 2018 10:12:30 -0600
Received: from a0230074-OptiPlex-7010.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wATGCQL3019470;
        Thu, 29 Nov 2018 10:12:27 -0600
From:   Faiz Abbas <faiz_abbas@ti.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <adrian.hunter@intel.com>,
        <michal.simek@xilinx.com>, <kishon@ti.com>, <faiz_abbas@ti.com>
Subject: [PATCH 0/3] Add driver Support for MMCSD on AM654x.
Date:   Thu, 29 Nov 2018 21:45:10 +0530
Message-ID: <20181129161513.31734-1-faiz_abbas@ti.com>
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

[1] driver and phy patches posted before
    https://patchwork.kernel.org/project/linux-mmc/list/?series=26623

Faiz Abbas (3):
  dt-bindings: mmc: sdhci-am654: Document bindings for the host
    controllers on TI's AM654 SOCs
  dt-bindings: mmc: sdhci-of-arasan: Add deprecated message for am654
  mmc: sdhci_am654: Add Initial Support for AM654 SDHCI driver

 .../devicetree/bindings/mmc/arasan,sdhci.txt  |   4 +
 .../devicetree/bindings/mmc/sdhci-am654.txt   |  23 ++
 drivers/mmc/host/Kconfig                      |  12 +
 drivers/mmc/host/Makefile                     |   1 +
 drivers/mmc/host/sdhci-of-arasan.c            |  46 ---
 drivers/mmc/host/sdhci_am654.c                | 366 ++++++++++++++++++
 6 files changed, 406 insertions(+), 46 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-am654.txt
 create mode 100644 drivers/mmc/host/sdhci_am654.c

-- 
2.19.2

