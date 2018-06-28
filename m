Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7BF8C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 19:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D718A275B5
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 15:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="av3oaI/P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D718A275B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966900AbeF1PCn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 11:02:43 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:57566 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966491AbeF1PCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 11:02:42 -0400
X-Greylist: delayed 5368 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Jun 2018 11:02:41 EDT
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w5SDX54V115674;
        Thu, 28 Jun 2018 08:33:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1530192785;
        bh=qqK1gxMbi0qpKQyupk94DOZnVj7K+di/XrkiHpeq3vs=;
        h=From:To:CC:Subject:Date;
        b=av3oaI/PSosxE3uWn2/HjhJAlQ1vwd8zgs1aBHTqG7Z4fY5GN3Od7zHOePV12FXgM
         xOrp3NCFdeX6bbMDJqPlY8/wJXB6Px3nDkTNQce4QoiVAjB6nVz/3Va4i8n06xEqPo
         Czb5MJNPoAcmIkTYsA7A1lQ90GmBb9SRSbqATXtU=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5SDX5LF030754;
        Thu, 28 Jun 2018 08:33:05 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 28
 Jun 2018 08:33:05 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 28 Jun 2018 08:33:04 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5SDX50m014960;
        Thu, 28 Jun 2018 08:33:05 -0500
Received: from localhost (a0272616local-lt.dhcp.ti.com [172.22.190.81])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id w5SDX4x11957;
        Thu, 28 Jun 2018 08:33:04 -0500 (CDT)
From:   Dan Murphy <dmurphy@ti.com>
To:     <andrew@lunn.ch>, <f.fainelli@gmail.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH net v2] net: phy: DP83TC811: Fix diabling interrupts
Date:   Thu, 28 Jun 2018 08:32:53 -0500
Message-ID: <20180628133253.22871-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.12.2
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a bug where INT_STAT1 was written twice and
INT_STAT2 was ignored when disabling interrupts.

Fixes: b753a9faaf9a ("net: phy: DP83TC811: Introduce support for the DP83TC811 phy")
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Dan Murphy <dmurphy@ti.com>
---

v2 - Updated commit message to add the Fixes - http://lists.openwall.net/netdev/2018/06/28/110

 drivers/net/phy/dp83tc811.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/dp83tc811.c b/drivers/net/phy/dp83tc811.c
index 081d99aa3985..49ac678eb2dc 100644
--- a/drivers/net/phy/dp83tc811.c
+++ b/drivers/net/phy/dp83tc811.c
@@ -222,7 +222,7 @@ static int dp83811_config_intr(struct phy_device *phydev)
 		if (err < 0)
 			return err;
 
-		err = phy_write(phydev, MII_DP83811_INT_STAT1, 0);
+		err = phy_write(phydev, MII_DP83811_INT_STAT2, 0);
 	}
 
 	return err;
-- 
2.17.0.582.gccdcbd54c

