Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA8BC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0973A214FF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 15:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ReW4k5t+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0973A214FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733254AbeHIR12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 13:27:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:39762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730634AbeHIR12 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 13:27:28 -0400
Received: from jouet.infradead.org (179-240-153-38.3g.claro.net.br [179.240.153.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 58B6021DEC;
        Thu,  9 Aug 2018 15:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533826929;
        bh=ijjPwZsqYi2N6S1aMgMM27zXm+K+xS8Mk73lDsQT+l8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ReW4k5t+7z3bCW50dF4ViCSkhtbVxLERFiwbvqpA37FaU2o/ccCsMer2j9vgBUpgf
         UL4G9qb0dhmqDLSWTVNghaCa5HEUBWv8yaByh1un0EQZOx6ABmrOaDt4f5Pqgj0XCj
         iHc2Qo4aPlchY0DziQFANXYHxhCts0miJMphFzYU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 44/44] perf map: Optimize maps__fixup_overlappings()
Date:   Thu,  9 Aug 2018 11:58:22 -0300
Message-Id: <20180809145822.21391-45-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180809145822.21391-1-acme@kernel.org>
References: <20180809145822.21391-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

This function splits and removes overlapping areas.

Maps in tree are ordered by start address thus we could find first
overlap and stop if next map does not overlap.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/153365189407.435244.7234821822450484712.stgit@buzz
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/map.c | 44 ++++++++++++++++++++++++++------------------
 tools/perf/util/map.h |  1 -
 2 files changed, 26 insertions(+), 19 deletions(-)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 89ac5b5dc218..36d0763311ef 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -381,20 +381,6 @@ struct map *map__clone(struct map *from)
 	return map;
 }
 
-int map__overlap(struct map *l, struct map *r)
-{
-	if (l->start > r->start) {
-		struct map *t = l;
-		l = r;
-		r = t;
-	}
-
-	if (l->end > r->start)
-		return 1;
-
-	return 0;
-}
-
 size_t map__fprintf(struct map *map, FILE *fp)
 {
 	return fprintf(fp, " %" PRIx64 "-%" PRIx64 " %" PRIx64 " %s\n",
@@ -675,20 +661,42 @@ static void __map_groups__insert(struct map_groups *mg, struct map *map)
 static int maps__fixup_overlappings(struct maps *maps, struct map *map, FILE *fp)
 {
 	struct rb_root *root;
-	struct rb_node *next;
+	struct rb_node *next, *first;
 	int err = 0;
 
 	down_write(&maps->lock);
 
 	root = &maps->entries;
-	next = rb_first(root);
 
+	/*
+	 * Find first map where end > map->start.
+	 * Same as find_vma() in kernel.
+	 */
+	next = root->rb_node;
+	first = NULL;
+	while (next) {
+		struct map *pos = rb_entry(next, struct map, rb_node);
+
+		if (pos->end > map->start) {
+			first = next;
+			if (pos->start <= map->start)
+				break;
+			next = next->rb_left;
+		} else
+			next = next->rb_right;
+	}
+
+	next = first;
 	while (next) {
 		struct map *pos = rb_entry(next, struct map, rb_node);
 		next = rb_next(&pos->rb_node);
 
-		if (!map__overlap(pos, map))
-			continue;
+		/*
+		 * Stop if current map starts after map->end.
+		 * Maps are ordered by start: next will not overlap for sure.
+		 */
+		if (pos->start >= map->end)
+			break;
 
 		if (verbose >= 2) {
 
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index 4cb90f242bed..e0f327b51e66 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -166,7 +166,6 @@ static inline void __map__zput(struct map **map)
 
 #define map__zput(map) __map__zput(&map)
 
-int map__overlap(struct map *l, struct map *r);
 size_t map__fprintf(struct map *map, FILE *fp);
 size_t map__fprintf_dsoname(struct map *map, FILE *fp);
 char *map__srcline(struct map *map, u64 addr, struct symbol *sym);
-- 
2.14.4

