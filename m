Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755482AbeDDCZP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 22:25:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:36806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753733AbeDDCXl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 22:23:41 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A629B217CE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        =?UTF-8?q?Martin=20Li=C5=A1ka?= <mliska@suse.cz>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 12/17] perf hists: Move hists__scnprintf_title() away from the TUI code
Date: Tue,  3 Apr 2018 23:21:53 -0300
Message-Id: <20180404022158.12190-13-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180404022158.12190-1-acme@kernel.org>
References: <20180404022158.12190-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The previous patch made this function useful to non-TUI parts of the
tools, but left it where the function from what it was carved, so that
the patch showed more clearly the process.

Now just move it outside the TUI parts so that we can finally use it,
even when the TUI code doesn't get built/linked.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Martin Liška <mliska@suse.cz>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=196935
Link: https://lkml.kernel.org/n/tip-hqj7hvcr3mu5lvcqp3cssio6@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/hists.c | 79 ----------------------------------------
 tools/perf/util/hist.c         | 81 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 81 insertions(+), 79 deletions(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index c20f0ad22f34..cde9bab5061d 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2208,85 +2208,6 @@ static inline bool is_report_browser(void *timer)
 	return timer == NULL;
 }
 
-int __hists__scnprintf_title(struct hists *hists, char *bf, size_t size, bool show_freq)
-{
-	char unit;
-	int printed;
-	const struct dso *dso = hists->dso_filter;
-	const struct thread *thread = hists->thread_filter;
-	int socket_id = hists->socket_filter;
-	unsigned long nr_samples = hists->stats.nr_events[PERF_RECORD_SAMPLE];
-	u64 nr_events = hists->stats.total_period;
-	struct perf_evsel *evsel = hists_to_evsel(hists);
-	const char *ev_name = perf_evsel__name(evsel);
-	char buf[512], sample_freq_str[64] = "";
-	size_t buflen = sizeof(buf);
-	char ref[30] = " show reference callgraph, ";
-	bool enable_ref = false;
-
-	if (symbol_conf.filter_relative) {
-		nr_samples = hists->stats.nr_non_filtered_samples;
-		nr_events = hists->stats.total_non_filtered_period;
-	}
-
-	if (perf_evsel__is_group_event(evsel)) {
-		struct perf_evsel *pos;
-
-		perf_evsel__group_desc(evsel, buf, buflen);
-		ev_name = buf;
-
-		for_each_group_member(pos, evsel) {
-			struct hists *pos_hists = evsel__hists(pos);
-
-			if (symbol_conf.filter_relative) {
-				nr_samples += pos_hists->stats.nr_non_filtered_samples;
-				nr_events += pos_hists->stats.total_non_filtered_period;
-			} else {
-				nr_samples += pos_hists->stats.nr_events[PERF_RECORD_SAMPLE];
-				nr_events += pos_hists->stats.total_period;
-			}
-		}
-	}
-
-	if (symbol_conf.show_ref_callgraph &&
-	    strstr(ev_name, "call-graph=no"))
-		enable_ref = true;
-
-	if (show_freq)
-		scnprintf(sample_freq_str, sizeof(sample_freq_str), " %d Hz,", evsel->attr.sample_freq);
-
-	nr_samples = convert_unit(nr_samples, &unit);
-	printed = scnprintf(bf, size,
-			   "Samples: %lu%c of event%s '%s',%s%sEvent count (approx.): %" PRIu64,
-			   nr_samples, unit, evsel->nr_members > 1 ? "s" : "",
-			   ev_name, sample_freq_str, enable_ref ? ref : " ", nr_events);
-
-
-	if (hists->uid_filter_str)
-		printed += snprintf(bf + printed, size - printed,
-				    ", UID: %s", hists->uid_filter_str);
-	if (thread) {
-		if (hists__has(hists, thread)) {
-			printed += scnprintf(bf + printed, size - printed,
-				    ", Thread: %s(%d)",
-				     (thread->comm_set ? thread__comm_str(thread) : ""),
-				    thread->tid);
-		} else {
-			printed += scnprintf(bf + printed, size - printed,
-				    ", Thread: %s",
-				     (thread->comm_set ? thread__comm_str(thread) : ""));
-		}
-	}
-	if (dso)
-		printed += scnprintf(bf + printed, size - printed,
-				    ", DSO: %s", dso->short_name);
-	if (socket_id > -1)
-		printed += scnprintf(bf + printed, size - printed,
-				    ", Processor Socket: %d", socket_id);
-
-	return printed;
-}
-
 static int hists_browser__scnprintf_title(struct hist_browser *browser, char *bf, size_t size)
 {
 	struct hist_browser_timer *hbt = browser->hbt;
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 7d968892ee39..4d602fba40b2 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -6,6 +6,7 @@
 #include "session.h"
 #include "namespaces.h"
 #include "sort.h"
+#include "units.h"
 #include "evlist.h"
 #include "evsel.h"
 #include "annotate.h"
@@ -14,6 +15,7 @@
 #include "ui/progress.h"
 #include <errno.h>
 #include <math.h>
+#include <inttypes.h>
 #include <sys/param.h>
 
 static bool hists__filter_entry_by_dso(struct hists *hists,
@@ -2454,6 +2456,85 @@ u64 hists__total_period(struct hists *hists)
 		hists->stats.total_period;
 }
 
+int __hists__scnprintf_title(struct hists *hists, char *bf, size_t size, bool show_freq)
+{
+	char unit;
+	int printed;
+	const struct dso *dso = hists->dso_filter;
+	const struct thread *thread = hists->thread_filter;
+	int socket_id = hists->socket_filter;
+	unsigned long nr_samples = hists->stats.nr_events[PERF_RECORD_SAMPLE];
+	u64 nr_events = hists->stats.total_period;
+	struct perf_evsel *evsel = hists_to_evsel(hists);
+	const char *ev_name = perf_evsel__name(evsel);
+	char buf[512], sample_freq_str[64] = "";
+	size_t buflen = sizeof(buf);
+	char ref[30] = " show reference callgraph, ";
+	bool enable_ref = false;
+
+	if (symbol_conf.filter_relative) {
+		nr_samples = hists->stats.nr_non_filtered_samples;
+		nr_events = hists->stats.total_non_filtered_period;
+	}
+
+	if (perf_evsel__is_group_event(evsel)) {
+		struct perf_evsel *pos;
+
+		perf_evsel__group_desc(evsel, buf, buflen);
+		ev_name = buf;
+
+		for_each_group_member(pos, evsel) {
+			struct hists *pos_hists = evsel__hists(pos);
+
+			if (symbol_conf.filter_relative) {
+				nr_samples += pos_hists->stats.nr_non_filtered_samples;
+				nr_events += pos_hists->stats.total_non_filtered_period;
+			} else {
+				nr_samples += pos_hists->stats.nr_events[PERF_RECORD_SAMPLE];
+				nr_events += pos_hists->stats.total_period;
+			}
+		}
+	}
+
+	if (symbol_conf.show_ref_callgraph &&
+	    strstr(ev_name, "call-graph=no"))
+		enable_ref = true;
+
+	if (show_freq)
+		scnprintf(sample_freq_str, sizeof(sample_freq_str), " %d Hz,", evsel->attr.sample_freq);
+
+	nr_samples = convert_unit(nr_samples, &unit);
+	printed = scnprintf(bf, size,
+			   "Samples: %lu%c of event%s '%s',%s%sEvent count (approx.): %" PRIu64,
+			   nr_samples, unit, evsel->nr_members > 1 ? "s" : "",
+			   ev_name, sample_freq_str, enable_ref ? ref : " ", nr_events);
+
+
+	if (hists->uid_filter_str)
+		printed += snprintf(bf + printed, size - printed,
+				    ", UID: %s", hists->uid_filter_str);
+	if (thread) {
+		if (hists__has(hists, thread)) {
+			printed += scnprintf(bf + printed, size - printed,
+				    ", Thread: %s(%d)",
+				     (thread->comm_set ? thread__comm_str(thread) : ""),
+				    thread->tid);
+		} else {
+			printed += scnprintf(bf + printed, size - printed,
+				    ", Thread: %s",
+				     (thread->comm_set ? thread__comm_str(thread) : ""));
+		}
+	}
+	if (dso)
+		printed += scnprintf(bf + printed, size - printed,
+				    ", DSO: %s", dso->short_name);
+	if (socket_id > -1)
+		printed += scnprintf(bf + printed, size - printed,
+				    ", Processor Socket: %d", socket_id);
+
+	return printed;
+}
+
 int parse_filter_percentage(const struct option *opt __maybe_unused,
 			    const char *arg, int unset __maybe_unused)
 {
-- 
2.14.3
