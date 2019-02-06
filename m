Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0270FC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B16592073D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="arV9mMIP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730785AbfBFRr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 12:47:29 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35368 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730417AbfBFRqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 12:46:14 -0500
Received: by mail-pg1-f193.google.com with SMTP id s198so3221158pgs.2;
        Wed, 06 Feb 2019 09:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AkZIsZoku/0ITx/peTPQBDEYeXfc+kmCpWPYCSfWrvA=;
        b=arV9mMIPvPpQSCgPPmQprwoqXjw58BgE/CiksAGYuafNqR5AG+aev5U24UFqEvTCnY
         i8V749GP1iJbbqHaJ90HHgjA8T+GyzIQWXrnAj/6lIekjsnJxWz0WmSw5vTqiAPxnSrJ
         UyiMGIJbmoxGDqrZTUeKfmLdoxLDVzT/g3ZQ0ARdUK6xYIxVJNc8L83zczrNjiE6B0SO
         INjdwXh4aVgsDxnF4DnaX1VOXBtT53jA0vFL/eAmRH/HgD9OFMd9g4dnpeaX4lP/UKlg
         9XJBzSWbG90W3/hIZkJoVj2lrlJCFD3yFE4QLerM6RSbGEYP1Wr2wTEWbReA0N1okTUI
         xktw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AkZIsZoku/0ITx/peTPQBDEYeXfc+kmCpWPYCSfWrvA=;
        b=YV53CthvYb8KqFZYJAM2KnN2f4MGqyWZvwj3UzOreib7UvuZAHf+DgVanlchhUbuoB
         7EaoVfUd2bsqWMmEWIcjvP4Jz8okTWtlvXLIeUKcLxGX+DC1GjhRe9tR/8Om4HdE4gwG
         dMtrnc/zZj7yzxFiLtiLmpF6oknyXznoY/bsdfy4IxYJDLu20VcG9ZPY0/M+0pzrRQEp
         sshqPw6nQYRhQEHnyaysVrQm4tLeZi4JDC0sbPV0DkMNDPG3TSyIRc3DMkbfxilJf4tF
         2levTQccVkFg1BXXBZxZLTNdatRkmKlcLNsPGQcgVFj+AzvacQQbea65L5atraivGT9Y
         KFCA==
X-Gm-Message-State: AHQUAuZVY1lY+Q/1tgOjC8Rm4Una00zTOEftlwCrnR7LAsTOSaFSvPYx
        5XjcQYpOERU+dU9YF5ZEuYHY/FIh
X-Google-Smtp-Source: AHgI3IZqsCx19HvbkmhfX2ZTK1cSkmi4LMcqlBLMTkdU7S5UKgmt6ztM8Jo3uiWxK2MrfsBOtskHLQ==
X-Received: by 2002:a63:d846:: with SMTP id k6mr10807267pgj.251.1549475172695;
        Wed, 06 Feb 2019 09:46:12 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id 15sm10435313pfr.55.2019.02.06.09.46.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 09:46:11 -0800 (PST)
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
Subject: [PATCH net-next v4 05/12] mlxsw: Implement ndo_get_port_parent_id()
Date:   Wed,  6 Feb 2019 09:45:39 -0800
Message-Id: <20190206174546.23597-6-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190206174546.23597-1-f.fainelli@gmail.com>
References: <20190206174546.23597-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mlxsw implements SWITCHDEV_ATTR_ID_PORT_PARENT_ID and we want to get rid
of switchdev_ops eventually, ease that migration by implementing a
ndo_get_port_parent_id() function which returns what
switchdev_port_attr_get() would do.

Acked-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../net/ethernet/mellanox/mlxsw/spectrum.c    | 13 +++++++
 .../mellanox/mlxsw/spectrum_switchdev.c       |  5 ---
 .../net/ethernet/mellanox/mlxsw/switchx2.c    | 37 +++++++------------
 3 files changed, 26 insertions(+), 29 deletions(-)

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
index 2d4f213e154d..533fe6235b7c 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/switchx2.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/switchx2.c
@@ -11,7 +11,6 @@
 #include <linux/device.h>
 #include <linux/skbuff.h>
 #include <linux/if_vlan.h>
-#include <net/switchdev.h>
 
 #include "pci.h"
 #include "core.h"
@@ -390,6 +389,18 @@ static int mlxsw_sx_port_get_phys_port_name(struct net_device *dev, char *name,
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
@@ -397,6 +408,7 @@ static const struct net_device_ops mlxsw_sx_port_netdev_ops = {
 	.ndo_change_mtu		= mlxsw_sx_port_change_mtu,
 	.ndo_get_stats64	= mlxsw_sx_port_get_stats64,
 	.ndo_get_phys_port_name = mlxsw_sx_port_get_phys_port_name,
+	.ndo_get_port_parent_id	= mlxsw_sx_port_get_port_parent_id,
 };
 
 static void mlxsw_sx_port_get_drvinfo(struct net_device *dev,
@@ -901,28 +913,6 @@ static const struct ethtool_ops mlxsw_sx_port_ethtool_ops = {
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
@@ -1034,7 +1024,6 @@ static int __mlxsw_sx_port_eth_create(struct mlxsw_sx *mlxsw_sx, u8 local_port,
 
 	dev->netdev_ops = &mlxsw_sx_port_netdev_ops;
 	dev->ethtool_ops = &mlxsw_sx_port_ethtool_ops;
-	dev->switchdev_ops = &mlxsw_sx_port_switchdev_ops;
 
 	err = mlxsw_sx_port_dev_addr_get(mlxsw_sx_port);
 	if (err) {
-- 
2.17.1

