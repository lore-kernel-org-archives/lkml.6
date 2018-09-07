Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ADD1C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 07:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 872D52077C
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 07:40:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 872D52077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbeIGMTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 08:19:38 -0400
Received: from mga05.intel.com ([192.55.52.43]:3095 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbeIGMTh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 08:19:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Sep 2018 00:39:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,341,1531810800"; 
   d="scan'208";a="89739816"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 07 Sep 2018 00:39:57 -0700
Received: from [10.125.252.7] (abudanko-mobl.ccr.corp.intel.com [10.125.252.7])
        by linux.intel.com (Postfix) with ESMTP id 3462D5802B3;
        Fri,  7 Sep 2018 00:39:55 -0700 (PDT)
Subject: [PATCH v8 3/3]: perf record: extend trace writing to multi AIO
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <e1144f9d-b231-e42c-d698-4db0e62b71ff@linux.intel.com>
Organization: Intel Corp.
Message-ID: <8f9af1f4-30f4-00f0-78e2-677882223aa2@linux.intel.com>
Date:   Fri, 7 Sep 2018 10:39:55 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <e1144f9d-b231-e42c-d698-4db0e62b71ff@linux.intel.com>
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

With aio-cblocks option value different from 1, current default value, 
tool has capability to cache more and more data into user space
along with delegating spill to AIO.

That allows avoiding suspend at record__aio_sync() between calls of 
record__mmap_read_evlist() and increase profiling data thruput for 
the cost of userspace memory.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/builtin-record.c | 55 +++++++++++++++++++++++-------
 tools/perf/perf.h           |  1 +
 tools/perf/util/evlist.c    |  7 ++--
 tools/perf/util/evlist.h    |  3 +-
 tools/perf/util/mmap.c      | 83 +++++++++++++++++++++++++++++++--------------
 tools/perf/util/mmap.h      | 10 +++---
 6 files changed, 114 insertions(+), 45 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index d4857572cf33..6361098a5898 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -192,16 +192,35 @@ static int record__aio_complete(struct perf_mmap *md, struct aiocb *cblock)
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
@@ -428,7 +447,8 @@ static int record__mmap_evlist(struct record *rec,
 
 	if (perf_evlist__mmap_ex(evlist, opts->mmap_pages,
 				 opts->auxtrace_mmap_pages,
-				 opts->auxtrace_snapshot_mode) < 0) {
+				 opts->auxtrace_snapshot_mode,
+				 opts->nr_cblocks) < 0) {
 		if (errno == EPERM) {
 			pr_err("Permission error mapping pages.\n"
 			       "Consider increasing "
@@ -621,7 +641,7 @@ static void record__mmap_read_sync(struct record *rec)
 	for (i = 0; i < evlist->nr_mmaps; i++) {
 		struct perf_mmap *map = &maps[i];
 		if (map->base)
-			record__aio_sync(map);
+			record__aio_sync(map, true);
 	}
 }
 
@@ -629,7 +649,7 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
 				    bool overwrite)
 {
 	u64 bytes_written = rec->bytes_written;
-	int i;
+	int i, idx;
 	int rc = 0;
 	struct perf_mmap *maps;
 
@@ -648,11 +668,12 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
 
 		if (maps[i].base) {
 			/*
-			 * Call record__aio_sync() to wait till map->data buffer
-			 * becomes available after previous aio write request.
+			 * Call record__aio_sync() to get some free map->data
+			 * buffer or wait if all of previously started aio
+			 * writes are still incomplete.
 			 */
-			record__aio_sync(&maps[i]);
-			if (perf_mmap__push(&maps[i], rec, record__pushfn) != 0) {
+			idx = record__aio_sync(&maps[i], false);
+			if (perf_mmap__push(&maps[i], rec, idx, record__pushfn) != 0) {
 				rc = -1;
 				goto out;
 			}
@@ -1411,6 +1432,8 @@ static int perf_record_config(const char *var, const char *value, void *cb)
 		var = "call-graph.record-mode";
 		return perf_default_config(var, value, cb);
 	}
+	if (!strcmp(var, "record.aio-cblocks"))
+		rec->opts.nr_cblocks = strtol(value, NULL, 0);
 
 	return 0;
 }
@@ -1643,6 +1666,7 @@ static struct record record = {
 			.default_per_cpu = true,
 		},
 		.proc_map_timeout     = 500,
+		.nr_cblocks	      = 1
 	},
 	.tool = {
 		.sample		= process_sample_event,
@@ -1802,6 +1826,8 @@ static struct option __record_options[] = {
 			  "signal"),
 	OPT_BOOLEAN(0, "dry-run", &dry_run,
 		    "Parse options then exit"),
+	OPT_INTEGER(0, "aio-cblocks", &record.opts.nr_cblocks,
+		    "Max number of simultaneous per-mmap AIO trace writes (min: 1, max: 4, default: 1)"),
 	OPT_END()
 };
 
@@ -1994,6 +2020,11 @@ int cmd_record(int argc, const char **argv)
 		goto out;
 	}
 
+	if (!(rec->opts.nr_cblocks >= 1 && rec->opts.nr_cblocks <= 4))
+		rec->opts.nr_cblocks = 1;
+	if (verbose > 0)
+		pr_info("AIO trace writes: %d\n", rec->opts.nr_cblocks);
+
 	err = __cmd_record(&record, argc, argv);
 out:
 	perf_evlist__delete(rec->evlist);
diff --git a/tools/perf/perf.h b/tools/perf/perf.h
index 21bf7f5a3cf5..0a1ae2ae567a 100644
--- a/tools/perf/perf.h
+++ b/tools/perf/perf.h
@@ -82,6 +82,7 @@ struct record_opts {
 	bool         use_clockid;
 	clockid_t    clockid;
 	unsigned int proc_map_timeout;
+	int	     nr_cblocks;
 };
 
 struct option;
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index e7a4b31a84fb..4be49dc67c0d 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1018,7 +1018,8 @@ int perf_evlist__parse_mmap_pages(const struct option *opt, const char *str,
  */
 int perf_evlist__mmap_ex(struct perf_evlist *evlist, unsigned int pages,
 			 unsigned int auxtrace_pages,
-			 bool auxtrace_overwrite)
+			 bool auxtrace_overwrite,
+			 int nr_cblocks)
 {
 	struct perf_evsel *evsel;
 	const struct cpu_map *cpus = evlist->cpus;
@@ -1028,7 +1029,7 @@ int perf_evlist__mmap_ex(struct perf_evlist *evlist, unsigned int pages,
 	 * Its value is decided by evsel's write_backward.
 	 * So &mp should not be passed through const pointer.
 	 */
-	struct mmap_params mp;
+	struct mmap_params mp = { .nr_cblocks = nr_cblocks };
 
 	if (!evlist->mmap)
 		evlist->mmap = perf_evlist__alloc_mmap(evlist, false);
@@ -1060,7 +1061,7 @@ int perf_evlist__mmap_ex(struct perf_evlist *evlist, unsigned int pages,
 
 int perf_evlist__mmap(struct perf_evlist *evlist, unsigned int pages)
 {
-	return perf_evlist__mmap_ex(evlist, pages, 0, false);
+	return perf_evlist__mmap_ex(evlist, pages, 0, false, 1);
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
index 71c5628df3db..1da3abb63028 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -155,6 +155,16 @@ void __weak auxtrace_mmap_params__set_idx(struct auxtrace_mmap_params *mp __mayb
 
 void perf_mmap__munmap(struct perf_mmap *map)
 {
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
 	if (map->data)
 		zfree(&map->data);
 	if (map->base != NULL) {
@@ -168,7 +178,7 @@ void perf_mmap__munmap(struct perf_mmap *map)
 
 int perf_mmap__mmap(struct perf_mmap *map, struct mmap_params *mp, int fd)
 {
-	int delta_max;
+	int delta_max, i, prio;
 	/*
 	 * The last one will be done at perf_mmap__consume(), so that we
 	 * make sure we don't prevent tools from consuming every last event in
@@ -193,28 +203,51 @@ int perf_mmap__mmap(struct perf_mmap *map, struct mmap_params *mp, int fd)
 		map->base = NULL;
 		return -1;
 	}
-	delta_max = sysconf(_SC_AIO_PRIO_DELTA_MAX);
-	map->data = malloc(perf_mmap__mmap_len(map));
+	map->nr_cblocks = mp->nr_cblocks;
+	map->aiocb = calloc(map->nr_cblocks, sizeof(struct aiocb *));
+	if (!map->aiocb) {
+		pr_debug2("failed to allocate aiocb for data buffers, error %d\n",
+				errno);
+		return -1;
+	}
+	map->cblocks = calloc(map->nr_cblocks, sizeof(struct aiocb));
+	if (!map->cblocks) {
+		pr_debug2("failed to allocate cblocks for data buffers, error %d\n",
+				errno);
+		return -1;
+	}
+	map->data = calloc(map->nr_cblocks, sizeof(void *));
 	if (!map->data) {
 		pr_debug2("failed to allocate data buffer, error %d\n",
 				errno);
 		return -1;
 	}
-	/*
-	 * Use cblock.aio_fildes value different from -1
-	 * to denote started aio write operation on the
-	 * cblock so it requires explicit record__aio_sync()
-	 * call prior the cblock may be reused again.
-	 */
-	map->cblock.aio_fildes = -1;
-	/*
-	 * Allocate cblock with max priority delta to
-	 * have faster aio_write() calls because queued
-	 * requests are kept in separate per-prio queues
-	 * and adding a new request iterates thru shorter
-	 * per-prio list.
-	 */
-	map->cblock.aio_reqprio = delta_max;
+	delta_max = sysconf(_SC_AIO_PRIO_DELTA_MAX);
+	for (i = 0; i < map->nr_cblocks; ++i) {
+		map->data[i] = malloc(perf_mmap__mmap_len(map));
+		if (!map->data[i]) {
+			pr_debug2("failed to allocate buffer area, error %d\n",
+					errno);
+			return -1;
+		}
+		/*
+		 * Use cblock.aio_fildes value different from -1
+		 * to denote started aio write operation on the
+		 * cblock so it requires explicit record__aio_sync()
+		 * call prior the cblock may be reused again.
+		 */
+		map->cblocks[i].aio_fildes = -1;
+		/*
+		 * Allocate cblocks with priority delta to
+		 * have faster aio_write() calls because queued
+		 * requests are kept in separate per-prio queues
+		 * and adding a new request iterates thru shorter
+		 * per-prio list. Blocks with numbers higher than
+		 * _SC_AIO_PRIO_DELTA_MAX go with priority 0.
+		 */
+		prio = delta_max - i;
+		map->cblocks[i].aio_reqprio = prio >= 0 ? prio : 0;
+	}
 	map->fd = fd;
 
 	if (auxtrace_mmap__mmap(&map->auxtrace_mmap,
@@ -304,7 +337,7 @@ int perf_mmap__read_init(struct perf_mmap *map)
 	return __perf_mmap__read_init(map);
 }
 
-int perf_mmap__push(struct perf_mmap *md, void *to,
+int perf_mmap__push(struct perf_mmap *md, void *to, int idx,
 		    int push(void *to, struct aiocb *cblock, void *data, size_t size))
 {
 	u64 head = perf_mmap__read_head(md);
@@ -318,7 +351,7 @@ int perf_mmap__push(struct perf_mmap *md, void *to,
 		return (rc == -EAGAIN) ? 0 : -1;
 
 	/*
-	 * md->base data is copied into md->data buffer to
+	 * md->base data is copied into md->data[idx] buffer to
 	 * release space in the kernel buffer as fast as possible,
 	 * thru perf_mmap__consume() below.
 	 *
@@ -340,20 +373,20 @@ int perf_mmap__push(struct perf_mmap *md, void *to,
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
@@ -363,7 +396,7 @@ int perf_mmap__push(struct perf_mmap *md, void *to,
 	md->prev = head;
 	perf_mmap__consume(md);
 
-	rc = push(to, &md->cblock, md->data, size0 + size);
+	rc = push(to, &md->cblocks[idx], md->data[idx], size0 + size);
 	if (rc) {
 		/*
 		 * Decrement md->refcount back if aio write
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index a9795a5fe200..04b9ea59b4b6 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -26,8 +26,10 @@ struct perf_mmap {
 	bool		 overwrite;
 	struct auxtrace_mmap auxtrace_mmap;
 	char		 event_copy[PERF_SAMPLE_MAX_SIZE] __aligned(8);
-	void 		 *data;
-	struct aiocb	 cblock;
+	void		 **data;
+	struct aiocb	 *cblocks;
+	struct aiocb	 **aiocb;
+	int		 nr_cblocks;
 };
 
 /*
@@ -59,7 +61,7 @@ enum bkw_mmap_state {
 };
 
 struct mmap_params {
-	int			    prot, mask;
+	int			    prot, mask, nr_cblocks;
 	struct auxtrace_mmap_params auxtrace_mp;
 };
 
@@ -94,7 +96,7 @@ union perf_event *perf_mmap__read_forward(struct perf_mmap *map);
 
 union perf_event *perf_mmap__read_event(struct perf_mmap *map);
 
-int perf_mmap__push(struct perf_mmap *md, void *to,
+int perf_mmap__push(struct perf_mmap *md, void *to, int idx,
 		    int push(void *to, struct aiocb *cblock, void *data, size_t size));
 
 size_t perf_mmap__mmap_len(struct perf_mmap *map);
