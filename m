Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE66FC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7940C222D0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:54:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ShHuGei5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404624AbfBOWx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 17:53:29 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46516 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394130AbfBOWxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 17:53:24 -0500
Received: by mail-pg1-f193.google.com with SMTP id w7so5452172pgp.13;
        Fri, 15 Feb 2019 14:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NK5Nsx4Hxviwe7e67zABRGR+HMqbd3Rniv+pDjc5hfE=;
        b=ShHuGei536BzKpRL+QQ0YUEhre4vFe3Vatvj5ClAjz4aLMZm+wetaMlWn73T159YHI
         Nb/qu152uLlvU5Lb37himDs0YhpnAV+TN/s+v/PDHfDfTmzlUwhLm0fwvZKmZqT+hSHk
         h0tC/O1Q4hslqZBb05HDOyCjlw0DOpzCVoazVhj9f+sGd+pT50bNfGh65rnh02ZZnSyM
         PjtW+bzxeBCtWeE5rMxTwz6YyVJSznQILu66MFwf6nyRpXoipYEhfKPqRDpS2UGjBJuh
         YzmV4V7Fk8aVzMbIvXzrcpNI38cWbtZmgtio0E1s+sVPfhesRW0L6rax9TSN6bSsJVyo
         IHXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NK5Nsx4Hxviwe7e67zABRGR+HMqbd3Rniv+pDjc5hfE=;
        b=TWIcttuaX3OGQNTUhQ4ucXz1WvFl0NfzKipp8pqiKAujuDM69sh4cAvnSQ8q/wHQxl
         30VFxTUBmbZISm7VO/YeimMoJuCA5KKgknVLMIr3+0qJ+Ui5jx3eiiEZ41HT9u8z7Mla
         GFf1+uSPZiIYYm8lvQxQFAm+9wyQUXs44cpqYwmUraN0Wj+F86JuNvCKbvig4gmMpb33
         fvFkbTg1KSFW+RUuu0D4CClH0XXzX3rPTDGOgWK/H7sp2/1G8gX/iHBu+GoUjIwPbe8r
         8Z7D59biXkPkRM5TQb3tzHwnh9fBfASoCq2tg0wep3GbIBY/J/BVENEh0jnNsK0sltx1
         2rWQ==
X-Gm-Message-State: AHQUAuYxB0I2/VtLrnCEgSIrrRolIpwR6cSvYnsBqNu05IWjK3m2IHxM
        bmnMQGZLJ0j8PDdI0E1aavqlP0Fz
X-Google-Smtp-Source: AHgI3IbjkPALmcbquI9ka1WFqcKquXeKK2km7phH1pErP03BSGQBuxlkM8oLXSR1bk77bwdsnj0MvA==
X-Received: by 2002:a65:64c8:: with SMTP id t8mr7499119pgv.31.1550271202845;
        Fri, 15 Feb 2019 14:53:22 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id d129sm9719905pfc.31.2019.02.15.14.53.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 14:53:22 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        linux-kernel@vger.kernel.org (open list),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE),
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next v2 3/9] mlxsw: spectrum: Handle PORT_PRE_BRIDGE_FLAGS
Date:   Fri, 15 Feb 2019 14:53:07 -0800
Message-Id: <20190215225313.32303-4-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190215225313.32303-1-f.fainelli@gmail.com>
References: <20190215225313.32303-1-f.fainelli@gmail.com>
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
 .../mellanox/mlxsw/spectrum_switchdev.c       | 22 ++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index 1f492b7dbea8..8cdc0fe17a2e 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -595,10 +595,25 @@ mlxsw_sp_bridge_port_learning_set(struct mlxsw_sp_port *mlxsw_sp_port,
 	return err;
 }
 
+static int mlxsw_sp_port_attr_br_pre_flags_set(struct mlxsw_sp_port
+					       *mlxsw_sp_port,
+					       struct switchdev_trans *trans,
+					       unsigned long brport_flags)
+{
+	if (switchdev_trans_ph_prepare(trans))
+		return 0;
+
+	if (brport_flags & ~(BR_LEARNING | BR_FLOOD | BR_MCAST_FLOOD))
+		return -EINVAL;
+
+	return 0;
+}
+
 static int mlxsw_sp_port_attr_br_flags_set(struct mlxsw_sp_port *mlxsw_sp_port,
 					   struct switchdev_trans *trans,
 					   struct net_device *orig_dev,
-					   unsigned long brport_flags)
+					   unsigned long brport_flags,
+					   bool pre_set)
 {
 	struct mlxsw_sp_bridge_port *bridge_port;
 	int err;
@@ -841,6 +856,11 @@ static int mlxsw_sp_port_attr_set(struct net_device *dev,
 						       attr->orig_dev,
 						       attr->u.stp_state);
 		break;
+	case SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS:
+		err = mlxsw_sp_port_attr_br_pre_flags_set(mlxsw_sp_port,
+							  trans,
+							  attr->u.brport_flags);
+		break;
 	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS:
 		err = mlxsw_sp_port_attr_br_flags_set(mlxsw_sp_port, trans,
 						      attr->orig_dev,
-- 
2.17.1

