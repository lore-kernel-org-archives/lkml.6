Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D51CDC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6B9F2148E
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548692227;
	bh=o0Vhzp8tST2qQstEFg0xGSNNmzH3GmX0Ha2xIUgb/Tc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EZsEZ6vKM0cY5xej7APHRgyFvJnb6qstHvi5W7JBLvPzJy9r3Y3/ybBMXMWYc4kb3
	 Uq5DuqGPfaQzwqGWhMPpogb8GkTcD0M0GAhuFPSQhcvQpRyDefBVdFbt5jvGafO+gE
	 K9pU0xq1bvfwa4I7rxSinjnXaJTvjpmRt9gqK4YM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388128AbfA1QRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:17:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:50734 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388113AbfA1QRE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:17:04 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5445C20879;
        Mon, 28 Jan 2019 16:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692223;
        bh=o0Vhzp8tST2qQstEFg0xGSNNmzH3GmX0Ha2xIUgb/Tc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Av+Y6n1XKK1hqG1+QyLQfeb1NPfQMOk3VRIXw99Bb9T3Uq0TPeYeB7x78kqYhQvn5
         PnYmr6nRgjya+bBWpwLoui7Xq9Am24xhTRf3S9PNoIroDs+OoXs2BV5r43VMwGpZET
         /etf0opA4ZIPwJ5SVj55bPRrbV2J6JKXWBEsxuus=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ido Schimmel <idosch@mellanox.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 117/170] mlxsw: spectrum: Properly cleanup LAG uppers when removing port from LAG
Date:   Mon, 28 Jan 2019 11:11:07 -0500
Message-Id: <20190128161200.55107-117-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128161200.55107-1-sashal@kernel.org>
References: <20190128161200.55107-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ido Schimmel <idosch@mellanox.com>

[ Upstream commit be2d6f421f680e01d58f7cd452646e0d8586d49b ]

When a LAG device or a VLAN device on top of it is enslaved to a bridge,
the driver propagates the CHANGEUPPER event to the LAG's slaves.

This causes each physical port to increase the reference count of the
internal representation of the bridge port by calling
mlxsw_sp_port_bridge_join().

However, when a port is removed from a LAG, the corresponding leave()
function is not called and the reference count is not decremented. This
leads to ugly hacks such as mlxsw_sp_bridge_port_should_destroy() that
try to understand if the bridge port should be destroyed even when its
reference count is not 0.

Instead, make sure that when a port is unlinked from a LAG it would see
the same events as if the LAG (or its uppers) were unlinked from a
bridge.

The above is achieved by walking the LAG's uppers when a port is
unlinked and calling mlxsw_sp_port_bridge_leave() for each upper that is
enslaved to a bridge.

Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Reviewed-by: Petr Machata <petrm@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/mellanox/mlxsw/spectrum.c    | 23 ++++++++++++++++
 .../mellanox/mlxsw/spectrum_switchdev.c       | 27 +------------------
 2 files changed, 24 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index cf65b2ee8b95..7892e6b8d2e8 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -3907,6 +3907,25 @@ void mlxsw_sp_port_dev_put(struct mlxsw_sp_port *mlxsw_sp_port)
 	dev_put(mlxsw_sp_port->dev);
 }
 
+static void
+mlxsw_sp_port_lag_uppers_cleanup(struct mlxsw_sp_port *mlxsw_sp_port,
+				 struct net_device *lag_dev)
+{
+	struct net_device *br_dev = netdev_master_upper_dev_get(lag_dev);
+	struct net_device *upper_dev;
+	struct list_head *iter;
+
+	if (netif_is_bridge_port(lag_dev))
+		mlxsw_sp_port_bridge_leave(mlxsw_sp_port, lag_dev, br_dev);
+
+	netdev_for_each_upper_dev_rcu(lag_dev, upper_dev, iter) {
+		if (!netif_is_bridge_port(upper_dev))
+			continue;
+		br_dev = netdev_master_upper_dev_get(upper_dev);
+		mlxsw_sp_port_bridge_leave(mlxsw_sp_port, upper_dev, br_dev);
+	}
+}
+
 static int mlxsw_sp_lag_create(struct mlxsw_sp *mlxsw_sp, u16 lag_id)
 {
 	char sldr_pl[MLXSW_REG_SLDR_LEN];
@@ -4094,6 +4113,10 @@ static void mlxsw_sp_port_lag_leave(struct mlxsw_sp_port *mlxsw_sp_port,
 
 	/* Any VLANs configured on the port are no longer valid */
 	mlxsw_sp_port_vlan_flush(mlxsw_sp_port);
+	/* Make the LAG and its directly linked uppers leave bridges they
+	 * are memeber in
+	 */
+	mlxsw_sp_port_lag_uppers_cleanup(mlxsw_sp_port, lag_dev);
 
 	if (lag->ref_count == 1)
 		mlxsw_sp_lag_destroy(mlxsw_sp, lag_id);
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index 9052e93e1925..f33fb95c4189 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -291,30 +291,6 @@ mlxsw_sp_bridge_port_destroy(struct mlxsw_sp_bridge_port *bridge_port)
 	kfree(bridge_port);
 }
 
-static bool
-mlxsw_sp_bridge_port_should_destroy(const struct mlxsw_sp_bridge_port *
-				    bridge_port)
-{
-	struct net_device *dev = bridge_port->dev;
-	struct mlxsw_sp *mlxsw_sp;
-
-	if (is_vlan_dev(dev))
-		mlxsw_sp = mlxsw_sp_lower_get(vlan_dev_real_dev(dev));
-	else
-		mlxsw_sp = mlxsw_sp_lower_get(dev);
-
-	/* In case ports were pulled from out of a bridged LAG, then
-	 * it's possible the reference count isn't zero, yet the bridge
-	 * port should be destroyed, as it's no longer an upper of ours.
-	 */
-	if (!mlxsw_sp && list_empty(&bridge_port->vlans_list))
-		return true;
-	else if (bridge_port->ref_count == 0)
-		return true;
-	else
-		return false;
-}
-
 static struct mlxsw_sp_bridge_port *
 mlxsw_sp_bridge_port_get(struct mlxsw_sp_bridge *bridge,
 			 struct net_device *brport_dev)
@@ -352,8 +328,7 @@ static void mlxsw_sp_bridge_port_put(struct mlxsw_sp_bridge *bridge,
 {
 	struct mlxsw_sp_bridge_device *bridge_device;
 
-	bridge_port->ref_count--;
-	if (!mlxsw_sp_bridge_port_should_destroy(bridge_port))
+	if (--bridge_port->ref_count != 0)
 		return;
 	bridge_device = bridge_port->bridge_device;
 	mlxsw_sp_bridge_port_destroy(bridge_port);
-- 
2.19.1

