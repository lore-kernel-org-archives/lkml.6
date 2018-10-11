Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F6F9C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31A1521476
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:36:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yLJmFzoR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31A1521476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729060AbeJKXEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:04:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:59190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726562AbeJKXEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:04:21 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A5CD213A2;
        Thu, 11 Oct 2018 15:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272198;
        bh=OOOOvH/eoMnS1LuVMKhwBpTBzmjtQjiTOWiABmOtbqM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yLJmFzoRvJJhDdll/anSD1Ge6cM8LQiUxZ6bUxdQTTwdrydzT1767LrtOx+ujQ/E9
         BMBgPMgKKXzMFuUtjwjayWSguAgXpXtyu0jvT55rkKUS3rFQnvhq7MXKwRgJFzq6Ym
         PGJOhEJUOCUjbVViCr3allB57/0ymM6adWOwhFi8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dave Taht <dave.taht@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 006/120] gso_segment: Reset skb->mac_len after modifying network header
Date:   Thu, 11 Oct 2018 17:33:07 +0200
Message-Id: <20181011152549.779181670@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152549.500488630@linuxfoundation.org>
References: <20181011152549.500488630@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Toke Høiland-Jørgensen <toke@toke.dk>

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
Signed-off-by: Toke Høiland-Jørgensen <toke@toke.dk>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/af_inet.c     |    1 +
 net/ipv6/ip6_offload.c |    1 +
 2 files changed, 2 insertions(+)

--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1288,6 +1288,7 @@ static struct sk_buff *inet_gso_segment(
 		if (encap)
 			skb_reset_inner_headers(skb);
 		skb->network_header = (u8 *)iph - skb->head;
+		skb_reset_mac_len(skb);
 	} while ((skb = skb->next));
 
 out:
--- a/net/ipv6/ip6_offload.c
+++ b/net/ipv6/ip6_offload.c
@@ -118,6 +118,7 @@ static struct sk_buff *ipv6_gso_segment(
 		ipv6h = (struct ipv6hdr *)(skb_mac_header(skb) + nhoff);
 		ipv6h->payload_len = htons(skb->len - nhoff - sizeof(*ipv6h));
 		skb->network_header = (u8 *)ipv6h - skb->head;
+		skb_reset_mac_len(skb);
 
 		if (udpfrag) {
 			int err = ip6_find_1stfragopt(skb, &prevhdr);


