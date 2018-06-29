Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D72F4C6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 16:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B4D82517F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 16:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="p7IGfKkf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B4D82517F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936593AbeF2QwP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 12:52:15 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:42518 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932460AbeF2QwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 12:52:14 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w5TFSic5082325;
        Fri, 29 Jun 2018 10:28:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1530286124;
        bh=l4YipK+w/nEhXWi3fNi7UZAH3lTmWH5I62HygjmgKFc=;
        h=From:To:CC:Subject:Date;
        b=p7IGfKkfFuLEriAlsGjZHpcQ6RhSt1WGZ1ao7vJvkjxz6vFPNeyts+DGGgVbyEgVy
         mgFfO79nOZrcuGbF/71rOZkAyW5iT9/sJGuwZbF+6CrqGOQZZ3ZVRymUgnCIL5xYOX
         drIJyY18rcTjHooWzdLIhBZjg8NbPlTyJQ5qv5JE=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5TFSitg007498;
        Fri, 29 Jun 2018 10:28:44 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 29
 Jun 2018 10:28:44 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 29 Jun 2018 10:28:43 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5TFSh8U016480;
        Fri, 29 Jun 2018 10:28:43 -0500
Received: from localhost (a0272616local-lt.dhcp.ti.com [172.22.149.121])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id w5TFShx17017;
        Fri, 29 Jun 2018 10:28:43 -0500 (CDT)
From:   Dan Murphy <dmurphy@ti.com>
To:     <andrew@lunn.ch>, <f.fainelli@gmail.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH net v3] net: phy: DP83TC811: Fix disabling interrupts
Date:   Fri, 29 Jun 2018 10:28:31 -0500
Message-ID: <20180629152831.23259-1-dmurphy@ti.com>
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

v3 - Fix subject misspelling
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

