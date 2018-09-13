Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22571C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC60C204FD
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 13:55:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC60C204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731299AbeIMTF1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 15:05:27 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34060 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730755AbeIMTF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 15:05:27 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 72803D10;
        Thu, 13 Sep 2018 13:55:50 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ido Schimmel <idosch@mellanox.com>,
        Petr Machata <petrm@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.18 034/197] mlxsw: spectrum_switchdev: Do not leak RIFs when removing bridge
Date:   Thu, 13 Sep 2018 15:29:43 +0200
Message-Id: <20180913131842.922250954@linuxfoundation.org>
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

From: Ido Schimmel <idosch@mellanox.com>

[ Upstream commit 602b74eda81311dbdb5dbab08c30f789f648ebdc ]

When a bridge device is removed, the VLANs are flushed from each
configured port. This causes the ports to decrement the reference count
on the associated FIDs (filtering identifier). If the reference count of
a FID is 1 and it has a RIF (router interface), then this RIF is
destroyed.

However, if no port is member in the VLAN for which a RIF exists, then
the RIF will continue to exist after the removal of the bridge. To
reproduce:

# ip link add name br0 type bridge vlan_filtering 1
# ip link set dev swp1 master br0
# ip link add link br0 name br0.10 type vlan id 10
# ip address add 192.0.2.0/24 dev br0.10
# ip link del dev br0

The RIF associated with br0.10 continues to exist.

Fix this by iterating over all the bridge device uppers when it is
destroyed and take care of destroying their RIFs.

Fixes: 99f44bb3527b ("mlxsw: spectrum: Enable L3 interfaces on top of bridge devices")
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Reviewed-by: Petr Machata <petrm@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum.h           |    2 +
 drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c    |   11 ++++++++
 drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c |   20 +++++++++++++++
 3 files changed, 33 insertions(+)

--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
@@ -433,6 +433,8 @@ mlxsw_sp_netdevice_ipip_ul_event(struct
 void
 mlxsw_sp_port_vlan_router_leave(struct mlxsw_sp_port_vlan *mlxsw_sp_port_vlan);
 void mlxsw_sp_rif_destroy(struct mlxsw_sp_rif *rif);
+void mlxsw_sp_rif_destroy_by_dev(struct mlxsw_sp *mlxsw_sp,
+				 struct net_device *dev);
 
 /* spectrum_kvdl.c */
 int mlxsw_sp_kvdl_init(struct mlxsw_sp *mlxsw_sp);
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
@@ -6228,6 +6228,17 @@ void mlxsw_sp_rif_destroy(struct mlxsw_s
 	mlxsw_sp_vr_put(mlxsw_sp, vr);
 }
 
+void mlxsw_sp_rif_destroy_by_dev(struct mlxsw_sp *mlxsw_sp,
+				 struct net_device *dev)
+{
+	struct mlxsw_sp_rif *rif;
+
+	rif = mlxsw_sp_rif_find_by_dev(mlxsw_sp, dev);
+	if (!rif)
+		return;
+	mlxsw_sp_rif_destroy(rif);
+}
+
 static void
 mlxsw_sp_rif_subport_params_init(struct mlxsw_sp_rif_params *params,
 				 struct mlxsw_sp_port_vlan *mlxsw_sp_port_vlan)
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -160,6 +160,24 @@ bool mlxsw_sp_bridge_device_is_offloaded
 	return !!mlxsw_sp_bridge_device_find(mlxsw_sp->bridge, br_dev);
 }
 
+static int mlxsw_sp_bridge_device_upper_rif_destroy(struct net_device *dev,
+						    void *data)
+{
+	struct mlxsw_sp *mlxsw_sp = data;
+
+	mlxsw_sp_rif_destroy_by_dev(mlxsw_sp, dev);
+	return 0;
+}
+
+static void mlxsw_sp_bridge_device_rifs_destroy(struct mlxsw_sp *mlxsw_sp,
+						struct net_device *dev)
+{
+	mlxsw_sp_rif_destroy_by_dev(mlxsw_sp, dev);
+	netdev_walk_all_upper_dev_rcu(dev,
+				      mlxsw_sp_bridge_device_upper_rif_destroy,
+				      mlxsw_sp);
+}
+
 static struct mlxsw_sp_bridge_device *
 mlxsw_sp_bridge_device_create(struct mlxsw_sp_bridge *bridge,
 			      struct net_device *br_dev)
@@ -198,6 +216,8 @@ static void
 mlxsw_sp_bridge_device_destroy(struct mlxsw_sp_bridge *bridge,
 			       struct mlxsw_sp_bridge_device *bridge_device)
 {
+	mlxsw_sp_bridge_device_rifs_destroy(bridge->mlxsw_sp,
+					    bridge_device->dev);
 	list_del(&bridge_device->list);
 	if (bridge_device->vlan_enabled)
 		bridge->vlan_enabled_exists = false;


