Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B7CC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 08:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AA7B216C4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 08:28:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AA7B216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbeHULrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 07:47:11 -0400
Received: from mga12.intel.com ([192.55.52.136]:10480 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbeHULrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 07:47:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Aug 2018 01:27:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,269,1531810800"; 
   d="scan'208";a="85087508"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga002.jf.intel.com with ESMTP; 21 Aug 2018 01:27:07 -0700
Received: from [10.125.252.171] (abudanko-mobl.ccr.corp.intel.com [10.125.252.171])
        by linux.intel.com (Postfix) with ESMTP id 5F39D580145;
        Tue, 21 Aug 2018 01:27:04 -0700 (PDT)
Subject: [PATCH v1 2/2]: perf record: enable asynchronous trace writing
From:   Alexey Budankov <alexey.budankov@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
References: <dcd3ee88-57d6-8704-f5e1-7a3c75a17d8d@linux.intel.com>
Organization: Intel Corp.
Message-ID: <2db359cc-dc5d-c00e-a42a-12a2e9da80b7@linux.intel.com>
Date:   Tue, 21 Aug 2018 11:27:03 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <dcd3ee88-57d6-8704-f5e1-7a3c75a17d8d@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Trace file offsets are different for every enqueued write operation 
and calculated dynamically in trace streaming loop and don't overlap 
so write requests can be written in parallel.

record__mmap_read_sync implements sort of a barrier between spilling 
ready profiling data to disk.

Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
---
 tools/perf/builtin-record.c | 97 +++++++++++++++++++++++++++++++++++++++++----
 tools/perf/util/mmap.c      | 23 +++++------
 tools/perf/util/mmap.h      |  2 +-
 3 files changed, 101 insertions(+), 21 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index a35675e9f3aa..dee63229ed37 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -132,7 +132,7 @@ static int record__aio_write(int trace_fd, struct aiocb *cblock,
 	cblock->aio_sigevent.sigev_notify = SIGEV_NONE;
 
 	if (aio_write(cblock) == -1) {
-		pr_err("failed to write perf data, error: %m\n");
+		pr_err("failed to queue perf data, error: %m\n");
 		return -1;
 	}
 
@@ -148,12 +148,14 @@ static int process_synthesized_event(struct perf_tool *tool,
 	return record__write(rec, event, event->header.size);
 }
 
-static int record__pushfn(void *to, void *bf, size_t size)
+static int record__pushfn(void *to, void *bf, size_t size, off_t off)
 {
 	struct record *rec = to;
+	struct perf_mmap *map = bf;
 
 	rec->samples++;
-	return record__write(rec, bf, size);
+	return record__aio_write(rec->session->data->file.fd, &map->cblock,
+			map->data, size, off);
 }
 
 static volatile int done;
@@ -528,13 +530,85 @@ static struct perf_event_header finished_round_event = {
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
+	struct timespec timeoutS = { 0, 1000 * 500  * 1 };
+
+	if (!cblocks_size)
+		return 0;
+
+	do {
+		do_suspend = 0;
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
+			size = aio_ret = aio_return((struct aiocb*)cblocks[i]);
+			if (aio_ret < 0) {
+				if (aio_errno == EINTR) {
+					size = 0;
+				} else {
+					pr_err("failed to write perf data, error: %m\n");
+					cblocks[i] = NULL;
+					continue;
+				}
+			}
+			rec->bytes_written += size;
+			md = (struct perf_mmap*)((char*)cblocks[i] -
+				offsetof(struct perf_mmap, cblock));
+			rem = cblocks[i]->aio_nbytes - (size_t)size;
+			if (rem == 0) {
+				perf_mmap__put(md);
+				cblocks[i] = NULL;
+				if (switch_output_size(rec))
+					trigger_hit(&switch_output_trigger);
+			} else {
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
@@ -546,14 +620,17 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
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
@@ -563,6 +640,10 @@ static int record__mmap_read_evlist(struct record *rec, struct perf_evlist *evli
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
index e71d46cb01cc..c8b921c88a5d 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -292,11 +292,11 @@ int perf_mmap__read_init(struct perf_mmap *map)
 }
 
 int perf_mmap__push(struct perf_mmap *md, void *to,
-		    int push(void *to, void *buf, size_t size))
+		    int push(void *to, void *buf, size_t size, off_t), off_t *off)
 {
 	u64 head = perf_mmap__read_head(md);
 	unsigned char *data = md->base + page_size;
-	unsigned long size;
+	unsigned long size, size0 = 0;
 	void *buf;
 	int rc = 0;
 
@@ -308,23 +308,22 @@ int perf_mmap__push(struct perf_mmap *md, void *to,
 
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
+	perf_mmap__get(md);
+	*off += size0 + size;
 
 	md->prev = head;
 	perf_mmap__consume(md);
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index 1974e621e36b..6211a3a0c4c3 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -95,7 +95,7 @@ union perf_event *perf_mmap__read_forward(struct perf_mmap *map);
 union perf_event *perf_mmap__read_event(struct perf_mmap *map);
 
 int perf_mmap__push(struct perf_mmap *md, void *to,
-		    int push(void *to, void *buf, size_t size));
+		    int push(void *to, void *buf, size_t size, off_t off), off_t *off);
 
 size_t perf_mmap__mmap_len(struct perf_mmap *map);
 
