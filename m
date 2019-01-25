Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC3E1C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 745EE20844
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548458366;
	bh=cRNOaUHEEQiyT0SJBI3sgJBY4BbYL1S8QZqkXn3Nyzw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=S5N71nV9jRRwka1Hx/dWhOJQ4TiCFBbvKZ771ycd9Dls1fFGgq+JoUMa2tRRJEOvK
	 coM+RtZEyHbSRzOwsFWVIyTh0JBmfZ/xc3qPU/hj2VD+2CfJRsx+JXfQ67koATsmOu
	 QttZiSBwDZG2UNI7+USb9JavRjatpezwHYvfC7b4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729839AbfAYXTZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 18:19:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:47786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729783AbfAYXTR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 18:19:17 -0500
Received: from quaco.cust.in.nbox.cz (unknown [95.82.135.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC70321904;
        Fri, 25 Jan 2019 23:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548458355;
        bh=cRNOaUHEEQiyT0SJBI3sgJBY4BbYL1S8QZqkXn3Nyzw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mRUc9nwsWqTyc70uKSAzkWVwstGS4MEe4ILAcTcR5zBug59NX4IkPc7QIJvY/IJf4
         umSfQR7pQt5K177QGE7h22pz65mjdctBJ0XQOHfBrqJKzLhAQC7/3S3aqYUpxwdy+f
         sV8Ag+ces99EDyozUHGZBjK/ZlYJXv0zse32SqgU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Davidlohr Bueso <dave@stgolabs.net>,
        Davidlohr Bueso <dbueso@suse.de>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH 12/29] perf callchain: Use cached rbtrees
Date:   Sat, 26 Jan 2019 00:18:26 +0100
Message-Id: <20190125231843.2895-13-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190125231843.2895-1-acme@kernel.org>
References: <20190125231843.2895-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Davidlohr Bueso <dave@stgolabs.net>

At the cost of an extra pointer, we can avoid the O(logN) cost of
finding the first element in the tree (smallest node), which is
something required for nearly every in/srcline callchain node deletion
(in/srcline__tree_delete()).

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lkml.kernel.org/r/20181206191819.30182-4-dave@stgolabs.net
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/dso.c     |  4 ++--
 tools/perf/util/dso.h     |  4 ++--
 tools/perf/util/srcline.c | 43 +++++++++++++++++++++++----------------
 tools/perf/util/srcline.h | 13 ++++++------
 4 files changed, 36 insertions(+), 28 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 8cbbb5be4a0b..a82bbf6e24e0 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1198,8 +1198,8 @@ struct dso *dso__new(const char *name)
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
index 2de54c0b26b2..40edfb375a8b 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -143,8 +143,8 @@ struct dso {
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
index dc86597d0cc4..00f215580b5a 100644
--- a/tools/perf/util/srcline.c
+++ b/tools/perf/util/srcline.c
@@ -594,11 +594,12 @@ struct srcline_node {
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
@@ -614,16 +615,18 @@ void srcline__tree_insert(struct rb_root *tree, u64 addr, char *srcline)
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
@@ -640,15 +643,15 @@ char *srcline__tree_find(struct rb_root *tree, u64 addr)
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
@@ -682,28 +685,32 @@ void inline_node__delete(struct inline_node *node)
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
@@ -720,15 +727,15 @@ struct inline_node *inlines__tree_find(struct rb_root *tree, u64 addr)
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
index 5762212dc342..b11a0aaaa676 100644
--- a/tools/perf/util/srcline.h
+++ b/tools/perf/util/srcline.h
@@ -19,11 +19,11 @@ void free_srcline(char *srcline);
 char *get_srcline_split(struct dso *dso, u64 addr, unsigned *line);
 
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
 
@@ -46,10 +46,11 @@ struct inline_node *dso__parse_addr_inlines(struct dso *dso, u64 addr,
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
2.20.1

