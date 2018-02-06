Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753344AbeBFRDz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 12:03:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:43118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753065AbeBFQyj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 11:54:39 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1E452178F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@intel.com>, Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>, Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Wang Nan <wangnan0@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 14/21] perf top: Add overwrite fall back
Date: Tue,  6 Feb 2018 13:53:43 -0300
Message-Id: <20180206165350.2570-15-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180206165350.2570-1-acme@kernel.org>
References: <20180206165350.2570-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@intel.com>

Switch to non-overwrite mode if kernel doesnot support overwrite
ringbuffer.

It's only effect when overwrite mode is supported.  No change to current
behavior.

Signed-off-by: Kan Liang <kan.liang@intel.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/1516310792-208685-14-git-send-email-kan.liang@intel.com
[ Use perf_missing_features.write_backward instead of the non merged is_write_backward_fail() ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-top.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 17783798924a..ee4bba1e282c 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -943,6 +943,27 @@ static int perf_top__overwrite_check(struct perf_top *top)
 	return 0;
 }
 
+static int perf_top_overwrite_fallback(struct perf_top *top,
+				       struct perf_evsel *evsel)
+{
+	struct record_opts *opts = &top->record_opts;
+	struct perf_evlist *evlist = top->evlist;
+	struct perf_evsel *counter;
+
+	if (!opts->overwrite)
+		return 0;
+
+	/* only fall back when first event fails */
+	if (evsel != perf_evlist__first(evlist))
+		return 0;
+
+	evlist__for_each_entry(evlist, counter)
+		counter->attr.write_backward = false;
+	opts->overwrite = false;
+	ui__warning("fall back to non-overwrite mode\n");
+	return 1;
+}
+
 static int perf_top__start_counters(struct perf_top *top)
 {
 	char msg[BUFSIZ];
@@ -967,6 +988,21 @@ static int perf_top__start_counters(struct perf_top *top)
 try_again:
 		if (perf_evsel__open(counter, top->evlist->cpus,
 				     top->evlist->threads) < 0) {
+
+			/*
+			 * Specially handle overwrite fall back.
+			 * Because perf top is the only tool which has
+			 * overwrite mode by default, support
+			 * both overwrite and non-overwrite mode, and
+			 * require consistent mode for all events.
+			 *
+			 * May move it to generic code with more tools
+			 * have similar attribute.
+			 */
+			if (perf_missing_features.write_backward &&
+			    perf_top_overwrite_fallback(top, counter))
+				goto try_again;
+
 			if (perf_evsel__fallback(counter, errno, msg, sizeof(msg))) {
 				if (verbose > 0)
 					ui__warning("%s\n", msg);
-- 
2.14.3
