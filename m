Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5987AC6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FCEA208E7
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544790720;
	bh=UQUkZN3dsVq4Yqnb+WSLIuljxkyTSVal89fob/0QlnU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HY6Vnl1rd6eakwL7IPqfKZ2TysM2fnKWYeM0XTw3g3xNys8DsVAlAMiOd5yiADamo
	 CMksLbCZ/Iwqui0UKFLJsIAqRW0DTwTkXAoJxMGXCFZaUjne7dDJ8oyKvOsXO65317
	 bASwiF1MjErHOjxdxJ1LQ/ShOms2NURH1w5SZzvw=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FCEA208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731187AbeLNMb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:31:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:55072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730693AbeLNMJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:09:22 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 659B9214AE;
        Fri, 14 Dec 2018 12:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789361;
        bh=UQUkZN3dsVq4Yqnb+WSLIuljxkyTSVal89fob/0QlnU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GZ2MZHVTRUu6651yG+5GuhQn4OYKlYnC0MHnydvy9+0OWwu3Oprhvce7hxdcNXEeL
         /ERKDl4SC00UFh6ihbn1+XhsEkzRcT1v91GwKZdOHt/vwumpvwBnK9SSJ9ZcS0e0EZ
         Ejldj3BnBUrIq6zoHlg9wV56sChVpCGk/bhOdPSc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alin Nastac <alin.nastac@gmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 53/89] netfilter: ipv6: Preserve link scope traffic original oif
Date:   Fri, 14 Dec 2018 13:00:06 +0100
Message-Id: <20181214115732.294320091@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115729.658859279@linuxfoundation.org>
References: <20181214115729.658859279@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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
2.19.1



