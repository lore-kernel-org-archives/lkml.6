Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0389C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EF7D222CF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ukcGLI2h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392448AbfBMWHv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 17:07:51 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45064 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730382AbfBMWHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 17:07:47 -0500
Received: by mail-pl1-f196.google.com with SMTP id r14so1855417pls.12;
        Wed, 13 Feb 2019 14:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=g2+XpA5ni4P8phE+1KGFcK1ujquQd92gmwto6EnDuBU=;
        b=ukcGLI2hsEhE6xbWBPkxxgsFDgBFuHWRCSi9hoOAVgn72tC0EekrHfFaCqyHHLo1xR
         QFui0eDUHVJjFScQ2zisheQZ7xyv83Vkn8OwqOehwhM820Xk5bJshNAjwnNGYl5n8FKH
         7cOuKYldlMnH1GRf1cEG1hXpVTM+EFNcCxcVvWPptXeqiRiniJKxuFqvQXv/g+E69VEr
         5Dglu80QWA3AwO1zPKi0YvG4YEIpQmMa9B6JAp1EBSOeiScpc9bDqdODcUekd8SUPQmT
         LktmUJJMbX1Rky5B3GFHBnSqLP5Mcl1+3+09GZDy/8miZ0agPCOffUlV+n6L8cxbDy7N
         0PfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=g2+XpA5ni4P8phE+1KGFcK1ujquQd92gmwto6EnDuBU=;
        b=AsWV/ELQAnJ6Nx5rhwATlpQWiLWN6Mox1+rnAMrsaHkW6lIVEr2wVnjH6FDfzNArwV
         I0P+a7M1T8n14KIyMfa4LrqvD8HjUwggDuJ4Ahp6Xpg/cDzqxZOU0xDnOH81WM2uhh3A
         ZBDLBJHwNUf8FAM8dVpuUgt0qvFse2JjkRi1p9sURR1n4QRr2R9ogwDo8gEDRHupwCCh
         lgeq+UlFB7ovpkF1Izq9kVftJBH/mYW3ZlE7a3dZHd9k3WJWz5Z2FiK5l1GCR0NMtfnX
         M9nrEVGaDr0VP91J+fFaBb26X5/351H2DR9yq5q5hnfapD+WWCYVEp3AqUZraIEAgqEj
         V+Kg==
X-Gm-Message-State: AHQUAuapoPVNG54nNbwF+6wHqP06f7npgca0ZLL0Yb4F8WsSw84vbVWL
        hpVztgiy+H3DD865fRiAO2hekf/h
X-Google-Smtp-Source: AHgI3IZXVg0G1d8VwY8AutKkd+3pP+trL+LKJ297RDgB+HUMXrVOoeFRIC9f9csPprcqq6ox7aYSMg==
X-Received: by 2002:a17:902:bd82:: with SMTP id q2mr456485pls.156.1550095666611;
        Wed, 13 Feb 2019 14:07:46 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id o1sm383735pgn.63.2019.02.13.14.07.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 14:07:45 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        linux-kernel@vger.kernel.org (open list),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE),
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next 8/9] net: Remove SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT
Date:   Wed, 13 Feb 2019 14:06:37 -0800
Message-Id: <20190213220638.1552-9-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190213220638.1552-1-f.fainelli@gmail.com>
References: <20190213220638.1552-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have converted the bridge code and the drivers to check for
bridge port(s) flags at the time we try to set them, there is no need
for a get() -> set() sequence anymore and
SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT therefore becomes unused.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../ethernet/mellanox/mlxsw/spectrum_switchdev.c   | 11 +----------
 drivers/net/ethernet/rocker/rocker_main.c          | 14 +-------------
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c            | 10 +---------
 include/net/switchdev.h                            |  2 --
 net/dsa/slave.c                                    | 10 +---------
 5 files changed, 4 insertions(+), 43 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index 7616eab50035..c11cf7fa4863 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -434,16 +434,7 @@ static void mlxsw_sp_bridge_vlan_put(struct mlxsw_sp_bridge_vlan *bridge_vlan)
 static int mlxsw_sp_port_attr_get(struct net_device *dev,
 				  struct switchdev_attr *attr)
 {
-	switch (attr->id) {
-	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT:
-		attr->u.brport_flags_support = BR_LEARNING | BR_FLOOD |
-					       BR_MCAST_FLOOD;
-		break;
-	default:
-		return -EOPNOTSUPP;
-	}
-
-	return 0;
+	return -EOPNOTSUPP;
 }
 
 static int
diff --git a/drivers/net/ethernet/rocker/rocker_main.c b/drivers/net/ethernet/rocker/rocker_main.c
index 863a8b32e6e9..8e80301eae7b 100644
--- a/drivers/net/ethernet/rocker/rocker_main.c
+++ b/drivers/net/ethernet/rocker/rocker_main.c
@@ -2057,19 +2057,7 @@ static const struct net_device_ops rocker_port_netdev_ops = {
 static int rocker_port_attr_get(struct net_device *dev,
 				struct switchdev_attr *attr)
 {
-	const struct rocker_port *rocker_port = netdev_priv(dev);
-	int err = 0;
-
-	switch (attr->id) {
-	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT:
-		err = rocker_world_port_attr_bridge_flags_support_get(rocker_port,
-								      &attr->u.brport_flags_support);
-		break;
-	default:
-		return -EOPNOTSUPP;
-	}
-
-	return err;
+	return -EOPNOTSUPP;
 }
 
 static int rocker_port_attr_set(struct net_device *dev,
diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index f788a9458b89..5f58c7df67bb 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -643,15 +643,7 @@ static void ethsw_teardown_irqs(struct fsl_mc_device *sw_dev)
 static int swdev_port_attr_get(struct net_device *netdev,
 			       struct switchdev_attr *attr)
 {
-	switch (attr->id) {
-	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT:
-		attr->u.brport_flags_support = BR_LEARNING | BR_FLOOD;
-		break;
-	default:
-		return -EOPNOTSUPP;
-	}
-
-	return 0;
+	return -EOPNOTSUPP;
 }
 
 static int port_attr_stp_state_set(struct net_device *netdev,
diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index de72b0a3867f..0f352019ef99 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -45,7 +45,6 @@ enum switchdev_attr_id {
 	SWITCHDEV_ATTR_ID_UNDEFINED,
 	SWITCHDEV_ATTR_ID_PORT_STP_STATE,
 	SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS,
-	SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT,
 	SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS,
 	SWITCHDEV_ATTR_ID_PORT_MROUTER,
 	SWITCHDEV_ATTR_ID_BRIDGE_AGEING_TIME,
@@ -63,7 +62,6 @@ struct switchdev_attr {
 	union {
 		u8 stp_state;				/* PORT_STP_STATE */
 		unsigned long brport_flags;		/* PORT_{PRE}_BRIDGE_FLAGS */
-		unsigned long brport_flags_support;	/* PORT_BRIDGE_FLAGS_SUPPORT */
 		bool mrouter;				/* PORT_MROUTER */
 		clock_t ageing_time;			/* BRIDGE_AGEING_TIME */
 		bool vlan_filtering;			/* BRIDGE_VLAN_FILTERING */
diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index 417388c9f1fa..a176d3ba3b7a 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -388,15 +388,7 @@ static int dsa_slave_get_port_parent_id(struct net_device *dev,
 static int dsa_slave_port_attr_get(struct net_device *dev,
 				   struct switchdev_attr *attr)
 {
-	switch (attr->id) {
-	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT:
-		attr->u.brport_flags_support = 0;
-		break;
-	default:
-		return -EOPNOTSUPP;
-	}
-
-	return 0;
+	return -EOPNOTSUPP;
 }
 
 static inline netdev_tx_t dsa_slave_netpoll_send_skb(struct net_device *dev,
-- 
2.17.1

