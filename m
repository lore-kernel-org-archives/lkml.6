Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A1CC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC1FA2080D
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:04:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC1FA2080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731124AbeKLFyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:54:01 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51684 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726508AbeKLFx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:53:59 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvss-0000l6-6Q; Sun, 11 Nov 2018 19:59:02 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsV-0001i5-Sh; Sun, 11 Nov 2018 19:58:39 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "David S. Miller" <davem@davemloft.net>,
        "Sergei Shtylyov" <sergei.shtylyov@cogentembedded.com>,
        "Vladimir Zapolskiy" <vladimir_zapolskiy@mentor.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.597631180@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 239/366] sh_eth: fix invalid context bug while
 changing link options by ethtool
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>

commit 5cb3f52a11e18628fc4bee76dd14b1f0b76349de upstream.

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
[bwh: Backported to 3.16:
 - Keep using phy_ethtool_sset()
 - Adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/net/ethernet/renesas/sh_eth.c
+++ b/drivers/net/ethernet/renesas/sh_eth.c
@@ -1727,8 +1727,15 @@ static void sh_eth_adjust_link(struct ne
 {
 	struct sh_eth_private *mdp = netdev_priv(ndev);
 	struct phy_device *phydev = mdp->phydev;
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
@@ -1749,18 +1756,21 @@ static void sh_eth_adjust_link(struct ne
 				     ECMR);
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
@@ -1843,35 +1853,8 @@ static int sh_eth_set_settings(struct ne
 			       struct ethtool_cmd *ecmd)
 {
 	struct sh_eth_private *mdp = netdev_priv(ndev);
-	unsigned long flags;
-	int ret;
-
-	spin_lock_irqsave(&mdp->lock, flags);
 
-	/* disable tx and rx */
-	sh_eth_rcv_snd_disable(ndev);
-
-	ret = phy_ethtool_sset(mdp->phydev, ecmd);
-	if (ret)
-		goto error_exit;
-
-	if (ecmd->duplex == DUPLEX_FULL)
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
+	return phy_ethtool_sset(mdp->phydev, ecmd);
 }
 
 static int sh_eth_nway_reset(struct net_device *ndev)

