Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E122ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 19:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B59992054F
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 19:37:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FB5A32R1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B59992054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbeJYEGe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 00:06:34 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45917 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbeJYEGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 00:06:33 -0400
Received: by mail-wr1-f67.google.com with SMTP id n5-v6so3051067wrw.12;
        Wed, 24 Oct 2018 12:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=2S+qq7eHn7jtuqE/DLkUUqZS5/P5m6JsCPwpuiklhRo=;
        b=FB5A32R17/WO33PmCghSc8jl+wUpOP6UiZQiR4XSuA7GeNRDt/8GHw3kQ7QXwnZ7fC
         Bbejy0mitQIkI2YWcS3YkqZpeJYJW8F5Z0SNIkeOCbpEjkRwi/qpC0Fk281n0/Aq3hS8
         xgSJK4v0F5ndYoLpw6VX5/d2XAKGxSC8mJRNNKsoGWuSnMYt0LjT++00tMuOGq22AWUL
         qPa2ma4oIcAC/zGUofU0Lgqlb3T9ityYKIyU1a1AkMU1oSp0xYLkAx3hQAnvWR9ZO6fM
         I+kQ0mA6pheab/aQENcqpUNeOGGcHsWUm5HPCDvNwPFse1Kis6gst4yEe4HlRb+fdk5Z
         brsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=2S+qq7eHn7jtuqE/DLkUUqZS5/P5m6JsCPwpuiklhRo=;
        b=qfr0hgT8GSoZbrltAyunlvxW9m7cHMXN01qf312mJybHd58uDXeB5kAWc3YmkrlDhk
         xVWlnr5Ofvnm9sbTFf+mHYHD0Py6GELblANEFmTBg1xcD2ikzp8myX7t19i4I5tzKTgD
         q6NJNRq0xtwvOZjRmoK/Fx35TaZJ7JXlvd/ydFtLVpz2PXjWSf+197mw6JKryjInOd2V
         63UumxwJVNKHi540YstyHMxwHNNgFjQlVyCnngX6BmCx5xd4UiEsjBWxRM/5ZhIKiwOb
         KSiC97LTuWUKE3SVNw8eZqU+To+uO6JfiUCEJgjE4DVIGz5NO1Dly7bx9XMQgw0uO1PS
         HIKw==
X-Gm-Message-State: AGRZ1gJHzg5i+pfAS3PGbvfA89VntP2KFfbYPVXfP00keTM+MNPg6IPD
        vvvCFvJ/hzvj8551YlxssIdjHwpw9P0=
X-Google-Smtp-Source: AJdET5fLWOmnzhKjEGD/R+8ub5WwqzzMJlu4qSkt75qL32vGUdzQWDM+73FXyY8GsvxTqs7uQKlpmw==
X-Received: by 2002:adf:9589:: with SMTP id p9-v6mr399280wrp.270.1540409829439;
        Wed, 24 Oct 2018 12:37:09 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id t143-v6sm4293725wmt.2.2018.10.24.12.37.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 12:37:08 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     jiri@mellanox.com, petr@mellanox.com, idosch@mellanox.com,
        privat@egil-hjelmeland.no, Woojung.Huh@microchip.com,
        tristram.ha@microchip.com, Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH RFC] net: dsa: Make switches VLAN aware when enslaved into a bridge
Date:   Wed, 24 Oct 2018 12:36:57 -0700
Message-Id: <20181024193657.24012-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 2ea7a679ca2a ("net: dsa: Don't add vlans when vlan filtering is
disabled") changed the behavior of DSA switches when the switch ports
are enslaved into the bridge and only pushed the VLAN configuration down
to the switch if the bridge is configured with VLAN filtering enabled.

This is unfortunately wrong, because what vlan_filtering configures is a
policy on the acceptance of VLAN tagged frames with an unknown VID.

vlan_filtering=0 means a frame with a VLAN tag that is not part of the
VLAN table should be allowed to ingress the switch, and vlan_fltering=1
would reject that frame.

Fixes: 2ea7a679ca2a ("net: dsa: Don't add vlans when vlan filtering is disabled")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
Andrew,

I checked with Jiri and he confirmed that our interpretention of
vlan_filtering in DSA was incorrect and that it does denote whether the
switch should be doing VID ingress policy checking.

You mentioned in the commit message some problems without being too
specific about them which is why I am putting the same checks in
mv88e6xxx in order not to break your use cases. Let me know if you want
to drop that hunk entirely.

Thanks!

 drivers/net/dsa/mv88e6xxx/chip.c |  7 ++++++-
 net/dsa/port.c                   | 10 ++--------
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 8da3d39e3218..df411e776911 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -1684,13 +1684,14 @@ static int _mv88e6xxx_port_vlan_add(struct mv88e6xxx_chip *chip, int port,
 static void mv88e6xxx_port_vlan_add(struct dsa_switch *ds, int port,
 				    const struct switchdev_obj_port_vlan *vlan)
 {
+	struct dsa_port *dp = &ds->ports[i];
 	struct mv88e6xxx_chip *chip = ds->priv;
 	bool untagged = vlan->flags & BRIDGE_VLAN_INFO_UNTAGGED;
 	bool pvid = vlan->flags & BRIDGE_VLAN_INFO_PVID;
 	u8 member;
 	u16 vid;
 
-	if (!chip->info->max_vid)
+	if (!chip->info->max_vid || br_vlan_enabled(dp->bridge_dev))
 		return;
 
 	if (dsa_is_dsa_port(ds, port) || dsa_is_cpu_port(ds, port))
@@ -1751,12 +1752,16 @@ static int mv88e6xxx_port_vlan_del(struct dsa_switch *ds, int port,
 				   const struct switchdev_obj_port_vlan *vlan)
 {
 	struct mv88e6xxx_chip *chip = ds->priv;
+	struct dsa_port *dp = &ds->ports[i];
 	u16 pvid, vid;
 	int err = 0;
 
 	if (!chip->info->max_vid)
 		return -EOPNOTSUPP;
 
+	if (br_vlan_enabled(dp->bridge_dev))
+		return 0;
+
 	mutex_lock(&chip->reg_lock);
 
 	err = mv88e6xxx_port_get_pvid(chip, port, &pvid);
diff --git a/net/dsa/port.c b/net/dsa/port.c
index ed0595459df1..111d7cfc8982 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -255,10 +255,7 @@ int dsa_port_vlan_add(struct dsa_port *dp,
 	if (netif_is_bridge_master(vlan->obj.orig_dev))
 		return -EOPNOTSUPP;
 
-	if (br_vlan_enabled(dp->bridge_dev))
-		return dsa_port_notify(dp, DSA_NOTIFIER_VLAN_ADD, &info);
-
-	return 0;
+	return dsa_port_notify(dp, DSA_NOTIFIER_VLAN_ADD, &info);
 }
 
 int dsa_port_vlan_del(struct dsa_port *dp,
@@ -273,10 +270,7 @@ int dsa_port_vlan_del(struct dsa_port *dp,
 	if (netif_is_bridge_master(vlan->obj.orig_dev))
 		return -EOPNOTSUPP;
 
-	if (br_vlan_enabled(dp->bridge_dev))
-		return dsa_port_notify(dp, DSA_NOTIFIER_VLAN_DEL, &info);
-
-	return 0;
+	return dsa_port_notify(dp, DSA_NOTIFIER_VLAN_DEL, &info);
 }
 
 static struct phy_device *dsa_port_get_phy_device(struct dsa_port *dp)
-- 
2.17.1

