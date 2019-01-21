Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6EBEC2F3A0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88D5E20879
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548079200;
	bh=njLAZT81n5lObx+g/QKTaX8FWFSaEbSIauG/5mFcyu0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zrDeyAru7FoOwqZ/Rp6PqX4PENprqC1sIupgmPhSMfgNUlM6ig5XeE5o2Xu8D2vlQ
	 r3KjkFcu9GkEbj4fPki3VKovW7BHFXl8QMBV4kREQhGsM5PdEI7/nyGAX08eSHFKv5
	 LXThXXwAN9dmJ/9FLURKURThDQn77U+6F1h+6W6E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732291AbfAUN77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:59:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:46150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732276AbfAUN7y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:59:54 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC09520879;
        Mon, 21 Jan 2019 13:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548079193;
        bh=njLAZT81n5lObx+g/QKTaX8FWFSaEbSIauG/5mFcyu0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vRF+ZcoWL5YLvkGYoflRYBiNxMI/QfJYu9ti3XLwr4pA0sCw8Z06BmVWs/j51QQKP
         sxzKiF2yvYzcdbO++wmkqmGOFvB/0kfu2+I5jBTyfkavt9dFEDgbwYhW6aNzXQXZ8o
         uHTKbFeGp2Z+gZHJIantvH7YwFGVLllNPuWxJ62k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Florian Westphal <fw@strlen.de>,
        Shawn Bohrer <sbohrer@cloudflare.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH 4.19 06/99] netfilter: nf_conncount: replace CONNCOUNT_LOCK_SLOTS with CONNCOUNT_SLOTS
Date:   Mon, 21 Jan 2019 14:47:58 +0100
Message-Id: <20190121134914.168149053@linuxfoundation.org>
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

From: Shawn Bohrer <sbohrer@cloudflare.com>

commit c78e7818f16f687389174c4569243abbec8dc68f upstream.

Most of the time these were the same value anyway, but when
CONFIG_LOCKDEP was enabled we would use a smaller number of locks to
reduce overhead.  Unfortunately having two values is confusing and not
worth the complexity.

This fixes a bug where tree_gc_worker() would only GC up to
CONNCOUNT_LOCK_SLOTS trees which meant when CONFIG_LOCKDEP was enabled
not all trees would be GCed by tree_gc_worker().

Fixes: 5c789e131cbb9 ("netfilter: nf_conncount: Add list lock and gc worker, and RCU for init tree search")
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Shawn Bohrer <sbohrer@cloudflare.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/netfilter/nf_conncount.c |   19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

--- a/net/netfilter/nf_conncount.c
+++ b/net/netfilter/nf_conncount.c
@@ -33,12 +33,6 @@
 
 #define CONNCOUNT_SLOTS		256U
 
-#ifdef CONFIG_LOCKDEP
-#define CONNCOUNT_LOCK_SLOTS	8U
-#else
-#define CONNCOUNT_LOCK_SLOTS	256U
-#endif
-
 #define CONNCOUNT_GC_MAX_NODES	8
 #define MAX_KEYLEN		5
 
@@ -60,7 +54,7 @@ struct nf_conncount_rb {
 	struct rcu_head rcu_head;
 };
 
-static spinlock_t nf_conncount_locks[CONNCOUNT_LOCK_SLOTS] __cacheline_aligned_in_smp;
+static spinlock_t nf_conncount_locks[CONNCOUNT_SLOTS] __cacheline_aligned_in_smp;
 
 struct nf_conncount_data {
 	unsigned int keylen;
@@ -353,7 +347,7 @@ insert_tree(struct net *net,
 	unsigned int count = 0, gc_count = 0;
 	bool node_found = false;
 
-	spin_lock_bh(&nf_conncount_locks[hash % CONNCOUNT_LOCK_SLOTS]);
+	spin_lock_bh(&nf_conncount_locks[hash]);
 
 	parent = NULL;
 	rbnode = &(root->rb_node);
@@ -430,7 +424,7 @@ insert_tree(struct net *net,
 	rb_link_node_rcu(&rbconn->node, parent, rbnode);
 	rb_insert_color(&rbconn->node, root);
 out_unlock:
-	spin_unlock_bh(&nf_conncount_locks[hash % CONNCOUNT_LOCK_SLOTS]);
+	spin_unlock_bh(&nf_conncount_locks[hash]);
 	return count;
 }
 
@@ -499,7 +493,7 @@ static void tree_gc_worker(struct work_s
 	struct rb_node *node;
 	unsigned int tree, next_tree, gc_count = 0;
 
-	tree = data->gc_tree % CONNCOUNT_LOCK_SLOTS;
+	tree = data->gc_tree % CONNCOUNT_SLOTS;
 	root = &data->root[tree];
 
 	rcu_read_lock();
@@ -621,10 +615,7 @@ static int __init nf_conncount_modinit(v
 {
 	int i;
 
-	BUILD_BUG_ON(CONNCOUNT_LOCK_SLOTS > CONNCOUNT_SLOTS);
-	BUILD_BUG_ON((CONNCOUNT_SLOTS % CONNCOUNT_LOCK_SLOTS) != 0);
-
-	for (i = 0; i < CONNCOUNT_LOCK_SLOTS; ++i)
+	for (i = 0; i < CONNCOUNT_SLOTS; ++i)
 		spin_lock_init(&nf_conncount_locks[i]);
 
 	conncount_conn_cachep = kmem_cache_create("nf_conncount_tuple",


