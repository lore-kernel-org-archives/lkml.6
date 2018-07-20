Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22092ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:41:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAFC520850
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:41:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAFC520850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389668AbeGTN30 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:29:26 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51528 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389077AbeGTN3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:29:25 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8DECDBBF;
        Fri, 20 Jul 2018 12:37:40 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Or Gerlitz <ogerlitz@mellanox.com>,
        Guy Kushnir <guyk@mellanox.com>, Eli Cohen <eli@melloanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.17 021/101] net/mlx5: E-Switch, Avoid setup attempt if not being e-switch manager
Date:   Fri, 20 Jul 2018 14:13:27 +0200
Message-Id: <20180720121423.864322367@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720121422.837870592@linuxfoundation.org>
References: <20180720121422.837870592@linuxfoundation.org>
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

[ Upstream commit 0efc8562491b7d36f6bbc4fbc8f3348cb6641e9c ]

In smartnic env, the host (PF) driver might not be an e-switch
manager, hence the FW will err on driver attempts to deal with
setting/unsetting the eswitch and as a result the overall setup
of sriov will fail.

Fix that by avoiding the operation if e-switch management is not
allowed for this driver instance. While here, move to use the
correct name for the esw manager capability name.

Fixes: 81848731ff40 ('net/mlx5: E-Switch, Add SR-IOV (FDB) support')
Signed-off-by: Or Gerlitz <ogerlitz@mellanox.com>
Reported-by: Guy Kushnir <guyk@mellanox.com>
Reviewed-by: Eli Cohen <eli@melloanox.com>
Tested-by: Eli Cohen <eli@melloanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c  |    2 +-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c |    2 +-
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c |    3 ++-
 drivers/net/ethernet/mellanox/mlx5/core/fw.c      |    5 +++--
 drivers/net/ethernet/mellanox/mlx5/core/sriov.c   |    7 ++++++-
 include/linux/mlx5/eswitch.h                      |    2 ++
 include/linux/mlx5/mlx5_ifc.h                     |    2 +-
 7 files changed, 16 insertions(+), 7 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -806,7 +806,7 @@ static bool mlx5e_is_vf_vport_rep(struct
 	struct mlx5e_rep_priv *rpriv = priv->ppriv;
 	struct mlx5_eswitch_rep *rep;
 
-	if (!MLX5_CAP_GEN(priv->mdev, eswitch_flow_table))
+	if (!MLX5_ESWITCH_MANAGER(priv->mdev))
 		return false;
 
 	rep = rpriv->rep;
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -1604,7 +1604,7 @@ int mlx5_eswitch_enable_sriov(struct mlx
 	if (!ESW_ALLOWED(esw))
 		return 0;
 
-	if (!MLX5_CAP_GEN(esw->dev, eswitch_flow_table) ||
+	if (!MLX5_ESWITCH_MANAGER(esw->dev) ||
 	    !MLX5_CAP_ESW_FLOWTABLE_FDB(esw->dev, ft_support)) {
 		esw_warn(esw->dev, "E-Switch FDB is not supported, aborting ...\n");
 		return -EOPNOTSUPP;
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -32,6 +32,7 @@
 
 #include <linux/mutex.h>
 #include <linux/mlx5/driver.h>
+#include <linux/mlx5/eswitch.h>
 
 #include "mlx5_core.h"
 #include "fs_core.h"
@@ -2631,7 +2632,7 @@ int mlx5_init_fs(struct mlx5_core_dev *d
 			goto err;
 	}
 
-	if (MLX5_CAP_GEN(dev, eswitch_flow_table)) {
+	if (MLX5_ESWITCH_MANAGER(dev)) {
 		if (MLX5_CAP_ESW_FLOWTABLE_FDB(dev, ft_support)) {
 			err = init_fdb_root_ns(steering);
 			if (err)
--- a/drivers/net/ethernet/mellanox/mlx5/core/fw.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fw.c
@@ -32,6 +32,7 @@
 
 #include <linux/mlx5/driver.h>
 #include <linux/mlx5/cmd.h>
+#include <linux/mlx5/eswitch.h>
 #include <linux/module.h>
 #include "mlx5_core.h"
 #include "../../mlxfw/mlxfw.h"
@@ -159,13 +160,13 @@ int mlx5_query_hca_caps(struct mlx5_core
 	}
 
 	if (MLX5_CAP_GEN(dev, vport_group_manager) &&
-	    MLX5_CAP_GEN(dev, eswitch_flow_table)) {
+	    MLX5_ESWITCH_MANAGER(dev)) {
 		err = mlx5_core_get_caps(dev, MLX5_CAP_ESWITCH_FLOW_TABLE);
 		if (err)
 			return err;
 	}
 
-	if (MLX5_CAP_GEN(dev, eswitch_flow_table)) {
+	if (MLX5_ESWITCH_MANAGER(dev)) {
 		err = mlx5_core_get_caps(dev, MLX5_CAP_ESWITCH);
 		if (err)
 			return err;
--- a/drivers/net/ethernet/mellanox/mlx5/core/sriov.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sriov.c
@@ -88,6 +88,9 @@ static int mlx5_device_enable_sriov(stru
 		return -EBUSY;
 	}
 
+	if (!MLX5_ESWITCH_MANAGER(dev))
+		goto enable_vfs_hca;
+
 	err = mlx5_eswitch_enable_sriov(dev->priv.eswitch, num_vfs, SRIOV_LEGACY);
 	if (err) {
 		mlx5_core_warn(dev,
@@ -95,6 +98,7 @@ static int mlx5_device_enable_sriov(stru
 		return err;
 	}
 
+enable_vfs_hca:
 	for (vf = 0; vf < num_vfs; vf++) {
 		err = mlx5_core_enable_hca(dev, vf + 1);
 		if (err) {
@@ -140,7 +144,8 @@ static void mlx5_device_disable_sriov(st
 	}
 
 out:
-	mlx5_eswitch_disable_sriov(dev->priv.eswitch);
+	if (MLX5_ESWITCH_MANAGER(dev))
+		mlx5_eswitch_disable_sriov(dev->priv.eswitch);
 
 	if (mlx5_wait_for_vf_pages(dev))
 		mlx5_core_warn(dev, "timeout reclaiming VFs pages\n");
--- a/include/linux/mlx5/eswitch.h
+++ b/include/linux/mlx5/eswitch.h
@@ -8,6 +8,8 @@
 
 #include <linux/mlx5/driver.h>
 
+#define MLX5_ESWITCH_MANAGER(mdev) MLX5_CAP_GEN(mdev, eswitch_manager)
+
 enum {
 	SRIOV_NONE,
 	SRIOV_LEGACY,
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -905,7 +905,7 @@ struct mlx5_ifc_cmd_hca_cap_bits {
 	u8         vnic_env_queue_counters[0x1];
 	u8         ets[0x1];
 	u8         nic_flow_table[0x1];
-	u8         eswitch_flow_table[0x1];
+	u8         eswitch_manager[0x1];
 	u8         device_memory[0x1];
 	u8         mcam_reg[0x1];
 	u8         pcam_reg[0x1];


