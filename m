Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D9B5C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5AA3208C4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:10:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5AA3208C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729543AbeHWLiq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:38:46 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:45456 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728739AbeHWLip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:38:45 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 48CC0C74;
        Thu, 23 Aug 2018 08:10:18 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 083/130] sh_eth: fix invalid context bug while changing link options by ethtool
Date:   Thu, 23 Aug 2018 09:53:19 +0200
Message-Id: <20180823074932.594402949@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074927.161454870@linuxfoundation.org>
References: <20180823074927.161454870@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>

[ Upstream commit 5cb3f52a11e18628fc4bee76dd14b1f0b76349de ]

The change fixes sleep in atomic context bug, which is encountered
every time when link settings are changed by ethtool.

Since commit 35b5f6b1a82b ("PHYLIB: Locking fixes for PHY I/O
potentially sleeping") phy_start_aneg() function utilizes a mutex
to serialize changes to phy state, however that helper function is
called in atomic context under a grabbed spinlock, because
phy_start_aneg() is called by phy_ethtool_ksettings_set() and by
replaced phy_ethtool_sset() helpers from phylib.

Now duplex mode setting is enforced in sh_eth_adjust_link() only,
also now RX/TX is disabled when link is put down or modifications
to E-MAC registers ECMR and GECMR are expected for both cases of
checked and ignored link status pin state from E-MAC interrupt handler.

For reference the change is a partial rework of commit 1e1b812bbe10
("sh_eth: fix handling of no LINK signal").

Fixes: dc19e4e5e02f ("sh: sh_eth: Add support ethtool")
Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Reviewed-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/renesas/sh_eth.c |   49 ++++++++++------------------------
 1 file changed, 15 insertions(+), 34 deletions(-)

--- a/drivers/net/ethernet/renesas/sh_eth.c
+++ b/drivers/net/ethernet/renesas/sh_eth.c
@@ -1743,8 +1743,15 @@ static void sh_eth_adjust_link(struct ne
 {
 	struct sh_eth_private *mdp = netdev_priv(ndev);
 	struct phy_device *phydev = ndev->phydev;
+	unsigned long flags;
 	int new_state = 0;
 
+	spin_lock_irqsave(&mdp->lock, flags);
+
+	/* Disable TX and RX right over here, if E-MAC change is ignored */
+	if (mdp->cd->no_psr || mdp->no_ether_link)
+		sh_eth_rcv_snd_disable(ndev);
+
 	if (phydev->link) {
 		if (phydev->duplex != mdp->duplex) {
 			new_state = 1;
@@ -1763,18 +1770,21 @@ static void sh_eth_adjust_link(struct ne
 			sh_eth_modify(ndev, ECMR, ECMR_TXF, 0);
 			new_state = 1;
 			mdp->link = phydev->link;
-			if (mdp->cd->no_psr || mdp->no_ether_link)
-				sh_eth_rcv_snd_enable(ndev);
 		}
 	} else if (mdp->link) {
 		new_state = 1;
 		mdp->link = 0;
 		mdp->speed = 0;
 		mdp->duplex = -1;
-		if (mdp->cd->no_psr || mdp->no_ether_link)
-			sh_eth_rcv_snd_disable(ndev);
 	}
 
+	/* Enable TX and RX right over here, if E-MAC change is ignored */
+	if ((mdp->cd->no_psr || mdp->no_ether_link) && phydev->link)
+		sh_eth_rcv_snd_enable(ndev);
+
+	mmiowb();
+	spin_unlock_irqrestore(&mdp->lock, flags);
+
 	if (new_state && netif_msg_link(mdp))
 		phy_print_status(phydev);
 }
@@ -1856,39 +1866,10 @@ static int sh_eth_get_link_ksettings(str
 static int sh_eth_set_link_ksettings(struct net_device *ndev,
 				     const struct ethtool_link_ksettings *cmd)
 {
-	struct sh_eth_private *mdp = netdev_priv(ndev);
-	unsigned long flags;
-	int ret;
-
 	if (!ndev->phydev)
 		return -ENODEV;
 
-	spin_lock_irqsave(&mdp->lock, flags);
-
-	/* disable tx and rx */
-	sh_eth_rcv_snd_disable(ndev);
-
-	ret = phy_ethtool_ksettings_set(ndev->phydev, cmd);
-	if (ret)
-		goto error_exit;
-
-	if (cmd->base.duplex == DUPLEX_FULL)
-		mdp->duplex = 1;
-	else
-		mdp->duplex = 0;
-
-	if (mdp->cd->set_duplex)
-		mdp->cd->set_duplex(ndev);
-
-error_exit:
-	mdelay(1);
-
-	/* enable tx and rx */
-	sh_eth_rcv_snd_enable(ndev);
-
-	spin_unlock_irqrestore(&mdp->lock, flags);
-
-	return ret;
+	return phy_ethtool_ksettings_set(ndev->phydev, cmd);
 }
 
 /* If it is ever necessary to increase SH_ETH_REG_DUMP_MAX_REGS, the


