Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753171AbeBFQ5C (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 11:57:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:43192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753190AbeBFQyt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 11:54:49 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33E452172C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@intel.com>, Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Wang Nan <wangnan0@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 17/21] perf top: Switch default mode to overwrite mode
Date: Tue,  6 Feb 2018 13:53:46 -0300
Message-Id: <20180206165350.2570-18-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180206165350.2570-1-acme@kernel.org>
References: <20180206165350.2570-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@intel.com>

perf_top__mmap_read() has a severe performance issue in the Knights
Landing/Mill platform, when monitoring heavy load systems. It costs
several minutes to finish, which is unacceptable.

Currently, 'perf top' uses the non overwrite mode. For non overwrite
mode, it tries to read everything in the ringbuffer and doesn't pause
it. Once there are lots of samples delivered persistently, the
processing time could be very long. Also, the latest samples could be
lost when the ringbuffer is full.

For overwrite mode, it takes a snapshot for the system by pausing the
ringbuffer, which could significantly reduce the processing time.  Also,
the overwrite mode always keep the latest samples.  Considering the real
time requirement for 'perf top', the overwrite mode is more suitable for
it.

Actually, 'perf top' was overwrite mode. It is changed to non overwrite
mode since commit 93fc64f14472 ("perf top: Switch to non overwrite
mode"). It's better to change it back to overwrite mode by default.

For the kernel which doesn't support overwrite mode, it will fall back
to non overwrite mode.

There would be some records lost in overwrite mode because of pausing
the ringbuffer. It has little impact for the accuracy of the snapshot
and can be tolerated.

For overwrite mode, unconditionally wait 100 ms before each snapshot. It
also reduces the overhead caused by pausing ringbuffer, especially on
light load system.

Signed-off-by: Kan Liang <kan.liang@intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/1516310792-208685-17-git-send-email-kan.liang@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-top.c | 34 +++++++++++++++++++++++++---------
 1 file changed, 25 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 59653062bb48..2b4914f34ed6 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -809,15 +809,23 @@ static void perf_event__process_sample(struct perf_tool *tool,
 
 static void perf_top__mmap_read_idx(struct perf_top *top, int idx)
 {
+	struct record_opts *opts = &top->record_opts;
+	struct perf_evlist *evlist = top->evlist;
 	struct perf_sample sample;
 	struct perf_evsel *evsel;
+	struct perf_mmap *md;
 	struct perf_session *session = top->session;
 	union perf_event *event;
 	struct machine *machine;
+	u64 end, start;
 	int ret;
 
-	while ((event = perf_evlist__mmap_read(top->evlist, idx)) != NULL) {
-		ret = perf_evlist__parse_sample(top->evlist, event, &sample);
+	md = opts->overwrite ? &evlist->overwrite_mmap[idx] : &evlist->mmap[idx];
+	if (perf_mmap__read_init(md, opts->overwrite, &start, &end) < 0)
+		return;
+
+	while ((event = perf_mmap__read_event(md, opts->overwrite, &start, end)) != NULL) {
+		ret = perf_evlist__parse_sample(evlist, event, &sample);
 		if (ret) {
 			pr_err("Can't parse sample, err = %d\n", ret);
 			goto next_event;
@@ -871,16 +879,28 @@ static void perf_top__mmap_read_idx(struct perf_top *top, int idx)
 		} else
 			++session->evlist->stats.nr_unknown_events;
 next_event:
-		perf_evlist__mmap_consume(top->evlist, idx);
+		perf_mmap__consume(md, opts->overwrite);
 	}
+
+	perf_mmap__read_done(md);
 }
 
 static void perf_top__mmap_read(struct perf_top *top)
 {
+	bool overwrite = top->record_opts.overwrite;
+	struct perf_evlist *evlist = top->evlist;
 	int i;
 
+	if (overwrite)
+		perf_evlist__toggle_bkw_mmap(evlist, BKW_MMAP_DATA_PENDING);
+
 	for (i = 0; i < top->evlist->nr_mmaps; i++)
 		perf_top__mmap_read_idx(top, i);
+
+	if (overwrite) {
+		perf_evlist__toggle_bkw_mmap(evlist, BKW_MMAP_EMPTY);
+		perf_evlist__toggle_bkw_mmap(evlist, BKW_MMAP_RUNNING);
+	}
 }
 
 /*
@@ -979,11 +999,6 @@ static int perf_top__start_counters(struct perf_top *top)
 		goto out_err;
 	}
 
-	if (opts->overwrite) {
-		ui__error("not support overwrite mode yet\n");
-		goto out_err;
-	}
-
 	perf_evlist__config(evlist, opts, &callchain_param);
 
 	evlist__for_each_entry(evlist, counter) {
@@ -1144,7 +1159,7 @@ static int __cmd_top(struct perf_top *top)
 
 		perf_top__mmap_read(top);
 
-		if (hits == top->samples)
+		if (opts->overwrite || (hits == top->samples))
 			ret = perf_evlist__poll(top->evlist, 100);
 
 		if (resize) {
@@ -1238,6 +1253,7 @@ int cmd_top(int argc, const char **argv)
 				.uses_mmap   = true,
 			},
 			.proc_map_timeout    = 500,
+			.overwrite	= 1,
 		},
 		.max_stack	     = sysctl_perf_event_max_stack,
 		.sym_pcnt_filter     = 5,
-- 
2.14.3
