Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F033ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:06:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E04EB20852
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 15:06:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E04EB20852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388290AbeGWQIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 12:08:17 -0400
Received: from inva021.nxp.com ([92.121.34.21]:36056 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387852AbeGWQIQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 12:08:16 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E5381200029;
        Mon, 23 Jul 2018 17:06:35 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D65A2200027;
        Mon, 23 Jul 2018 17:06:35 +0200 (CEST)
Received: from fsr-ub1464-019.ea.freescale.net (fsr-ub1464-019.ea.freescale.net [10.171.81.207])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 7B6CD205DB;
        Mon, 23 Jul 2018 17:06:35 +0200 (CEST)
From:   Camelia Groza <camelia.groza@nxp.com>
To:     andrew@lunn.ch, f.fainelli@gmail.com, rmk+kernel@armlinux.org.uk,
        davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Camelia Groza <camelia.groza@nxp.com>
Subject: [PATCH net-next] net: phy: prevent PHYs w/o Clause 22 regs from calling genphy_config_aneg
Date:   Mon, 23 Jul 2018 18:06:15 +0300
Message-Id: <1532358375-8146-1-git-send-email-camelia.groza@nxp.com>
X-Mailer: git-send-email 1.9.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

genphy_config_aneg() should be called only by PHYs that implement
the Clause 22 register set. Prevent Clause 45 PHYs that don't implement
the register set from calling the genphy function.

Signed-off-by: Camelia Groza <camelia.groza@nxp.com>
---
 drivers/net/phy/phy.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index efa0a3c..6049652 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -471,8 +471,14 @@ static int phy_config_aneg(struct phy_device *phydev)
 {
 	if (phydev->drv->config_aneg)
 		return phydev->drv->config_aneg(phydev);
-	else
-		return genphy_config_aneg(phydev);
+
+	/* Clause 45 PHYs that don't implement Clause 22 registers are not
+	 * allowed to call genphy_config_aneg()
+	 */
+	if (phydev->is_c45 && !(phydev->c45_ids.devices_in_package & BIT(0)))
+		return -EOPNOTSUPP;
+
+	return genphy_config_aneg(phydev);
 }
 
 /**
-- 
1.9.1

