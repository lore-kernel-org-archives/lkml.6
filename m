Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163717AbeE1Kul (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:50:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:40084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163660AbeE1Kue (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:50:34 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tal Bar <talb@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>, Jiri Pirko <jiri@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 177/496] spectrum: Reference count VLAN entries
Date: Mon, 28 May 2018 11:59:22 +0200
Message-Id: <20180528100327.328191207@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ido Schimmel <idosch@mellanox.com>

[ Upstream commit b3529af6bb0d4fe72defdd539712ceffaa054fb3 ]

One of the basic construct in the device is a port-VLAN pair, which can
be bound to a FID or a RIF in order to direct packets to the bridge or
the router, respectively.

Since not all the netdevs are configured with a VLAN (e.g., sw1p1 vs.
sw1p1.10), VID 1 is used to represent these and thus this VID can be
used by both upper devices of mlxsw ports and by the driver itself.

However, this VID is not reference counted and therefore might be freed
prematurely, which can result in various WARNINGs. For example:

$ ip link add name br0 type bridge vlan_filtering 1
$ teamd -t team0 -d -c '{"runner": {"name": "lacp"}}'
$ ip link set dev team0 master br0
$ ip link set dev enp1s0np1 master team0
$ ip address add 192.0.2.1/24 dev enp1s0np1

The enslavement to team0 will fail because team0 already has an upper
and thus vlan_vids_del_by_dev() will be executed as part of team's error
path which will delete VID 1 from enp1s0np1 (added by br0 as PVID). The
WARNING will be generated when the driver will realize it can't find VID
1 on the port and bind it to a RIF.

Fix this by adding a reference count to the VLAN entries on the port, in
a similar fashion to the reference counting used by the corresponding
'vlan_vid_info' structure in the 8021q driver.

Fixes: c57529e1d5d8 ("mlxsw: spectrum: Replace vPorts with Port-VLAN")
Reported-by: Tal Bar <talb@mellanox.com>
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Tested-by: Tal Bar <talb@mellanox.com>
Signed-off-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c |    8 +++++++-
 drivers/net/ethernet/mellanox/mlxsw/spectrum.h |    1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -1417,6 +1417,7 @@ mlxsw_sp_port_vlan_create(struct mlxsw_s
 	}
 
 	mlxsw_sp_port_vlan->mlxsw_sp_port = mlxsw_sp_port;
+	mlxsw_sp_port_vlan->ref_count = 1;
 	mlxsw_sp_port_vlan->vid = vid;
 	list_add(&mlxsw_sp_port_vlan->list, &mlxsw_sp_port->vlans_list);
 
@@ -1444,8 +1445,10 @@ mlxsw_sp_port_vlan_get(struct mlxsw_sp_p
 	struct mlxsw_sp_port_vlan *mlxsw_sp_port_vlan;
 
 	mlxsw_sp_port_vlan = mlxsw_sp_port_vlan_find_by_vid(mlxsw_sp_port, vid);
-	if (mlxsw_sp_port_vlan)
+	if (mlxsw_sp_port_vlan) {
+		mlxsw_sp_port_vlan->ref_count++;
 		return mlxsw_sp_port_vlan;
+	}
 
 	return mlxsw_sp_port_vlan_create(mlxsw_sp_port, vid);
 }
@@ -1454,6 +1457,9 @@ void mlxsw_sp_port_vlan_put(struct mlxsw
 {
 	struct mlxsw_sp_fid *fid = mlxsw_sp_port_vlan->fid;
 
+	if (--mlxsw_sp_port_vlan->ref_count != 0)
+		return;
+
 	if (mlxsw_sp_port_vlan->bridge_port)
 		mlxsw_sp_port_vlan_bridge_leave(mlxsw_sp_port_vlan);
 	else if (fid)
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
@@ -194,6 +194,7 @@ struct mlxsw_sp_port_vlan {
 	struct list_head list;
 	struct mlxsw_sp_port *mlxsw_sp_port;
 	struct mlxsw_sp_fid *fid;
+	unsigned int ref_count;
 	u16 vid;
 	struct mlxsw_sp_bridge_port *bridge_port;
 	struct list_head bridge_vlan_node;
