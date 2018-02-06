Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753115AbeBFQ4e (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 11:56:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:43062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752969AbeBFQyd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 11:54:33 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE3172172C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@intel.com>, Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Wang Nan <wangnan0@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 12/21] perf top: Check per-event overwrite term
Date: Tue,  6 Feb 2018 13:53:41 -0300
Message-Id: <20180206165350.2570-13-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180206165350.2570-1-acme@kernel.org>
References: <20180206165350.2570-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@intel.com>

Per-event overwrite term is not forbidden in 'perf top', which can bring
problems. Because 'perf top' only support non-overwrite mode now.

Add new rules and check regarding to overwrite term for 'perf top'.
- All events either have same per-event term or don't have per-event
  mode setting. Otherwise, it will error out.
- Per-event overwrite term should be consistent as opts->overwrite.
  If not, updating the opts->overwrite according to per-event term.

Make it possible to support either non-overwrite or overwrite mode.
The overwrite mode is forbidden now, which will be removed when the
overwrite mode is supported later.

Signed-off-by: Kan Liang <kan.liang@intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/1516310792-208685-12-git-send-email-kan.liang@intel.com
[ Renamed perf_top_overwrite_check to perf_top__overwrite_check, to follow existing convention ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-top.c | 73 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index c6ccda52117d..17783798924a 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -881,6 +881,68 @@ static void perf_top__mmap_read(struct perf_top *top)
 		perf_top__mmap_read_idx(top, i);
 }
 
+/*
+ * Check per-event overwrite term.
+ * perf top should support consistent term for all events.
+ * - All events don't have per-event term
+ *   E.g. "cpu/cpu-cycles/,cpu/instructions/"
+ *   Nothing change, return 0.
+ * - All events have same per-event term
+ *   E.g. "cpu/cpu-cycles,no-overwrite/,cpu/instructions,no-overwrite/
+ *   Using the per-event setting to replace the opts->overwrite if
+ *   they are different, then return 0.
+ * - Events have different per-event term
+ *   E.g. "cpu/cpu-cycles,overwrite/,cpu/instructions,no-overwrite/"
+ *   Return -1
+ * - Some of the event set per-event term, but some not.
+ *   E.g. "cpu/cpu-cycles/,cpu/instructions,no-overwrite/"
+ *   Return -1
+ */
+static int perf_top__overwrite_check(struct perf_top *top)
+{
+	struct record_opts *opts = &top->record_opts;
+	struct perf_evlist *evlist = top->evlist;
+	struct perf_evsel_config_term *term;
+	struct list_head *config_terms;
+	struct perf_evsel *evsel;
+	int set, overwrite = -1;
+
+	evlist__for_each_entry(evlist, evsel) {
+		set = -1;
+		config_terms = &evsel->config_terms;
+		list_for_each_entry(term, config_terms, list) {
+			if (term->type == PERF_EVSEL__CONFIG_TERM_OVERWRITE)
+				set = term->val.overwrite ? 1 : 0;
+		}
+
+		/* no term for current and previous event (likely) */
+		if ((overwrite < 0) && (set < 0))
+			continue;
+
+		/* has term for both current and previous event, compare */
+		if ((overwrite >= 0) && (set >= 0) && (overwrite != set))
+			return -1;
+
+		/* no term for current event but has term for previous one */
+		if ((overwrite >= 0) && (set < 0))
+			return -1;
+
+		/* has term for current event */
+		if ((overwrite < 0) && (set >= 0)) {
+			/* if it's first event, set overwrite */
+			if (evsel == perf_evlist__first(evlist))
+				overwrite = set;
+			else
+				return -1;
+		}
+	}
+
+	if ((overwrite >= 0) && (opts->overwrite != overwrite))
+		opts->overwrite = overwrite;
+
+	return 0;
+}
+
 static int perf_top__start_counters(struct perf_top *top)
 {
 	char msg[BUFSIZ];
@@ -888,6 +950,17 @@ static int perf_top__start_counters(struct perf_top *top)
 	struct perf_evlist *evlist = top->evlist;
 	struct record_opts *opts = &top->record_opts;
 
+	if (perf_top__overwrite_check(top)) {
+		ui__error("perf top only support consistent per-event "
+			  "overwrite setting for all events\n");
+		goto out_err;
+	}
+
+	if (opts->overwrite) {
+		ui__error("not support overwrite mode yet\n");
+		goto out_err;
+	}
+
 	perf_evlist__config(evlist, opts, &callchain_param);
 
 	evlist__for_each_entry(evlist, counter) {
-- 
2.14.3
