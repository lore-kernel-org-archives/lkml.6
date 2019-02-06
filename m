Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C886C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A2612073D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JUK7Xrzu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730824AbfBFRrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 12:47:05 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40875 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730619AbfBFRqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 12:46:18 -0500
Received: by mail-pl1-f193.google.com with SMTP id u18so3413100plq.7;
        Wed, 06 Feb 2019 09:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=unVY6jzXSwf6Z3BXuXwH1dAfhkC5gzzltRG8BJVomGo=;
        b=JUK7XrzuUcBq0D1LE7KfCL/jHkJVKOJn0MZvWp4rhf8JcrcbxJKHESlhKww02n5s4c
         fBfmuZwbNaS55nLzVfxEQ0o2cRbZkL/9ijQrrur455hXjDXVYjQCWPTgdjNhM1dEvr/5
         n8XREN7oypSZDqD6a07lDt0rcPSfKpXtNm9NT44vC5uc8tELulpgRJLC1cJz0v8aD2Pi
         9ENtn3f790UbcX1vxKB9KkKl2w4asYlqJtBERt3pWC7TU9WQkGWtVozohV87+nkgCf8X
         XS15xWbCg92WNdVo2u54E57V+SGvNdPGz4DWPl4amOpWZ7mszcJAE5lz3eerODKD6pEt
         vhLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=unVY6jzXSwf6Z3BXuXwH1dAfhkC5gzzltRG8BJVomGo=;
        b=bezTgliAXnPiZmeGf4mLNywa1kSzUa8cftyNnjuf9o713dBYOFQXrYJ/ECFaTTtf7+
         rME/NJeTPZ13hpXlnajL56xJl+fzozd6wGUc7sPVrsvnQpjoR1pbcAyyaXnPYzHROsGJ
         j6JlG/uD0YP/nXi6dtkw7pCN08jyOVsZvYpSitMxX9ExtHlz+R5s3ZCdVk2uk1EN3oQK
         bInTTlb3DuSein5GWEDNzcqwHXExq/S878F6ggS5HS3r9uVxoyShoel5plVkfJN7isTC
         s2vqfr1s+zobw9Gmw6ELJ3UcQnOZm7pPZ8sMrij7EQXlxGiSlxBqNpeUBtBfwBtqkX46
         5aVQ==
X-Gm-Message-State: AHQUAuZ6g5SGUUAXmXivPBuLJkDD3YssZOO24q+cPQAoB4h172lbSrsW
        U4gnwbSw4RwoXBWb3UqiBwCMA0CG
X-Google-Smtp-Source: AHgI3IZEqnr+VqB6BUoodBAOcFStZBE8DuO4OTSMItuppYiTAXoA0aIhs1T659nskY1SnWZM/KhkHw==
X-Received: by 2002:a17:902:1101:: with SMTP id d1mr11816746pla.136.1549475177546;
        Wed, 06 Feb 2019 09:46:17 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id 15sm10435313pfr.55.2019.02.06.09.46.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 09:46:16 -0800 (PST)
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
Subject: [PATCH net-next v4 08/12] rocker: Implement ndo_get_port_parent_id()
Date:   Wed,  6 Feb 2019 09:45:42 -0800
Message-Id: <20190206174546.23597-9-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190206174546.23597-1-f.fainelli@gmail.com>
References: <20190206174546.23597-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mlxsw implements SWITCHDEV_ATTR_ID_PORT_PARENT_ID and we want to get rid
of switchdev_ops eventually, ease that migration by implementing a
ndo_get_port_parent_id() function which returns what
switchdev_port_attr_get() would do.

Acked-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/rocker/rocker_main.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/rocker/rocker_main.c b/drivers/net/ethernet/rocker/rocker_main.c
index 62a205eba9f7..596f44dbfae1 100644
--- a/drivers/net/ethernet/rocker/rocker_main.c
+++ b/drivers/net/ethernet/rocker/rocker_main.c
@@ -2026,6 +2026,18 @@ static void rocker_port_neigh_destroy(struct net_device *dev,
 			    err);
 }
 
+static int rocker_port_get_port_parent_id(struct net_device *dev,
+					  struct netdev_phys_item_id *ppid)
+{
+	const struct rocker_port *rocker_port = netdev_priv(dev);
+	const struct rocker *rocker = rocker_port->rocker;
+
+	ppid->id_len = sizeof(rocker->hw.id);
+	memcpy(&ppid->id, &rocker->hw.id, ppid->id_len);
+
+	return 0;
+}
+
 static const struct net_device_ops rocker_port_netdev_ops = {
 	.ndo_open			= rocker_port_open,
 	.ndo_stop			= rocker_port_stop,
@@ -2035,6 +2047,7 @@ static const struct net_device_ops rocker_port_netdev_ops = {
 	.ndo_get_phys_port_name		= rocker_port_get_phys_port_name,
 	.ndo_change_proto_down		= rocker_port_change_proto_down,
 	.ndo_neigh_destroy		= rocker_port_neigh_destroy,
+	.ndo_get_port_parent_id		= rocker_port_get_port_parent_id,
 };
 
 /********************
@@ -2049,10 +2062,6 @@ static int rocker_port_attr_get(struct net_device *dev,
 	int err = 0;
 
 	switch (attr->id) {
-	case SWITCHDEV_ATTR_ID_PORT_PARENT_ID:
-		attr->u.ppid.id_len = sizeof(rocker->hw.id);
-		memcpy(&attr->u.ppid.id, &rocker->hw.id, attr->u.ppid.id_len);
-		break;
 	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS:
 		err = rocker_world_port_attr_bridge_flags_get(rocker_port,
 							      &attr->u.brport_flags);
-- 
2.17.1

