Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 201C4C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 23:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1D6E2073D
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 23:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XxKsW2tY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728574AbfBEXzz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 18:55:55 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33621 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728315AbfBEXzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 18:55:51 -0500
Received: by mail-pl1-f196.google.com with SMTP id z23so2276363plo.0;
        Tue, 05 Feb 2019 15:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RNI+XdPhvdY1OjXcP7pgSSgHAFM8lKWzobqUPPNGsDM=;
        b=XxKsW2tYBDWt1KqZFOfr9sxzCsiU2/h83p8XGxW2ixfxvP+GywHk6XCDwLV55DOecK
         XsFp2f2dl+hNMLrpXtkE5TTr9Az8KoId/ujtO6Hj+IejX6WBh7fnQOmPiRsku++TY/Kz
         S6xfnipw83IGvodd3ht/jFzbEaKd3rxgrQixKrlsrA55k0V9VmQdakICWem+zjXRoEJt
         iOVxrbDCgZzoe0Akd/kD3rMfsSDhuk9xYhVnaJ/UTTXrhQoeqchK+ziDvBv6TIV+s5/A
         gI+9q6FS1+ddQa45UI3D/I9hPf9kUEl/WMH2k1I3tVIR5R1jrsZX4jN29xqHbzQ4L6+G
         HLxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RNI+XdPhvdY1OjXcP7pgSSgHAFM8lKWzobqUPPNGsDM=;
        b=aeQ9OP6i4Pu/R50QzmAKEuXdeln8CZpxqBzs5OjI+tH5fIZtBo0jK4bNPtMyiPwJPH
         CLCDjZfqUh84vNgzhzcorgUxi3IyhLezzFufgifXpzRoSEYJjh85q9vGO/Zegsn0R5F2
         FNRke8bWHsdt9SI/9uPsrMoHIIm0gFFkyxyCnstWm29M/dRJbK88KGoPidEjRr1XtGgm
         tyylKpNkM8WVJWyn8KCo9yMsoY2tSdPrUNa/2k9W0LtORLEaJh5b3YYC/YL5s/lVJH6h
         OdglQ4W1E0WwfDXmuu4noKdcJofhvO3JDl6uybrtHT/i8eLPjqvI3mXrZZGjokhNmXok
         XekQ==
X-Gm-Message-State: AHQUAubg0D2Deegl52ai7dodHD9MhN/v+Qwled5vBm0HS/sVVsP0e199
        74V23PSggULjSD7Jbt5xcnNU4BYW
X-Google-Smtp-Source: AHgI3Ib/e8F0w6fnGkfWz9Pt0u+wz9JA1h6FkZvlkETiZlyUctLoMckwrQBOKDSf+X13MuascrLDKA==
X-Received: by 2002:a17:902:e78e:: with SMTP id cp14mr7709062plb.4.1549410950116;
        Tue, 05 Feb 2019 15:55:50 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id v184sm6770197pfb.182.2019.02.05.15.55.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 15:55:49 -0800 (PST)
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
Subject: [PATCH net-next v3 06/12] mscc: ocelot: Implement ndo_get_port_parent_id()
Date:   Tue,  5 Feb 2019 15:53:20 -0800
Message-Id: <20190205235326.14600-7-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190205235326.14600-1-f.fainelli@gmail.com>
References: <20190205235326.14600-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ocelot only supports SWITCHDEV_ATTR_ID_PORT_PARENT_ID as a valid
switchdev attribute getter, convert it to use ndo_get_port_parent_id()
and get rid of the switchdev_ops::switchdev_port_attr_get altogether.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/mscc/ocelot.c | 33 ++++++++++++------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/mscc/ocelot.c b/drivers/net/ethernet/mscc/ocelot.c
index c6a575eb0ff5..195306d05bcd 100644
--- a/drivers/net/ethernet/mscc/ocelot.c
+++ b/drivers/net/ethernet/mscc/ocelot.c
@@ -916,6 +916,18 @@ static int ocelot_set_features(struct net_device *dev,
 	return 0;
 }
 
+static int ocelot_get_port_parent_id(struct net_device *dev,
+				     struct netdev_phys_item_id *ppid)
+{
+	struct ocelot_port *ocelot_port = netdev_priv(dev);
+	struct ocelot *ocelot = ocelot_port->ocelot;
+
+	ppid->id_len = sizeof(ocelot->base_mac);
+	memcpy(&ppid->id, &ocelot->base_mac, ppid->id_len);
+
+	return 0;
+}
+
 static const struct net_device_ops ocelot_port_netdev_ops = {
 	.ndo_open			= ocelot_port_open,
 	.ndo_stop			= ocelot_port_stop,
@@ -930,6 +942,7 @@ static const struct net_device_ops ocelot_port_netdev_ops = {
 	.ndo_vlan_rx_add_vid		= ocelot_vlan_rx_add_vid,
 	.ndo_vlan_rx_kill_vid		= ocelot_vlan_rx_kill_vid,
 	.ndo_set_features		= ocelot_set_features,
+	.ndo_get_port_parent_id		= ocelot_get_port_parent_id,
 };
 
 static void ocelot_get_strings(struct net_device *netdev, u32 sset, u8 *data)
@@ -1013,25 +1026,6 @@ static const struct ethtool_ops ocelot_ethtool_ops = {
 	.set_link_ksettings	= phy_ethtool_set_link_ksettings,
 };
 
-static int ocelot_port_attr_get(struct net_device *dev,
-				struct switchdev_attr *attr)
-{
-	struct ocelot_port *ocelot_port = netdev_priv(dev);
-	struct ocelot *ocelot = ocelot_port->ocelot;
-
-	switch (attr->id) {
-	case SWITCHDEV_ATTR_ID_PORT_PARENT_ID:
-		attr->u.ppid.id_len = sizeof(ocelot->base_mac);
-		memcpy(&attr->u.ppid.id, &ocelot->base_mac,
-		       attr->u.ppid.id_len);
-		break;
-	default:
-		return -EOPNOTSUPP;
-	}
-
-	return 0;
-}
-
 static int ocelot_port_attr_stp_state_set(struct ocelot_port *ocelot_port,
 					  struct switchdev_trans *trans,
 					  u8 state)
@@ -1331,7 +1325,6 @@ static int ocelot_port_obj_del(struct net_device *dev,
 }
 
 static const struct switchdev_ops ocelot_port_switchdev_ops = {
-	.switchdev_port_attr_get	= ocelot_port_attr_get,
 	.switchdev_port_attr_set	= ocelot_port_attr_set,
 };
 
-- 
2.17.1

