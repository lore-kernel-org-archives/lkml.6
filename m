Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3BDAC43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:34:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B3A724FF3
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:34:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B3A724FF3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755215AbeFXPeZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 11:34:25 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59338 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754659AbeFXPeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 11:34:23 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 949362C;
        Sun, 24 Jun 2018 15:34:21 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Frank van der Linden <fllinden@amazon.com>,
        Eric Dumazet <edumazet@google.com>,
        Balbir Singh <bsingharora@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 07/64] tcp: verify the checksum of the first data segment in a new connection
Date:   Sun, 24 Jun 2018 23:21:48 +0800
Message-Id: <20180624142744.063463910@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180624142743.613370789@linuxfoundation.org>
References: <20180624142743.613370789@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Frank van der Linden <fllinden@amazon.com>

[ Upstream commit 4fd44a98ffe0d048246efef67ed640fdf2098a62 ]

commit 079096f103fa ("tcp/dccp: install syn_recv requests into ehash
table") introduced an optimization for the handling of child sockets
created for a new TCP connection.

But this optimization passes any data associated with the last ACK of the
connection handshake up the stack without verifying its checksum, because it
calls tcp_child_process(), which in turn calls tcp_rcv_state_process()
directly.  These lower-level processing functions do not do any checksum
verification.

Insert a tcp_checksum_complete call in the TCP_NEW_SYN_RECEIVE path to
fix this.

Fixes: 079096f103fa ("tcp/dccp: install syn_recv requests into ehash table")
Signed-off-by: Frank van der Linden <fllinden@amazon.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Tested-by: Balbir Singh <bsingharora@gmail.com>
Reviewed-by: Balbir Singh <bsingharora@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp_ipv4.c |    4 ++++
 net/ipv6/tcp_ipv6.c |    4 ++++
 2 files changed, 8 insertions(+)

--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1680,6 +1680,10 @@ process:
 			reqsk_put(req);
 			goto discard_it;
 		}
+		if (tcp_checksum_complete(skb)) {
+			reqsk_put(req);
+			goto csum_error;
+		}
 		if (unlikely(sk->sk_state != TCP_LISTEN)) {
 			inet_csk_reqsk_queue_drop_and_put(sk, req);
 			goto lookup;
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1459,6 +1459,10 @@ process:
 			reqsk_put(req);
 			goto discard_it;
 		}
+		if (tcp_checksum_complete(skb)) {
+			reqsk_put(req);
+			goto csum_error;
+		}
 		if (unlikely(sk->sk_state != TCP_LISTEN)) {
 			inet_csk_reqsk_queue_drop_and_put(sk, req);
 			goto lookup;


