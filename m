Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25FBBC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E220C214C1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="dyGmzpbr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E220C214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729431AbeLEJpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:45:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:50438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729151AbeLEJpg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:45:36 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 858B420989;
        Wed,  5 Dec 2018 09:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544003135;
        bh=Ofmx9UdU7QC1++JUfqpfGPPanAnMb59ulgzm2Z/MTsY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dyGmzpbrkeSm4E+/biGlnSpsIx5Z5z79iqBj/rghm5AZVMzMhyToIPceNrXoxmvtK
         g3LBtmjsSqbSR6nv0ST3WHofVRI/EjmRU9zneByjlburRFSsTuyV4xCJZKRfPVLxPH
         y9gIUSqAQaLS5mOv0fa2kLe74q+wsELscu4jsCNA=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Alin Nastac <alin.nastac@gmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 40/69] netfilter: ipv6: Preserve link scope traffic original oif
Date:   Wed,  5 Dec 2018 04:42:18 -0500
Message-Id: <20181205094247.6556-40-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205094247.6556-1-sashal@kernel.org>
References: <20181205094247.6556-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alin Nastac <alin.nastac@gmail.com>

[ Upstream commit 508b09046c0f21678652fb66fd1e9959d55591d2 ]

When ip6_route_me_harder is invoked, it resets outgoing interface of:
  - link-local scoped packets sent by neighbor discovery
  - multicast packets sent by MLD host
  - multicast packets send by MLD proxy daemon that sets outgoing
    interface through IPV6_PKTINFO ipi6_ifindex

Link-local and multicast packets must keep their original oif after
ip6_route_me_harder is called.

Signed-off-by: Alin Nastac <alin.nastac@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/netfilter.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/netfilter.c b/net/ipv6/netfilter.c
index 9bf260459f83..1f8b1a433b5d 100644
--- a/net/ipv6/netfilter.c
+++ b/net/ipv6/netfilter.c
@@ -25,7 +25,8 @@ int ip6_route_me_harder(struct net *net, struct sk_buff *skb)
 	unsigned int hh_len;
 	struct dst_entry *dst;
 	struct flowi6 fl6 = {
-		.flowi6_oif = sk ? sk->sk_bound_dev_if : 0,
+		.flowi6_oif = sk && sk->sk_bound_dev_if ? sk->sk_bound_dev_if :
+			rt6_need_strict(&iph->daddr) ? skb_dst(skb)->dev->ifindex : 0,
 		.flowi6_mark = skb->mark,
 		.flowi6_uid = sock_net_uid(net, sk),
 		.daddr = iph->daddr,
-- 
2.17.1

