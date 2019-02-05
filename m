Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A107C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:13:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDF0A2054F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:13:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pPiaAbbX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730413AbfBEWNm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 17:13:42 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46423 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbfBEWNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 17:13:39 -0500
Received: by mail-ed1-f68.google.com with SMTP id o10so4234786edt.13;
        Tue, 05 Feb 2019 14:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3mX5fH4LKPGaIOryzhzseVTjCTVN1J2S2fZbA4M9ttU=;
        b=pPiaAbbXY++lZPzeb9nmO6y2a1sAa2lUFEFQDijUaiCKDlyjFx7Bd9QfsUkoKhogBm
         AFTiMPhIGdtEnCMPsH39V4wiNgQs7wsPsC0suGM71XMdA3HM4q9iFb+ZfOqDWBgMOPPr
         t/Acy6Lslsfnf2HxkfnHkm1Q8/dpEWVCXDNJ3wgPP4LMPBLEJkkZ/e2VVKw5mz48atgb
         8co9Mgnowat68isdvcbD96QH7rymrkSnMSaiypC/Pi8T9CAF7f+uNqPOGGszqgNTEJu3
         KXarY4HfD0V4575PiPdGgKTlzY7aZPJ0rmlP2EGNf7yXkY3yn0uNwGhi1sSyRz9dBC7Q
         cEYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3mX5fH4LKPGaIOryzhzseVTjCTVN1J2S2fZbA4M9ttU=;
        b=cUFxU6ceO+/TFg20QGB63CyqAsRmRWDozO0+xCi5Fc/O/M2d8//PITfSYYRjRVE+23
         uwc/lO2R4fYL/fFIIOBTPBeElM9fi70O03o1RFD4knVFLolj1alrVtGa8YiL/KVaBTDw
         yfshPOdn4r6qQdYhGUD8gcQ0a1MR0NY0Dpzx8z8O8fw+ZJ3JqmnZj9ULTt5QNdxqCrlK
         RckHGR3R76vCIKAewKjtLaI7pz34kMYOIXy1KWLwUqEAjmlXSrkpEPjkHiIbGAxL65/W
         BJpMeQmBIQHR9WfalzgZGWAUIeR23aYGjlBt1Cu9TNQPViZdRg7U4fQzHHAWBsM2oZWk
         eFkA==
X-Gm-Message-State: AHQUAuY/yHF5Gb7yOweUflxtllhYXBWVsWObAirY1q4IxyRTYvjtW6AD
        XUkVbu6gKtXn4YZo8GIO3n3hqIjL
X-Google-Smtp-Source: AHgI3Iacy2LCKsCWS6U/+aaeZvLQrt5Xw3ISp3/CBcgkXhwWpDrF02oaTLw9vsaR+40ZYtDWwJwF/Q==
X-Received: by 2002:a17:906:b208:: with SMTP id p8mr5176811ejz.17.1549404816791;
        Tue, 05 Feb 2019 14:13:36 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id x47sm5523299eda.91.2019.02.05.14.13.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 14:13:36 -0800 (PST)
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
Subject: [PATCH net-next v2 04/12] net/mlx5e: Implement ndo_get_port_parent_id()
Date:   Tue,  5 Feb 2019 14:13:03 -0800
Message-Id: <20190205221311.18476-5-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190205221311.18476-1-f.fainelli@gmail.com>
References: <20190205221311.18476-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mlx5e only supports SWITCHDEV_ATTR_ID_PORT_PARENT_ID, which makes it a
great candidate to be converted to use the ndo_get_port_parent_id() NDO
instead of implementing switchdev_port_attr_get().

Since mlx5e makes use of switchdev_port_parent_id() convert it to use
netdev_port_same_parent_id().

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../ethernet/mellanox/mlx5/core/en/tc_tun.c   |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en_rep.c  | 31 +++++++------------
 .../net/ethernet/mellanox/mlx5/core/en_tc.c   |  5 ++-
 3 files changed, 14 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c
index 046948ead152..19dc4a963b90 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c
@@ -25,7 +25,7 @@ static int get_route_and_out_devs(struct mlx5e_priv *priv,
 	/* if the egress device isn't on the same HW e-switch or
 	 * it's a LAG device, use the uplink
 	 */
-	if (!switchdev_port_same_parent_id(priv->netdev, dev) ||
+	if (!netdev_port_same_parent_id(priv->netdev, dev) ||
 	    dst_is_lag_dev) {
 		*route_dev = uplink_dev;
 		*out_dev = *route_dev;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
index 5d2e0c2f6624..0b1988b330f3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -381,7 +381,8 @@ static const struct ethtool_ops mlx5e_uplink_rep_ethtool_ops = {
 	.set_pauseparam    = mlx5e_uplink_rep_set_pauseparam,
 };
 
-static int mlx5e_attr_get(struct net_device *dev, struct switchdev_attr *attr)
+static int mlx5e_rep_get_port_parent_id(struct net_device *dev,
+					struct netdev_phys_item_id *ppid)
 {
 	struct mlx5e_priv *priv = netdev_priv(dev);
 	struct mlx5_eswitch *esw = priv->mdev->priv.eswitch;
@@ -398,20 +399,14 @@ static int mlx5e_attr_get(struct net_device *dev, struct switchdev_attr *attr)
 		uplink_priv = netdev_priv(uplink_dev);
 	}
 
-	switch (attr->id) {
-	case SWITCHDEV_ATTR_ID_PORT_PARENT_ID:
-		attr->u.ppid.id_len = ETH_ALEN;
-		if (uplink_upper && mlx5_lag_is_sriov(uplink_priv->mdev)) {
-			ether_addr_copy(attr->u.ppid.id, uplink_upper->dev_addr);
-		} else {
-			struct mlx5e_rep_priv *rpriv = priv->ppriv;
-			struct mlx5_eswitch_rep *rep = rpriv->rep;
+	ppid->id_len = ETH_ALEN;
+	if (uplink_upper && mlx5_lag_is_sriov(uplink_priv->mdev)) {
+		ether_addr_copy(ppid->id, uplink_upper->dev_addr);
+	} else {
+		struct mlx5e_rep_priv *rpriv = priv->ppriv;
+		struct mlx5_eswitch_rep *rep = rpriv->rep;
 
-			ether_addr_copy(attr->u.ppid.id, rep->hw_id);
-		}
-		break;
-	default:
-		return -EOPNOTSUPP;
+		ether_addr_copy(ppid->id, rep->hw_id);
 	}
 
 	return 0;
@@ -1284,10 +1279,6 @@ static int mlx5e_uplink_rep_set_vf_vlan(struct net_device *dev, int vf, u16 vlan
 	return 0;
 }
 
-static const struct switchdev_ops mlx5e_rep_switchdev_ops = {
-	.switchdev_port_attr_get	= mlx5e_attr_get,
-};
-
 static const struct net_device_ops mlx5e_netdev_ops_vf_rep = {
 	.ndo_open                = mlx5e_vf_rep_open,
 	.ndo_stop                = mlx5e_vf_rep_close,
@@ -1298,6 +1289,7 @@ static const struct net_device_ops mlx5e_netdev_ops_vf_rep = {
 	.ndo_has_offload_stats	 = mlx5e_rep_has_offload_stats,
 	.ndo_get_offload_stats	 = mlx5e_rep_get_offload_stats,
 	.ndo_change_mtu          = mlx5e_vf_rep_change_mtu,
+	.ndo_get_port_parent_id	 = mlx5e_rep_get_port_parent_id,
 };
 
 static const struct net_device_ops mlx5e_netdev_ops_uplink_rep = {
@@ -1319,6 +1311,7 @@ static const struct net_device_ops mlx5e_netdev_ops_uplink_rep = {
 	.ndo_get_vf_config       = mlx5e_get_vf_config,
 	.ndo_get_vf_stats        = mlx5e_get_vf_stats,
 	.ndo_set_vf_vlan         = mlx5e_uplink_rep_set_vf_vlan,
+	.ndo_get_port_parent_id	 = mlx5e_rep_get_port_parent_id,
 };
 
 bool mlx5e_eswitch_rep(struct net_device *netdev)
@@ -1393,8 +1386,6 @@ static void mlx5e_build_rep_netdev(struct net_device *netdev)
 	netdev->watchdog_timeo    = 15 * HZ;
 
 
-	netdev->switchdev_ops = &mlx5e_rep_switchdev_ops;
-
 	netdev->features	 |= NETIF_F_HW_TC | NETIF_F_NETNS_LOCAL;
 	netdev->hw_features      |= NETIF_F_HW_TC;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
index 74159d39dd66..098b28feba0c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -38,7 +38,6 @@
 #include <linux/mlx5/fs.h>
 #include <linux/mlx5/device.h>
 #include <linux/rhashtable.h>
-#include <net/switchdev.h>
 #include <net/tc_act/tc_mirred.h>
 #include <net/tc_act/tc_vlan.h>
 #include <net/tc_act/tc_tunnel_key.h>
@@ -2569,8 +2568,8 @@ static int parse_tc_fdb_actions(struct mlx5e_priv *priv, struct tcf_exts *exts,
 
 			action |= MLX5_FLOW_CONTEXT_ACTION_FWD_DEST |
 				  MLX5_FLOW_CONTEXT_ACTION_COUNT;
-			if (switchdev_port_same_parent_id(priv->netdev,
-							  out_dev) ||
+			if (netdev_port_same_parent_id(priv->netdev,
+						       out_dev) ||
 			    is_merged_eswitch_dev(priv, out_dev)) {
 				struct mlx5_eswitch *esw = priv->mdev->priv.eswitch;
 				struct net_device *uplink_dev = mlx5_eswitch_uplink_get_proto_dev(esw, REP_ETH);
-- 
2.17.1

