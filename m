Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF98CC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73073214D9
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QcZkbAXu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73073214D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388841AbeKVFqW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:46:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:41528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729285AbeKVFqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:46:20 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10C2B2151B;
        Wed, 21 Nov 2018 19:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542827447;
        bh=OgjSWMnDR1Ge4WeMzVjxpETiRtBrFK6nv2WJE9Xf3To=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QcZkbAXua/HnKrRCIa5GIKWHbigISofTNh1prmSA6LiSfvCQdJiJvJyP8OSRE+Vaj
         u6u0hpBYwrVP+qt5471XBxfBvxo3dr1/CIvnQvffgVnFUtDMksgRo298Cx4nVrh5HB
         IjNOFmiXrXdKN7jbPfJweJfCYreCRrzgSPhuFrls=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Preethi Ramachandra <preethir@juniper.net>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 09/59] ipv6: Fix PMTU updates for UDP/raw sockets in presence of VRF
Date:   Wed, 21 Nov 2018 20:06:24 +0100
Message-Id: <20181121183508.619898409@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181121183508.262873520@linuxfoundation.org>
References: <20181121183508.262873520@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Ahern <dsahern@gmail.com>

[ Upstream commit 7ddacfa564870cdd97275fd87decb6174abc6380 ]

Preethi reported that PMTU discovery for UDP/raw applications is not
working in the presence of VRF when the socket is not bound to a device.
The problem is that ip6_sk_update_pmtu does not consider the L3 domain
of the skb device if the socket is not bound. Update the function to
set oif to the L3 master device if relevant.

Fixes: ca254490c8df ("net: Add VRF support to IPv6 stack")
Reported-by: Preethi Ramachandra <preethir@juniper.net>
Signed-off-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/route.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -1439,10 +1439,13 @@ EXPORT_SYMBOL_GPL(ip6_update_pmtu);
 
 void ip6_sk_update_pmtu(struct sk_buff *skb, struct sock *sk, __be32 mtu)
 {
+	int oif = sk->sk_bound_dev_if;
 	struct dst_entry *dst;
 
-	ip6_update_pmtu(skb, sock_net(sk), mtu,
-			sk->sk_bound_dev_if, sk->sk_mark);
+	if (!oif && skb->dev)
+		oif = l3mdev_master_ifindex(skb->dev);
+
+	ip6_update_pmtu(skb, sock_net(sk), mtu, oif, sk->sk_mark);
 
 	dst = __sk_dst_get(sk);
 	if (!dst || !dst->obsolete ||


