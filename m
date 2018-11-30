Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D17C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 06:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 434CB2146D
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 06:57:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 434CB2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbeK3SFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 13:05:50 -0500
Received: from mxhk.zte.com.cn ([63.217.80.70]:45350 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726826AbeK3SFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 13:05:49 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id 31C33D718A6C74EAF65A;
        Fri, 30 Nov 2018 14:57:30 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id wAU6vKDZ086462;
        Fri, 30 Nov 2018 14:57:20 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from localhost.localdomain ([10.75.9.60])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2018113014575815-13904801 ;
          Fri, 30 Nov 2018 14:57:58 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     mareklindner@neomailbox.ch, sw@simonwunderlich.de, a@unstable.cc,
        davem@davemloft.net
Cc:     netdev@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org,
        linux-kernel@vger.kernel.org, zhong.weidong@zte.com.cn,
        wen.yang99@zte.com.cn
Subject: [PATCH] batman-adv: fix null pointer dereference in batadv_gw_election
Date:   Fri, 30 Nov 2018 15:00:02 +0800
Message-Id: <1543561202-614-1-git-send-email-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2018-11-30 14:57:58,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2018-11-30 14:57:04,
        Serialize complete at 2018-11-30 14:57:04
X-MAIL: mse01.zte.com.cn wAU6vKDZ086462
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a possible null pointer dereference in
batadv_gw_election, detected by the semantic patch
deref_null.cocci, with the following warning:

./net/batman-adv/gateway_client.c:289:15-24: ERROR: next_gw is NULL but dereferenced.
./net/batman-adv/gateway_client.c:290:15-29: ERROR: next_gw is NULL but dereferenced.
./net/batman-adv/gateway_client.c:291:15-29: ERROR: next_gw is NULL but dereferenced.
./net/batman-adv/gateway_client.c:292:15-27: ERROR: next_gw is NULL but dereferenced.
./net/batman-adv/gateway_client.c:293:15-27: ERROR: next_gw is NULL but dereferenced.

Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Reviewed-by: Tan Hu <tan.hu@zte.com.cn>
---
 net/batman-adv/gateway_client.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/net/batman-adv/gateway_client.c b/net/batman-adv/gateway_client.c
index 140c61a..d80ef1c 100644
--- a/net/batman-adv/gateway_client.c
+++ b/net/batman-adv/gateway_client.c
@@ -284,14 +284,16 @@ void batadv_gw_election(struct batadv_priv *bat_priv)
 		batadv_throw_uevent(bat_priv, BATADV_UEV_GW, BATADV_UEV_ADD,
 				    gw_addr);
 	} else {
-		batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
-			   "Changing route to gateway %pM (bandwidth: %u.%u/%u.%u MBit, tq: %i)\n",
-			   next_gw->orig_node->orig,
-			   next_gw->bandwidth_down / 10,
-			   next_gw->bandwidth_down % 10,
-			   next_gw->bandwidth_up / 10,
-			   next_gw->bandwidth_up % 10,
-			   router_ifinfo->bat_iv.tq_avg);
+		if (next_gw) {
+			batadv_dbg(BATADV_DBG_BATMAN, bat_priv,
+				   "Changing route to gateway %pM (bandwidth: %u.%u/%u.%u MBit, tq: %i)\n",
+				    next_gw->orig_node->orig,
+				    next_gw->bandwidth_down / 10,
+				    next_gw->bandwidth_down % 10,
+				    next_gw->bandwidth_up / 10,
+				    next_gw->bandwidth_up % 10,
+				    router_ifinfo->bat_iv.tq_avg);
+		}
 		batadv_throw_uevent(bat_priv, BATADV_UEV_GW, BATADV_UEV_CHANGE,
 				    gw_addr);
 	}
-- 
2.9.5

