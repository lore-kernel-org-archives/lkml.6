Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41600C282DE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FC6120989
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:35:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="l54Th9Ib"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728534AbfAUHfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:35:03 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:36700 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728150AbfAUHfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:35:03 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0L7Z1jY080654;
        Mon, 21 Jan 2019 01:35:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1548056101;
        bh=UG5LW9b/t1Fp20/hw5Nn9lm1i+/8dr1BINqaxIscQGk=;
        h=From:To:CC:Subject:Date;
        b=l54Th9Ib5oTF/SHXiIU96W4+oMELRbueZkZjFx2SZCArn6ViO8wsr5ng5aC8ZnMXs
         LlYPOPGDxhrdC6zDRRXruByQFY4WPcBo5zfRmbND6a+lTY+M8QgdKLU/ILJsHpN2hW
         nj1xs96pC3SG/TvI9zkxjVJTW2lo33orzkNjdEL0=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0L7Z1VF016981
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Jan 2019 01:35:01 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 21
 Jan 2019 01:35:00 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 21 Jan 2019 01:35:00 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0L7YwI7026303;
        Mon, 21 Jan 2019 01:34:59 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Sekhar Nori <nsekhar@ti.com>, Roger Quadros <rogerq@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH 0/3] PHY: Add support for SERDES in TI's AM654 platform
Date:   Mon, 21 Jan 2019 12:18:10 +0530
Message-ID: <20190121064813.18444-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch series adds support for SERDES module in am654. This also
modifies phy_reset API to invoke pm_runtime_get/pm_runtime_put since
the reset callback can access registers.

Kishon Vijay Abraham I (3):
  phy: core: Invoke pm_runtime_get_*/pm_runtime_put_* before invoking
    reset callback
  dt-bindings: phy: ti: Add dt binding documentation for SERDES in
    AM654x SoC
  phy: ti: Add a new SERDES driver for TI's AM654x SoC

 .../devicetree/bindings/phy/ti-phy.txt        |  77 +++
 drivers/phy/phy-core.c                        |   6 +
 drivers/phy/ti/Kconfig                        |  11 +
 drivers/phy/ti/Makefile                       |   1 +
 drivers/phy/ti/phy-am654-serdes.c             | 528 ++++++++++++++++++
 include/dt-bindings/phy/phy-am654-serdes.h    |  13 +
 6 files changed, 636 insertions(+)
 create mode 100644 drivers/phy/ti/phy-am654-serdes.c
 create mode 100644 include/dt-bindings/phy/phy-am654-serdes.h

-- 
2.17.1

