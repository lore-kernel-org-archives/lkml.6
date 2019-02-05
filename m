Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA731C282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A40012054F
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oZ8oOR3M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730659AbfBEWOS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 17:14:18 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37191 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730552AbfBEWNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 17:13:54 -0500
Received: by mail-ed1-f65.google.com with SMTP id h15so4282563edb.4;
        Tue, 05 Feb 2019 14:13:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IMuInuNuhaKwQCdz4TCP3q6TDWOHc2cQyv/xBrmgGRc=;
        b=oZ8oOR3MNLvbmgZp8d0uiTtBjbfedppXPujVkvCG89NIX7KZ0OtsQKvreKM+xtG6Md
         IZT2BZxWk7hVDwS8pGw9h4pOOJ5RipHxAQZmk7t+TtUx8yr9/LLZwmlLhG/Pk9yEJ+Pg
         9j+XqHCaZAtzYFsJ/F4ZqesxSVa9ltwexjSPxL/sm6oqDqt03FTLnpIXhb3Tt0vibevw
         Ow/dC7oKIU7uGhn/LY+HmSNe4wd/rwajbCFZuT3xq4ZxFWGcWKpLIhYtZdC+yotZZDem
         nD6WA7pHY/XZEdO79yvaI5gaYwSth8h8uxYH3Nqczis/FYXMoM6Z7GoWXoewSwKRAoZE
         Ru4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IMuInuNuhaKwQCdz4TCP3q6TDWOHc2cQyv/xBrmgGRc=;
        b=RY+F1dbnETVEc6LBlOG7e4B2yjfo7fM5qKGDIFMOcOlRVjRFHEFavmP0SfMZ68jFpc
         cc7tD8A8uCkttd9uPgrE3HkFliXE0WRmB+hGTKIxQvVob6ME6kVowjnXSX90sYxaxGNY
         F+s9JY2uB8uN1EX/BlcNrO1Hlw2BCVLJFW1GCIPF7JnC8o70c7YF7T8ap87vbL0nvbTy
         nUws4lrTfj/fh6xtyQyNIKzZki/p8YNjwcKd1dGvUo4o2KXU5KForIIzMx4QlVtPUPnC
         mI48M65nZrAGrgrEIlJh+oNPk8xO97Laqj54tbQOcdnWD70NtZihORHMdUvAeS1k7/0I
         BTBA==
X-Gm-Message-State: AHQUAuY7/p/BXetxJ0iRACzOpcpqMRmRI3kfXe++PlsB/zZ0yancJuxS
        4aAeyzp9Gh2dbKuvh3l/cpCZlfdq
X-Google-Smtp-Source: AHgI3Ibsqx2Fwh74o/MUuNbOpMiXa3Xbd8dypG+aOnBgTC9o8rrPgRogsbvfzOmzQSiix+h//Y68ow==
X-Received: by 2002:a17:906:1350:: with SMTP id x16mr5144699ejb.85.1549404832441;
        Tue, 05 Feb 2019 14:13:52 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id x47sm5523299eda.91.2019.02.05.14.13.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 14:13:51 -0800 (PST)
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
Subject: [PATCH net-next v2 10/12] staging: fsl-dpaa2: ethsw: Implement ndo_get_port_parent_id()
Date:   Tue,  5 Feb 2019 14:13:09 -0800
Message-Id: <20190205221311.18476-11-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190205221311.18476-1-f.fainelli@gmail.com>
References: <20190205221311.18476-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ethsw implements SWITCHDEV_ATTR_ID_PORT_PARENT_ID and we want to get rid
of switchdev_ops eventually, ease that migration by implementing a
ndo_get_port_parent_id() function which returns what
switchdev_port_attr_get() would do.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index daabaceeea52..622f32377b91 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -505,6 +505,17 @@ static netdev_tx_t port_dropframe(struct sk_buff *skb,
 	return NETDEV_TX_OK;
 }
 
+static int swdev_get_port_parent_id(struct net_device *dev,
+				    struct netdev_phys_item_id *ppid)
+{
+	struct ethsw_port_priv *port_priv = netdev_priv(dev);
+
+	ppid->id_len = 1;
+	ppid->id[0] = port_priv->ethsw_data->dev_id;
+
+	return 0;
+}
+
 static const struct net_device_ops ethsw_port_ops = {
 	.ndo_open		= port_open,
 	.ndo_stop		= port_stop,
@@ -515,6 +526,7 @@ static const struct net_device_ops ethsw_port_ops = {
 	.ndo_get_offload_stats	= port_get_offload_stats,
 
 	.ndo_start_xmit		= port_dropframe,
+	.ndo_get_port_parent_id	= swdev_get_port_parent_id,
 };
 
 static void ethsw_links_state_update(struct ethsw_core *ethsw)
@@ -634,10 +646,6 @@ static int swdev_port_attr_get(struct net_device *netdev,
 	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
 
 	switch (attr->id) {
-	case SWITCHDEV_ATTR_ID_PORT_PARENT_ID:
-		attr->u.ppid.id_len = 1;
-		attr->u.ppid.id[0] = port_priv->ethsw_data->dev_id;
-		break;
 	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS:
 		attr->u.brport_flags =
 			(port_priv->ethsw_data->learning ? BR_LEARNING : 0) |
@@ -1434,7 +1442,6 @@ static int ethsw_probe_port(struct ethsw_core *ethsw, u16 port_idx)
 	SET_NETDEV_DEV(port_netdev, dev);
 	port_netdev->netdev_ops = &ethsw_port_ops;
 	port_netdev->ethtool_ops = &ethsw_port_ethtool_ops;
-	port_netdev->switchdev_ops = &ethsw_port_switchdev_ops;
 
 	/* Set MTU limits */
 	port_netdev->min_mtu = ETH_MIN_MTU;
-- 
2.17.1

