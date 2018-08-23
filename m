Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F307DC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B86532084A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:58:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B86532084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387395AbeHWM1S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 08:27:18 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52958 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728086AbeHWM1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 08:27:17 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5F381CA0;
        Thu, 23 Aug 2018 08:58:35 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 200/324] ravb: fix invalid context bug while changing link options by ethtool
Date:   Thu, 23 Aug 2018 09:54:26 +0200
Message-Id: <20180823075006.154988806@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823074955.885811006@linuxfoundation.org>
References: <20180823074955.885811006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>

[ Upstream commit 05925e52a7d379192a5fdff2c33710f573190ead ]

The change fixes sleep in atomic context bug, which is encountered
every time when link settings are changed by ethtool.

Since commit 35b5f6b1a82b ("PHYLIB: Locking fixes for PHY I/O
potentially sleeping") phy_start_aneg() function utilizes a mutex
to serialize changes to phy state, however that helper function is
called in atomic context under a grabbed spinlock, because
phy_start_aneg() is called by phy_ethtool_ksettings_set() and by
replaced phy_ethtool_sset() helpers from phylib.

Now duplex mode setting is enforced in ravb_adjust_link() only, also
now RX/TX is disabled when link is put down or modifications to E-MAC
registers ECMR and GECMR are expected for both cases of checked and
ignored link status pin state from E-MAC interrupt handler.

Fixes: c156633f1353 ("Renesas Ethernet AVB driver proper")
Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Reviewed-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/renesas/ravb_main.c |   49 +++++++++----------------------
 1 file changed, 15 insertions(+), 34 deletions(-)

--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -980,6 +980,13 @@ static void ravb_adjust_link(struct net_
 	struct ravb_private *priv = netdev_priv(ndev);
 	struct phy_device *phydev = ndev->phydev;
 	bool new_state = false;
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	/* Disable TX and RX right over here, if E-MAC change is ignored */
+	if (priv->no_avb_link)
+		ravb_rcv_snd_disable(ndev);
 
 	if (phydev->link) {
 		if (phydev->duplex != priv->duplex) {
@@ -997,18 +1004,21 @@ static void ravb_adjust_link(struct net_
 			ravb_modify(ndev, ECMR, ECMR_TXF, 0);
 			new_state = true;
 			priv->link = phydev->link;
-			if (priv->no_avb_link)
-				ravb_rcv_snd_enable(ndev);
 		}
 	} else if (priv->link) {
 		new_state = true;
 		priv->link = 0;
 		priv->speed = 0;
 		priv->duplex = -1;
-		if (priv->no_avb_link)
-			ravb_rcv_snd_disable(ndev);
 	}
 
+	/* Enable TX and RX right over here, if E-MAC change is ignored */
+	if (priv->no_avb_link && phydev->link)
+		ravb_rcv_snd_enable(ndev);
+
+	mmiowb();
+	spin_unlock_irqrestore(&priv->lock, flags);
+
 	if (new_state && netif_msg_link(priv))
 		phy_print_status(phydev);
 }
@@ -1115,39 +1125,10 @@ static int ravb_get_link_ksettings(struc
 static int ravb_set_link_ksettings(struct net_device *ndev,
 				   const struct ethtool_link_ksettings *cmd)
 {
-	struct ravb_private *priv = netdev_priv(ndev);
-	unsigned long flags;
-	int error;
-
 	if (!ndev->phydev)
 		return -ENODEV;
 
-	spin_lock_irqsave(&priv->lock, flags);
-
-	/* Disable TX and RX */
-	ravb_rcv_snd_disable(ndev);
-
-	error = phy_ethtool_ksettings_set(ndev->phydev, cmd);
-	if (error)
-		goto error_exit;
-
-	if (cmd->base.duplex == DUPLEX_FULL)
-		priv->duplex = 1;
-	else
-		priv->duplex = 0;
-
-	ravb_set_duplex(ndev);
-
-error_exit:
-	mdelay(1);
-
-	/* Enable TX and RX */
-	ravb_rcv_snd_enable(ndev);
-
-	mmiowb();
-	spin_unlock_irqrestore(&priv->lock, flags);
-
-	return error;
+	return phy_ethtool_ksettings_set(ndev->phydev, cmd);
 }
 
 static int ravb_nway_reset(struct net_device *ndev)


