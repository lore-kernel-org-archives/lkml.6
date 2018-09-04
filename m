Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91467C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 11:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F4CE20659
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 11:58:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F4CE20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbeIDQXG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 12:23:06 -0400
Received: from mga12.intel.com ([192.55.52.136]:21575 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726223AbeIDQXG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 12:23:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2018 04:58:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,329,1531810800"; 
   d="scan'208";a="88816576"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 04 Sep 2018 04:58:07 -0700
Received: from [10.125.251.238] (abudanko-mobl.ccr.corp.intel.com [10.125.251.238])
        by linux.intel.com (Postfix) with ESMTP id 24BE35803E2;
        Tue,  4 Sep 2018 04:58:04 -0700 (PDT)
Subject: [PATCH v6 2/2]: perf record: enable asynchronous trace writing
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <01963930-68b3-ff33-6e05-acaff3efc083@linux.intel.com>
Organization: Intel Corp.
Message-ID: <920241cd-7c14-d622-6c9f-2fa61b0963b2@linux.intel.com>
Date:   Tue, 4 Sep 2018 14:58:04 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <01963930-68b3-ff33-6e05-acaff3efc083@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


record__aio_sync() allocates index of free map->data buffer for 
a cpu buffer or blocks till completion of any started operation 
and then proceeds.

Trace file offset is calculated and updated linearly prior
enqueuing aio write at record__pushfn().

record__mmap_read_sync() implements a barrier for all incomplete
aio write requests per-cpu per aio data.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
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
 tools/perf/builtin-record.c | 182 +++++++++++++++++++++++++++++++++++++++++++-
 tools/perf/util/mmap.c      |  57 ++++++++++----
 tools/perf/util/mmap.h      |   4 +-
 3 files changed, 223 insertions(+), 20 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 8eb093f8d4d5..78965b3737a9 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -121,6 +121,91 @@ static int record__write(struct record *rec, void *bf, size_t size)
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
+static int record__aio_sync(struct perf_mmap *md)
+{
+	void *rem_buf;
+	off_t rem_off;
+	size_t rem_size;
+	ssize_t aio_ret, written;
+	int i, aio_errno, do_suspend, idx = -1;
+	struct aiocb **cblocks = md->cblocks;
+	struct timespec timeout = { 0, 1000 * 1000  * 1 }; // 1ms
+
+	for (i = 0; i < md->nr_cblocks; ++i)
+		if (cblocks[i]->aio_fildes == -1)
+			return i;
+
+	do {
+		do_suspend = 0;
+		if (aio_suspend((const struct aiocb**)cblocks, md->nr_cblocks, &timeout)) {
+			if (!(errno == EAGAIN || errno == EINTR))
+				pr_err("failed to sync perf data, error: %m\n");
+			do_suspend = 1;
+			continue;
+		}
+		for (i = 0; i < md->nr_cblocks; ++i) {
+			aio_errno = aio_error(cblocks[i]);
+			if (aio_errno == EINPROGRESS)
+				continue;
+			written = aio_ret = aio_return(cblocks[i]);
+			if (aio_ret < 0) {
+				if (aio_errno != EINTR)
+					pr_err("failed to write perf data, error: %m\n");
+				written = 0;
+			}
+			rem_size = cblocks[i]->aio_nbytes - written;
+			if (rem_size == 0) {
+				cblocks[i]->aio_fildes = -1;
+				/* md->refcount is incremented in perf_mmap__push() for
+				 * every enqueued aio write request so decrement it because
+				 * the request is now complete.
+				 */
+				perf_mmap__put(md);
+				if (idx == -1)
+					idx = i;
+			} else {
+				/* aio write request may require restart with the
+				 * reminder if the kernel didn't write whole
+				 * chunk at once.
+				 */
+				rem_off = cblocks[i]->aio_offset + written;
+				rem_buf = (void*)(cblocks[i]->aio_buf + written);
+				record__aio_write(cblocks[i], cblocks[i]->aio_fildes,
+						rem_buf, rem_size, rem_off);
+			}
+		}
+		if (idx == -1)
+			do_suspend = 1;
+	} while (do_suspend);
+
+	return idx;
+}
+
 static int process_synthesized_event(struct perf_tool *tool,
 				     union perf_event *event,
 				     struct perf_sample *sample __maybe_unused,
@@ -130,12 +215,28 @@ static int process_synthesized_event(struct perf_tool *tool,
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
+	off =
+	lseek(trace_fd, 0, SEEK_CUR);
+	lseek(trace_fd, off + size, SEEK_SET);
+
+	ret = record__aio_write(cblock, trace_fd, data, size, off);
+	if (!ret) {
+		rec->bytes_written += size;
+		if (switch_output_size(rec))
+			trigger_hit(&switch_output_trigger);
+	} else {
+		lseek(trace_fd, off, SEEK_SET);
+	}
+
+	return ret;
 }
 
 static volatile int done;
@@ -511,6 +612,70 @@ static struct perf_event_header finished_round_event = {
 	.type = PERF_RECORD_FINISHED_ROUND,
 };
 
+static void record__aio_complete(struct perf_mmap *md, int i)
+{
+	int aio_errno;
+	void *rem_buf;
+	off_t rem_off;
+	size_t rem_size;
+	ssize_t aio_ret, written;
+	struct aiocb *cblock = md->cblocks[i];
+	struct timespec timeout = { 0, 1000 * 1000  * 1 }; // 1ms
+
+	if (cblock->aio_fildes == -1)
+		return;
+
+	do {
+		if (aio_suspend((const struct aiocb**)&cblock, 1, &timeout)) {
+			if (!(errno == EAGAIN || errno == EINTR))
+				pr_err("failed to sync perf data, error: %m\n");
+			continue;
+		}
+		aio_errno = aio_error(cblock);
+		if (aio_errno == EINPROGRESS)
+			continue;
+		written = aio_ret = aio_return(cblock);
+		if (aio_ret < 0) {
+			if (!(aio_errno == EINTR))
+				pr_err("failed to write perf data, error: %m\n");
+			written = 0;
+		}
+		rem_size = cblock->aio_nbytes - written;
+		if (rem_size == 0) {
+			cblock->aio_fildes = -1;
+			/* md->refcount is incremented in perf_mmap__push() for
+			 * every enqueued aio write request so decrement it because
+			 * the request is now complete.
+			 */
+			perf_mmap__put(md);
+			return;
+		} else {
+			/* aio write request may require restart with the
+			 * reminder if the kernel didn't write whole
+			 * chunk at once.
+			 */
+			rem_off = cblock->aio_offset + written;
+			rem_buf = (void*)(cblock->aio_buf + written);
+			record__aio_write(cblock, cblock->aio_fildes,
+					rem_buf, rem_size, rem_off);
+		}
+	} while (1);
+}
+
+static void record__mmap_read_sync(struct record *rec)
+{
+	int i, j;
+	struct perf_evlist *evlist = rec->evlist;
+	struct perf_mmap *maps = evlist->mmap;
+
+	for (i = 0; i < evlist->nr_mmaps; i++) {
+		struct perf_mmap *map = &maps[i];
+		if (map->base)
+			for (j = 0; j < map->nr_cblocks; ++j)
+				record__aio_complete(map, j);
+	}
+}
+
 static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evlist,
 				    bool overwrite)
 {
@@ -533,7 +698,13 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
 		struct auxtrace_mmap *mm = &maps[i].auxtrace_mmap;
 
 		if (maps[i].base) {
-			if (perf_mmap__push(&maps[i], rec, record__pushfn) != 0) {
+			/* Call record__aio_sync() to allocate free
+			 * map->data buffer or wait till one of the
+			 * buffers becomes available after previous
+			 * aio write request.
+			 */
+			if (perf_mmap__push(&maps[i], rec, record__aio_sync(&maps[i]),
+				record__pushfn) != 0) {
 				rc = -1;
 				goto out;
 			}
@@ -1055,6 +1226,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 			perf_evlist__toggle_bkw_mmap(rec->evlist, BKW_MMAP_DATA_PENDING);
 
 		if (record__mmap_read_all(rec) < 0) {
+			record__mmap_read_sync(rec);
 			trigger_error(&auxtrace_snapshot_trigger);
 			trigger_error(&switch_output_trigger);
 			err = -1;
@@ -1066,6 +1238,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 			if (!trigger_is_error(&auxtrace_snapshot_trigger))
 				record__read_auxtrace_snapshot(rec);
 			if (trigger_is_error(&auxtrace_snapshot_trigger)) {
+				record__mmap_read_sync(rec);
 				pr_err("AUX area tracing snapshot failed\n");
 				err = -1;
 				goto out_child;
@@ -1084,6 +1257,8 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 			 */
 			if (rec->evlist->bkw_mmap_state == BKW_MMAP_RUNNING)
 				continue;
+
+			record__mmap_read_sync(rec);
 			trigger_ready(&switch_output_trigger);
 
 			/*
@@ -1137,6 +1312,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 			disabled = true;
 		}
 	}
+	record__mmap_read_sync(rec);
 	trigger_off(&auxtrace_snapshot_trigger);
 	trigger_off(&switch_output_trigger);
 
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 384d17cd1379..1d57d8387caf 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -332,12 +332,12 @@ int perf_mmap__read_init(struct perf_mmap *map)
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
 
@@ -345,31 +345,58 @@ int perf_mmap__push(struct perf_mmap *md, void *to,
 	if (rc < 0)
 		return (rc == -EAGAIN) ? 0 : -1;
 
+	/* md->base data is copied into md->data[idx] buffer to
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
-		size = md->mask + 1 - (md->start & md->mask);
-		md->start += size;
-
-		if (push(to, buf, size) < 0) {
-			rc = -1;
-			goto out;
-		}
+		size0 = md->mask + 1 - (md->start & md->mask);
+		md->start += size0;
+		memcpy(md->data[idx], buf, size0);
 	}
 
 	buf = &data[md->start & md->mask];
 	size = md->end - md->start;
 	md->start += size;
+	memcpy(md->data[idx] + size0, buf, size);
 
-	if (push(to, buf, size) < 0) {
-		rc = -1;
-		goto out;
-	}
+	/* Increment md->refcount to guard md->data[idx] buffer
+	 * from premature deallocation because md object can be
+	 * released earlier than aio write request started
+	 * on mmap->data[idx] is complete.
+	 *
+	 * perf_mmap__put() is done at record__aio_sync() or
+	 * record__aio_complete() after started request completion.
+	 */
+
+	perf_mmap__get(md);
 
 	md->prev = head;
 	perf_mmap__consume(md);
-out:
+
+	rc = push(to, md->cblocks[idx], md->data[idx], size0 + size);
+	if (rc) {
+		/* Decrement md->refcount back if aio write
+		 * operation failed to start.
+		 */
+		perf_mmap__put(md);
+	}
+
 	return rc;
 }
 
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index 4a9bb0ecae4f..9a106c075172 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -95,8 +95,8 @@ union perf_event *perf_mmap__read_forward(struct perf_mmap *map);
 
 union perf_event *perf_mmap__read_event(struct perf_mmap *map);
 
-int perf_mmap__push(struct perf_mmap *md, void *to,
-		    int push(void *to, void *buf, size_t size));
+int perf_mmap__push(struct perf_mmap *md, void *to, int aio_idx,
+		    int push(void *to, struct aiocb *cblock, void *data, size_t size));
 
 size_t perf_mmap__mmap_len(struct perf_mmap *map);
 
