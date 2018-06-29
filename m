Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D81A2C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 15:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84CA228071
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 15:36:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EgGP/KiZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84CA228071
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966076AbeF2PgJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 11:36:09 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:43658 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753318AbeF2PgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 11:36:06 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w5TFZweY026546;
        Fri, 29 Jun 2018 10:35:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1530286558;
        bh=obJSGThw7Yq/ZleoBGB6MTxPf0hoqhCyDaXF+ZzNZmY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=EgGP/KiZdTwQVTAN/tHcKa97OukwX+IrwjTitiZgDsVFZZe4PsBIymoR7YcHx6x/a
         q2dYrbfQ8WJ6M+KlZBehlIsgIaoTYkxtj0pUMJj0SMXqV1S2MedVg6/53uB0KgpTMn
         9ej2uxrcFfmmf3zROdoQHKo/imcwi0rXzBHFFWRk=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5TFZwE9021037;
        Fri, 29 Jun 2018 10:35:58 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 29
 Jun 2018 10:35:58 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 29 Jun 2018 10:35:58 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5TFZwhj031772;
        Fri, 29 Jun 2018 10:35:58 -0500
Received: from localhost (a0272616local-lt.dhcp.ti.com [172.22.149.121])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id w5TFZvx17694;
        Fri, 29 Jun 2018 10:35:58 -0500 (CDT)
From:   Dan Murphy <dmurphy@ti.com>
To:     <andrew@lunn.ch>, <f.fainelli@gmail.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH net-next v2 2/2] net: phy: DP83TC811: Fix SGMII enable/disable
Date:   Fri, 29 Jun 2018 10:35:46 -0500
Message-ID: <20180629153546.24107-2-dmurphy@ti.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20180629153546.24107-1-dmurphy@ti.com>
References: <20180629153546.24107-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If SGMII was selected in the DT then the device should
write the SGMII enable bit.

If SGMII is not selected in the DT then the SGMII bit
should be disabled.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---

v2 - Removed erroneous defconfig addtion in the patch.

 drivers/net/phy/dp83tc811.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/net/phy/dp83tc811.c b/drivers/net/phy/dp83tc811.c
index f8653f5d8789..78cad134a79e 100644
--- a/drivers/net/phy/dp83tc811.c
+++ b/drivers/net/phy/dp83tc811.c
@@ -284,21 +284,19 @@ static int dp83811_config_init(struct phy_device *phydev)
 	if (err < 0)
 		return err;
 
+	value = phy_read(phydev, MII_DP83811_SGMII_CTRL);
 	if (phydev->interface == PHY_INTERFACE_MODE_SGMII) {
-		value = phy_read(phydev, MII_DP83811_SGMII_CTRL);
-		if (!(value & DP83811_SGMII_EN)) {
-			err = phy_write(phydev, MII_DP83811_SGMII_CTRL,
+		err = phy_write(phydev, MII_DP83811_SGMII_CTRL,
 					(DP83811_SGMII_EN | value));
-			if (err < 0)
-				return err;
-		} else {
-			err = phy_write(phydev, MII_DP83811_SGMII_CTRL,
-					(~DP83811_SGMII_EN & value));
-			if (err < 0)
-				return err;
-		}
+	} else {
+		err = phy_write(phydev, MII_DP83811_SGMII_CTRL,
+				(~DP83811_SGMII_EN & value));
 	}
 
+	if (err < 0)
+
+		return err;
+
 	value = DP83811_WOL_MAGIC_EN | DP83811_WOL_SECURE_ON | DP83811_WOL_EN;
 
 	return phy_write_mmd(phydev, DP83811_DEVADDR, MII_DP83811_WOL_CFG,
-- 
2.17.0.582.gccdcbd54c

