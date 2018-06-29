Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE22C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 15:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C79AB28071
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 15:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JgNq3J9o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C79AB28071
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966028AbeF2PgI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 11:36:08 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:43136 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752225AbeF2PgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 11:36:06 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w5TFZwHa114884;
        Fri, 29 Jun 2018 10:35:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1530286558;
        bh=RPhTbVnvi256NBldU8FbitfughbHmZpBL5A4omRqQ8M=;
        h=From:To:CC:Subject:Date;
        b=JgNq3J9o4vyv7y8nUgwBSrT/2y4quRJ0n06/rGWcm/JYBlA6x25SdInn/YcUoMMlR
         S+LTRL8PJ/TpUp1HaY2p6NjuqYK1KtjJqDBeHfn0S73aQBualPfOfv7p4dxh2oMu1O
         PBdW7PeV5J7v6MsaZ87Md8+fdXD+IFyZ3VjBpsTA=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5TFZwA9011194;
        Fri, 29 Jun 2018 10:35:58 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 29
 Jun 2018 10:35:57 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 29 Jun 2018 10:35:57 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5TFZv7K019307;
        Fri, 29 Jun 2018 10:35:57 -0500
Received: from localhost (a0272616local-lt.dhcp.ti.com [172.22.149.121])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id w5TFZvx17690;
        Fri, 29 Jun 2018 10:35:57 -0500 (CDT)
From:   Dan Murphy <dmurphy@ti.com>
To:     <andrew@lunn.ch>, <f.fainelli@gmail.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH net-next v2 1/2] net: phy: DP83TC811: Add INT_STAT3
Date:   Fri, 29 Jun 2018 10:35:45 -0500
Message-ID: <20180629153546.24107-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.12.2
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add INT_STAT3 interrupt setting and clearing
support.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---

v2 - Removed bug fix removal of writing INT_STAT1 twice when disabling interrupts

 drivers/net/phy/dp83tc811.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/net/phy/dp83tc811.c b/drivers/net/phy/dp83tc811.c
index 49ac678eb2dc..f8653f5d8789 100644
--- a/drivers/net/phy/dp83tc811.c
+++ b/drivers/net/phy/dp83tc811.c
@@ -21,6 +21,7 @@
 #define MII_DP83811_SGMII_CTRL	0x09
 #define MII_DP83811_INT_STAT1	0x12
 #define MII_DP83811_INT_STAT2	0x13
+#define MII_DP83811_INT_STAT3	0x18
 #define MII_DP83811_RESET_CTRL	0x1f
 
 #define DP83811_HW_RESET	BIT(15)
@@ -44,6 +45,11 @@
 #define DP83811_OVERVOLTAGE_INT_EN	BIT(6)
 #define DP83811_UNDERVOLTAGE_INT_EN	BIT(7)
 
+/* INT_STAT3 bits */
+#define DP83811_LPS_INT_EN	BIT(0)
+#define DP83811_NO_FRAME_INT_EN	BIT(3)
+#define DP83811_POR_DONE_INT_EN	BIT(4)
+
 #define MII_DP83811_RXSOP1	0x04a5
 #define MII_DP83811_RXSOP2	0x04a6
 #define MII_DP83811_RXSOP3	0x04a7
@@ -81,6 +87,10 @@ static int dp83811_ack_interrupt(struct phy_device *phydev)
 	if (err < 0)
 		return err;
 
+	err = phy_read(phydev, MII_DP83811_INT_STAT3);
+	if (err < 0)
+		return err;
+
 	return 0;
 }
 
@@ -216,6 +226,18 @@ static int dp83811_config_intr(struct phy_device *phydev)
 				DP83811_UNDERVOLTAGE_INT_EN);
 
 		err = phy_write(phydev, MII_DP83811_INT_STAT2, misr_status);
+		if (err < 0)
+			return err;
+
+		misr_status = phy_read(phydev, MII_DP83811_INT_STAT3);
+		if (misr_status < 0)
+			return misr_status;
+
+		misr_status |= (DP83811_LPS_INT_EN |
+				DP83811_NO_FRAME_INT_EN |
+				DP83811_POR_DONE_INT_EN);
+
+		err = phy_write(phydev, MII_DP83811_INT_STAT3, misr_status);
 
 	} else {
 		err = phy_write(phydev, MII_DP83811_INT_STAT1, 0);
@@ -223,6 +245,10 @@ static int dp83811_config_intr(struct phy_device *phydev)
 			return err;
 
 		err = phy_write(phydev, MII_DP83811_INT_STAT2, 0);
+		if (err < 0)
+			return err;
+
+		err = phy_write(phydev, MII_DP83811_INT_STAT3, 0);
 	}
 
 	return err;
-- 
2.17.0.582.gccdcbd54c

