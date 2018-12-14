Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C144DC67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 809422146E
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544788961;
	bh=biMN0VFApf2zL4ODT6/ZCtAji4e2ybb3eXZPvN5KYaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gPF5s6OYdJ9+mR23Xriazv9yX8hHamTHrvZQjIOk7G4KT/T5BHWiiZpSnVUBHXVsj
	 gnuT2ZuuWDRE+ObfrPVDFq04M0iZNxWSwSk8HvDXOrueBb+gOf7jLiHbCYXAge46Dl
	 ceYHf1gV8i9cIie6hN03jifJ6UNCj6gF/hExPdy8=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 809422146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730120AbeLNMCk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:02:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:45660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730102AbeLNMCj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:02:39 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E934921479;
        Fri, 14 Dec 2018 12:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544788958;
        bh=biMN0VFApf2zL4ODT6/ZCtAji4e2ybb3eXZPvN5KYaA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r03YFsHpkNoZ7phImfHsAEwOlFFqYZAsO3j301Xiw1fbqzUPbCskKitTkwlx2Kb9x
         ZemDPk1yVOMLSQ0HznsocpdKb83wOOsCc0Sd7+pcg0ohfmmtlfgf4J6QO8bre/UtwL
         6stUh4SkikLYdT8wB1elV2N9jo2vlq7yRFXuzZFM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Taehee Yoo <ap420073@gmail.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 038/142] netfilter: nf_conncount: fix unexpected permanent node of list.
Date:   Fri, 14 Dec 2018 12:58:43 +0100
Message-Id: <20181214115748.570313917@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115747.053633987@linuxfoundation.org>
References: <20181214115747.053633987@linuxfoundation.org>
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
2.19.1



