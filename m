Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF1CC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 16:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7EDB21470
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 16:17:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7EDB21470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbeJCXGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 19:06:09 -0400
Received: from mga02.intel.com ([134.134.136.20]:8279 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726819AbeJCXGJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 19:06:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Oct 2018 09:17:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,336,1534834800"; 
   d="scan'208";a="79578371"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 03 Oct 2018 09:17:05 -0700
Received: from [10.252.30.119] (abudanko-mobl.ccr.corp.intel.com [10.252.30.119])
        by linux.intel.com (Postfix) with ESMTP id 594415801E6;
        Wed,  3 Oct 2018 09:17:02 -0700 (PDT)
Subject: [PATCH v9 3/3]: perf record: extend trace writing to multi AIO
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <ded47c34-9e92-6bd2-9522-a927a7237011@linux.intel.com>
Organization: Intel Corp.
Message-ID: <6cf496d7-60b6-2ba3-7c40-26caeec81837@linux.intel.com>
Date:   Wed, 3 Oct 2018 19:17:01 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <ded47c34-9e92-6bd2-9522-a927a7237011@linux.intel.com>
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

With aio-cblocks option value different from 0, current default value, 
tool has capability to cache more and more data into user space
along with delegating spill to AIO.

That allows avoiding suspend at record__aio_sync() between calls of 
record__mmap_read_evlist() and increase profiling data thruput for 
the cost of userspace memory.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/builtin-record.c | 59 +++++++++++++++++++++++++++------
 tools/perf/util/evlist.c    |  7 ++--
 tools/perf/util/evlist.h    |  3 +-
 tools/perf/util/mmap.c      | 79 ++++++++++++++++++++++++++++++++-------------
 tools/perf/util/mmap.h      |  7 ++--
 5 files changed, 115 insertions(+), 40 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index c63fe8c021a2..7b67574be5b7 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -196,16 +196,35 @@ static int record__aio_complete(struct perf_mmap *md, struct aiocb *cblock)
 	return rc;
 }
 
-static void record__aio_sync(struct perf_mmap *md)
+static int record__aio_sync(struct perf_mmap *md, bool sync_all)
 {
-	struct aiocb *cblock = &md->cblock;
+	struct aiocb **aiocb = md->aiocb;
+	struct aiocb *cblocks = md->cblocks;
 	struct timespec timeout = { 0, 1000 * 1000  * 1 }; // 1ms
+	int i, do_suspend;
 
 	do {
-		if (cblock->aio_fildes == -1 || record__aio_complete(md, cblock))
-			return;
+		do_suspend = 0;
+		for (i = 0; i < md->nr_cblocks; ++i) {
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
+		while (aio_suspend((const struct aiocb **)aiocb, md->nr_cblocks, &timeout)) {
 			if (!(errno == EAGAIN || errno == EINTR))
 				pr_err("failed to sync perf data, error: %m\n");
 		}
@@ -436,11 +455,15 @@ static int record__mmap_evlist(struct record *rec,
 			       struct perf_evlist *evlist)
 {
 	struct record_opts *opts = &rec->opts;
+	int nr_cblocks = 0;
 	char msg[512];
-
+#ifdef HAVE_AIO_SUPPORT
+	nr_cblocks = opts->nr_cblocks;
+#endif
 	if (perf_evlist__mmap_ex(evlist, opts->mmap_pages,
 				 opts->auxtrace_mmap_pages,
-				 opts->auxtrace_snapshot_mode) < 0) {
+				 opts->auxtrace_snapshot_mode,
+				 nr_cblocks) < 0) {
 		if (errno == EPERM) {
 			pr_err("Permission error mapping pages.\n"
 			       "Consider increasing "
@@ -637,7 +660,7 @@ static void record__mmap_read_sync(struct record *rec __maybe_unused)
 	for (i = 0; i < evlist->nr_mmaps; i++) {
 		struct perf_mmap *map = &maps[i];
 		if (map->base)
-			record__aio_sync(map);
+			record__aio_sync(map, true);
 	}
 #endif
 }
@@ -676,12 +699,13 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
 					goto out;
 				}
 			} else {
+				int idx;
 				/*
 				 * Call record__aio_sync() to wait till map->data buffer
 				 * becomes available after previous aio write request.
 				 */
-				record__aio_sync(map);
-				if (perf_mmap__aio_push(map, rec, record__aio_pushfn) != 0) {
+				idx = record__aio_sync(map, false);
+				if (perf_mmap__aio_push(map, rec, idx, record__aio_pushfn) != 0) {
 					rc = -1;
 					goto out;
 				}
@@ -1442,6 +1466,10 @@ static int perf_record_config(const char *var, const char *value, void *cb)
 		var = "call-graph.record-mode";
 		return perf_default_config(var, value, cb);
 	}
+#ifdef HAVE_AIO_SUPPORT
+	if (!strcmp(var, "record.aio-cblocks"))
+		rec->opts.nr_cblocks = strtol(value, NULL, 0);
+#endif
 
 	return 0;
 }
@@ -1833,6 +1861,10 @@ static struct option __record_options[] = {
 			  "signal"),
 	OPT_BOOLEAN(0, "dry-run", &dry_run,
 		    "Parse options then exit"),
+#ifdef HAVE_AIO_SUPPORT
+	OPT_INTEGER(0, "aio-cblocks", &record.opts.nr_cblocks,
+		    "Max number of simultaneous per-mmap trace writes (default: 0 - serial, max: 4)"),
+#endif
 	OPT_END()
 };
 
@@ -2025,6 +2057,13 @@ int cmd_record(int argc, const char **argv)
 		goto out;
 	}
 
+#ifdef HAVE_AIO_SUPPORT
+	if (rec->opts.nr_cblocks > 4)
+		rec->opts.nr_cblocks = 4;
+	if (verbose > 0)
+		pr_info("nr_cblocks: %d\n", rec->opts.nr_cblocks);
+#endif
+
 	err = __cmd_record(&record, argc, argv);
 out:
 	perf_evlist__delete(rec->evlist);
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index af2f8c965d7a..4bb5dd5b58e9 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1018,7 +1018,8 @@ int perf_evlist__parse_mmap_pages(const struct option *opt, const char *str,
  */
 int perf_evlist__mmap_ex(struct perf_evlist *evlist, unsigned int pages,
 			 unsigned int auxtrace_pages,
-			 bool auxtrace_overwrite)
+			 bool auxtrace_overwrite,
+			 int nr_cblocks __maybe_unused)
 {
 	struct perf_evsel *evsel;
 	const struct cpu_map *cpus = evlist->cpus;
@@ -1030,7 +1031,7 @@ int perf_evlist__mmap_ex(struct perf_evlist *evlist, unsigned int pages,
 	 */
 	struct mmap_params mp;
 #ifdef HAVE_AIO_SUPPORT
-	mp.nr_cblocks = 0;
+	mp.nr_cblocks = nr_cblocks;
 #endif
 	if (!evlist->mmap)
 		evlist->mmap = perf_evlist__alloc_mmap(evlist, false);
@@ -1062,7 +1063,7 @@ int perf_evlist__mmap_ex(struct perf_evlist *evlist, unsigned int pages,
 
 int perf_evlist__mmap(struct perf_evlist *evlist, unsigned int pages)
 {
-	return perf_evlist__mmap_ex(evlist, pages, 0, false);
+	return perf_evlist__mmap_ex(evlist, pages, 0, false, 0);
 }
 
 int perf_evlist__create_maps(struct perf_evlist *evlist, struct target *target)
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index dc66436add98..a94d3c613254 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -162,7 +162,8 @@ unsigned long perf_event_mlock_kb_in_pages(void);
 
 int perf_evlist__mmap_ex(struct perf_evlist *evlist, unsigned int pages,
 			 unsigned int auxtrace_pages,
-			 bool auxtrace_overwrite);
+			 bool auxtrace_overwrite,
+			 int nr_cblocks);
 int perf_evlist__mmap(struct perf_evlist *evlist, unsigned int pages);
 void perf_evlist__munmap(struct perf_evlist *evlist);
 
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 0a13e217458d..860259547b83 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -156,8 +156,16 @@ void __weak auxtrace_mmap_params__set_idx(struct auxtrace_mmap_params *mp __mayb
 void perf_mmap__munmap(struct perf_mmap *map)
 {
 #ifdef HAVE_AIO_SUPPORT
-	if (map->data)
-		zfree(&map->data);
+	int i;
+
+	if (map->aiocb)
+		zfree(&map->aiocb);
+	if (map->cblocks)
+		zfree(&map->cblocks);
+	for (i = 0; i < map->nr_cblocks; ++i) {
+		if (map->data[i])
+			zfree(&map->data[i]);
+	}
 #endif
 	if (map->base != NULL) {
 		munmap(map->base, perf_mmap__mmap_len(map));
@@ -171,7 +179,7 @@ void perf_mmap__munmap(struct perf_mmap *map)
 int perf_mmap__mmap(struct perf_mmap *map, struct mmap_params *mp, int fd, int cpu)
 {
 #ifdef HAVE_AIO_SUPPORT
-	int delta_max;
+	int delta_max, i, prio;
 #endif
 	/*
 	 * The last one will be done at perf_mmap__consume(), so that we
@@ -200,25 +208,50 @@ int perf_mmap__mmap(struct perf_mmap *map, struct mmap_params *mp, int fd, int c
 #ifdef HAVE_AIO_SUPPORT
 	map->nr_cblocks = mp->nr_cblocks;
 	if (map->nr_cblocks) {
-		map->data = malloc(perf_mmap__mmap_len(map));
+		map->aiocb = calloc(map->nr_cblocks, sizeof(struct aiocb *));
+		if (!map->aiocb) {
+			pr_debug2("failed to allocate aiocb for data buffer, error %d\n",
+					errno);
+			return -1;
+		}
+		map->cblocks = calloc(map->nr_cblocks, sizeof(struct aiocb));
+		if (!map->cblocks) {
+			pr_debug2("failed to allocate cblocks for data buffer, error %d\n",
+					errno);
+			return -1;
+		}
+		map->data = calloc(map->nr_cblocks, sizeof(void *));
 		if (!map->data) {
 			pr_debug2("failed to allocate data buffer, error %d\n",
 					errno);
 			return -1;
 		}
-		/*
-		 * Use cblock.aio_fildes value different from -1
-		 * to denote started aio write operation on the
-		 * cblock so it requires explicit record__aio_sync()
-		 * call prior the cblock may be reused again.
-		 */
-		map->cblock.aio_fildes = -1;
-		/*
-		 * Allocate cblock with max priority delta to
-		 * have faster aio write system calls.
-		 */
 		delta_max = sysconf(_SC_AIO_PRIO_DELTA_MAX);
-		map->cblock.aio_reqprio = delta_max;
+		for (i = 0; i < map->nr_cblocks; ++i) {
+			map->data[i] = malloc(perf_mmap__mmap_len(map));
+			if (!map->data[i]) {
+				pr_debug2("failed to allocate data buffer area, error %d\n",
+						errno);
+				return -1;
+			}
+			/*
+			 * Use cblock.aio_fildes value different from -1
+			 * to denote started aio write operation on the
+			 * cblock so it requires explicit record__aio_sync()
+			 * call prior the cblock may be reused again.
+			 */
+			map->cblocks[i].aio_fildes = -1;
+			/*
+			 * Allocate cblocks with priority delta to have
+			 * faster aio write system calls because queued requests
+			 * are kept in separate per-prio queues and adding
+			 * a new request will iterate thru shorter per-prio
+			 * list. Blocks with numbers higher than
+			 *  _SC_AIO_PRIO_DELTA_MAX go with priority 0.
+			 */
+			prio = delta_max - i;
+			map->cblocks[i].aio_reqprio = prio >= 0 ? prio : 0;
+		}
 	}
 #endif
 	map->fd = fd;
@@ -353,7 +386,7 @@ int perf_mmap__push(struct perf_mmap *md, void *to,
 }
 
 #ifdef HAVE_AIO_SUPPORT
-int perf_mmap__aio_push(struct perf_mmap *md, void *to,
+int perf_mmap__aio_push(struct perf_mmap *md, void *to, int idx,
 			int push(void *to, struct aiocb *cblock, void *buf, size_t size))
 {
 	u64 head = perf_mmap__read_head(md);
@@ -367,7 +400,7 @@ int perf_mmap__aio_push(struct perf_mmap *md, void *to,
 		return (rc == -EAGAIN) ? 0 : -1;
 
 	/*
-	 * md->base data is copied into md->data buffer to
+	 * md->base data is copied into md->data[idx] buffer to
 	 * release space in the kernel buffer as fast as possible,
 	 * thru perf_mmap__consume() below.
 	 *
@@ -389,20 +422,20 @@ int perf_mmap__aio_push(struct perf_mmap *md, void *to,
 		buf = &data[md->start & md->mask];
 		size = md->mask + 1 - (md->start & md->mask);
 		md->start += size;
-		memcpy(md->data, buf, size);
+		memcpy(md->data[idx], buf, size);
 		size0 = size;
 	}
 
 	buf = &data[md->start & md->mask];
 	size = md->end - md->start;
 	md->start += size;
-	memcpy(md->data + size0, buf, size);
+	memcpy(md->data[idx] + size0, buf, size);
 
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
@@ -412,7 +445,7 @@ int perf_mmap__aio_push(struct perf_mmap *md, void *to,
 	md->prev = head;
 	perf_mmap__consume(md);
 
-	rc = push(to, &md->cblock, md->data, size0 + size);
+	rc = push(to, &md->cblocks[idx], md->data[idx], size0 + size);
 	if (rc) {
 		/*
 		 * Decrement md->refcount back if aio write
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index ac011777c38f..68050d48d767 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -30,8 +30,9 @@ struct perf_mmap {
 	struct auxtrace_mmap auxtrace_mmap;
 	char		 event_copy[PERF_SAMPLE_MAX_SIZE] __aligned(8);
 #ifdef HAVE_AIO_SUPPORT
-	void 		 *data;
-	struct aiocb	 cblock;
+	void		 **data;
+	struct aiocb	 *cblocks;
+	struct aiocb	 **aiocb;
 	int		 nr_cblocks;
 #endif
 };
@@ -106,7 +107,7 @@ union perf_event *perf_mmap__read_event(struct perf_mmap *map);
 int perf_mmap__push(struct perf_mmap *md, void *to,
 		    int push(struct perf_mmap *map, void *to, void *buf, size_t size));
 #ifdef HAVE_AIO_SUPPORT
-int perf_mmap__aio_push(struct perf_mmap *md, void *to,
+int perf_mmap__aio_push(struct perf_mmap *md, void *to, int idx,
 			int push(void *to, struct aiocb *cblock, void *buf, size_t size));
 #endif
 
