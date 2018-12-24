Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E6CBC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 13:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2531721783
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 13:46:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbeLXNqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 08:46:50 -0500
Received: from mga06.intel.com ([134.134.136.31]:11612 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbeLXNqu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 08:46:50 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Dec 2018 05:46:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,392,1539673200"; 
   d="scan'208";a="103053348"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 24 Dec 2018 05:46:50 -0800
Received: from [10.252.4.220] (abudanko-mobl.ccr.corp.intel.com [10.252.4.220])
        by linux.intel.com (Postfix) with ESMTP id 55BDD58044E;
        Mon, 24 Dec 2018 05:46:47 -0800 (PST)
Subject: [PATCH v1 3/4] perf record: enable runtime trace compression
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <eaa8b5da-103f-61c8-bdca-2a2a27bf1715@linux.intel.com>
Organization: Intel Corp.
Message-ID: <767c2f35-48c8-1249-c8b7-974877561b8b@linux.intel.com>
Date:   Mon, 24 Dec 2018 16:46:46 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <eaa8b5da-103f-61c8-bdca-2a2a27bf1715@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Compression is implemented using Zstandard API and employs AIO buffers
as the memory to operate on so memcpy() is substituted by the API call.
If the API call fails for some reason copying falls back to memcpy().
Data chunks are split and packed into PERF_RECORD_COMPRESSED records by
64KB at max. mmap-flush option value can be used to avoid compression of
every single byte of data and increase compression ratio.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/builtin-record.c | 122 ++++++++++++++++++++++++++++++++++--
 tools/perf/util/mmap.c      |  13 ++--
 tools/perf/util/mmap.h      |   2 +
 3 files changed, 127 insertions(+), 10 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index cb0b880281d7..0ef1878967f8 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -53,6 +53,9 @@
 #include <sys/mman.h>
 #include <sys/wait.h>
 #include <linux/time64.h>
+#ifdef HAVE_ZSTD_SUPPORT
+#include <zstd.h>
+#endif
 
 struct switch_output {
 	bool		 enabled;
@@ -83,6 +86,9 @@ struct record {
 	unsigned long long	samples;
 	u64			bytes_transferred;
 	u64			bytes_compressed;
+#ifdef HAVE_ZSTD_SUPPORT
+	ZSTD_CStream		*zstd_cstream;
+#endif
 };
 
 static volatile int auxtrace_record__snapshot_started;
@@ -358,6 +364,109 @@ static int record__mmap_flush_parse(const struct option *opt,
 	return 0;
 }
 
+#ifdef HAVE_ZSTD_SUPPORT
+static int record__zstd_init(struct record *rec)
+{
+	size_t ret;
+
+	if (rec->opts.comp_level == 0)
+		return 0;
+
+	rec->zstd_cstream = ZSTD_createCStream();
+	if (rec->zstd_cstream == NULL) {
+		pr_err("Couldn't create compression stream, disables trace compression\n");
+		return -1;
+	}
+
+	ret = ZSTD_initCStream(rec->zstd_cstream, rec->opts.comp_level);
+	if (ZSTD_isError(ret)) {
+		pr_err("Failed to initialize compression stream: %s\n", ZSTD_getErrorName(ret));
+		return -1;
+	}
+
+	return 0;
+}
+
+static int record__zstd_fini(struct record *rec)
+{
+	if (rec->zstd_cstream) {
+		ZSTD_freeCStream(rec->zstd_cstream);
+		rec->zstd_cstream = NULL;
+	}
+
+	return 0;
+}
+
+static size_t record__zstd_compress(void *to,  void *dst, size_t dst_size,
+			            void *src, size_t src_size)
+{
+	void *dst_head = dst;
+	struct record *rec = to;
+	size_t ret, size, compressed = 0;
+	struct compressed_event *event = NULL;
+	/* maximum size of record data size (2^16 - 1 - header) */
+	const size_t max_data_size = (1 << 8 * sizeof(event->header.size)) -
+				      1 - sizeof(struct compressed_event);
+	ZSTD_inBuffer input = { src, src_size, 0 };
+	ZSTD_outBuffer output;
+
+	if (rec->opts.comp_level == 0) {
+		memcpy(dst_head, src, src_size);
+		return src_size;
+	}
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
+		ret = ZSTD_compressStream(rec->zstd_cstream, &output, &input);
+		ZSTD_flushStream(rec->zstd_cstream, &output);
+		if (ZSTD_isError(ret)) {
+			pr_err("failed to compress %ld bytes: %s\n",
+				(long)src_size, ZSTD_getErrorName(ret));
+			memcpy(dst_head, src, src_size);
+			return src_size;
+		}
+		size = output.pos;
+
+		event->header.size += size;
+		compressed += size;
+		dst += size;
+		dst_size -= size;
+	}
+
+	rec->bytes_transferred += src_size;
+	rec->bytes_compressed += compressed;
+
+	return compressed;
+}
+#else /* !HAVE_ZSTD_SUPPORT */
+static int record__zstd_init(struct record *rec __maybe_unused)
+{
+	return -1;
+}
+
+static int record__zstd_fini(struct record *rec __maybe_unused)
+{
+	return 0;
+}
+
+static size_t record__zstd_compress(void *to __maybe_unused,
+			            void *dst, size_t dst_size __maybe_unused,
+			            void *src, size_t src_size)
+{
+	memcpy(dst, src, src_size);
+	return src_size;
+}
+#endif
+
 static int process_synthesized_event(struct perf_tool *tool,
 				     union perf_event *event,
 				     struct perf_sample *sample __maybe_unused,
@@ -799,7 +908,8 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
 				 * becomes available after previous aio write request.
 				 */
 				idx = record__aio_sync(map, false);
-				if (perf_mmap__aio_push(map, rec, idx, record__aio_pushfn, &off) != 0) {
+				if (perf_mmap__aio_push(map, rec, idx,
+					record__zstd_compress, record__aio_pushfn, &off) != 0) {
 					record__aio_set_pos(trace_fd, off);
 					if (sync)
 						map->flush = flush;
@@ -1175,8 +1285,12 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	fd = perf_data__fd(data);
 	rec->session = session;
 
-	session->header.env.comp_type = PERF_COMP_NONE;
-	rec->opts.comp_level = 0;
+	if (record__zstd_init(rec) == 0) {
+		session->header.env.comp_type = PERF_COMP_ZSTD;
+	} else {
+		session->header.env.comp_type = PERF_COMP_NONE;
+		rec->opts.comp_level = 0;
+	}
 	session->header.env.comp_level = rec->opts.comp_level;
 
 	record__init_features(rec);
@@ -1447,7 +1561,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 out_child:
 	record__mmap_read_all(rec, true);
 	record__aio_mmap_read_sync(rec);
-
+	record__zstd_fini(rec);
 	if (!quiet && rec->bytes_transferred && rec->bytes_compressed) {
 		float ratio = (float)rec->bytes_transferred/(float)rec->bytes_compressed;
 		session->header.env.comp_ratio = ratio + 0.5;
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 5e71b0183e33..58a71ca77df5 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -218,14 +218,16 @@ static void perf_mmap__aio_munmap(struct perf_mmap *map)
 }
 
 int perf_mmap__aio_push(struct perf_mmap *md, void *to, int idx,
+			size_t compress(void *to, void *dst, size_t dst_size, void *src, size_t src_size),
 			int push(void *to, struct aiocb *cblock, void *buf, size_t size, off_t off),
 			off_t *off)
 {
 	u64 head = perf_mmap__read_head(md);
 	unsigned char *data = md->base + page_size;
-	unsigned long size, size0 = 0;
+	size_t size, size0 = 0, size1 = 0;
 	void *buf;
 	int rc = 0;
+	size_t mmap_len = perf_mmap__mmap_len(md);
 
 	rc = perf_mmap__read_init(md);
 	if (rc < 0)
@@ -254,14 +256,13 @@ int perf_mmap__aio_push(struct perf_mmap *md, void *to, int idx,
 		buf = &data[md->start & md->mask];
 		size = md->mask + 1 - (md->start & md->mask);
 		md->start += size;
-		memcpy(md->aio.data[idx], buf, size);
-		size0 = size;
+		size0 = compress(to, md->aio.data[idx], mmap_len, buf, size);
 	}
 
 	buf = &data[md->start & md->mask];
 	size = md->end - md->start;
 	md->start += size;
-	memcpy(md->aio.data[idx] + size0, buf, size);
+	size1 = compress(to, md->aio.data[idx] + size0, mmap_len - size0, buf, size);
 
 	/*
 	 * Increment md->refcount to guard md->data[idx] buffer
@@ -277,9 +278,9 @@ int perf_mmap__aio_push(struct perf_mmap *md, void *to, int idx,
 	md->prev = head;
 	perf_mmap__consume(md);
 
-	rc = push(to, &md->aio.cblocks[idx], md->aio.data[idx], size0 + size, *off);
+	rc = push(to, &md->aio.cblocks[idx], md->aio.data[idx], size0 + size1, *off);
 	if (!rc) {
-		*off += size0 + size;
+		*off += size0 + size1;
 	} else {
 		/*
 		 * Decrement md->refcount back if aio write
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index afbfb8b58d45..0b3b8b46410a 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -100,10 +100,12 @@ int perf_mmap__push(struct perf_mmap *md, void *to,
 		    int push(struct perf_mmap *map, void *to, void *buf, size_t size));
 #ifdef HAVE_AIO_SUPPORT
 int perf_mmap__aio_push(struct perf_mmap *md, void *to, int idx,
+			size_t compress(void *to, void *dst, size_t dst_size, void *src, size_t src_size),
 			int push(void *to, struct aiocb *cblock, void *buf, size_t size, off_t off),
 			off_t *off);
 #else
 static inline int perf_mmap__aio_push(struct perf_mmap *md __maybe_unused, void *to __maybe_unused, int idx __maybe_unused,
+	size_t compress(void *to, void *dst, size_t dst_size, void *src, size_t src_size) __maybe_unused,
 	int push(void *to, struct aiocb *cblock, void *buf, size_t size, off_t off) __maybe_unused,
 	off_t *off __maybe_unused)
 {
