Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752683AbeEVDoy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 23:44:54 -0400
Received: from mga04.intel.com ([192.55.52.120]:37610 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752656AbeEVDou (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 23:44:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,428,1520924400";
   d="scan'208";a="60606834"
From: Jin Yao <yao.jin@linux.intel.com>
To: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc: Linux-kernel@vger.kernel.org, ak@linux.intel.com, kan.liang@intel.com,
        yao.jin@intel.com, Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH] perf annotate: Show group event string for stdio
Date: Tue, 22 May 2018 19:38:35 +0800
Message-Id: <1526989115-14435-1-git-send-email-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we enable the group, for tui/stdio2, the output first
line includes the group event string. While for stdio,
it will show only one event.

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
---
 tools/perf/util/annotate.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 6612c7f..7189768 100644
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
2.7.4
