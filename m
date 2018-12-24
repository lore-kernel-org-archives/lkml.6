Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88E63C43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 14:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F5672184A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 14:00:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbeLXOAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 09:00:34 -0500
Received: from mga03.intel.com ([134.134.136.65]:26132 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725355AbeLXOAe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 09:00:34 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Dec 2018 06:00:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,392,1539673200"; 
   d="scan'208";a="112982604"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 24 Dec 2018 06:00:29 -0800
Received: from [10.252.4.220] (abudanko-mobl.ccr.corp.intel.com [10.252.4.220])
        by linux.intel.com (Postfix) with ESMTP id 9C1C658044E;
        Mon, 24 Dec 2018 06:00:26 -0800 (PST)
Subject: [PATCH v1 4/4] perf report: support record trace file decompression
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
Message-ID: <dca35458-ec72-e192-54ac-769e50c122f3@linux.intel.com>
Date:   Mon, 24 Dec 2018 17:00:24 +0300
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


PERF_RECORD_COMPRESSED records are decompressed from trace file into a 
linked list of mmaped memory regions using Zstandard API. After that the 
region is loaded fetching uncompressed events. When dumping raw trace 
like perf report -D file offsets of events from compressed records are 
set to zero.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/builtin-report.c | 151 +++++++++++++++++++++++++++++++++++-
 tools/perf/util/machine.c   |   4 +
 tools/perf/util/session.c   |  59 +++++++++++++-
 tools/perf/util/session.h   |  16 ++++
 tools/perf/util/tool.h      |   2 +
 5 files changed, 230 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 4958095be4fc..1c45e674743d 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -52,7 +52,10 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <unistd.h>
-#include <linux/mman.h>
+#include <sys/mman.h>
+#ifdef HAVE_ZSTD_SUPPORT
+#include <zstd.h>
+#endif
 
 struct report {
 	struct perf_tool	tool;
@@ -118,6 +121,94 @@ static int report__config(const char *var, const char *value, void *cb)
 	return 0;
 }
 
+#ifdef HAVE_ZSTD_SUPPORT
+static int report__zstd_init(struct perf_session *session)
+{
+	size_t ret;
+
+	session->zstd_dstream = ZSTD_createDStream();
+	if (session->zstd_dstream == NULL)
+	{
+		pr_err("Couldn't create decompression stream, disables trace compression\n");
+		return -1;
+	}
+
+	ret = ZSTD_initDStream(session->zstd_dstream);
+	if (ZSTD_isError(ret))
+	{
+		pr_err("Failed to initialize decompression stream: %s\n", ZSTD_getErrorName(ret));
+		return -1;
+	}
+
+	return 0;
+}
+
+static int report__zstd_fini(struct perf_session *session)
+{
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
+	return 0;
+}
+
+static size_t report__zstd_decompress(struct perf_session *session,
+		                      void *src, size_t src_size,
+		                      void *dst, size_t dst_size)
+{
+	size_t ret;
+	ZSTD_inBuffer input = { src, src_size, 0 };
+	ZSTD_outBuffer output = { dst, dst_size, 0 };
+
+	if (session->zstd_dstream == NULL)
+		return 0;
+
+	while (input.pos < input.size) {
+		ret = ZSTD_decompressStream(session->zstd_dstream, &output, &input);
+		if (ZSTD_isError(ret))
+		{
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
+#else /* !HAVE_ZSTD_SUPPORT */
+static int report__zstd_init(struct perf_session *session __maybe_unused)
+{
+	return -1;
+}
+
+static int report__zstd_fini(struct perf_session *session __maybe_unused)
+{
+	return 0;
+}
+
+static size_t report__zstd_decompress(struct perf_session *session __maybe_unused,
+				      void *src __maybe_unused, size_t src_size __maybe_unused,
+				      void *dst __maybe_unused, size_t dst_size __maybe_unused)
+{
+	return 0;
+}
+#endif
+
 static int hist_iter__report_callback(struct hist_entry_iter *iter,
 				      struct addr_location *al, bool single,
 				      void *arg)
@@ -225,6 +316,57 @@ static int process_feature_event(struct perf_session *session,
 	return 0;
 }
 
+static int process_compressed_event(struct perf_session *session,
+		                    union perf_event *event, u64 file_offset)
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
+	src = (void*)event + sizeof(struct compressed_event);
+	src_size = event->pack.header.size - sizeof(struct compressed_event);
+
+	decomp_size = report__zstd_decompress(session, src, src_size,
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
 static int process_sample_event(struct perf_tool *tool,
 				union perf_event *event,
 				struct perf_sample *sample,
@@ -983,6 +1125,7 @@ int cmd_report(int argc, const char **argv)
 			.auxtrace	 = perf_event__process_auxtrace,
 			.event_update	 = perf_event__process_event_update,
 			.feature	 = process_feature_event,
+			.compressed	 = process_compressed_event,
 			.ordered_events	 = true,
 			.ordering_requires_timestamps = true,
 		},
@@ -1205,6 +1348,10 @@ int cmd_report(int argc, const char **argv)
 
 	report.session = session;
 
+	if (session->header.env.comp_type == PERF_COMP_ZSTD &&
+	    session->header.env.comp_level)
+		report__zstd_init(session);
+
 	has_br_stack = perf_header__has_feat(&session->header,
 					     HEADER_BRANCH_STACK);
 
@@ -1409,6 +1556,8 @@ int cmd_report(int argc, const char **argv)
 error:
 	zfree(&report.ptime_range);
 
+	report__zstd_fini(session);
+
 	perf_session__delete(session);
 	return ret;
 }
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 6fcb3bce0442..66d1ed7e7a80 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -972,6 +972,10 @@ int machine__map_x86_64_entry_trampolines(struct machine *machine,
 			continue;
 
 		dest_map = map_groups__find(kmaps, map->pgoff);
+		if (!dest_map) {
+			pr_debug("dest_map for %lx is NULL\n", map->pgoff);
+			continue;
+		}
 		if (dest_map != map)
 			map->pgoff = dest_map->map_ip(dest_map, map->pgoff);
 		found = true;
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 78a067777144..be717ebcdb85 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -296,6 +296,13 @@ static int process_event_op2_stub(struct perf_session *session __maybe_unused,
 	return 0;
 }
 
+static int process_event_op4_stub(struct perf_session *session __maybe_unused,
+				  union perf_event *event __maybe_unused,
+				  u64 data __maybe_unused)
+{
+	dump_printf(": unhandled!\n");
+	return 0;
+}
 
 static
 int process_event_thread_map_stub(struct perf_session *session __maybe_unused,
@@ -418,6 +425,8 @@ void perf_tool__fill_defaults(struct perf_tool *tool)
 		tool->time_conv = process_event_op2_stub;
 	if (tool->feature == NULL)
 		tool->feature = process_event_op2_stub;
+	if (tool->compressed == NULL)
+		tool->compressed = process_event_op4_stub;
 }
 
 static void swap_sample_id_all(union perf_event *event, void *data)
@@ -1345,7 +1354,8 @@ static s64 perf_session__process_user_event(struct perf_session *session,
 	int fd = perf_data__fd(session->data);
 	int err;
 
-	dump_event(session->evlist, event, file_offset, &sample);
+	if (event->header.type != PERF_RECORD_COMPRESSED)
+		dump_event(session->evlist, event, file_offset, &sample);
 
 	/* These events are processed right away */
 	switch (event->header.type) {
@@ -1398,6 +1408,11 @@ static s64 perf_session__process_user_event(struct perf_session *session,
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
@@ -1673,6 +1688,8 @@ static int perf_session__flush_thread_stacks(struct perf_session *session)
 
 volatile int session_done;
 
+static int __perf_session__process_decomp_events(struct perf_session *session);
+
 static int __perf_session__process_pipe_events(struct perf_session *session)
 {
 	struct ordered_events *oe = &session->ordered_events;
@@ -1753,6 +1770,10 @@ static int __perf_session__process_pipe_events(struct perf_session *session)
 	if (skip > 0)
 		head += skip;
 
+	err = __perf_session__process_decomp_events(session);
+	if (err)
+		goto out_err;
+
 	if (!session_done())
 		goto more;
 done:
@@ -1801,6 +1822,38 @@ fetch_mmaped_event(struct perf_session *session,
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
@@ -1904,6 +1957,10 @@ static int __perf_session__process_events(struct perf_session *session,
 	head += size;
 	file_pos += size;
 
+	err = __perf_session__process_decomp_events(session);
+	if (err)
+		goto out_err;
+
 	ui_progress__update(&prog, size);
 
 	if (session_done())
diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
index d96eccd7d27f..8ecda50efc6b 100644
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
@@ -35,6 +38,19 @@ struct perf_session {
 	struct ordered_events	ordered_events;
 	struct perf_data	*data;
 	struct perf_tool	*tool;
+	struct decomp		*decomp;
+	struct decomp		*decomp_last;
+#ifdef HAVE_ZSTD_SUPPORT
+	ZSTD_DStream		*zstd_dstream;
+#endif
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
index 56e4ca54020a..65ec84dfc5eb 100644
--- a/tools/perf/util/tool.h
+++ b/tools/perf/util/tool.h
@@ -28,6 +28,7 @@ typedef int (*event_attr_op)(struct perf_tool *tool,
 
 typedef int (*event_op2)(struct perf_session *session, union perf_event *event);
 typedef s64 (*event_op3)(struct perf_session *session, union perf_event *event);
+typedef int (*event_op4)(struct perf_session *session, union perf_event *event, u64 data);
 
 typedef int (*event_oe)(struct perf_tool *tool, union perf_event *event,
 			struct ordered_events *oe);
@@ -69,6 +70,7 @@ struct perf_tool {
 			stat,
 			stat_round,
 			feature;
+	event_op4	compressed;
 	event_op3	auxtrace;
 	bool		ordered_events;
 	bool		ordering_requires_timestamps;
