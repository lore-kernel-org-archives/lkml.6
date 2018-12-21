Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DFFBC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 21:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F0D421920
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 21:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390610AbeLUVlV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 16:41:21 -0500
Received: from gateway21.websitewelcome.com ([192.185.45.2]:35457 "EHLO
        gateway21.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388574AbeLUVlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 16:41:20 -0500
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway21.websitewelcome.com (Postfix) with ESMTP id AE33A400C452F
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 15:41:19 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id aSXngsjiw2PzOaSXngcMne; Fri, 21 Dec 2018 15:41:19 -0600
X-Authority-Reason: nr=8
Received: from [189.250.106.44] (port=35208 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1gaSXn-000bw3-27; Fri, 21 Dec 2018 15:41:19 -0600
Date:   Fri, 21 Dec 2018 15:41:17 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Remi Denis-Courmont <courmisch@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] phonet: af_phonet: Fix Spectre v1 vulnerability
Message-ID: <20181221214117.GA1539@embeddedor>
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
X-Exim-ID: 1gaSXn-000bw3-27
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.106.44]:35208
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 10
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

protocol is indirectly controlled by user-space, hence leading to
a potential exploitation of the Spectre variant 1 vulnerability.

This issue was detected with the help of Smatch:

net/phonet/af_phonet.c:48 phonet_proto_get() warn: potential spectre issue 'proto_tab' [w] (local cap)

Fix this by sanitizing protocol before using it to index proto_tab.

Notice that given that speculation windows are large, the policy is
to kill the speculation on the first load and not worry if it can be
completed with a dependent load/store [1].

[1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 net/phonet/af_phonet.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/phonet/af_phonet.c b/net/phonet/af_phonet.c
index 3b0ef691f5b1..d4b2abd78858 100644
--- a/net/phonet/af_phonet.c
+++ b/net/phonet/af_phonet.c
@@ -34,6 +34,8 @@
 #include <net/phonet/phonet.h>
 #include <net/phonet/pn_dev.h>
 
+#include <linux/nospec.h>
+
 /* Transport protocol registration */
 static const struct phonet_protocol *proto_tab[PHONET_NPROTO] __read_mostly;
 
@@ -43,6 +45,7 @@ static const struct phonet_protocol *phonet_proto_get(unsigned int protocol)
 
 	if (protocol >= PHONET_NPROTO)
 		return NULL;
+	protocol = array_index_nospec(protocol, PHONET_NPROTO);
 
 	rcu_read_lock();
 	pp = rcu_dereference(proto_tab[protocol]);
-- 
2.20.1

