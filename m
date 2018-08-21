Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD45C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99C5A20C09
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:33:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99C5A20C09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbeHUJwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 05:52:25 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56868 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbeHUJwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 05:52:24 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5F57D9D7;
        Tue, 21 Aug 2018 06:33:35 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sabrina Dubroca <sd@queasysnail.net>,
        Xin Long <lucien.xin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 05/25] ip6_tunnel: use the right value for ipv4 min mtu check in ip6_tnl_xmit
Date:   Tue, 21 Aug 2018 08:21:19 +0200
Message-Id: <20180821055125.124130539@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180821055124.909865464@linuxfoundation.org>
References: <20180821055124.909865464@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit 82a40777de12728dedf4075453b694f0d1baee80 ]

According to RFC791, 68 bytes is the minimum size of IPv4 datagram every
device must be able to forward without further fragmentation while 576
bytes is the minimum size of IPv4 datagram every device has to be able
to receive, so in ip6_tnl_xmit(), 68(IPV4_MIN_MTU) should be the right
value for the ipv4 min mtu check in ip6_tnl_xmit.

While at it, change to use max() instead of if statement.

Fixes: c9fefa08190f ("ip6_tunnel: get the min mtu properly in ip6_tnl_xmit")
Reported-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/ip6_tunnel.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -1133,12 +1133,8 @@ route_lookup:
 		max_headroom += 8;
 		mtu -= 8;
 	}
-	if (skb->protocol == htons(ETH_P_IPV6)) {
-		if (mtu < IPV6_MIN_MTU)
-			mtu = IPV6_MIN_MTU;
-	} else if (mtu < 576) {
-		mtu = 576;
-	}
+	mtu = max(mtu, skb->protocol == htons(ETH_P_IPV6) ?
+		       IPV6_MIN_MTU : IPV4_MIN_MTU);
 
 	if (skb_dst(skb) && !t->parms.collect_md)
 		skb_dst(skb)->ops->update_pmtu(skb_dst(skb), NULL, skb, mtu);


