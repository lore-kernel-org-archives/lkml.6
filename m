Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A67C070C3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2879921477
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 08:14:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2879921477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbeINN1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 09:27:55 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:12133 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726918AbeINN1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 09:27:54 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D8BC02859DF68;
        Fri, 14 Sep 2018 16:14:29 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.399.0; Fri, 14 Sep 2018 16:14:25 +0800
From:   Mao Wenan <maowenan@huawei.com>
To:     <netdev@vger.kernel.org>, <gregkh@linux-foundation.org>,
        <dwmw2@infradead.org>, <eric.dumazet@gmail.com>,
        <davem@davemloft.net>, <stable@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <maowenan@huawei.com>
Subject: [PATCH stable 4.4 V2 6/6] tcp: add tcp_ooo_try_coalesce() helper
Date:   Fri, 14 Sep 2018 16:24:10 +0800
Message-ID: <1536913450-12380-7-git-send-email-maowenan@huawei.com>
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
Signed-off-by: Mao Wenan <maowenan@huawei.com>
---
 net/ipv4/tcp_input.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index cbe0ca0..1aff93d 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4296,6 +4296,23 @@ static bool tcp_try_coalesce(struct sock *sk,
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
@@ -4422,7 +4439,8 @@ static void tcp_data_queue_ofo(struct sock *sk, struct sk_buff *skb)
 	/* In the typical case, we are adding an skb to the end of the list.
 	 * Use of ooo_last_skb avoids the O(Log(N)) rbtree lookup.
 	 */
-	if (tcp_try_coalesce(sk, tp->ooo_last_skb, skb, &fragstolen)) {
+	if (tcp_ooo_try_coalesce(sk, tp->ooo_last_skb,
+				 skb, &fragstolen)) {
 coalesce_done:
 		tcp_grow_window(sk, skb);
 		kfree_skb_partial(skb, fragstolen);
@@ -4467,7 +4485,8 @@ coalesce_done:
 				tcp_drop(sk, skb1);
 				goto merge_right;
 			}
-		} else if (tcp_try_coalesce(sk, skb1, skb, &fragstolen)) {
+		} else if (tcp_ooo_try_coalesce(sk, skb1,
+						skb, &fragstolen)) {
 			goto coalesce_done;
 		}
 		p = &parent->rb_right;
-- 
1.8.3.1

