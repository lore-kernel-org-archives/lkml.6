Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2343BC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 21:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3241214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 21:18:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OSIA8Fj2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbfBKVSW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 16:18:22 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43983 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbfBKVSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 16:18:21 -0500
Received: by mail-pl1-f196.google.com with SMTP id f90so145556plb.10;
        Mon, 11 Feb 2019 13:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=p5ZCXTBfLok1XMf+SlQNjbPYGN3N8X4VxG7Tq+I0H5E=;
        b=OSIA8Fj2pOi8lhCDKo5ZYKT8u0H9kmPzH/BVhtIGSchGYFx56fFEUVkxdOe3G5YDkL
         ZyMPiBo7zqGPKB4r03DMaloM7CdCi5cKXAyj4GcrEQ03C9UiMUa6zx0Cw6OmP+RLSL2B
         o39SdzxdfHh1qq4yZB0xdtfFIwpH0lXDFenjKudDnO154i8DAPuDZjLJOquTiniHgnOk
         DCD/zJNkUN9KAB1IR16U/hgB8kfOwh4+nqZJPmrir7gYBUYPURe7sL4Bxx6VkrzRgb2P
         mtGQ7MeofN/DlFTywGxbwpUEVZLBQG5kSBYes1HY958iFY+RZFQoiu7VYZAiDNTEpg6h
         3TyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=p5ZCXTBfLok1XMf+SlQNjbPYGN3N8X4VxG7Tq+I0H5E=;
        b=f5kOy0vUn/4MF4thHGH3a50K1R+28S1N9pgnQY4Kj11LD6b4TaRvSSDKwWwW0b5ntk
         MfdupTyaa36RcCmQakJJL/EDURpVEx4n+CdFfsA9amnM0sTnMuLBlq0eyzC21r/ExXPG
         y1BauLPPkrM4BKcYrmmHQFIzP0dmNaYWyjLnBZcdEeZZdN5NWRtPdY4/UEjrF4P+UX+v
         QdyYHp1EOZWSylDmPPSa9GRIu0oRDQxaf4zMyCRqFju+vCveKAAP9YqK9tihnX6WKTxs
         EFyvUrMHBBPvzI+gWdi8s92QFa8nFqwdLPkUOowLujK/f+W544qlB1ACxqZP8W04ZJTN
         2dIw==
X-Gm-Message-State: AHQUAuavRoSjCqD3UFZ30bm08dPg7lskAqCMHnsrIWo6ZL8UBhbBHAlc
        7Zwp04TSiVKkFXU01mWlMgHwGKy2
X-Google-Smtp-Source: AHgI3IbOSWz95AqJbyFlwkqyMHq48zdF4nk74Oktg/Rujj26+VluwykTWWOejKmGQesePnss5hPi4g==
X-Received: by 2002:a17:902:aa01:: with SMTP id be1mr315854plb.60.1549919900159;
        Mon, 11 Feb 2019 13:18:20 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id 24sm15213029pfr.75.2019.02.11.13.18.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 13:18:19 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        linux-kernel@vger.kernel.org (open list),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE),
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next 2/3] rocker: Remove getting PORT_BRIDGE_FLAGS
Date:   Mon, 11 Feb 2019 13:17:48 -0800
Message-Id: <20190211211749.19847-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190211211749.19847-1-f.fainelli@gmail.com>
References: <20190211211749.19847-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no code that attempts to get the
SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS attribute, remove support for that.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/rocker/rocker.h       |  2 --
 drivers/net/ethernet/rocker/rocker_main.c  | 15 ---------------
 drivers/net/ethernet/rocker/rocker_ofdpa.c | 10 ----------
 3 files changed, 27 deletions(-)

diff --git a/drivers/net/ethernet/rocker/rocker.h b/drivers/net/ethernet/rocker/rocker.h
index 748fb12260a6..2b2e1c4f0dc3 100644
--- a/drivers/net/ethernet/rocker/rocker.h
+++ b/drivers/net/ethernet/rocker/rocker.h
@@ -109,8 +109,6 @@ struct rocker_world_ops {
 	int (*port_attr_bridge_flags_set)(struct rocker_port *rocker_port,
 					  unsigned long brport_flags,
 					  struct switchdev_trans *trans);
-	int (*port_attr_bridge_flags_get)(const struct rocker_port *rocker_port,
-					  unsigned long *p_brport_flags);
 	int (*port_attr_bridge_flags_support_get)(const struct rocker_port *
 						  rocker_port,
 						  unsigned long *
diff --git a/drivers/net/ethernet/rocker/rocker_main.c b/drivers/net/ethernet/rocker/rocker_main.c
index 66f72f8c46e5..5ce8d5aba603 100644
--- a/drivers/net/ethernet/rocker/rocker_main.c
+++ b/drivers/net/ethernet/rocker/rocker_main.c
@@ -1582,17 +1582,6 @@ rocker_world_port_attr_bridge_flags_set(struct rocker_port *rocker_port,
 						trans);
 }
 
-static int
-rocker_world_port_attr_bridge_flags_get(const struct rocker_port *rocker_port,
-					unsigned long *p_brport_flags)
-{
-	struct rocker_world_ops *wops = rocker_port->rocker->wops;
-
-	if (!wops->port_attr_bridge_flags_get)
-		return -EOPNOTSUPP;
-	return wops->port_attr_bridge_flags_get(rocker_port, p_brport_flags);
-}
-
 static int
 rocker_world_port_attr_bridge_flags_support_get(const struct rocker_port *
 						rocker_port,
@@ -2061,10 +2050,6 @@ static int rocker_port_attr_get(struct net_device *dev,
 	int err = 0;
 
 	switch (attr->id) {
-	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS:
-		err = rocker_world_port_attr_bridge_flags_get(rocker_port,
-							      &attr->u.brport_flags);
-		break;
 	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT:
 		err = rocker_world_port_attr_bridge_flags_support_get(rocker_port,
 								      &attr->u.brport_flags_support);
diff --git a/drivers/net/ethernet/rocker/rocker_ofdpa.c b/drivers/net/ethernet/rocker/rocker_ofdpa.c
index bea7895930f6..9c07f6040720 100644
--- a/drivers/net/ethernet/rocker/rocker_ofdpa.c
+++ b/drivers/net/ethernet/rocker/rocker_ofdpa.c
@@ -2511,16 +2511,6 @@ static int ofdpa_port_attr_bridge_flags_set(struct rocker_port *rocker_port,
 	return err;
 }
 
-static int
-ofdpa_port_attr_bridge_flags_get(const struct rocker_port *rocker_port,
-				 unsigned long *p_brport_flags)
-{
-	const struct ofdpa_port *ofdpa_port = rocker_port->wpriv;
-
-	*p_brport_flags = ofdpa_port->brport_flags;
-	return 0;
-}
-
 static int
 ofdpa_port_attr_bridge_flags_support_get(const struct rocker_port *
 					 rocker_port,
-- 
2.17.1

