Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E4AC6780B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 19:02:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 177772085B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 19:02:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 177772085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729796AbeJLCaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 22:30:55 -0400
Received: from mga17.intel.com ([192.55.52.151]:53442 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728239AbeJLCaz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 22:30:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Oct 2018 12:02:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,369,1534834800"; 
   d="scan'208";a="271616641"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 11 Oct 2018 11:55:44 -0700
Received: from [10.252.28.165] (abudanko-mobl.ccr.corp.intel.com [10.252.28.165])
        by linux.intel.com (Postfix) with ESMTP id BFF9E580409;
        Thu, 11 Oct 2018 11:55:41 -0700 (PDT)
Subject: [PATCH v13 2/3]: perf record: enable asynchronous trace writing
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
Message-ID: <98e5ac93-598f-d09f-e25a-9b718f1e4efc@linux.intel.com>
Date:   Thu, 11 Oct 2018 21:55:40 +0300
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


Trace file offset is read once before mmaps iterating loop and written
back after all performance data enqueued for aio writing. Trace file offset 
is incremented linearly after every successful aio write operation. 

record__aio_sync() blocks till completion of started AIO operation 
and then proceeds.

record__aio_mmap_read_sync() implements a barrier for all incomplete
aio write requests.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 Changes in v13:
 - named new functions with _aio_ word
 - grouped aio functions under single #ifdef HAVE_AIO_SUPPORT
 - moved perf_mmap__aio_push() stub into header
 - removed trailed white space
 Changes in v12:
 - implemented record__aio_get/set_pos(), record__aio_enabled()
 - implemented simple --aio option
 Changes in v11:
 - replacing the both lseek() syscalls in every loop iteration by the only 
   two syscalls just before and after the loop at record__mmap_read_evlist() 
   and advancing *in-flight* off file pos value at perf_mmap__aio_push()
 Changes in v10:
 - avoided lseek() setting file pos back in case of record__aio_write() failure
 - compacted code selecting between serial and AIO streaming
 - optimized call places of record__mmap_read_sync()
 Changes in v9:
 - enable AIO streaming only when --aio-cblocks option is specified explicitly
 Changes in v8:
 - split AIO completion check into separate record__aio_complete()
 Changes in v6:
 - handled errno == EAGAIN case from aio_write();
 Changes in v5:
 - data loss metrics decreased from 25% to 2x in trialed configuration;
 - avoided nanosleep() prior calling aio_suspend();
 - switched to per cpu multi record__aio_sync() aio
 - record_mmap_read_sync() now does global barrier just before 
   switching trace file or collection stop;
 - resolved livelock on perf record -e intel_pt// -- dd if=/dev/zero of=/dev/null count=100000
 Changes in v4:
 - converted void *bf to struct perf_mmap *md in signatures
 - written comment in perf_mmap__push() just before perf_mmap__get();
 - written comment in record__mmap_read_sync() on possible restarting 
   of aio_write() operation and releasing perf_mmap object after all;
 - added perf_mmap__put() for the cases of failed aio_write();
 Changes in v3:
 - written comments about nanosleep(0.5ms) call prior aio_suspend()
   to cope with intrusiveness of its implementation in glibc;
 - written comments about rationale behind coping profiling data 
   into mmap->data buffer;
---
 tools/perf/Documentation/perf-record.txt |   5 +
 tools/perf/builtin-record.c              | 216 ++++++++++++++++++++++++++++++-
 tools/perf/perf.h                        |   1 +
 tools/perf/util/evlist.c                 |   6 +-
 tools/perf/util/evlist.h                 |   2 +-
 tools/perf/util/mmap.c                   |  77 ++++++++++-
 tools/perf/util/mmap.h                   |  14 ++
 7 files changed, 312 insertions(+), 9 deletions(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 246dee081efd..7efb4af88a68 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -435,6 +435,11 @@ Specify vmlinux path which has debuginfo.
 --buildid-all::
 Record build-id of all DSOs regardless whether it's actually hit or not.
 
+--aio::
+Enable asynchronous (Posix AIO) trace writing mode.
+Asynchronous mode is supported only when linking Perf tool with libc library
+providing implementation for Posix AIO API.
+
 --all-kernel::
 Configure all used events to run in kernel space.
 
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 0980dfe3396b..cec56ded7532 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -124,6 +124,181 @@ static int record__write(struct record *rec, struct perf_mmap *map __maybe_unuse
 	return 0;
 }
 
+#ifdef HAVE_AIO_SUPPORT
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
+		if (aio_errno != EINTR)
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
+static void record__aio_sync(struct perf_mmap *md)
+{
+	struct aiocb *cblock = &md->aio.cblock;
+	struct timespec timeout = { 0, 1000 * 1000  * 1 }; /* 1ms */
+
+	do {
+		if (cblock->aio_fildes == -1 || record__aio_complete(md, cblock))
+			return;
+
+		while (aio_suspend((const struct aiocb**)&cblock, 1, &timeout)) {
+			if (!(errno == EAGAIN || errno == EINTR))
+				pr_err("failed to sync perf data, error: %m\n");
+		}
+	} while (1);
+}
+
+static int record__aio_pushfn(void *to, struct aiocb *cblock, void *bf, size_t size, off_t off)
+{
+	struct record *rec = to;
+	int ret, trace_fd = rec->session->data->file.fd;
+
+	rec->samples++;
+
+	ret = record__aio_write(cblock, trace_fd, bf, size, off);
+	if (!ret) {
+		rec->bytes_written += size;
+		if (switch_output_size(rec))
+			trigger_hit(&switch_output_trigger);
+	}
+
+	return ret;
+}
+
+static off_t record__aio_get_pos(int trace_fd)
+{
+	return lseek(trace_fd, 0, SEEK_CUR);
+}
+
+static void record__aio_set_pos(int trace_fd, off_t pos)
+{
+	lseek(trace_fd, pos, SEEK_SET);
+}
+
+static void record__aio_mmap_read_sync(struct record *rec)
+{
+	int i;
+	struct perf_evlist *evlist = rec->evlist;
+	struct perf_mmap *maps = evlist->mmap;
+
+	if (!rec->opts.nr_cblocks)
+		return;
+
+	for (i = 0; i < evlist->nr_mmaps; i++) {
+		struct perf_mmap *map = &maps[i];
+
+		if (map->base)
+			record__aio_sync(map);
+	}
+}
+
+static int record__aio_parse(const struct option *opt,
+			     const char *str __maybe_unused,
+			     int unset)
+{
+	struct record_opts *opts = (struct record_opts *)opt->value;
+
+	if (unset)
+		opts->nr_cblocks = 0;
+	else
+		opts->nr_cblocks = 1;
+
+	return 0;
+}
+#else /* HAVE_AIO_SUPPORT */
+static void record__aio_sync(struct perf_mmap *md __maybe_unused)
+{
+}
+
+static int record__aio_pushfn(void *to __maybe_unused, struct aiocb *cblock __maybe_unused,
+		void *bf __maybe_unused, size_t size __maybe_unused, off_t off __maybe_unused)
+{
+	return -1;
+}
+
+static off_t record__aio_get_pos(int trace_fd __maybe_unused)
+{
+	return -1;
+}
+
+static void record__aio_set_pos(int trace_fd __maybe_unused, off_t pos __maybe_unused)
+{
+}
+
+static void record__aio_mmap_read_sync(struct record *rec __maybe_unused)
+{
+}
+#endif
+
+static int record__aio_enabled(struct record *rec)
+{
+	return rec->opts.nr_cblocks > 0;
+}
+
 static int process_synthesized_event(struct perf_tool *tool,
 				     union perf_event *event,
 				     struct perf_sample *sample __maybe_unused,
@@ -329,7 +504,7 @@ static int record__mmap_evlist(struct record *rec,
 
 	if (perf_evlist__mmap_ex(evlist, opts->mmap_pages,
 				 opts->auxtrace_mmap_pages,
-				 opts->auxtrace_snapshot_mode) < 0) {
+				 opts->auxtrace_snapshot_mode, opts->nr_cblocks) < 0) {
 		if (errno == EPERM) {
 			pr_err("Permission error mapping pages.\n"
 			       "Consider increasing "
@@ -520,6 +695,8 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
 	int i;
 	int rc = 0;
 	struct perf_mmap *maps;
+	int trace_fd = rec->data.file.fd;
+	off_t off;
 
 	if (!evlist)
 		return 0;
@@ -531,13 +708,29 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
 	if (overwrite && evlist->bkw_mmap_state != BKW_MMAP_DATA_PENDING)
 		return 0;
 
+	if (record__aio_enabled(rec))
+		off = record__aio_get_pos(trace_fd);
+
 	for (i = 0; i < evlist->nr_mmaps; i++) {
 		struct perf_mmap *map = &maps[i];
 
 		if (map->base) {
-			if (perf_mmap__push(map, rec, record__pushfn) != 0) {
-				rc = -1;
-				goto out;
+			if (!record__aio_enabled(rec)) {
+				if (perf_mmap__push(map, rec, record__pushfn) != 0) {
+					rc = -1;
+					goto out;
+				}
+			} else {
+				/*
+				 * Call record__aio_sync() to wait till map->data buffer
+				 * becomes available after previous aio write request.
+				 */
+				record__aio_sync(map);
+				if (perf_mmap__aio_push(map, rec, record__aio_pushfn, &off) != 0) {
+					record__aio_set_pos(trace_fd, off);
+					rc = -1;
+					goto out;
+				}
 			}
 		}
 
@@ -548,6 +741,9 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
 		}
 	}
 
+	if (record__aio_enabled(rec))
+		record__aio_set_pos(trace_fd, off);
+
 	/*
 	 * Mark the round finished in case we wrote
 	 * at least one event.
@@ -650,6 +846,8 @@ record__switch_output(struct record *rec, bool at_exit)
 	/* Same Size:      "2015122520103046"*/
 	char timestamp[] = "InvalidTimestamp";
 
+	record__aio_mmap_read_sync(rec);
+
 	record__synthesize(rec, true);
 	if (target__none(&rec->opts.target))
 		record__synthesize_workload(rec, true);
@@ -1157,6 +1355,8 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		record__synthesize_workload(rec, true);
 
 out_child:
+	record__aio_mmap_read_sync(rec);
+
 	if (forks) {
 		int exit_status;
 
@@ -1681,6 +1881,11 @@ static struct option __record_options[] = {
 			  "signal"),
 	OPT_BOOLEAN(0, "dry-run", &dry_run,
 		    "Parse options then exit"),
+#ifdef HAVE_AIO_SUPPORT
+	OPT_CALLBACK_NOOPT(0, "aio", &record.opts,
+		     NULL, "Enable asynchronous trace writing mode",
+		     record__aio_parse),
+#endif
 	OPT_END()
 };
 
@@ -1873,6 +2078,9 @@ int cmd_record(int argc, const char **argv)
 		goto out;
 	}
 
+	if (verbose > 0)
+		pr_info("nr_cblocks: %d\n", rec->opts.nr_cblocks);
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
index 1a83bf2c069c..6593bd0dc2af 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1018,7 +1018,7 @@ int perf_evlist__parse_mmap_pages(const struct option *opt, const char *str,
  */
 int perf_evlist__mmap_ex(struct perf_evlist *evlist, unsigned int pages,
 			 unsigned int auxtrace_pages,
-			 bool auxtrace_overwrite)
+			 bool auxtrace_overwrite, int nr_cblocks)
 {
 	struct perf_evsel *evsel;
 	const struct cpu_map *cpus = evlist->cpus;
@@ -1028,7 +1028,7 @@ int perf_evlist__mmap_ex(struct perf_evlist *evlist, unsigned int pages,
 	 * Its value is decided by evsel's write_backward.
 	 * So &mp should not be passed through const pointer.
 	 */
-	struct mmap_params mp = { .nr_cblocks = 0 };
+	struct mmap_params mp = { .nr_cblocks = nr_cblocks };
 
 	if (!evlist->mmap)
 		evlist->mmap = perf_evlist__alloc_mmap(evlist, false);
@@ -1060,7 +1060,7 @@ int perf_evlist__mmap_ex(struct perf_evlist *evlist, unsigned int pages,
 
 int perf_evlist__mmap(struct perf_evlist *evlist, unsigned int pages)
 {
-	return perf_evlist__mmap_ex(evlist, pages, 0, false);
+	return perf_evlist__mmap_ex(evlist, pages, 0, false, 0);
 }
 
 int perf_evlist__create_maps(struct perf_evlist *evlist, struct target *target)
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index dc66436add98..2464463879b4 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -162,7 +162,7 @@ unsigned long perf_event_mlock_kb_in_pages(void);
 
 int perf_evlist__mmap_ex(struct perf_evlist *evlist, unsigned int pages,
 			 unsigned int auxtrace_pages,
-			 bool auxtrace_overwrite);
+			 bool auxtrace_overwrite, int nr_cblocks);
 int perf_evlist__mmap(struct perf_evlist *evlist, unsigned int pages);
 void perf_evlist__munmap(struct perf_evlist *evlist);
 
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 47cdc3ad6546..61aa381d05d0 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -158,7 +158,8 @@ static int perf_mmap__aio_mmap(struct perf_mmap *map, struct mmap_params *mp)
 {
 	int delta_max;
 
-	if (mp->nr_cblocks) {
+	map->aio.nr_cblocks = mp->nr_cblocks;
+	if (map->aio.nr_cblocks) {
 		map->aio.data = malloc(perf_mmap__mmap_len(map));
 		if (!map->aio.data) {
 			pr_debug2("failed to allocate data buffer, error %m\n");
@@ -187,6 +188,80 @@ static void perf_mmap__aio_munmap(struct perf_mmap *map)
 	if (map->aio.data)
 		zfree(&map->aio.data);
 }
+
+int perf_mmap__aio_push(struct perf_mmap *md, void *to,
+			int push(void *to, struct aiocb *cblock, void *buf, size_t size, off_t off),
+			off_t *off)
+{
+	u64 head = perf_mmap__read_head(md);
+	unsigned char *data = md->base + page_size;
+	unsigned long size, size0 = 0;
+	void *buf;
+	int rc = 0;
+
+	rc = perf_mmap__read_init(md);
+	if (rc < 0)
+		return (rc == -EAGAIN) ? 0 : -1;
+
+	/*
+	 * md->base data is copied into md->data buffer to
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
+		memcpy(md->aio.data, buf, size);
+		size0 = size;
+	}
+
+	buf = &data[md->start & md->mask];
+	size = md->end - md->start;
+	md->start += size;
+	memcpy(md->aio.data + size0, buf, size);
+
+	/*
+	 * Increment md->refcount to guard md->data buffer
+	 * from premature deallocation because md object can be
+	 * released earlier than aio write request started
+	 * on mmap->data is complete.
+	 *
+	 * perf_mmap__put() is done at record__aio_complete()
+	 * after started request completion.
+	 */
+	perf_mmap__get(md);
+
+	md->prev = head;
+	perf_mmap__consume(md);
+
+	rc = push(to, &md->aio.cblock, md->aio.data, size0 + size, *off);
+	if (!rc) {
+		*off += size0 + size;
+	} else {
+		/*
+		 * Decrement md->refcount back if aio write
+		 * operation failed to start.
+		 */
+		perf_mmap__put(md);
+	}
+
+	return rc;
+}
 #else
 static int perf_mmap__aio_mmap(struct perf_mmap *map __maybe_unused,
 			       struct mmap_params *mp __maybe_unused)
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index a46dbdcdcc8a..9be06f18f17a 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -12,6 +12,7 @@
 #include "auxtrace.h"
 #include "event.h"
 
+struct aiocb;
 /**
  * struct perf_mmap - perf's ring buffer mmap details
  *
@@ -33,6 +34,7 @@ struct perf_mmap {
 	struct {
 		void 		 *data;
 		struct aiocb	 cblock;
+		int		 nr_cblocks;
 	} aio;
 #endif
 };
@@ -103,6 +105,18 @@ union perf_event *perf_mmap__read_event(struct perf_mmap *map);
 
 int perf_mmap__push(struct perf_mmap *md, void *to,
 		    int push(struct perf_mmap *map, void *to, void *buf, size_t size));
+#ifdef HAVE_AIO_SUPPORT
+int perf_mmap__aio_push(struct perf_mmap *md, void *to,
+			int push(void *to, struct aiocb *cblock, void *buf, size_t size, off_t off),
+			off_t *off);
+#else
+static inline int perf_mmap__aio_push(struct perf_mmap *md __maybe_unused, void *to __maybe_unused,
+	int push(void *to, struct aiocb *cblock, void *buf, size_t size, off_t off) __maybe_unused,
+	off_t *off __maybe_unused)
+{
+	return 0;
+}
+#endif
 
 size_t perf_mmap__mmap_len(struct perf_mmap *map);
