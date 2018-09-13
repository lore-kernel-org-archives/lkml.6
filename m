Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C0BDC07520
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:56:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FFC320854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:56:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FFC320854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbeIMSGD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:06:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53914 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727231AbeIMSGA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:06:00 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id F0C9530B8F89;
        Thu, 13 Sep 2018 12:56:38 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1F202600C8;
        Thu, 13 Sep 2018 12:56:36 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH 47/48] perf record: Spread maps for --threads option
Date:   Thu, 13 Sep 2018 14:54:49 +0200
Message-Id: <20180913125450.21342-48-jolsa@kernel.org>
In-Reply-To: <20180913125450.21342-1-jolsa@kernel.org>
References: <20180913125450.21342-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Thu, 13 Sep 2018 12:56:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we assign all maps to main thread. Adding
code that spreads maps for --threads option.

For --thread option we create as many threads as there
are memory maps in evlist, which is the number of CPUs
in the system or CPUs we monitor. Each thread gets a
single data mmap to read.

In addition we have also same amount of tracking mmaps
for auxiliary events which we don't create special thread
for. Instead we assign the to the main thread, because
there's not much traffic expected there.

The assignment is visible from --thread-stats output:

          pid      write       poll       skip  maps (size 20K)
    1s   9770       144B          1          0   19K   19K   19K   18K   19K
         9772         0B          1          0   18K
         9773         0B          1          0   19K
         9774         0B          1          0   19K

There are 5 maps for thread 9770 (1 data map and 4 auxiliary)
and one data map for every other thread. Each thread writes
data to the separate data file.

In addition we also pin every thread to the cpu that
the data map belongs to in order to keep both writer
(kernel) and reader (perf tool thread) on the same CPU.

Link: http://lkml.kernel.org/n/tip-ghcsnp3b73innq2gkl1lkfbz@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-record.c | 133 +++++++++++++++++++++++++++++++++---
 1 file changed, 125 insertions(+), 8 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 92ba4d83b18c..4cc728174c79 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -109,6 +109,8 @@ struct record {
 	struct switch_output	switch_output;
 	unsigned long long	samples;
 	struct record_thread	*threads;
+	bool			threads_all;
+	bool			threads_one;
 	int			threads_cnt;
 	bool			threads_set;
 	int			threads_signal_cnt;
@@ -393,15 +395,11 @@ static int record__mmap_evlist(struct record *rec,
 	return 0;
 }
 
-static int record__mmap_index(struct record *rec)
+static void record__mmap_index_single(struct record *rec)
 {
 	struct perf_evlist *evlist = rec->evlist;
 	struct perf_data *data = &rec->data;
-	int i, ret, nr = evlist->nr_mmaps;
-
-	ret = perf_data__create_index(data, nr);
-	if (ret)
-		return ret;
+	int i, nr = evlist->nr_mmaps;
 
 	for (i = 0; i < nr; i++) {
 		struct perf_mmap *map = &evlist->mmap[i];
@@ -414,6 +412,50 @@ static int record__mmap_index(struct record *rec)
 
 		map->file = &data->file;
 	}
+}
+
+static void record__mmap_index_all(struct record *rec)
+{
+	struct perf_evlist *evlist = rec->evlist;
+	struct perf_data     *data = &rec->data;
+	struct record_thread *threads = rec->threads;
+	struct record_thread *thread0 = threads;
+	int i, t;
+
+	BUG_ON(data->index_nr != rec->threads_cnt);
+
+	for (i = 0; i < evlist->nr_mmaps; i++) {
+		struct perf_mmap *map = &evlist->track_mmap[i];
+
+		map->file = &data->file;
+	}
+
+	thread0->mmap[0]->file = &data->index[0];
+
+	for (t = 1; t < rec->threads_cnt; t++) {
+		struct record_thread *th = threads + t;
+
+		for (i = 0; i < th->mmap_nr; i++) {
+			struct perf_mmap *map = th->mmap[i];
+
+			map->file = &data->index[t];
+		}
+	}
+}
+
+static int record__mmap_index(struct record *rec)
+{
+	struct perf_data *data = &rec->data;
+	int ret;
+
+	ret = perf_data__create_index(data, rec->threads_cnt);
+	if (ret)
+		return ret;
+
+	if (rec->threads_all)
+		record__mmap_index_all(rec);
+	else if (rec->threads_one)
+		record__mmap_index_single(rec);
 
 	return 0;
 }
@@ -1056,7 +1098,7 @@ record_thread__mmap(struct record_thread *th, int nr, int nr_ovw)
 }
 
 static int
-record__threads_assign(struct record *rec)
+record__threads_assign_single(struct record *rec)
 {
 	struct record_thread *threads = rec->threads;
 	struct record_thread *thread0 = threads;
@@ -1089,6 +1131,55 @@ record__threads_assign(struct record *rec)
 	return ret;
 }
 
+static int
+record__threads_assign_all(struct record *rec)
+{
+	struct perf_evlist *evlist = rec->evlist;
+	struct record_thread *threads = rec->threads;
+	struct record_thread *thread0 = threads;
+	int cnt = rec->threads_cnt;
+	int i, t, nr, nr0, nr_trk;
+	int nr_cpus = cpu__max_present_cpu();
+
+	nr     = evlist->mmap       ? evlist->nr_mmaps : 0;
+	nr_trk = evlist->track_mmap ? evlist->nr_mmaps : 0;
+
+	BUG_ON(evlist->overwrite_mmap);
+	BUG_ON(nr_cpus != nr);
+
+	nr0 = 1 + nr_trk;
+
+	if (record_thread__mmap(thread0, nr0, 0))
+		return -ENOMEM;
+
+	thread0->mmap[0] = &evlist->mmap[0];
+
+	for (i = 0; i < nr_trk; i++)
+		thread0->mmap[i + 1] = &evlist->track_mmap[i];
+
+	for (t = 1; t < cnt; t++) {
+		struct record_thread *th = threads + t;
+
+		if (record_thread__mmap(th, 1, 0))
+			return -ENOMEM;
+
+		th->mmap[0] = &evlist->mmap[t];
+	}
+
+	return 0;
+}
+
+static int
+record__threads_assign(struct record *rec)
+{
+	if (rec->threads_all)
+		return record__threads_assign_all(rec);
+	else if (rec->threads_one)
+		return record__threads_assign_single(rec);
+	else
+		return -EINVAL;
+}
+
 static int
 record_thread__create_poll(struct record_thread *th,
 			   struct perf_evlist *evlist)
@@ -1146,7 +1237,8 @@ record__threads_create(struct record *rec)
 static int record__threads_cnt(struct record *rec)
 {
 	struct perf_evlist *evlist = rec->evlist;
-	int cnt;
+	bool all = false, one = false;
+	int cnt = 0;
 
 	if (rec->threads_set) {
 		if (rec->threads_cnt) {
@@ -1158,11 +1250,15 @@ static int record__threads_cnt(struct record *rec)
 			return -EINVAL;
 		}
 		cnt = evlist->nr_mmaps;
+		all = true;
 	} else {
+		one = true;
 		cnt = 1;
 	}
 
 	rec->threads_cnt = cnt;
+	rec->threads_all = all;
+	rec->threads_one = one;
 	return 0;
 }
 
@@ -1200,6 +1296,25 @@ static inline pid_t gettid(void)
 	return (pid_t) syscall(__NR_gettid);
 }
 
+static int set_affinity(int cpu)
+{
+	cpu_set_t mask;
+
+	CPU_ZERO(&mask);
+	CPU_SET(cpu, &mask);
+	return sched_setaffinity(0, sizeof(mask), &mask);
+}
+
+static void set_thread_affinity(struct record *rec)
+{
+	if (rec->threads_all) {
+		struct perf_mmap *m0 = thread->mmap[0];
+
+		if (set_affinity(m0->cpu))
+			pr_err("failed to set affinity for cpu %d\n", m0->cpu);
+	}
+}
+
 static void*
 record_thread__process(struct record *rec)
 {
@@ -1263,6 +1378,7 @@ static void *worker(void *arg)
 	thread->state = RECORD_THREAD__RUNNING;
 
 	signal_main(rec);
+	set_thread_affinity(rec);
 
 	return record_thread__process(rec);
 }
@@ -1283,6 +1399,7 @@ static int record__threads_start(struct record *rec)
 	if (rec->threads_cnt > 1)
 		wait_for_signal(rec);
 
+	set_thread_affinity(rec);
 	return err;
 }
 
-- 
2.17.1

