Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753333AbeDDFeE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 01:34:04 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40465 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750778AbeDDFeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 01:34:00 -0400
Date: Tue, 3 Apr 2018 22:33:46 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-w8mczjnqnbcj9yzfkv9ja6ro@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, dsahern@gmail.com, acme@redhat.com,
        tglx@linutronix.de, mingo@kernel.org, wangnan0@huawei.com,
        mliska@suse.cz, namhyung@kernel.org, hpa@zytor.com,
        adrian.hunter@intel.com, jolsa@kernel.org
Reply-To: adrian.hunter@intel.com, jolsa@kernel.org, hpa@zytor.com,
        wangnan0@huawei.com, mingo@kernel.org, mliska@suse.cz,
        namhyung@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        dsahern@gmail.com, acme@redhat.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf hists: Introduce hists__scnprint_title()
Git-Commit-ID: 967a464a7e6d939f0b0dbb4ee41bd3d515fa9a6d
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

Commit-ID:  967a464a7e6d939f0b0dbb4ee41bd3d515fa9a6d
Gitweb:     https://git.kernel.org/tip/967a464a7e6d939f0b0dbb4ee41bd3d515fa9a6d
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 2 Apr 2018 14:20:20 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 3 Apr 2018 10:23:18 -0300

perf hists: Introduce hists__scnprint_title()

That is not use any struct hists_browser internals, so that it can be
shared with the other UIs and tools.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Martin Liška <mliska@suse.cz>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=196935
Link: https://lkml.kernel.org/n/tip-w8mczjnqnbcj9yzfkv9ja6ro@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/hists.c | 15 +++++++++++----
 tools/perf/util/hist.h         |  6 ++++++
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 2ac66011354f..c20f0ad22f34 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2208,10 +2208,8 @@ static inline bool is_report_browser(void *timer)
 	return timer == NULL;
 }
 
-static int hists_browser__scnprintf_title(struct hist_browser *browser, char *bf, size_t size)
+int __hists__scnprintf_title(struct hists *hists, char *bf, size_t size, bool show_freq)
 {
-	struct hist_browser_timer *hbt = browser->hbt;
-	struct hists *hists = browser->hists;
 	char unit;
 	int printed;
 	const struct dso *dso = hists->dso_filter;
@@ -2254,7 +2252,7 @@ static int hists_browser__scnprintf_title(struct hist_browser *browser, char *bf
 	    strstr(ev_name, "call-graph=no"))
 		enable_ref = true;
 
-	if (!is_report_browser(hbt))
+	if (show_freq)
 		scnprintf(sample_freq_str, sizeof(sample_freq_str), " %d Hz,", evsel->attr.sample_freq);
 
 	nr_samples = convert_unit(nr_samples, &unit);
@@ -2285,6 +2283,15 @@ static int hists_browser__scnprintf_title(struct hist_browser *browser, char *bf
 	if (socket_id > -1)
 		printed += scnprintf(bf + printed, size - printed,
 				    ", Processor Socket: %d", socket_id);
+
+	return printed;
+}
+
+static int hists_browser__scnprintf_title(struct hist_browser *browser, char *bf, size_t size)
+{
+	struct hist_browser_timer *hbt = browser->hbt;
+	int printed = __hists__scnprintf_title(browser->hists, bf, size, !is_report_browser(hbt));
+
 	if (!is_report_browser(hbt)) {
 		struct perf_top *top = hbt->arg;
 
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 32fbf26e0c18..fbabfd8a215d 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -504,5 +504,11 @@ int __hpp__slsmg_color_printf(struct perf_hpp *hpp, const char *fmt, ...);
 int __hist_entry__snprintf(struct hist_entry *he, struct perf_hpp *hpp,
 			   struct perf_hpp_list *hpp_list);
 int hists__fprintf_headers(struct hists *hists, FILE *fp);
+int __hists__scnprintf_title(struct hists *hists, char *bf, size_t size, bool show_freq);
+
+static inline int hists__scnprintf_title(struct hists *hists, char *bf, size_t size)
+{
+	return __hists__scnprintf_title(hists, bf, size, true);
+}
 
 #endif	/* __PERF_HIST_H */
