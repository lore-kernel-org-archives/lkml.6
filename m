Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F79C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1894D21476
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:42:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="z/PEzuhE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1894D21476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730647AbeJKXJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:09:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:41034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726700AbeJKXJ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:09:57 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAD5721470;
        Thu, 11 Oct 2018 15:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272533;
        bh=rzTJfud4wUEy5a8X/WhD3pnzBtUIWo+yqx11yCzKM8s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=z/PEzuhEUmGstWSrT5QevLJl5efsZuxdjDRsxoaemenEbXDy8LFmAft9hGpaHg0PT
         JpTVFWxKJSCh3g5DCpB+Hm7t73QsD502dn9W7LhI/GT84L6B9Ybj2oxsLtgvVZbqRu
         /aQFHdUUv1xegTqk70iyIfT5n0J989uZAgB0C8xg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Yuchung Cheng <ycheng@google.com>,
        Yaogong Wang <wygivan@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Mao Wenan <maowenan@huawei.com>
Subject: [PATCH 4.4 22/27] tcp: fix a stale ooo_last_skb after a replace
Date:   Thu, 11 Oct 2018 17:35:09 +0200
Message-Id: <20181011152535.091804300@linuxfoundation.org>
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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp_input.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

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


