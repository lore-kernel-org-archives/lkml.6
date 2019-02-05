Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C2FC282CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 017232054F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+uSEB/r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730566AbfBEWNy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 17:13:54 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34146 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726804AbfBEWNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 17:13:43 -0500
Received: by mail-ed1-f66.google.com with SMTP id b3so4316037ede.1;
        Tue, 05 Feb 2019 14:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RNI+XdPhvdY1OjXcP7pgSSgHAFM8lKWzobqUPPNGsDM=;
        b=H+uSEB/rx6+7R4gnI61U9o89emgVY2NRCiyH96t3UCmBHnzJ1FqCmHoz6ZuokUFdZC
         RElPLEyyK3U9E+1W/ZpxTM3lTekP+/7VXUNGE0iaJzlo2LCu2FpklvCcINpcKmZuBY+n
         SqYYkBuLOl3LhnYKJverVQLcoP0+N+jJVh7S9XB/6A2qdiV1UYz2FOZmGI6+dTTyUvx0
         gOWLgiocvwsNp12TDagEgialOkvjzIXECgzUGPmxmWv/piXPvcCH1Tw5Cv740p/tsOXM
         JDpKCnWwMTpDXCmfWyJPY3ZnCpEJq4MyzgB38Zmvmjsi7bZ1TfzRZdlYr7gKGH8522pN
         e9xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RNI+XdPhvdY1OjXcP7pgSSgHAFM8lKWzobqUPPNGsDM=;
        b=ZbccYnircO+Gew2JfuoRRCVzNQNcV22Slt5WiULtBf2hH0l/1O5fcHlVyMN7Y7SjhT
         1yxrXF9UZQg9NPcfhoZdVZWglTY/wCgTNQg6nEMKvrAA4xN1WxeJrzY2w8IYy6Md9ZL2
         08+ZSB8m4/fjOOewwBF8oOCp5L5dstouos+vgNhrUGWops32WLlDskde1guQeDBE3shh
         pzPedOZsOPHrghQ2T21PjMxMEVuBU2xS1TtKSyCxiXwnIiZ9vYFt0Vzc5mw2LQPEoHZB
         hCS+OxkOjYYm0IedFgctCSLleUaDJ5twhBWSlqjVxIRqLw8mbRjrmPCUoFAAiuECNejx
         xDOQ==
X-Gm-Message-State: AHQUAuaBPzSy1VdFpQP0zJBJqyF5n6Maet0Uq/5jrihsVUSoBxKp6nmx
        OEQzd+RDLUnCjRpm2Cw5Ci9kBqyX
X-Google-Smtp-Source: AHgI3IaxpyniTj2kzgpPMkT8hqOemx72VcTF7WfJvPuR1tTqnbZ9qpS6ckyO3X4qqYtY1XHLe4o+KA==
X-Received: by 2002:a17:906:6dd5:: with SMTP id j21mr5111228ejt.13.1549404821902;
        Tue, 05 Feb 2019 14:13:41 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id x47sm5523299eda.91.2019.02.05.14.13.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 14:13:41 -0800 (PST)
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
Subject: [PATCH net-next v2 06/12] mscc: ocelot: Implement ndo_get_port_parent_id()
Date:   Tue,  5 Feb 2019 14:13:05 -0800
Message-Id: <20190205221311.18476-7-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190205221311.18476-1-f.fainelli@gmail.com>
References: <20190205221311.18476-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ocelot only supports SWITCHDEV_ATTR_ID_PORT_PARENT_ID as a valid
switchdev attribute getter, convert it to use ndo_get_port_parent_id()
and get rid of the switchdev_ops::switchdev_port_attr_get altogether.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/mscc/ocelot.c | 33 ++++++++++++------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/mscc/ocelot.c b/drivers/net/ethernet/mscc/ocelot.c
index c6a575eb0ff5..195306d05bcd 100644
--- a/drivers/net/ethernet/mscc/ocelot.c
+++ b/drivers/net/ethernet/mscc/ocelot.c
@@ -916,6 +916,18 @@ static int ocelot_set_features(struct net_device *dev,
 	return 0;
 }
 
+static int ocelot_get_port_parent_id(struct net_device *dev,
+				     struct netdev_phys_item_id *ppid)
+{
+	struct ocelot_port *ocelot_port = netdev_priv(dev);
+	struct ocelot *ocelot = ocelot_port->ocelot;
+
+	ppid->id_len = sizeof(ocelot->base_mac);
+	memcpy(&ppid->id, &ocelot->base_mac, ppid->id_len);
+
+	return 0;
+}
+
 static const struct net_device_ops ocelot_port_netdev_ops = {
 	.ndo_open			= ocelot_port_open,
 	.ndo_stop			= ocelot_port_stop,
@@ -930,6 +942,7 @@ static const struct net_device_ops ocelot_port_netdev_ops = {
 	.ndo_vlan_rx_add_vid		= ocelot_vlan_rx_add_vid,
 	.ndo_vlan_rx_kill_vid		= ocelot_vlan_rx_kill_vid,
 	.ndo_set_features		= ocelot_set_features,
+	.ndo_get_port_parent_id		= ocelot_get_port_parent_id,
 };
 
 static void ocelot_get_strings(struct net_device *netdev, u32 sset, u8 *data)
@@ -1013,25 +1026,6 @@ static const struct ethtool_ops ocelot_ethtool_ops = {
 	.set_link_ksettings	= phy_ethtool_set_link_ksettings,
 };
 
-static int ocelot_port_attr_get(struct net_device *dev,
-				struct switchdev_attr *attr)
-{
-	struct ocelot_port *ocelot_port = netdev_priv(dev);
-	struct ocelot *ocelot = ocelot_port->ocelot;
-
-	switch (attr->id) {
-	case SWITCHDEV_ATTR_ID_PORT_PARENT_ID:
-		attr->u.ppid.id_len = sizeof(ocelot->base_mac);
-		memcpy(&attr->u.ppid.id, &ocelot->base_mac,
-		       attr->u.ppid.id_len);
-		break;
-	default:
-		return -EOPNOTSUPP;
-	}
-
-	return 0;
-}
-
 static int ocelot_port_attr_stp_state_set(struct ocelot_port *ocelot_port,
 					  struct switchdev_trans *trans,
 					  u8 state)
@@ -1331,7 +1325,6 @@ static int ocelot_port_obj_del(struct net_device *dev,
 }
 
 static const struct switchdev_ops ocelot_port_switchdev_ops = {
-	.switchdev_port_attr_get	= ocelot_port_attr_get,
 	.switchdev_port_attr_set	= ocelot_port_attr_set,
 };
 
-- 
2.17.1

