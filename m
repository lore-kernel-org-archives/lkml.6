Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C9FBC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9CDF208E7
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 19:19:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9CDF208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbeLFTTH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 14:19:07 -0500
Received: from smtp2.provo.novell.com ([137.65.250.81]:40237 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbeLFTSl (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Thu, 6 Dec 2018 14:18:41 -0500
Received: from linux-r8p5.suse.de (prv-ext-foundry1int.gns.novell.com [137.65.251.240])
        by smtp2.provo.novell.com with ESMTP (TLS encrypted); Thu, 06 Dec 2018 12:18:31 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     acme@kernel.org
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, dave@stgolabs.net,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 3/7] perf callchain: Use cached rbtrees
Date:   Thu,  6 Dec 2018 11:18:15 -0800
Message-Id: <20181206191819.30182-4-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20181206191819.30182-1-dave@stgolabs.net>
References: <20181206191819.30182-1-dave@stgolabs.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the cost of an extra pointer, we can avoid the O(logN) cost
of finding the first element in the tree (smallest node), which
is something required for nearly every in/srcline callchain node
deletion (in/srcline__tree_delete()).

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 tools/perf/util/dso.c     |  4 ++--
 tools/perf/util/dso.h     |  4 ++--
 tools/perf/util/srcline.c | 43 +++++++++++++++++++++++++------------------
 tools/perf/util/srcline.h | 13 +++++++------
 4 files changed, 36 insertions(+), 28 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index bbed90e5d9bb..31edcc1d8661 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1197,8 +1197,8 @@ struct dso *dso__new(const char *name)
 		dso__set_short_name(dso, dso->name, false);
 		dso->symbols = dso->symbol_names = RB_ROOT;
 		dso->data.cache = RB_ROOT;
-		dso->inlined_nodes = RB_ROOT;
-		dso->srclines = RB_ROOT;
+		dso->inlined_nodes = RB_ROOT_CACHED;
+		dso->srclines = RB_ROOT_CACHED;
 		dso->data.fd = -1;
 		dso->data.status = DSO_DATA_STATUS_UNKNOWN;
 		dso->symtab_type = DSO_BINARY_TYPE__NOT_FOUND;
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index c5380500bed4..935fe99b38a8 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -142,8 +142,8 @@ struct dso {
 	struct rb_root	 *root;		/* root of rbtree that rb_node is in */
 	struct rb_root	 symbols;
 	struct rb_root	 symbol_names;
-	struct rb_root	 inlined_nodes;
-	struct rb_root	 srclines;
+	struct rb_root_cached inlined_nodes;
+	struct rb_root_cached srclines;
 	struct {
 		u64		addr;
 		struct symbol	*symbol;
diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
index e767c4a9d4d2..41ced7f65c03 100644
--- a/tools/perf/util/srcline.c
+++ b/tools/perf/util/srcline.c
@@ -566,11 +566,12 @@ struct srcline_node {
 	struct rb_node		rb_node;
 };
 
-void srcline__tree_insert(struct rb_root *tree, u64 addr, char *srcline)
+void srcline__tree_insert(struct rb_root_cached *tree, u64 addr, char *srcline)
 {
-	struct rb_node **p = &tree->rb_node;
+	struct rb_node **p = &tree->rb_root.rb_node;
 	struct rb_node *parent = NULL;
 	struct srcline_node *i, *node;
+	bool leftmost = true;
 
 	node = zalloc(sizeof(struct srcline_node));
 	if (!node) {
@@ -586,16 +587,18 @@ void srcline__tree_insert(struct rb_root *tree, u64 addr, char *srcline)
 		i = rb_entry(parent, struct srcline_node, rb_node);
 		if (addr < i->addr)
 			p = &(*p)->rb_left;
-		else
+		else {
 			p = &(*p)->rb_right;
+			leftmost = false;
+		}
 	}
 	rb_link_node(&node->rb_node, parent, p);
-	rb_insert_color(&node->rb_node, tree);
+	rb_insert_color_cached(&node->rb_node, tree, leftmost);
 }
 
-char *srcline__tree_find(struct rb_root *tree, u64 addr)
+char *srcline__tree_find(struct rb_root_cached *tree, u64 addr)
 {
-	struct rb_node *n = tree->rb_node;
+	struct rb_node *n = tree->rb_root.rb_node;
 
 	while (n) {
 		struct srcline_node *i = rb_entry(n, struct srcline_node,
@@ -612,15 +615,15 @@ char *srcline__tree_find(struct rb_root *tree, u64 addr)
 	return NULL;
 }
 
-void srcline__tree_delete(struct rb_root *tree)
+void srcline__tree_delete(struct rb_root_cached *tree)
 {
 	struct srcline_node *pos;
-	struct rb_node *next = rb_first(tree);
+	struct rb_node *next = rb_first_cached(tree);
 
 	while (next) {
 		pos = rb_entry(next, struct srcline_node, rb_node);
 		next = rb_next(&pos->rb_node);
-		rb_erase(&pos->rb_node, tree);
+		rb_erase_cached(&pos->rb_node, tree);
 		free_srcline(pos->srcline);
 		zfree(&pos);
 	}
@@ -654,28 +657,32 @@ void inline_node__delete(struct inline_node *node)
 	free(node);
 }
 
-void inlines__tree_insert(struct rb_root *tree, struct inline_node *inlines)
+void inlines__tree_insert(struct rb_root_cached *tree,
+			  struct inline_node *inlines)
 {
-	struct rb_node **p = &tree->rb_node;
+	struct rb_node **p = &tree->rb_root.rb_node;
 	struct rb_node *parent = NULL;
 	const u64 addr = inlines->addr;
 	struct inline_node *i;
+	bool leftmost = true;
 
 	while (*p != NULL) {
 		parent = *p;
 		i = rb_entry(parent, struct inline_node, rb_node);
 		if (addr < i->addr)
 			p = &(*p)->rb_left;
-		else
+		else {
 			p = &(*p)->rb_right;
+			leftmost = false;
+		}
 	}
 	rb_link_node(&inlines->rb_node, parent, p);
-	rb_insert_color(&inlines->rb_node, tree);
+	rb_insert_color_cached(&inlines->rb_node, tree, leftmost);
 }
 
-struct inline_node *inlines__tree_find(struct rb_root *tree, u64 addr)
+struct inline_node *inlines__tree_find(struct rb_root_cached *tree, u64 addr)
 {
-	struct rb_node *n = tree->rb_node;
+	struct rb_node *n = tree->rb_root.rb_node;
 
 	while (n) {
 		struct inline_node *i = rb_entry(n, struct inline_node,
@@ -692,15 +699,15 @@ struct inline_node *inlines__tree_find(struct rb_root *tree, u64 addr)
 	return NULL;
 }
 
-void inlines__tree_delete(struct rb_root *tree)
+void inlines__tree_delete(struct rb_root_cached *tree)
 {
 	struct inline_node *pos;
-	struct rb_node *next = rb_first(tree);
+	struct rb_node *next = rb_first_cached(tree);
 
 	while (next) {
 		pos = rb_entry(next, struct inline_node, rb_node);
 		next = rb_next(&pos->rb_node);
-		rb_erase(&pos->rb_node, tree);
+		rb_erase_cached(&pos->rb_node, tree);
 		inline_node__delete(pos);
 	}
 }
diff --git a/tools/perf/util/srcline.h b/tools/perf/util/srcline.h
index b2bb5502fd62..c77646f057bf 100644
--- a/tools/perf/util/srcline.h
+++ b/tools/perf/util/srcline.h
@@ -18,11 +18,11 @@ char *__get_srcline(struct dso *dso, u64 addr, struct symbol *sym,
 void free_srcline(char *srcline);
 
 /* insert the srcline into the DSO, which will take ownership */
-void srcline__tree_insert(struct rb_root *tree, u64 addr, char *srcline);
+void srcline__tree_insert(struct rb_root_cached *tree, u64 addr, char *srcline);
 /* find previously inserted srcline */
-char *srcline__tree_find(struct rb_root *tree, u64 addr);
+char *srcline__tree_find(struct rb_root_cached *tree, u64 addr);
 /* delete all srclines within the tree */
-void srcline__tree_delete(struct rb_root *tree);
+void srcline__tree_delete(struct rb_root_cached *tree);
 
 #define SRCLINE_UNKNOWN  ((char *) "??:0")
 
@@ -45,10 +45,11 @@ struct inline_node *dso__parse_addr_inlines(struct dso *dso, u64 addr,
 void inline_node__delete(struct inline_node *node);
 
 /* insert the inline node list into the DSO, which will take ownership */
-void inlines__tree_insert(struct rb_root *tree, struct inline_node *inlines);
+void inlines__tree_insert(struct rb_root_cached *tree,
+			  struct inline_node *inlines);
 /* find previously inserted inline node list */
-struct inline_node *inlines__tree_find(struct rb_root *tree, u64 addr);
+struct inline_node *inlines__tree_find(struct rb_root_cached *tree, u64 addr);
 /* delete all nodes within the tree of inline_node s */
-void inlines__tree_delete(struct rb_root *tree);
+void inlines__tree_delete(struct rb_root_cached *tree);
 
 #endif /* PERF_SRCLINE_H */
-- 
2.16.4

