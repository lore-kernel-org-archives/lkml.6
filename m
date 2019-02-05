Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 705FFC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 23:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 248202073D
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 23:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RWmt3k+H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729248AbfBEX45 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 18:56:57 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39864 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727524AbfBEXzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 18:55:49 -0500
Received: by mail-pg1-f193.google.com with SMTP id r11so2118138pgp.6;
        Tue, 05 Feb 2019 15:55:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FM7UbF1Ks8MhuNGG6C9onaIpALxRUEhyUABssROXJgE=;
        b=RWmt3k+HaV8gBQttQiXCGVJ2B0pEXVONrxNw39ZHUih4myfvMWFuDUhu28WJb3IEmG
         ILkcmWyg2hbdgLZLzHW6/rI72+SEmfubOMgBfn+UQyEbA6SBO6P9bpPNEH25BiU0yQZN
         VO0D7ElXxAX4873z3moYWyDPgRUmswuZR7B1T/QSAZMNP2Vou9TD1y7l4kHx1CscBN/7
         vbN7COdZl/kYl4x0TBKrsFOz9+7+0/v1Njb7q4kROLsWRPmbyeSwIkFqeA7VWwUTRs1P
         MOZ3yJeC4XFZKFuRulC35rrzAWBOZ56oIm2OVOuek4O849v9C3BPt/pnMnvUPNjvWfTI
         T+IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FM7UbF1Ks8MhuNGG6C9onaIpALxRUEhyUABssROXJgE=;
        b=PnW3cm41BMpUOc15WFBO5FgqPApFzjmvHUaPPUKZ4o4u9pK8DCThzRh6kvANfa7QFk
         4bi/+IkpjM+uYErT40GXtKCq+q4XjHahhptald4PUsSQ7m2Ow/+3nbbKb2mtQdx94FZK
         7WgfMkQC3BxHC8XkqCYkt20qt+thx/CfG7wAXhS5SI5jo5buyftJyven8l+Ey4ysbFyz
         Bs2lgjsp5XHj+FBCgigeRi0Q0h7SS1HJGi3nrtjTAjfw6+EjzncL3GP4ioIFelo+52k0
         y1l3htDu7DLHxhdS/Ga27RJsipGANRcWDwGG5eiKT0XhG5zivsECl5Zvmhipq2ZmNy+m
         O8vA==
X-Gm-Message-State: AHQUAuYGgUnp4UDM/zqA8RThRooCWGAPz6hTP/ndlAIB6FVS5UToNUFU
        VZGdOayYPt659vsTu0NM0uywa/p8
X-Google-Smtp-Source: AHgI3IakkKXZSsimKajXOch4WlFJ7nNhhJ9WCnzASMlb9KtrIWlZmgKu4KJWGLz5qw8vM8JXORx7AQ==
X-Received: by 2002:a65:40c5:: with SMTP id u5mr2132521pgp.46.1549410948443;
        Tue, 05 Feb 2019 15:55:48 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id v184sm6770197pfb.182.2019.02.05.15.55.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 15:55:47 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        linux-kernel@vger.kernel.org (open list),
        linux-rdma@vger.kernel.org (open list:MELLANOX MLX5 core VPI driver),
        oss-drivers@netronome.com (open list:NETRONOME ETHERNET DRIVERS),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE)
Subject: [PATCH net-next v3 05/12] mlxsw: Implement ndo_get_port_parent_id()
Date:   Tue,  5 Feb 2019 15:53:19 -0800
Message-Id: <20190205235326.14600-6-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190205235326.14600-1-f.fainelli@gmail.com>
References: <20190205235326.14600-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mlxsw implements SWITCHDEV_ATTR_ID_PORT_PARENT_ID and we want to get rid
of switchdev_ops eventually, ease that migration by implementing a
ndo_get_port_parent_id() function which returns what
switchdev_port_attr_get() would do.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../net/ethernet/mellanox/mlxsw/spectrum.c    | 13 +++++++
 .../mellanox/mlxsw/spectrum_switchdev.c       |  5 ---
 .../net/ethernet/mellanox/mlxsw/switchx2.c    | 36 +++++++------------
 3 files changed, 26 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index a88169738b4a..8dd808b7f931 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -1700,6 +1700,18 @@ static int mlxsw_sp_set_features(struct net_device *dev,
 				       mlxsw_sp_feature_hw_tc);
 }
 
+static int mlxsw_sp_port_get_port_parent_id(struct net_device *dev,
+					    struct netdev_phys_item_id *ppid)
+{
+	struct mlxsw_sp_port *mlxsw_sp_port = netdev_priv(dev);
+	struct mlxsw_sp *mlxsw_sp = mlxsw_sp_port->mlxsw_sp;
+
+	ppid->id_len = sizeof(mlxsw_sp->base_mac);
+	memcpy(&ppid->id, &mlxsw_sp->base_mac, ppid->id_len);
+
+	return 0;
+}
+
 static const struct net_device_ops mlxsw_sp_port_netdev_ops = {
 	.ndo_open		= mlxsw_sp_port_open,
 	.ndo_stop		= mlxsw_sp_port_stop,
@@ -1715,6 +1727,7 @@ static const struct net_device_ops mlxsw_sp_port_netdev_ops = {
 	.ndo_vlan_rx_kill_vid	= mlxsw_sp_port_kill_vid,
 	.ndo_get_phys_port_name	= mlxsw_sp_port_get_phys_port_name,
 	.ndo_set_features	= mlxsw_sp_set_features,
+	.ndo_get_port_parent_id	= mlxsw_sp_port_get_port_parent_id,
 };
 
 static void mlxsw_sp_port_get_drvinfo(struct net_device *dev,
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index a4a9fe992193..95e37de3e48f 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -451,11 +451,6 @@ static int mlxsw_sp_port_attr_get(struct net_device *dev,
 	struct mlxsw_sp *mlxsw_sp = mlxsw_sp_port->mlxsw_sp;
 
 	switch (attr->id) {
-	case SWITCHDEV_ATTR_ID_PORT_PARENT_ID:
-		attr->u.ppid.id_len = sizeof(mlxsw_sp->base_mac);
-		memcpy(&attr->u.ppid.id, &mlxsw_sp->base_mac,
-		       attr->u.ppid.id_len);
-		break;
 	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS:
 		mlxsw_sp_port_bridge_flags_get(mlxsw_sp->bridge, attr->orig_dev,
 					       &attr->u.brport_flags);
diff --git a/drivers/net/ethernet/mellanox/mlxsw/switchx2.c b/drivers/net/ethernet/mellanox/mlxsw/switchx2.c
index 2d4f213e154d..3814ba8af517 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/switchx2.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/switchx2.c
@@ -390,6 +390,18 @@ static int mlxsw_sx_port_get_phys_port_name(struct net_device *dev, char *name,
 						  name, len);
 }
 
+static int mlxsw_sx_port_get_port_parent_id(struct net_device *dev,
+					    struct netdev_phys_item_id *ppid)
+{
+	struct mlxsw_sx_port *mlxsw_sx_port = netdev_priv(dev);
+	struct mlxsw_sx *mlxsw_sx = mlxsw_sx_port->mlxsw_sx;
+
+	ppid->id_len = sizeof(mlxsw_sx->hw_id);
+	memcpy(&ppid->id, &mlxsw_sx->hw_id, ppid->id_len);
+
+	return 0;
+}
+
 static const struct net_device_ops mlxsw_sx_port_netdev_ops = {
 	.ndo_open		= mlxsw_sx_port_open,
 	.ndo_stop		= mlxsw_sx_port_stop,
@@ -397,6 +409,7 @@ static const struct net_device_ops mlxsw_sx_port_netdev_ops = {
 	.ndo_change_mtu		= mlxsw_sx_port_change_mtu,
 	.ndo_get_stats64	= mlxsw_sx_port_get_stats64,
 	.ndo_get_phys_port_name = mlxsw_sx_port_get_phys_port_name,
+	.ndo_get_port_parent_id	= mlxsw_sx_port_get_port_parent_id,
 };
 
 static void mlxsw_sx_port_get_drvinfo(struct net_device *dev,
@@ -901,28 +914,6 @@ static const struct ethtool_ops mlxsw_sx_port_ethtool_ops = {
 	.set_link_ksettings	= mlxsw_sx_port_set_link_ksettings,
 };
 
-static int mlxsw_sx_port_attr_get(struct net_device *dev,
-				  struct switchdev_attr *attr)
-{
-	struct mlxsw_sx_port *mlxsw_sx_port = netdev_priv(dev);
-	struct mlxsw_sx *mlxsw_sx = mlxsw_sx_port->mlxsw_sx;
-
-	switch (attr->id) {
-	case SWITCHDEV_ATTR_ID_PORT_PARENT_ID:
-		attr->u.ppid.id_len = sizeof(mlxsw_sx->hw_id);
-		memcpy(&attr->u.ppid.id, &mlxsw_sx->hw_id, attr->u.ppid.id_len);
-		break;
-	default:
-		return -EOPNOTSUPP;
-	}
-
-	return 0;
-}
-
-static const struct switchdev_ops mlxsw_sx_port_switchdev_ops = {
-	.switchdev_port_attr_get	= mlxsw_sx_port_attr_get,
-};
-
 static int mlxsw_sx_hw_id_get(struct mlxsw_sx *mlxsw_sx)
 {
 	char spad_pl[MLXSW_REG_SPAD_LEN] = {0};
@@ -1034,7 +1025,6 @@ static int __mlxsw_sx_port_eth_create(struct mlxsw_sx *mlxsw_sx, u8 local_port,
 
 	dev->netdev_ops = &mlxsw_sx_port_netdev_ops;
 	dev->ethtool_ops = &mlxsw_sx_port_ethtool_ops;
-	dev->switchdev_ops = &mlxsw_sx_port_switchdev_ops;
 
 	err = mlxsw_sx_port_dev_addr_get(mlxsw_sx_port);
 	if (err) {
-- 
2.17.1

