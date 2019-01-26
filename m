Return-Path: <SRS0=RQnK=QC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7990BC282C7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 10:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4578B217D7
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Jan 2019 10:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729609AbfAZKDW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 05:03:22 -0500
Received: from terminus.zytor.com ([198.137.202.136]:49329 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfAZKDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 05:03:22 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x0QA3CbR511187
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 26 Jan 2019 02:03:12 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x0QA3CLk511184;
        Sat, 26 Jan 2019 02:03:12 -0800
Date:   Sat, 26 Jan 2019 02:03:12 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Davidlohr Bueso <tipbot@zytor.com>
Message-ID: <tip-ca2270292e6c3415102242bf9dc3d05f622b7b28@git.kernel.org>
Cc:     jolsa@kernel.org, hpa@zytor.com, namhyung@kernel.org,
        dbueso@suse.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, dave@stgolabs.net, acme@redhat.com
Reply-To: jolsa@kernel.org, hpa@zytor.com, namhyung@kernel.org,
          linux-kernel@vger.kernel.org, mingo@kernel.org, dbueso@suse.de,
          acme@redhat.com, dave@stgolabs.net, tglx@linutronix.de
In-Reply-To: <20181206191819.30182-5-dave@stgolabs.net>
References: <20181206191819.30182-5-dave@stgolabs.net>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf util: Use cached rbtree for rblists
Git-Commit-ID: ca2270292e6c3415102242bf9dc3d05f622b7b28
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

Commit-ID:  ca2270292e6c3415102242bf9dc3d05f622b7b28
Gitweb:     https://git.kernel.org/tip/ca2270292e6c3415102242bf9dc3d05f622b7b28
Author:     Davidlohr Bueso <dave@stgolabs.net>
AuthorDate: Thu, 6 Dec 2018 11:18:16 -0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 25 Jan 2019 15:12:10 +0100

perf util: Use cached rbtree for rblists

At the cost of an extra pointer, we can avoid the O(logN) cost of
finding the first element in the tree (smallest node), which is
something required for any of the strlist or intlist traversals
(XXX_for_each_entry()). There are a number of users in perf of these
(particularly strlists), including probes, and buildid.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lkml.kernel.org/r/20181206191819.30182-5-dave@stgolabs.net
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intlist.h     |  2 +-
 tools/perf/util/metricgroup.c |  2 +-
 tools/perf/util/rb_resort.h   |  2 +-
 tools/perf/util/rblist.c      | 28 ++++++++++++++++++----------
 tools/perf/util/rblist.h      |  2 +-
 tools/perf/util/stat-shadow.c |  2 +-
 tools/perf/util/strlist.h     |  2 +-
 7 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/tools/perf/util/intlist.h b/tools/perf/util/intlist.h
index 85bab8735fa9..5c19ee001299 100644
--- a/tools/perf/util/intlist.h
+++ b/tools/perf/util/intlist.h
@@ -45,7 +45,7 @@ static inline unsigned int intlist__nr_entries(const struct intlist *ilist)
 /* For intlist iteration */
 static inline struct int_node *intlist__first(struct intlist *ilist)
 {
-	struct rb_node *rn = rb_first(&ilist->rblist.entries);
+	struct rb_node *rn = rb_first_cached(&ilist->rblist.entries);
 	return rn ? rb_entry(rn, struct int_node, rb_node) : NULL;
 }
 static inline struct int_node *intlist__next(struct int_node *in)
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index a28f9b5cc4ff..8529cbd3955b 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -352,7 +352,7 @@ void metricgroup__print(bool metrics, bool metricgroups, char *filter,
 	else if (metrics && !raw)
 		printf("\nMetrics:\n\n");
 
-	for (node = rb_first(&groups.entries); node; node = next) {
+	for (node = rb_first_cached(&groups.entries); node; node = next) {
 		struct mep *me = container_of(node, struct mep, nd);
 
 		if (metricgroups)
diff --git a/tools/perf/util/rb_resort.h b/tools/perf/util/rb_resort.h
index f272e181d3d6..376e86cb4c3c 100644
--- a/tools/perf/util/rb_resort.h
+++ b/tools/perf/util/rb_resort.h
@@ -140,7 +140,7 @@ struct __name##_sorted *__name = __name##_sorted__new
 
 /* For 'struct intlist' */
 #define DECLARE_RESORT_RB_INTLIST(__name, __ilist)				\
-	DECLARE_RESORT_RB(__name)(&__ilist->rblist.entries,			\
+	DECLARE_RESORT_RB(__name)(&__ilist->rblist.entries.rb_root,		\
 				  __ilist->rblist.nr_entries)
 
 /* For 'struct machine->threads' */
diff --git a/tools/perf/util/rblist.c b/tools/perf/util/rblist.c
index 0efc3258c648..11e07fab20dc 100644
--- a/tools/perf/util/rblist.c
+++ b/tools/perf/util/rblist.c
@@ -13,8 +13,9 @@
 
 int rblist__add_node(struct rblist *rblist, const void *new_entry)
 {
-	struct rb_node **p = &rblist->entries.rb_node;
+	struct rb_node **p = &rblist->entries.rb_root.rb_node;
 	struct rb_node *parent = NULL, *new_node;
+	bool leftmost = true;
 
 	while (*p != NULL) {
 		int rc;
@@ -24,8 +25,10 @@ int rblist__add_node(struct rblist *rblist, const void *new_entry)
 		rc = rblist->node_cmp(parent, new_entry);
 		if (rc > 0)
 			p = &(*p)->rb_left;
-		else if (rc < 0)
+		else if (rc < 0) {
 			p = &(*p)->rb_right;
+			leftmost = false;
+		}
 		else
 			return -EEXIST;
 	}
@@ -35,7 +38,7 @@ int rblist__add_node(struct rblist *rblist, const void *new_entry)
 		return -ENOMEM;
 
 	rb_link_node(new_node, parent, p);
-	rb_insert_color(new_node, &rblist->entries);
+	rb_insert_color_cached(new_node, &rblist->entries, leftmost);
 	++rblist->nr_entries;
 
 	return 0;
@@ -43,7 +46,7 @@ int rblist__add_node(struct rblist *rblist, const void *new_entry)
 
 void rblist__remove_node(struct rblist *rblist, struct rb_node *rb_node)
 {
-	rb_erase(rb_node, &rblist->entries);
+	rb_erase_cached(rb_node, &rblist->entries);
 	--rblist->nr_entries;
 	rblist->node_delete(rblist, rb_node);
 }
@@ -52,8 +55,9 @@ static struct rb_node *__rblist__findnew(struct rblist *rblist,
 					 const void *entry,
 					 bool create)
 {
-	struct rb_node **p = &rblist->entries.rb_node;
+	struct rb_node **p = &rblist->entries.rb_root.rb_node;
 	struct rb_node *parent = NULL, *new_node = NULL;
+	bool leftmost = true;
 
 	while (*p != NULL) {
 		int rc;
@@ -63,8 +67,10 @@ static struct rb_node *__rblist__findnew(struct rblist *rblist,
 		rc = rblist->node_cmp(parent, entry);
 		if (rc > 0)
 			p = &(*p)->rb_left;
-		else if (rc < 0)
+		else if (rc < 0) {
 			p = &(*p)->rb_right;
+			leftmost = false;
+		}
 		else
 			return parent;
 	}
@@ -73,7 +79,8 @@ static struct rb_node *__rblist__findnew(struct rblist *rblist,
 		new_node = rblist->node_new(rblist, entry);
 		if (new_node) {
 			rb_link_node(new_node, parent, p);
-			rb_insert_color(new_node, &rblist->entries);
+			rb_insert_color_cached(new_node,
+					       &rblist->entries, leftmost);
 			++rblist->nr_entries;
 		}
 	}
@@ -94,7 +101,7 @@ struct rb_node *rblist__findnew(struct rblist *rblist, const void *entry)
 void rblist__init(struct rblist *rblist)
 {
 	if (rblist != NULL) {
-		rblist->entries	 = RB_ROOT;
+		rblist->entries	 = RB_ROOT_CACHED;
 		rblist->nr_entries = 0;
 	}
 
@@ -103,7 +110,7 @@ void rblist__init(struct rblist *rblist)
 
 void rblist__exit(struct rblist *rblist)
 {
-	struct rb_node *pos, *next = rb_first(&rblist->entries);
+	struct rb_node *pos, *next = rb_first_cached(&rblist->entries);
 
 	while (next) {
 		pos = next;
@@ -124,7 +131,8 @@ struct rb_node *rblist__entry(const struct rblist *rblist, unsigned int idx)
 {
 	struct rb_node *node;
 
-	for (node = rb_first(&rblist->entries); node; node = rb_next(node)) {
+	for (node = rb_first_cached(&rblist->entries); node;
+	     node = rb_next(node)) {
 		if (!idx--)
 			return node;
 	}
diff --git a/tools/perf/util/rblist.h b/tools/perf/util/rblist.h
index 76df15c27f5f..14b232a4d0b6 100644
--- a/tools/perf/util/rblist.h
+++ b/tools/perf/util/rblist.h
@@ -20,7 +20,7 @@
  */
 
 struct rblist {
-	struct rb_root entries;
+	struct rb_root_cached entries;
 	unsigned int   nr_entries;
 
 	int (*node_cmp)(struct rb_node *rbn, const void *entry);
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 3c22c58b3e90..83d8094be4fe 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -168,7 +168,7 @@ static void reset_stat(struct runtime_stat *st)
 	struct rb_node *pos, *next;
 
 	rblist = &st->value_list;
-	next = rb_first(&rblist->entries);
+	next = rb_first_cached(&rblist->entries);
 	while (next) {
 		pos = next;
 		next = rb_next(pos);
diff --git a/tools/perf/util/strlist.h b/tools/perf/util/strlist.h
index d58f1e08b170..7e82c71dcc42 100644
--- a/tools/perf/util/strlist.h
+++ b/tools/perf/util/strlist.h
@@ -57,7 +57,7 @@ static inline unsigned int strlist__nr_entries(const struct strlist *slist)
 /* For strlist iteration */
 static inline struct str_node *strlist__first(struct strlist *slist)
 {
-	struct rb_node *rn = rb_first(&slist->rblist.entries);
+	struct rb_node *rn = rb_first_cached(&slist->rblist.entries);
 	return rn ? rb_entry(rn, struct str_node, rb_node) : NULL;
 }
 static inline struct str_node *strlist__next(struct str_node *sn)
