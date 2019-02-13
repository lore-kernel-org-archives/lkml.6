Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE15C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CD8F20842
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:07:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mVIcX+aO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404021AbfBMWH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 17:07:27 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42743 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729139AbfBMWHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 17:07:25 -0500
Received: by mail-pl1-f193.google.com with SMTP id s1so1861190plp.9;
        Wed, 13 Feb 2019 14:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qZ+w6NypwLrquHGLlezSrUoHQgjHNXwdwbbQGveSU5M=;
        b=mVIcX+aOP2dXPVez3n/ZZW6k16rZKOaqvLt7Rpzw1XjvbENUrmfMgfxEciVgSTuJ2M
         6RkbLtichTY8i4nT8P1FR0oMCwoW+8bpBc2ms+ieIwIhqBJ+BNYU2Y9qMJaHb9JOCJJd
         haFfArtACWjVioO+fQRgoJ3pxa3WxkCzOkhvdwCf+yp9Q5tDFlHP0IiVxi7i7VxMEmiS
         4j1iGV4sq4kYvjEF31gUTbWPvZoutFzCYG/gktqDDA6CyEBSEb8PQcqmJKzGL5IYoJhc
         fg+qYJz0n9ORtM901zbN9LMv92A7Vgy13gpN3qNoiYQ1pnx98ETWCC96VBKTLqELtaZ6
         rbSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qZ+w6NypwLrquHGLlezSrUoHQgjHNXwdwbbQGveSU5M=;
        b=kMaD6yisueLpOyMboEvodUc/BDfXC+QrXvgP+9mT6h8Zgv1ssk4MefKYmce5UYSMRR
         2ujud3aklLl5tpkJU1wdeXffkWI3JjqRKLdimIF081CvJYKSDkiXKzywNw3hR3JeXDTS
         2jsxNBYmulHK6ekydw2nJJz+Xelwso8FQhNJg3wwn8foqvIdtheEoCQF7/RYPKoRCiJd
         +zFwD5AsOVt/S3cR96F2/xQF1sPov5Yn0MYgLE2XV77vO6YBhUPjlwVM3XJjiAmJqsFC
         E2/FeNd6HG/3ogkOND5BK0dv9m0kIUUB412TZtAY0t/AL1ihUYU1Ck8zg1E+dQsWv23+
         ob/A==
X-Gm-Message-State: AHQUAuZthVpZV3WSmv5i23pI96f7pJOw0TgelXZowICeeJcS+w4O1m6A
        qTYMuvuAhv1qZ9ILr9JkX0+peKmK
X-Google-Smtp-Source: AHgI3IaX9c/wEpUtruYg7gvYvSSdPLD3GOMkn6F+ws7410uaYL9CyItB1LhtVpCjbYJ2Frr4mXhtcw==
X-Received: by 2002:a17:902:930b:: with SMTP id bc11mr421028plb.101.1550095644467;
        Wed, 13 Feb 2019 14:07:24 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id o1sm383735pgn.63.2019.02.13.14.07.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 14:07:23 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        linux-kernel@vger.kernel.org (open list),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE),
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next 3/9] mlxsw: spectrum: Check bridge flags during prepare phase
Date:   Wed, 13 Feb 2019 14:06:32 -0800
Message-Id: <20190213220638.1552-4-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190213220638.1552-1-f.fainelli@gmail.com>
References: <20190213220638.1552-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for getting rid of switchdev_port_attr_get(), have mlxsw
check for the bridge flags being set through switchdev_port_attr_set()
when the SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS attribute identifier is
used.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../ethernet/mellanox/mlxsw/spectrum_switchdev.c   | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index 1f492b7dbea8..7616eab50035 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -598,13 +598,17 @@ mlxsw_sp_bridge_port_learning_set(struct mlxsw_sp_port *mlxsw_sp_port,
 static int mlxsw_sp_port_attr_br_flags_set(struct mlxsw_sp_port *mlxsw_sp_port,
 					   struct switchdev_trans *trans,
 					   struct net_device *orig_dev,
-					   unsigned long brport_flags)
+					   unsigned long brport_flags,
+					   bool pre_set)
 {
 	struct mlxsw_sp_bridge_port *bridge_port;
 	int err;
 
-	if (switchdev_trans_ph_prepare(trans))
+	if (switchdev_trans_ph_prepare(trans) && pre_set) {
+		if (brport_flags & ~(BR_LEARNING | BR_FLOOD | BR_MCAST_FLOOD))
+			return -EOPNOTSUPP;
 		return 0;
+	}
 
 	bridge_port = mlxsw_sp_bridge_port_find(mlxsw_sp_port->mlxsw_sp->bridge,
 						orig_dev);
@@ -833,6 +837,7 @@ static int mlxsw_sp_port_attr_set(struct net_device *dev,
 				  struct switchdev_trans *trans)
 {
 	struct mlxsw_sp_port *mlxsw_sp_port = netdev_priv(dev);
+	bool pre_set = false;
 	int err;
 
 	switch (attr->id) {
@@ -841,10 +846,13 @@ static int mlxsw_sp_port_attr_set(struct net_device *dev,
 						       attr->orig_dev,
 						       attr->u.stp_state);
 		break;
+	case SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS:
+		pre_set = true;	/* fall through */
 	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS:
 		err = mlxsw_sp_port_attr_br_flags_set(mlxsw_sp_port, trans,
 						      attr->orig_dev,
-						      attr->u.brport_flags);
+						      attr->u.brport_flags,
+						      pre_set);
 		break;
 	case SWITCHDEV_ATTR_ID_BRIDGE_AGEING_TIME:
 		err = mlxsw_sp_port_attr_br_ageing_set(mlxsw_sp_port, trans,
-- 
2.17.1

