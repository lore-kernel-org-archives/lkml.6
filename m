Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8249EC07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39F9B20882
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:55:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39F9B20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbeIMSEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:04:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37746 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727051AbeIMSEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:04:21 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7D23A30820DE;
        Thu, 13 Sep 2018 12:55:00 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A2154600C6;
        Thu, 13 Sep 2018 12:54:58 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH 03/48] perf tools: Pass struct perf_mmap into auxtrace_mmap__read* functions
Date:   Thu, 13 Sep 2018 14:54:05 +0200
Message-Id: <20180913125450.21342-4-jolsa@kernel.org>
In-Reply-To: <20180913125450.21342-1-jolsa@kernel.org>
References: <20180913125450.21342-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Thu, 13 Sep 2018 12:55:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The map struct will hold the file pointer, so we need to propagate
it down the stack to record__write callers instead of its member
the auxtrace_mmap struct.

Link: http://lkml.kernel.org/n/tip-h6tbp0huyptieote47dk1znz@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-record.c | 27 +++++++++++++--------------
 tools/perf/util/auxtrace.c  | 11 ++++++-----
 tools/perf/util/auxtrace.h  |  5 +++--
 3 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 9853552bcf16..fd8b12c5f4ae 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -207,11 +207,11 @@ static int record__process_auxtrace(struct perf_tool *tool,
 }
 
 static int record__auxtrace_mmap_read(struct record *rec,
-				      struct auxtrace_mmap *mm)
+				      struct perf_mmap *map)
 {
 	int ret;
 
-	ret = auxtrace_mmap__read(mm, rec->itr, &rec->tool,
+	ret = auxtrace_mmap__read(map, rec->itr, &rec->tool,
 				  record__process_auxtrace);
 	if (ret < 0)
 		return ret;
@@ -223,11 +223,11 @@ static int record__auxtrace_mmap_read(struct record *rec,
 }
 
 static int record__auxtrace_mmap_read_snapshot(struct record *rec,
-					       struct auxtrace_mmap *mm)
+					       struct perf_mmap *map)
 {
 	int ret;
 
-	ret = auxtrace_mmap__read_snapshot(mm, rec->itr, &rec->tool,
+	ret = auxtrace_mmap__read_snapshot(map, rec->itr, &rec->tool,
 					   record__process_auxtrace,
 					   rec->opts.auxtrace_snapshot_size);
 	if (ret < 0)
@@ -245,13 +245,12 @@ static int record__auxtrace_read_snapshot_all(struct record *rec)
 	int rc = 0;
 
 	for (i = 0; i < rec->evlist->nr_mmaps; i++) {
-		struct auxtrace_mmap *mm =
-				&rec->evlist->mmap[i].auxtrace_mmap;
+		struct perf_mmap *map = &rec->evlist->mmap[i];
 
-		if (!mm->base)
+		if (!map->auxtrace_mmap.base)
 			continue;
 
-		if (record__auxtrace_mmap_read_snapshot(rec, mm) != 0) {
+		if (record__auxtrace_mmap_read_snapshot(rec, map) != 0) {
 			rc = -1;
 			goto out;
 		}
@@ -295,7 +294,7 @@ static int record__auxtrace_init(struct record *rec)
 
 static inline
 int record__auxtrace_mmap_read(struct record *rec __maybe_unused,
-			       struct auxtrace_mmap *mm __maybe_unused)
+			       struct perf_mmap *map __maybe_unused)
 {
 	return 0;
 }
@@ -529,17 +528,17 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
 		return 0;
 
 	for (i = 0; i < evlist->nr_mmaps; i++) {
-		struct auxtrace_mmap *mm = &maps[i].auxtrace_mmap;
+		struct perf_mmap *map = &maps[i];
 
-		if (maps[i].base) {
-			if (perf_mmap__push(&maps[i], rec, record__pushfn) != 0) {
+		if (map->base) {
+			if (perf_mmap__push(map, rec, record__pushfn) != 0) {
 				rc = -1;
 				goto out;
 			}
 		}
 
-		if (mm->base && !rec->opts.auxtrace_snapshot_mode &&
-		    record__auxtrace_mmap_read(rec, mm) != 0) {
+		if (map->auxtrace_mmap.base && !rec->opts.auxtrace_snapshot_mode &&
+		    record__auxtrace_mmap_read(rec, map) != 0) {
 			rc = -1;
 			goto out;
 		}
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 3017b205a157..2fecee57f555 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -1193,11 +1193,12 @@ int perf_event__process_auxtrace_error(struct perf_session *session,
 	return 0;
 }
 
-static int __auxtrace_mmap__read(struct auxtrace_mmap *mm,
+static int __auxtrace_mmap__read(struct perf_mmap *map,
 				 struct auxtrace_record *itr,
 				 struct perf_tool *tool, process_auxtrace_t fn,
 				 bool snapshot, size_t snapshot_size)
 {
+	struct auxtrace_mmap *mm = &map->auxtrace_mmap;
 	u64 head, old = mm->prev, offset, ref;
 	unsigned char *data = mm->base;
 	size_t size, head_off, old_off, len1, len2, padding;
@@ -1303,18 +1304,18 @@ static int __auxtrace_mmap__read(struct auxtrace_mmap *mm,
 	return 1;
 }
 
-int auxtrace_mmap__read(struct auxtrace_mmap *mm, struct auxtrace_record *itr,
+int auxtrace_mmap__read(struct perf_mmap *map, struct auxtrace_record *itr,
 			struct perf_tool *tool, process_auxtrace_t fn)
 {
-	return __auxtrace_mmap__read(mm, itr, tool, fn, false, 0);
+	return __auxtrace_mmap__read(map, itr, tool, fn, false, 0);
 }
 
-int auxtrace_mmap__read_snapshot(struct auxtrace_mmap *mm,
+int auxtrace_mmap__read_snapshot(struct perf_mmap *map,
 				 struct auxtrace_record *itr,
 				 struct perf_tool *tool, process_auxtrace_t fn,
 				 size_t snapshot_size)
 {
-	return __auxtrace_mmap__read(mm, itr, tool, fn, true, snapshot_size);
+	return __auxtrace_mmap__read(map, itr, tool, fn, true, snapshot_size);
 }
 
 /**
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index 6be89776358c..7eeb141361b9 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -33,6 +33,7 @@ union perf_event;
 struct perf_session;
 struct perf_evlist;
 struct perf_tool;
+struct perf_mmap;
 struct option;
 struct record_opts;
 struct auxtrace_info_event;
@@ -437,10 +438,10 @@ typedef int (*process_auxtrace_t)(struct perf_tool *tool,
 				  union perf_event *event, void *data1,
 				  size_t len1, void *data2, size_t len2);
 
-int auxtrace_mmap__read(struct auxtrace_mmap *mm, struct auxtrace_record *itr,
+int auxtrace_mmap__read(struct perf_mmap *map, struct auxtrace_record *itr,
 			struct perf_tool *tool, process_auxtrace_t fn);
 
-int auxtrace_mmap__read_snapshot(struct auxtrace_mmap *mm,
+int auxtrace_mmap__read_snapshot(struct perf_mmap *map,
 				 struct auxtrace_record *itr,
 				 struct perf_tool *tool, process_auxtrace_t fn,
 				 size_t snapshot_size);
-- 
2.17.1

