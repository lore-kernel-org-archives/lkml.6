Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71E4CC04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34DE120C0A
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:56:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34DE120C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbeIMSGD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:06:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57918 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727972AbeIMSGC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:06:02 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 273A78666E;
        Thu, 13 Sep 2018 12:56:41 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4AE22600CD;
        Thu, 13 Sep 2018 12:56:39 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH 48/48] perf record: Spread maps for --threads=X option
Date:   Thu, 13 Sep 2018 14:54:50 +0200
Message-Id: <20180913125450.21342-49-jolsa@kernel.org>
In-Reply-To: <20180913125450.21342-1-jolsa@kernel.org>
References: <20180913125450.21342-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Thu, 13 Sep 2018 12:56:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This code allows to create arbitrary number of threads
and assign maps for it.

Each thread gets a fair share of the data maps plus the
main thread gets also to read tracking maps.

The assignment is visible from --thread-stats output
(for --threads=2 on 4 CPUs system):

        pid      write       poll       skip  maps (size 20K)
  1s   9318       144B          1          0   18K   19K   17K   19K   19K   19K
       9320        16K          3          3   19K   18K

There are 6 maps for thread 9318 (2 data maps and 4 auxiliary)
and 2 data maps for thread 9320. Each thread writes data to the
separate data file.

Link: http://lkml.kernel.org/n/tip-5myhg112a5mqv0ij0q7hky98@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-record.c | 103 ++++++++++++++++++++++++++++++++++--
 1 file changed, 98 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 4cc728174c79..6d3ce2ca8fbe 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -443,6 +443,33 @@ static void record__mmap_index_all(struct record *rec)
 	}
 }
 
+static void record__mmap_index_cnt(struct record *rec)
+{
+	struct perf_evlist *evlist = rec->evlist;
+	struct perf_data     *data = &rec->data;
+	int i, t;
+
+	for (i = 0; i < evlist->nr_mmaps; i++) {
+		struct perf_mmap *map = &evlist->track_mmap[i];
+
+		map->file = &data->file;
+	}
+
+	for (t = 0; t < rec->threads_cnt; t++) {
+		struct record_thread *th = rec->threads + t;
+		int nr = th->mmap_nr;
+
+		if (!t)
+			nr -= evlist->nr_mmaps;
+
+		for (i = 0; i < nr; i++) {
+			struct perf_mmap *map = th->mmap[i];
+
+			map->file = &data->index[t];
+		}
+	}
+}
+
 static int record__mmap_index(struct record *rec)
 {
 	struct perf_data *data = &rec->data;
@@ -456,6 +483,8 @@ static int record__mmap_index(struct record *rec)
 		record__mmap_index_all(rec);
 	else if (rec->threads_one)
 		record__mmap_index_single(rec);
+	else
+		record__mmap_index_cnt(rec);
 
 	return 0;
 }
@@ -1169,6 +1198,70 @@ record__threads_assign_all(struct record *rec)
 	return 0;
 }
 
+static int
+record__threads_assign_cnt(struct record *rec)
+{
+	struct record_thread *threads = rec->threads;
+	struct record_thread *thread0 = threads;
+	struct perf_evlist *evlist = rec->evlist;
+	int cnt = rec->threads_cnt;
+	int i, j, t, nr, nr_trk, nr_thr, nr_mod, n0 = 0;
+
+	nr     = evlist->mmap       ? evlist->nr_mmaps : 0;
+	nr_trk = evlist->track_mmap ? evlist->nr_mmaps : 0;
+
+	nr_thr = nr / cnt;
+	nr_mod = nr % cnt;
+
+	/*
+	 * Create threads' mmaps first..
+	 */
+	for (t = 0; t < cnt; t++) {
+		struct record_thread *th = threads + t;
+		int n = nr_thr;
+
+		/* evenly spread the remainder of threads */
+		n += (nr_mod-- > 0) ? 1 : 0;
+
+		/* first thread deals with track mmaps */
+		if (!t) {
+			n0 = n;
+			n += nr_trk;
+		}
+
+		if (record_thread__mmap(th, n, 0))
+			return -ENOMEM;
+	}
+
+	/*
+	 *  ... and assign mmaps separatelly.
+	 */
+
+	j = 0; /* mmap in evlist->mmap */
+	i = 0; /* mmap in thread    */
+
+	while (1) {
+		for (t = 0; t < cnt; t++) {
+			struct record_thread *th = threads + t;
+
+			if (i == th->mmap_nr)
+				continue;
+
+			th->mmap[i] = &evlist->mmap[j++];
+
+			if (j == nr)
+				goto out;
+		}
+		i++;
+	}
+out:
+	/* Assign track maps to thread 0. */
+	for (i = n0, j = 0; j < nr_trk && i < thread0->mmap_nr; i++, j++)
+		thread0->mmap[i] = &evlist->track_mmap[j];
+
+	return 0;
+}
+
 static int
 record__threads_assign(struct record *rec)
 {
@@ -1177,7 +1270,7 @@ record__threads_assign(struct record *rec)
 	else if (rec->threads_one)
 		return record__threads_assign_single(rec);
 	else
-		return -EINVAL;
+		return record__threads_assign_cnt(rec);
 }
 
 static int
@@ -1242,15 +1335,15 @@ static int record__threads_cnt(struct record *rec)
 
 	if (rec->threads_set) {
 		if (rec->threads_cnt) {
-			pr_err("failed: Can't specify number of threads yet.\n");
-			return -EINVAL;
+			cnt = rec->threads_cnt;
+		} else {
+			cnt = evlist->nr_mmaps;
+			all = true;
 		}
 		if (evlist->overwrite_mmap) {
 			pr_err("failed: Can't use multiple threads with overwrite mmaps yet.\n");
 			return -EINVAL;
 		}
-		cnt = evlist->nr_mmaps;
-		all = true;
 	} else {
 		one = true;
 		cnt = 1;
-- 
2.17.1

