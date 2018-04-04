Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755290AbeDDCXn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 22:23:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:36778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755221AbeDDCXg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 22:23:36 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D2BF2178C
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
Subject: [PATCH 11/17] perf hists: Introduce hists__scnprint_title()
Date: Tue,  3 Apr 2018 23:21:52 -0300
Message-Id: <20180404022158.12190-12-acme@kernel.org>
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
-- 
2.14.3
