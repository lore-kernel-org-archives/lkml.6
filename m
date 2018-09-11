Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153A8C04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 13:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C055C20839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 13:25:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C055C20839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbeIKSYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 14:24:48 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:41035 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726689AbeIKSYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 14:24:48 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8681EF948BD17;
        Tue, 11 Sep 2018 21:25:26 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.399.0; Tue, 11 Sep 2018 21:25:26 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <davem@davemloft.net>, <edumazet@google.com>
CC:     <kuznet@ms2.inr.ac.ru>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCHv2] net: ipv4: Use BUG_ON directly instead of a if condition followed by BUG
Date:   Tue, 11 Sep 2018 21:13:13 +0800
Message-ID: <1536671593-14746-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The if condition can be removed if we use BUG_ON directly.
The issule is detected with the help of Coccinelle.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 net/ipv4/tcp_input.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 62508a2..526c05e 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -4934,8 +4934,8 @@ void tcp_rbtree_insert(struct rb_root *root, struct sk_buff *skb)
 			BUG_ON(offset < 0);
 			if (size > 0) {
 				size = min(copy, size);
-				if (skb_copy_bits(skb, offset, skb_put(nskb, size), size))
-					BUG();
+				BUG_ON(skb_copy_bits(skb, offset,
+						     skb_put(nskb, size), size));
 				TCP_SKB_CB(nskb)->end_seq += size;
 				copy -= size;
 				start += size;
@@ -5327,8 +5327,8 @@ static void tcp_urg(struct sock *sk, struct sk_buff *skb, const struct tcphdr *t
 		/* Is the urgent pointer pointing into this packet? */
 		if (ptr < skb->len) {
 			u8 tmp;
-			if (skb_copy_bits(skb, ptr, &tmp, 1))
-				BUG();
+
+			BUG_ON(skb_copy_bits(skb, ptr, &tmp, 1));
 			tp->urg_data = TCP_URG_VALID | tmp;
 			if (!sock_flag(sk, SOCK_DEAD))
 				sk->sk_data_ready(sk);
-- 
1.7.12.4

