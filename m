Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05465C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C86072184E
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 11:08:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OBi9ZHTK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728945AbfBFLIh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 06:08:37 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:40164 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbfBFLIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 06:08:36 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x16B8ZFn021531;
        Wed, 6 Feb 2019 05:08:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549451315;
        bh=dbQkSPHc2KXm8g+32WtLpuqLCuqUVFDtEZDlhlNFuSA=;
        h=From:To:CC:Subject:Date;
        b=OBi9ZHTKDVfVwtoD15ZZAj4B7HGPsEkkNMKnes4P7sqfyeHJLudt+Mxo81VwkDyxG
         CdkqmlEQb5I9EIV7OKD7TBOaANMEpyScMgbDpdfE4944Esmq8+lEs6U3Zso4e3eSkO
         V/fHKdRuh+mhGzbuqfSELg2Rzp0mTJpZefS2SE8Q=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x16B8ZS0105047
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 6 Feb 2019 05:08:35 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 6
 Feb 2019 05:08:35 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 6 Feb 2019 05:08:34 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x16B8WaY024645;
        Wed, 6 Feb 2019 05:08:33 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Roger Quadros <rogerq@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/4] PHY: Add support for SERDES in TI's AM654 platform
Date:   Wed, 6 Feb 2019 16:37:49 +0530
Message-ID: <20190206110753.28738-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series
  *) adds support for SERDES module in am654
  *) modifies phy_reset API to invoke pm_runtime_get/pm_runtime_put since
the reset callback can access registers.
  *) Add *release* phy_ops to be invoked when the consumer relinquishes
PHY

Changes from v1:
  *) Add *release* phy ops
  *) Populate release phy_ops in phy-am654-serdes to cleanup
initializations done in of_xlate

Kishon Vijay Abraham I (4):
  phy: core: Add *release* phy_ops invoked when the consumer
    relinquishes PHY
  phy: core: Invoke pm_runtime_get_*/pm_runtime_put_* before invoking
    reset callback
  dt-bindings: phy: ti: Add dt binding documentation for SERDES in
    AM654x SoC
  phy: ti: Add a new SERDES driver for TI's AM654x SoC

 .../devicetree/bindings/phy/ti-phy.txt        |  77 +++
 drivers/phy/phy-core.c                        |  11 +
 drivers/phy/ti/Kconfig                        |  11 +
 drivers/phy/ti/Makefile                       |   1 +
 drivers/phy/ti/phy-am654-serdes.c             | 539 ++++++++++++++++++
 include/dt-bindings/phy/phy-am654-serdes.h    |  13 +
 include/linux/phy/phy.h                       |   2 +
 7 files changed, 654 insertions(+)
 create mode 100644 drivers/phy/ti/phy-am654-serdes.c
 create mode 100644 include/dt-bindings/phy/phy-am654-serdes.h

-- 
2.17.1

