Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753274AbeCXUEM (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 16:04:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:37444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752842AbeCXUEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 16:04:08 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F61A2172B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, David Ahern <dsahern@gmail.com>,
        Jin Yao <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 22/44] perf annotate: Introduce init_column_widths() method out of TUI code
Date: Sat, 24 Mar 2018 17:01:49 -0300
Message-Id: <20180324200211.21326-23-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180324200211.21326-1-acme@kernel.org>
References: <20180324200211.21326-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

More non-TUI stuff goes to the UI-agnostic library

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-hngv7rpqvtta69ouj7ne770q@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate.c | 14 +-------------
 tools/perf/util/annotate.c        | 17 +++++++++++++++++
 tools/perf/util/annotate.h        |  1 +
 3 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index ab4d004fc184..06ad5ecaa67a 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -905,15 +905,6 @@ int hist_entry__tui_annotate(struct hist_entry *he, struct perf_evsel *evsel,
 	return map_symbol__tui_annotate(&he->ms, evsel, hbt);
 }
 
-static inline int width_jumps(int n)
-{
-	if (n >= 100)
-		return 5;
-	if (n / 10)
-		return 2;
-	return 1;
-}
-
 int symbol__tui_annotate(struct symbol *sym, struct map *map,
 			 struct perf_evsel *evsel,
 			 struct hist_browser_timer *hbt)
@@ -974,10 +965,7 @@ int symbol__tui_annotate(struct symbol *sym, struct map *map,
 	browser.b.width = notes->max_line_len;
 	annotation__mark_jump_targets(notes, sym);
 	annotation__compute_ipc(notes, size);
-
-	notes->widths.addr = notes->widths.target = notes->widths.min_addr = hex_width(size);
-	notes->widths.max_addr = hex_width(sym->end);
-	notes->widths.jumps = width_jumps(notes->max_jump_sources);
+	annotation__init_column_widths(notes, sym);
 	notes->nr_events = nr_pcnt;
 	browser.b.nr_entries = notes->nr_entries;
 	browser.b.entries = &notes->src->source,
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 8a2fda80a221..9c05b534f428 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2084,6 +2084,23 @@ void annotation__set_offsets(struct annotation *notes, s64 size)
 	}
 }
 
+static inline int width_jumps(int n)
+{
+	if (n >= 100)
+		return 5;
+	if (n / 10)
+		return 2;
+	return 1;
+}
+
+void annotation__init_column_widths(struct annotation *notes, struct symbol *sym)
+{
+	notes->widths.addr = notes->widths.target =
+		notes->widths.min_addr = hex_width(symbol__size(sym));
+	notes->widths.max_addr = hex_width(sym->end);
+	notes->widths.jumps = width_jumps(notes->max_jump_sources);
+}
+
 void annotation__update_column_widths(struct annotation *notes)
 {
 	if (notes->options->use_offset)
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index a8bea758490a..c4528e03a031 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -204,6 +204,7 @@ void annotation__set_offsets(struct annotation *notes, s64 size);
 void annotation__compute_ipc(struct annotation *notes, size_t size);
 void annotation__mark_jump_targets(struct annotation *notes, struct symbol *sym);
 void annotation__update_column_widths(struct annotation *notes);
+void annotation__init_column_widths(struct annotation *notes, struct symbol *sym);
 
 static inline struct sym_hist *annotation__histogram(struct annotation *notes, int idx)
 {
-- 
2.14.3
