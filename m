Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12380C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 22:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC676206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 22:28:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbeL1W20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 17:28:26 -0500
Received: from smtp04.smtpout.orange.fr ([80.12.242.126]:58779 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727226AbeL1W20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 17:28:26 -0500
Received: from localhost.localdomain ([90.126.241.217])
        by mwinf5d07 with ME
        id HaUM1z00F4i89ZE03aUNTG; Fri, 28 Dec 2018 23:28:24 +0100
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 28 Dec 2018 23:28:24 +0100
X-ME-IP: 90.126.241.217
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        sd@queasysnail.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] net/ipv6: Fix a test against 'ipv6_find_idev()' return value
Date:   Fri, 28 Dec 2018 23:28:21 +0100
Message-Id: <20181228222821.20332-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'ipv6_find_idev()' returns NULL on error, not an error pointer.
Update the test accordingly and return -ENOBUFS, as already done in
'addrconf_add_dev()', if NULL is returned.

Fixes: ("ipv6: allow userspace to add IFA_F_OPTIMISTIC addresses")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 net/ipv6/addrconf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 521e471f1cf9..8eeec6eb2bd3 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -4736,8 +4736,8 @@ inet6_rtm_newaddr(struct sk_buff *skb, struct nlmsghdr *nlh,
 			 IFA_F_MCAUTOJOIN | IFA_F_OPTIMISTIC;
 
 	idev = ipv6_find_idev(dev);
-	if (IS_ERR(idev))
-		return PTR_ERR(idev);
+	if (!idev)
+		return -ENOBUFS;
 
 	if (!ipv6_allow_optimistic_dad(net, idev))
 		cfg.ifa_flags &= ~IFA_F_OPTIMISTIC;
-- 
2.19.1

