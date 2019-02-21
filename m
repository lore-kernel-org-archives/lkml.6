Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77208C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 00:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 434D72081B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 00:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHjpDU8v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbfBUA6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 19:58:55 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34383 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfBUA6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 19:58:53 -0500
Received: by mail-pg1-f195.google.com with SMTP id i130so12843135pgd.1;
        Wed, 20 Feb 2019 16:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9UDI7X41YNHKHghB/bq/RanLp9N2yQLoh7jMnll+lSo=;
        b=MHjpDU8vnx8rt7P5+weZq3EGNcz1vZRbdJIk4Wa1yVGy9RR7GxN+6bHHBsWx2j74ix
         jDHM+4RAghP2+XJ0tNsOTWTqaxm3EvbvSiPOzbcw+G8pbEEVwaYzHB6mGxIc5YRiHaZA
         3F1nYnaRM2f8ZEYUd0O8yonZbv9s05Vh4/x8PAfCacgpL3iVPl335peoSUHbS3Oe13WT
         f6vpsnBlz7YX+h+k5TiQH08SfQClFxYLYBsCzFHDwJvQIN/nsOE4r+ELLgeAUKsHlBaK
         NxSUmQzVir1DGOxCf6Wc6nuQ00EoldQmF8e9QNWXwO9DtmVIMmRw4JACA+2NwyjOCeRP
         IanA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9UDI7X41YNHKHghB/bq/RanLp9N2yQLoh7jMnll+lSo=;
        b=nSGlWqUFrP+C9FfXRbEVio9t7yTKpY6Wqe/TTSeVY98wV9+795gQkzspK5TWJcsOEe
         INwmgpW9On75m5atD2wZev/7KDRDcfb3jJJWP5opWF42POMW7QHAzlxPzlBfuHTf8ReC
         822GlNjtwRtpaQmHhdBxS7x6adkTt3ZerfqQnu1wLgyls10fsP2pt9+g7kreeeUdkH2Z
         a2Z8+98ee4MZHdma34HCclmtUU8rQmjjl++6UzPZ/uU9g+gAws1PrBylywyr8dtX7YHA
         Ex4ICUB9ePDFGzqnwYHw0USnpg6p3DV5cUINAzJFDOs/yOG2nCTdgjkpSg9wQgbTWxav
         Ezbg==
X-Gm-Message-State: AHQUAubX0jwM4vWQSesSto5KJbyeZymwEzIPV7EdzJZ1GdZNLDUcAmed
        TEJ+2tyC7i4jLztjiO/lFHaLldK8
X-Google-Smtp-Source: AHgI3IbhvGdAWyREuyN03U+kJsev9flRLgTE+Nc7THU8ilSfEFaR4vgchmFyWEmDHRZ8Np8KyCoUzA==
X-Received: by 2002:a62:61c4:: with SMTP id v187mr13313157pfb.133.1550710731786;
        Wed, 20 Feb 2019 16:58:51 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id z15sm17203255pgc.25.2019.02.20.16.58.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 16:58:51 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        linux-kernel@vger.kernel.org (open list),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE),
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next v3 4/8] net: dsa: Add setter for SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS
Date:   Wed, 20 Feb 2019 16:58:22 -0800
Message-Id: <20190221005826.26317-5-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190221005826.26317-1-f.fainelli@gmail.com>
References: <20190221005826.26317-1-f.fainelli@gmail.com>
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
 net/dsa/dsa_priv.h |  2 ++
 net/dsa/port.c     | 12 ++++++++++++
 net/dsa/slave.c    |  4 ++++
 3 files changed, 18 insertions(+)

diff --git a/net/dsa/dsa_priv.h b/net/dsa/dsa_priv.h
index f4f99ec29f5d..47a1d1379d15 100644
--- a/net/dsa/dsa_priv.h
+++ b/net/dsa/dsa_priv.h
@@ -160,6 +160,8 @@ int dsa_port_mdb_add(const struct dsa_port *dp,
 		     struct switchdev_trans *trans);
 int dsa_port_mdb_del(const struct dsa_port *dp,
 		     const struct switchdev_obj_port_mdb *mdb);
+int dsa_port_pre_bridge_flags(const struct dsa_port *dp, unsigned long flags,
+			      struct switchdev_trans *trans);
 int dsa_port_bridge_flags(const struct dsa_port *dp, unsigned long flags,
 			  struct switchdev_trans *trans);
 int dsa_port_vlan_add(struct dsa_port *dp,
diff --git a/net/dsa/port.c b/net/dsa/port.c
index 7bc2a5ad95c6..e9b5b50f8cf1 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -187,6 +187,18 @@ int dsa_port_ageing_time(struct dsa_port *dp, clock_t ageing_clock,
 	return dsa_port_notify(dp, DSA_NOTIFIER_AGEING_TIME, &info);
 }
 
+int dsa_port_pre_bridge_flags(const struct dsa_port *dp, unsigned long flags,
+			      struct switchdev_trans *trans)
+{
+	struct dsa_switch *ds = dp->ds;
+
+	if (!ds->ops->port_egress_floods ||
+	    (flags & ~(BR_FLOOD | BR_MCAST_FLOOD)))
+		return -EINVAL;
+
+	return 0;
+}
+
 int dsa_port_bridge_flags(const struct dsa_port *dp, unsigned long flags,
 			  struct switchdev_trans *trans)
 {
diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index 85dc68611002..44cc4e50dd5a 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -295,6 +295,10 @@ static int dsa_slave_port_attr_set(struct net_device *dev,
 	case SWITCHDEV_ATTR_ID_BRIDGE_AGEING_TIME:
 		ret = dsa_port_ageing_time(dp, attr->u.ageing_time, trans);
 		break;
+	case SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS:
+		ret = dsa_port_pre_bridge_flags(dp, attr->u.brport_flags,
+						trans);
+		break;
 	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS:
 		ret = dsa_port_bridge_flags(dp, attr->u.brport_flags, trans);
 		break;
-- 
2.17.1

