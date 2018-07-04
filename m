Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E30C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 11:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7919220C07
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 11:32:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7919220C07
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934544AbeGDLcR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 07:32:17 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:46034 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934115AbeGDLbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 07:31:23 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from moshe@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 4 Jul 2018 14:34:10 +0300
Received: from dev-l-vrt-136.mtl.labs.mlnx (dev-l-vrt-136.mtl.labs.mlnx [10.134.136.1])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id w64BVKPI031402;
        Wed, 4 Jul 2018 14:31:20 +0300
Received: from dev-l-vrt-136.mtl.labs.mlnx (localhost [127.0.0.1])
        by dev-l-vrt-136.mtl.labs.mlnx (8.14.7/8.14.7) with ESMTP id w64BVKnU024657;
        Wed, 4 Jul 2018 14:31:20 +0300
Received: (from moshe@localhost)
        by dev-l-vrt-136.mtl.labs.mlnx (8.14.7/8.14.7/Submit) id w64BVKJa024656;
        Wed, 4 Jul 2018 14:31:20 +0300
From:   Moshe Shemesh <moshe@mellanox.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Vasundhara Volam <vasundhara-v.volam@broadcom.com>,
        Jiri Pirko <jiri@mellanox.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Moshe Shemesh <moshe@mellanox.com>
Subject: [PATCH net-next 08/10] mlx4: Add support for devlink reload and load driverinit values
Date:   Wed,  4 Jul 2018 14:30:35 +0300
Message-Id: <1530703837-24563-9-git-send-email-moshe@mellanox.com>
X-Mailer: git-send-email 1.8.4.3
In-Reply-To: <1530703837-24563-1-git-send-email-moshe@mellanox.com>
References: <1530703837-24563-1-git-send-email-moshe@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add mlx4_devlink_reload() to support devlink reload operation.
Add mlx4_devlink_param_load_driverinit_values() to load values which
were set using driverinit configuration mode.

Signed-off-by: Moshe Shemesh <moshe@mellanox.com>
Signed-off-by: Jiri Pirko <jiri@mellanox.com>
---
 drivers/net/ethernet/mellanox/mlx4/catas.c |  2 +-
 drivers/net/ethernet/mellanox/mlx4/main.c  | 53 +++++++++++++++++++++++++++++-
 drivers/net/ethernet/mellanox/mlx4/mlx4.h  |  3 +-
 3 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/catas.c b/drivers/net/ethernet/mellanox/mlx4/catas.c
index e2b6b0c..8afe4b5 100644
--- a/drivers/net/ethernet/mellanox/mlx4/catas.c
+++ b/drivers/net/ethernet/mellanox/mlx4/catas.c
@@ -212,7 +212,7 @@ static void mlx4_handle_error_state(struct mlx4_dev_persistent *persist)
 	mutex_lock(&persist->interface_state_mutex);
 	if (persist->interface_state & MLX4_INTERFACE_STATE_UP &&
 	    !(persist->interface_state & MLX4_INTERFACE_STATE_DELETION)) {
-		err = mlx4_restart_one(persist->pdev);
+		err = mlx4_restart_one(persist->pdev, false, NULL);
 		mlx4_info(persist->dev, "mlx4_restart_one was ended, ret=%d\n",
 			  err);
 	}
diff --git a/drivers/net/ethernet/mellanox/mlx4/main.c b/drivers/net/ethernet/mellanox/mlx4/main.c
index 2445f79..c42eddf 100644
--- a/drivers/net/ethernet/mellanox/mlx4/main.c
+++ b/drivers/net/ethernet/mellanox/mlx4/main.c
@@ -3852,8 +3852,57 @@ static int mlx4_devlink_port_type_set(struct devlink_port *devlink_port,
 	return __set_port_type(info, mlx4_port_type);
 }
 
+static void mlx4_devlink_param_load_driverinit_values(struct devlink *devlink)
+{
+	union devlink_param_value saved_value;
+	int err;
+
+	err = devlink_param_driverinit_value_get(devlink,
+						 DEVLINK_PARAM_GENERIC_ID_INT_ERR_RESET,
+						 &saved_value);
+	if (!err && mlx4_internal_err_reset != saved_value.vbool) {
+		mlx4_internal_err_reset = saved_value.vbool;
+		/* Notify on value changed on runtime configuration mode */
+		devlink_param_value_changed(devlink,
+					    DEVLINK_PARAM_GENERIC_ID_INT_ERR_RESET);
+	}
+	err = devlink_param_driverinit_value_get(devlink,
+						 DEVLINK_PARAM_GENERIC_ID_MAX_MACS,
+						 &saved_value);
+	if (!err)
+		log_num_mac = order_base_2(saved_value.vu32);
+	err = devlink_param_driverinit_value_get(devlink,
+						 MLX4_DEVLINK_PARAM_ID_ENABLE_64B_CQE_EQE,
+						 &saved_value);
+	if (!err)
+		enable_64b_cqe_eqe = saved_value.vbool;
+	err = devlink_param_driverinit_value_get(devlink,
+						 MLX4_DEVLINK_PARAM_ID_ENABLE_4K_UAR,
+						 &saved_value);
+	if (!err)
+		enable_4k_uar = saved_value.vbool;
+}
+
+static int mlx4_devlink_reload(struct devlink *devlink,
+			       struct netlink_ext_ack *extack)
+{
+	struct mlx4_priv *priv = devlink_priv(devlink);
+	struct mlx4_dev *dev = &priv->dev;
+	struct mlx4_dev_persistent *persist = dev->persist;
+	int err;
+
+	if (persist->num_vfs)
+		mlx4_warn(persist->dev, "Reload performed on PF, will cause reset on operating Virtual Functions\n");
+	err = mlx4_restart_one(persist->pdev, true, devlink);
+	if (err)
+		mlx4_err(persist->dev, "mlx4_restart_one failed, ret=%d\n", err);
+
+	return err;
+}
+
 static const struct devlink_ops mlx4_devlink_ops = {
 	.port_type_set	= mlx4_devlink_port_type_set,
+	.reload		= mlx4_devlink_reload,
 };
 
 static int mlx4_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
@@ -4064,7 +4113,7 @@ static int restore_current_port_types(struct mlx4_dev *dev,
 	return err;
 }
 
-int mlx4_restart_one(struct pci_dev *pdev)
+int mlx4_restart_one(struct pci_dev *pdev, bool reload, struct devlink *devlink)
 {
 	struct mlx4_dev_persistent *persist = pci_get_drvdata(pdev);
 	struct mlx4_dev	 *dev  = persist->dev;
@@ -4077,6 +4126,8 @@ int mlx4_restart_one(struct pci_dev *pdev)
 	memcpy(nvfs, dev->persist->nvfs, sizeof(dev->persist->nvfs));
 
 	mlx4_unload_one(pdev);
+	if (reload)
+		mlx4_devlink_param_load_driverinit_values(devlink);
 	err = mlx4_load_one(pdev, pci_dev_data, total_vfs, nvfs, priv, 1);
 	if (err) {
 		mlx4_err(dev, "%s: ERROR: mlx4_load_one failed, pci_name=%s, err=%d\n",
diff --git a/drivers/net/ethernet/mellanox/mlx4/mlx4.h b/drivers/net/ethernet/mellanox/mlx4/mlx4.h
index cb9e923..2ebaa3b 100644
--- a/drivers/net/ethernet/mellanox/mlx4/mlx4.h
+++ b/drivers/net/ethernet/mellanox/mlx4/mlx4.h
@@ -1042,7 +1042,8 @@ int mlx4_calc_vf_counters(struct mlx4_dev *dev, int slave, int port,
 void mlx4_stop_catas_poll(struct mlx4_dev *dev);
 int mlx4_catas_init(struct mlx4_dev *dev);
 void mlx4_catas_end(struct mlx4_dev *dev);
-int mlx4_restart_one(struct pci_dev *pdev);
+int mlx4_restart_one(struct pci_dev *pdev, bool reload,
+		     struct devlink *devlink);
 int mlx4_register_device(struct mlx4_dev *dev);
 void mlx4_unregister_device(struct mlx4_dev *dev);
 void mlx4_dispatch_event(struct mlx4_dev *dev, enum mlx4_dev_event type,
-- 
1.8.3.1

