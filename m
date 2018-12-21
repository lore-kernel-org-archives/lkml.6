Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E8CCC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 21:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6225B21927
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 21:47:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392041AbeLUVrA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 16:47:00 -0500
Received: from gateway20.websitewelcome.com ([192.185.67.41]:46378 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730243AbeLUVq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 16:46:59 -0500
X-Greylist: delayed 1468 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Dec 2018 16:46:59 EST
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id 7B87C400C593A
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 15:22:30 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id aSFagRgNdYTGMaSFagGcAW; Fri, 21 Dec 2018 15:22:30 -0600
X-Authority-Reason: nr=8
Received: from [189.250.106.44] (port=34474 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gaSFZ-000Qlq-PT; Fri, 21 Dec 2018 15:22:29 -0600
Date:   Fri, 21 Dec 2018 15:22:29 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>
Cc:     linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] can: af_can: Fix Spectre v1 vulnerability
Message-ID: <20181221212229.GA32635@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.106.44
X-Source-L: No
X-Exim-ID: 1gaSFZ-000Qlq-PT
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.106.44]:34474
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 6
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

protocol is indirectly controlled by user-space, hence leading to
a potential exploitation of the Spectre variant 1 vulnerability.

This issue was detected with the help of Smatch:

net/can/af_can.c:115 can_get_proto() warn: potential spectre issue 'proto_tab' [w]

Fix this by sanitizing protocol before using it to index proto_tab.

Notice that given that speculation windows are large, the policy is
to kill the speculation on the first load and not worry if it can be
completed with a dependent load/store [1].

[1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 net/can/af_can.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/can/af_can.c b/net/can/af_can.c
index 1684ba5b51eb..cade7250c6d4 100644
--- a/net/can/af_can.c
+++ b/net/can/af_can.c
@@ -59,6 +59,7 @@
 #include <linux/can/core.h>
 #include <linux/can/skb.h>
 #include <linux/ratelimit.h>
+#include <linux/nospec.h>
 #include <net/net_namespace.h>
 #include <net/sock.h>
 
@@ -136,6 +137,7 @@ static int can_create(struct net *net, struct socket *sock, int protocol,
 
 	if (protocol < 0 || protocol >= CAN_NPROTO)
 		return -EINVAL;
+	protocol = array_index_nospec(protocol, CAN_NPROTO);
 
 	cp = can_get_proto(protocol);
 
-- 
2.20.1

