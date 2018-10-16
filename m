Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44419C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 100532098A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ak9xqgSO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 100532098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731417AbeJQBOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:14:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:33378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730397AbeJQBOx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:14:53 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 929E320866;
        Tue, 16 Oct 2018 17:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710608;
        bh=iHnQhHcAhED/C7CetQCqAdOCOZ+lHa9P3lUu5ggZ/bE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ak9xqgSODf09EkfgZ0pW96gz/yEgsNSoK4VT3dB5hwrImsXm7PFQPzxqVT9tf+FH+
         3Wt1UQgVYZButIyroINlMi5hFRtmiGt0WQJ18pjsJSXEI5Y6YvqsRcTiwkXP1D/Gfp
         FZadm0Msmk5aPVYz3K+pNbiGpBOpaoNQxPcsj41E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 25/71] ip_tunnel: be careful when accessing the inner header
Date:   Tue, 16 Oct 2018 19:09:22 +0200
Message-Id: <20181016170540.656927872@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170539.315587743@linuxfoundation.org>
References: <20181016170539.315587743@linuxfoundation.org>
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
@@ -627,6 +627,7 @@ void ip_tunnel_xmit(struct sk_buff *skb,
 		    const struct iphdr *tnl_params, u8 protocol)
 {
 	struct ip_tunnel *tunnel = netdev_priv(dev);
+	unsigned int inner_nhdr_len = 0;
 	const struct iphdr *inner_iph;
 	struct flowi4 fl4;
 	u8     tos, ttl;
@@ -636,6 +637,14 @@ void ip_tunnel_xmit(struct sk_buff *skb,
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
 


