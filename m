Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A71D6C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6416223F9F
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 05:57:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6416223F9F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934548AbeGFF5W (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 01:57:22 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33418 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934372AbeGFFvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 01:51:37 -0400
Received: from localhost (D57D388D.static.ziggozakelijk.nl [213.125.56.141])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4234686A;
        Fri,  6 Jul 2018 05:51:36 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.14 40/61] netfilter: dont set F_IFACE on ipv6 fib lookups
Date:   Fri,  6 Jul 2018 07:47:04 +0200
Message-Id: <20180706054713.871605357@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180706054712.332416244@linuxfoundation.org>
References: <20180706054712.332416244@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

commit 47b7e7f82802dced3ac73658bf4b77584a63063f upstream.

"fib" starts to behave strangely when an ipv6 default route is
added - the FIB lookup returns a route using 'oif' in this case.

This behaviour was inherited from ip6tables rpfilter so change
this as well.

Bugzilla: https://bugzilla.netfilter.org/show_bug.cgi?id=1221
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/ipv6/netfilter/ip6t_rpfilter.c |    4 ----
 net/ipv6/netfilter/nft_fib_ipv6.c  |   12 ++----------
 2 files changed, 2 insertions(+), 14 deletions(-)

--- a/net/ipv6/netfilter/ip6t_rpfilter.c
+++ b/net/ipv6/netfilter/ip6t_rpfilter.c
@@ -48,10 +48,6 @@ static bool rpfilter_lookup_reverse6(str
 	}
 
 	fl6.flowi6_mark = flags & XT_RPFILTER_VALID_MARK ? skb->mark : 0;
-	if ((flags & XT_RPFILTER_LOOSE) == 0) {
-		fl6.flowi6_oif = dev->ifindex;
-		lookup_flags |= RT6_LOOKUP_F_IFACE;
-	}
 
 	rt = (void *) ip6_route_lookup(net, &fl6, lookup_flags);
 	if (rt->dst.error)
--- a/net/ipv6/netfilter/nft_fib_ipv6.c
+++ b/net/ipv6/netfilter/nft_fib_ipv6.c
@@ -182,7 +182,6 @@ void nft_fib6_eval(const struct nft_expr
 	}
 
 	*dest = 0;
- again:
 	rt = (void *)ip6_route_lookup(nft_net(pkt), &fl6, lookup_flags);
 	if (rt->dst.error)
 		goto put_rt_err;
@@ -191,15 +190,8 @@ void nft_fib6_eval(const struct nft_expr
 	if (rt->rt6i_flags & (RTF_REJECT | RTF_ANYCAST | RTF_LOCAL))
 		goto put_rt_err;
 
-	if (oif && oif != rt->rt6i_idev->dev) {
-		/* multipath route? Try again with F_IFACE */
-		if ((lookup_flags & RT6_LOOKUP_F_IFACE) == 0) {
-			lookup_flags |= RT6_LOOKUP_F_IFACE;
-			fl6.flowi6_oif = oif->ifindex;
-			ip6_rt_put(rt);
-			goto again;
-		}
-	}
+	if (oif && oif != rt->rt6i_idev->dev)
+		goto put_rt_err;
 
 	switch (priv->result) {
 	case NFT_FIB_RESULT_OIF:


