Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9796C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5995821773
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:23:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729556AbfBKUXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 15:23:48 -0500
Received: from mga06.intel.com ([134.134.136.31]:52715 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727082AbfBKUXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 15:23:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2019 12:23:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,360,1544515200"; 
   d="scan'208";a="125647373"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 11 Feb 2019 12:23:44 -0800
Received: from [10.252.27.66] (abudanko-mobl.ccr.corp.intel.com [10.252.27.66])
        by linux.intel.com (Postfix) with ESMTP id C90965802BB;
        Mon, 11 Feb 2019 12:23:41 -0800 (PST)
Subject: [PATCH v2 3/4] perf record: enable runtime trace compression
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <044ee2be-2e1d-e90f-7317-40083b5e716c@linux.intel.com>
Organization: Intel Corp.
Message-ID: <5bc6958d-f4bc-d4ea-e5d0-16c5e7b73911@linux.intel.com>
Date:   Mon, 11 Feb 2019 23:23:40 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <044ee2be-2e1d-e90f-7317-40083b5e716c@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Compression is implemented using simple Zstd API and employs AIO data
buffer as the memory to operate on. If the API call fails for some
reason compression falls back to memcpy().

Data chunks are split and packed into PERF_RECORD_COMPRESSED records
by 64KB at max. mmap-flush option value can be used to avoid compression
of every single byte of data and increase compression ratio.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
Changes in v2:
- enabled trace compression for serial trace streaming
- moved compression/decompression code to session layer

---
 tools/perf/builtin-record.c |  67 +++++++++-----
 tools/perf/util/mmap.c      | 173 +++++++++++++++++++++---------------
 tools/perf/util/mmap.h      |  24 +++--
 tools/perf/util/session.c   | 106 ++++++++++++++++++++++
 tools/perf/util/session.h   |  13 +++
 5 files changed, 280 insertions(+), 103 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 227dbbd47d3f..435ff88dfc5e 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -112,8 +112,7 @@ static bool switch_output_time(struct record *rec)
 	       trigger_is_ready(&switch_output_trigger);
 }
 
-static int record__write(struct record *rec, struct perf_mmap *map __maybe_unused,
-			 void *bf, size_t size)
+static int record__write(struct record *rec, void *bf, size_t size)
 {
 	struct perf_data_file *file = &rec->session->data->file;
 
@@ -237,7 +236,7 @@ static int record__aio_sync(struct perf_mmap *md, bool sync_all)
 	} while (1);
 }
 
-static int record__aio_pushfn(void *to, struct aiocb *cblock, void *bf, size_t size, off_t off)
+static int record__aio_pushfn(void *to, void *bf, size_t size, off_t off, struct aiocb *cblock)
 {
 	struct record *rec = to;
 	int ret, trace_fd = rec->session->data->file.fd;
@@ -264,13 +263,15 @@ static void record__aio_set_pos(int trace_fd, off_t pos)
 	lseek(trace_fd, pos, SEEK_SET);
 }
 
+static int record__aio_enabled(struct record *rec);
+
 static void record__aio_mmap_read_sync(struct record *rec)
 {
 	int i;
 	struct perf_evlist *evlist = rec->evlist;
 	struct perf_mmap *maps = evlist->mmap;
 
-	if (!rec->opts.nr_cblocks)
+	if (!record__aio_enabled(rec))
 		return;
 
 	for (i = 0; i < evlist->nr_mmaps; i++) {
@@ -311,8 +312,8 @@ static int record__aio_sync(struct perf_mmap *md __maybe_unused, bool sync_all _
 	return -1;
 }
 
-static int record__aio_pushfn(void *to __maybe_unused, struct aiocb *cblock __maybe_unused,
-		void *bf __maybe_unused, size_t size __maybe_unused, off_t off __maybe_unused)
+static int record__aio_pushfn(void *to __maybe_unused, void *bf __maybe_unused,
+	size_t size __maybe_unused, off_t off __maybe_unused, struct aiocb *cblock __maybe_unused)
 {
 	return -1;
 }
@@ -371,15 +372,15 @@ static int process_synthesized_event(struct perf_tool *tool,
 				     struct machine *machine __maybe_unused)
 {
 	struct record *rec = container_of(tool, struct record, tool);
-	return record__write(rec, NULL, event, event->header.size);
+	return record__write(rec, event, event->header.size);
 }
 
-static int record__pushfn(struct perf_mmap *map, void *to, void *bf, size_t size)
+static int record__pushfn(void *to, void *bf, size_t size)
 {
 	struct record *rec = to;
 
 	rec->samples++;
-	return record__write(rec, map, bf, size);
+	return record__write(rec, bf, size);
 }
 
 static volatile int done;
@@ -414,7 +415,7 @@ static void record__sig_exit(void)
 #ifdef HAVE_AUXTRACE_SUPPORT
 
 static int record__process_auxtrace(struct perf_tool *tool,
-				    struct perf_mmap *map,
+				    struct perf_mmap *map __maybe_unused,
 				    union perf_event *event, void *data1,
 				    size_t len1, void *data2, size_t len2)
 {
@@ -442,11 +443,11 @@ static int record__process_auxtrace(struct perf_tool *tool,
 	if (padding)
 		padding = 8 - padding;
 
-	record__write(rec, map, event, event->header.size);
-	record__write(rec, map, data1, len1);
+	record__write(rec, event, event->header.size);
+	record__write(rec, data1, len1);
 	if (len2)
-		record__write(rec, map, data2, len2);
-	record__write(rec, map, &pad, padding);
+		record__write(rec, data2, len2);
+	record__write(rec, &pad, padding);
 
 	return 0;
 }
@@ -774,6 +775,8 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
 	struct perf_mmap *maps;
 	int trace_fd = rec->data.file.fd;
 	off_t off;
+	struct perf_session *session = rec->session;
+	perf_mmap__compress_fn_t compress_fn;
 
 	if (!evlist)
 		return 0;
@@ -785,6 +788,9 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
 	if (overwrite && evlist->bkw_mmap_state != BKW_MMAP_DATA_PENDING)
 		return 0;
 
+	compress_fn = (record__comp_enabled(rec) ?
+		perf_session__zstd_compress : perf_session__zstd_copy);
+
 	if (record__aio_enabled(rec))
 		off = record__aio_get_pos(trace_fd);
 
@@ -799,11 +805,21 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
 				map->flush = MMAP_FLUSH_DEFAULT;
 			}
 			if (!record__aio_enabled(rec)) {
-				if (perf_mmap__push(map, rec, record__pushfn) != 0) {
-					if (sync)
-						map->flush = flush;
-					rc = -1;
-					goto out;
+				if (!record__comp_enabled(rec)) {
+					if (perf_mmap__push(map, rec, record__pushfn) != 0) {
+						if (sync)
+							map->flush = flush;
+						rc = -1;
+						goto out;
+					}
+				} else {
+					if (perf_mmap__pack(map, rec, record__pushfn,
+							compress_fn, session) != 0) {
+						if (sync)
+							map->flush = flush;
+						rc = -1;
+						goto out;
+					}
 				}
 			} else {
 				int idx;
@@ -812,7 +828,8 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
 				 * becomes available after previous aio write request.
 				 */
 				idx = record__aio_sync(map, false);
-				if (perf_mmap__aio_push(map, rec, idx, record__aio_pushfn, &off) != 0) {
+				if (perf_mmap__aio_push(map, rec, record__aio_pushfn,
+					&off, idx, compress_fn, session) != 0) {
 					record__aio_set_pos(trace_fd, off);
 					if (sync)
 						map->flush = flush;
@@ -839,7 +856,7 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
 	 * at least one event.
 	 */
 	if (bytes_written != rec->bytes_written)
-		rc = record__write(rec, NULL, &finished_round_event, sizeof(finished_round_event));
+		rc = record__write(rec, &finished_round_event, sizeof(finished_round_event));
 
 	if (overwrite)
 		perf_evlist__toggle_bkw_mmap(evlist, BKW_MMAP_EMPTY);
@@ -1193,9 +1210,10 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	fd = perf_data__fd(data);
 	rec->session = session;
 
-	rec->opts.comp_level = 0;
-	session->header.env.comp_level = rec->opts.comp_level;
-	session->header.env.comp_type = PERF_COMP_NONE;
+	if (perf_session__zstd_init(session, rec->opts.comp_level) < 0) {
+		pr_err("Compression initialization failed.\n");
+		return -1;
+	}
 
 	record__init_features(rec);
 
@@ -1526,6 +1544,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	}
 
 out_delete_session:
+	perf_session__zstd_fini(session);
 	perf_session__delete(session);
 	return status;
 }
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 239e9a13c2b7..980784b77fe2 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -156,6 +156,86 @@ void __weak auxtrace_mmap_params__set_idx(struct auxtrace_mmap_params *mp __mayb
 {
 }
 
+static ssize_t perf_mmap__capture(struct perf_mmap *md, int idx,
+			perf_mmap__compress_fn_t compress, void *where)
+{
+	u64 head = perf_mmap__read_head(md);
+	unsigned char *data = md->base + page_size;
+	unsigned long size, size0 = 0;
+	void *buf;
+	int rc = 0;
+	size_t mmap_len = perf_mmap__mmap_len(md);
+
+	rc = perf_mmap__read_init(md);
+	if (rc < 0)
+		return (rc == -EAGAIN) ? 0 : -1;
+
+	/*
+	 * md->base data is copied into md->data[idx] buffer to
+	 * release space in the kernel buffer as fast as possible,
+	 * thru perf_mmap__consume() below.
+	 *
+	 * That lets the kernel to proceed with storing more
+	 * profiling data into the kernel buffer earlier than other
+	 * per-cpu kernel buffers are handled.
+	 *
+	 * Coping can be done in two steps in case the chunk of
+	 * profiling data crosses the upper bound of the kernel buffer.
+	 * In this case we first move part of data from md->start
+	 * till the upper bound and then the reminder from the
+	 * beginning of the kernel buffer till the end of
+	 * the data chunk.
+	 */
+
+	size = md->end - md->start;
+
+	if ((md->start & md->mask) + size != (md->end & md->mask)) {
+		buf = &data[md->start & md->mask];
+		size = md->mask + 1 - (md->start & md->mask);
+		md->start += size;
+		size0 = compress(where, md->aio.data[idx], mmap_len, buf, size);
+	}
+
+	buf = &data[md->start & md->mask];
+	size = md->end - md->start;
+	md->start += size;
+	size0 += compress(where, md->aio.data[idx] + size0, mmap_len - size0, buf, size);
+
+	/*
+	 * Increment md->refcount to guard md->data[idx] buffer
+	 * from premature deallocation because md object can be
+	 * released earlier than aio write request started
+	 * on mmap->data[idx] is complete.
+	 *
+	 * perf_mmap__put() is done at record__aio_complete()
+	 * after started request completion.
+	 */
+	perf_mmap__get(md);
+
+	md->prev = head;
+	perf_mmap__consume(md);
+
+	return size0;
+}
+
+int perf_mmap__pack(struct perf_mmap *md, void *to, perf_mmap__push_fn_t push,
+		perf_mmap__compress_fn_t compress, void *where)
+{
+	int rc = 0;
+	ssize_t size = 0;
+
+	size = perf_mmap__capture(md, /*idx*/ 0, compress, where);
+	if (size > 0) {
+		rc = push(to, md->aio.data[0], size);
+		perf_mmap__put(md);
+		rc = rc < 0 ? -1 : 0;
+	} else if (size < 0) {
+		rc = -1;
+	}
+
+	return rc;
+}
+
 #ifdef HAVE_LIBNUMA_SUPPORT
 static int perf_mmap__aio_alloc(struct perf_mmap *map, int idx)
 {
@@ -311,75 +391,27 @@ static void perf_mmap__aio_munmap_blocks(struct perf_mmap *map)
 	zfree(&map->aio.aiocb);
 }
 
-int perf_mmap__aio_push(struct perf_mmap *md, void *to, int idx,
-			int push(void *to, struct aiocb *cblock, void *buf, size_t size, off_t off),
-			off_t *off)
+int perf_mmap__aio_push(struct perf_mmap *md, void *to,
+		perf_mmap__aio_push_fn_t push, off_t *push_off,
+		int idx, perf_mmap__compress_fn_t compress, void *where)
 {
-	u64 head = perf_mmap__read_head(md);
-	unsigned char *data = md->base + page_size;
-	unsigned long size, size0 = 0;
-	void *buf;
 	int rc = 0;
-
-	rc = perf_mmap__read_init(md);
-	if (rc < 0)
-		return (rc == -EAGAIN) ? 0 : -1;
-
-	/*
-	 * md->base data is copied into md->data[idx] buffer to
-	 * release space in the kernel buffer as fast as possible,
-	 * thru perf_mmap__consume() below.
-	 *
-	 * That lets the kernel to proceed with storing more
-	 * profiling data into the kernel buffer earlier than other
-	 * per-cpu kernel buffers are handled.
-	 *
-	 * Coping can be done in two steps in case the chunk of
-	 * profiling data crosses the upper bound of the kernel buffer.
-	 * In this case we first move part of data from md->start
-	 * till the upper bound and then the reminder from the
-	 * beginning of the kernel buffer till the end of
-	 * the data chunk.
-	 */
-
-	size = md->end - md->start;
-
-	if ((md->start & md->mask) + size != (md->end & md->mask)) {
-		buf = &data[md->start & md->mask];
-		size = md->mask + 1 - (md->start & md->mask);
-		md->start += size;
-		memcpy(md->aio.data[idx], buf, size);
-		size0 = size;
-	}
-
-	buf = &data[md->start & md->mask];
-	size = md->end - md->start;
-	md->start += size;
-	memcpy(md->aio.data[idx] + size0, buf, size);
-
-	/*
-	 * Increment md->refcount to guard md->data[idx] buffer
-	 * from premature deallocation because md object can be
-	 * released earlier than aio write request started
-	 * on mmap->data[idx] is complete.
-	 *
-	 * perf_mmap__put() is done at record__aio_complete()
-	 * after started request completion.
-	 */
-	perf_mmap__get(md);
-
-	md->prev = head;
-	perf_mmap__consume(md);
-
-	rc = push(to, &md->aio.cblocks[idx], md->aio.data[idx], size0 + size, *off);
-	if (!rc) {
-		*off += size0 + size;
-	} else {
-		/*
-		 * Decrement md->refcount back if aio write
-		 * operation failed to start.
-		 */
-		perf_mmap__put(md);
+	ssize_t size = 0;
+
+	size = perf_mmap__capture(md, idx, compress, where);
+	if (size > 0) {
+		rc = push(to, md->aio.data[idx], size, *push_off, &md->aio.cblocks[idx]);
+		if (!rc) {
+			*push_off += size;
+		} else {
+			/*
+			 * Decrement md->refcount back if aio write
+			 * operation failed to start.
+			 */
+			perf_mmap__put(md);
+		}
+	} else if (size < 0) {
+		rc = -1;
 	}
 
 	return rc;
@@ -553,8 +585,7 @@ int perf_mmap__read_init(struct perf_mmap *map)
 	return __perf_mmap__read_init(map);
 }
 
-int perf_mmap__push(struct perf_mmap *md, void *to,
-		    int push(struct perf_mmap *map, void *to, void *buf, size_t size))
+int perf_mmap__push(struct perf_mmap *md, void *to, perf_mmap__push_fn_t push)
 {
 	u64 head = perf_mmap__read_head(md);
 	unsigned char *data = md->base + page_size;
@@ -573,7 +604,7 @@ int perf_mmap__push(struct perf_mmap *md, void *to,
 		size = md->mask + 1 - (md->start & md->mask);
 		md->start += size;
 
-		if (push(md, to, buf, size) < 0) {
+		if (push(to, buf, size) < 0) {
 			rc = -1;
 			goto out;
 		}
@@ -583,7 +614,7 @@ int perf_mmap__push(struct perf_mmap *md, void *to,
 	size = md->end - md->start;
 	md->start += size;
 
-	if (push(md, to, buf, size) < 0) {
+	if (push(to, buf, size) < 0) {
 		rc = -1;
 		goto out;
 	}
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index 4fd7d82825b7..bf70972c7101 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -97,16 +97,24 @@ union perf_event *perf_mmap__read_forward(struct perf_mmap *map);
 
 union perf_event *perf_mmap__read_event(struct perf_mmap *map);
 
-int perf_mmap__push(struct perf_mmap *md, void *to,
-		    int push(struct perf_mmap *map, void *to, void *buf, size_t size));
+typedef int (*perf_mmap__push_fn_t)(void *to, void *buf, size_t size);
+int perf_mmap__push(struct perf_mmap *md, void *to, perf_mmap__push_fn_t push);
+
+typedef size_t (*perf_mmap__compress_fn_t)(void *where, void *dst, size_t dst_size,
+		void *src, size_t src_size);
+int perf_mmap__pack(struct perf_mmap *md, void *to, perf_mmap__push_fn_t push,
+		perf_mmap__compress_fn_t compress, void *where);
+
+typedef int (*perf_mmap__aio_push_fn_t)(void *to, void *buf, size_t size,
+		off_t push_off, struct aiocb *cblock);
+
 #ifdef HAVE_AIO_SUPPORT
-int perf_mmap__aio_push(struct perf_mmap *md, void *to, int idx,
-			int push(void *to, struct aiocb *cblock, void *buf, size_t size, off_t off),
-			off_t *off);
+int perf_mmap__aio_push(struct perf_mmap *md, void *to, perf_mmap__aio_push_fn_t push, off_t *push_off,
+		int idx, perf_mmap__compress_fn_t compress_fn, void *where);
 #else
-static inline int perf_mmap__aio_push(struct perf_mmap *md __maybe_unused, void *to __maybe_unused, int idx __maybe_unused,
-	int push(void *to, struct aiocb *cblock, void *buf, size_t size, off_t off) __maybe_unused,
-	off_t *off __maybe_unused)
+static inline int perf_mmap__aio_push(struct perf_mmap *md __maybe_unused, void *to __maybe_unused,
+	perf_mmap__aio_push_fn_t push __maybe_unused, off_t *push_off __maybe_unused,
+	int idx __maybe_unused, perf_mmap__compress_fn_t compress __maybe_unused, void *where __maybe_unused)
 {
 	return 0;
 }
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 18fb9c8cbf9c..5d406eebd058 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -29,6 +29,112 @@
 #include "stat.h"
 #include "arch/common.h"
 
+#ifdef HAVE_ZSTD_SUPPORT
+int perf_session__zstd_init(struct perf_session *session, int level)
+{
+	size_t ret;
+
+	session->header.env.comp_type  = PERF_COMP_NONE;
+	session->header.env.comp_level = 0;
+
+	session->zstd_cstream = ZSTD_createCStream();
+	if (session->zstd_cstream == NULL) {
+		pr_err("Couldn't create compression stream.\n");
+		return -1;
+	}
+
+	ret = ZSTD_initCStream(session->zstd_cstream, level);
+	if (ZSTD_isError(ret)) {
+		pr_err("Failed to initialize compression stream: %s\n", ZSTD_getErrorName(ret));
+		return -1;
+	}
+
+	session->header.env.comp_type  = PERF_COMP_ZSTD;
+	session->header.env.comp_level = level;
+
+	return 0;
+}
+
+int perf_session__zstd_fini(struct perf_session *session)
+{
+	if (session->zstd_cstream) {
+		ZSTD_freeCStream(session->zstd_cstream);
+		session->zstd_cstream = NULL;
+	}
+
+	return 0;
+}
+
+size_t perf_session__zstd_compress(void *to,  void *dst, size_t dst_size,
+				   void *src, size_t src_size)
+{
+	struct perf_session *session = to;
+	size_t ret, size, compressed = 0;
+	struct compressed_event *event = NULL;
+	/* maximum size of record data size (2^16 - 1 - header) */
+	const size_t max_data_size = (1 << 8 * sizeof(event->header.size)) -
+				      1 - sizeof(struct compressed_event);
+	ZSTD_inBuffer input = { src, src_size, 0 };
+	ZSTD_outBuffer output;
+
+	while (input.pos < input.size) {
+		event = dst;
+
+		event->header.type = PERF_RECORD_COMPRESSED;
+		event->header.size = size = sizeof(struct compressed_event);
+		compressed += size;
+		dst += size;
+		dst_size -= size;
+
+		output = (ZSTD_outBuffer){ dst, (dst_size > max_data_size) ?
+						max_data_size : dst_size, 0 };
+		ret = ZSTD_compressStream(session->zstd_cstream, &output, &input);
+		ZSTD_flushStream(session->zstd_cstream, &output);
+		if (ZSTD_isError(ret)) {
+			pr_err("failed to compress %ld bytes: %s\n",
+				(long)src_size, ZSTD_getErrorName(ret));
+			return perf_session__zstd_copy(session, dst, dst_size, src, src_size);
+		}
+		size = output.pos;
+
+		event->header.size += size;
+		compressed += size;
+		dst += size;
+		dst_size -= size;
+	}
+
+	session->bytes_transferred += src_size;
+	session->bytes_compressed  += compressed;
+
+	return compressed;
+}
+#else /* !HAVE_ZSTD_SUPPORT */
+int perf_session__zstd_init(struct perf_session *session __maybe_unused, int level __maybe_unused)
+{
+	return 0;
+}
+
+int perf_session__zstd_fini(struct perf_session *session __maybe_unused)
+{
+	return 0;
+}
+
+size_t perf_session__zstd_compress(void *to __maybe_unused,
+				void *dst __maybe_unused, size_t dst_size __maybe_unused,
+				void *src __maybe_unused, size_t src_size __maybe_unused)
+{
+	return 0;
+}
+#endif
+
+size_t perf_session__zstd_copy(void *to __maybe_unused,
+			void *dst, size_t dst_size __maybe_unused,
+			void *src, size_t src_size)
+{
+	memcpy(dst, src, src_size);
+	return src_size;
+}
+
 static int perf_session__deliver_event(struct perf_session *session,
 				       union perf_event *event,
 				       struct perf_tool *tool,
diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
index 0e14884f28b2..d8f3284cd838 100644
--- a/tools/perf/util/session.h
+++ b/tools/perf/util/session.h
@@ -11,6 +11,9 @@
 #include <linux/kernel.h>
 #include <linux/rbtree.h>
 #include <linux/perf_event.h>
+#ifdef HAVE_ZSTD_SUPPORT
+#include <zstd.h>
+#endif
 
 struct ip_callchain;
 struct symbol;
@@ -37,6 +40,9 @@ struct perf_session {
 	struct perf_tool	*tool;
 	u64			bytes_transferred;
 	u64			bytes_compressed;
+#ifdef HAVE_ZSTD_SUPPORT
+	ZSTD_CStream		*zstd_cstream;
+#endif
 };
 
 struct perf_tool;
@@ -122,6 +128,13 @@ int perf_session__deliver_synth_event(struct perf_session *session,
 				      union perf_event *event,
 				      struct perf_sample *sample);
 
+int perf_session__zstd_init(struct perf_session *session, int level);
+int perf_session__zstd_fini(struct perf_session *session);
+size_t perf_session__zstd_copy(void *to, void *dst, size_t dst_size,
+			void *src, size_t src_size);
+size_t perf_session__zstd_compress(void *to, void *dst, size_t dst_size,
+			void *src, size_t src_size);
+
 int perf_event__process_id_index(struct perf_session *session,
 				 union perf_event *event);
 
