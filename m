Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B3F2C6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 353A72089F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 10:10:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 353A72089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388684AbeG0LbM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:31:12 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36462 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729431AbeG0LbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:31:11 -0400
Received: from localhost (unknown [89.188.5.116])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D0AE2CB5;
        Fri, 27 Jul 2018 10:09:58 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        Yuchung Cheng <ycheng@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 18/33] tcp: avoid collapses in tcp_prune_queue() if possible
Date:   Fri, 27 Jul 2018 12:08:59 +0200
Message-Id: <20180727100828.356613301@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727100827.665729981@linuxfoundation.org>
References: <20180727100827.665729981@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -5027,6 +5027,9 @@ static int tcp_prune_queue(struct sock *
 	else if (tcp_under_memory_pressure(sk))
 		tp->rcv_ssthresh = min(tp->rcv_ssthresh, 4U * tp->advmss);
 
+	if (atomic_read(&sk->sk_rmem_alloc) <= sk->sk_rcvbuf)
+		return 0;
+
 	tcp_collapse_ofo_queue(sk);
 	if (!skb_queue_empty(&sk->sk_receive_queue))
 		tcp_collapse(sk, &sk->sk_receive_queue, NULL,


