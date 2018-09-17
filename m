Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C5CAECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F10D72146F
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:05:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F10D72146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731147AbeIREfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:35:13 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49364 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730492AbeIREfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:35:12 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2466AC49;
        Mon, 17 Sep 2018 23:05:42 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 112/126] net: speed up skb_rbtree_purge()
Date:   Tue, 18 Sep 2018 00:42:40 +0200
Message-Id: <20180917211711.312227776@linuxfoundation.org>
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

From: Eric Dumazet <edumazet@google.com>

As measured in my prior patch ("sch_netem: faster rb tree removal"),
rbtree_postorder_for_each_entry_safe() is nice looking but much slower
than using rb_next() directly, except when tree is small enough
to fit in CPU caches (then the cost is the same)

Also note that there is not even an increase of text size :
$ size net/core/skbuff.o.before net/core/skbuff.o
   text	   data	    bss	    dec	    hex	filename
  40711	   1298	      0	  42009	   a419	net/core/skbuff.o.before
  40711	   1298	      0	  42009	   a419	net/core/skbuff.o

From: Eric Dumazet <edumazet@google.com>

Signed-off-by: David S. Miller <davem@davemloft.net>
(cherry picked from commit 7c90584c66cc4b033a3b684b0e0950f79e7b7166)
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/skbuff.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -2850,12 +2850,15 @@ EXPORT_SYMBOL(skb_queue_purge);
  */
 void skb_rbtree_purge(struct rb_root *root)
 {
-	struct sk_buff *skb, *next;
+	struct rb_node *p = rb_first(root);
 
-	rbtree_postorder_for_each_entry_safe(skb, next, root, rbnode)
-		kfree_skb(skb);
+	while (p) {
+		struct sk_buff *skb = rb_entry(p, struct sk_buff, rbnode);
 
-	*root = RB_ROOT;
+		p = rb_next(p);
+		rb_erase(&skb->rbnode, root);
+		kfree_skb(skb);
+	}
 }
 
 /**


