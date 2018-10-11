Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0476C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 18:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3AE220658
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 18:59:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3AE220658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729792AbeJLC1z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 22:27:55 -0400
Received: from mga01.intel.com ([192.55.52.88]:41631 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728239AbeJLC1z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 22:27:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Oct 2018 11:59:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,369,1534834800"; 
   d="scan'208";a="94420982"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 11 Oct 2018 11:59:22 -0700
Received: from [10.252.28.165] (abudanko-mobl.ccr.corp.intel.com [10.252.28.165])
        by linux.intel.com (Postfix) with ESMTP id 3ED19580496;
        Thu, 11 Oct 2018 11:59:20 -0700 (PDT)
Subject: [PATCH v13 3/3]: perf record: extend trace writing to multi AIO
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <36159e5e-57cc-9734-501f-1856f59b4913@linux.intel.com>
Organization: Intel Corp.
Message-ID: <6e4badbc-4c6d-b0f9-75fe-8f897d31b9f6@linux.intel.com>
Date:   Thu, 11 Oct 2018 21:59:19 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <36159e5e-57cc-9734-501f-1856f59b4913@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Multi AIO trace writing allows caching more kernel data into userspace 
memory postponing trace writing for the sake of overall profiling data 
thruput increase. It could be seen as kernel data buffer extension into
userspace memory.

With aio option value different from 0, default value is 1, 
tool has capability to cache more and more data into user space
along with delegating spill to AIO.

That allows avoiding suspend at record__aio_sync() between calls of 
record__mmap_read_evlist() and increase profiling data thruput for 
the cost of userspace memory.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
Changes in v13:
- preserved --aio option name avoiding complication
Changes in v12:
- extended --aio option to --aio-cblocks=<n>
Changes in v10:
- added description of aio-cblocks option into perf-record.txt
---
 tools/perf/Documentation/perf-record.txt |  4 +-
 tools/perf/builtin-record.c              | 63 +++++++++++++++++++++++--------
 tools/perf/util/mmap.c                   | 64 +++++++++++++++++++++-----------
 tools/perf/util/mmap.h                   |  9 +++--
 4 files changed, 98 insertions(+), 42 deletions(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 7efb4af88a68..d232b13ea713 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -435,8 +435,8 @@ Specify vmlinux path which has debuginfo.
 --buildid-all::
 Record build-id of all DSOs regardless whether it's actually hit or not.
 
---aio::
-Enable asynchronous (Posix AIO) trace writing mode.
+--aio[=n]::
+Use <n> control blocks in asynchronous (Posix AIO) trace writing mode (default: 1, max: 4).
 Asynchronous mode is supported only when linking Perf tool with libc library
 providing implementation for Posix AIO API.
 
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index cec56ded7532..b048ede546d4 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -196,16 +196,35 @@ static int record__aio_complete(struct perf_mmap *md, struct aiocb *cblock)
 	return rc;
 }
 
-static void record__aio_sync(struct perf_mmap *md)
+static int record__aio_sync(struct perf_mmap *md, bool sync_all)
 {
-	struct aiocb *cblock = &md->aio.cblock;
+	struct aiocb **aiocb = md->aio.aiocb;
+	struct aiocb *cblocks = md->aio.cblocks;
 	struct timespec timeout = { 0, 1000 * 1000  * 1 }; /* 1ms */
+	int i, do_suspend;
 
 	do {
-		if (cblock->aio_fildes == -1 || record__aio_complete(md, cblock))
-			return;
+		do_suspend = 0;
+		for (i = 0; i < md->aio.nr_cblocks; ++i) {
+			if (cblocks[i].aio_fildes == -1 || record__aio_complete(md, &cblocks[i])) {
+				if (sync_all)
+					aiocb[i] = NULL;
+				else
+					return i;
+			} else {
+				/*
+				 * Started aio write is not complete yet
+				 * so it has to be waited before the
+				 * next allocation.
+				 */
+				aiocb[i] = &cblocks[i];
+				do_suspend = 1;
+			}
+		}
+		if (!do_suspend)
+			return -1;
 
-		while (aio_suspend((const struct aiocb**)&cblock, 1, &timeout)) {
+		while (aio_suspend((const struct aiocb **)aiocb, md->aio.nr_cblocks, &timeout)) {
 			if (!(errno == EAGAIN || errno == EINTR))
 				pr_err("failed to sync perf data, error: %m\n");
 		}
@@ -252,26 +271,30 @@ static void record__aio_mmap_read_sync(struct record *rec)
 		struct perf_mmap *map = &maps[i];
 
 		if (map->base)
-			record__aio_sync(map);
+			record__aio_sync(map, true);
 	}
 }
 
 static int record__aio_parse(const struct option *opt,
-			     const char *str __maybe_unused,
+			     const char *str,
 			     int unset)
 {
 	struct record_opts *opts = (struct record_opts *)opt->value;
 
-	if (unset)
+	if (unset) {
 		opts->nr_cblocks = 0;
-	else
-		opts->nr_cblocks = 1;
+	} else {
+		opts->nr_cblocks = strtol(str, NULL, 0);
+		if (!opts->nr_cblocks)
+			opts->nr_cblocks = 1;
+	}
 
 	return 0;
 }
 #else /* HAVE_AIO_SUPPORT */
-static void record__aio_sync(struct perf_mmap *md __maybe_unused)
+static int record__aio_sync(struct perf_mmap *md __maybe_unused, bool sync_all __maybe_unused)
 {
+	return -1;
 }
 
 static int record__aio_pushfn(void *to __maybe_unused, struct aiocb *cblock __maybe_unused,
@@ -721,12 +744,13 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
 					goto out;
 				}
 			} else {
+				int idx;
 				/*
 				 * Call record__aio_sync() to wait till map->data buffer
 				 * becomes available after previous aio write request.
 				 */
-				record__aio_sync(map);
-				if (perf_mmap__aio_push(map, rec, record__aio_pushfn, &off) != 0) {
+				idx = record__aio_sync(map, false);
+				if (perf_mmap__aio_push(map, rec, idx, record__aio_pushfn, &off) != 0) {
 					record__aio_set_pos(trace_fd, off);
 					rc = -1;
 					goto out;
@@ -1490,6 +1514,13 @@ static int perf_record_config(const char *var, const char *value, void *cb)
 		var = "call-graph.record-mode";
 		return perf_default_config(var, value, cb);
 	}
+#ifdef HAVE_AIO_SUPPORT
+	if (!strcmp(var, "record.aio")) {
+		rec->opts.nr_cblocks = strtol(value, NULL, 0);
+		if (!rec->opts.nr_cblocks)
+			rec->opts.nr_cblocks = 1;
+	}
+#endif
 
 	return 0;
 }
@@ -1882,8 +1913,8 @@ static struct option __record_options[] = {
 	OPT_BOOLEAN(0, "dry-run", &dry_run,
 		    "Parse options then exit"),
 #ifdef HAVE_AIO_SUPPORT
-	OPT_CALLBACK_NOOPT(0, "aio", &record.opts,
-		     NULL, "Enable asynchronous trace writing mode",
+	OPT_CALLBACK(0, "aio", &record.opts,
+		     "n", "Use <n> control blocks in asynchronous trace writing mode (default: 1, max: 4)",
 		     record__aio_parse),
 #endif
 	OPT_END()
@@ -2078,6 +2109,8 @@ int cmd_record(int argc, const char **argv)
 		goto out;
 	}
 
+	if (rec->opts.nr_cblocks > 4)
+		rec->opts.nr_cblocks = 4;
 	if (verbose > 0)
 		pr_info("nr_cblocks: %d\n", rec->opts.nr_cblocks);
 
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 61aa381d05d0..ab30555d2afc 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -156,28 +156,50 @@ void __weak auxtrace_mmap_params__set_idx(struct auxtrace_mmap_params *mp __mayb
 #ifdef HAVE_AIO_SUPPORT
 static int perf_mmap__aio_mmap(struct perf_mmap *map, struct mmap_params *mp)
 {
-	int delta_max;
+	int delta_max, i, prio;
 
 	map->aio.nr_cblocks = mp->nr_cblocks;
 	if (map->aio.nr_cblocks) {
-		map->aio.data = malloc(perf_mmap__mmap_len(map));
+		map->aio.aiocb = calloc(map->aio.nr_cblocks, sizeof(struct aiocb *));
+		if (!map->aio.aiocb) {
+			pr_debug2("failed to allocate aiocb for data buffer, error %m\n");
+			return -1;
+		}
+		map->aio.cblocks = calloc(map->aio.nr_cblocks, sizeof(struct aiocb));
+		if (!map->aio.cblocks) {
+			pr_debug2("failed to allocate cblocks for data buffer, error %m\n");
+			return -1;
+		}
+		map->aio.data = calloc(map->aio.nr_cblocks, sizeof(void *));
 		if (!map->aio.data) {
 			pr_debug2("failed to allocate data buffer, error %m\n");
 			return -1;
 		}
-		/*
-		 * Use cblock.aio_fildes value different from -1
-		 * to denote started aio write operation on the
-		 * cblock so it requires explicit record__aio_sync()
-		 * call prior the cblock may be reused again.
-		 */
-		map->aio.cblock.aio_fildes = -1;
-		/*
-		 * Allocate cblock with max priority delta to
-		 * have faster aio write system calls.
-		 */
 		delta_max = sysconf(_SC_AIO_PRIO_DELTA_MAX);
-		map->aio.cblock.aio_reqprio = delta_max;
+		for (i = 0; i < map->aio.nr_cblocks; ++i) {
+			map->aio.data[i] = malloc(perf_mmap__mmap_len(map));
+			if (!map->aio.data[i]) {
+				pr_debug2("failed to allocate data buffer area, error %m");
+				return -1;
+			}
+			/*
+			 * Use cblock.aio_fildes value different from -1
+			 * to denote started aio write operation on the
+			 * cblock so it requires explicit record__aio_sync()
+			 * call prior the cblock may be reused again.
+			 */
+			map->aio.cblocks[i].aio_fildes = -1;
+			/*
+			 * Allocate cblocks with priority delta to have
+			 * faster aio write system calls because queued requests
+			 * are kept in separate per-prio queues and adding
+			 * a new request will iterate thru shorter per-prio
+			 * list. Blocks with numbers higher than
+			 *  _SC_AIO_PRIO_DELTA_MAX go with priority 0.
+			 */
+			prio = delta_max - i;
+			map->aio.cblocks[i].aio_reqprio = prio >= 0 ? prio : 0;
+		}
 	}
 
 	return 0;
@@ -189,7 +211,7 @@ static void perf_mmap__aio_munmap(struct perf_mmap *map)
 		zfree(&map->aio.data);
 }
 
-int perf_mmap__aio_push(struct perf_mmap *md, void *to,
+int perf_mmap__aio_push(struct perf_mmap *md, void *to, int idx,
 			int push(void *to, struct aiocb *cblock, void *buf, size_t size, off_t off),
 			off_t *off)
 {
@@ -204,7 +226,7 @@ int perf_mmap__aio_push(struct perf_mmap *md, void *to,
 		return (rc == -EAGAIN) ? 0 : -1;
 
 	/*
-	 * md->base data is copied into md->data buffer to
+	 * md->base data is copied into md->data[idx] buffer to
 	 * release space in the kernel buffer as fast as possible,
 	 * thru perf_mmap__consume() below.
 	 *
@@ -226,20 +248,20 @@ int perf_mmap__aio_push(struct perf_mmap *md, void *to,
 		buf = &data[md->start & md->mask];
 		size = md->mask + 1 - (md->start & md->mask);
 		md->start += size;
-		memcpy(md->aio.data, buf, size);
+		memcpy(md->aio.data[idx], buf, size);
 		size0 = size;
 	}
 
 	buf = &data[md->start & md->mask];
 	size = md->end - md->start;
 	md->start += size;
-	memcpy(md->aio.data + size0, buf, size);
+	memcpy(md->aio.data[idx] + size0, buf, size);
 
 	/*
-	 * Increment md->refcount to guard md->data buffer
+	 * Increment md->refcount to guard md->data[idx] buffer
 	 * from premature deallocation because md object can be
 	 * released earlier than aio write request started
-	 * on mmap->data is complete.
+	 * on mmap->data[idx] is complete.
 	 *
 	 * perf_mmap__put() is done at record__aio_complete()
 	 * after started request completion.
@@ -249,7 +271,7 @@ int perf_mmap__aio_push(struct perf_mmap *md, void *to,
 	md->prev = head;
 	perf_mmap__consume(md);
 
-	rc = push(to, &md->aio.cblock, md->aio.data, size0 + size, *off);
+	rc = push(to, &md->aio.cblocks[idx], md->aio.data[idx], size0 + size, *off);
 	if (!rc) {
 		*off += size0 + size;
 	} else {
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index 9be06f18f17a..cb63d357a248 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -32,8 +32,9 @@ struct perf_mmap {
 	char		 event_copy[PERF_SAMPLE_MAX_SIZE] __aligned(8);
 #ifdef HAVE_AIO_SUPPORT
 	struct {
-		void 		 *data;
-		struct aiocb	 cblock;
+		void		 **data;
+		struct aiocb	 *cblocks;
+		struct aiocb	 **aiocb;
 		int		 nr_cblocks;
 	} aio;
 #endif
@@ -106,11 +107,11 @@ union perf_event *perf_mmap__read_event(struct perf_mmap *map);
 int perf_mmap__push(struct perf_mmap *md, void *to,
 		    int push(struct perf_mmap *map, void *to, void *buf, size_t size));
 #ifdef HAVE_AIO_SUPPORT
-int perf_mmap__aio_push(struct perf_mmap *md, void *to,
+int perf_mmap__aio_push(struct perf_mmap *md, void *to, int idx,
 			int push(void *to, struct aiocb *cblock, void *buf, size_t size, off_t off),
 			off_t *off);
 #else
-static inline int perf_mmap__aio_push(struct perf_mmap *md __maybe_unused, void *to __maybe_unused,
+static inline int perf_mmap__aio_push(struct perf_mmap *md __maybe_unused, void *to __maybe_unused, int idx __maybe_unused,
 	int push(void *to, struct aiocb *cblock, void *buf, size_t size, off_t off) __maybe_unused,
 	off_t *off __maybe_unused)
 {
