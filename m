Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12711C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 17:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C15EA214DB
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 17:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="yf+6Yiim"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C15EA214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731017AbeKVEBg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 23:01:36 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:44054 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbeKVEBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 23:01:35 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wALHOPh1045560;
        Wed, 21 Nov 2018 17:25:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=oI4kmYkzYMvDuA6Bkgxf5DUWQF7a8R3IaiVt46a1TaM=;
 b=yf+6YiimRQuPjzLSyg9ftjlMIIcLfHI9x8csHNdHN7MXT8SpboC1RlVVoP3bEQM4uDyF
 35kfOUVXl4ccdT3+6y2uh08romjt4LIAjHaxeVT+o1ACvDT7IictcXB0szM5SYZ7afon
 84ZsFCGVA2wh2xbJICv+6GEJ+DeWMEIRK1Ax3EH2TAGtnkPcClq85GHJgO12GsndVPn4
 ZHKd5gdn/zdZK1p4YWb/UKZZ/ZKRsKWoeXZGjAYQ78D7ThKHce9kcDCujnaGsjICzeUv
 Rra7S7t7Cil843DvVVRhe7R4wAuRZiFQQhPyVfZu1AoOKok9GYsyd6t4IeJ7chHa4AfU RA== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2ntadu2wk2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Nov 2018 17:25:56 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wALHPtk8024738
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Nov 2018 17:25:55 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wALHPsPw007030;
        Wed, 21 Nov 2018 17:25:54 GMT
Received: from ca-dev-arm44.us.oracle.com (/10.211.8.237)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 21 Nov 2018 09:25:54 -0800
From:   Eric Saint-Etienne <eric.saint.etienne@oracle.com>
To:     Linux Kernel <linux-kernel@vger.kernel.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.co>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Shaggy <dave.kleikamp@oracle.com>,
        David Aldridge <david.j.aldridge@oracle.com>,
        Rob Gardner <rob.gardner@oracle.com>,
        Eric Saint-Etienne <eric.saintetienne@gmail.com>
Subject: [PATCH] perf symbols: fix slowness due to -ffunction-section
Date:   Wed, 21 Nov 2018 09:51:19 -0800
Message-Id: <1542822679-25591-1-git-send-email-eric.saint.etienne@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9084 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811210151
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Perf can take minutes to parse an image when -ffunction-section is used.
This is especially true with the kernel image when it is compiled this way,
which is the arm64 default since the patcheset "Enable deadcode elimination
at link time".

Perf organize maps using a rbtree. Whenever perf finds a new symbols, it
first searches this rbtree for the map it belongs to, by strcmp()'aring
section names.  When it finds the map with the right name, it uses it to
add the symbol. With a usual image there aren't so many maps but when using
-ffunction-section there's basically one map per function.
With the kernel image that's north of 40,000 maps. For most symbols perf
has to parses the entire rbtree to eventually create a new map and add it.
Consequently perf spends most of the time browsing a rbtree that keeps
getting larger.

This performance fix introduces a secondary rbtree that indexes maps based
on the section name.

Signed-off-by: Eric Saint-Etienne <eric.saint.etienne@oracle.com>
Reviewed-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Reviewed-by: David Aldridge <david.aldridge@oracle.com>
Reviewed-by: Rob Gardner <rob.gardner@oracle.com>
---
 tools/perf/util/map.c    | 27 +++++++++++++++++++++++++++
 tools/perf/util/map.h    |  2 ++
 tools/perf/util/symbol.c | 15 +++++++++++++--
 3 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 354e545..781eed8 100644
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
index e0f327b..5c792c9 100644
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
index d188b75..dcce74b 100644
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
1.8.3.1

