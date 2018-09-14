Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A13FC6183
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1CC420853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:14:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1CC420853
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbeINN1x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 09:27:53 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12131 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726918AbeINN1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 09:27:52 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A82FB2C337CFF;
        Fri, 14 Sep 2018 16:14:29 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.399.0; Fri, 14 Sep 2018 16:14:23 +0800
From:   Mao Wenan <maowenan@huawei.com>
To:     <netdev@vger.kernel.org>, <gregkh@linux-foundation.org>,
        <dwmw2@infradead.org>, <eric.dumazet@gmail.com>,
        <davem@davemloft.net>, <stable@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <maowenan@huawei.com>
Subject: [PATCH stable 4.4 V2 3/6] tcp: fix a stale ooo_last_skb after a replace
Date:   Fri, 14 Sep 2018 16:24:07 +0800
Message-ID: <1536913450-12380-4-git-send-email-maowenan@huawei.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1536913450-12380-1-git-send-email-maowenan@huawei.com>
References: <1536913450-12380-1-git-send-email-maowenan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 76f0dcbb5ae1a7c3dbeec13dd98233b8e6b0b32a ]

When skb replaces another one in ooo queue, I forgot to also
update tp->ooo_last_skb as well, if the replaced skb was the last one
in the queue.

To fix this, we simply can re-use the code that runs after an insertion,
trying to merge skbs at the right of current skb.

This not only fixes the bug, but also remove all small skbs that might
be a subset of the new one.

Example:

We receive segments 2001:3001,  4001:5001

Then we receive 2001:8001 : We should replace 2001:3001 with the big
skb, but also remove 4001:50001 from the queue to save space.

packetdrill test demonstrating the bug

0.000 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3
+0 setsockopt(3, SOL_SOCKET, SO_REUSEADDR, [1], 4) = 0
+0 bind(3, ..., ...) = 0
+0 listen(3, 1) = 0

+0 < S 0:0(0) win 32792 <mss 1000,sackOK,nop,nop,nop,wscale 7>
+0 > S. 0:0(0) ack 1 <mss 1460,nop,nop,sackOK,nop,wscale 7>
+0.100 < . 1:1(0) ack 1 win 1024
+0 accept(3, ..., ...) = 4

+0.01 < . 1001:2001(1000) ack 1 win 1024
+0    > . 1:1(0) ack 1 <nop,nop, sack 1001:2001>

+0.01 < . 1001:3001(2000) ack 1 win 1024
+0    > . 1:1(0) ack 1 <nop,nop, sack 1001:2001 1001:3001>

Fixes: 9f5afeae5152 ("tcp: use an RB tree for ooo receive queue")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: Yuchung Cheng <ycheng@google.com>
Cc: Yaogong Wang <wygivan@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Mao Wenan <maowenan@huawei.com>
---
 net/ipv4/tcp_input.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 7832d0d..4cc0a53 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4465,7 +4465,7 @@ coalesce_done:
 				NET_INC_STATS(sock_net(sk),
 					      LINUX_MIB_TCPOFOMERGE);
 				__kfree_skb(skb1);
-				goto add_sack;
+				goto merge_right;
 			}
 		} else if (tcp_try_coalesce(sk, skb1, skb, &fragstolen)) {
 			goto coalesce_done;
@@ -4477,6 +4477,7 @@ coalesce_done:
 	rb_link_node(&skb->rbnode, parent, p);
 	rb_insert_color(&skb->rbnode, &tp->out_of_order_queue);
 
+merge_right:
 	/* Remove other segments covered by skb. */
 	while ((q = rb_next(&skb->rbnode)) != NULL) {
 		skb1 = rb_entry(q, struct sk_buff, rbnode);
-- 
1.8.3.1

