Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A4D2C282CC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18E1C2073D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:46:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nj4KEp7H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730788AbfBFRqo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 12:46:44 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46670 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730640AbfBFRqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 12:46:22 -0500
Received: by mail-pf1-f194.google.com with SMTP id c73so3392631pfe.13;
        Wed, 06 Feb 2019 09:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FtkP+LHS9beMQbwAZ2URo6E44LQ0Jw0xcba93MNhkCA=;
        b=nj4KEp7Hvlm4gcYRmpV0S0CtNHo1iW521AHYiHGE4FzK+ksWVB5LmN6pqk5uHBXbkp
         xCwdezFfxLrf6bD0o0pugwvQWF/gHc90GLth8JABSbKLdgGjLMKNjYl/uZ2cxsF9sZ40
         scxeeMtZaAasZbiolhuZiS6/PXJWeQpLk5UTXVIAeH9Ov4bvgMhUaYoa6Ou3j+9USeOn
         x/gQMsPHOE/eA0Zp3+UL/f8KsMpQQJQOwaRVYohnC7iMMuCSaY6ANQMH7IhDe4Imcjqn
         RKTDMN3536QcF0oweIoRQRRWzO7EAhuCEvdXjuEQwVTPIqbVva3cOFU6wAOUxb2sYTAx
         BCHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FtkP+LHS9beMQbwAZ2URo6E44LQ0Jw0xcba93MNhkCA=;
        b=MLRmLUdYMnNS3/eCm65i2aRZdEaTmvK5/nUKGpa3oulFYqLuz+Es3LbXvRVdVhS7v7
         XFArpBne/BLQfrNrmH6n83NEJVX6P7ecz6OqD6gMa10O75PdsoIp4/BOKAL+Rxm83MvM
         bgSBxklmv3+TxHdv6iVitQEZw5qF4VUEXIBP/1oevzzGw271mdIXZeWY5aLLgr7kdBTF
         Qe1ABG/y5ROlIIx3ufmi4ufi3kYsqIHSA+27JSV5zmbrMP+FHL4Iu8dQKdvA/pRZr56C
         fvP5BrJ1Ri/ZDv7dwJ0vpFN4HEU+OKgLu4RTYnRm/VsuBx8YPlTkRhqhZGFuotIBrila
         9O0A==
X-Gm-Message-State: AHQUAuah7HvnbWyjkpereMMKeTRAyMj2lUAmeLnZwO9aCOWhdtLEbUxe
        WRlyAGxEfPfWbwd2wLC6htnefafS
X-Google-Smtp-Source: AHgI3IYmaErYZ/TEJjPreDxqdojdEqu6PPDQsrPAo0VEkvkzXIcFztJd31F/q0QzYKnfIcGsHkY8zg==
X-Received: by 2002:a63:e447:: with SMTP id i7mr886657pgk.273.1549475181636;
        Wed, 06 Feb 2019 09:46:21 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id 15sm10435313pfr.55.2019.02.06.09.46.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 09:46:20 -0800 (PST)
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
Subject: [PATCH net-next v4 10/12] staging: fsl-dpaa2: ethsw: Implement ndo_get_port_parent_id()
Date:   Wed,  6 Feb 2019 09:45:44 -0800
Message-Id: <20190206174546.23597-11-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190206174546.23597-1-f.fainelli@gmail.com>
References: <20190206174546.23597-1-f.fainelli@gmail.com>
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
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index daabaceeea52..e559f4c25cf7 100644
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
-- 
2.17.1

