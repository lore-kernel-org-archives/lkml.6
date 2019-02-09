Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A47FAC282CB
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7334920821
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bvxk9HQp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbfBIAdd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 19:33:33 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46657 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbfBIAda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 19:33:30 -0500
Received: by mail-pl1-f196.google.com with SMTP id o6so2440041pls.13;
        Fri, 08 Feb 2019 16:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SdrJ+oS+GUGFnNUQUWKb4pbc8XzkyTnnh3se8pJXu1M=;
        b=Bvxk9HQpTUfcPUbKmQdZjIRmVb4uHvx32UT7E74ywnMEz8K95iVy6IkNdfqjewvQFQ
         UJzmfFVc2YGzeOAl6132yXkWzYAk01dmMSwSxXsofRLiqCxE1sSTVnwc4XRWC2QdXp85
         /0v/sra6UNcRj6JEC4aUbUTXjZAIBMdoc6EG8fr2QtWlp10nQcsqQP0yB9qfRqZmuXPN
         Uf2r37Nb+4ixYHT5+VOvBGBXJlIinpTRLVU2W3k6OuHwyRmvAxbMO5PzPvUc95NO2dcY
         OjewS2woHjAUsYURb+cvcqH6kvhYwk90JFk19vwwfq7Mvj0PCvOBuh7kfr6vVuyzMUeG
         e7zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SdrJ+oS+GUGFnNUQUWKb4pbc8XzkyTnnh3se8pJXu1M=;
        b=nfbscAhkZc2ukf7mtcOB3z8x1rYYMlzrcw/8y9rdwurdmjW1/e2czxMSANDhxDoVwu
         KMPFk0l+PbK1tupx2ugoJWwpnUtWasX18Hsd7cPFRmm6bWvzBcn28gf+dCeIW0N8K021
         sHiNm7d7/4zdYXR5Gy7M0dT9eRJD+enkyY1xgdEFsE+gAvCx5UEkrfHaq54YeiaJSN9c
         O80B0+Lm2xVTGfPk9Feo054phB7oQlmTNaEsFGCfHMC6GDUlscZG8KtHTH4+kvswaD4Q
         GVByCI/7SRHkD46HF7iCbiGtvhWtflcZClXQ2w971vA+8WuvtjSvpXrywKAZi4IEBWOL
         b3fw==
X-Gm-Message-State: AHQUAubvY5hbV6Wx7HyZQlVtHXJRve0RyZ/7t2/+GMdXGIqnsGyG8gNu
        DpvbQ9tjBXpvTQzidwiOGrZrhSUc
X-Google-Smtp-Source: AHgI3IahN/+ivn1O/r6Nv/QyUapEKNfF76Ri1WWL7VQV9mzB8txsJvzJmzRAZKOCYwMWsbPmmUZXIQ==
X-Received: by 2002:a17:902:129:: with SMTP id 38mr25808977plb.140.1549672409794;
        Fri, 08 Feb 2019 16:33:29 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id i71sm372491pfi.170.2019.02.08.16.33.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 16:33:28 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        linux-kernel@vger.kernel.org (open list),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE),
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next 05/16] rocker: Check bridge flags during prepare phase
Date:   Fri,  8 Feb 2019 16:32:37 -0800
Message-Id: <20190209003248.31088-6-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190209003248.31088-1-f.fainelli@gmail.com>
References: <20190209003248.31088-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for getting rid of switchdev_port_attr_get(), have rocker
check for the bridge flags being set through switchdev_port_attr_set()
with the SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS attribute identifier.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/rocker/rocker_main.c | 40 ++++++++++++++---------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/rocker/rocker_main.c b/drivers/net/ethernet/rocker/rocker_main.c
index 66f72f8c46e5..8657313b6f30 100644
--- a/drivers/net/ethernet/rocker/rocker_main.c
+++ b/drivers/net/ethernet/rocker/rocker_main.c
@@ -1565,18 +1565,42 @@ static int rocker_world_port_attr_stp_state_set(struct rocker_port *rocker_port,
 	return wops->port_attr_stp_state_set(rocker_port, state);
 }
 
+static int
+rocker_world_port_attr_bridge_flags_support_get(const struct rocker_port *
+						rocker_port,
+						unsigned long *
+						p_brport_flags_support)
+{
+	struct rocker_world_ops *wops = rocker_port->rocker->wops;
+
+	if (!wops->port_attr_bridge_flags_support_get)
+		return -EOPNOTSUPP;
+	return wops->port_attr_bridge_flags_support_get(rocker_port,
+							p_brport_flags_support);
+}
+
 static int
 rocker_world_port_attr_bridge_flags_set(struct rocker_port *rocker_port,
 					unsigned long brport_flags,
 					struct switchdev_trans *trans)
 {
 	struct rocker_world_ops *wops = rocker_port->rocker->wops;
+	unsigned long brport_flags_s;
+	int err;
 
 	if (!wops->port_attr_bridge_flags_set)
 		return -EOPNOTSUPP;
 
-	if (switchdev_trans_ph_prepare(trans))
+	if (switchdev_trans_ph_prepare(trans)) {
+		err = rocker_world_port_attr_bridge_flags_support_get(rocker_port,
+							      &brport_flags_s);
+		if (err)
+			return err;
+
+		if (brport_flags & ~brport_flags_s)
+			return -EOPNOTSUPP;
 		return 0;
+	}
 
 	return wops->port_attr_bridge_flags_set(rocker_port, brport_flags,
 						trans);
@@ -1593,20 +1617,6 @@ rocker_world_port_attr_bridge_flags_get(const struct rocker_port *rocker_port,
 	return wops->port_attr_bridge_flags_get(rocker_port, p_brport_flags);
 }
 
-static int
-rocker_world_port_attr_bridge_flags_support_get(const struct rocker_port *
-						rocker_port,
-						unsigned long *
-						p_brport_flags_support)
-{
-	struct rocker_world_ops *wops = rocker_port->rocker->wops;
-
-	if (!wops->port_attr_bridge_flags_support_get)
-		return -EOPNOTSUPP;
-	return wops->port_attr_bridge_flags_support_get(rocker_port,
-							p_brport_flags_support);
-}
-
 static int
 rocker_world_port_attr_bridge_ageing_time_set(struct rocker_port *rocker_port,
 					      u32 ageing_time,
-- 
2.17.1

