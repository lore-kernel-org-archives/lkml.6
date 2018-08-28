Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1CB5C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72EF320894
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 15:57:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72EF320894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbeH1TuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 15:50:13 -0400
Received: from mga12.intel.com ([192.55.52.136]:19986 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727098AbeH1TuN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 15:50:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Aug 2018 08:57:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,300,1531810800"; 
   d="scan'208";a="257923873"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 28 Aug 2018 08:57:46 -0700
Received: from [10.125.252.157] (abudanko-mobl.ccr.corp.intel.com [10.125.252.157])
        by linux.intel.com (Postfix) with ESMTP id 28AAD5802AD;
        Tue, 28 Aug 2018 08:57:43 -0700 (PDT)
Subject: [PATCH v4 2/2]: perf record: enable asynchronous trace writing
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <74fbcac7-80af-fcf0-2666-adefca98c271@linux.intel.com>
Organization: Intel Corp.
Message-ID: <3333b5e8-4d07-5008-109f-bde53af38678@linux.intel.com>
Date:   Tue, 28 Aug 2018 18:57:43 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <74fbcac7-80af-fcf0-2666-adefca98c271@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Trace file offset are linearly calculated by perf_mmap__push() code 
for the next possible write operation, but file position is updated by 
the kernel only in the second lseek() syscall after the loop. 
The first lseek() syscall reads that file position for 
the next loop iterations.

record__mmap_read_sync implements sort of a barrier between spilling 
ready profiling data to disk.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
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
 tools/perf/builtin-record.c | 136 +++++++++++++++++++++++++++++++++++++++++---
 tools/perf/util/mmap.c      |  43 ++++++++++----
 tools/perf/util/mmap.h      |   2 +-
 3 files changed, 161 insertions(+), 20 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 22ebeb92ac51..7b628f9a7770 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -121,6 +121,23 @@ static int record__write(struct record *rec, void *bf, size_t size)
 	return 0;
 }
 
+static int record__aio_write(int trace_fd, struct aiocb *cblock,
+		void *buf, size_t size, off_t off)
+{
+	cblock->aio_fildes = trace_fd;
+	cblock->aio_buf    = buf;
+	cblock->aio_nbytes = size;
+	cblock->aio_offset = off;
+	cblock->aio_sigevent.sigev_notify = SIGEV_NONE;
+
+	if (aio_write(cblock) == -1) {
+		pr_err("failed to queue perf data, error: %m\n");
+		return -1;
+	}
+
+	return 0;
+}
+
 static int process_synthesized_event(struct perf_tool *tool,
 				     union perf_event *event,
 				     struct perf_sample *sample __maybe_unused,
@@ -130,12 +147,13 @@ static int process_synthesized_event(struct perf_tool *tool,
 	return record__write(rec, event, event->header.size);
 }
 
-static int record__pushfn(void *to, void *bf, size_t size)
+static int record__pushfn(void *to, struct perf_mmap *map, size_t size, off_t off)
 {
 	struct record *rec = to;
 
 	rec->samples++;
-	return record__write(rec, bf, size);
+	return record__aio_write(rec->session->data->file.fd, &map->cblock,
+			map->data, size, off);
 }
 
 static volatile int done;
@@ -510,13 +528,110 @@ static struct perf_event_header finished_round_event = {
 	.type = PERF_RECORD_FINISHED_ROUND,
 };
 
+static int record__mmap_read_sync(int trace_fd, struct aiocb **cblocks,
+		int cblocks_size, struct record *rec)
+{
+	size_t rem;
+	ssize_t size;
+	off_t rem_off;
+	int i, aio_ret, aio_errno, do_suspend;
+	struct perf_mmap *md;
+	struct timespec timeout0 = { 0, 0 };
+	struct timespec timeoutS = { 0, 1000 * 500  * 1 }; // 0.5ms
+
+	if (!cblocks_size)
+		return 0;
+
+	do {
+		do_suspend = 0;
+		/* aio_suspend() implementation inside glibc (as of v2.27) is
+		 * intrusive and not just blocks waiting io requests completion
+		 * but polls requests queue inducing context switches in perf
+		 * tool process. When profiling in system wide mode with tracing
+		 * context switches the trace may be polluted by context switches
+		 * from the perf process and the trace size becomes about 3-5
+		 * times bigger than that of when writing the trace serially.
+		 * To limit the volume of context switches from perf tool
+		 * process nanosleep() call below is added prior aio_suspend()
+		 * calling till every half of the kernel timer tick which is
+		 * usually 1ms (depends on CONFIG_HZ value).
+		 */
+		nanosleep(&timeoutS, NULL);
+		if (aio_suspend((const struct aiocb**)cblocks, cblocks_size, &timeout0)) {
+			if (errno == EAGAIN || errno == EINTR) {
+				do_suspend = 1;
+				continue;
+			} else {
+				pr_err("failed to sync perf data, error: %m\n");
+				break;
+			}
+		}
+		for (i = 0; i < cblocks_size; i++) {
+			if (cblocks[i] == NULL) {
+				continue;
+			}
+			aio_errno = aio_error(cblocks[i]);
+			if (aio_errno == EINPROGRESS) {
+				do_suspend = 1;
+				continue;
+			}
+			md = (struct perf_mmap*)((char*)cblocks[i] -
+				offsetof(struct perf_mmap, cblock));
+			size = aio_ret = aio_return((struct aiocb*)cblocks[i]);
+			if (aio_ret < 0) {
+				if (aio_errno == EINTR) {
+					size = 0;
+				} else {
+					pr_err("failed to write perf data, error: %m\n");
+					perf_mmap__put(md);
+					cblocks[i] = NULL;
+					continue;
+				}
+			}
+			rec->bytes_written += size;
+			rem = cblocks[i]->aio_nbytes - (size_t)size;
+			if (rem == 0) {
+				/* We incremented perf_mmap refcount after successful
+				 * push() from map->base to map->data with the
+				 * following aio_write() at perf_mmap__push() code and
+				 * decrement here when aio write request is fully
+				 * complete. We also decrement the refcount if
+				 * lowlevel AIO write syscall failed with the reason
+				 * different from -EINTR. See right above.
+				 */
+				perf_mmap__put(md);
+				cblocks[i] = NULL;
+				if (switch_output_size(rec))
+					trigger_hit(&switch_output_trigger);
+			} else {
+				/* aio write request may require restart with the
+				 * reminder if the kernel didn't write whole pushed
+				 * chunk at once.
+				 */
+				rem_off = cblocks[i]->aio_offset +
+					cblocks[i]->aio_nbytes - rem;
+				if (!record__aio_write(trace_fd,
+					(struct aiocb *)cblocks[i],
+					md->data + cblocks[i]->aio_nbytes - rem,
+					rem, rem_off))
+					do_suspend = 1;
+			}
+		}
+	} while (do_suspend);
+
+	return 0;
+}
+
 static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evlist,
 				    bool overwrite)
 {
 	u64 bytes_written = rec->bytes_written;
-	int i;
-	int rc = 0;
+	int i, rc = 0;
 	struct perf_mmap *maps;
+	int trace_fd = rec->session->data->file.fd;
+	struct aiocb **mmap_aio = rec->evlist->mmap_aio;
+	int mmap_aio_size = 0;
+	off_t off;
 
 	if (!evlist)
 		return 0;
@@ -528,14 +643,17 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
 	if (overwrite && evlist->bkw_mmap_state != BKW_MMAP_DATA_PENDING)
 		return 0;
 
+	off = lseek(trace_fd, 0, SEEK_CUR);
+
 	for (i = 0; i < evlist->nr_mmaps; i++) {
 		struct auxtrace_mmap *mm = &maps[i].auxtrace_mmap;
 
 		if (maps[i].base) {
-			if (perf_mmap__push(&maps[i], rec, record__pushfn) != 0) {
-				rc = -1;
+			rc = perf_mmap__push(&maps[i], rec, record__pushfn, &off);
+			if (rc < 0)
 				goto out;
-			}
+			else if (rc > 0)
+				mmap_aio[mmap_aio_size++] = &maps[i].cblock;
 		}
 
 		if (mm->base && !rec->opts.auxtrace_snapshot_mode &&
@@ -545,6 +663,10 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
 		}
 	}
 
+	record__mmap_read_sync(trace_fd, mmap_aio, mmap_aio_size, rec);
+
+	lseek(trace_fd, off, SEEK_SET);
+
 	/*
 	 * Mark the round finished in case we wrote
 	 * at least one event.
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 570cba187f70..17460086423f 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -290,11 +290,11 @@ int perf_mmap__read_init(struct perf_mmap *map)
 }
 
 int perf_mmap__push(struct perf_mmap *md, void *to,
-		    int push(void *to, void *buf, size_t size))
+		    int push(void *to, struct perf_mmap *md, size_t size, off_t off), off_t *off)
 {
 	u64 head = perf_mmap__read_head(md);
 	unsigned char *data = md->base + page_size;
-	unsigned long size;
+	unsigned long size, size0 = 0;
 	void *buf;
 	int rc = 0;
 
@@ -304,25 +304,44 @@ int perf_mmap__push(struct perf_mmap *md, void *to,
 
 	size = md->end - md->start;
 
+	/* Data is copied into the md->data buffer to release space in
+	 * the kernel buffer as fast as possible, thru perf_mmap__consume().
+	 * That lets the kernel to proceed with storing more profiling
+	 * data into the kernel buffer earlier than other per-cpu kernel
+	 * buffers are handled.
+	 *
+	 * Coping can be done in two steps in case chunk of the profiling
+	 * data split by upper bound in the kernel buffer. In this case
+	 * we first move upper part of data from md->start till the
+	 * upper bound and then the reminder from the beginning of
+	 * the kernel buffer till the end of the data chunk.
+	 */
+
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
+		memcpy(md->data, buf, size0);
 	}
 
 	buf = &data[md->start & md->mask];
 	size = md->end - md->start;
 	md->start += size;
+	memcpy(md->data + size0, buf, size);
 
-	if (push(to, buf, size) < 0) {
-		rc = -1;
+	rc = push(to, md, size0 + size, *off) < 0 ? -1 : 1;
+	if (rc == -1)
 		goto out;
-	}
+
+	/* perf_mmap__get() below guards md->data buffer from premature
+	 * deallocation because md->base kernel buffer and md object
+	 * itself can be released earlier than just pushed aio request
+	 * on mmap->data is complete. Complement perf_mmap__put() call
+	 * is implemented at record__mmap_read_sync() code after
+	 * the pushed request completion or error from the system.
+	 */
+	perf_mmap__get(md);
+	*off += size0 + size;
 
 	md->prev = head;
 	perf_mmap__consume(md);
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index 1974e621e36b..7949702bc104 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -95,7 +95,7 @@ union perf_event *perf_mmap__read_forward(struct perf_mmap *map);
 union perf_event *perf_mmap__read_event(struct perf_mmap *map);
 
 int perf_mmap__push(struct perf_mmap *md, void *to,
-		    int push(void *to, void *buf, size_t size));
+		    int push(void *to, struct perf_mmap *md, size_t size, off_t off), off_t *off);
 
 size_t perf_mmap__mmap_len(struct perf_mmap *map);
 
