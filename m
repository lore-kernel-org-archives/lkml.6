Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935068AbeEWUYX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 16:24:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:34200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934938AbeEWUVz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 16:21:55 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, Jin Yao <yao.jin@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 10/18] perf annotate: Show group event string for stdio
Date: Wed, 23 May 2018 17:20:58 -0300
Message-Id: <20180523202106.17286-11-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180523202106.17286-1-acme@kernel.org>
References: <20180523202106.17286-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jin Yao <yao.jin@linux.intel.com>

When we enable the group, for tui/stdio2, the output first line includes
the group event string. While for stdio, it will show only one event.

For example,

perf record -e cycles,branches ./div
perf annotate --group --stdio

    Percent |      Source code & Disassembly of div for cycles (44407 samples)
    ......

The first line doesn't include the event 'branches'.

With this patch, it will show the correct group even string.

perf annotate --group --stdio

    Percent |      Source code & Disassembly of div for cycles, branches (44407 samples)
    ......

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Suggested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/1526989115-14435-1-git-send-email-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 6612c7f90af4..71897689dacf 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1965,6 +1965,7 @@ int symbol__annotate_printf(struct symbol *sym, struct map *map,
 	u64 len;
 	int width = symbol_conf.show_total_period ? 12 : 8;
 	int graph_dotted_len;
+	char buf[512];
 
 	filename = strdup(dso->long_name);
 	if (!filename)
@@ -1977,8 +1978,11 @@ int symbol__annotate_printf(struct symbol *sym, struct map *map,
 
 	len = symbol__size(sym);
 
-	if (perf_evsel__is_group_event(evsel))
+	if (perf_evsel__is_group_event(evsel)) {
 		width *= evsel->nr_members;
+		perf_evsel__group_desc(evsel, buf, sizeof(buf));
+		evsel_name = buf;
+	}
 
 	graph_dotted_len = printf(" %-*.*s|	Source code & Disassembly of %s for %s (%" PRIu64 " samples)\n",
 				  width, width, symbol_conf.show_total_period ? "Period" :
-- 
2.14.3
