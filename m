Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D4CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AB3121104
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XkmmGVmI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AB3121104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbeKZVtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:49:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:58134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726923AbeKZVtQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:49:16 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8E7320817;
        Mon, 26 Nov 2018 10:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543229732;
        bh=L4nQoftVq9Kk6fnH8UXEv+4SNZ10dIPxPjmY+nyZy1g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XkmmGVmIB5/PbeeXtTshviv6/rFuYffj5cNqgQmOgrnXCGvnse3U81Pg8/dQ09E5E
         MUkC2UbASLokiWSxp1rqt3v6vNZbrjfeyFSE08eVVsB5ML6QAAV0mNoGKrhj9fY6TN
         9QYSfmvGVxtPJW1o9Fl56mM9idkm5sezveMxe5m0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Preethi Ramachandra <preethir@juniper.net>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 05/70] ipv6: Fix PMTU updates for UDP/raw sockets in presence of VRF
Date:   Mon, 26 Nov 2018 11:50:20 +0100
Message-Id: <20181126105047.456791259@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105046.722096341@linuxfoundation.org>
References: <20181126105046.722096341@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

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
 net/ipv6/route.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -1420,8 +1420,12 @@ EXPORT_SYMBOL_GPL(ip6_update_pmtu);
 
 void ip6_sk_update_pmtu(struct sk_buff *skb, struct sock *sk, __be32 mtu)
 {
-	ip6_update_pmtu(skb, sock_net(sk), mtu,
-			sk->sk_bound_dev_if, sk->sk_mark);
+	int oif = sk->sk_bound_dev_if;
+
+	if (!oif && skb->dev)
+		oif = l3mdev_master_ifindex(skb->dev);
+
+	ip6_update_pmtu(skb, sock_net(sk), mtu, oif, sk->sk_mark);
 }
 EXPORT_SYMBOL_GPL(ip6_sk_update_pmtu);
 


