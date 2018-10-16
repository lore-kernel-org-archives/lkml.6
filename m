Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 189A8C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7F7C20866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:25:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rILFYOZ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7F7C20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731904AbeJQBQi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:16:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:35322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730396AbeJQBQh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:16:37 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEE1320866;
        Tue, 16 Oct 2018 17:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710711;
        bh=gsRULgFs11CRW6QCb0FGj4RGOS6VCJaPLJ6LKxSDlcM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rILFYOZ5icb5qDOy4WmHJh0l0+UGO/f4JB0C1vDIzygYg7IveCcdZu3lIFsQ/hkQL
         +wQ++FoSmT7sSg5/IlSy9guirjv4oOCDoT/hrbky3tD9UClD0SzVxmi8P102/iW6Y4
         KVf0F57MYFOuIRr11Gv1N+4bs6yM3965SSqdpXkc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 62/71] net: speed up skb_rbtree_purge()
Date:   Tue, 16 Oct 2018 19:09:59 +0200
Message-Id: <20181016170542.493641718@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170539.315587743@linuxfoundation.org>
References: <20181016170539.315587743@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2433,12 +2433,15 @@ EXPORT_SYMBOL(skb_queue_purge);
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


