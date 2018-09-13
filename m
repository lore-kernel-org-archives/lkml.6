Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD656C07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 903F820854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:55:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 903F820854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728349AbeIMSFP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:05:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:25489 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727009AbeIMSFO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:05:14 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0440F80466;
        Thu, 13 Sep 2018 12:55:53 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F2616600CD;
        Thu, 13 Sep 2018 12:55:50 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Stephane Eranian <eranian@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH 26/48] perf tools: Introduce map_groups__{insert,find}_by_time()
Date:   Thu, 13 Sep 2018 14:54:28 +0200
Message-Id: <20180913125450.21342-27-jolsa@kernel.org>
In-Reply-To: <20180913125450.21342-1-jolsa@kernel.org>
References: <20180913125450.21342-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 13 Sep 2018 12:55:53 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Namhyung Kim <namhyung@kernel.org>

It'll manage maps using timestamp so that it can find correct
map/symbol for sample at a certain time.  With this API, it can
maintain overlapping maps in a map_groups.

Cc: Stephane Eranian <eranian@google.com>
Link: http://lkml.kernel.org/n/tip-3bzcl4dzqh6qiqaddo5gco4y@git.kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/util/map.c | 64 +++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/map.h | 24 ++++++++++++++++
 2 files changed, 88 insertions(+)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 2821919156c9..4135a22091fe 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -825,6 +825,41 @@ void maps__insert(struct maps *maps, struct map *map)
 	up_write(&maps->lock);
 }
 
+static void __maps__insert_by_time(struct maps *maps, struct map *map)
+{
+	struct rb_node **p = &maps->entries.rb_node;
+	struct rb_node *parent = NULL;
+	const u64 ip = map->start;
+	const u64 timestamp = map->timestamp;
+	struct map *m;
+
+	while (*p != NULL) {
+		parent = *p;
+		m = rb_entry(parent, struct map, rb_node);
+		if (ip < m->start)
+			p = &(*p)->rb_left;
+		else if (ip > m->start)
+			p = &(*p)->rb_right;
+		else if (timestamp > m->timestamp)
+			p = &(*p)->rb_left;
+		else if (timestamp <= m->timestamp)
+			p = &(*p)->rb_right;
+		else
+			BUG_ON(1);
+	}
+
+	rb_link_node(&map->rb_node, parent, p);
+	rb_insert_color(&map->rb_node, &maps->entries);
+	map__get(map);
+}
+
+void maps__insert_by_time(struct maps *maps, struct map *map)
+{
+	down_write(&maps->lock);
+	__maps__insert_by_time(maps, map);
+	up_write(&maps->lock);
+}
+
 static void __maps__remove(struct maps *maps, struct map *map)
 {
 	rb_erase_init(&map->rb_node, &maps->entries);
@@ -863,6 +898,35 @@ struct map *maps__find(struct maps *maps, u64 ip)
 	return m;
 }
 
+struct map *maps__find_by_time(struct maps *maps, u64 ip, u64 timestamp)
+{
+	struct rb_node **p;
+	struct rb_node *parent = NULL;
+	struct map *m;
+	struct map *best = NULL;
+
+	down_read(&maps->lock);
+
+	p = &maps->entries.rb_node;
+	while (*p != NULL) {
+		parent = *p;
+		m = rb_entry(parent, struct map, rb_node);
+		if (ip < m->start)
+			p = &(*p)->rb_left;
+		else if (ip >= m->end)
+			p = &(*p)->rb_right;
+		else if (timestamp >= m->timestamp) {
+			if (!best || best->timestamp < m->timestamp)
+				best = m;
+			p = &(*p)->rb_left;
+		} else
+			p = &(*p)->rb_right;
+	}
+
+	up_read(&maps->lock);
+	return best;
+}
+
 struct map *maps__first(struct maps *maps)
 {
 	struct rb_node *first = rb_first(&maps->entries);
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index 0d35064cf813..02c6f6962eb1 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -13,6 +13,8 @@
 #include <linux/types.h>
 #include "rwsem.h"
 
+#include "perf.h"  /* for perf_has_index */
+
 struct dso;
 struct ip_callchain;
 struct ref_reloc_sym;
@@ -186,8 +188,10 @@ void map__fixup_end(struct map *map);
 void map__reloc_vmlinux(struct map *map);
 
 void maps__insert(struct maps *maps, struct map *map);
+void maps__insert_by_time(struct maps *maps, struct map *map);
 void maps__remove(struct maps *maps, struct map *map);
 struct map *maps__find(struct maps *maps, u64 addr);
+struct map *maps__find_by_time(struct maps *maps, u64 addr, u64 timestamp);
 struct map *maps__first(struct maps *maps);
 struct map *map__next(struct map *map);
 struct symbol *maps__find_symbol_by_name(struct maps *maps, const char *name,
@@ -207,6 +211,17 @@ static inline void map_groups__insert(struct map_groups *mg, struct map *map)
 	map->groups = mg;
 }
 
+static inline void map_groups__insert_by_time(struct map_groups *mg,
+					      struct map *map)
+{
+	if (perf_has_index)
+		maps__insert_by_time(&mg->maps, map);
+	else
+		maps__insert(&mg->maps, map);
+
+	map->groups = mg;
+}
+
 static inline void map_groups__remove(struct map_groups *mg, struct map *map)
 {
 	maps__remove(&mg->maps, map);
@@ -219,6 +234,15 @@ static inline struct map *map_groups__find(struct map_groups *mg, u64 addr)
 
 struct map *map_groups__first(struct map_groups *mg);
 
+static inline struct map *map_groups__find_by_time(struct map_groups *mg,
+						   u64 addr, u64 timestamp)
+{
+	if (!perf_has_index)
+		return maps__find(&mg->maps, addr);
+
+	return maps__find_by_time(&mg->maps, addr, timestamp);
+}
+
 static inline struct map *map_groups__next(struct map *map)
 {
 	return map__next(map);
-- 
2.17.1

