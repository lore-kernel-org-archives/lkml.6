Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F605C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3630620895
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:49:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3630620895
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388827AbeG0LKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:10:10 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52702 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731988AbeG0LKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:10:10 -0400
Received: from localhost (unknown [89.188.5.116])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D3A54BB6;
        Fri, 27 Jul 2018 09:49:03 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        Yuchung Cheng <ycheng@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.17 46/66] tcp: add tcp_ooo_try_coalesce() helper
Date:   Fri, 27 Jul 2018 11:45:39 +0200
Message-Id: <20180727093814.247227006@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727093809.043856530@linuxfoundation.org>
References: <20180727093809.043856530@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 58152ecbbcc6a0ce7fddd5bf5f6ee535834ece0c ]

In case skb in out_or_order_queue is the result of
multiple skbs coalescing, we would like to get a proper gso_segs
counter tracking, so that future tcp_drop() can report an accurate
number.

I chose to not implement this tracking for skbs in receive queue,
since they are not dropped, unless socket is disconnected.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
Acked-by: Yuchung Cheng <ycheng@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp_input.c |   25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4299,6 +4299,23 @@ static bool tcp_try_coalesce(struct sock
 	return true;
 }
 
+static bool tcp_ooo_try_coalesce(struct sock *sk,
+			     struct sk_buff *to,
+			     struct sk_buff *from,
+			     bool *fragstolen)
+{
+	bool res = tcp_try_coalesce(sk, to, from, fragstolen);
+
+	/* In case tcp_drop() is called later, update to->gso_segs */
+	if (res) {
+		u32 gso_segs = max_t(u16, 1, skb_shinfo(to)->gso_segs) +
+			       max_t(u16, 1, skb_shinfo(from)->gso_segs);
+
+		skb_shinfo(to)->gso_segs = min_t(u32, gso_segs, 0xFFFF);
+	}
+	return res;
+}
+
 static void tcp_drop(struct sock *sk, struct sk_buff *skb)
 {
 	sk_drops_add(sk, skb);
@@ -4422,8 +4439,8 @@ static void tcp_data_queue_ofo(struct so
 	/* In the typical case, we are adding an skb to the end of the list.
 	 * Use of ooo_last_skb avoids the O(Log(N)) rbtree lookup.
 	 */
-	if (tcp_try_coalesce(sk, tp->ooo_last_skb,
-			     skb, &fragstolen)) {
+	if (tcp_ooo_try_coalesce(sk, tp->ooo_last_skb,
+				 skb, &fragstolen)) {
 coalesce_done:
 		tcp_grow_window(sk, skb);
 		kfree_skb_partial(skb, fragstolen);
@@ -4473,8 +4490,8 @@ coalesce_done:
 				tcp_drop(sk, skb1);
 				goto merge_right;
 			}
-		} else if (tcp_try_coalesce(sk, skb1,
-					    skb, &fragstolen)) {
+		} else if (tcp_ooo_try_coalesce(sk, skb1,
+						skb, &fragstolen)) {
 			goto coalesce_done;
 		}
 		p = &parent->rb_right;


