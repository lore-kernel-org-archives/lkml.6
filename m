Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752695AbeCEOax (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 09:30:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:52946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752615AbeCEOaj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 09:30:39 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88BE92178E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 10/28] perf top browser: Show sample_freq in browser title line
Date: Mon,  5 Mar 2018 11:29:14 -0300
Message-Id: <20180305142932.16921-11-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180305142932.16921-1-acme@kernel.org>
References: <20180305142932.16921-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
-- 
2.14.3
