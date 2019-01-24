Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4F49C282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75354218A6
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548358119;
	bh=PS2fBftkJI0/VZcvshlPgLZoKY8UgCeWZnDyWvKEx30=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Upue+8xkCY5JknwBdJJI44ln6v9qNkNDyEDWx53jN+4la4nDAt0R288MwpLn3K0TQ
	 hqffvw4lNqiQ9PS/RcgUrR/j1M/+fptFmpyLAjxyXdfWOnhvDLQt2HckVH8SxBfn5F
	 p7QCl6OvxaVF1ZaoV6xjWB26etihnw7l4kwq1g/I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731017AbfAXT2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:28:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:55360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730379AbfAXT2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:28:35 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 727B3218A6;
        Thu, 24 Jan 2019 19:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358114;
        bh=PS2fBftkJI0/VZcvshlPgLZoKY8UgCeWZnDyWvKEx30=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UuLqSDOV8BxruUWr5ZnYQtj1lrnV73E1fQtGvCB/AnQkDPp7vwue84u72j7Xcfu5L
         8yG1cgWF2cPqKl7A7uAidAdSWh+bEs5xmNecUVNogk2N1W88J12bxTVekrIw+82WlO
         51ibPKXh+s+YD5iGhKhIOPzPQnf31jncACbQOAvU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Mao Wenan <maowenan@huawei.com>
Subject: [PATCH 4.4 103/104] net: speed up skb_rbtree_purge()
Date:   Thu, 24 Jan 2019 20:20:32 +0100
Message-Id: <20190124190205.798431289@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190154.968308875@linuxfoundation.org>
References: <20190124190154.968308875@linuxfoundation.org>
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

From: Eric Dumazet <edumazet@google.com>

commit 7c90584c66cc4b033a3b684b0e0950f79e7b7166 upstream.

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
Signed-off-by: Mao Wenan <maowenan@huawei.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/core/skbuff.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -2388,12 +2388,15 @@ EXPORT_SYMBOL(skb_queue_purge);
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


