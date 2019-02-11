Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80623C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 21:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D90F214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 21:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hr88RD0a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbfBKVSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 16:18:18 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44686 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbfBKVSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 16:18:17 -0500
Received: by mail-pf1-f195.google.com with SMTP id u6so144833pfh.11;
        Mon, 11 Feb 2019 13:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nsoTPbQ3gK+2NOAMcVz9btjLns72C32iPXrYhr04RyQ=;
        b=Hr88RD0aDxIM3Chruik2+LpEO/3tKHT3RIpY/iXxzczgnpSd02tAI/DqD3WF18LRds
         yHEmv6KvUQd2NxDDskWlbmh2fjDtH1lxG0W1yOUmUA/mYNb54OV7bp3c5nidy6EQRD8u
         BUMmiIde9XeoSsNSDJky1fkvynKV+cMknhWEPNKQ1A8hCssY9yI4/VLL1LoB4cc4N4DB
         cHOphkZXiHRzFN66yZOSfmVBVyDee2Bk3b+GVkA0xyEJI0yDoIhLvKUpYtabtD3FThwJ
         t0KIFcnOe8W3jaVSL2Hxcw3+BrJBRAhh/B+lUdgNGxwQIX69YVIS4Oblw+I2cDvzCwDb
         G44w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nsoTPbQ3gK+2NOAMcVz9btjLns72C32iPXrYhr04RyQ=;
        b=SaL0VdbGmgy/rDMBvVDg0gZ5tMuvPglVF4bVc6a32ltkBsa8SiSpLhLDjBuE9Zyr4O
         rWhFU5Uzpfc9mVMgLKSZeoiH7tFGslg28u4M2WX5e3zsHCpJJP3RE18n1eL3Q1Xize6C
         HyLKx61JoUOUV8TPG+mjvs/vT4mdBwH8fEjz+t0tPyXsyaBnWxxPZhCS37V7gzdNIlLN
         Ktsz/LPz6fJn1Ra5P+low5eUp61pq3bPmA2/k+7W0Jj4erjyyMq7MK/VjvtFuzJZISxE
         pgckhtT77Pxt6qzyFWFCNPr68RDGogCEGRCFRecYZX7Lv9JoSNHHkuvWzic9+MlUhbAB
         iSlw==
X-Gm-Message-State: AHQUAubmCxBPNABNWnc4aBybSgAwZHYAAcqYEtX2wHJFCMbt4IRrcQzm
        z16wzluE2iSlufbZgZxL7836e4tN
X-Google-Smtp-Source: AHgI3Iaoq+IMunTZmw+h+ZX4K3bCOX2OmXxZewgZJFjo9rMx/4X+zSdyiU9O/iFioq2VfFrVcRUTfg==
X-Received: by 2002:a62:68c5:: with SMTP id d188mr295420pfc.194.1549919895744;
        Mon, 11 Feb 2019 13:18:15 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id 24sm15213029pfr.75.2019.02.11.13.18.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 13:18:14 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        linux-kernel@vger.kernel.org (open list),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE),
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next 1/3] mlxsw: spectrum_switchdev: Remove getting PORT_BRIDGE_FLAGS
Date:   Mon, 11 Feb 2019 13:17:47 -0800
Message-Id: <20190211211749.19847-2-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190211211749.19847-1-f.fainelli@gmail.com>
References: <20190211211749.19847-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no code that will query the SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS
attribute remove support for that.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 .../mellanox/mlxsw/spectrum_switchdev.c         | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index 95e37de3e48f..4c5780f8f4b2 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -431,19 +431,6 @@ static void mlxsw_sp_bridge_vlan_put(struct mlxsw_sp_bridge_vlan *bridge_vlan)
 		mlxsw_sp_bridge_vlan_destroy(bridge_vlan);
 }
 
-static void mlxsw_sp_port_bridge_flags_get(struct mlxsw_sp_bridge *bridge,
-					   struct net_device *dev,
-					   unsigned long *brport_flags)
-{
-	struct mlxsw_sp_bridge_port *bridge_port;
-
-	bridge_port = mlxsw_sp_bridge_port_find(bridge, dev);
-	if (WARN_ON(!bridge_port))
-		return;
-
-	memcpy(brport_flags, &bridge_port->flags, sizeof(*brport_flags));
-}
-
 static int mlxsw_sp_port_attr_get(struct net_device *dev,
 				  struct switchdev_attr *attr)
 {
@@ -451,10 +438,6 @@ static int mlxsw_sp_port_attr_get(struct net_device *dev,
 	struct mlxsw_sp *mlxsw_sp = mlxsw_sp_port->mlxsw_sp;
 
 	switch (attr->id) {
-	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS:
-		mlxsw_sp_port_bridge_flags_get(mlxsw_sp->bridge, attr->orig_dev,
-					       &attr->u.brport_flags);
-		break;
 	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT:
 		attr->u.brport_flags_support = BR_LEARNING | BR_FLOOD |
 					       BR_MCAST_FLOOD;
-- 
2.17.1

