Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30AF6C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01A9E20831
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:16:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01A9E20831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405027AbeKVRy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 12:54:26 -0500
Received: from terminus.zytor.com ([198.137.202.136]:36085 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728441AbeKVRyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 12:54:25 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id wAM7FsOG3692696
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 21 Nov 2018 23:15:54 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id wAM7FsDp3692693;
        Wed, 21 Nov 2018 23:15:54 -0800
Date:   Wed, 21 Nov 2018 23:15:54 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Eric Saint-Etienne <tipbot@zytor.com>
Message-ID: <tip-1e6285699b3034e6f4d1f091edd46d717580bf7c@git.kernel.org>
Cc:     david.aldridge@oracle.com, dave.kleikamp@oracle.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        jolsa@redhat.com, rob.gardner@oracle.com, acme@redhat.com,
        peterz@infradead.org, mingo@kernel.org,
        eric.saint.etienne@oracle.com
Reply-To: alexander.shishkin@linux.intel.com, hpa@zytor.com,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          dave.kleikamp@oracle.com, david.aldridge@oracle.com,
          rob.gardner@oracle.com, jolsa@redhat.com, namhyung@kernel.org,
          peterz@infradead.org, mingo@kernel.org, acme@redhat.com,
          eric.saint.etienne@oracle.com
In-Reply-To: <1542822679-25591-1-git-send-email-eric.saint.etienne@oracle.com>
References: <1542822679-25591-1-git-send-email-eric.saint.etienne@oracle.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf symbols: Fix slowness due to
 -ffunction-section
Git-Commit-ID: 1e6285699b3034e6f4d1f091edd46d717580bf7c
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

Commit-ID:  1e6285699b3034e6f4d1f091edd46d717580bf7c
Gitweb:     https://git.kernel.org/tip/1e6285699b3034e6f4d1f091edd46d717580bf7c
Author:     Eric Saint-Etienne <eric.saint.etienne@oracle.com>
AuthorDate: Wed, 21 Nov 2018 09:51:19 -0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 21 Nov 2018 22:39:59 -0300

perf symbols: Fix slowness due to -ffunction-section

Perf can take minutes to parse an image when -ffunction-section is used.
This is especially true with the kernel image when it is compiled this
way, which is the arm64 default since the patcheset "Enable deadcode
elimination at link time".

Perf organize maps using a rbtree. Whenever perf finds a new symbols, it
first searches this rbtree for the map it belongs to, by strcmp()'aring
section names.  When it finds the map with the right name, it uses it to
add the symbol. With a usual image there aren't so many maps but when
using -ffunction-section there's basically one map per function.  With
the kernel image that's north of 40,000 maps. For most symbols perf has
to parses the entire rbtree to eventually create a new map and add it.
Consequently perf spends most of the time browsing a rbtree that keeps
getting larger.

This performance fix introduces a secondary rbtree that indexes maps
based on the section name.

Signed-off-by: Eric Saint-Etienne <eric.saint.etienne@oracle.com>
Reviewed-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Reviewed-by: David Aldridge <david.aldridge@oracle.com>
Reviewed-by: Rob Gardner <rob.gardner@oracle.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1542822679-25591-1-git-send-email-eric.saint.etienne@oracle.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/map.c    | 27 +++++++++++++++++++++++++++
 tools/perf/util/map.h    |  2 ++
 tools/perf/util/symbol.c | 15 +++++++++++++--
 3 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 354e54550d2b..781eed8e3265 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -21,6 +21,7 @@
 #include "unwind.h"
 
 static void __maps__insert(struct maps *maps, struct map *map);
+static void __maps__insert_name(struct maps *maps, struct map *map);
 
 static inline int is_anon_memory(const char *filename, u32 flags)
 {
@@ -496,6 +497,7 @@ u64 map__objdump_2mem(struct map *map, u64 ip)
 static void maps__init(struct maps *maps)
 {
 	maps->entries = RB_ROOT;
+	maps->names = RB_ROOT;
 	init_rwsem(&maps->lock);
 }
 
@@ -664,6 +666,7 @@ size_t map_groups__fprintf(struct map_groups *mg, FILE *fp)
 static void __map_groups__insert(struct map_groups *mg, struct map *map)
 {
 	__maps__insert(&mg->maps, map);
+	__maps__insert_name(&mg->maps, map);
 	map->groups = mg;
 }
 
@@ -824,10 +827,34 @@ static void __maps__insert(struct maps *maps, struct map *map)
 	map__get(map);
 }
 
+static void __maps__insert_name(struct maps *maps, struct map *map)
+{
+	struct rb_node **p = &maps->names.rb_node;
+	struct rb_node *parent = NULL;
+	struct map *m;
+	int rc;
+
+	while (*p != NULL) {
+		parent = *p;
+		m = rb_entry(parent, struct map, rb_node_name);
+		rc = strcmp(m->dso->short_name, map->dso->short_name);
+		if (rc < 0)
+			p = &(*p)->rb_left;
+		else if (rc  > 0)
+			p = &(*p)->rb_right;
+		else
+			return;
+	}
+	rb_link_node(&map->rb_node_name, parent, p);
+	rb_insert_color(&map->rb_node_name, &maps->names);
+	map__get(map);
+}
+
 void maps__insert(struct maps *maps, struct map *map)
 {
 	down_write(&maps->lock);
 	__maps__insert(maps, map);
+	__maps__insert_name(maps, map);
 	up_write(&maps->lock);
 }
 
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index e0f327b51e66..5c792c90fc4c 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -25,6 +25,7 @@ struct map {
 		struct rb_node	rb_node;
 		struct list_head node;
 	};
+	struct rb_node          rb_node_name;
 	u64			start;
 	u64			end;
 	bool			erange_warned;
@@ -57,6 +58,7 @@ struct kmap {
 
 struct maps {
 	struct rb_root	 entries;
+	struct rb_root	 names;
 	struct rw_semaphore lock;
 };
 
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index d188b7588152..dcce74bae6de 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1680,11 +1680,22 @@ struct map *map_groups__find_by_name(struct map_groups *mg, const char *name)
 {
 	struct maps *maps = &mg->maps;
 	struct map *map;
+	struct rb_node *node;
 
 	down_read(&maps->lock);
 
-	for (map = maps__first(maps); map; map = map__next(map)) {
-		if (map->dso && strcmp(map->dso->short_name, name) == 0)
+	for (node = maps->names.rb_node; node; ) {
+		int rc;
+
+		map = rb_entry(node, struct map, rb_node_name);
+
+		rc = strcmp(map->dso->short_name, name);
+		if (rc < 0)
+			node = node->rb_left;
+		else if (rc > 0)
+			node = node->rb_right;
+		else
+
 			goto out_unlock;
 	}
 
