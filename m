Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48198C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C015D20842
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VSSFbcja"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395078AbfBMWHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 17:07:55 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43197 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730382AbfBMWHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 17:07:52 -0500
Received: by mail-pl1-f196.google.com with SMTP id f90so1863013plb.10;
        Wed, 13 Feb 2019 14:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=97jL08vpSK7nllW2QUkWLce6ED4PA+azRx4iN+y5Cq8=;
        b=VSSFbcjanh2AZArygX2xQEyxtpKK5NPazkQc/3oq8bJOXCEWbLVfTpPfqPnW/AFI2T
         sscvulK04A7/d/v90HkGjVQm4l8BnBWmGGBey1TEJLWGSOQ3EfDWIFpxRRiegYGH00Qh
         R5Qm5xvzlHc2vkYsvf6PzqoJkBC+gTVEi1gUCKZNvorK6k/4d0p2Wjhz6+v7GZgCHWjO
         XVHN5Pm+NSEhSDZFXFZAJJmoRdW9JbwhXdedMsCM/QNoJt7Qc3FzLBvksScN96XcetgN
         hE4TBj2IfPjxLXFBNMEfb4ZtL7tm6YDiEFDTAm1X71WV9lvDKxQk4b5/A/HklltMHed8
         uANg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=97jL08vpSK7nllW2QUkWLce6ED4PA+azRx4iN+y5Cq8=;
        b=eJDk2AzOHsGVaU6vOe6cmCuGjAdMYkdrpqRJLt2lZNlxCP6l6xPBI+4H3e36jj8vY8
         nHIBIblMK12+q364COlHwVXjfEhEZtUbY02MqEqKM71jONdMxdlmMcrR5AdQj+sjcJUZ
         Vqkcv8HpBwfgqztEs3EI82/RWYlaHLNlxxlId1seFBJA6r2B/2rUhqvlipgcqEkAdHll
         xLDWZCiHTDWFD9xt6EPhaZxjVQeFY3SOchsesV3vRAzoP8M50MLJUxjQ8Q0XfM6KONTI
         S6I7Ubs9UiGutkDqio29MNM+NdX3BXRnLuQRVr6rNAweVk5omR8WyWUMhxKO4fhX83uW
         Xcwg==
X-Gm-Message-State: AHQUAuaDFXCJL1EnSWC8Yq/x2oEC6kzh47CwOfU7IezAIptLRZFhWOiW
        IABZvN3nUOgqEGWOqhpgMPFW7/BU
X-Google-Smtp-Source: AHgI3IYO9IgcbrkSNZP19cYqw1KOEvaHdQ7AT1czGmgWA5L9MiFJiJV4taarw1bfh2ikc/WXVOK4dA==
X-Received: by 2002:a17:902:6b03:: with SMTP id o3mr457756plk.126.1550095671171;
        Wed, 13 Feb 2019 14:07:51 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id o1sm383735pgn.63.2019.02.13.14.07.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 14:07:50 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        linux-kernel@vger.kernel.org (open list),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE),
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next 9/9] net: Get rid of switchdev_port_attr_get()
Date:   Wed, 13 Feb 2019 14:06:38 -0800
Message-Id: <20190213220638.1552-10-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190213220638.1552-1-f.fainelli@gmail.com>
References: <20190213220638.1552-1-f.fainelli@gmail.com>
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
 Documentation/networking/switchdev.txt                   | 5 ++---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c | 7 -------
 drivers/net/ethernet/rocker/rocker_main.c                | 7 -------
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c                  | 7 -------
 include/net/switchdev.h                                  | 8 --------
 net/dsa/slave.c                                          | 7 -------
 6 files changed, 2 insertions(+), 39 deletions(-)

diff --git a/Documentation/networking/switchdev.txt b/Documentation/networking/switchdev.txt
index ea90243340a9..327afe754230 100644
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
index c11cf7fa4863..5263abe6224e 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -431,12 +431,6 @@ static void mlxsw_sp_bridge_vlan_put(struct mlxsw_sp_bridge_vlan *bridge_vlan)
 		mlxsw_sp_bridge_vlan_destroy(bridge_vlan);
 }
 
-static int mlxsw_sp_port_attr_get(struct net_device *dev,
-				  struct switchdev_attr *attr)
-{
-	return -EOPNOTSUPP;
-}
-
 static int
 mlxsw_sp_port_bridge_vlan_stp_set(struct mlxsw_sp_port *mlxsw_sp_port,
 				  struct mlxsw_sp_bridge_vlan *bridge_vlan,
@@ -1937,7 +1931,6 @@ static struct mlxsw_sp_port *mlxsw_sp_lag_rep_port(struct mlxsw_sp *mlxsw_sp,
 }
 
 static const struct switchdev_ops mlxsw_sp_port_switchdev_ops = {
-	.switchdev_port_attr_get	= mlxsw_sp_port_attr_get,
 	.switchdev_port_attr_set	= mlxsw_sp_port_attr_set,
 };
 
diff --git a/drivers/net/ethernet/rocker/rocker_main.c b/drivers/net/ethernet/rocker/rocker_main.c
index 8e80301eae7b..5d06c7edf696 100644
--- a/drivers/net/ethernet/rocker/rocker_main.c
+++ b/drivers/net/ethernet/rocker/rocker_main.c
@@ -2054,12 +2054,6 @@ static const struct net_device_ops rocker_port_netdev_ops = {
  * swdev interface
  ********************/
 
-static int rocker_port_attr_get(struct net_device *dev,
-				struct switchdev_attr *attr)
-{
-	return -EOPNOTSUPP;
-}
-
 static int rocker_port_attr_set(struct net_device *dev,
 				const struct switchdev_attr *attr,
 				struct switchdev_trans *trans)
@@ -2135,7 +2129,6 @@ static int rocker_port_obj_del(struct net_device *dev,
 }
 
 static const struct switchdev_ops rocker_port_switchdev_ops = {
-	.switchdev_port_attr_get	= rocker_port_attr_get,
 	.switchdev_port_attr_set	= rocker_port_attr_set,
 };
 
diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index 5f58c7df67bb..005c12c08df4 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -640,12 +640,6 @@ static void ethsw_teardown_irqs(struct fsl_mc_device *sw_dev)
 	fsl_mc_free_irqs(sw_dev);
 }
 
-static int swdev_port_attr_get(struct net_device *netdev,
-			       struct switchdev_attr *attr)
-{
-	return -EOPNOTSUPP;
-}
-
 static int port_attr_stp_state_set(struct net_device *netdev,
 				   struct switchdev_trans *trans,
 				   u8 state)
@@ -924,7 +918,6 @@ static int swdev_port_obj_del(struct net_device *netdev,
 }
 
 static const struct switchdev_ops ethsw_port_switchdev_ops = {
-	.switchdev_port_attr_get	= swdev_port_attr_get,
 	.switchdev_port_attr_set	= swdev_port_attr_set,
 };
 
diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index 0f352019ef99..45310ddf2d7e 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -179,8 +179,6 @@ switchdev_notifier_info_to_extack(const struct switchdev_notifier_info *info)
 #ifdef CONFIG_NET_SWITCHDEV
 
 void switchdev_deferred_process(void);
-int switchdev_port_attr_get(struct net_device *dev,
-			    struct switchdev_attr *attr);
 int switchdev_port_attr_set(struct net_device *dev,
 			    const struct switchdev_attr *attr);
 int switchdev_port_obj_add(struct net_device *dev,
@@ -225,12 +223,6 @@ static inline void switchdev_deferred_process(void)
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
index a176d3ba3b7a..1258a0b7a158 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -385,12 +385,6 @@ static int dsa_slave_get_port_parent_id(struct net_device *dev,
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
@@ -1057,7 +1051,6 @@ static const struct net_device_ops dsa_slave_netdev_ops = {
 };
 
 static const struct switchdev_ops dsa_slave_switchdev_ops = {
-	.switchdev_port_attr_get	= dsa_slave_port_attr_get,
 	.switchdev_port_attr_set	= dsa_slave_port_attr_set,
 };
 
-- 
2.17.1

