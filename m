Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48DC4C2F3BE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FA682089F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548078718;
	bh=CMkJGSzgAuYWHp/ngkisxg1cJbL0FV1njC4Yqk1i7z8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v/3BKh13qG5EpwhFygBc0g8/qfU6fxnUUEecwrsMaYwkeX4Fa6V7dTOebToraIxAb
	 6FOV+BHl4pOZsRFGNf3fl/sMWZXfxusSp2PofEuGcpTagi/3jQLOFySpGNaIySeQur
	 qnSZK/kI+HJOvfp+jVvLk8dd4cRnmuf5ktE/TxOQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730932AbfAUNv4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:51:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:34928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730894AbfAUNvw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:51:52 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7689E2063F;
        Mon, 21 Jan 2019 13:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078711;
        bh=CMkJGSzgAuYWHp/ngkisxg1cJbL0FV1njC4Yqk1i7z8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AFCd7C3UIU9T3xMlMVpa2YP5PQQlibUsZz23F13vJF3S8SGh2UjQiLHDpOrZt4kGZ
         PakS0nAErkTkV6BCGoAovt4yPVUgyXVsVqexLXu9uijtoQDrVRiDPOZg9Jye/7JO61
         xz41CResy3k17dOjeJZwafCVnJyOH2sOrmG0SE5M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, syzbot <syzkaller@googlegroups.com>,
        Eric Dumazet <edumazet@google.com>,
        Willem de Bruijn <willemb@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 17/59] ip: on queued skb use skb_header_pointer instead of pskb_may_pull
Date:   Mon, 21 Jan 2019 14:43:42 +0100
Message-Id: <20190121122458.449032083@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121122456.529172919@linuxfoundation.org>
References: <20190121122456.529172919@linuxfoundation.org>
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

From: Willem de Bruijn <willemb@google.com>

[ Upstream commit 4a06fa67c4da20148803525151845276cdb995c1 ]

Commit 2efd4fca703a ("ip: in cmsg IP(V6)_ORIGDSTADDR call
pskb_may_pull") avoided a read beyond the end of the skb linear
segment by calling pskb_may_pull.

That function can trigger a BUG_ON in pskb_expand_head if the skb is
shared, which it is when when peeking. It can also return ENOMEM.

Avoid both by switching to safer skb_header_pointer.

Fixes: 2efd4fca703a ("ip: in cmsg IP(V6)_ORIGDSTADDR call pskb_may_pull")
Reported-by: syzbot <syzkaller@googlegroups.com>
Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/ip_sockglue.c |   12 +++++-------
 net/ipv6/datagram.c    |   10 ++++------
 2 files changed, 9 insertions(+), 13 deletions(-)

--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -146,19 +146,17 @@ static void ip_cmsg_recv_security(struct
 
 static void ip_cmsg_recv_dstaddr(struct msghdr *msg, struct sk_buff *skb)
 {
+	__be16 _ports[2], *ports;
 	struct sockaddr_in sin;
-	__be16 *ports;
-	int end;
-
-	end = skb_transport_offset(skb) + 4;
-	if (end > 0 && !pskb_may_pull(skb, end))
-		return;
 
 	/* All current transport protocols have the port numbers in the
 	 * first four bytes of the transport header and this function is
 	 * written with this assumption in mind.
 	 */
-	ports = (__be16 *)skb_transport_header(skb);
+	ports = skb_header_pointer(skb, skb_transport_offset(skb),
+				   sizeof(_ports), &_ports);
+	if (!ports)
+		return;
 
 	sin.sin_family = AF_INET;
 	sin.sin_addr.s_addr = ip_hdr(skb)->daddr;
--- a/net/ipv6/datagram.c
+++ b/net/ipv6/datagram.c
@@ -709,17 +709,15 @@ void ip6_datagram_recv_specific_ctl(stru
 	}
 	if (np->rxopt.bits.rxorigdstaddr) {
 		struct sockaddr_in6 sin6;
-		__be16 *ports;
-		int end;
+		__be16 _ports[2], *ports;
 
-		end = skb_transport_offset(skb) + 4;
-		if (end <= 0 || pskb_may_pull(skb, end)) {
+		ports = skb_header_pointer(skb, skb_transport_offset(skb),
+					   sizeof(_ports), &_ports);
+		if (ports) {
 			/* All current transport protocols have the port numbers in the
 			 * first four bytes of the transport header and this function is
 			 * written with this assumption in mind.
 			 */
-			ports = (__be16 *)skb_transport_header(skb);
-
 			sin6.sin6_family = AF_INET6;
 			sin6.sin6_addr = ipv6_hdr(skb)->daddr;
 			sin6.sin6_port = ports[1];


