Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A690C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58D002087C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549276918;
	bh=5bQLVGch1lcHOAwgQqr39sliSSQr05lIOaQKTfjukxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=J2bIi5X3/CBgwfketzj0FSOzOeaSlO0aW/6ZVclDL+SBuB8l+R5cMgFh48ko/1Uds
	 Vmmh0JLWU5UxgRHHCOvvGr3hKf/Nz/90S8gdwh1jf0vLjG5kZQvYEs8n/9ROYa1/z6
	 FOVc4CxsZV945NPEAOKnJP4uhIGXdZ4CkCPx9p70=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730423AbfBDKl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:41:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:39842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728963AbfBDKly (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:41:54 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 928A0217FA;
        Mon,  4 Feb 2019 10:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549276914;
        bh=5bQLVGch1lcHOAwgQqr39sliSSQr05lIOaQKTfjukxA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D4qoUGN8QUWlLECVRghWP72mdQILJm3IazmtD0Oo3ZTBV6ow/RiYf6N/QqFTrgEMB
         4vbbcoXvlN3VIls7nWhARryefzojb7bztjoOIybkEkvPo5zFvseGy2Veg/oTK5hHIl
         1ulkHwewj7YDaHdXjaYC5mwH1NCC8TX35/d/Tfcs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Peter Oskolkov <posk@google.com>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        Mao Wenan <maowenan@huawei.com>
Subject: [PATCH 4.4 57/65] net: modify skb_rbtree_purge to return the truesize of all purged skbs.
Date:   Mon,  4 Feb 2019 11:36:50 +0100
Message-Id: <20190204103619.936365012@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103610.583715954@linuxfoundation.org>
References: <20190204103610.583715954@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Oskolkov <posk@google.com>

commit 385114dec8a49b5e5945e77ba7de6356106713f4 upstream.

Tested: see the next patch is the series.

Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Peter Oskolkov <posk@google.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Florian Westphal <fw@strlen.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Mao Wenan <maowenan@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/skbuff.h |    2 +-
 net/core/skbuff.c      |    6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -2273,7 +2273,7 @@ static inline void __skb_queue_purge(str
 		kfree_skb(skb);
 }
 
-void skb_rbtree_purge(struct rb_root *root);
+unsigned int skb_rbtree_purge(struct rb_root *root);
 
 void *netdev_alloc_frag(unsigned int fragsz);
 
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -2380,23 +2380,27 @@ EXPORT_SYMBOL(skb_queue_purge);
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


