Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E9DBC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 16:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0F5D2098A
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 16:13:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0F5D2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbeJCXCZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 19:02:25 -0400
Received: from mga14.intel.com ([192.55.52.115]:61900 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726818AbeJCXCZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 19:02:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Oct 2018 09:13:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,336,1534834800"; 
   d="scan'208";a="94320293"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 03 Oct 2018 09:12:14 -0700
Received: from [10.252.30.119] (abudanko-mobl.ccr.corp.intel.com [10.252.30.119])
        by linux.intel.com (Postfix) with ESMTP id 417705801E6;
        Wed,  3 Oct 2018 09:12:12 -0700 (PDT)
Subject: [PATCH v9 2/3]: perf record: enable asynchronous trace writing
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
Message-ID: <5ed78452-ff2b-dfe5-ec29-888971cb4b55@linux.intel.com>
Date:   Wed, 3 Oct 2018 19:12:10 +0300
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


Trace file offset is calculated and updated linearly prior
enqueuing aio write at record__pushfn().

record__aio_sync() blocks till completion of started AIO operation 
and then proceeds.

record__mmap_read_sync() implements a barrier for all incomplete
aio write requests.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
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
 tools/perf/builtin-record.c | 154 +++++++++++++++++++++++++++++++++++++++++++-
 tools/perf/perf.h           |   3 +
 tools/perf/util/mmap.c      |  73 +++++++++++++++++++++
 tools/perf/util/mmap.h      |   4 ++
 4 files changed, 233 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 0980dfe3396b..c63fe8c021a2 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -124,6 +124,118 @@ static int record__write(struct record *rec, struct perf_mmap *map __maybe_unuse
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
+	struct aiocb *cblock = &md->cblock;
+	struct timespec timeout = { 0, 1000 * 1000  * 1 }; // 1ms
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
+static int record__aio_pushfn(void *to, struct aiocb *cblock, void *bf, size_t size)
+{
+	off_t off;
+	struct record *rec = to;
+	int ret, trace_fd = rec->session->data->file.fd;
+
+	rec->samples++;
+
+	off = lseek(trace_fd, 0, SEEK_CUR);
+	lseek(trace_fd, off + size, SEEK_SET);
+	ret = record__aio_write(cblock, trace_fd, bf, size, off);
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
+}
+#endif
+
 static int process_synthesized_event(struct perf_tool *tool,
 				     union perf_event *event,
 				     struct perf_sample *sample __maybe_unused,
@@ -136,7 +248,6 @@ static int process_synthesized_event(struct perf_tool *tool,
 static int record__pushfn(struct perf_mmap *map, void *to, void *bf, size_t size)
 {
 	struct record *rec = to;
-
 	rec->samples++;
 	return record__write(rec, map, bf, size);
 }
@@ -513,6 +624,24 @@ static struct perf_event_header finished_round_event = {
 	.type = PERF_RECORD_FINISHED_ROUND,
 };
 
+static void record__mmap_read_sync(struct record *rec __maybe_unused)
+{
+#ifdef HAVE_AIO_SUPPORT
+	int i;
+	struct perf_evlist *evlist = rec->evlist;
+	struct perf_mmap *maps = evlist->mmap;
+
+	if (!rec->opts.nr_cblocks)
+		return;
+
+	for (i = 0; i < evlist->nr_mmaps; i++) {
+		struct perf_mmap *map = &maps[i];
+		if (map->base)
+			record__aio_sync(map);
+	}
+#endif
+}
+
 static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evlist,
 				    bool overwrite)
 {
@@ -535,10 +664,29 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
 		struct perf_mmap *map = &maps[i];
 
 		if (map->base) {
+#ifndef HAVE_AIO_SUPPORT
 			if (perf_mmap__push(map, rec, record__pushfn) != 0) {
 				rc = -1;
 				goto out;
 			}
+#else
+			if (!rec->opts.nr_cblocks) {
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
+				if (perf_mmap__aio_push(map, rec, record__aio_pushfn) != 0) {
+					rc = -1;
+					goto out;
+				}
+			}
+#endif
 		}
 
 		if (map->auxtrace_mmap.base && !rec->opts.auxtrace_snapshot_mode &&
@@ -1057,6 +1205,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 			perf_evlist__toggle_bkw_mmap(rec->evlist, BKW_MMAP_DATA_PENDING);
 
 		if (record__mmap_read_all(rec) < 0) {
+			record__mmap_read_sync(rec);
 			trigger_error(&auxtrace_snapshot_trigger);
 			trigger_error(&switch_output_trigger);
 			err = -1;
@@ -1068,6 +1217,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 			if (!trigger_is_error(&auxtrace_snapshot_trigger))
 				record__read_auxtrace_snapshot(rec);
 			if (trigger_is_error(&auxtrace_snapshot_trigger)) {
+				record__mmap_read_sync(rec);
 				pr_err("AUX area tracing snapshot failed\n");
 				err = -1;
 				goto out_child;
@@ -1086,6 +1236,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 			 */
 			if (rec->evlist->bkw_mmap_state == BKW_MMAP_RUNNING)
 				continue;
+			record__mmap_read_sync(rec);
 			trigger_ready(&switch_output_trigger);
 
 			/*
@@ -1139,6 +1290,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 			disabled = true;
 		}
 	}
+	record__mmap_read_sync(rec);
 	trigger_off(&auxtrace_snapshot_trigger);
 	trigger_off(&switch_output_trigger);
 
diff --git a/tools/perf/perf.h b/tools/perf/perf.h
index 21bf7f5a3cf5..ef700d8bb610 100644
--- a/tools/perf/perf.h
+++ b/tools/perf/perf.h
@@ -82,6 +82,9 @@ struct record_opts {
 	bool         use_clockid;
 	clockid_t    clockid;
 	unsigned int proc_map_timeout;
+#ifdef HAVE_AIO_SUPPORT
+	int	     nr_cblocks;
+#endif
 };
 
 struct option;
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 5b3727b0c7c0..0a13e217458d 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -352,6 +352,79 @@ int perf_mmap__push(struct perf_mmap *md, void *to,
 	return rc;
 }
 
+#ifdef HAVE_AIO_SUPPORT
+int perf_mmap__aio_push(struct perf_mmap *md, void *to,
+			int push(void *to, struct aiocb *cblock, void *buf, size_t size))
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
+		memcpy(md->data, buf, size);
+		size0 = size;
+	}
+
+	buf = &data[md->start & md->mask];
+	size = md->end - md->start;
+	md->start += size;
+	memcpy(md->data + size0, buf, size);
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
+	rc = push(to, &md->cblock, md->data, size0 + size);
+	if (rc) {
+		/*
+		 * Decrement md->refcount back if aio write
+		 * operation failed to start.
+		 */
+		perf_mmap__put(md);
+	}
+
+	return rc;
+}
+#endif
+
 /*
  * Mandatory for overwrite mode
  * The direction of overwrite mode is backward.
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index 1b63b6cc7cf9..ac011777c38f 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -105,6 +105,10 @@ union perf_event *perf_mmap__read_event(struct perf_mmap *map);
 
 int perf_mmap__push(struct perf_mmap *md, void *to,
 		    int push(struct perf_mmap *map, void *to, void *buf, size_t size));
+#ifdef HAVE_AIO_SUPPORT
+int perf_mmap__aio_push(struct perf_mmap *md, void *to,
+			int push(void *to, struct aiocb *cblock, void *buf, size_t size));
+#endif
 
 size_t perf_mmap__mmap_len(struct perf_mmap *map);
