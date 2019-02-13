Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF158C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA8CD222CC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 22:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GEvgGTcZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437030AbfBMWHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 17:07:46 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38790 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730382AbfBMWHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 17:07:43 -0500
Received: by mail-pl1-f193.google.com with SMTP id e5so1877908plb.5;
        Wed, 13 Feb 2019 14:07:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/FNSaCPkNb/ATQEB/CndFveaqB+F4uCmwJCbnMmSO6Y=;
        b=GEvgGTcZLNMZ5vvQeqU/k8nRu5G+1FWJyGtVUNNs73ELZjVy1d4zrlIHNw6Nnnesup
         rq00QhhI5fbhL3Y60R4eJjPe/fYHn0DlBi5jyYTXfWXw58NHOF2Y9g7xmlmStNJ5EX7E
         TKVk2Of6QjynIJblOeoQTgGiDFEQwHJgiSYN7L5FDUMg4qVOQZrRnOzNcJbW8Affnv5d
         893XIuI+5unQ/6y1+XodepjRdfhGNkT+qb/lb9kktI/PZ72zzEFrmtgZ2lvlVv4HtZMY
         RAqGhO/tRCH1wr/GSFWpHxuJ7rRLdvoWFJIBW0TeRbAsvzmvzeQ5kEU85/z56/YZd/fF
         GxoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/FNSaCPkNb/ATQEB/CndFveaqB+F4uCmwJCbnMmSO6Y=;
        b=NGzzYRGVYUhfu+RRolNq9xV3vDWpnHwOejWscy+j/Pi/KB2TiK0RD6ANsj/WNI0D4H
         LplZsna6pM/kvjavpzOQzNWS7WRroU1B1jjBz6bHuJQyMirSQrr6AYFx9MGICOqU/0sv
         lvDsMT5A4RttbqIn1wQCURTikyfut0Yk+XZjz74N0ScfkHT8URLcyTFN+ruC4ia9NbLI
         u6Jm3sNhqNYCeoIjCVK2sh/4qAA+o4G+kl70PymArIgWgG5vUIKGVLCitnq7eDctidRb
         3HSTijtkSGxcbRJQR+qPQb8cwza8w7XeXnsyyuBYrjcBSs11szufBJBz2uBcemRiDs36
         GDXw==
X-Gm-Message-State: AHQUAubdsMKgnGhtLWNX+1ACCS1U3uWkAAFPnoUvkifcsAOy7B63q25I
        71biWvMVMLINchidjFW1YooIJJMr
X-Google-Smtp-Source: AHgI3Ia8HnG0LE9hfYxaNbSSzCmSw9E9L3ZRjWlQPCsLoco0kl3amHHIXCYwU0vSJrS6fCxHHW2YyQ==
X-Received: by 2002:a17:902:15a8:: with SMTP id m37mr420819pla.129.1550095662182;
        Wed, 13 Feb 2019 14:07:42 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id o1sm383735pgn.63.2019.02.13.14.07.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Feb 2019 14:07:41 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        linux-kernel@vger.kernel.org (open list),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE),
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next 7/9] net: bridge: Stop calling switchdev_port_attr_get()
Date:   Wed, 13 Feb 2019 14:06:36 -0800
Message-Id: <20190213220638.1552-8-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190213220638.1552-1-f.fainelli@gmail.com>
References: <20190213220638.1552-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that all switchdev drivers have been converted to checking the
bridge port flags during the prepare phase of the
switchdev_port_attr_set() when the process
SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS, we can avoid calling
switchdev_port_attr_get() with
SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 net/bridge/br_switchdev.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index db9e8ab96d48..8f88f8a1a7fa 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -64,29 +64,27 @@ int br_switchdev_set_port_flag(struct net_bridge_port *p,
 {
 	struct switchdev_attr attr = {
 		.orig_dev = p->dev,
-		.id = SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT,
+		.id = SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS,
+		.u.brport_flags = flags,
 	};
 	int err;
 
 	if (mask & ~BR_PORT_FLAGS_HW_OFFLOAD)
 		return 0;
 
-	err = switchdev_port_attr_get(p->dev, &attr);
-	if (err == -EOPNOTSUPP)
-		return 0;
-	if (err)
+	err = switchdev_port_attr_set(p->dev, &attr);
+	if (err && err != -EOPNOTSUPP)
 		return err;
 
-	/* Check if specific bridge flag attribute offload is supported */
-	if (!(attr.u.brport_flags_support & mask)) {
+	if (err == -EOPNOTSUPP) {
 		br_warn(p->br, "bridge flag offload is not supported %u(%s)\n",
 			(unsigned int)p->port_no, p->dev->name);
-		return -EOPNOTSUPP;
+		return err;
 	}
 
 	attr.id = SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS;
 	attr.flags = SWITCHDEV_F_DEFER;
-	attr.u.brport_flags = flags;
+
 	err = switchdev_port_attr_set(p->dev, &attr);
 	if (err) {
 		br_warn(p->br, "error setting offload flag on port %u(%s)\n",
-- 
2.17.1

