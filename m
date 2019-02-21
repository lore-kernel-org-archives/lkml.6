Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE96C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 00:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63FF82146E
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 00:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYUtFonq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727307AbfBUA7I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 19:59:08 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:47055 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfBUA7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 19:59:06 -0500
Received: by mail-pl1-f196.google.com with SMTP id o6so13183367pls.13;
        Wed, 20 Feb 2019 16:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=W+nJHmG+9hiq4brdQCqTxoE3ycs0fIkJUj7NUG7o0HU=;
        b=QYUtFonqywo7KcH1v56MiPBz5tAqAbpz56KEAOlkecwpIRjPKyNOuTetF3YMntXmie
         AzPA8nJRCIpMlaI9O1QPbvM4uF5MuWuyKWQ9jgvNuQvEM6StyeHMyHKdjlDQwgwRsFri
         I/XQhcZjI/pxJVOSgQSl5tVnTDTv2VklVKPa9z4WfIOnv8Smr2Q1ZQixt8gbUBb/gzuP
         HCoW+PqaZ95MELa03CHE8TTnGt4EAsDzKMMNkKKTa6V8uSekGZV7iH8kJeeAv2jN8FkS
         2xsRd3lkZi0udBRKzrSSUov8RTgPT3OhKkIWKiU8vcd/S4BnxNSrJKHOaOTpunqY4yrx
         AhXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=W+nJHmG+9hiq4brdQCqTxoE3ycs0fIkJUj7NUG7o0HU=;
        b=dXnmTBDwuC1JweYKtZosK8T1U5oNRwi8y2/E1NKhoEgEfWiaXo9DAp8IgbESU7lPfk
         3e1NoRg6rUtpRDYwldKdgxhw11ZT+94RbfUe0CryCCni6ClA2C9PueGS/ZL2JGvyiCwW
         HAj3Id9A2enSQADTk2V2+ueFhvvrMr3xz/7rfCeEDqckZfIwenzXsMKwSlu73kPwvmOn
         bfS6KXDmANevWRjtY+HaRzRhZk5fzKrP/bJlgsNp72iJ2jjB1BjmcvPMKtstsSxZU/OA
         GRFpy9++6HoDPJE6NVMbb2lyU2I+C1+cCzo9K+fFBoj9NIFeeEudI0npzmbB4DBBSNfw
         wDCg==
X-Gm-Message-State: AHQUAuY+P4IBL9eNAeRovW52pllpMsspI1dmpHflz3dWsphzMVnsC4uf
        qZIfCwcLClCY/MNAgaWMkuZy4OFi
X-Google-Smtp-Source: AHgI3IbhQAs1yHc2OiM85xTfH9F8q9teP47XmIUiUpvU2ybyksBXK9xG2nfWJNcOCvHkZ7qzxbrPkg==
X-Received: by 2002:a17:902:5c6:: with SMTP id f64mr32970338plf.213.1550710745143;
        Wed, 20 Feb 2019 16:59:05 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id z15sm17203255pgc.25.2019.02.20.16.59.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 16:59:04 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        linux-kernel@vger.kernel.org (open list),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE),
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next v3 7/8] net: Remove SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT
Date:   Wed, 20 Feb 2019 16:58:25 -0800
Message-Id: <20190221005826.26317-8-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190221005826.26317-1-f.fainelli@gmail.com>
References: <20190221005826.26317-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have converted the bridge code and the drivers to check for
bridge port(s) flags at the time we try to set them, there is no need
for a get() -> set() sequence anymore and
SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT therefore becomes unused.

Reviewed-by: Ido Schimmel <idosch@mellanox.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 Documentation/networking/switchdev.txt           |  6 ++----
 .../ethernet/mellanox/mlxsw/spectrum_switchdev.c | 11 +----------
 drivers/net/ethernet/rocker/rocker_main.c        | 14 +-------------
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c          | 10 +---------
 include/net/switchdev.h                          |  2 --
 net/dsa/slave.c                                  | 16 +---------------
 6 files changed, 6 insertions(+), 53 deletions(-)

diff --git a/Documentation/networking/switchdev.txt b/Documentation/networking/switchdev.txt
index f3244d87512a..79c8b0f16aee 100644
--- a/Documentation/networking/switchdev.txt
+++ b/Documentation/networking/switchdev.txt
@@ -232,10 +232,8 @@ Learning_sync attribute enables syncing of the learned/forgotten FDB entry to
 the bridge's FDB.  It's possible, but not optimal, to enable learning on the
 device port and on the bridge port, and disable learning_sync.
 
-To support learning and learning_sync port attributes, the driver implements
-switchdev op switchdev_port_attr_get/set for
-SWITCHDEV_ATTR_PORT_ID_BRIDGE_FLAGS. The driver should initialize the attributes
-to the hardware defaults.
+To support learning, the driver implements switchdev op
+switchdev_port_attr_get/set for SWITCHDEV_ATTR_PORT_ID_BRIDGE_FLAGS.
 
 FDB Ageing
 ^^^^^^^^^^
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index 9a8798f74d2b..bbb5a406232e 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -434,16 +434,7 @@ static void mlxsw_sp_bridge_vlan_put(struct mlxsw_sp_bridge_vlan *bridge_vlan)
 static int mlxsw_sp_port_attr_get(struct net_device *dev,
 				  struct switchdev_attr *attr)
 {
-	switch (attr->id) {
-	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT:
-		attr->u.brport_flags_support = BR_LEARNING | BR_FLOOD |
-					       BR_MCAST_FLOOD;
-		break;
-	default:
-		return -EOPNOTSUPP;
-	}
-
-	return 0;
+	return -EOPNOTSUPP;
 }
 
 static int
diff --git a/drivers/net/ethernet/rocker/rocker_main.c b/drivers/net/ethernet/rocker/rocker_main.c
index 25129f7b5583..6b8273e2057d 100644
--- a/drivers/net/ethernet/rocker/rocker_main.c
+++ b/drivers/net/ethernet/rocker/rocker_main.c
@@ -2069,19 +2069,7 @@ static const struct net_device_ops rocker_port_netdev_ops = {
 static int rocker_port_attr_get(struct net_device *dev,
 				struct switchdev_attr *attr)
 {
-	const struct rocker_port *rocker_port = netdev_priv(dev);
-	int err = 0;
-
-	switch (attr->id) {
-	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT:
-		err = rocker_world_port_attr_bridge_flags_support_get(rocker_port,
-								      &attr->u.brport_flags_support);
-		break;
-	default:
-		return -EOPNOTSUPP;
-	}
-
-	return err;
+	return -EOPNOTSUPP;
 }
 
 static int rocker_port_attr_set(struct net_device *dev,
diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index 331625137717..de4dcabbc29a 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -643,15 +643,7 @@ static void ethsw_teardown_irqs(struct fsl_mc_device *sw_dev)
 static int swdev_port_attr_get(struct net_device *netdev,
 			       struct switchdev_attr *attr)
 {
-	switch (attr->id) {
-	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT:
-		attr->u.brport_flags_support = BR_LEARNING | BR_FLOOD;
-		break;
-	default:
-		return -EOPNOTSUPP;
-	}
-
-	return 0;
+	return -EOPNOTSUPP;
 }
 
 static int port_attr_stp_state_set(struct net_device *netdev,
diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index de72b0a3867f..0f352019ef99 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -45,7 +45,6 @@ enum switchdev_attr_id {
 	SWITCHDEV_ATTR_ID_UNDEFINED,
 	SWITCHDEV_ATTR_ID_PORT_STP_STATE,
 	SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS,
-	SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT,
 	SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS,
 	SWITCHDEV_ATTR_ID_PORT_MROUTER,
 	SWITCHDEV_ATTR_ID_BRIDGE_AGEING_TIME,
@@ -63,7 +62,6 @@ struct switchdev_attr {
 	union {
 		u8 stp_state;				/* PORT_STP_STATE */
 		unsigned long brport_flags;		/* PORT_{PRE}_BRIDGE_FLAGS */
-		unsigned long brport_flags_support;	/* PORT_BRIDGE_FLAGS_SUPPORT */
 		bool mrouter;				/* PORT_MROUTER */
 		clock_t ageing_time;			/* BRIDGE_AGEING_TIME */
 		bool vlan_filtering;			/* BRIDGE_VLAN_FILTERING */
diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index 44cc4e50dd5a..db0a2651070f 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -388,21 +388,7 @@ static int dsa_slave_get_port_parent_id(struct net_device *dev,
 static int dsa_slave_port_attr_get(struct net_device *dev,
 				   struct switchdev_attr *attr)
 {
-	struct dsa_port *dp = dsa_slave_to_port(dev);
-	struct dsa_switch *ds = dp->ds;
-
-	switch (attr->id) {
-	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT:
-		attr->u.brport_flags_support = 0;
-		if (ds->ops->port_egress_floods)
-			attr->u.brport_flags_support |= BR_FLOOD |
-							BR_MCAST_FLOOD;
-		break;
-	default:
-		return -EOPNOTSUPP;
-	}
-
-	return 0;
+	return -EOPNOTSUPP;
 }
 
 static inline netdev_tx_t dsa_slave_netpoll_send_skb(struct net_device *dev,
-- 
2.17.1

