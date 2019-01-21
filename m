Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA9EC2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CC6D20861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548078452;
	bh=woFZSJAEiwJ2ET855R4gzGvSEnzpWKt9sFfmfDNpyqk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aiYxKcY+eEyI/3yXQ/6H/is+YFXtfGNXPzs7zOF6FajJhau6PXNFMC+Ezr6zQtBTV
	 RMYK+FlT6Mt+t/CHVMieC/IJ3oqHZJ7k5olDeDAK5rFPgi6IXrQQs3SdAQ+djPvLNE
	 f+inXOwvBQNmpEd36//cTaGOQWjoiMJxk9CGvSsM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729623AbfAUNra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:47:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:56826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729117AbfAUNr2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:47:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC7BE20861;
        Mon, 21 Jan 2019 13:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078448;
        bh=woFZSJAEiwJ2ET855R4gzGvSEnzpWKt9sFfmfDNpyqk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hJvhzS058F/C0LCzawG06utlmz/agxbEskxiYACJLO55ynIljhJTVS/H8ouxHTZi2
         l+lvVvB3uinR0IIr71MPK2eQtQTPSO4QhzR3PYy+2JwnFOqm7kjdB5SA82ch2zFQkz
         aQoV2Df/PXQWYVNnAz6nUScsw8o/2to9P1Xdze3M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shawn Bohrer <sbohrer@cloudflare.com>,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.20 008/111] netfilter: nf_conncount: split gc in two phases
Date:   Mon, 21 Jan 2019 14:42:02 +0100
Message-Id: <20190121122456.690054934@linuxfoundation.org>
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

commit f7fcc98dfc2d136722007fec0debbed761679b94 upstream.

The lockless workqueue garbage collector can race with packet path
garbage collector to delete list nodes, as it calls tree_nodes_free()
with the addresses of nodes that might have been free'd already from
another cpu.

To fix this, split gc into two phases.

One phase to perform gc on the connections: From a locking perspective,
this is the same as count_tree(): we hold rcu lock, but we do not
change the tree, we only change the nodes' contents.

The second phase acquires the tree lock and reaps empty nodes.
This avoids a race condition of the garbage collection vs.  packet path:
If a node has been free'd already, the second phase won't find it anymore.

This second phase is, from locking perspective, same as insert_tree().

The former only modifies nodes (list content, count), latter modifies
the tree itself (rb_erase or rb_insert).

Fixes: 5c789e131cbb9 ("netfilter: nf_conncount: Add list lock and gc worker, and RCU for init tree search")
Reviewed-by: Shawn Bohrer <sbohrer@cloudflare.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/netfilter/nf_conncount.c |   22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

--- a/net/netfilter/nf_conncount.c
+++ b/net/netfilter/nf_conncount.c
@@ -500,16 +500,32 @@ static void tree_gc_worker(struct work_s
 	for (node = rb_first(root); node != NULL; node = rb_next(node)) {
 		rbconn = rb_entry(node, struct nf_conncount_rb, node);
 		if (nf_conncount_gc_list(data->net, &rbconn->list))
-			gc_nodes[gc_count++] = rbconn;
+			gc_count++;
 	}
 	rcu_read_unlock();
 
 	spin_lock_bh(&nf_conncount_locks[tree]);
+	if (gc_count < ARRAY_SIZE(gc_nodes))
+		goto next; /* do not bother */
 
-	if (gc_count) {
-		tree_nodes_free(root, gc_nodes, gc_count);
+	gc_count = 0;
+	node = rb_first(root);
+	while (node != NULL) {
+		rbconn = rb_entry(node, struct nf_conncount_rb, node);
+		node = rb_next(node);
+
+		if (rbconn->list.count > 0)
+			continue;
+
+		gc_nodes[gc_count++] = rbconn;
+		if (gc_count >= ARRAY_SIZE(gc_nodes)) {
+			tree_nodes_free(root, gc_nodes, gc_count);
+			gc_count = 0;
+		}
 	}
 
+	tree_nodes_free(root, gc_nodes, gc_count);
+next:
 	clear_bit(tree, data->pending_trees);
 
 	next_tree = (tree + 1) % CONNCOUNT_SLOTS;


