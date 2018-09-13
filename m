Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47246C61CF0
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CA9420854
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 12:56:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CA9420854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728655AbeIMSF6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 14:05:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58620 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726741AbeIMSF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 14:05:57 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C9B37811C0;
        Thu, 13 Sep 2018 12:56:36 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.10])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EF425600C8;
        Thu, 13 Sep 2018 12:56:34 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andi Kleen <andi@firstfloor.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>
Subject: [PATCH 46/48] perf record: Add maps to --thread-stats output
Date:   Thu, 13 Sep 2018 14:54:48 +0200
Message-Id: <20180913125450.21342-47-jolsa@kernel.org>
In-Reply-To: <20180913125450.21342-1-jolsa@kernel.org>
References: <20180913125450.21342-1-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 13 Sep 2018 12:56:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Display free size of thread's memory maps as part
of --thread-stats output.

  $ perf --debug threads=2 record ...
  ...
            pid      write       poll       skip  maps (size 20K)
      1s   8914       136B          1          0   19K   19K   19K   19K
      2s   8914       512K         43         79   19K   19K   17K   19K
      3s   8914         3M        214        385   17K   16K   16K   17K
      4s   8914         3M        121        291   17K   17K   18K   18K
   ...

Link: http://lkml.kernel.org/n/tip-4id1fjlu5ypfqnu9kvpo7l3z@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/builtin-record.c | 37 +++++++++++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index ec487d1f2b0b..92ba4d83b18c 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1306,10 +1306,25 @@ static int record__threads_stop(struct record *rec)
 	return err;
 }
 
-static void record_thread__display(struct record_thread *t, unsigned long s)
+/* Stolen from kernel. */
+#define CIRC_CNT(head, tail, size)    (((head) - (tail)) & ((size) - 1))
+#define CIRC_SPACE(head, tail, size)  CIRC_CNT((tail), ((head)+1), (size))
+
+static u64 mmap_free_size(struct perf_mmap *map, struct perf_evlist *evlist)
+{
+	u64 head = perf_mmap__read_head(map);
+	u64 tail = perf_mmap__read_tail(map);
+
+	return CIRC_SPACE(head, tail, evlist->mmap_len);
+}
+
+static void
+record_thread__display(struct record_thread *t, struct perf_evlist *evlist,
+		       unsigned long s)
 {
 	char buf_size[20];
 	char buf_time[20];
+	int i;
 
 	unit_number__scnprintf(buf_size, sizeof(buf_size), t->stats.bytes_written);
 
@@ -1318,15 +1333,26 @@ static void record_thread__display(struct record_thread *t, unsigned long s)
 	else
 		buf_time[0] = 0;
 
-	fprintf(stderr, "%6s %6d %10s %10" PRIu64" %10" PRIu64"\n",
+	fprintf(stderr, "%6s %6d %10s %10" PRIu64" %10" PRIu64 " ",
 		buf_time, t->pid, buf_size, t->stats.poll, t->stats.poll_skip);
+
+	for (i = 0; i < t->mmap_nr; i++) {
+		u64 size = mmap_free_size(t->mmap[i], evlist);
+
+		unit_number__scnprintf(buf_size, sizeof(buf_size), size);
+		fprintf(stderr, "%5s ", buf_size);
+	}
+
+	fprintf(stderr, "\n");
 }
 
 static void record__threads_stats(struct record *rec)
 {
 	struct record_thread *threads = rec->threads;
+	struct perf_evlist *evlist = rec->evlist;
 	static time_t last, last_header, start;
 	time_t current = time(NULL);
+	char buf_size[20];
 	int i;
 
 	if (last == current)
@@ -1337,15 +1363,18 @@ static void record__threads_stats(struct record *rec)
 
 	last = current;
 
+	unit_number__scnprintf(buf_size, sizeof(buf_size), evlist->mmap_len);
+
 	if (!last_header || (last_header + 10 < current)) {
-		fprintf(stderr, "%6s %6s %10s %10s %10s\n", " ", "pid", "write", "poll", "skip");
+		fprintf(stderr, "%6s %6s %10s %10s %10s %5s (size %s)\n",
+			" ", "pid", "write", "poll", "skip", "maps", buf_size);
 		last_header = current;
 	}
 
 	for (i = 0; i < rec->threads_cnt; i++) {
 		struct record_thread *t = threads + i;
 
-		record_thread__display(t, !i ? current - start : 0);
+		record_thread__display(t, evlist, !i ? current - start : 0);
 		memset(&t->stats, 0, sizeof(t->stats));
 	}
 }
-- 
2.17.1

