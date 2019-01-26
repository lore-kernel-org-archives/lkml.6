Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D521C282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 10:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68867217D7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 10:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729697AbfAZKCn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 05:02:43 -0500
Received: from terminus.zytor.com ([198.137.202.136]:49757 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfAZKCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 05:02:43 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0QA2X94510947
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 26 Jan 2019 02:02:33 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0QA2Xpa510944;
        Sat, 26 Jan 2019 02:02:33 -0800
Date:   Sat, 26 Jan 2019 02:02:33 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Davidlohr Bueso <tipbot@zytor.com>
Message-ID: <tip-55ecd6310f9fe48cf7e435be408862da1e0e6baa@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, dave@stgolabs.net, acme@redhat.com,
        mingo@kernel.org, dbueso@suse.de, jolsa@kernel.org,
        namhyung@kernel.org, tglx@linutronix.de, hpa@zytor.com
Reply-To: mingo@kernel.org, linux-kernel@vger.kernel.org,
          dave@stgolabs.net, acme@redhat.com, tglx@linutronix.de,
          hpa@zytor.com, namhyung@kernel.org, jolsa@kernel.org,
          dbueso@suse.de
In-Reply-To: <20181206191819.30182-4-dave@stgolabs.net>
References: <20181206191819.30182-4-dave@stgolabs.net>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf callchain: Use cached rbtrees
Git-Commit-ID: 55ecd6310f9fe48cf7e435be408862da1e0e6baa
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  55ecd6310f9fe48cf7e435be408862da1e0e6baa
Gitweb:     https://git.kernel.org/tip/55ecd6310f9fe48cf7e435be408862da1e0e6baa
Author:     Davidlohr Bueso <dave@stgolabs.net>
AuthorDate: Thu, 6 Dec 2018 11:18:15 -0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 25 Jan 2019 15:12:09 +0100

perf callchain: Use cached rbtrees

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
 tools/perf/util/srcline.c | 43 +++++++++++++++++++++++++------------------
 tools/perf/util/srcline.h | 13 +++++++------
 4 files changed, 36 insertions(+), 28 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index cbe6e7dc6af3..9ec4b2e6d4ac 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1199,8 +1199,8 @@ struct dso *dso__new(const char *name)
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
