Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935112AbeBMMVW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 07:21:22 -0500
Received: from terminus.zytor.com ([198.137.202.136]:40923 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934827AbeBMMVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 07:21:20 -0500
Date: Tue, 13 Feb 2018 04:10:54 -0800
From: tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-73508fab8d06316e4dbd6cccfc9fcb21dde677b7@git.kernel.org>
Cc: peterz@infradead.org, namhyung@kernel.org, mingo@kernel.org,
        ak@linux.intel.com, tglx@linutronix.de, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com, kan.liang@intel.com,
        acme@redhat.com, wangnan0@huawei.com, yao.jin@linux.intel.com
Reply-To: tglx@linutronix.de, ak@linux.intel.com, hpa@zytor.com,
        jolsa@kernel.org, linux-kernel@vger.kernel.org, kan.liang@intel.com,
        yao.jin@linux.intel.com, acme@redhat.com, wangnan0@huawei.com,
        peterz@infradead.org, mingo@kernel.org, namhyung@kernel.org
In-Reply-To: <1516310792-208685-17-git-send-email-kan.liang@intel.com>
References: <1516310792-208685-17-git-send-email-kan.liang@intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf top: Switch default mode to overwrite mode
Git-Commit-ID: 73508fab8d06316e4dbd6cccfc9fcb21dde677b7
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  73508fab8d06316e4dbd6cccfc9fcb21dde677b7
Gitweb:     https://git.kernel.org/tip/73508fab8d06316e4dbd6cccfc9fcb21dde677b7
Author:     Kan Liang <kan.liang@intel.com>
AuthorDate: Thu, 18 Jan 2018 13:26:31 -0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 6 Feb 2018 10:11:51 -0300

perf top: Switch default mode to overwrite mode

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
index 5965306..2b4914f 100644
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
