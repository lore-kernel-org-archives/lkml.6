Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1419AC169C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D048A21841
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZpcQTdMw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbfBIAdo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 19:33:44 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:40274 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbfBIAdk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 19:33:40 -0500
Received: by mail-pf1-f193.google.com with SMTP id i12so2431990pfo.7;
        Fri, 08 Feb 2019 16:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=prYinq/TbFxbdvZPlemTXRDAe8PcaKduMMjaHMi1Eg4=;
        b=ZpcQTdMwolO8iwUEhV9HLg4+ZkEdvB5mCC1eCKbR0wZ9ORmekGy+uhFC906uQMJjDT
         evo4/4FFAq1E3+i9kEVrO8Ic2p7q8q0WIC09ntX3J4uRHEVZCAqVt7cw+Y1jo354GNPn
         xJA18N1w74QccTVotVGaMFogQ7HQHxd2E3HDgX1ylUirnvaUpSe5ro4+BamJ+Y8MadBo
         vl5Boxionx2SY7SR0odOXmYCVlluN5ZJqPz4zN9yMFRrx7h/T/cgPTbTxYax0vt4EMpH
         G/N0CElkxVHmp2Z3KKG/dgk0xxDWiCi2eiR07WQgqjLZqZX85wxX0U373jriWbWJX34s
         6fXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=prYinq/TbFxbdvZPlemTXRDAe8PcaKduMMjaHMi1Eg4=;
        b=EI2ezNKZXHINHm5CcCC198Fs60Ly+ZvZxaXzzugsCkYBAHGWI2dvAwH5DSVGNnZUhE
         M5WWS2k7JegHyCAP+X//orZgueDCIwGqsF9pm6NIfpliFxWfohPgNGhjfUgsZktercGd
         pL7JmCe+xU2pE6/Ic/pO8X2u9B1pHF3PNpIdHIfW8wLrKQgq7jjt10R7tZXSdMqIFlN+
         GjDrj1rufiA0jBgKWStLWnSL58/Grap/m0dElakGGQfm7+GPVdfspQzHxKRVjdpFYweQ
         Ox8iRQ8Q5oms1bw8Y2U4Dj39eevkz2te2FDEAmRjHGMulJsBndHVEh3qvz081h/i68KA
         LW1Q==
X-Gm-Message-State: AHQUAuYuWvM4+R42Bt5W+J9vuj9lsKJZjAGzy4VbWm3M9Ur5vm40YhzR
        WV1ckMCYzVSGyC69NFJtgtQef506
X-Google-Smtp-Source: AHgI3IYBf/XLCVoXiNvoj/36NtaPERuN+htg4a3Af+kxd0FyZYEX7WbksZ05h/cZbRS6kugWoJBERg==
X-Received: by 2002:a63:6bc1:: with SMTP id g184mr8023565pgc.25.1549672418550;
        Fri, 08 Feb 2019 16:33:38 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id i71sm372491pfi.170.2019.02.08.16.33.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 16:33:37 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        linux-kernel@vger.kernel.org (open list),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE),
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next 07/16] net: Remove SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT
Date:   Fri,  8 Feb 2019 16:32:39 -0800
Message-Id: <20190209003248.31088-8-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190209003248.31088-1-f.fainelli@gmail.com>
References: <20190209003248.31088-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have converted the bridge code and the drivers to check for
bridge port(s) flags at the time we try to set them, there is no need
for a get() -> set() sequence anymore and
SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT therefore becomes unused.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../net/ethernet/mellanox/mlxsw/spectrum_switchdev.c   |  4 ----
 drivers/net/ethernet/rocker/rocker_main.c              |  4 ----
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c                |  3 ---
 include/net/switchdev.h                                |  2 --
 net/dsa/slave.c                                        | 10 +---------
 5 files changed, 1 insertion(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index 468a6d513074..8242a373f6e7 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -455,10 +455,6 @@ static int mlxsw_sp_port_attr_get(struct net_device *dev,
 		mlxsw_sp_port_bridge_flags_get(mlxsw_sp->bridge, attr->orig_dev,
 					       &attr->u.brport_flags);
 		break;
-	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT:
-		attr->u.brport_flags_support = BR_LEARNING | BR_FLOOD |
-					       BR_MCAST_FLOOD;
-		break;
 	default:
 		return -EOPNOTSUPP;
 	}
diff --git a/drivers/net/ethernet/rocker/rocker_main.c b/drivers/net/ethernet/rocker/rocker_main.c
index 8657313b6f30..375c4c908bea 100644
--- a/drivers/net/ethernet/rocker/rocker_main.c
+++ b/drivers/net/ethernet/rocker/rocker_main.c
@@ -2075,10 +2075,6 @@ static int rocker_port_attr_get(struct net_device *dev,
 		err = rocker_world_port_attr_bridge_flags_get(rocker_port,
 							      &attr->u.brport_flags);
 		break;
-	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT:
-		err = rocker_world_port_attr_bridge_flags_support_get(rocker_port,
-								      &attr->u.brport_flags_support);
-		break;
 	default:
 		return -EOPNOTSUPP;
 	}
diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index 6228c4375835..79635d1091df 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -651,9 +651,6 @@ static int swdev_port_attr_get(struct net_device *netdev,
 			(port_priv->ethsw_data->learning ? BR_LEARNING : 0) |
 			(port_priv->flood ? BR_FLOOD : 0);
 		break;
-	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT:
-		attr->u.brport_flags_support = BR_LEARNING | BR_FLOOD;
-		break;
 	default:
 		return -EOPNOTSUPP;
 	}
diff --git a/include/net/switchdev.h b/include/net/switchdev.h
index 5e87b54c5dc5..e2083824e577 100644
--- a/include/net/switchdev.h
+++ b/include/net/switchdev.h
@@ -45,7 +45,6 @@ enum switchdev_attr_id {
 	SWITCHDEV_ATTR_ID_UNDEFINED,
 	SWITCHDEV_ATTR_ID_PORT_STP_STATE,
 	SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS,
-	SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT,
 	SWITCHDEV_ATTR_ID_PORT_MROUTER,
 	SWITCHDEV_ATTR_ID_BRIDGE_AGEING_TIME,
 	SWITCHDEV_ATTR_ID_BRIDGE_VLAN_FILTERING,
@@ -62,7 +61,6 @@ struct switchdev_attr {
 	union {
 		u8 stp_state;				/* PORT_STP_STATE */
 		unsigned long brport_flags;		/* PORT_BRIDGE_FLAGS */
-		unsigned long brport_flags_support;	/* PORT_BRIDGE_FLAGS_SUPPORT */
 		bool mrouter;				/* PORT_MROUTER */
 		clock_t ageing_time;			/* BRIDGE_AGEING_TIME */
 		bool vlan_filtering;			/* BRIDGE_VLAN_FILTERING */
diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index 212fc1cc27fc..5797da954e77 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -382,15 +382,7 @@ static int dsa_slave_get_port_parent_id(struct net_device *dev,
 static int dsa_slave_port_attr_get(struct net_device *dev,
 				   struct switchdev_attr *attr)
 {
-	switch (attr->id) {
-	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT:
-		attr->u.brport_flags_support = 0;
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

