Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77BE9C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D73B21476
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1dV8nf0f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D73B21476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730660AbeJKXKB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:10:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:41100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726700AbeJKXKA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:10:00 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6797020652;
        Thu, 11 Oct 2018 15:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272535;
        bh=hpXi7dgk5YwJgpjGYIVPK9GTpGQxffMLMlgG33i7yew=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1dV8nf0fVvwowHcMufmpoHu7CFGqHNAO1yRChaLJBZoqcfFWH1LVG1RvfFfBZ1kIo
         talzFG0LJYo10FBvSdB2v00JPAdXP1TbH+fWJPAdWXB68ypXIRJFrZgvI1KCyuz7iI
         uZ72s1c5I2XjFEPB0znOu2DPc7jPJVPQ2RcDNYQY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Juha-Matti Tilli <juha-matti.tilli@iki.fi>,
        Yuchung Cheng <ycheng@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Mao Wenan <maowenan@huawei.com>
Subject: [PATCH 4.4 23/27] tcp: free batches of packets in tcp_prune_ofo_queue()
Date:   Thu, 11 Oct 2018 17:35:10 +0200
Message-Id: <20181011152535.140663022@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152534.014964888@linuxfoundation.org>
References: <20181011152534.014964888@linuxfoundation.org>
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

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 72cd43ba64fc172a443410ce01645895850844c8 ]

Juha-Matti Tilli reported that malicious peers could inject tiny
packets in out_of_order_queue, forcing very expensive calls
to tcp_collapse_ofo_queue() and tcp_prune_ofo_queue() for
every incoming packet. out_of_order_queue rb-tree can contain
thousands of nodes, iterating over all of them is not nice.

Before linux-4.9, we would have pruned all packets in ofo_queue
in one go, every XXXX packets. XXXX depends on sk_rcvbuf and skbs
truesize, but is about 7000 packets with tcp_rmem[2] default of 6 MB.

Since we plan to increase tcp_rmem[2] in the future to cope with
modern BDP, can not revert to the old behavior, without great pain.

Strategy taken in this patch is to purge ~12.5 % of the queue capacity.

Fixes: 36a6503fedda ("tcp: refine tcp_prune_ofo_queue() to not drop all packets")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: Juha-Matti Tilli <juha-matti.tilli@iki.fi>
Acked-by: Yuchung Cheng <ycheng@google.com>
Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Mao Wenan <maowenan@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp_input.c |   16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4899,27 +4899,33 @@ new_range:
 
 /*
  * Purge the out-of-order queue.
+ * Drop at least 12.5 % of sk_rcvbuf to avoid malicious attacks.
  * Return true if queue was pruned.
  */
 static bool tcp_prune_ofo_queue(struct sock *sk)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 	struct rb_node *node, *prev;
+	int goal;
 
 	if (RB_EMPTY_ROOT(&tp->out_of_order_queue))
 		return false;
 
 	NET_INC_STATS_BH(sock_net(sk), LINUX_MIB_OFOPRUNED);
-
+	goal = sk->sk_rcvbuf >> 3;
 	node = &tp->ooo_last_skb->rbnode;
 	do {
 		prev = rb_prev(node);
 		rb_erase(node, &tp->out_of_order_queue);
+		goal -= rb_to_skb(node)->truesize;
 		__kfree_skb(rb_to_skb(node));
-		sk_mem_reclaim(sk);
-		if (atomic_read(&sk->sk_rmem_alloc) <= sk->sk_rcvbuf &&
-		    !tcp_under_memory_pressure(sk))
-			break;
+		if (!prev || goal <= 0) {
+			sk_mem_reclaim(sk);
+			if (atomic_read(&sk->sk_rmem_alloc) <= sk->sk_rcvbuf &&
+			    !tcp_under_memory_pressure(sk))
+				break;
+			goal = sk->sk_rcvbuf >> 3;
+		}
 
 		node = prev;
 	} while (node);


