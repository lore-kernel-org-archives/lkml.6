Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 254BEC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA546214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895553;
	bh=AfkbaJCbna1xMScEcd2XXkTYYxn6zgIuIpHNOi8amew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=y61zXqe85W765wLzTkbycBFw+Lmn+Wt/UsB49y+TTp01QJKLumYRGigYShS2Kg3jL
	 is2OmI4S4jnsf44tUijmSu5hbmJhCgM0MWstLzRLAgxhVHPawLFZ2Wy6rtS0p1+zz3
	 ka3D3s5dufUyRRZBhaRwIr/aq6TSPpdlWAp5q/cI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729954AbfBKOcb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:32:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:39826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730473AbfBKOc1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:32:27 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB58D20844;
        Mon, 11 Feb 2019 14:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895546;
        bh=AfkbaJCbna1xMScEcd2XXkTYYxn6zgIuIpHNOi8amew=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qIH9Au6d3LwULKSZVYz4FOv5WxlfPHuO1aiMcf1uR9otQbBOIfNK73Bd0LhTwYGfl
         7B2TrPc0mRXTU8ZT8cNnqY4YxMA3/8a6lqPgTfdCaVwJCYCijxp46WZ2IThPjVkVjf
         hjdLmNU/DFtyFKQ9YeyP98VGIyG+MDRsn67Bdl+s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ido Schimmel <idosch@mellanox.com>,
        Petr Machata <petrm@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 213/352] mlxsw: spectrum: Properly cleanup LAG uppers when removing port from LAG
Date:   Mon, 11 Feb 2019 15:17:20 +0100
Message-Id: <20190211141900.768213130@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 124aee09e953..8f1180fff955 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -4298,6 +4298,25 @@ void mlxsw_sp_port_dev_put(struct mlxsw_sp_port *mlxsw_sp_port)
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
@@ -4490,6 +4509,10 @@ static void mlxsw_sp_port_lag_leave(struct mlxsw_sp_port *mlxsw_sp_port,
 
 	/* Any VLANs configured on the port are no longer valid */
 	mlxsw_sp_port_vlan_flush(mlxsw_sp_port);
+	/* Make the LAG and its directly linked uppers leave bridges they
+	 * are memeber in
+	 */
+	mlxsw_sp_port_lag_uppers_cleanup(mlxsw_sp_port, lag_dev);
 
 	if (lag->ref_count == 1)
 		mlxsw_sp_lag_destroy(mlxsw_sp, lag_id);
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index 69f556ddb934..c514af438fc2 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -292,30 +292,6 @@ mlxsw_sp_bridge_port_destroy(struct mlxsw_sp_bridge_port *bridge_port)
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
@@ -353,8 +329,7 @@ static void mlxsw_sp_bridge_port_put(struct mlxsw_sp_bridge *bridge,
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



