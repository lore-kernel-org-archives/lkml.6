Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B378AC43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 01:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AD47208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 01:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="N5CLgmkF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AD47208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732635AbeKTLwE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 06:52:04 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:49100 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbeKTLwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 06:52:04 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAK1OSlW030130;
        Mon, 19 Nov 2018 19:24:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1542677068;
        bh=fed6IxSPIH0xAhigqlysN4Bkr2D6HP3w7DjJM+pyIxs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=N5CLgmkFkccyWBD0uH69wEd8HSdqwARcS2REC12gN+h+7/epuA1o81V1fma/AP3f6
         2z0Bvhv/eWivMYNLz0yuAdx/gibSjI4ZbRE03F4rTM8/qLo0gbpm5E9nFK6i7NtiFF
         Rf32jLEZNK7pw05u8dets9D+ifFY9ns1r3XxQaN0=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAK1OSmJ128557
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 19 Nov 2018 19:24:28 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 19
 Nov 2018 19:24:28 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 19 Nov 2018 19:24:28 -0600
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAK1ORt6009048;
        Mon, 19 Nov 2018 19:24:27 -0600
Received: from localhost (uda0226610.dhcp.ti.com [128.247.59.147])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id wAK1ORx26505;
        Mon, 19 Nov 2018 19:24:27 -0600 (CST)
From:   Grygorii Strashko <grygorii.strashko@ti.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Antoine Tenart <antoine.tenart@free-electrons.com>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
CC:     <netdev@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tony Lindgren <tony@atomide.com>,
        <linux-amlogic@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Carlo Caione <carlo@caione.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Manu Gautam <mgautam@codeaurora.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH v3 5/5] phy: core: clean up unused ethernet specific phy modes
Date:   Mon, 19 Nov 2018 19:24:24 -0600
Message-ID: <20181120012424.11802-6-grygorii.strashko@ti.com>
X-Mailer: git-send-email 2.10.5
In-Reply-To: <20181120012424.11802-1-grygorii.strashko@ti.com>
References: <20181120012424.11802-1-grygorii.strashko@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After recent changes PHY_MODE_SGMII, PHY_MODE_2500SGMII, PHY_MODE_QSGMII,
PHY_MODE_10GKR are not used any more and can be removed. Hence - remove
them.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 include/linux/phy/phy.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index 02c9ef0..79da05a 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -35,10 +35,6 @@ enum phy_mode {
 	PHY_MODE_USB_DEVICE_HS,
 	PHY_MODE_USB_DEVICE_SS,
 	PHY_MODE_USB_OTG,
-	PHY_MODE_SGMII,
-	PHY_MODE_2500SGMII,
-	PHY_MODE_QSGMII,
-	PHY_MODE_10GKR,
 	PHY_MODE_UFS_HS_A,
 	PHY_MODE_UFS_HS_B,
 	PHY_MODE_PCIE,
-- 
2.10.5

