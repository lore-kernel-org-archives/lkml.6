Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF72C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20C3020867
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:56:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20C3020867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbeH1Vtm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 17:49:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:51104 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727040AbeH1Vtm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 17:49:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B2C49AF4A;
        Tue, 28 Aug 2018 17:56:53 +0000 (UTC)
Received: by unicorn.suse.cz (Postfix, from userid 1000)
        id 6403BA0C37; Tue, 28 Aug 2018 19:56:53 +0200 (CEST)
Message-Id: <33df6a13852258285819ffe3940d3d14ece9bbe8.1535477409.git.mkubecek@suse.cz>
In-Reply-To: <cover.1535477409.git.mkubecek@suse.cz>
References: <cover.1535477409.git.mkubecek@suse.cz>
From:   Michal Kubecek <mkubecek@suse.cz>
Subject: [PATCH net-next 1/2] 8390/etherh: convert to
 ethtool_{get,set}_link_ksettings
To:     "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Tue, 28 Aug 2018 19:56:53 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the last in-tree driver using the old {get,set}_settings API.

Note: this is only build tested. I don't have the hardware at hand; as it's
10Mb/s half duplex device and driver can be built only for one subplatform
of 32-bit ARM (Acorn RiscPC), it may be difficult to find someone who does.

Signed-off-by: Michal Kubecek <mkubecek@suse.cz>
---
 drivers/net/ethernet/8390/etherh.c | 35 ++++++++++++++++--------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/8390/etherh.c b/drivers/net/ethernet/8390/etherh.c
index 32e9627e3880..77191a281866 100644
--- a/drivers/net/ethernet/8390/etherh.c
+++ b/drivers/net/ethernet/8390/etherh.c
@@ -564,26 +564,29 @@ static void etherh_get_drvinfo(struct net_device *dev, struct ethtool_drvinfo *i
 		sizeof(info->bus_info));
 }
 
-static int etherh_get_settings(struct net_device *dev, struct ethtool_cmd *cmd)
+static int etherh_get_link_ksettings(struct net_device *dev,
+				     struct ethtool_link_ksettings *cmd)
 {
-	cmd->supported	= etherh_priv(dev)->supported;
-	ethtool_cmd_speed_set(cmd, SPEED_10);
-	cmd->duplex	= DUPLEX_HALF;
-	cmd->port	= dev->if_port == IF_PORT_10BASET ? PORT_TP : PORT_BNC;
-	cmd->autoneg	= (dev->flags & IFF_AUTOMEDIA ?
-			   AUTONEG_ENABLE : AUTONEG_DISABLE);
+	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
+						etherh_priv(dev)->supported);
+	cmd->base.speed = SPEED_10;
+	cmd->base.duplex = DUPLEX_HALF;
+	cmd->base.port = dev->if_port == IF_PORT_10BASET ? PORT_TP : PORT_BNC;
+	cmd->base.autoneg = (dev->flags & IFF_AUTOMEDIA ? AUTONEG_ENABLE :
+							  AUTONEG_DISABLE);
 	return 0;
 }
 
-static int etherh_set_settings(struct net_device *dev, struct ethtool_cmd *cmd)
+static int etherh_set_link_ksettings(struct net_device *dev,
+				     const struct ethtool_link_ksettings *cmd)
 {
-	switch (cmd->autoneg) {
+	switch (cmd->base.autoneg) {
 	case AUTONEG_ENABLE:
 		dev->flags |= IFF_AUTOMEDIA;
 		break;
 
 	case AUTONEG_DISABLE:
-		switch (cmd->port) {
+		switch (cmd->base.port) {
 		case PORT_TP:
 			dev->if_port = IF_PORT_10BASET;
 			break;
@@ -622,12 +625,12 @@ static void etherh_set_msglevel(struct net_device *dev, u32 v)
 }
 
 static const struct ethtool_ops etherh_ethtool_ops = {
-	.get_settings	= etherh_get_settings,
-	.set_settings	= etherh_set_settings,
-	.get_drvinfo	= etherh_get_drvinfo,
-	.get_ts_info	= ethtool_op_get_ts_info,
-	.get_msglevel	= etherh_get_msglevel,
-	.set_msglevel	= etherh_set_msglevel,
+	.get_drvinfo		= etherh_get_drvinfo,
+	.get_ts_info		= ethtool_op_get_ts_info,
+	.get_msglevel		= etherh_get_msglevel,
+	.set_msglevel		= etherh_set_msglevel,
+	.get_link_ksettings	= etherh_get_link_ksettings,
+	.set_link_ksettings	= etherh_set_link_ksettings,
 };
 
 static const struct net_device_ops etherh_netdev_ops = {
-- 
2.18.0

