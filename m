Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89804C282CB
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4646920821
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TYDo2jeH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbfBIAdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 19:33:49 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37807 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727190AbfBIAdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 19:33:45 -0500
Received: by mail-pf1-f194.google.com with SMTP id y126so2445462pfb.4;
        Fri, 08 Feb 2019 16:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/+Z3LNOvkFOIttWYCf4gKx3ujKryI+0e94YvGRWZSKY=;
        b=TYDo2jeHX+yjsycozx6+t0zax6dNkQz69q5xghUezzK53aBHXZ69UMnSlROkwzxuKW
         QzmJhvZLoXWgBHzQDtmd5fli1/amf3MEhNvX5tB8voL/wkywdBEZeKKXsTMml7bJGInW
         qSQBU8wffoVnGPy71AmXYh8fEb13IkIIl/Oyg9Yu8H/SFRSEkAiYNHjIvLquRw8frakx
         P/K7LNmTIypJ3hszi6+61bZXxgG3D/WjNKCTyufs82Td56nEQG73c92MCK+ewZeyrW5r
         Vyp5Lfcv0LRQ+CgFxYJpEx2nrj3tE9oIY+CY9E3Z5iW4rwJBUaAqSG6j/dXe7q/LlSG2
         9KtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/+Z3LNOvkFOIttWYCf4gKx3ujKryI+0e94YvGRWZSKY=;
        b=NhdlOAQDPTmhDKktRMreS1BZ6eo2Y8a0vZ3wa26sWIMm7K6Vy8gAjN7FZDoN76Glde
         1R3RbYynh55BqO5qc8+1pis6WDfgBV3s0vsCm7AdXGaNmlU0PoXVa/fBBuryeXRl/5m9
         mMcQaafZX9GRnKMNJlniR80A37pYi4PO3xiv38CN+UUUNzGLEnCyCP6AOxmSvfd+AB4H
         3Rp5SP7IytEB1M+vHAyHDRK4HOC7ip8rE5tT+qglGIRVf3NcIA7RAV4wsiUDBKymUQhK
         LreLG2xVtAgUg03kLxgJckvzeJDbbIKIP9yHABD3xKGy1anSCOS2Bioi2vTwA1lkewZd
         H5kg==
X-Gm-Message-State: AHQUAuZciiFd5yk2r7xXKAROckJCUQvGveglVCBuCkPmPRSpA7mzRnOe
        omMf4i3usD/R72lCuhtK6AqI+ZT7
X-Google-Smtp-Source: AHgI3Iaue16qW9kxMIQi/th1hQL9OjG9fnC9tYDruErajhhRdNY4YU8x/zTP6CC3DcL35mqx96AgNA==
X-Received: by 2002:a63:e950:: with SMTP id q16mr7337154pgj.138.1549672423166;
        Fri, 08 Feb 2019 16:33:43 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id i71sm372491pfi.170.2019.02.08.16.33.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 16:33:42 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        linux-kernel@vger.kernel.org (open list),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE),
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next 08/16] net: Get rid of switchdev_port_attr_get()
Date:   Fri,  8 Feb 2019 16:32:40 -0800
Message-Id: <20190209003248.31088-9-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190209003248.31088-1-f.fainelli@gmail.com>
References: <20190209003248.31088-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the bridge no longer calling switchdev_port_attr_get() to obtain
the supported bridge port flags from a driver but instead trying to set
the bridge port flags directly and relying on driver to reject
unsupported configurations, we can effectively get rid of
switchdev_port_attr_get() entirely since this was the only place where
it was called.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 Documentation/networking/switchdev.txt        |  5 ++-
 .../mellanox/mlxsw/spectrum_switchdev.c       | 32 -------------------
 drivers/net/ethernet/rocker/rocker_main.c     | 30 -----------------
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c       | 19 -----------
 include/net/switchdev.h                       |  8 -----
 net/dsa/slave.c                               |  7 ----
 6 files changed, 2 insertions(+), 99 deletions(-)

diff --git a/Documentation/networking/switchdev.txt b/Documentation/networking/switchdev.txt
index 2842f63ad47b..0d9530bf745b 100644
--- a/Documentation/networking/switchdev.txt
+++ b/Documentation/networking/switchdev.txt
@@ -233,9 +233,8 @@ the bridge's FDB.  It's possible, but not optimal, to enable learning on the
 device port and on the bridge port, and disable learning_sync.
 
 To support learning and learning_sync port attributes, the driver implements
-switchdev op switchdev_port_attr_get/set for
-SWITCHDEV_ATTR_PORT_ID_BRIDGE_FLAGS. The driver should initialize the attributes
-to the hardware defaults.
+switchdev op switchdev_port_attr_set for SWITCHDEV_ATTR_PORT_ID_BRIDGE_FLAGS.
+The driver should initialize the attributes to the hardware defaults.
 
 FDB Ageing
 ^^^^^^^^^^
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index 8242a373f6e7..6b09d68671cf 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -431,37 +431,6 @@ static void mlxsw_sp_bridge_vlan_put(struct mlxsw_sp_bridge_vlan *bridge_vlan)
 		mlxsw_sp_bridge_vlan_destroy(bridge_vlan);
 }
 
-static void mlxsw_sp_port_bridge_flags_get(struct mlxsw_sp_bridge *bridge,
-					   struct net_device *dev,
-					   unsigned long *brport_flags)
-{
-	struct mlxsw_sp_bridge_port *bridge_port;
-
-	bridge_port = mlxsw_sp_bridge_port_find(bridge, dev);
-	if (WARN_ON(!bridge_port))
-		return;
-
-	memcpy(brport_flags, &bridge_port->flags, sizeof(*brport_flags));
-}
-
-static int mlxsw_sp_port_attr_get(struct net_device *dev,
-				  struct switchdev_attr *attr)
-{
-	struct mlxsw_sp_port *mlxsw_sp_port = netdev_priv(dev);
-	struct mlxsw_sp *mlxsw_sp = mlxsw_sp_port->mlxsw_sp;
-
-	switch (attr->id) {
-	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS:
-		mlxsw_sp_port_bridge_flags_get(mlxsw_sp->bridge, attr->orig_dev,
-					       &attr->u.brport_flags);
-		break;
-	default:
-		return -EOPNOTSUPP;
-	}
-
-	return 0;
-}
-
 static int
 mlxsw_sp_port_bridge_vlan_stp_set(struct mlxsw_sp_port *mlxsw_sp_port,
 				  struct mlxsw_sp_bridge_vlan *bridge_vlan,
@@ -1957,7 +1926,6 @@ static struct mlxsw_sp_port *mlxsw_sp_lag_rep_port(struct mlxsw_sp *mlxsw_sp,
 }
 
 static const struct switchdev_ops mlxsw_sp_port_switchdev_ops = {
-	.switchdev_port_attr_get	= mlxsw_sp_port_attr_get,
 	.switchdev_port_attr_set	= mlxsw_sp_port_attr_set,
 };
 
diff --git a/drivers/net/ethernet/rocker/rocker_main.c b/drivers/net/ethernet/rocker/rocker_main.c
index 375c4c908bea..ff3f14504f4f 100644
--- a/drivers/net/ethernet/rocker/rocker_main.c
+++ b/drivers/net/ethernet/rocker/rocker_main.c
@@ -1606,17 +1606,6 @@ rocker_world_port_attr_bridge_flags_set(struct rocker_port *rocker_port,
 						trans);
 }
 
-static int
-rocker_world_port_attr_bridge_flags_get(const struct rocker_port *rocker_port,
-					unsigned long *p_brport_flags)
-{
-	struct rocker_world_ops *wops = rocker_port->rocker->wops;
-
-	if (!wops->port_attr_bridge_flags_get)
-		return -EOPNOTSUPP;
-	return wops->port_attr_bridge_flags_get(rocker_port, p_brport_flags);
-}
-
 static int
 rocker_world_port_attr_bridge_ageing_time_set(struct rocker_port *rocker_port,
 					      u32 ageing_time,
@@ -2064,24 +2053,6 @@ static const struct net_device_ops rocker_port_netdev_ops = {
  * swdev interface
  ********************/
 
-static int rocker_port_attr_get(struct net_device *dev,
-				struct switchdev_attr *attr)
-{
-	const struct rocker_port *rocker_port = netdev_priv(dev);
-	int err = 0;
-
-	switch (attr->id) {
-	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS:
-		err = rocker_world_port_attr_bridge_flags_get(rocker_port,
-							      &attr->u.brport_flags);
-		break;
-	default:
-		return -EOPNOTSUPP;
-	}
-
-	return err;
-}
-
 static int rocker_port_attr_set(struct net_device *dev,
 				const struct switchdev_attr *attr,
 				struct switchdev_trans *trans)
@@ -2154,7 +2125,6 @@ static int rocker_port_obj_del(struct net_device *dev,
 }
 
 static const struct switchdev_ops rocker_port_switchdev_ops = {
-	.switchdev_port_attr_get	= rocker_port_attr_get,
 	.switchdev_port_attr_set	= rocker_port_attr_set,
 };
 
diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index 79635d1091df..b195b09e0d1d 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -640,24 +640,6 @@ static void ethsw_teardown_irqs(struct fsl_mc_device *sw_dev)
 	fsl_mc_free_irqs(sw_dev);
 }
 
-static int swdev_port_attr_get(struct net_device *netdev,
-			       struct switchdev_attr *attr)
-{
-	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
-
-	switch (attr->id) {
-	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS:
-		attr->u.brport_flags =
-			(port_priv->ethsw_data->learning ? BR_LEARNING : 0) |
-			(port_priv->flood ? BR_FLOOD : 0);
-		break;
-	default:
-		return -EOPNOTSUPP;
-	}
-
-	return 0;
-}
-
 static int port_attr_stp_state_set(struct net_device *netdev,
 				   struct switchdev_trans *trans,
 				   u8 state)
@@ -933,7 +915,6 @@ static int swdev_port_obj_del(struct net_device *netdev,
 }
 
 static const struct switchdev_ops ethsw_port_switchdev_ops = {
-	.switchdev_port_attr_get	= swdev_port_attr_get,
 	.switchdev_port_attr_set	= swdev_port_attr_set,
 };
 
diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index e2083824e577..96cd3e795f7f 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -178,8 +178,6 @@ switchdev_notifier_info_to_extack(const struct switchdev_notifier_info *info)
 #ifdef CONFIG_NET_SWITCHDEV
 
 void switchdev_deferred_process(void);
-int switchdev_port_attr_get(struct net_device *dev,
-			    struct switchdev_attr *attr);
 int switchdev_port_attr_set(struct net_device *dev,
 			    const struct switchdev_attr *attr);
 int switchdev_port_obj_add(struct net_device *dev,
@@ -224,12 +222,6 @@ static inline void switchdev_deferred_process(void)
 {
 }
 
-static inline int switchdev_port_attr_get(struct net_device *dev,
-					  struct switchdev_attr *attr)
-{
-	return -EOPNOTSUPP;
-}
-
 static inline int switchdev_port_attr_set(struct net_device *dev,
 					  const struct switchdev_attr *attr)
 {
diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index 5797da954e77..ae34be949d79 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -379,12 +379,6 @@ static int dsa_slave_get_port_parent_id(struct net_device *dev,
 	return 0;
 }
 
-static int dsa_slave_port_attr_get(struct net_device *dev,
-				   struct switchdev_attr *attr)
-{
-	return -EOPNOTSUPP;
-}
-
 static inline netdev_tx_t dsa_slave_netpoll_send_skb(struct net_device *dev,
 						     struct sk_buff *skb)
 {
@@ -1051,7 +1045,6 @@ static const struct net_device_ops dsa_slave_netdev_ops = {
 };
 
 static const struct switchdev_ops dsa_slave_switchdev_ops = {
-	.switchdev_port_attr_get	= dsa_slave_port_attr_get,
 	.switchdev_port_attr_set	= dsa_slave_port_attr_set,
 };
 
-- 
2.17.1

