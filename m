Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1919ECE564
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 14:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EA5021525
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 14:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ff1XSXMQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EA5021525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732359AbeISUEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 16:04:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:50134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731308AbeISUE3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 16:04:29 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E565021524;
        Wed, 19 Sep 2018 14:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537367178;
        bh=0xlKX7eyvmMXgBWdq5/jzLjeuREW3bMSwed+CJAsGzk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ff1XSXMQMGOQpqSWUInE+TzKnbpC3r1wMNmP/ecmhxAWRArECLyTnKH4G+bbcNp60
         9d42+NsinY65GrGparkHLYOLqN/gPQPzrMWERR5DRi5c2/YUcUd0w7wpDlfPssdruu
         sQvRV5JvW0CTyXGhAdXTxnPk3AozFkhqDkCAC7wM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <andi@firstfloor.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 09/13] perf auxtrace: Pass struct perf_mmap into mmap__read* functions
Date:   Wed, 19 Sep 2018 11:25:33 -0300
Message-Id: <20180919142537.29985-10-acme@kernel.org>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180919142537.29985-1-acme@kernel.org>
References: <20180919142537.29985-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

The perf_mmap struct will hold a file pointer to write the mmap's
contents, so we need to propagate it down the stack to record__write
callers instead of its member the auxtrace_mmap struct.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180913125450.21342-4-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
2.14.4

