Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B521AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 11:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 824022146F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 11:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731957AbfAKL5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 06:57:02 -0500
Received: from inva021.nxp.com ([92.121.34.21]:45014 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731289AbfAKL5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 06:57:02 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C346920016F;
        Fri, 11 Jan 2019 12:56:59 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B41F920016E;
        Fri, 11 Jan 2019 12:56:59 +0100 (CET)
Received: from fsr-ub1464-019.ea.freescale.net (fsr-ub1464-019.ea.freescale.net [10.171.81.207])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 558B42031E;
        Fri, 11 Jan 2019 12:56:59 +0100 (CET)
From:   Camelia Groza <camelia.groza@nxp.com>
To:     andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com,
        davem@davemloft.net, oss@buserror.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Camelia Groza <camelia.groza@nxp.com>
Subject: [PATCH net] net: phy: guard against accessing a NULL features bitmap
Date:   Fri, 11 Jan 2019 13:56:46 +0200
Message-Id: <1547207806-30572-1-git-send-email-camelia.groza@nxp.com>
X-Mailer: git-send-email 1.9.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since phy driver features became a link_mode bitmap, phy drivers that
don't have a list of features configured will cause the kernel to crash
when probed.

Fixes: 719655a14971 ("net: phy: Replace phy driver features u32 with link_mode bitmap")
Reported-by: Scott Wood <oss@buserror.net>
Signed-off-by: Camelia Groza <camelia.groza@nxp.com>
---
I'll submit a modified version of this patch to 4.20 stable once this
one is accepted.
---
 drivers/net/phy/phy_device.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 5199000..ddf04ab 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -2154,7 +2154,8 @@ static int phy_probe(struct device *dev)
 	 * a controller will attach, and may modify one
 	 * or both of these values
 	 */
-	linkmode_copy(phydev->supported, phydrv->features);
+	if (phydrv->features)
+		linkmode_copy(phydev->supported, phydrv->features);
 	of_set_phy_supported(phydev);
 	linkmode_copy(phydev->advertising, phydev->supported);
 
@@ -2174,8 +2175,9 @@ static int phy_probe(struct device *dev)
 	 * (e.g. hardware erratum) where the driver wants to set only one
 	 * of these bits.
 	 */
-	if (test_bit(ETHTOOL_LINK_MODE_Pause_BIT, phydrv->features) ||
-	    test_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT, phydrv->features)) {
+	if (phydrv->features &&
+	    (test_bit(ETHTOOL_LINK_MODE_Pause_BIT, phydrv->features) ||
+	     test_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT, phydrv->features))) {
 		linkmode_clear_bit(ETHTOOL_LINK_MODE_Pause_BIT,
 				   phydev->supported);
 		linkmode_clear_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT,
-- 
1.9.1

