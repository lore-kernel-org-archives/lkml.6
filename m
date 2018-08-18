Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82908C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4503F2188F
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 11:42:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4503F2188F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbeHROuJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 10:50:09 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50487 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbeHROuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 10:50:09 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w7IBgRq81287995
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Sat, 18 Aug 2018 04:42:27 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w7IBgQJO1287992;
        Sat, 18 Aug 2018 04:42:26 -0700
Date:   Sat, 18 Aug 2018 04:42:26 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Konstantin Khlebnikov <tipbot@zytor.com>
Message-ID: <tip-6a9405b56c274024564f9014bba97b92c91b34d6@git.kernel.org>
Cc:     jolsa@kernel.org, peterz@infradead.org, namhyung@kernel.org,
        linux-kernel@vger.kernel.org, mingo@kernel.org, acme@redhat.com,
        tglx@linutronix.de, alexander.shishkin@linux.intel.com,
        khlebnikov@yandex-team.ru, hpa@zytor.com
Reply-To: tglx@linutronix.de, alexander.shishkin@linux.intel.com,
          hpa@zytor.com, khlebnikov@yandex-team.ru, peterz@infradead.org,
          jolsa@kernel.org, mingo@kernel.org, acme@redhat.com,
          namhyung@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <153365189407.435244.7234821822450484712.stgit@buzz>
References: <153365189407.435244.7234821822450484712.stgit@buzz>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf map: Optimize maps__fixup_overlappings()
Git-Commit-ID: 6a9405b56c274024564f9014bba97b92c91b34d6
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

Commit-ID:  6a9405b56c274024564f9014bba97b92c91b34d6
Gitweb:     https://git.kernel.org/tip/6a9405b56c274024564f9014bba97b92c91b34d6
Author:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
AuthorDate: Tue, 7 Aug 2018 17:24:54 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 8 Aug 2018 15:56:00 -0300

perf map: Optimize maps__fixup_overlappings()

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
