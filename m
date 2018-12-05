Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05D0C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A00AB214E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pj005Y9a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A00AB214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbeLEKND (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 05:13:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:39326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727836AbeLEJg5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:36:57 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21F5720850;
        Wed,  5 Dec 2018 09:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544002617;
        bh=1bj43Matz2RrQSqqzCO5ShXTaN+MIAVY2/tr2HALc6k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pj005Y9a0h48bRji25KmkAGa2kEoVcZ5upaJOBtnWHm6Ok9mopBIGr/ij/xyDikKU
         LDOEzX6fTnMmsOxJjmjb6jExLyi83/QC1SpkjEYBh5nPer0xy/v2D6m+PuzSYQ7AY5
         TaKGaDon5RlGSEUtmiwTj5skO4EA1aDqpVgTh9CA=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Taehee Yoo <ap420073@gmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 019/123] netfilter: nf_conncount: fix unexpected permanent node of list.
Date:   Wed,  5 Dec 2018 04:34:11 -0500
Message-Id: <20181205093555.5386-19-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205093555.5386-1-sashal@kernel.org>
References: <20181205093555.5386-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Taehee Yoo <ap420073@gmail.com>

[ Upstream commit 3c5cdb17c3be76714dfd0d03e384f70579545614 ]

When list->count is 0, the list is deleted by GC. But list->count is
never reached 0 because initial count value is 1 and it is increased
when node is inserted. So that initial value of list->count should be 0.

Originally GC always finds zero count list through deleting node and
decreasing count. However, list may be left empty since node insertion
may fail eg.  allocaton problem. In order to solve this problem, GC
routine also finds zero count list without deleting node.

Fixes: cb2b36f5a97d ("netfilter: nf_conncount: Switch to plain list")
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_conncount.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/net/netfilter/nf_conncount.c b/net/netfilter/nf_conncount.c
index cb33709138df..8acae4a3e4c0 100644
--- a/net/netfilter/nf_conncount.c
+++ b/net/netfilter/nf_conncount.c
@@ -144,8 +144,10 @@ static bool conn_free(struct nf_conncount_list *list,
 	list->count--;
 	conn->dead = true;
 	list_del_rcu(&conn->node);
-	if (list->count == 0)
+	if (list->count == 0) {
+		list->dead = true;
 		free_entry = true;
+	}
 
 	spin_unlock_bh(&list->list_lock);
 	call_rcu(&conn->rcu_head, __conn_free);
@@ -248,7 +250,7 @@ void nf_conncount_list_init(struct nf_conncount_list *list)
 {
 	spin_lock_init(&list->list_lock);
 	INIT_LIST_HEAD(&list->head);
-	list->count = 1;
+	list->count = 0;
 	list->dead = false;
 }
 EXPORT_SYMBOL_GPL(nf_conncount_list_init);
@@ -262,6 +264,7 @@ bool nf_conncount_gc_list(struct net *net,
 	struct nf_conn *found_ct;
 	unsigned int collected = 0;
 	bool free_entry = false;
+	bool ret = false;
 
 	list_for_each_entry_safe(conn, conn_n, &list->head, node) {
 		found = find_or_evict(net, list, conn, &free_entry);
@@ -291,7 +294,15 @@ bool nf_conncount_gc_list(struct net *net,
 		if (collected > CONNCOUNT_GC_MAX_NODES)
 			return false;
 	}
-	return false;
+
+	spin_lock_bh(&list->list_lock);
+	if (!list->count) {
+		list->dead = true;
+		ret = true;
+	}
+	spin_unlock_bh(&list->list_lock);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(nf_conncount_gc_list);
 
@@ -417,6 +428,7 @@ insert_tree(struct net *net,
 	nf_conncount_list_init(&rbconn->list);
 	list_add(&conn->node, &rbconn->list.head);
 	count = 1;
+	rbconn->list.count = count;
 
 	rb_link_node(&rbconn->node, parent, rbnode);
 	rb_insert_color(&rbconn->node, root);
-- 
2.17.1

