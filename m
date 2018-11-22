Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71894C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 03:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E88220821
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 03:37:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yw7k2Vte"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E88220821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404516AbeKVOPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 09:15:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:56824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387514AbeKVOPM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 09:15:12 -0500
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5238D206B2;
        Thu, 22 Nov 2018 03:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542857865;
        bh=gr5L89y92WjjJhzTw3Bc3wy87jsmnKfevb9IE6nDw0M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yw7k2Vte0uurp3jLCBpIyvJOlcwNLgLLvRYHZnt/580QlMP8H1vcPz0CJlNMwu6aq
         ja877ToqR8kHIB+MwfqHS6nAs/Bd1b4EbJkkDzNYg9oDM/E0HuGJMOmp5CwVpt2OE/
         exT0VkDzxTen6PEpghzPNZlsVWWFd3/j+HGQHW0U=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Eric Saint-Etienne <eric.saint.etienne@oracle.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 27/28] perf symbols: Fix slowness due to -ffunction-section
Date:   Thu, 22 Nov 2018 00:36:10 -0300
Message-Id: <20181122033611.15890-28-acme@kernel.org>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20181122033611.15890-1-acme@kernel.org>
References: <20181122033611.15890-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Saint-Etienne <eric.saint.etienne@oracle.com>

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
 
-- 
2.14.5

