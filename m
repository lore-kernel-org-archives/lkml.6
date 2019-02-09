Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18DCEC169C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D759420821
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uy0SlXix"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbfBIAdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 19:33:38 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33697 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbfBIAdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 19:33:35 -0500
Received: by mail-pf1-f196.google.com with SMTP id c123so2453618pfb.0;
        Fri, 08 Feb 2019 16:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LbBXhe3YkkTyT7Tr9D7509SAnLlS8iTnmbaYese6GGQ=;
        b=Uy0SlXixSzeXW1dYz9yZnTMGZe3d+RWHPVE04Cr0FMGrgXFOuOFrC6lpuR239VLFP9
         79Ji2CxoL/btfxkjmVuSaaglpEWYyLCHqE2zyecVm4KkLsdzoy4poJbWZP1TxThNHzkw
         TiM19BNzmULTgsm3qH7ZT+ID79TMPysVrJIrwlfkHW+huqRguWe0sIM8G/Ea7SqpPsPk
         YNQuvAhmgD8AEkqTlWqYtt2EH7DElYG0L0OPWA22MZyElhTF/eolEpaqXrFJAPZ/6z99
         M0gXKxAg7hxnKBh1PRiWPuH+lvNxKdw7F+5YC5mIQqGELCUDbdKlSf8+a9zAuz5wzc/5
         IQew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LbBXhe3YkkTyT7Tr9D7509SAnLlS8iTnmbaYese6GGQ=;
        b=eCkinfczGvpfJvzEEQkMSjSAflFOh1vAdXNxhIOcQnuaLodrxZOQEGNNBAIgbiFocZ
         r+N50hawdQn/HOOWk90H1M26AHnk/L2xSreYYSpQjKy3ZKBtTY+6YGE1CZRG8zk+6diE
         Jo1dshJaZ7ntjNxyi3fIIMPJk3oAcd5if1rEFD5VuEYiBenF/1Ae2KUYUIre5zEB2nVl
         Rdz2cUKhETi6pWCULDk4lZGgtHOFgxkCW3UI5lIxi+uSkzm7IAPSf1WiGkpCa016pZbh
         a6dLpJazkVRUvPvP4uGo8se93C154TU1qFrOQdjMRtq6GvVhf2zSxX7TkO3uQgS4iklh
         MuAw==
X-Gm-Message-State: AHQUAuZo0N/KdeXbjoQlOMtBj/ofCwlfw1qRCGp9qc7m3c9JlKLZelrd
        5BbMcXbagKgQuud8gPvm0ooBUATA
X-Google-Smtp-Source: AHgI3IYlxW+db6BZ0P28zI8qiH5UqsaIvDUB7G09CanTmfNGOIQSEi2AxPGScR+D48qINvo5ELfz4Q==
X-Received: by 2002:a63:e545:: with SMTP id z5mr23317798pgj.195.1549672414229;
        Fri, 08 Feb 2019 16:33:34 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id i71sm372491pfi.170.2019.02.08.16.33.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 16:33:33 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        linux-kernel@vger.kernel.org (open list),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE),
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next 06/16] net: bridge: Stop calling switchdev_port_attr_get()
Date:   Fri,  8 Feb 2019 16:32:38 -0800
Message-Id: <20190209003248.31088-7-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190209003248.31088-1-f.fainelli@gmail.com>
References: <20190209003248.31088-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that all switchdev drivers have been converted to checking the
bridge port flags during the prepare phase of the
switchdev_port_attr_set(), we can move straight to trying to set the
desired flag through SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 net/bridge/br_switchdev.c | 20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index db9e8ab96d48..939f300522c5 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -64,29 +64,15 @@ int br_switchdev_set_port_flag(struct net_bridge_port *p,
 {
 	struct switchdev_attr attr = {
 		.orig_dev = p->dev,
-		.id = SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT,
+		.id = SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS,
+		.flags = SWITCHDEV_F_DEFER,
+		.u.brport_flags = flags,
 	};
 	int err;
 
 	if (mask & ~BR_PORT_FLAGS_HW_OFFLOAD)
 		return 0;
 
-	err = switchdev_port_attr_get(p->dev, &attr);
-	if (err == -EOPNOTSUPP)
-		return 0;
-	if (err)
-		return err;
-
-	/* Check if specific bridge flag attribute offload is supported */
-	if (!(attr.u.brport_flags_support & mask)) {
-		br_warn(p->br, "bridge flag offload is not supported %u(%s)\n",
-			(unsigned int)p->port_no, p->dev->name);
-		return -EOPNOTSUPP;
-	}
-
-	attr.id = SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS;
-	attr.flags = SWITCHDEV_F_DEFER;
-	attr.u.brport_flags = flags;
 	err = switchdev_port_attr_set(p->dev, &attr);
 	if (err) {
 		br_warn(p->br, "error setting offload flag on port %u(%s)\n",
-- 
2.17.1

