Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A13C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:18:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EB052089E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HsDEDxfi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EB052089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730200AbeJQBKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:10:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:55162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727562AbeJQBKO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:10:14 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F6B621476;
        Tue, 16 Oct 2018 17:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710329;
        bh=K5+nlledb+2N4C3TovUGKepZyURqXeuRf5kJWI1+HXg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HsDEDxfijGCjoRYhd+Y5CN8zQO1GOCLHIA5SmIl4j8goSrih687iJbOkgr1mIc4QE
         V0I47OHgzilkmqpopqqGQAsHBC7yzE1oraR1GYPCEP0PiEuXW8Iz9opzAOwMWE1m8h
         j0TjXJ+1cua6ue8rCmw9dBoQ7PdkkODwK5MOPedE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 005/109] ip_tunnel: be careful when accessing the inner header
Date:   Tue, 16 Oct 2018 19:04:33 +0200
Message-Id: <20181016170524.958398088@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170524.530541524@linuxfoundation.org>
References: <20181016170524.530541524@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit ccfec9e5cb2d48df5a955b7bf47f7782157d3bc2]

Cong noted that we need the same checks introduced by commit 76c0ddd8c3a6
("ip6_tunnel: be careful when accessing the inner header")
even for ipv4 tunnels.

Fixes: c54419321455 ("GRE: Refactor GRE tunneling code.")
Suggested-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/ip_tunnel.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/net/ipv4/ip_tunnel.c
+++ b/net/ipv4/ip_tunnel.c
@@ -635,6 +635,7 @@ void ip_tunnel_xmit(struct sk_buff *skb,
 		    const struct iphdr *tnl_params, u8 protocol)
 {
 	struct ip_tunnel *tunnel = netdev_priv(dev);
+	unsigned int inner_nhdr_len = 0;
 	const struct iphdr *inner_iph;
 	struct flowi4 fl4;
 	u8     tos, ttl;
@@ -644,6 +645,14 @@ void ip_tunnel_xmit(struct sk_buff *skb,
 	__be32 dst;
 	bool connected;
 
+	/* ensure we can access the inner net header, for several users below */
+	if (skb->protocol == htons(ETH_P_IP))
+		inner_nhdr_len = sizeof(struct iphdr);
+	else if (skb->protocol == htons(ETH_P_IPV6))
+		inner_nhdr_len = sizeof(struct ipv6hdr);
+	if (unlikely(!pskb_may_pull(skb, inner_nhdr_len)))
+		goto tx_error;
+
 	inner_iph = (const struct iphdr *)skb_inner_network_header(skb);
 	connected = (tunnel->parms.iph.daddr != 0);
 


