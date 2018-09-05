Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E78E6C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 00:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B984206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 00:25:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B984206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726095AbeIEEwn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 00:52:43 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33396 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbeIEEwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 00:52:43 -0400
Received: by mail-pf1-f193.google.com with SMTP id d4-v6so2521559pfn.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 17:25:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oD95rymA/e/4MNKPkFl3JzEBuEGal8AyjU9bY8qoA/I=;
        b=dAQMRdBOXw7BpM+yR5/uTdTAqVU/CGBZaOR6IWQ+NjxarUgc8OtWQspqiDl5s0LcKc
         8naM4kLYK3aiSCcZwrDeBnUo8MH/qEbdt/aY1SWp/xWMjPohi4ojYzgTOtxkJuRmRTgG
         73RfaMnmmERUDangsajUc/QCMwVDs510YFXob9x5AAgPBs8iU6CHShu5qEa62rhPxmlO
         AYzveRj0SYhTUKFgfjlSscUwCgO+m8Yta9Rq2vrDtG+z4VtuqksVEgftshpRF8OcBONr
         C8wC6/9Xs5iaUOvCjsL9dg2FfBEdVTpB4BF/ebWTVLNXuojPIsC4Bct983WC/Sj4VJyK
         nD5Q==
X-Gm-Message-State: APzg51CkLzojsRGoUMgUkguKGsQHAzG7Jdlv2evWvV68MsZnYOXvPNoH
        xJuqgmAQYT+xHwzDL8ICs0pT0Q==
X-Google-Smtp-Source: ANB0Vdag+TAJmLqfUQsjoautZcVGM/Ow+qraml3ueqHeHRd/MackD3SeJpP3rCABA1WIE4EI6kWAZA==
X-Received: by 2002:a62:1d54:: with SMTP id d81-v6mr37708339pfd.139.1536107111298;
        Tue, 04 Sep 2018 17:25:11 -0700 (PDT)
Received: from localhost ([207.114.172.147])
        by smtp.gmail.com with ESMTPSA id l85-v6sm287219pfk.34.2018.09.04.17.25.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Sep 2018 17:25:10 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     netdev@vger.kernel.org
Cc:     davem@davemloft.net, f.fainelli@gmail.com, andrew@lunn.ch,
        alex.williams@ni.com, moritz.fischer@ettus.com,
        linux-kernel@vger.kernel.org, Moritz Fischer <mdf@kernel.org>
Subject: [RFC/PATCH] net: nixge: Add PHYLINK support
Date:   Tue,  4 Sep 2018 17:15:35 -0700
Message-Id: <20180905001535.19168-1-mdf@kernel.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add basic PHYLINK support to driver.

Suggested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---

Hi all,

as Andrew suggested in order to enable SFP as
well as fixed-link support add PHYLINK support.

A couple of questions are still open (hence the RFC):

1) It seems odd to implement PHYLINK callbacks that
   are all empty? If so, should we have generic empty
   ones in drivers/net/phy/phylink.c like we have for
   genphys?

2) If this is ok, then I'll go ahead rework this with
   a DT binding update to deprecate the non-'mdio'-subnode
   case (since there are no in-tree users we might just
   change the binding)?

3) I'm again not sure about the 'select PHYLINK', wouldn't
   wanna break the build again...

Thanks again for your time!

Moritz

---
 drivers/net/ethernet/ni/Kconfig |   1 +
 drivers/net/ethernet/ni/nixge.c | 115 +++++++++++++++++++++++---------
 2 files changed, 83 insertions(+), 33 deletions(-)

diff --git a/drivers/net/ethernet/ni/Kconfig b/drivers/net/ethernet/ni/Kconfig
index c73978474c4b..80cd72948551 100644
--- a/drivers/net/ethernet/ni/Kconfig
+++ b/drivers/net/ethernet/ni/Kconfig
@@ -21,6 +21,7 @@ config NI_XGE_MANAGEMENT_ENET
 	depends on HAS_IOMEM && HAS_DMA
 	select PHYLIB
 	select OF_MDIO if OF
+	select PHYLINK
 	help
 	  Simple LAN device for debug or management purposes. Can
 	  support either 10G or 1G PHYs via SFP+ ports.
diff --git a/drivers/net/ethernet/ni/nixge.c b/drivers/net/ethernet/ni/nixge.c
index 74cf52e3fb09..a0e790d07b1c 100644
--- a/drivers/net/ethernet/ni/nixge.c
+++ b/drivers/net/ethernet/ni/nixge.c
@@ -11,6 +11,7 @@
 #include <linux/of_mdio.h>
 #include <linux/of_net.h>
 #include <linux/of_platform.h>
+#include <linux/phylink.h>
 #include <linux/of_irq.h>
 #include <linux/skbuff.h>
 #include <linux/phy.h>
@@ -165,7 +166,7 @@ struct nixge_priv {
 	struct device *dev;
 
 	/* Connection to PHY device */
-	struct device_node *phy_node;
+	struct phylink *phylink;
 	phy_interface_t		phy_mode;
 
 	int link;
@@ -416,20 +417,6 @@ static void nixge_device_reset(struct net_device *ndev)
 	netif_trans_update(ndev);
 }
 
-static void nixge_handle_link_change(struct net_device *ndev)
-{
-	struct nixge_priv *priv = netdev_priv(ndev);
-	struct phy_device *phydev = ndev->phydev;
-
-	if (phydev->link != priv->link || phydev->speed != priv->speed ||
-	    phydev->duplex != priv->duplex) {
-		priv->link = phydev->link;
-		priv->speed = phydev->speed;
-		priv->duplex = phydev->duplex;
-		phy_print_status(phydev);
-	}
-}
-
 static void nixge_tx_skb_unmap(struct nixge_priv *priv,
 			       struct nixge_tx_skb *tx_skb)
 {
@@ -859,17 +846,15 @@ static void nixge_dma_err_handler(unsigned long data)
 static int nixge_open(struct net_device *ndev)
 {
 	struct nixge_priv *priv = netdev_priv(ndev);
-	struct phy_device *phy;
 	int ret;
 
 	nixge_device_reset(ndev);
 
-	phy = of_phy_connect(ndev, priv->phy_node,
-			     &nixge_handle_link_change, 0, priv->phy_mode);
-	if (!phy)
-		return -ENODEV;
+	ret = phylink_of_phy_connect(priv->phylink, priv->dev->of_node, 0);
+	if (ret < 0)
+		return ret;
 
-	phy_start(phy);
+	phylink_start(priv->phylink);
 
 	/* Enable tasklets for Axi DMA error handling */
 	tasklet_init(&priv->dma_err_tasklet, nixge_dma_err_handler,
@@ -893,8 +878,7 @@ static int nixge_open(struct net_device *ndev)
 err_rx_irq:
 	free_irq(priv->tx_irq, ndev);
 err_tx_irq:
-	phy_stop(phy);
-	phy_disconnect(phy);
+	phylink_disconnect_phy(priv->phylink);
 	tasklet_kill(&priv->dma_err_tasklet);
 	netdev_err(ndev, "request_irq() failed\n");
 	return ret;
@@ -908,9 +892,9 @@ static int nixge_stop(struct net_device *ndev)
 	netif_stop_queue(ndev);
 	napi_disable(&priv->napi);
 
-	if (ndev->phydev) {
-		phy_stop(ndev->phydev);
-		phy_disconnect(ndev->phydev);
+	if (priv->phylink) {
+		phylink_stop(priv->phylink);
+		phylink_disconnect_phy(priv->phylink);
 	}
 
 	cr = nixge_dma_read_reg(priv, XAXIDMA_RX_CR_OFFSET);
@@ -1076,13 +1060,31 @@ static int nixge_ethtools_set_phys_id(struct net_device *ndev,
 	return 0;
 }
 
+static int
+nixge_ethtool_set_link_ksettings(struct net_device *ndev,
+				 const struct ethtool_link_ksettings *cmd)
+{
+	struct nixge_priv *priv = netdev_priv(ndev);
+
+	return phylink_ethtool_ksettings_set(priv->phylink, cmd);
+}
+
+static int
+nixge_ethtool_get_link_ksettings(struct net_device *ndev,
+				 struct ethtool_link_ksettings *cmd)
+{
+	struct nixge_priv *priv = netdev_priv(ndev);
+
+	return phylink_ethtool_ksettings_get(priv->phylink, cmd);
+}
+
 static const struct ethtool_ops nixge_ethtool_ops = {
 	.get_drvinfo    = nixge_ethtools_get_drvinfo,
 	.get_coalesce   = nixge_ethtools_get_coalesce,
 	.set_coalesce   = nixge_ethtools_set_coalesce,
 	.set_phys_id    = nixge_ethtools_set_phys_id,
-	.get_link_ksettings     = phy_ethtool_get_link_ksettings,
-	.set_link_ksettings     = phy_ethtool_set_link_ksettings,
+	.get_link_ksettings     = nixge_ethtool_get_link_ksettings,
+	.set_link_ksettings     = nixge_ethtool_set_link_ksettings,
 	.get_link		= ethtool_op_get_link,
 };
 
@@ -1225,11 +1227,52 @@ static void *nixge_get_nvmem_address(struct device *dev)
 	return mac;
 }
 
+static void nixge_validate(struct net_device *ndev, unsigned long *supported,
+			   struct phylink_link_state *state)
+{
+}
+
+static int nixge_mac_link_state(struct net_device *ndev,
+				struct phylink_link_state *state)
+{
+	return 0;
+}
+
+static void nixge_mac_config(struct net_device *ndev, unsigned int mode,
+			     const struct phylink_link_state *state)
+{
+}
+
+static void nixge_mac_an_restart(struct net_device *ndev)
+{
+}
+
+static void nixge_mac_link_down(struct net_device *ndev, unsigned int mode,
+				phy_interface_t interface)
+{
+}
+
+static void nixge_mac_link_up(struct net_device *ndev, unsigned int mode,
+			      phy_interface_t interface,
+			      struct phy_device *phy)
+{
+}
+
+static const struct phylink_mac_ops nixge_phylink_ops = {
+	.validate = nixge_validate,
+	.mac_link_state = nixge_mac_link_state,
+	.mac_an_restart = nixge_mac_an_restart,
+	.mac_config = nixge_mac_config,
+	.mac_link_down = nixge_mac_link_down,
+	.mac_link_up = nixge_mac_link_up,
+};
+
 static int nixge_probe(struct platform_device *pdev)
 {
 	struct nixge_priv *priv;
 	struct net_device *ndev;
 	struct resource *dmares;
+	struct device_node *mn;
 	const u8 *mac_addr;
 	int err;
 
@@ -1286,7 +1329,13 @@ static int nixge_probe(struct platform_device *pdev)
 	priv->coalesce_count_rx = XAXIDMA_DFT_RX_THRESHOLD;
 	priv->coalesce_count_tx = XAXIDMA_DFT_TX_THRESHOLD;
 
-	err = nixge_mdio_setup(priv, pdev->dev.of_node);
+	mn = of_get_child_by_name(pdev->dev.of_node, "mdio");
+	if (!mn) {
+		dev_warn(&pdev->dev, "No \"mdio\" subnode found, defaulting to legacy\n");
+		mn = pdev->dev.of_node;
+	}
+
+	err = nixge_mdio_setup(priv, mn);
 	if (err) {
 		netdev_err(ndev, "error registering mdio bus");
 		goto free_netdev;
@@ -1299,10 +1348,10 @@ static int nixge_probe(struct platform_device *pdev)
 		goto unregister_mdio;
 	}
 
-	priv->phy_node = of_parse_phandle(pdev->dev.of_node, "phy-handle", 0);
-	if (!priv->phy_node) {
-		netdev_err(ndev, "not find \"phy-handle\" property\n");
-		err = -EINVAL;
+	priv->phylink = phylink_create(ndev, pdev->dev.fwnode, priv->phy_mode,
+				       &nixge_phylink_ops);
+	if (IS_ERR(priv->phylink)) {
+		err = PTR_ERR(priv->phylink);
 		goto unregister_mdio;
 	}
 
-- 
2.18.0

