Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD54C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 00:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1154120651
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 00:01:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H3nqMZLO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbfBWABD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 19:01:03 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:40809 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbfBWAA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 19:00:59 -0500
Received: by mail-pl1-f195.google.com with SMTP id bj4so1775032plb.7;
        Fri, 22 Feb 2019 16:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=e6E5yXxxOu+GooUpHMHfdFlKV5FD1GMPis9dbjfbz5c=;
        b=H3nqMZLO3I0o0bPyPS8ef2zL1gBtIo06TfF/loUOcDH/ru+qIzi7CMmuiNTOMJGmCm
         la8VypB55n7M/qkPzYo3tY9/Iw2N2Z2FvGPv0YSTBmY2jEhYkALYLPqHlhdYMPoijbky
         PAbJQV4Ad040F+hro9ZMLw4eIz/LRQ4iIHabS5DDhzVVUB5ovi6o3ys1JAcfjPGQ0jN7
         sAUU0wv72eSNkpOsW3gMjpVIZWI1KSlqaEqnDzTOLLU1Mw7OKBGuEBpKPfndltpxRaQH
         F4zho4DrJ5AH6nV6r1gbnHWiKdog5CG1UgkMkUaq3vCZURF+0+3soeZ7yS+VKvGNL54E
         3JNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=e6E5yXxxOu+GooUpHMHfdFlKV5FD1GMPis9dbjfbz5c=;
        b=C1WTUMYGklbgVXmmpJQlMLtiJTGaAShA0dmUeeeiMIWWyV61L9i1ruco0SiEgkqe7D
         w5rlo+2GinKPgHPWkwQ29nfm4KSLX/J7gGAzbM71LEQC1B8670BFls6PP6NiuIlzi8+5
         1FaEZ4OIIQ45gwfxGj2qmeSBcaDamrgFLMsSGMpph59WJiSYcYH6qCL1ura4c/I+IHkM
         lNBpaXLsHGmmI8MWWP7ZbzclHnJYrPrv8z8sjwNZlo0DOriALRiPOOr7yYbQrxMYS4dM
         udflJDlhKPLyhlRJrtCEDNF3gaj1j73Yhb8Z4rw16lxKr6nniwHdnC6KR7Lz+0aVZvgc
         atZA==
X-Gm-Message-State: AHQUAubLszkIYsRe51MmMMDgYbOjUUqntLE6dQEajXvTgsEVO9SlI/C0
        26K3eOGnaoz8QYRnQhss4ULIKRJB
X-Google-Smtp-Source: AHgI3IYE0ph6+yU4FsTeDdVa1a7XYWx+zRob9uCrk2rCmai9qeWIAJrl+0JR1zBckejBNv7fgIqetQ==
X-Received: by 2002:a17:902:8203:: with SMTP id x3mr6743168pln.159.1550880058763;
        Fri, 22 Feb 2019 16:00:58 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id z12sm3327872pgv.0.2019.02.22.16.00.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Feb 2019 16:00:57 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        linux-kernel@vger.kernel.org (open list),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE),
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next 8/8] net: Remove switchdev_ops
Date:   Fri, 22 Feb 2019 15:59:26 -0800
Message-Id: <20190222235927.10295-9-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190222235927.10295-1-f.fainelli@gmail.com>
References: <20190222235927.10295-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have converted all possible callers to using a switchdev
notifier for attributes we do not have a need for implementing
switchdev_ops anymore, and this can be removed from all drivers the
net_device structure.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../net/ethernet/mellanox/mlxsw/spectrum.c    | 12 -----------
 .../net/ethernet/mellanox/mlxsw/spectrum.h    |  2 --
 .../mellanox/mlxsw/spectrum_switchdev.c       | 12 -----------
 drivers/net/ethernet/mscc/ocelot.c            |  5 -----
 drivers/net/ethernet/rocker/rocker_main.c     |  5 -----
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c       |  5 -----
 include/linux/netdevice.h                     |  3 ---
 include/net/switchdev.h                       | 21 -------------------
 net/dsa/slave.c                               |  5 -----
 9 files changed, 70 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
index f018b0607dac..5d998517653a 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -3215,7 +3215,6 @@ static int mlxsw_sp_port_create(struct mlxsw_sp *mlxsw_sp, u8 local_port,
 	}
 	mlxsw_sp_port->default_vlan = mlxsw_sp_port_vlan;
 
-	mlxsw_sp_port_switchdev_init(mlxsw_sp_port);
 	mlxsw_sp->ports[local_port] = mlxsw_sp_port;
 	err = register_netdev(dev);
 	if (err) {
@@ -3232,7 +3231,6 @@ static int mlxsw_sp_port_create(struct mlxsw_sp *mlxsw_sp, u8 local_port,
 
 err_register_netdev:
 	mlxsw_sp->ports[local_port] = NULL;
-	mlxsw_sp_port_switchdev_fini(mlxsw_sp_port);
 	mlxsw_sp_port_vlan_destroy(mlxsw_sp_port_vlan);
 err_port_vlan_create:
 err_port_pvid_set:
@@ -3275,7 +3273,6 @@ static void mlxsw_sp_port_remove(struct mlxsw_sp *mlxsw_sp, u8 local_port)
 	mlxsw_core_port_clear(mlxsw_sp->core, local_port, mlxsw_sp);
 	unregister_netdev(mlxsw_sp_port->dev); /* This calls ndo_stop */
 	mlxsw_sp->ports[local_port] = NULL;
-	mlxsw_sp_port_switchdev_fini(mlxsw_sp_port);
 	mlxsw_sp_port_vlan_flush(mlxsw_sp_port, true);
 	mlxsw_sp_port_nve_fini(mlxsw_sp_port);
 	mlxsw_sp_tc_qdisc_fini(mlxsw_sp_port);
@@ -3996,12 +3993,6 @@ static int mlxsw_sp_init(struct mlxsw_core *mlxsw_core,
 		goto err_span_init;
 	}
 
-	err = mlxsw_sp_switchdev_init(mlxsw_sp);
-	if (err) {
-		dev_err(mlxsw_sp->bus_info->dev, "Failed to initialize switchdev\n");
-		goto err_switchdev_init;
-	}
-
 	err = mlxsw_sp_counter_pool_init(mlxsw_sp);
 	if (err) {
 		dev_err(mlxsw_sp->bus_info->dev, "Failed to init counter pool\n");
@@ -4072,8 +4063,6 @@ static int mlxsw_sp_init(struct mlxsw_core *mlxsw_core,
 err_afa_init:
 	mlxsw_sp_counter_pool_fini(mlxsw_sp);
 err_counter_pool_init:
-	mlxsw_sp_switchdev_fini(mlxsw_sp);
-err_switchdev_init:
 	mlxsw_sp_span_fini(mlxsw_sp);
 err_span_init:
 	mlxsw_sp_lag_fini(mlxsw_sp);
@@ -4138,7 +4127,6 @@ static void mlxsw_sp_fini(struct mlxsw_core *mlxsw_core)
 	mlxsw_sp_nve_fini(mlxsw_sp);
 	mlxsw_sp_afa_fini(mlxsw_sp);
 	mlxsw_sp_counter_pool_fini(mlxsw_sp);
-	mlxsw_sp_switchdev_fini(mlxsw_sp);
 	mlxsw_sp_span_fini(mlxsw_sp);
 	mlxsw_sp_lag_fini(mlxsw_sp);
 	mlxsw_sp_buffers_fini(mlxsw_sp);
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
index 8bb83d0facc2..b1342fe9ca48 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.h
@@ -381,8 +381,6 @@ extern const struct mlxsw_sp_sb_vals mlxsw_sp2_sb_vals;
 /* spectrum_switchdev.c */
 int mlxsw_sp_switchdev_init(struct mlxsw_sp *mlxsw_sp);
 void mlxsw_sp_switchdev_fini(struct mlxsw_sp *mlxsw_sp);
-void mlxsw_sp_port_switchdev_init(struct mlxsw_sp_port *mlxsw_sp_port);
-void mlxsw_sp_port_switchdev_fini(struct mlxsw_sp_port *mlxsw_sp_port);
 int mlxsw_sp_rif_fdb_op(struct mlxsw_sp *mlxsw_sp, const char *mac, u16 fid,
 			bool adding);
 void
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index c1aedfea3a31..f6ce386c3036 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -1938,10 +1938,6 @@ static struct mlxsw_sp_port *mlxsw_sp_lag_rep_port(struct mlxsw_sp *mlxsw_sp,
 	return NULL;
 }
 
-static const struct switchdev_ops mlxsw_sp_port_switchdev_ops = {
-	.switchdev_port_attr_set	= mlxsw_sp_port_attr_set,
-};
-
 static int
 mlxsw_sp_bridge_8021q_port_join(struct mlxsw_sp_bridge_device *bridge_device,
 				struct mlxsw_sp_bridge_port *bridge_port,
@@ -3545,11 +3541,3 @@ void mlxsw_sp_switchdev_fini(struct mlxsw_sp *mlxsw_sp)
 	kfree(mlxsw_sp->bridge);
 }
 
-void mlxsw_sp_port_switchdev_init(struct mlxsw_sp_port *mlxsw_sp_port)
-{
-	mlxsw_sp_port->dev->switchdev_ops = &mlxsw_sp_port_switchdev_ops;
-}
-
-void mlxsw_sp_port_switchdev_fini(struct mlxsw_sp_port *mlxsw_sp_port)
-{
-}
diff --git a/drivers/net/ethernet/mscc/ocelot.c b/drivers/net/ethernet/mscc/ocelot.c
index 83a678b11757..a1d0d6e42533 100644
--- a/drivers/net/ethernet/mscc/ocelot.c
+++ b/drivers/net/ethernet/mscc/ocelot.c
@@ -1324,10 +1324,6 @@ static int ocelot_port_obj_del(struct net_device *dev,
 	return ret;
 }
 
-static const struct switchdev_ops ocelot_port_switchdev_ops = {
-	.switchdev_port_attr_set	= ocelot_port_attr_set,
-};
-
 static int ocelot_port_bridge_join(struct ocelot_port *ocelot_port,
 				   struct net_device *bridge)
 {
@@ -1660,7 +1656,6 @@ int ocelot_probe_port(struct ocelot *ocelot, u8 port,
 
 	dev->netdev_ops = &ocelot_port_netdev_ops;
 	dev->ethtool_ops = &ocelot_ethtool_ops;
-	dev->switchdev_ops = &ocelot_port_switchdev_ops;
 
 	dev->hw_features |= NETIF_F_HW_VLAN_CTAG_FILTER | NETIF_F_RXFCS;
 	dev->features |= NETIF_F_HW_VLAN_CTAG_FILTER;
diff --git a/drivers/net/ethernet/rocker/rocker_main.c b/drivers/net/ethernet/rocker/rocker_main.c
index fc772cf079cc..c883aa89b7ca 100644
--- a/drivers/net/ethernet/rocker/rocker_main.c
+++ b/drivers/net/ethernet/rocker/rocker_main.c
@@ -2142,10 +2142,6 @@ static int rocker_port_obj_del(struct net_device *dev,
 	return err;
 }
 
-static const struct switchdev_ops rocker_port_switchdev_ops = {
-	.switchdev_port_attr_set	= rocker_port_attr_set,
-};
-
 struct rocker_fib_event_work {
 	struct work_struct work;
 	union {
@@ -2599,7 +2595,6 @@ static int rocker_probe_port(struct rocker *rocker, unsigned int port_number)
 	rocker_port_dev_addr_init(rocker_port);
 	dev->netdev_ops = &rocker_port_netdev_ops;
 	dev->ethtool_ops = &rocker_port_ethtool_ops;
-	dev->switchdev_ops = &rocker_port_switchdev_ops;
 	netif_tx_napi_add(dev, &rocker_port->napi_tx, rocker_port_poll_tx,
 			  NAPI_POLL_WEIGHT);
 	netif_napi_add(dev, &rocker_port->napi_rx, rocker_port_poll_rx,
diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index 73efc2a5fd91..ef7ec02da2fa 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -925,10 +925,6 @@ static int swdev_port_obj_del(struct net_device *netdev,
 	return err;
 }
 
-static const struct switchdev_ops ethsw_port_switchdev_ops = {
-	.switchdev_port_attr_set	= swdev_port_attr_set,
-};
-
 /* For the moment, only flood setting needs to be updated */
 static int port_bridge_join(struct net_device *netdev,
 			    struct net_device *upper_dev)
@@ -1455,7 +1451,6 @@ static int ethsw_probe_port(struct ethsw_core *ethsw, u16 port_idx)
 	SET_NETDEV_DEV(port_netdev, dev);
 	port_netdev->netdev_ops = &ethsw_port_ops;
 	port_netdev->ethtool_ops = &ethsw_port_ethtool_ops;
-	port_netdev->switchdev_ops = &ethsw_port_switchdev_ops;
 
 	/* Set MTU limits */
 	port_netdev->min_mtu = ETH_MIN_MTU;
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index aab4d9f6613d..a3c60ba35046 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1835,9 +1835,6 @@ struct net_device {
 #endif
 	const struct net_device_ops *netdev_ops;
 	const struct ethtool_ops *ethtool_ops;
-#ifdef CONFIG_NET_SWITCHDEV
-	const struct switchdev_ops *switchdev_ops;
-#endif
 #ifdef CONFIG_NET_L3_MASTER_DEV
 	const struct l3mdev_ops	*l3mdev_ops;
 #endif
diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index ca56b7487540..e4f751e19ecf 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -112,21 +112,6 @@ void *switchdev_trans_item_dequeue(struct switchdev_trans *trans);
 
 typedef int switchdev_obj_dump_cb_t(struct switchdev_obj *obj);
 
-/**
- * struct switchdev_ops - switchdev operations
- *
- * @switchdev_port_attr_get: Get a port attribute (see switchdev_attr).
- *
- * @switchdev_port_attr_set: Set a port attribute (see switchdev_attr).
- */
-struct switchdev_ops {
-	int	(*switchdev_port_attr_get)(struct net_device *dev,
-					   struct switchdev_attr *attr);
-	int	(*switchdev_port_attr_set)(struct net_device *dev,
-					   const struct switchdev_attr *attr,
-					   struct switchdev_trans *trans);
-};
-
 enum switchdev_notifier_type {
 	SWITCHDEV_FDB_ADD_TO_BRIDGE = 1,
 	SWITCHDEV_FDB_DEL_TO_BRIDGE,
@@ -230,9 +215,6 @@ int switchdev_handle_port_attr_set(struct net_device *dev,
 			int (*set_cb)(struct net_device *dev,
 				      const struct switchdev_attr *attr,
 				      struct switchdev_trans *trans));
-
-#define SWITCHDEV_SET_OPS(netdev, ops) ((netdev)->switchdev_ops = (ops))
-
 #else
 
 static inline void switchdev_deferred_process(void)
@@ -329,9 +311,6 @@ switchdev_handle_port_attr_set(struct net_device *dev,
 {
 	return 0;
 }
-
-#define SWITCHDEV_SET_OPS(netdev, ops) do {} while (0)
-
 #endif
 
 #endif /* _LINUX_SWITCHDEV_H_ */
diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index 49a5b29fe884..49dc87309bd6 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -1050,10 +1050,6 @@ static const struct net_device_ops dsa_slave_netdev_ops = {
 	.ndo_get_port_parent_id	= dsa_slave_get_port_parent_id,
 };
 
-static const struct switchdev_ops dsa_slave_switchdev_ops = {
-	.switchdev_port_attr_set	= dsa_slave_port_attr_set,
-};
-
 static struct device_type dsa_type = {
 	.name	= "dsa",
 };
@@ -1313,7 +1309,6 @@ int dsa_slave_create(struct dsa_port *port)
 	eth_hw_addr_inherit(slave_dev, master);
 	slave_dev->priv_flags |= IFF_NO_QUEUE;
 	slave_dev->netdev_ops = &dsa_slave_netdev_ops;
-	slave_dev->switchdev_ops = &dsa_slave_switchdev_ops;
 	slave_dev->min_mtu = 0;
 	slave_dev->max_mtu = ETH_MAX_MTU;
 	SET_NETDEV_DEVTYPE(slave_dev, &dsa_type);
-- 
2.17.1

