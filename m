Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90948C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:07:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 601F520842
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:07:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mKaPj6sm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404054AbfBMWHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 17:07:31 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33857 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729139AbfBMWHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 17:07:30 -0500
Received: by mail-pf1-f195.google.com with SMTP id j18so1858172pfe.1;
        Wed, 13 Feb 2019 14:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=a873itx+S/T6yC+oMc+1M1LiImcgfFyeED4oExKC26w=;
        b=mKaPj6sm8tggLzNs698hl1jZiyYmcNwQSzZ1b7TwTtX6DapyetiOaR4Azzlo9/pDDy
         yZDQ9nhhHJGcDxDqj3/f5G+EJZI4a+/2CMm+Wr+xo+6o7xvxJ0BIhjWYiXxtgvWULLXm
         HXo/x3VR04o90sr171OmGBP4/s0LyFrO0DgBYkFNdeOHLrqycgzDTGTmcUD41+OJTGYq
         uuKq2QZJQHAK9fj3spFs4fgBOxJsF8o1rim92padBvg4S7qnci7boN9mGJF/IASIv8QC
         DHmund0/LVFNKI3uOYI5V/ffOFLXykVjllaOfikCTuME3qgMdl5VbiELKNWwOpy1j3+l
         TUBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=a873itx+S/T6yC+oMc+1M1LiImcgfFyeED4oExKC26w=;
        b=GwHqeXZLSEzgDcHo764CQ/DwmDkgq4JuUPteDaSGIR28h3u9K10HrfrvlDyDQIe7EW
         apZAN48Hp4VzGUYL9tKntdug64IyBXWzUtNa1/4Rxo/1JWA2K1sRcMFjuroDMntwTiN9
         ziCXkcL2Mgw364ctl7PkL0lK7ltJDZWuqj37Vj++MRAeaJyZzGBSgZmAzJxmlsZfkwNP
         IYjDjxVZur2Gat0WG93fHOzO392up19A0FWQagp47QEqX4sxECml+onpdg/YOmPIKvrS
         U3+8S4GgPdAuGKPNJymsSdFS32tRnldNwPEwaEwr7PKVKDNNMsEmufRgH0A2pN/b0x2P
         W+zw==
X-Gm-Message-State: AHQUAua5Xbt7fxycBDtPGNVW+Gv/83rfMWK3AG7vNyHT9DFv/jhJ/wg4
        aBydjj1BUVg/1IMZtoarjGyxWpaf
X-Google-Smtp-Source: AHgI3IZgPftvOHkTK/7+kiw9jKZBsvZFVchWdXXycPQfcPxQmDP7XNRUv4gHlWpC6ffrgUtcyCa/yQ==
X-Received: by 2002:a65:41c2:: with SMTP id b2mr377141pgq.67.1550095648813;
        Wed, 13 Feb 2019 14:07:28 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id o1sm383735pgn.63.2019.02.13.14.07.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 14:07:28 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        linux-kernel@vger.kernel.org (open list),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE),
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next 4/9] staging: fsl-dpaa2: ethsw: Check bridge port flags during prepare
Date:   Wed, 13 Feb 2019 14:06:33 -0800
Message-Id: <20190213220638.1552-5-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190213220638.1552-1-f.fainelli@gmail.com>
References: <20190213220638.1552-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for removing SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT,
have ethsw check that the bridge port flags that are being set are
supported when SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS is specified.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
index 1b3943b71254..f788a9458b89 100644
--- a/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
+++ b/drivers/staging/fsl-dpaa2/ethsw/ethsw.c
@@ -668,13 +668,16 @@ static int port_attr_stp_state_set(struct net_device *netdev,
 
 static int port_attr_br_flags_set(struct net_device *netdev,
 				  struct switchdev_trans *trans,
-				  unsigned long flags)
+				  unsigned long flags, bool pre_set)
 {
 	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
 	int err = 0;
 
-	if (switchdev_trans_ph_prepare(trans))
+	if (switchdev_trans_ph_prepare(trans) && pre_set) {
+		if (flags & ~(BR_LEARNING | BR_FLOOD))
+			return -EOPNOTSUPP;
 		return 0;
+	}
 
 	/* Learning is enabled per switch */
 	err = ethsw_set_learning(port_priv->ethsw_data, flags & BR_LEARNING);
@@ -691,6 +694,7 @@ static int swdev_port_attr_set(struct net_device *netdev,
 			       const struct switchdev_attr *attr,
 			       struct switchdev_trans *trans)
 {
+	bool pre_set = false;
 	int err = 0;
 
 	switch (attr->id) {
@@ -698,9 +702,11 @@ static int swdev_port_attr_set(struct net_device *netdev,
 		err = port_attr_stp_state_set(netdev, trans,
 					      attr->u.stp_state);
 		break;
+	case SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS:
+		pre_set = true; /* fall through */
 	case SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS:
 		err = port_attr_br_flags_set(netdev, trans,
-					     attr->u.brport_flags);
+					     attr->u.brport_flags, pre_set);
 		break;
 	case SWITCHDEV_ATTR_ID_BRIDGE_VLAN_FILTERING:
 		/* VLANs are supported by default  */
-- 
2.17.1

