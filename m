Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC0EC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 14:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B34A2174B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 14:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="sffNSu79"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B34A2174B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389530AbeHGQje (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 12:39:34 -0400
Received: from forwardcorp1o.cmail.yandex.net ([37.9.109.47]:32977 "EHLO
        forwardcorp1o.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732510AbeHGQje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 12:39:34 -0400
Received: from smtpcorp1p.mail.yandex.net (smtpcorp1p.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b6:10])
        by forwardcorp1o.cmail.yandex.net (Yandex) with ESMTP id 06AF021803;
        Tue,  7 Aug 2018 17:24:57 +0300 (MSK)
Received: from smtpcorp1p.mail.yandex.net (localhost.localdomain [127.0.0.1])
        by smtpcorp1p.mail.yandex.net (Yandex) with ESMTP id F2E546E40E07;
        Tue,  7 Aug 2018 17:24:56 +0300 (MSK)
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net [2a02:6b8:0:40c:854c:7dcd:9203:76a5])
        by smtpcorp1p.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id QZExRYDYw8-Ouw4s3gw;
        Tue, 07 Aug 2018 17:24:56 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1533651896; bh=pVxGH8iWYTaFN1SRyYf9ahHyukhwZccMhb9aW/ED0tk=;
        h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References;
        b=sffNSu79KzTDCK9cQEJpQaNTFyNvCrhOSxDSFmOpD8a2tVHtjCAj7meKReP4dj5ag
         TMpFvSnQm7txgTOMHpc4ViVwlUdEA9FM6jYeyZV75HdjDPSKhnnj2FfKCJ3w6JiKJn
         4plqAiKj2M+QLXyMPq7+WQVCoXhga2huxUIQ5IYU=
Authentication-Results: smtpcorp1p.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Subject: [PATCH v2] perf map: optimize maps__fixup_overlappings()
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Date:   Tue, 07 Aug 2018 17:24:54 +0300
Message-ID: <153365189407.435244.7234821822450484712.stgit@buzz>
In-Reply-To: <153363294565.396323.4605638589903548668.stgit@buzz>
References: <153363294565.396323.4605638589903548668.stgit@buzz>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This function splits and removes overlapping areas.

Maps in tree are ordered by start address thus we could find
first overlap and stop if next map does not overlap.

Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>

---

v2:
* add comments
* replace map__overlap with minimal check
* remove remove map__overlap, that was the only user
---
 tools/perf/util/map.c |   44 ++++++++++++++++++++++++++------------------
 tools/perf/util/map.h |    1 -
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

