Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935169AbeBMMTI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 07:19:08 -0500
Received: from terminus.zytor.com ([198.137.202.136]:57833 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934918AbeBMMTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 07:19:06 -0500
Date: Tue, 13 Feb 2018 04:08:44 -0800
From: tip-bot for Kan Liang <tipbot@zytor.com>
Message-ID: <tip-e6b33238e03466ca9b096368226f29fb4aec627a@git.kernel.org>
Cc: mingo@kernel.org, ak@linux.intel.com, yao.jin@linux.intel.com,
        peterz@infradead.org, jolsa@kernel.org, tglx@linutronix.de,
        namhyung@kernel.org, wangnan0@huawei.com, kan.liang@intel.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org, acme@redhat.com
Reply-To: jolsa@kernel.org, tglx@linutronix.de, namhyung@kernel.org,
        wangnan0@huawei.com, mingo@kernel.org, ak@linux.intel.com,
        yao.jin@linux.intel.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, acme@redhat.com, kan.liang@intel.com,
        hpa@zytor.com
In-Reply-To: <1516310792-208685-12-git-send-email-kan.liang@intel.com>
References: <1516310792-208685-12-git-send-email-kan.liang@intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf top: Check per-event overwrite term
Git-Commit-ID: e6b33238e03466ca9b096368226f29fb4aec627a
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

Commit-ID:  e6b33238e03466ca9b096368226f29fb4aec627a
Gitweb:     https://git.kernel.org/tip/e6b33238e03466ca9b096368226f29fb4aec627a
Author:     Kan Liang <kan.liang@intel.com>
AuthorDate: Thu, 18 Jan 2018 13:26:26 -0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 6 Feb 2018 10:11:50 -0300

perf top: Check per-event overwrite term

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
index c6ccda5..1778379 100644
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
