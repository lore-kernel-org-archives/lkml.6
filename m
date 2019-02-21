Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74AD8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 00:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40F632084F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 00:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="txh9ImLw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbfBUA7C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 19:59:02 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37765 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbfBUA7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 19:59:01 -0500
Received: by mail-pl1-f193.google.com with SMTP id q3so5812493pll.4;
        Wed, 20 Feb 2019 16:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=l46VvHT7eqrMkE6E40frKPiWzb4eR8K705HCwYquJCU=;
        b=txh9ImLwOaMk2Pj6TsIYFuyxEpUJqVwgwNymksKWtPWisIJo2EiDoRKdrew+nKzHNe
         PTAz+ddwdXucDqiIBxUrJ0sc70xW6LOifRCyznfbhJGZeQ2mo4zGhbrQSkZPNHdip7WN
         l5uHQT+VJGmWm/gUwO8v7jRroVFoe6C1t4m5IP4AUqqocUPP+cW4EmpadcUIvS8/6AQ7
         t99n36Yvjx8Zbh8yIIkWBKvcgFkiK09KpgbH/iF5KlD/Ndac++AIG2wQCCEo8NjoyUag
         /rXTlITaLmSZrnaXrahsWpLrwdn5Whhop+Pv80iZ/6jWN2ujAnXh88N84GRlid2jSZxU
         Mu5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=l46VvHT7eqrMkE6E40frKPiWzb4eR8K705HCwYquJCU=;
        b=dXiQMS48tx5V8zVpvnzuX+mpc/RpjKRPpAeQwBQsO12kBGT4HLUUfbsQ2eOiu+EG+0
         g0LctSZ0DT40FCXKti7e1Kt0/VTHBI65C2n0VAk6Obb/J5RGs1EiswiTnbMq/dvTPwk9
         I/PvaRdb7Ji5dfOxfSYa0k808UCB5or6u3wAhOEh1VDpCRP60AFfY81LdqtBW0WfEf0U
         1pvBmLzOxhP2ZKXNRT0PB7fQKlAJrEGhvGLzeXLkgNu4n6hu/N9V1V+GnvAsOArYDukQ
         wRtoskYNh30u/tYnWNl8eKiLV2aJ/6R8TMG67xGSdDFg1KDqxI5U6rUQZNo7/Lt+9G40
         55ow==
X-Gm-Message-State: AHQUAubdFv64G4xDeM+rcEURRMj7sFGlcEsnwGV3PSwJqlrCed1Aq9dz
        ac4gK+nkfCmr6DRz+wmrGzwOwTQw
X-Google-Smtp-Source: AHgI3IYxQ3BqReAoXqOKvaundjZ0rG8AcY2CDpqydKMqHv8SpepkPm9zdKZNTPfHpyhwy+DBK4Z1qQ==
X-Received: by 2002:a17:902:6b03:: with SMTP id o3mr39617799plk.126.1550710740732;
        Wed, 20 Feb 2019 16:59:00 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
        by smtp.gmail.com with ESMTPSA id z15sm17203255pgc.25.2019.02.20.16.58.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 16:58:59 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        linux-kernel@vger.kernel.org (open list),
        devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM),
        bridge@lists.linux-foundation.org (moderated list:ETHERNET BRIDGE),
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: [PATCH net-next v3 6/8] net: bridge: Stop calling switchdev_port_attr_get()
Date:   Wed, 20 Feb 2019 16:58:24 -0800
Message-Id: <20190221005826.26317-7-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190221005826.26317-1-f.fainelli@gmail.com>
References: <20190221005826.26317-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that all switchdev drivers have been converted to check the
SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS flags and report flags that they
do not support accordingly, we can migrate the bridge code to try to set
that attribute first, check the results and then do the actual setting.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 net/bridge/br_switchdev.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/net/bridge/br_switchdev.c b/net/bridge/br_switchdev.c
index db9e8ab96d48..af57c4a2b78a 100644
--- a/net/bridge/br_switchdev.c
+++ b/net/bridge/br_switchdev.c
@@ -64,21 +64,19 @@ int br_switchdev_set_port_flag(struct net_bridge_port *p,
 {
 	struct switchdev_attr attr = {
 		.orig_dev = p->dev,
-		.id = SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT,
+		.id = SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS,
+		.u.brport_flags = mask,
 	};
 	int err;
 
 	if (mask & ~BR_PORT_FLAGS_HW_OFFLOAD)
 		return 0;
 
-	err = switchdev_port_attr_get(p->dev, &attr);
+	err = switchdev_port_attr_set(p->dev, &attr);
 	if (err == -EOPNOTSUPP)
 		return 0;
-	if (err)
-		return err;
 
-	/* Check if specific bridge flag attribute offload is supported */
-	if (!(attr.u.brport_flags_support & mask)) {
+	if (err) {
 		br_warn(p->br, "bridge flag offload is not supported %u(%s)\n",
 			(unsigned int)p->port_no, p->dev->name);
 		return -EOPNOTSUPP;
@@ -87,6 +85,7 @@ int br_switchdev_set_port_flag(struct net_bridge_port *p,
 	attr.id = SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS;
 	attr.flags = SWITCHDEV_F_DEFER;
 	attr.u.brport_flags = flags;
+
 	err = switchdev_port_attr_set(p->dev, &attr);
 	if (err) {
 		br_warn(p->br, "error setting offload flag on port %u(%s)\n",
-- 
2.17.1

