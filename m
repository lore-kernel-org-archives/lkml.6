Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16CCBC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB7D620895
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:48:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB7D620895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388324AbeG0LJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:09:07 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51612 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388154AbeG0LJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:09:06 -0400
Received: from localhost (unknown [89.188.5.116])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 29C7E898;
        Fri, 27 Jul 2018 09:48:01 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Or Gerlitz <ogerlitz@mellanox.com>,
        Jiri Pirko <jiri@mellanox.com>,
        Paul Blakey <paulb@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.17 27/66] net/mlx5e: Add ingress/egress indication for offloaded TC flows
Date:   Fri, 27 Jul 2018 11:45:20 +0200
Message-Id: <20180727093812.204381998@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727093809.043856530@linuxfoundation.org>
References: <20180727093809.043856530@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Or Gerlitz <ogerlitz@mellanox.com>

[ Upstream commit 60bd4af814fec164c42bdd2efd7984b85d6b1e1e ]

When an e-switch TC rule is offloaded through the egdev (egress
device) mechanism, we treat this as egress, all other cases (NIC
and e-switch) are considred ingress.

This is preparation step that will allow us to  identify "wrong"
stat/del offload calls made by the TC core on egdev based flows and
ignore them.

Signed-off-by: Or Gerlitz <ogerlitz@mellanox.com>
Signed-off-by: Jiri Pirko <jiri@mellanox.com>
Reviewed-by: Paul Blakey <paulb@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h      |    3 -
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c |   15 ++++----
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c  |   32 +++++++++++++-----
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c   |   38 ++++++++++++++++------
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.h   |   13 +++++--
 5 files changed, 70 insertions(+), 31 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -1092,9 +1092,6 @@ int mlx5e_ethtool_get_ts_info(struct mlx
 int mlx5e_ethtool_flash_device(struct mlx5e_priv *priv,
 			       struct ethtool_flash *flash);
 
-int mlx5e_setup_tc_block_cb(enum tc_setup_type type, void *type_data,
-			    void *cb_priv);
-
 /* mlx5e generic netdev management API */
 struct net_device*
 mlx5e_create_netdev(struct mlx5_core_dev *mdev, const struct mlx5e_profile *profile,
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -3093,22 +3093,23 @@ out:
 
 #ifdef CONFIG_MLX5_ESWITCH
 static int mlx5e_setup_tc_cls_flower(struct mlx5e_priv *priv,
-				     struct tc_cls_flower_offload *cls_flower)
+				     struct tc_cls_flower_offload *cls_flower,
+				     int flags)
 {
 	switch (cls_flower->command) {
 	case TC_CLSFLOWER_REPLACE:
-		return mlx5e_configure_flower(priv, cls_flower);
+		return mlx5e_configure_flower(priv, cls_flower, flags);
 	case TC_CLSFLOWER_DESTROY:
-		return mlx5e_delete_flower(priv, cls_flower);
+		return mlx5e_delete_flower(priv, cls_flower, flags);
 	case TC_CLSFLOWER_STATS:
-		return mlx5e_stats_flower(priv, cls_flower);
+		return mlx5e_stats_flower(priv, cls_flower, flags);
 	default:
 		return -EOPNOTSUPP;
 	}
 }
 
-int mlx5e_setup_tc_block_cb(enum tc_setup_type type, void *type_data,
-			    void *cb_priv)
+static int mlx5e_setup_tc_block_cb(enum tc_setup_type type, void *type_data,
+				   void *cb_priv)
 {
 	struct mlx5e_priv *priv = cb_priv;
 
@@ -3117,7 +3118,7 @@ int mlx5e_setup_tc_block_cb(enum tc_setu
 
 	switch (type) {
 	case TC_SETUP_CLSFLOWER:
-		return mlx5e_setup_tc_cls_flower(priv, type_data);
+		return mlx5e_setup_tc_cls_flower(priv, type_data, MLX5E_TC_INGRESS);
 	default:
 		return -EOPNOTSUPP;
 	}
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -723,15 +723,31 @@ static int mlx5e_rep_get_phys_port_name(
 
 static int
 mlx5e_rep_setup_tc_cls_flower(struct mlx5e_priv *priv,
-			      struct tc_cls_flower_offload *cls_flower)
+			      struct tc_cls_flower_offload *cls_flower, int flags)
 {
 	switch (cls_flower->command) {
 	case TC_CLSFLOWER_REPLACE:
-		return mlx5e_configure_flower(priv, cls_flower);
+		return mlx5e_configure_flower(priv, cls_flower, flags);
 	case TC_CLSFLOWER_DESTROY:
-		return mlx5e_delete_flower(priv, cls_flower);
+		return mlx5e_delete_flower(priv, cls_flower, flags);
 	case TC_CLSFLOWER_STATS:
-		return mlx5e_stats_flower(priv, cls_flower);
+		return mlx5e_stats_flower(priv, cls_flower, flags);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int mlx5e_rep_setup_tc_cb_egdev(enum tc_setup_type type, void *type_data,
+				       void *cb_priv)
+{
+	struct mlx5e_priv *priv = cb_priv;
+
+	if (!tc_cls_can_offload_and_chain0(priv->netdev, type_data))
+		return -EOPNOTSUPP;
+
+	switch (type) {
+	case TC_SETUP_CLSFLOWER:
+		return mlx5e_rep_setup_tc_cls_flower(priv, type_data, MLX5E_TC_EGRESS);
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -747,7 +763,7 @@ static int mlx5e_rep_setup_tc_cb(enum tc
 
 	switch (type) {
 	case TC_SETUP_CLSFLOWER:
-		return mlx5e_rep_setup_tc_cls_flower(priv, type_data);
+		return mlx5e_rep_setup_tc_cls_flower(priv, type_data, MLX5E_TC_INGRESS);
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -1111,7 +1127,7 @@ mlx5e_vport_rep_load(struct mlx5_core_de
 
 	uplink_rpriv = mlx5_eswitch_get_uplink_priv(dev->priv.eswitch, REP_ETH);
 	upriv = netdev_priv(uplink_rpriv->netdev);
-	err = tc_setup_cb_egdev_register(netdev, mlx5e_setup_tc_block_cb,
+	err = tc_setup_cb_egdev_register(netdev, mlx5e_rep_setup_tc_cb_egdev,
 					 upriv);
 	if (err)
 		goto err_neigh_cleanup;
@@ -1126,7 +1142,7 @@ mlx5e_vport_rep_load(struct mlx5_core_de
 	return 0;
 
 err_egdev_cleanup:
-	tc_setup_cb_egdev_unregister(netdev, mlx5e_setup_tc_block_cb,
+	tc_setup_cb_egdev_unregister(netdev, mlx5e_rep_setup_tc_cb_egdev,
 				     upriv);
 
 err_neigh_cleanup:
@@ -1155,7 +1171,7 @@ mlx5e_vport_rep_unload(struct mlx5_eswit
 	uplink_rpriv = mlx5_eswitch_get_uplink_priv(priv->mdev->priv.eswitch,
 						    REP_ETH);
 	upriv = netdev_priv(uplink_rpriv->netdev);
-	tc_setup_cb_egdev_unregister(netdev, mlx5e_setup_tc_block_cb,
+	tc_setup_cb_egdev_unregister(netdev, mlx5e_rep_setup_tc_cb_egdev,
 				     upriv);
 	mlx5e_rep_neigh_cleanup(rpriv);
 	mlx5e_detach_netdev(priv);
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -61,12 +61,16 @@ struct mlx5_nic_flow_attr {
 	struct mlx5_flow_table	*hairpin_ft;
 };
 
+#define MLX5E_TC_FLOW_BASE (MLX5E_TC_LAST_EXPORTED_BIT + 1)
+
 enum {
-	MLX5E_TC_FLOW_ESWITCH	= BIT(0),
-	MLX5E_TC_FLOW_NIC	= BIT(1),
-	MLX5E_TC_FLOW_OFFLOADED	= BIT(2),
-	MLX5E_TC_FLOW_HAIRPIN	= BIT(3),
-	MLX5E_TC_FLOW_HAIRPIN_RSS = BIT(4),
+	MLX5E_TC_FLOW_INGRESS	= MLX5E_TC_INGRESS,
+	MLX5E_TC_FLOW_EGRESS	= MLX5E_TC_EGRESS,
+	MLX5E_TC_FLOW_ESWITCH	= BIT(MLX5E_TC_FLOW_BASE),
+	MLX5E_TC_FLOW_NIC	= BIT(MLX5E_TC_FLOW_BASE + 1),
+	MLX5E_TC_FLOW_OFFLOADED	= BIT(MLX5E_TC_FLOW_BASE + 2),
+	MLX5E_TC_FLOW_HAIRPIN	= BIT(MLX5E_TC_FLOW_BASE + 3),
+	MLX5E_TC_FLOW_HAIRPIN_RSS = BIT(MLX5E_TC_FLOW_BASE + 4),
 };
 
 struct mlx5e_tc_flow {
@@ -2566,8 +2570,20 @@ static int parse_tc_fdb_actions(struct m
 	return err;
 }
 
+static void get_flags(int flags, u8 *flow_flags)
+{
+	u8 __flow_flags = 0;
+
+	if (flags & MLX5E_TC_INGRESS)
+		__flow_flags |= MLX5E_TC_FLOW_INGRESS;
+	if (flags & MLX5E_TC_EGRESS)
+		__flow_flags |= MLX5E_TC_FLOW_EGRESS;
+
+	*flow_flags = __flow_flags;
+}
+
 int mlx5e_configure_flower(struct mlx5e_priv *priv,
-			   struct tc_cls_flower_offload *f)
+			   struct tc_cls_flower_offload *f, int flags)
 {
 	struct mlx5_eswitch *esw = priv->mdev->priv.eswitch;
 	struct mlx5e_tc_flow_parse_attr *parse_attr;
@@ -2576,11 +2592,13 @@ int mlx5e_configure_flower(struct mlx5e_
 	int attr_size, err = 0;
 	u8 flow_flags = 0;
 
+	get_flags(flags, &flow_flags);
+
 	if (esw && esw->mode == SRIOV_OFFLOADS) {
-		flow_flags = MLX5E_TC_FLOW_ESWITCH;
+		flow_flags |= MLX5E_TC_FLOW_ESWITCH;
 		attr_size  = sizeof(struct mlx5_esw_flow_attr);
 	} else {
-		flow_flags = MLX5E_TC_FLOW_NIC;
+		flow_flags |= MLX5E_TC_FLOW_NIC;
 		attr_size  = sizeof(struct mlx5_nic_flow_attr);
 	}
 
@@ -2639,7 +2657,7 @@ err_free:
 }
 
 int mlx5e_delete_flower(struct mlx5e_priv *priv,
-			struct tc_cls_flower_offload *f)
+			struct tc_cls_flower_offload *f, int flags)
 {
 	struct mlx5e_tc_flow *flow;
 	struct mlx5e_tc_table *tc = &priv->fs.tc;
@@ -2659,7 +2677,7 @@ int mlx5e_delete_flower(struct mlx5e_pri
 }
 
 int mlx5e_stats_flower(struct mlx5e_priv *priv,
-		       struct tc_cls_flower_offload *f)
+		       struct tc_cls_flower_offload *f, int flags)
 {
 	struct mlx5e_tc_table *tc = &priv->fs.tc;
 	struct mlx5e_tc_flow *flow;
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.h
@@ -38,16 +38,23 @@
 #define MLX5E_TC_FLOW_ID_MASK 0x0000ffff
 
 #ifdef CONFIG_MLX5_ESWITCH
+
+enum {
+	MLX5E_TC_INGRESS = BIT(0),
+	MLX5E_TC_EGRESS  = BIT(1),
+	MLX5E_TC_LAST_EXPORTED_BIT = 1,
+};
+
 int mlx5e_tc_init(struct mlx5e_priv *priv);
 void mlx5e_tc_cleanup(struct mlx5e_priv *priv);
 
 int mlx5e_configure_flower(struct mlx5e_priv *priv,
-			   struct tc_cls_flower_offload *f);
+			   struct tc_cls_flower_offload *f, int flags);
 int mlx5e_delete_flower(struct mlx5e_priv *priv,
-			struct tc_cls_flower_offload *f);
+			struct tc_cls_flower_offload *f, int flags);
 
 int mlx5e_stats_flower(struct mlx5e_priv *priv,
-		       struct tc_cls_flower_offload *f);
+		       struct tc_cls_flower_offload *f, int flags);
 
 struct mlx5e_encap_entry;
 void mlx5e_tc_encap_flows_add(struct mlx5e_priv *priv,


