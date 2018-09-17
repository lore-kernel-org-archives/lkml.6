Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E44ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 611AF20867
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:05:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 611AF20867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731155AbeIREfQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:35:16 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49372 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730492AbeIREfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:35:16 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3F57DC49;
        Mon, 17 Sep 2018 23:05:46 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Peter Oskolkov <posk@google.com>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 113/126] net: modify skb_rbtree_purge to return the truesize of all purged skbs.
Date:   Tue, 18 Sep 2018 00:42:41 +0200
Message-Id: <20180917211711.398353401@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211703.481236999@linuxfoundation.org>
References: <20180917211703.481236999@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Oskolkov <posk@google.com>

Tested: see the next patch is the series.

Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Peter Oskolkov <posk@google.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Florian Westphal <fw@strlen.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
(cherry picked from commit 385114dec8a49b5e5945e77ba7de6356106713f4)
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/skbuff.h |    2 +-
 net/core/skbuff.c      |    6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -2581,7 +2581,7 @@ static inline void __skb_queue_purge(str
 		kfree_skb(skb);
 }
 
-void skb_rbtree_purge(struct rb_root *root);
+unsigned int skb_rbtree_purge(struct rb_root *root);
 
 void *netdev_alloc_frag(unsigned int fragsz);
 
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -2842,23 +2842,27 @@ EXPORT_SYMBOL(skb_queue_purge);
 /**
  *	skb_rbtree_purge - empty a skb rbtree
  *	@root: root of the rbtree to empty
+ *	Return value: the sum of truesizes of all purged skbs.
  *
  *	Delete all buffers on an &sk_buff rbtree. Each buffer is removed from
  *	the list and one reference dropped. This function does not take
  *	any lock. Synchronization should be handled by the caller (e.g., TCP
  *	out-of-order queue is protected by the socket lock).
  */
-void skb_rbtree_purge(struct rb_root *root)
+unsigned int skb_rbtree_purge(struct rb_root *root)
 {
 	struct rb_node *p = rb_first(root);
+	unsigned int sum = 0;
 
 	while (p) {
 		struct sk_buff *skb = rb_entry(p, struct sk_buff, rbnode);
 
 		p = rb_next(p);
 		rb_erase(&skb->rbnode, root);
+		sum += skb->truesize;
 		kfree_skb(skb);
 	}
+	return sum;
 }
 
 /**


