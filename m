Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D27AC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 20:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11BFC2081F
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 20:26:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11BFC2081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sai.msu.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbeKCFe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 01:34:57 -0400
Received: from lnfm1.sai.msu.ru ([93.180.26.255]:59799 "EHLO lnfm1.sai.msu.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725728AbeKCFe5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 01:34:57 -0400
X-Greylist: delayed 7378 seconds by postgrey-1.27 at vger.kernel.org; Sat, 03 Nov 2018 01:34:56 EDT
Received: from dragon.sai.msu.ru (dragon.sai.msu.ru [93.180.26.172])
        by lnfm1.sai.msu.ru (8.14.1/8.12.8) with ESMTP id wA2IKBfD032311;
        Fri, 2 Nov 2018 21:20:16 +0300
Received: from alpha.local (unknown [92.243.181.209])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by dragon.sai.msu.ru (Postfix) with ESMTPSA id 43896D354;
        Fri,  2 Nov 2018 21:20:12 +0300 (MSK)
From:   "Matwey V. Kornilov" <matwey@sai.msu.ru>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     matwey.kornilov@gmail.com, Eric Dumazet <edumazet@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Debabrata Banerjee <dbanerje@akamai.com>,
        Dave Jones <davej@codemonkey.org.uk>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Matwey V. Kornilov" <matwey@sai.msu.ru>
Subject: [PATCH] net: core: netpoll: Enable netconsole IPv6 link local address
Date:   Fri,  2 Nov 2018 21:19:36 +0300
Message-Id: <20181102181936.26294-1-matwey@sai.msu.ru>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no reason to discard using source link local address when
remote netconsole IPv6 address is set to be link local one.

The patch allows administrators to use IPv6 netconsole without
explicitly configuring source address:

    netconsole=@/,@fe80::5054:ff:fe2f:6012/

Signed-off-by: Matwey V. Kornilov <matwey@sai.msu.ru>
---
 net/core/netpoll.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index 5da9552b186b..2b9fdbc43205 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -717,7 +717,8 @@ int netpoll_setup(struct netpoll *np)
 
 				read_lock_bh(&idev->lock);
 				list_for_each_entry(ifp, &idev->addr_list, if_list) {
-					if (ipv6_addr_type(&ifp->addr) & IPV6_ADDR_LINKLOCAL)
+					if (!!(ipv6_addr_type(&ifp->addr) & IPV6_ADDR_LINKLOCAL) !=
+					    !!(ipv6_addr_type(&np->remote_ip.in6) & IPV6_ADDR_LINKLOCAL))
 						continue;
 					np->local_ip.in6 = ifp->addr;
 					err = 0;
-- 
2.16.4

