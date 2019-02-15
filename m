Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D9BCC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36A62222D0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 22:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fHJi0B45"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394162AbfBOWyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 17:54:25 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35417 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403879AbfBOWx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 17:53:26 -0500
Received: by mail-pl1-f194.google.com with SMTP id p8so5656279plo.2;
        Fri, 15 Feb 2019 14:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VDGmRMfeqZv9NxuAeBQdbUzJUsHV0xq2Pnb3Ma6yPoU=;
        b=fHJi0B45dpX2nXBWIkj7n3csq8XA3GJLOSf315HQEMWlPPy4SQujmTv8qbRGV3YBVu
         AJZTtb5w3vxVwBoRm+nCexc7xqBPHXXkddRtnOr4cNqB7m7RfdPytw6NMrRQUHyHkm0h
         VXeVDzisTdNpAfag4yEVSjzq/BgPqnMZDGGZYL/Kl/2dUDO/Gt1pO/ROoGkQp7+6ef9u
         JCm1npFS938zhKmgaLEPIumpPH6hWU8uzL+jImgNY4kihFf0twkjlIV20J9yv83Gkmsp
         Z8DlSz2KfTtAlbtm/C+uDBKtU2QgQ1FYNLzAK76IxmELr+Eyb/msyOujzxA6F5J6x0XY
         Jh/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VDGmRMfeqZv9NxuAeBQdbUzJUsHV0xq2Pnb3Ma6yPoU=;
        b=lEfljHHQlG79cROt/IcQHNXoAtqlmqFwJ0gMqrzO91Eqx4xq6ioX73WmRCzAAliRuz
         m7zBoSbOHQ+mqkTJH2WWexX+BClvrEzLVtDCF8k0NRK2rTBPgd5CVbnvrvOiVVnrlltf
         GwvAoLzumo5Su5AIphhMmnobjgHHzMTMsRHCK0di2dNJ/dZ2mYudIuGQEc3maWtgoqT4
         ePaovHO92AOc30pc/qKSYZervQwbTLrfbWEbE235jbmgAKzGqX1TsLm3FGPIkBOzJnZt
         QQYGnSeiqWMQKq2OnaMRwJhnP67dM/W5AQw50QPuLo+Xg8aLT7IAbq9f4vcHX5pCPhGM
         fe4w==
X-Gm-Message-State: AHQUAuZjTZ61cAIO8sIGo72yiR4HSYjiITeIXDUL34ZDw/Phrje0nvDO
        2ww0F+YA1a9wa3AELNmu/1r3KsY0
X-Google-Smtp-Source: AHgI3IYExsjGZGgMZythUEinhQXDH0azMb5/UK0vIAWYOeJntw8HdG04ym59tCbjPSA2zZWOBowMrw==
X-Received: by 2002:a17:902:860a:: with SMTP id f10mr12467915plo.136.1550271205863;
        Fri, 15 Feb 2019 14:53:25 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id d129sm9719905pfc.31.2019.02.15.14.53.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 14:53:25 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        linux-kernel@vger.kernel.org (open list),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE),
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next v2 5/9] net: dsa: Add setter for SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS
Date:   Fri, 15 Feb 2019 14:53:09 -0800
Message-Id: <20190215225313.32303-6-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190215225313.32303-1-f.fainelli@gmail.com>
References: <20190215225313.32303-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for removing SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT,
add support for a function that processes the
SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS and
SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS attributes and returns not
supported for any flag set, since DSA does not currently support
toggling those bridge port attributes (yet).

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 net/dsa/dsa_priv.h |  6 ++++++
 net/dsa/port.c     | 17 +++++++++++++++++
 net/dsa/slave.c    |  9 +++++++++
 3 files changed, 32 insertions(+)

diff --git a/net/dsa/dsa_priv.h b/net/dsa/dsa_priv.h
index 1f4972dab9f2..3d58dc4f4d46 100644
--- a/net/dsa/dsa_priv.h
+++ b/net/dsa/dsa_priv.h
@@ -150,6 +150,12 @@ int dsa_port_vlan_filtering(struct dsa_port *dp, bool vlan_filtering,
 			    struct switchdev_trans *trans);
 int dsa_port_ageing_time(struct dsa_port *dp, clock_t ageing_clock,
 			 struct switchdev_trans *trans);
+int dsa_port_bridge_port_pre_flags_set(struct dsa_port *dp,
+				       unsigned long brport_flags,
+				       struct switchdev_trans *trans);
+int dsa_port_bridge_port_flags_set(struct dsa_port *dp,
+				   unsigned long brport_flags,
+				   struct switchdev_trans *trans);
 int dsa_port_fdb_add(struct dsa_port *dp, const unsigned char *addr,
 		     u16 vid);
 int dsa_port_fdb_del(struct dsa_port *dp, const unsigned char *addr,
diff --git a/net/dsa/port.c b/net/dsa/port.c
index 2d7e01b23572..c67a329d4414 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -177,6 +177,23 @@ int dsa_port_ageing_time(struct dsa_port *dp, clock_t ageing_clock,
 	return dsa_port_notify(dp, DSA_NOTIFIER_AGEING_TIME, &info);
 }
 
+int dsa_port_bridge_port_pre_flags_set(struct dsa_port *dp,
+				       unsigned long brport_flags,
+				       struct switchdev_trans *trans)
+{
+	if (switchdev_trans_ph_prepare(trans))
+		return 0;
+
+	return -EINVAL;
+}
+
+int dsa_port_bridge_port_flags_set(struct dsa_port *dp,
+				   unsigned long brport_flags,
+				   struct switchdev_trans *trans)
+{
+	return -EOPNOTSUPP;
+}
+
 int dsa_port_fdb_add(struct dsa_port *dp, const unsigned char *addr,
 		     u16 vid)
 {
diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index 2e5e7c04821b..d3370e840956 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -295,6 +295,15 @@ static int dsa_slave_port_attr_set(struct net_device *dev,
 	case SWITCHDEV_ATTR_ID_BRIDGE_AGEING_TIME:
 		ret = dsa_port_ageing_time(dp, attr->u.ageing_time, trans);
 		break;
+	case SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS:
+		ret = dsa_port_bridge_port_pre_flags_set(dp,
+							 attr->u.brport_flags,
+							 trans);
+		break;
+	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS:
+		ret = dsa_port_bridge_port_flags_set(dp, attr->u.brport_flags,
+						     trans);
+		break;
 	default:
 		ret = -EOPNOTSUPP;
 		break;
-- 
2.17.1

