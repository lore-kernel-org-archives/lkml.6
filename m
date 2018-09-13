Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1827C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FD6720854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:51:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FD6720854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730810AbeIMTA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:00:56 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33280 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbeIMTAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:00:55 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9F1F6D10;
        Thu, 13 Sep 2018 13:51:20 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ahmad Fatoum <a.fatoum@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.18 022/197] net: macb: Fix regression breaking non-MDIO fixed-link PHYs
Date:   Thu, 13 Sep 2018 15:29:31 +0200
Message-Id: <20180913131842.454065227@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180913131841.568116777@linuxfoundation.org>
References: <20180913131841.568116777@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ahmad Fatoum <a.fatoum@pengutronix.de>

[ Upstream commit ab5f11055fdf8dfc3ddbd89e8e3cc550de41d1d3 ]

commit 739de9a1563a ("net: macb: Reorganize macb_mii bringup") broke
initializing macb on the EVB-KSZ9477 eval board.
There, of_mdiobus_register was called even for the fixed-link representing
the RGMII-link to the switch with the result that the driver attempts to
enumerate PHYs on a non-existent MDIO bus:

	libphy: MACB_mii_bus: probed
	mdio_bus f0028000.ethernet-ffffffff: fixed-link has invalid PHY address
	mdio_bus f0028000.ethernet-ffffffff: scan phy fixed-link at address 0
        [snip]
	mdio_bus f0028000.ethernet-ffffffff: scan phy fixed-link at address 31

The "MDIO" bus registration succeeds regardless, having claimed the reset GPIO,
and calling of_phy_register_fixed_link later on fails because it tries
to claim the same GPIO:

	macb f0028000.ethernet: broken fixed-link specification

Fix this by registering the fixed-link before calling mdiobus_register.

Fixes: 739de9a1563a ("net: macb: Reorganize macb_mii bringup")
Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/cadence/macb_main.c |   27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -481,11 +481,6 @@ static int macb_mii_probe(struct net_dev
 
 	if (np) {
 		if (of_phy_is_fixed_link(np)) {
-			if (of_phy_register_fixed_link(np) < 0) {
-				dev_err(&bp->pdev->dev,
-					"broken fixed-link specification\n");
-				return -ENODEV;
-			}
 			bp->phy_node = of_node_get(np);
 		} else {
 			bp->phy_node = of_parse_phandle(np, "phy-handle", 0);
@@ -568,7 +563,7 @@ static int macb_mii_init(struct macb *bp
 {
 	struct macb_platform_data *pdata;
 	struct device_node *np;
-	int err;
+	int err = -ENXIO;
 
 	/* Enable management port */
 	macb_writel(bp, NCR, MACB_BIT(MPE));
@@ -591,12 +586,23 @@ static int macb_mii_init(struct macb *bp
 	dev_set_drvdata(&bp->dev->dev, bp->mii_bus);
 
 	np = bp->pdev->dev.of_node;
-	if (pdata)
-		bp->mii_bus->phy_mask = pdata->phy_mask;
+	if (np && of_phy_is_fixed_link(np)) {
+		if (of_phy_register_fixed_link(np) < 0) {
+			dev_err(&bp->pdev->dev,
+				"broken fixed-link specification %pOF\n", np);
+			goto err_out_free_mdiobus;
+		}
+
+		err = mdiobus_register(bp->mii_bus);
+	} else {
+		if (pdata)
+			bp->mii_bus->phy_mask = pdata->phy_mask;
+
+		err = of_mdiobus_register(bp->mii_bus, np);
+	}
 
-	err = of_mdiobus_register(bp->mii_bus, np);
 	if (err)
-		goto err_out_free_mdiobus;
+		goto err_out_free_fixed_link;
 
 	err = macb_mii_probe(bp->dev);
 	if (err)
@@ -606,6 +612,7 @@ static int macb_mii_init(struct macb *bp
 
 err_out_unregister_bus:
 	mdiobus_unregister(bp->mii_bus);
+err_out_free_fixed_link:
 	if (np && of_phy_is_fixed_link(np))
 		of_phy_deregister_fixed_link(np);
 err_out_free_mdiobus:


