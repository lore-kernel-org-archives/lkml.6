Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752097AbeCYWR3 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 18:17:29 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50699 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751010AbeCYWRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 18:17:24 -0400
Date: Sun, 25 Mar 2018 15:17:14 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-hngv7rpqvtta69ouj7ne770q@git.kernel.org>
Cc: jolsa@kernel.org, mingo@kernel.org, acme@redhat.com,
        yao.jin@linux.intel.com, wangnan0@huawei.com,
        linux-kernel@vger.kernel.org, namhyung@kernel.org, dsahern@gmail.com,
        hpa@zytor.com, adrian.hunter@intel.com, ak@linux.intel.com,
        tglx@linutronix.de
Reply-To: ak@linux.intel.com, tglx@linutronix.de, adrian.hunter@intel.com,
        dsahern@gmail.com, namhyung@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, acme@redhat.com, yao.jin@linux.intel.com,
        wangnan0@huawei.com, mingo@kernel.org, jolsa@kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf annotate: Introduce init_column_widths()
 method out of TUI code
Git-Commit-ID: b8b0d819858e1140e98ce858a0c839f3d03cb0f5
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

Commit-ID:  b8b0d819858e1140e98ce858a0c839f3d03cb0f5
Gitweb:     https://git.kernel.org/tip/b8b0d819858e1140e98ce858a0c839f3d03cb0f5
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 15 Mar 2018 16:26:29 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 20 Mar 2018 13:19:29 -0300

perf annotate: Introduce init_column_widths() method out of TUI code

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
