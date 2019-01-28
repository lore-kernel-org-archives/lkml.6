Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F750C282CF
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC67C2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548690745;
	bh=G3Ek8rf//Sj4CubWzrsorbQmTLx4hfIWVnSPJxd9g5g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zpVtU8HExuL2y1i1/Y81qdfjteDCsGKehOpWTvpBqgZiHOnvSAaugiIlVBQVVJM4c
	 xh7tLR5PRiJH/Ucp4Wh9Io18vKwetq4J9RAUlgnABfnQnrxJXx06/UXVHlCXF+U6Xb
	 Km5tJ+ZphXSfEWgwcFbPGCe8ExRQUXFDVDywEKs4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729277AbfA1PwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:52:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:38812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728069AbfA1PwS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:52:18 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF0FF20880;
        Mon, 28 Jan 2019 15:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690737;
        bh=G3Ek8rf//Sj4CubWzrsorbQmTLx4hfIWVnSPJxd9g5g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qElL5hc3xvMOS79ThmKxV5vmn0DnoTc9tcwqbLvcobCRiNsOSMugJ+IpjopfzdZ94
         Ui18NZzFmhz//+LHo8H8loIcNiGF/2hiwnI5xiQfw3Y9FW+w8HRL1c+UD7B26mBwGZ
         JB8HzOuroYOeMdLql2mlFScQ9TSUQ9tZS/FgyEaI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     David Ahern <dsahern@gmail.com>,
        Mike Manning <mmanning@vyatta.att-mail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 179/304] ipv6: Fix handling of LLA with VRF and sockets bound to VRF
Date:   Mon, 28 Jan 2019 10:41:36 -0500
Message-Id: <20190128154341.47195-179-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Ahern <dsahern@gmail.com>

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

