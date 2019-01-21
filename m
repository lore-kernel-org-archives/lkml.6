Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41E27C2F3CD
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FD0B20989
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548079208;
	bh=iFLA/yE+pk7cfPYEDCbQJRkxwF+M5Uq9JduBAy4HCv8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EKwa/eHSs9DOaZ7sLF35CsCXPvxTpbDMSzyflO9HSeAkFYmXvjkMexxUQruRt1XuX
	 EDW97NrPRG8Cf7jqKhymrfYmGSPsd803pFialaHdC2mfFoq27+D0QNPEKpzMLFJr8y
	 ai28fjRln+DslIx2LlRh4KwFuTbbWH6a5MEPSRoA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732318AbfAUOAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:00:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:46392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732301AbfAUOAD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 09:00:03 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0994D20879;
        Mon, 21 Jan 2019 14:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548079202;
        bh=iFLA/yE+pk7cfPYEDCbQJRkxwF+M5Uq9JduBAy4HCv8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CwL29NAL5vIKo5CMg8op5fDRnTq6IrTc8iXQosIy+8QymSmPdLmvUFfe/SKIWUUk9
         /kRRkRTCxVvA4ouqmOdYLF1YeBQLAD6o/K+9jNzQT25mHohjxX2P9+M6RFUKan0a3x
         k1CH+NKWcTimn7KcslScAf4h3CrxvLVblVa0AH5g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Shawn Bohrer <sbohrer@cloudflare.com>,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.19 09/99] netfilter: nf_conncount: restart search when nodes have been erased
Date:   Mon, 21 Jan 2019 14:48:01 +0100
Message-Id: <20190121134914.273684405@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121134913.924726465@linuxfoundation.org>
References: <20190121134913.924726465@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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


