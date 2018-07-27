Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7542C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D19E2089B
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:28:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D19E2089B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389082AbeG0Ltz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:49:55 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42676 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389057AbeG0Lty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:49:54 -0400
Received: from localhost (unknown [89.188.5.116])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 80064CD1;
        Fri, 27 Jul 2018 10:28:37 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        Yuchung Cheng <ycheng@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 17/27] tcp: avoid collapses in tcp_prune_queue() if possible
Date:   Fri, 27 Jul 2018 12:26:54 +0200
Message-Id: <20180727102649.679062445@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727102649.049641021@linuxfoundation.org>
References: <20180727102649.049641021@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit f4a3313d8e2ca9fd8d8f45e40a2903ba782607e7 ]

Right after a TCP flow is created, receiving tiny out of order
packets allways hit the condition :

if (atomic_read(&sk->sk_rmem_alloc) >= sk->sk_rcvbuf)
	tcp_clamp_window(sk);

tcp_clamp_window() increases sk_rcvbuf to match sk_rmem_alloc
(guarded by tcp_rmem[2])

Calling tcp_collapse_ofo_queue() in this case is not useful,
and offers a O(N^2) surface attack to malicious peers.

Better not attempt anything before full queue capacity is reached,
forcing attacker to spend lots of resource and allow us to more
easily detect the abuse.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
Acked-by: Yuchung Cheng <ycheng@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp_input.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4738,6 +4738,9 @@ static int tcp_prune_queue(struct sock *
 	else if (sk_under_memory_pressure(sk))
 		tp->rcv_ssthresh = min(tp->rcv_ssthresh, 4U * tp->advmss);
 
+	if (atomic_read(&sk->sk_rmem_alloc) <= sk->sk_rcvbuf)
+		return 0;
+
 	tcp_collapse_ofo_queue(sk);
 	if (!skb_queue_empty(&sk->sk_receive_queue))
 		tcp_collapse(sk, &sk->sk_receive_queue,


