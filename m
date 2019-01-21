Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A009C2F3DC
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6ACDB20861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548080418;
	bh=XRLkbw3eom5RAmdyzD1P6uSzLpujbwrQO77EWJvTNow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=g2sBEyOoxYb9sPMK3fMZeEEw2RGe4lT+ILhjyBrHSz0WkrVZa26/l1zvfByIG5Z4p
	 lGnzVTZoVe6eOAUzvUmfJkfhVxEP1UG6knSyS4Ty4XFmjF0bdnMtWcBxRrkNXJnnQ9
	 V+vBD0y7XiBUt8k8dPb57JVLY1Ppv6Hp8F0AQvbY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729929AbfAUOUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:20:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:57666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729776AbfAUNsA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:48:00 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B0052063F;
        Mon, 21 Jan 2019 13:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078479;
        bh=XRLkbw3eom5RAmdyzD1P6uSzLpujbwrQO77EWJvTNow=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q5A/yuq43ZR2LIn07p8nzaboxBCgi+BiNGuMjXXyoolTYhIaC18h/aOD/G4ANi6Tb
         0U3wIo/yPuwSLUKpCMGYxU59s1D6OL1dxcDNiF8I0ZymgUQu5oYUCOEkZ/70FGZde1
         H3B25w+o7b8UIcYcb+7BDTy3pHtZcqEk/v6KZwss=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shawn Bohrer <sbohrer@cloudflare.com>,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.20 009/111] netfilter: nf_conncount: restart search when nodes have been erased
Date:   Mon, 21 Jan 2019 14:42:03 +0100
Message-Id: <20190121122456.772949916@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121122455.819406896@linuxfoundation.org>
References: <20190121122455.819406896@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Florian Westphal <fw@strlen.de>

commit e8cfb372b38a1b8979aa7f7631fb5e7b11c3793c upstream.

Shawn Bohrer reported a following crash:
 |RIP: 0010:rb_erase+0xae/0x360
 [..]
 Call Trace:
  nf_conncount_destroy+0x59/0xc0 [nf_conncount]
  cleanup_match+0x45/0x70 [ip_tables]
  ...

Shawn tracked this down to bogus 'parent' pointer:
Problem is that when we insert a new node, then there is a chance that
the 'parent' that we found was also passed to tree_nodes_free() (because
that node was empty) for erase+free.

Instead of trying to be clever and detect when this happens, restart
the search if we have evicted one or more nodes.  To prevent frequent
restarts, do not perform gc on the second round.

Also, unconditionally schedule the gc worker.
The condition

  gc_count > ARRAY_SIZE(gc_nodes))

cannot be true unless tree grows very large, as the height of the tree
will be low even with hundreds of nodes present.

Fixes: 5c789e131cbb9 ("netfilter: nf_conncount: Add list lock and gc worker, and RCU for init tree search")
Reported-by: Shawn Bohrer <sbohrer@cloudflare.com>
Reviewed-by: Shawn Bohrer <sbohrer@cloudflare.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/netfilter/nf_conncount.c |   18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

--- a/net/netfilter/nf_conncount.c
+++ b/net/netfilter/nf_conncount.c
@@ -346,9 +346,10 @@ insert_tree(struct net *net,
 	struct nf_conncount_tuple *conn;
 	unsigned int count = 0, gc_count = 0;
 	bool node_found = false;
+	bool do_gc = true;
 
 	spin_lock_bh(&nf_conncount_locks[hash]);
-
+restart:
 	parent = NULL;
 	rbnode = &(root->rb_node);
 	while (*rbnode) {
@@ -381,21 +382,16 @@ insert_tree(struct net *net,
 		if (gc_count >= ARRAY_SIZE(gc_nodes))
 			continue;
 
-		if (nf_conncount_gc_list(net, &rbconn->list))
+		if (do_gc && nf_conncount_gc_list(net, &rbconn->list))
 			gc_nodes[gc_count++] = rbconn;
 	}
 
 	if (gc_count) {
 		tree_nodes_free(root, gc_nodes, gc_count);
-		/* tree_node_free before new allocation permits
-		 * allocator to re-use newly free'd object.
-		 *
-		 * This is a rare event; in most cases we will find
-		 * existing node to re-use. (or gc_count is 0).
-		 */
-
-		if (gc_count >= ARRAY_SIZE(gc_nodes))
-			schedule_gc_worker(data, hash);
+		schedule_gc_worker(data, hash);
+		gc_count = 0;
+		do_gc = false;
+		goto restart;
 	}
 
 	if (node_found)


