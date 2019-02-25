Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7684BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 07:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 469D72087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 07:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbfBYHWY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 02:22:24 -0500
Received: from out1.zte.com.cn ([202.103.147.172]:58294 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728217AbfBYHWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 02:22:23 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id CDD63786DFFC7970AD9B;
        Mon, 25 Feb 2019 15:22:17 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id x1P7M4rn029616;
        Mon, 25 Feb 2019 15:22:04 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019022515221065-1608662 ;
          Mon, 25 Feb 2019 15:22:10 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     andrew@lunn.ch
Cc:     vivien.didelot@gmail.com, f.fainelli@gmail.com,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, wang.yi59@zte.com.cn,
        Wen Yang <wen.yang99@zte.com.cn>
Subject: [PATCH v2] net: dsa: fix a leaked reference by adding missing of_node_put
Date:   Mon, 25 Feb 2019 15:22:19 +0800
Message-Id: <1551079339-30270-1-git-send-email-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-02-25 15:22:10,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-02-25 15:22:05,
        Serialize complete at 2019-02-25 15:22:05
X-MAIL: mse01.zte.com.cn x1P7M4rn029616
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The call to of_parse_phandle returns a node pointer with refcount
incremented thus it must be explicitly decremented after the last
usage.

Detected by coccinelle with the following warnings:
./net/dsa/port.c:294:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 284, but without a corresponding object release within this function.
./net/dsa/dsa2.c:627:3-9: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 618, but without a corresponding object release within this function.
./net/dsa/dsa2.c:630:3-9: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 618, but without a corresponding object release within this function.
./net/dsa/dsa2.c:636:3-9: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 618, but without a corresponding object release within this function.
./net/dsa/dsa2.c:639:1-7: ERROR: missing of_node_put; acquired a node pointer with refcount incremented on line 618, but without a corresponding object release within this function.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Reviewed-by: Vivien Didelot <vivien.didelot@gmail.com>
Reviewed-by: "David S. Miller" <davem@davemloft.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Vivien Didelot <vivien.didelot@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Vivien Didelot <vivien.didelot@gmail.com>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
v2->v1: preserve the reverse christmas tree ordering of variables.

 net/dsa/dsa2.c | 16 ++++++++++------
 net/dsa/port.c |  1 +
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/net/dsa/dsa2.c b/net/dsa/dsa2.c
index 8c431e0..c00ee464 100644
--- a/net/dsa/dsa2.c
+++ b/net/dsa/dsa2.c
@@ -612,8 +612,8 @@ static int dsa_switch_parse_ports_of(struct dsa_switch *ds,
 {
 	struct device_node *ports, *port;
 	struct dsa_port *dp;
+	int err = 0;
 	u32 reg;
-	int err;
 
 	ports = of_get_child_by_name(dn, "ports");
 	if (!ports) {
@@ -624,19 +624,23 @@ static int dsa_switch_parse_ports_of(struct dsa_switch *ds,
 	for_each_available_child_of_node(ports, port) {
 		err = of_property_read_u32(port, "reg", &reg);
 		if (err)
-			return err;
+			goto out_put_node;
 
-		if (reg >= ds->num_ports)
-			return -EINVAL;
+		if (reg >= ds->num_ports) {
+			err = -EINVAL;
+			goto out_put_node;
+		}
 
 		dp = &ds->ports[reg];
 
 		err = dsa_port_parse_of(dp, port);
 		if (err)
-			return err;
+			goto out_put_node;
 	}
 
-	return 0;
+out_put_node:
+	of_node_put(ports);
+	return err;
 }
 
 static int dsa_switch_parse_member_of(struct dsa_switch *ds,
diff --git a/net/dsa/port.c b/net/dsa/port.c
index 2d7e01b..a6d9a04 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -291,6 +291,7 @@ static struct phy_device *dsa_port_get_phy_device(struct dsa_port *dp)
 		return ERR_PTR(-EPROBE_DEFER);
 	}
 
+	of_node_put(phy_dn);
 	return phydev;
 }
 
-- 
2.9.5

