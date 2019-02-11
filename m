Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 022F4C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3F82218A4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 20:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbfBKUZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 15:25:06 -0500
Received: from mga14.intel.com ([192.55.52.115]:17558 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727082AbfBKUZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 15:25:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2019 12:25:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,360,1544515200"; 
   d="scan'208";a="318135509"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 11 Feb 2019 12:25:04 -0800
Received: from [10.252.27.66] (abudanko-mobl.ccr.corp.intel.com [10.252.27.66])
        by linux.intel.com (Postfix) with ESMTP id C702F5800C6;
        Mon, 11 Feb 2019 12:25:01 -0800 (PST)
Subject: [PATCH v2 4/4] perf report: support record trace file decompression
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
Message-ID: <4f45c930-cf39-76b0-5c56-ee4fb0705fa3@linux.intel.com>
Date:   Mon, 11 Feb 2019 23:25:00 +0300
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


PERF_RECORD_COMPRESSED records are decompressed from trace file into
a linked list of mmaped memory regions using streaming Zstandard API.
After that the regions are loaded fetching uncompressed events. When
dumping raw trace (e.g., perf report -D --header) file offsets of
events from compressed records are set to zero.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
Changes in v2:
- moved compression/decompression code to session layer

---
 tools/perf/builtin-report.c |   5 +-
 tools/perf/util/session.c   | 165 +++++++++++++++++++++++++++++++++++-
 tools/perf/util/session.h   |  11 +++
 tools/perf/util/tool.h      |   2 +
 4 files changed, 181 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 2e8c74d6430c..3bfb74c11875 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1215,6 +1215,9 @@ int cmd_report(int argc, const char **argv)
 	if (session == NULL)
 		return -1;
 
+	if (perf_session__zstd_init(session, 0) < 0)
+		pr_warning("Decompression initialization failed. Reported data may be incomplete.\n");
+
 	if (report.queue_size) {
 		ordered_events__set_alloc_size(&session->ordered_events,
 					       report.queue_size);
@@ -1427,7 +1430,7 @@ int cmd_report(int argc, const char **argv)
 
 error:
 	zfree(&report.ptime_range);
-
+	perf_session__zstd_fini(session);
 	perf_session__delete(session);
 	return ret;
 }
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 5d406eebd058..c501cb904d95 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -34,6 +34,21 @@ int perf_session__zstd_init(struct perf_session *session, int level)
 {
 	size_t ret;
 
+	session->zstd_dstream = ZSTD_createDStream();
+	if (session->zstd_dstream == NULL) {
+		pr_err("Couldn't create decompression stream.\n");
+		return -1;
+	}
+
+	ret = ZSTD_initDStream(session->zstd_dstream);
+	if (ZSTD_isError(ret)) {
+		pr_err("Failed to initialize decompression stream: %s\n", ZSTD_getErrorName(ret));
+		return -1;
+	}
+
+	if (level == 0)
+		return 0;
+
 	session->header.env.comp_type  = PERF_COMP_NONE;
 	session->header.env.comp_level = 0;
 
@@ -57,6 +72,22 @@ int perf_session__zstd_init(struct perf_session *session, int level)
 
 int perf_session__zstd_fini(struct perf_session *session)
 {
+	struct decomp *next = session->decomp, *decomp;
+	size_t decomp_len = session->header.env.comp_mmap_len;
+
+	if (session->zstd_dstream) {
+		ZSTD_freeDStream(session->zstd_dstream);
+		session->zstd_dstream = NULL;
+	}
+
+	do {
+		decomp = next;
+		if (decomp == NULL)
+			break;
+		next = decomp->next;
+		munmap(decomp, decomp_len + sizeof(struct decomp));
+	} while (1);
+
 	if (session->zstd_cstream) {
 		ZSTD_freeCStream(session->zstd_cstream);
 		session->zstd_cstream = NULL;
@@ -108,6 +139,80 @@ size_t perf_session__zstd_compress(void *to,  void *dst, size_t dst_size,
 
 	return compressed;
 }
+
+static size_t perf_session__zstd_decompress(struct perf_session *session,
+					void *src, size_t src_size,
+					void *dst, size_t dst_size)
+{
+	size_t ret;
+	ZSTD_inBuffer input = { src, src_size, 0 };
+	ZSTD_outBuffer output = { dst, dst_size, 0 };
+
+	while (input.pos < input.size) {
+		ret = ZSTD_decompressStream(session->zstd_dstream, &output, &input);
+		if (ZSTD_isError(ret)) {
+			pr_err("failed to decompress (B): %ld -> %ld : %s\n",
+				src_size, output.size, ZSTD_getErrorName(ret));
+			break;
+		}
+		output.dst  = dst + output.pos;
+		output.size = dst_size - output.pos;
+	}
+
+	return output.pos;
+}
+
+static int perf_session__process_compressed_event(struct perf_session *session,
+					union perf_event *event, u64 file_offset)
+{
+	void *src;
+	size_t decomp_size, src_size;
+	u64 decomp_last_rem = 0;
+	size_t decomp_len = session->header.env.comp_mmap_len;
+	struct decomp *decomp, *decomp_last = session->decomp_last;
+
+	decomp = mmap(NULL, sizeof(struct decomp) + decomp_len, PROT_READ|PROT_WRITE,
+		      MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
+	if (decomp == MAP_FAILED) {
+		pr_err("Couldn't allocate memory for decompression\n");
+		return -1;
+	}
+
+	decomp->file_pos = file_offset;
+	decomp->head = 0;
+
+	if (decomp_last) {
+		decomp_last_rem = decomp_last->size - decomp_last->head;
+		memcpy(decomp->data, &(decomp_last->data[decomp_last->head]), decomp_last_rem);
+		decomp->size = decomp_last_rem;
+	}
+
+	src = (void *)event + sizeof(struct compressed_event);
+	src_size = event->pack.header.size - sizeof(struct compressed_event);
+
+	decomp_size = perf_session__zstd_decompress(session, src, src_size,
+				&(decomp->data[decomp_last_rem]), decomp_len - decomp_last_rem);
+	if (!decomp_size) {
+		munmap(decomp, sizeof(struct decomp) + decomp_len);
+		pr_err("Couldn't decompress data\n");
+		return -1;
+	}
+
+	decomp->size += decomp_size;
+
+	if (session->decomp == NULL) {
+		session->decomp = decomp;
+		session->decomp_last = decomp;
+	} else {
+		session->decomp_last->next = decomp;
+		session->decomp_last = decomp;
+	}
+
+	pr_debug("decomp (B): %ld to %ld\n", src_size, decomp_size);
+
+	return 0;
+}
+
 #else /* !HAVE_ZSTD_SUPPORT */
 int perf_session__zstd_init(struct perf_session *session __maybe_unused, int level __maybe_unused)
 {
@@ -125,6 +230,14 @@ size_t perf_session__zstd_compress(void *to __maybe_unused,
 {
 	return 0;
 }
+
+static int perf_session__process_compressed_event(struct perf_session *session __maybe_unused,
+				union perf_event *event __maybe_unused,
+				u64 file_offset __maybe_unused)
+{
+	dump_printf(": unhandled!\n");
+	return 0;
+}
 #endif
 
 size_t perf_session__zstd_copy(void *to __maybe_unused,
@@ -533,6 +646,8 @@ void perf_tool__fill_defaults(struct perf_tool *tool)
 		tool->time_conv = process_event_op2_stub;
 	if (tool->feature == NULL)
 		tool->feature = process_event_op2_stub;
+	if (tool->compressed == NULL)
+		tool->compressed = perf_session__process_compressed_event;
 }
 
 static void swap_sample_id_all(union perf_event *event, void *data)
@@ -1469,7 +1584,8 @@ static s64 perf_session__process_user_event(struct perf_session *session,
 	int fd = perf_data__fd(session->data);
 	int err;
 
-	dump_event(session->evlist, event, file_offset, &sample);
+	if (event->header.type != PERF_RECORD_COMPRESSED)
+		dump_event(session->evlist, event, file_offset, &sample);
 
 	/* These events are processed right away */
 	switch (event->header.type) {
@@ -1522,6 +1638,11 @@ static s64 perf_session__process_user_event(struct perf_session *session,
 		return tool->time_conv(session, event);
 	case PERF_RECORD_HEADER_FEATURE:
 		return tool->feature(session, event);
+	case PERF_RECORD_COMPRESSED:
+		err = tool->compressed(session, event, file_offset);
+		if (err)
+			dump_event(session->evlist, event, file_offset, &sample);
+		return 0;
 	default:
 		return -EINVAL;
 	}
@@ -1804,6 +1925,8 @@ static int perf_session__flush_thread_stacks(struct perf_session *session)
 
 volatile int session_done;
 
+static int __perf_session__process_decomp_events(struct perf_session *session);
+
 static int __perf_session__process_pipe_events(struct perf_session *session)
 {
 	struct ordered_events *oe = &session->ordered_events;
@@ -1884,6 +2007,10 @@ static int __perf_session__process_pipe_events(struct perf_session *session)
 	if (skip > 0)
 		head += skip;
 
+	err = __perf_session__process_decomp_events(session);
+	if (err)
+		goto out_err;
+
 	if (!session_done())
 		goto more;
 done:
@@ -1932,6 +2059,38 @@ fetch_mmaped_event(struct perf_session *session,
 	return event;
 }
 
+static int __perf_session__process_decomp_events(struct perf_session *session)
+{
+	s64 skip;
+	u64 size, file_pos = 0;
+	union perf_event *event;
+	struct decomp *decomp = session->decomp_last;
+
+	if (!decomp)
+		return 0;
+
+	while (decomp->head < decomp->size && !session_done()) {
+		event = fetch_mmaped_event(session, decomp->head, decomp->size, decomp->data);
+		if (!event)
+			break;
+
+		size = event->header.size;
+		if (size < sizeof(struct perf_event_header) ||
+		    (skip = perf_session__process_event(session, event, file_pos)) < 0) {
+			pr_err("%#" PRIx64 " [%#x]: failed to process type: %d\n",
+				decomp->file_pos + decomp->head, event->header.size, event->header.type);
+			return -EINVAL;
+		}
+
+		if (skip)
+			size += skip;
+
+		decomp->head += size;
+	}
+
+	return 0;
+}
+
 /*
  * On 64bit we can mmap the data file in one go. No need for tiny mmap
  * slices. On 32bit we use 32MB.
@@ -2032,6 +2191,10 @@ reader__process_events(struct reader *rd, struct perf_session *session,
 	head += size;
 	file_pos += size;
 
+	err = __perf_session__process_decomp_events(session);
+	if (err)
+		goto out;
+
 	ui_progress__update(prog, size);
 
 	if (session_done())
diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
index d8f3284cd838..06a0536adbe0 100644
--- a/tools/perf/util/session.h
+++ b/tools/perf/util/session.h
@@ -42,7 +42,18 @@ struct perf_session {
 	u64			bytes_compressed;
 #ifdef HAVE_ZSTD_SUPPORT
 	ZSTD_CStream		*zstd_cstream;
+	ZSTD_DStream		*zstd_dstream;
 #endif
+	struct decomp		*decomp;
+	struct decomp		*decomp_last;
+};
+
+struct decomp {
+	struct decomp *next;
+	u64 file_pos;
+	u64 head;
+	size_t size;
+	char data[];
 };
 
 struct perf_tool;
diff --git a/tools/perf/util/tool.h b/tools/perf/util/tool.h
index 250391672f9f..9096a6e3de59 100644
--- a/tools/perf/util/tool.h
+++ b/tools/perf/util/tool.h
@@ -28,6 +28,7 @@ typedef int (*event_attr_op)(struct perf_tool *tool,
 
 typedef int (*event_op2)(struct perf_session *session, union perf_event *event);
 typedef s64 (*event_op3)(struct perf_session *session, union perf_event *event);
+typedef int (*event_op4)(struct perf_session *session, union perf_event *event, u64 data);
 
 typedef int (*event_oe)(struct perf_tool *tool, union perf_event *event,
 			struct ordered_events *oe);
@@ -72,6 +73,7 @@ struct perf_tool {
 			stat,
 			stat_round,
 			feature;
+	event_op4	compressed;
 	event_op3	auxtrace;
 	bool		ordered_events;
 	bool		ordering_requires_timestamps;
