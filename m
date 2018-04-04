Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753342AbeDDFea (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 01:34:30 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54525 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751510AbeDDFe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 01:34:28 -0400
Date: Tue, 3 Apr 2018 22:34:15 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-hqj7hvcr3mu5lvcqp3cssio6@git.kernel.org>
Cc: tglx@linutronix.de, namhyung@kernel.org, jolsa@kernel.org,
        hpa@zytor.com, wangnan0@huawei.com, dsahern@gmail.com, acme@redhat.com,
        mingo@kernel.org, mliska@suse.cz, linux-kernel@vger.kernel.org,
        adrian.hunter@intel.com
Reply-To: mliska@suse.cz, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org, acme@redhat.com,
        dsahern@gmail.com, wangnan0@huawei.com, hpa@zytor.com,
        jolsa@kernel.org, namhyung@kernel.org, tglx@linutronix.de
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf hists: Move hists__scnprintf_title() away
 from the TUI code
Git-Commit-ID: 25c312dbf88ca402bf47389c5aa4f1552799a8ca
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

Commit-ID:  25c312dbf88ca402bf47389c5aa4f1552799a8ca
Gitweb:     https://git.kernel.org/tip/25c312dbf88ca402bf47389c5aa4f1552799a8ca
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 2 Apr 2018 14:24:28 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 3 Apr 2018 10:23:32 -0300

perf hists: Move hists__scnprintf_title() away from the TUI code

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
