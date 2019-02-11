Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91DD5C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61BCD218D8
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549901055;
	bh=JiNB4qYG5B9PnF2Izhq51ABOQs3lGHRLd5wDxYwstd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hL2ZgSrgpiatfyqom9oOh8WJCZV/klK7lXsS+1zImi3IW2CkCKSUlXK/EvfiS5WKJ
	 1X1bN9sD0PIFZD7S4IpE7/dmLsIWm/0jfjBJuVC1H/KHieskJKBh0srTI15nKtsFst
	 MUYqw10iKJJPdrBoofEKJuT6m8G5zgk9mizQeiFc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730218AbfBKQEO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 11:04:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:34764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728638AbfBKO2r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:28:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 954982075C;
        Mon, 11 Feb 2019 14:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895327;
        bh=JiNB4qYG5B9PnF2Izhq51ABOQs3lGHRLd5wDxYwstd4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S5NnkctPDX+Gf4KWTN9HvqA6pGaPywxThhw7WiKwmfLOgbXOmFqZLNKTrVom6BDY7
         P4J0VNQkH3D/EVq8S8F2HiL4O6tlcOvjXoEIIPl0FTgzJ1ZOGNYUNJzcHPRSqVXXuW
         qDFgvbq1wAETgO8QEoDQFOFpIb68RHe2ET8ZCnsk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Donald Sharp <sharpd@cumulusnetworks.com>,
        Mike Manning <mmanning@vyatta.att-mail.com>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 168/352] ipv6: Fix handling of LLA with VRF and sockets bound to VRF
Date:   Mon, 11 Feb 2019 15:16:35 +0100
Message-Id: <20190211141857.701933826@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit c2027d1e17582903e368abf5d4838b22a98f2b7b ]

A recent commit allows sockets bound to a VRF to receive ipv6 link local
packets. However, it only works for UDP and worse TCP connection attempts
to the LLA with the only listener bound to the VRF just hang where as
before the client gets a reset and connection refused. Fix by adjusting
ir_iif for LL addresses and packets received through a device enslaved
to a VRF.

Fixes: 6f12fa775530 ("vrf: mark skb for multicast or link-local as enslaved to VRF")
Reported-by: Donald Sharp <sharpd@cumulusnetworks.com>
Cc: Mike Manning <mmanning@vyatta.att-mail.com>
Signed-off-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/tcp_ipv6.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 03e6b7a2bc53..f5c213001b05 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -734,6 +734,7 @@ static void tcp_v6_init_req(struct request_sock *req,
 			    const struct sock *sk_listener,
 			    struct sk_buff *skb)
 {
+	bool l3_slave = ipv6_l3mdev_skb(TCP_SKB_CB(skb)->header.h6.flags);
 	struct inet_request_sock *ireq = inet_rsk(req);
 	const struct ipv6_pinfo *np = inet6_sk(sk_listener);
 
@@ -741,7 +742,7 @@ static void tcp_v6_init_req(struct request_sock *req,
 	ireq->ir_v6_loc_addr = ipv6_hdr(skb)->daddr;
 
 	/* So that link locals have meaning */
-	if (!sk_listener->sk_bound_dev_if &&
+	if ((!sk_listener->sk_bound_dev_if || l3_slave) &&
 	    ipv6_addr_type(&ireq->ir_v6_rmt_addr) & IPV6_ADDR_LINKLOCAL)
 		ireq->ir_iif = tcp_v6_iif(skb);
 
-- 
2.19.1



