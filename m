Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B50C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 00:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82A5020855
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 00:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tqbYZbeP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbfBUA6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 19:58:47 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45925 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfBUA6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 19:58:44 -0500
Received: by mail-pg1-f195.google.com with SMTP id y4so12821187pgc.12;
        Wed, 20 Feb 2019 16:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JxyV5djIl/VRQnKUN8DXhmuwa6Oozfa8/E9OhzYbBjk=;
        b=tqbYZbePSD8pqc5mZG3sTHGEzI3c7F8B0H4hF4/pswZTlAlF3tnTsflk7kVGri5tSh
         yqgQfWI6MB3UWfuu7oIGtK6B+elFCBc1e/93hoyrkWVsnA/1yg+YxKprmXkfwtrbjBk1
         Kpb9KnoHQpcdKq4meRFwFhmOlnC6hskmdTXzMdKaRpSyGkdUIdcAj0VyZDg20O0JWcos
         QLEvZl64PEVqTt1MP50QUBiQj4OxAnnr68gNVfIY6lriPW6SHZbdq+fG+3cGU4/7a+dL
         LyCPlRkPsJFTynPlQXLD6Dk3l9kEVQUINIyi1irPERRJK+KpMRKlyCPQJtTCgGnRd/lv
         gnUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JxyV5djIl/VRQnKUN8DXhmuwa6Oozfa8/E9OhzYbBjk=;
        b=Xmh4C63359erPvAHNvaHqo0yVrCnTCWQwk53gHiQDgvUWtTGf2PRE1Ps8iJ6rwC5ob
         9iS/TsPKxACMLqbJ4g6NKfWYPqrSqUuwS1kRclhxRi5N0X5o/iqhO6h4XvR6o7q2nYZY
         +gjMSLlsLQ/7eiQ6tU9bhdQf59AY7PwrzaNBSZVQgXxlEE/lCrFdSI7l8/tCmWlhtA+M
         lXy7q8HCC7DQzEzeMTLssYH7+1jMfLlBJLa58mLE7mE7PzbyBkIGQgUiIyKp4fqxuk3F
         B9x6gg8o386L0i0VB+sp1W1EmeqaMfxdLTjEEEIQNVtk8nivYVOGjqRfwdHOiKjo71UZ
         /bCQ==
X-Gm-Message-State: AHQUAubfYqq9KkbAdj4ubZ96rk3+CbXoPOGIPYofEzXUetuI6dyYXTKy
        em4V+MqR2oD1t3MGAXOVi0oOlr5D
X-Google-Smtp-Source: AHgI3IbdBR+APBxntQLd0NttQAcOqbyrLK/JYDst6kz22o5RNTEpHL+h1AJ+YiWPjcyShwHd4NDcug==
X-Received: by 2002:aa7:8249:: with SMTP id e9mr37533427pfn.93.1550710723108;
        Wed, 20 Feb 2019 16:58:43 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id z15sm17203255pgc.25.2019.02.20.16.58.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 16:58:42 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        linux-kernel@vger.kernel.org (open list),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE),
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next v3 2/8] mlxsw: spectrum: Handle PORT_PRE_BRIDGE_FLAGS
Date:   Wed, 20 Feb 2019 16:58:20 -0800
Message-Id: <20190221005826.26317-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190221005826.26317-1-f.fainelli@gmail.com>
References: <20190221005826.26317-1-f.fainelli@gmail.com>
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
 .../ethernet/mellanox/mlxsw/spectrum_switchdev.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
index 1f492b7dbea8..9a8798f74d2b 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_switchdev.c
@@ -595,6 +595,17 @@ mlxsw_sp_bridge_port_learning_set(struct mlxsw_sp_port *mlxsw_sp_port,
 	return err;
 }
 
+static int mlxsw_sp_port_attr_br_pre_flags_set(struct mlxsw_sp_port
+					       *mlxsw_sp_port,
+					       struct switchdev_trans *trans,
+					       unsigned long brport_flags)
+{
+	if (brport_flags & ~(BR_LEARNING | BR_FLOOD | BR_MCAST_FLOOD))
+		return -EINVAL;
+
+	return 0;
+}
+
 static int mlxsw_sp_port_attr_br_flags_set(struct mlxsw_sp_port *mlxsw_sp_port,
 					   struct switchdev_trans *trans,
 					   struct net_device *orig_dev,
@@ -841,6 +852,11 @@ static int mlxsw_sp_port_attr_set(struct net_device *dev,
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

