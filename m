Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA2DC07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06DD720854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:56:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06DD720854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728636AbeIMSF5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:05:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58592 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726741AbeIMSF4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:05:56 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A7B6780F9B;
        Thu, 13 Sep 2018 12:56:34 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C7F29600CD;
        Thu, 13 Sep 2018 12:56:32 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH 45/48] perf record: Add --thread-stats option support
Date:   Thu, 13 Sep 2018 14:54:47 +0200
Message-Id: <20180913125450.21342-46-jolsa@kernel.org>
In-Reply-To: <20180913125450.21342-1-jolsa@kernel.org>
References: <20180913125450.21342-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 13 Sep 2018 12:56:34 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add per-thread stats to have an idea what's happening
in the main reading loop.

  $ perf --debug threads=2 record ...
  SNIP
            pid      write       poll       skip
      1s   8914       136B          1          0
      2s   8914       512K         43         79
      3s   8914         3M        214        385
      4s   8914         3M        121        291

  $ perf --debug threads=2 record --threads ...
  SNIP
            pid      write       poll       skip
     1s   9770       144B          1          0
          9772         0B          1          0
          9773         0B          1          0
          9774         0B          1          0
     2s   9770       290K         35         37
          9772       272K         36         34
          9773       274K         35         35
          9774       304K         39         39
     3s   9770      1120K        140        140
          9772      1088K        138        138
          9773      1120K        140        140
          9774      1123K        140        140
     4s   9770      1161K        146        146
          9772      1121K        142        142
          9773      1135K        142        142
          9774      1159K        145        145

Link: http://lkml.kernel.org/n/tip-z9un5mjzsh47u9m12ijn7pfq@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-record.c | 79 +++++++++++++++++++++++++++++++++++--
 1 file changed, 76 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index ada6f795d492..ec487d1f2b0b 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -70,7 +70,14 @@ enum {
 	RECORD_THREAD__STOP	= 1,
 };
 
+struct thread_stat {
+	u64	bytes_written;
+	u64	poll;
+	u64	poll_skip;
+};
+
 struct record_thread {
+	int			  pid;
 	struct perf_mmap	**mmap;
 	int			  mmap_nr;
 	struct perf_mmap	**ovw_mmap;
@@ -81,6 +88,7 @@ struct record_thread {
 	u64			  bytes_written;
 	pthread_t		  pt;
 	int			  state;
+	struct thread_stat	  stats;
 };
 
 struct record {
@@ -149,7 +157,8 @@ static int record__write(struct record *rec, struct perf_mmap *map,
 		return -1;
 	}
 
-	thread->bytes_written += size;
+	thread->bytes_written       += size;
+	thread->stats.bytes_written += size;
 
 	if (switch_output_size(rec))
 		trigger_hit(&switch_output_trigger);
@@ -1186,6 +1195,11 @@ record__threads_config(struct record *rec)
 	return ret;
 }
 
+static inline pid_t gettid(void)
+{
+	return (pid_t) syscall(__NR_gettid);
+}
+
 static void*
 record_thread__process(struct record *rec)
 {
@@ -1197,6 +1211,8 @@ record_thread__process(struct record *rec)
 			break;
 
 		if (hits == thread->samples) {
+			thread->stats.poll++;
+
 			err = fdarray__poll(&thread->pollfd, 500);
 			/*
 			 * Propagate error, only if there's any. Ignore positive
@@ -1209,6 +1225,8 @@ record_thread__process(struct record *rec)
 			if (fdarray__filter(&thread->pollfd, POLLERR|POLLHUP,
 					    perf_mmap__put_filtered, NULL) == 0)
 				break;
+		} else {
+			thread->stats.poll_skip++;
 		}
 	}
 
@@ -1241,6 +1259,7 @@ static void *worker(void *arg)
 	struct record *rec = th->rec;
 
 	thread        = th;
+	thread->pid   = gettid();
 	thread->state = RECORD_THREAD__RUNNING;
 
 	signal_main(rec);
@@ -1287,6 +1306,50 @@ static int record__threads_stop(struct record *rec)
 	return err;
 }
 
+static void record_thread__display(struct record_thread *t, unsigned long s)
+{
+	char buf_size[20];
+	char buf_time[20];
+
+	unit_number__scnprintf(buf_size, sizeof(buf_size), t->stats.bytes_written);
+
+	if (s)
+		scnprintf(buf_time, sizeof(buf_time), "%5lus", s);
+	else
+		buf_time[0] = 0;
+
+	fprintf(stderr, "%6s %6d %10s %10" PRIu64" %10" PRIu64"\n",
+		buf_time, t->pid, buf_size, t->stats.poll, t->stats.poll_skip);
+}
+
+static void record__threads_stats(struct record *rec)
+{
+	struct record_thread *threads = rec->threads;
+	static time_t last, last_header, start;
+	time_t current = time(NULL);
+	int i;
+
+	if (last == current)
+		return;
+
+	if (!start)
+		start = current - 1;
+
+	last = current;
+
+	if (!last_header || (last_header + 10 < current)) {
+		fprintf(stderr, "%6s %6s %10s %10s %10s\n", " ", "pid", "write", "poll", "skip");
+		last_header = current;
+	}
+
+	for (i = 0; i < rec->threads_cnt; i++) {
+		struct record_thread *t = threads + i;
+
+		record_thread__display(t, !i ? current - start : 0);
+		memset(&t->stats, 0, sizeof(t->stats));
+	}
+}
+
 static int __cmd_record(struct record *rec, int argc, const char **argv)
 {
 	int err;
@@ -1371,6 +1434,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	}
 
 	thread = &rec->threads[0];
+	thread->pid = gettid();
 
 	err = bpf__apply_obj_config();
 	if (err) {
@@ -1573,7 +1637,10 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		if (hits == thread->samples) {
 			if (done || draining)
 				break;
-			err = fdarray__poll(&thread->pollfd, -1);
+
+			err = fdarray__poll(&thread->pollfd, 1000);
+			thread->stats.poll++;
+
 			/*
 			 * Propagate error, only if there's any. Ignore positive
 			 * number of returned events and interrupt error.
@@ -1582,10 +1649,16 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 				err = 0;
 			rec->waking++;
 
-			if (perf_evlist__filter_pollfd(rec->evlist, POLLERR | POLLHUP) == 0)
+			if (fdarray__filter(&thread->pollfd, POLLERR|POLLHUP,
+					    perf_mmap__put_filtered, NULL) == 0)
 				draining = true;
+		} else {
+			thread->stats.poll_skip++;
 		}
 
+		if (debug_threads)
+			record__threads_stats(rec);
+
 		/*
 		 * When perf is starting the traced process, at the end events
 		 * die with the process and we wait for that. Thus no need to
-- 
2.17.1

