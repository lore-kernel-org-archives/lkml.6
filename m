Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B37FC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 09:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D01B320861
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 09:34:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D01B320861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbeIGOOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 10:14:37 -0400
Received: from mga05.intel.com ([192.55.52.43]:14989 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728367AbeIGOOh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 10:14:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Sep 2018 02:34:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,341,1531810800"; 
   d="scan'208";a="261518946"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 07 Sep 2018 02:34:31 -0700
Received: from [10.125.252.7] (abudanko-mobl.ccr.corp.intel.com [10.125.252.7])
        by linux.intel.com (Postfix) with ESMTP id 5D9305802B3;
        Fri,  7 Sep 2018 02:34:29 -0700 (PDT)
Subject: Re: [PATCH v8 0/3]: perf: reduce data loss when profiling highly
 parallel CPU bound workloads
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
Message-ID: <3110ced1-8573-0899-d49c-f0cb780e77a6@linux.intel.com>
Date:   Fri, 7 Sep 2018 12:34:28 +0300
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



On 07.09.2018 10:07, Alexey Budankov wrote:
> 
> Currently in record mode the tool implements trace writing serially. 
> The algorithm loops over mapped per-cpu data buffers and stores 
> ready data chunks into a trace file using write() system call.
> 
> At some circumstances the kernel may lack free space in a buffer 
> because the other buffer's half is not yet written to disk due to 
> some other buffer's data writing by the tool at the moment.
> 
> Thus serial trace writing implementation may cause the kernel 
> to loose profiling data and that is what observed when profiling 
> highly parallel CPU bound workloads on machines with big number 
> of cores.
> 
> Experiment with profiling matrix multiplication code executing 128 
> threads on Intel Xeon Phi (KNM) with 272 cores, like below,
> demonstrates data loss metrics value of 98%:
> 
> /usr/bin/time perf record -o /tmp/perf-ser.data -a -N -B -T -R -g \
>     --call-graph dwarf,1024 --user-regs=IP,SP,BP \
>     --switch-events -e cycles,instructions,ref-cycles,software/period=1,name=cs,config=0x3/Duk -- \
>     matrix.gcc
> 
> Data loss metrics is the ratio lost_time/elapsed_time where 
> lost_time is the sum of time intervals containing PERF_RECORD_LOST 
> records and elapsed_time is the elapsed application run time 
> under profiling.
> 
> Applying asynchronous trace streaming thru Posix AIO API
> (http://man7.org/linux/man-pages/man7/aio.7.html) 
> lowers data loss metrics value providing 2x improvement -
> lowering 98% loss to almost 0%.
> 
> ---
>  Alexey Budankov (3):
>         perf util: map data buffer for preserving collected data
> 	  perf record: enable asynchronous trace writing
>         perf record: extend trace writing to multi AIO
>  
>  tools/perf/builtin-record.c | 166 ++++++++++++++++++++++++++++++++++++++++++--
>  tools/perf/perf.h           |   1 +
>  tools/perf/util/evlist.c    |   7 +-
>  tools/perf/util/evlist.h    |   3 +-
>  tools/perf/util/mmap.c      | 114 ++++++++++++++++++++++++++----
>  tools/perf/util/mmap.h      |  11 ++-
>  6 files changed, 277 insertions(+), 25 deletions(-)

The whole thing for 

	git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux perf/core 

repository follows:

 tools/perf/builtin-record.c | 165 ++++++++++++++++++++++++++++++++++++++++++--
 tools/perf/perf.h           |   1 +
 tools/perf/util/evlist.c    |   7 +-
 tools/perf/util/evlist.h    |   3 +-
 tools/perf/util/mmap.c      | 114 ++++++++++++++++++++++++++----
 tools/perf/util/mmap.h      |  11 ++-
 6 files changed, 276 insertions(+), 25 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 9853552bcf16..7bb7947072e5 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -121,6 +121,112 @@ static int record__write(struct record *rec, void *bf, size_t size)
 	return 0;
 }
 
+static int record__aio_write(struct aiocb *cblock, int trace_fd,
+		void *buf, size_t size, off_t off)
+{
+	int rc;
+
+	cblock->aio_fildes = trace_fd;
+	cblock->aio_buf    = buf;
+	cblock->aio_nbytes = size;
+	cblock->aio_offset = off;
+	cblock->aio_sigevent.sigev_notify = SIGEV_NONE;
+
+	do {
+		rc = aio_write(cblock);
+		if (rc == 0) {
+			break;
+		} else if (errno != EAGAIN) {
+			cblock->aio_fildes = -1;
+			pr_err("failed to queue perf data, error: %m\n");
+			break;
+		}
+	} while (1);
+
+	return rc;
+}
+
+static int record__aio_complete(struct perf_mmap *md, struct aiocb *cblock)
+{
+	void *rem_buf;
+	off_t rem_off;
+	size_t rem_size;
+	int rc, aio_errno;
+	ssize_t aio_ret, written;
+
+	aio_errno = aio_error(cblock);
+	if (aio_errno == EINPROGRESS)
+		return 0;
+
+	written = aio_ret = aio_return(cblock);
+	if (aio_ret < 0) {
+		if (!(aio_errno == EINTR))
+			pr_err("failed to write perf data, error: %m\n");
+		written = 0;
+	}
+
+	rem_size = cblock->aio_nbytes - written;
+
+	if (rem_size == 0) {
+		cblock->aio_fildes = -1;
+		/*
+		 * md->refcount is incremented in perf_mmap__push() for
+		 * every enqueued aio write request so decrement it because
+		 * the request is now complete.
+		 */
+		perf_mmap__put(md);
+		rc = 1;
+	} else {
+		/*
+		 * aio write request may require restart with the
+		 * reminder if the kernel didn't write whole
+		 * chunk at once.
+		 */
+		rem_off = cblock->aio_offset + written;
+		rem_buf = (void *)(cblock->aio_buf + written);
+		record__aio_write(cblock, cblock->aio_fildes,
+				rem_buf, rem_size, rem_off);
+		rc = 0;
+	}
+
+	return rc;
+}
+
+static int record__aio_sync(struct perf_mmap *md, bool sync_all)
+{
+	struct aiocb **aiocb = md->aiocb;
+	struct aiocb *cblocks = md->cblocks;
+	struct timespec timeout = { 0, 1000 * 1000  * 1 }; // 1ms
+	int i, do_suspend;
+
+	do {
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
+
+		while (aio_suspend((const struct aiocb **)aiocb, md->nr_cblocks, &timeout)) {
+			if (!(errno == EAGAIN || errno == EINTR))
+				pr_err("failed to sync perf data, error: %m\n");
+		}
+	} while (1);
+}
+
 static int process_synthesized_event(struct perf_tool *tool,
 				     union perf_event *event,
 				     struct perf_sample *sample __maybe_unused,
@@ -130,12 +236,27 @@ static int process_synthesized_event(struct perf_tool *tool,
 	return record__write(rec, event, event->header.size);
 }
 
-static int record__pushfn(void *to, void *bf, size_t size)
+static int record__pushfn(void *to, struct aiocb *cblock, void *data, size_t size)
 {
+	off_t off;
 	struct record *rec = to;
+	int ret, trace_fd = rec->session->data->file.fd;
 
 	rec->samples++;
-	return record__write(rec, bf, size);
+
+	off = lseek(trace_fd, 0, SEEK_CUR);
+	lseek(trace_fd, off + size, SEEK_SET);
+	ret = record__aio_write(cblock, trace_fd, data, size, off);
+	if (!ret) {
+		rec->bytes_written += size;
+
+		if (switch_output_size(rec))
+			trigger_hit(&switch_output_trigger);
+	} else {
+		lseek(trace_fd, off, SEEK_SET);
+	}
+
+	return ret;
 }
 
 static volatile int done;
@@ -326,7 +447,8 @@ static int record__mmap_evlist(struct record *rec,
 
 	if (perf_evlist__mmap_ex(evlist, opts->mmap_pages,
 				 opts->auxtrace_mmap_pages,
-				 opts->auxtrace_snapshot_mode) < 0) {
+				 opts->auxtrace_snapshot_mode,
+				 opts->nr_cblocks) < 0) {
 		if (errno == EPERM) {
 			pr_err("Permission error mapping pages.\n"
 			       "Consider increasing "
@@ -510,11 +632,24 @@ static struct perf_event_header finished_round_event = {
 	.type = PERF_RECORD_FINISHED_ROUND,
 };
 
+static void record__mmap_read_sync(struct record *rec)
+{
+	int i;
+	struct perf_evlist *evlist = rec->evlist;
+	struct perf_mmap *maps = evlist->mmap;
+
+	for (i = 0; i < evlist->nr_mmaps; i++) {
+		struct perf_mmap *map = &maps[i];
+		if (map->base)
+			record__aio_sync(map, true);
+	}
+}
+
 static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evlist,
 				    bool overwrite)
 {
 	u64 bytes_written = rec->bytes_written;
-	int i;
+	int i, idx;
 	int rc = 0;
 	struct perf_mmap *maps;
 
@@ -532,7 +667,13 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
 		struct auxtrace_mmap *mm = &maps[i].auxtrace_mmap;
 
 		if (maps[i].base) {
-			if (perf_mmap__push(&maps[i], rec, record__pushfn) != 0) {
+			/*
+			 * Call record__aio_sync() to get some free map->data
+			 * buffer or wait if all of previously started aio
+			 * writes are still incomplete.
+			 */
+			idx = record__aio_sync(&maps[i], false);
+			if (perf_mmap__push(&maps[i], rec, idx, record__pushfn) != 0) {
 				rc = -1;
 				goto out;
 			}
@@ -1054,6 +1195,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 			perf_evlist__toggle_bkw_mmap(rec->evlist, BKW_MMAP_DATA_PENDING);
 
 		if (record__mmap_read_all(rec) < 0) {
+			record__mmap_read_sync(rec);
 			trigger_error(&auxtrace_snapshot_trigger);
 			trigger_error(&switch_output_trigger);
 			err = -1;
@@ -1065,6 +1207,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 			if (!trigger_is_error(&auxtrace_snapshot_trigger))
 				record__read_auxtrace_snapshot(rec);
 			if (trigger_is_error(&auxtrace_snapshot_trigger)) {
+				record__mmap_read_sync(rec);
 				pr_err("AUX area tracing snapshot failed\n");
 				err = -1;
 				goto out_child;
@@ -1083,6 +1226,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 			 */
 			if (rec->evlist->bkw_mmap_state == BKW_MMAP_RUNNING)
 				continue;
+			record__mmap_read_sync(rec);
 			trigger_ready(&switch_output_trigger);
 
 			/*
@@ -1136,6 +1280,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 			disabled = true;
 		}
 	}
+	record__mmap_read_sync(rec);
 	trigger_off(&auxtrace_snapshot_trigger);
 	trigger_off(&switch_output_trigger);
 
@@ -1287,6 +1432,8 @@ static int perf_record_config(const char *var, const char *value, void *cb)
 		var = "call-graph.record-mode";
 		return perf_default_config(var, value, cb);
 	}
+	if (!strcmp(var, "record.aio-cblocks"))
+		rec->opts.nr_cblocks = strtol(value, NULL, 0);
 
 	return 0;
 }
@@ -1519,6 +1666,7 @@ static struct record record = {
 			.default_per_cpu = true,
 		},
 		.proc_map_timeout     = 500,
+		.nr_cblocks	      = 1
 	},
 	.tool = {
 		.sample		= process_sample_event,
@@ -1678,6 +1826,8 @@ static struct option __record_options[] = {
 			  "signal"),
 	OPT_BOOLEAN(0, "dry-run", &dry_run,
 		    "Parse options then exit"),
+	OPT_INTEGER(0, "aio-cblocks", &record.opts.nr_cblocks,
+		    "Max number of simultaneous per-mmap AIO trace writes (min: 1, max: 4, default: 1)"),
 	OPT_END()
 };
 
@@ -1870,6 +2020,11 @@ int cmd_record(int argc, const char **argv)
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
index be440df29615..cc1381fb4ab3 100644
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
index 215f69f41672..46e541cfa3b3 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -155,6 +155,18 @@ void __weak auxtrace_mmap_params__set_idx(struct auxtrace_mmap_params *mp __mayb
 
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
+	if (map->data)
+		zfree(&map->data);
 	if (map->base != NULL) {
 		munmap(map->base, perf_mmap__mmap_len(map));
 		map->base = NULL;
@@ -166,6 +178,7 @@ void perf_mmap__munmap(struct perf_mmap *map)
 
 int perf_mmap__mmap(struct perf_mmap *map, struct mmap_params *mp, int fd, int cpu)
 {
+	int delta_max, i, prio;
 	/*
 	 * The last one will be done at perf_mmap__consume(), so that we
 	 * make sure we don't prevent tools from consuming every last event in
@@ -190,6 +203,51 @@ int perf_mmap__mmap(struct perf_mmap *map, struct mmap_params *mp, int fd, int c
 		map->base = NULL;
 		return -1;
 	}
+	map->nr_cblocks = mp->nr_cblocks;
+	map->aiocb = calloc(map->nr_cblocks, sizeof(struct aiocb *));
+	if (!map->aiocb) {
+		pr_debug2("failed to allocate aiocb for data buffer, error %d\n",
+				errno);
+		return -1;
+	}
+	map->cblocks = calloc(map->nr_cblocks, sizeof(struct aiocb));
+	if (!map->cblocks) {
+		pr_debug2("failed to allocate cblocks for data buffer, error %d\n",
+				errno);
+		return -1;
+	}
+	map->data = calloc(map->nr_cblocks, sizeof(void *));
+	if (!map->data) {
+		pr_debug2("failed to allocate data buffer, error %d\n",
+				errno);
+		return -1;
+	}
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
 	map->cpu = cpu;
 
@@ -280,12 +338,12 @@ int perf_mmap__read_init(struct perf_mmap *map)
 	return __perf_mmap__read_init(map);
 }
 
-int perf_mmap__push(struct perf_mmap *md, void *to,
-		    int push(void *to, void *buf, size_t size))
+int perf_mmap__push(struct perf_mmap *md, void *to, int idx,
+		    int push(void *to, struct aiocb *cblock, void *data, size_t size))
 {
 	u64 head = perf_mmap__read_head(md);
 	unsigned char *data = md->base + page_size;
-	unsigned long size;
+	unsigned long size, size0 = 0;
 	void *buf;
 	int rc = 0;
 
@@ -293,31 +351,61 @@ int perf_mmap__push(struct perf_mmap *md, void *to,
 	if (rc < 0)
 		return (rc == -EAGAIN) ? 0 : -1;
 
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
 	size = md->end - md->start;
 
 	if ((md->start & md->mask) + size != (md->end & md->mask)) {
 		buf = &data[md->start & md->mask];
 		size = md->mask + 1 - (md->start & md->mask);
 		md->start += size;
-
-		if (push(to, buf, size) < 0) {
-			rc = -1;
-			goto out;
-		}
+		memcpy(md->data[idx], buf, size);
+		size0 = size;
 	}
 
 	buf = &data[md->start & md->mask];
 	size = md->end - md->start;
 	md->start += size;
+	memcpy(md->data[idx] + size0, buf, size);
 
-	if (push(to, buf, size) < 0) {
-		rc = -1;
-		goto out;
-	}
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
 
 	md->prev = head;
 	perf_mmap__consume(md);
-out:
+
+	rc = push(to, &md->cblocks[idx], md->data[idx], size0 + size);
+	if (rc) {
+		/*
+		 * Decrement md->refcount back if aio write
+		 * operation failed to start.
+		 */
+		perf_mmap__put(md);
+	}
+
 	return rc;
 }
 
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index 05a6d47c7956..d279c7429b3f 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -6,6 +6,7 @@
 #include <linux/types.h>
 #include <asm/barrier.h>
 #include <stdbool.h>
+#include <aio.h>
 #include "auxtrace.h"
 #include "event.h"
 
@@ -26,6 +27,10 @@ struct perf_mmap {
 	bool		 overwrite;
 	struct auxtrace_mmap auxtrace_mmap;
 	char		 event_copy[PERF_SAMPLE_MAX_SIZE] __aligned(8);
+	void		 **data;
+	struct aiocb	 *cblocks;
+	struct aiocb	 **aiocb;
+	int		 nr_cblocks;
 };
 
 /*
@@ -57,7 +62,7 @@ enum bkw_mmap_state {
 };
 
 struct mmap_params {
-	int			    prot, mask;
+	int			    prot, mask, nr_cblocks;
 	struct auxtrace_mmap_params auxtrace_mp;
 };
 
@@ -92,8 +97,8 @@ union perf_event *perf_mmap__read_forward(struct perf_mmap *map);
 
 union perf_event *perf_mmap__read_event(struct perf_mmap *map);
 
-int perf_mmap__push(struct perf_mmap *md, void *to,
-		    int push(void *to, void *buf, size_t size));
+int perf_mmap__push(struct perf_mmap *md, void *to, int idx,
+		    int push(void *to, struct aiocb *cblock, void *data, size_t size));
 
 size_t perf_mmap__mmap_len(struct perf_mmap *map);

> 
> ---
>  Changes in v8:
>  - run the whole thing thru checkpatch.pl and corrected found issues except
>    lines longer than 80 symbols
>  - corrected comments alignment and formatting
>  - moved multi AIO implementation into 3rd patch in the series
>  - implemented explicit cblocks array allocation
>  - split AIO completion check into separate record__aio_complete()
>  - set nr_cblocks default to 1 and max allowed value to 4
>  Changes in v7:
>  - implemented handling record.aio setting from perfconfig file
>  Changes in v6:
>  - adjusted setting of priorities for cblocks;
>  - handled errno == EAGAIN case from aio_write() return;
>  Changes in v5:
>  - resolved livelock on perf record -e intel_pt// -- dd if=/dev/zero of=/dev/null count=100000
>  - data loss metrics decreased from 25% to 2x in trialed configuration;
>  - reshaped layout of data structures;
>  - implemented --aio option;
>  - avoided nanosleep() prior calling aio_suspend();
>  - switched to per-cpu aio multi buffer record__aio_sync();
>  - record_mmap_read_sync() now does global sync just before 
>    switching trace file or collection stop;
>  Changes in v4:
>  - converted mmap()/munmap() to malloc()/free() for mmap->data buffer management
>  - converted void *bf to struct perf_mmap *md in signatures
>  - written comment in perf_mmap__push() just before perf_mmap__get();
>  - written comment in record__mmap_read_sync() on possible restarting 
>    of aio_write() operation and releasing perf_mmap object after all;
>  - added perf_mmap__put() for the cases of failed aio_write();
>  Changes in v3:
>  - written comments about nanosleep(0.5ms) call prior aio_suspend()
>    to cope with intrusiveness of its implementation in glibc;
>  - written comments about rationale behind coping profiling data 
>    into mmap->data buffer;
>  Changes in v2:
>  - converted zalloc() to calloc() for allocation of mmap_aio array,
>  - cleared typo and adjusted fallback branch code;
> 
