Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3771AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0456020842
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:07:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQfMUSGF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436995AbfBMWHg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 17:07:36 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46974 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727190AbfBMWHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 17:07:34 -0500
Received: by mail-pg1-f195.google.com with SMTP id w7so1802806pgp.13;
        Wed, 13 Feb 2019 14:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zhn5DT6JA7hfxUQ3fw/Pm1kt+m2tksN1j/7Jsb3V7Ro=;
        b=aQfMUSGFuyMHVEAbv4VRomOraGhTDgHl8SAR6O43VbqwsxftqXYm0AigEgP2Mcaiko
         b0wmnVPzAm/pIiKAYlwFYRQQGK29h/4zuAPVInWJ5Ll4SH78GyYKrXI6f/tzImFFRthr
         YGt3O3GLcI1Hpuq0a60SYvX18fBpWaVzwQYm4CUlostRNdudA09jySaarVMUIuD001B6
         /Kgc+zOlaL5IqP16Mx6VRVVf6U5ONsCfld/Hx15X1f1C6ba5xOHwgWIN82Ni3LYGtZ6P
         tYrMcl26JFvvrqLUKBLngjKZBwhEo0X0yEMgpKKXW3TStTYu028Ydy52qZ7W2R12Ceeb
         24/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zhn5DT6JA7hfxUQ3fw/Pm1kt+m2tksN1j/7Jsb3V7Ro=;
        b=piVsZS0Mk13UCjLbu+Jq37kpQKKFXHCXmeYCuNxrW2Yn5iRhwXBxmyauicVmnLgl1l
         hl+Z4kg/vt1Z5gAvahs/4FiLTVpVCDDrWv0mAOXxXSJ01HOwgVsIRJ6IfSWV1gXeJkZU
         P9wfVYmiROrTmsNC8QvtUyud57CbDT4evJU4MAGz+32R7jF1VnRVOuSHw+sa87s2eKH7
         iTPVHU6cdjWoqgcqjVk7JHyY8ESf1gD6jOtEpDyUDnOmCVdI1lQBRec7AzdSjF5fpl8Y
         Og4lNzXntjeG/BzrK5qVzEClL5LU0eLtJnVVuvdFEy8Q+t3LPh+6PDZ2jafiuojETORK
         43yw==
X-Gm-Message-State: AHQUAuZ4aKEFfJ6Rem3jbo9auWv3k6CvJz3bnvqpIgPt15UgYwDgdxyk
        U3S8/lTM14F8XHh2LgywGJ06Wl51
X-Google-Smtp-Source: AHgI3Ibxm7z9fE7v/B42J+9Kfb0erWhRbniskgJaUaIQfYrHJ8MYjC3nhuF9WA1MHu+kyPQpCwYWHw==
X-Received: by 2002:a63:e742:: with SMTP id j2mr422942pgk.172.1550095653274;
        Wed, 13 Feb 2019 14:07:33 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id o1sm383735pgn.63.2019.02.13.14.07.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 14:07:32 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        linux-kernel@vger.kernel.org (open list),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE),
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next 5/9] net: dsa: Add setter for SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS
Date:   Wed, 13 Feb 2019 14:06:34 -0800
Message-Id: <20190213220638.1552-6-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190213220638.1552-1-f.fainelli@gmail.com>
References: <20190213220638.1552-1-f.fainelli@gmail.com>
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
 net/dsa/dsa_priv.h |  3 +++
 net/dsa/port.c     | 11 +++++++++++
 net/dsa/slave.c    |  7 +++++++
 3 files changed, 21 insertions(+)

diff --git a/net/dsa/dsa_priv.h b/net/dsa/dsa_priv.h
index 1f4972dab9f2..50d73698dfb3 100644
--- a/net/dsa/dsa_priv.h
+++ b/net/dsa/dsa_priv.h
@@ -150,6 +150,9 @@ int dsa_port_vlan_filtering(struct dsa_port *dp, bool vlan_filtering,
 			    struct switchdev_trans *trans);
 int dsa_port_ageing_time(struct dsa_port *dp, clock_t ageing_clock,
 			 struct switchdev_trans *trans);
+int dsa_port_bridge_port_flags_set(struct dsa_port *dp,
+				   unsigned long brport_flags,
+				   struct switchdev_trans *trans, bool pre_set);
 int dsa_port_fdb_add(struct dsa_port *dp, const unsigned char *addr,
 		     u16 vid);
 int dsa_port_fdb_del(struct dsa_port *dp, const unsigned char *addr,
diff --git a/net/dsa/port.c b/net/dsa/port.c
index 2d7e01b23572..b0c4cfd18da9 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -177,6 +177,17 @@ int dsa_port_ageing_time(struct dsa_port *dp, clock_t ageing_clock,
 	return dsa_port_notify(dp, DSA_NOTIFIER_AGEING_TIME, &info);
 }
 
+int dsa_port_bridge_port_flags_set(struct dsa_port *dp,
+				   unsigned long brport_flags,
+				   struct switchdev_trans *trans,
+				   bool pre_set)
+{
+	if (brport_flags)
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
 int dsa_port_fdb_add(struct dsa_port *dp, const unsigned char *addr,
 		     u16 vid)
 {
diff --git a/net/dsa/slave.c b/net/dsa/slave.c
index 2e5e7c04821b..417388c9f1fa 100644
--- a/net/dsa/slave.c
+++ b/net/dsa/slave.c
@@ -282,6 +282,7 @@ static int dsa_slave_port_attr_set(struct net_device *dev,
 				   struct switchdev_trans *trans)
 {
 	struct dsa_port *dp = dsa_slave_to_port(dev);
+	bool pre_set = false;
 	int ret;
 
 	switch (attr->id) {
@@ -295,6 +296,12 @@ static int dsa_slave_port_attr_set(struct net_device *dev,
 	case SWITCHDEV_ATTR_ID_BRIDGE_AGEING_TIME:
 		ret = dsa_port_ageing_time(dp, attr->u.ageing_time, trans);
 		break;
+	case SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS:
+		pre_set = true; /* fall through */
+	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS:
+		ret = dsa_port_bridge_port_flags_set(dp, attr->u.brport_flags,
+						     trans, pre_set);
+		break;
 	default:
 		ret = -EOPNOTSUPP;
 		break;
-- 
2.17.1

