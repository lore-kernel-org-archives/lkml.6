Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93FFECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91EA020850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 13:13:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91EA020850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730882AbeGRNv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 09:51:26 -0400
Received: from inva020.nxp.com ([92.121.34.13]:47708 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726181AbeGRNv0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 09:51:26 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 5C7E91A002D;
        Wed, 18 Jul 2018 15:13:32 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 50E111A0012;
        Wed, 18 Jul 2018 15:13:32 +0200 (CEST)
Received: from fsr-ub1464-019.ea.freescale.net (fsr-ub1464-019.ea.freescale.net [10.171.81.207])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 76BA5205E1;
        Wed, 18 Jul 2018 15:13:31 +0200 (CEST)
From:   Camelia Groza <camelia.groza@nxp.com>
To:     andrew@lunn.ch, f.fainelli@gmail.com, davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Camelia Groza <camelia.groza@nxp.com>
Subject: [PATCH] net: phy: use generic clause 45 autonegotiation done
Date:   Wed, 18 Jul 2018 16:12:15 +0300
Message-Id: <1531919535-20269-1-git-send-email-camelia.groza@nxp.com>
X-Mailer: git-send-email 1.9.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only Clause 22 PHYs can use genphy_aneg_done(). Use
genphy_c45_aneg_done() for PHYs that implement Clause 45 without
the Clause 22 register set.

This change follows the model of phy_restart_aneg() which
differentiates between the two implementations in a similar way.

Fixes: 41408ad519f7 ("net: phy: avoid genphy_aneg_done() for PHYs without clause 22 support")
Signed-off-by: Camelia Groza <camelia.groza@nxp.com>
---
 drivers/net/phy/phy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index 537297d..4fcc703 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -151,7 +151,7 @@ int phy_aneg_done(struct phy_device *phydev)
 	 * implement Clause 22 registers
 	 */
 	if (phydev->is_c45 && !(phydev->c45_ids.devices_in_package & BIT(0)))
-		return -EINVAL;
+		return genphy_c45_aneg_done(phydev);
 
 	return genphy_aneg_done(phydev);
 }
-- 
1.9.1

