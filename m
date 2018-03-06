Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753246AbeCFGpC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 01:45:02 -0500
Received: from terminus.zytor.com ([198.137.202.136]:49093 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751028AbeCFGpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 01:45:01 -0500
Date: Mon, 5 Mar 2018 22:44:49 -0800
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-n3wd8n395uo4y9irst29pjic@git.kernel.org>
Cc: adrian.hunter@intel.com, jolsa@kernel.org, tglx@linutronix.de,
        acme@redhat.com, namhyung@kernel.org, wangnan0@huawei.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org, dsahern@gmail.com,
        mingo@kernel.org
Reply-To: mingo@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
        dsahern@gmail.com, wangnan0@huawei.com, namhyung@kernel.org,
        acme@redhat.com, tglx@linutronix.de, jolsa@kernel.org,
        adrian.hunter@intel.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf top browser: Show sample_freq in browser title
 line
Git-Commit-ID: a9980a6dbb9efd154b032ad729c869784302f361
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

Commit-ID:  a9980a6dbb9efd154b032ad729c869784302f361
Gitweb:     https://git.kernel.org/tip/a9980a6dbb9efd154b032ad729c869784302f361
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 1 Mar 2018 14:22:12 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 5 Mar 2018 09:58:43 -0300

perf top browser: Show sample_freq in browser title line

The '--stdio' 'perf top' UI shows it, so lets remove this UI difference
and show it too in '--tui', will be useful for 'perf top --tui -F max'.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-n3wd8n395uo4y9irst29pjic@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/hists.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 6495ee55d9c3..de2bde232cb3 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2223,7 +2223,7 @@ static int perf_evsel_browser_title(struct hist_browser *browser,
 	u64 nr_events = hists->stats.total_period;
 	struct perf_evsel *evsel = hists_to_evsel(hists);
 	const char *ev_name = perf_evsel__name(evsel);
-	char buf[512];
+	char buf[512], sample_freq_str[64] = "";
 	size_t buflen = sizeof(buf);
 	char ref[30] = " show reference callgraph, ";
 	bool enable_ref = false;
@@ -2255,10 +2255,14 @@ static int perf_evsel_browser_title(struct hist_browser *browser,
 	if (symbol_conf.show_ref_callgraph &&
 	    strstr(ev_name, "call-graph=no"))
 		enable_ref = true;
+
+	if (!is_report_browser(hbt))
+		scnprintf(sample_freq_str, sizeof(sample_freq_str), " %d Hz,", evsel->attr.sample_freq);
+
 	nr_samples = convert_unit(nr_samples, &unit);
 	printed = scnprintf(bf, size,
-			   "Samples: %lu%c of event '%s',%sEvent count (approx.): %" PRIu64,
-			   nr_samples, unit, ev_name, enable_ref ? ref : " ", nr_events);
+			   "Samples: %lu%c of event '%s',%s%sEvent count (approx.): %" PRIu64,
+			   nr_samples, unit, ev_name, sample_freq_str, enable_ref ? ref : " ", nr_events);
 
 
 	if (hists->uid_filter_str)
