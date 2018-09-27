Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ACE3C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E48942150D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:26:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E48942150D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729024AbeI0Pnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:43:33 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56842 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727464AbeI0Pnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:43:33 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 0187B111C;
        Thu, 27 Sep 2018 09:26:11 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dave Taht <dave.taht@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 19/44] gso_segment: Reset skb->mac_len after modifying network header
Date:   Thu, 27 Sep 2018 11:04:08 +0200
Message-Id: <20180927090120.565699406@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180927090117.997362691@linuxfoundation.org>
References: <20180927090117.997362691@linuxfoundation.org>
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

From: "Toke Høiland-Jørgensen" <toke@toke.dk>

[ Upstream commit c56cae23c6b167acc68043c683c4573b80cbcc2c ]

When splitting a GSO segment that consists of encapsulated packets, the
skb->mac_len of the segments can end up being set wrong, causing packet
drops in particular when using act_mirred and ifb interfaces in
combination with a qdisc that splits GSO packets.

This happens because at the time skb_segment() is called, network_header
will point to the inner header, throwing off the calculation in
skb_reset_mac_len(). The network_header is subsequently adjust by the
outer IP gso_segment handlers, but they don't set the mac_len.

Fix this by adding skb_reset_mac_len() calls to both the IPv4 and IPv6
gso_segment handlers, after they modify the network_header.

Many thanks to Eric Dumazet for his help in identifying the cause of
the bug.

Acked-by: Dave Taht <dave.taht@gmail.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Toke HÃ¸iland-JÃ¸rgensen <toke@toke.dk>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/af_inet.c     |    1 +
 net/ipv6/ip6_offload.c |    1 +
 2 files changed, 2 insertions(+)

--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1277,6 +1277,7 @@ struct sk_buff *inet_gso_segment(struct
 		if (encap)
 			skb_reset_inner_headers(skb);
 		skb->network_header = (u8 *)iph - skb->head;
+		skb_reset_mac_len(skb);
 	} while ((skb = skb->next));
 
 out:
--- a/net/ipv6/ip6_offload.c
+++ b/net/ipv6/ip6_offload.c
@@ -113,6 +113,7 @@ static struct sk_buff *ipv6_gso_segment(
 			payload_len = skb->len - nhoff - sizeof(*ipv6h);
 		ipv6h->payload_len = htons(payload_len);
 		skb->network_header = (u8 *)ipv6h - skb->head;
+		skb_reset_mac_len(skb);
 
 		if (udpfrag) {
 			int err = ip6_find_1stfragopt(skb, &prevhdr);


