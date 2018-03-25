Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752124AbeCYWQC (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 18:16:02 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48939 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750994AbeCYWQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 18:16:01 -0400
Date: Sun, 25 Mar 2018 15:15:50 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-ek20dnd8z2y5v54pcepihybz@git.kernel.org>
Cc: dsahern@gmail.com, yao.jin@linux.intel.com, adrian.hunter@intel.com,
        acme@redhat.com, namhyung@kernel.org, wangnan0@huawei.com,
        hpa@zytor.com, mingo@kernel.org, ak@linux.intel.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
Reply-To: linux-kernel@vger.kernel.org, jolsa@kernel.org, tglx@linutronix.de,
        hpa@zytor.com, mingo@kernel.org, ak@linux.intel.com,
        namhyung@kernel.org, wangnan0@huawei.com, acme@redhat.com,
        yao.jin@linux.intel.com, adrian.hunter@intel.com, dsahern@gmail.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf annotate: Introduce set_offsets() method out
 of TUI code
Git-Commit-ID: 5bc49f6120203c9fbe8e63fdcb9598e0ba615de7
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

Commit-ID:  5bc49f6120203c9fbe8e63fdcb9598e0ba615de7
Gitweb:     https://git.kernel.org/tip/5bc49f6120203c9fbe8e63fdcb9598e0ba615de7
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 15 Mar 2018 15:59:01 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 20 Mar 2018 13:19:29 -0300

perf annotate: Introduce set_offsets() method out of TUI code

More non-strictly TUI code being moved to the UI neutral annotation
library, to be used in the upcoming --stdio2 output mode.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-ek20dnd8z2y5v54pcepihybz@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate.c | 24 ++----------------------
 tools/perf/util/annotate.c        | 28 ++++++++++++++++++++++++++++
 tools/perf/util/annotate.h        |  3 +++
 3 files changed, 33 insertions(+), 22 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 00b88349a3c2..977c7e9fdadb 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -938,7 +938,6 @@ int symbol__tui_annotate(struct symbol *sym, struct map *map,
 			 struct perf_evsel *evsel,
 			 struct hist_browser_timer *hbt)
 {
-	struct annotation_line *al;
 	struct annotation *notes = symbol__annotation(sym);
 	size_t size;
 	struct map_symbol ms = {
@@ -991,27 +990,8 @@ int symbol__tui_annotate(struct symbol *sym, struct map *map,
 
 	notes->start = map__rip_2objdump(map, sym->start);
 
-	list_for_each_entry(al, &notes->src->source, node) {
-		size_t line_len = strlen(al->line);
-
-		if (browser.b.width < line_len)
-			browser.b.width = line_len;
-		al->idx = notes->nr_entries++;
-		if (al->offset != -1) {
-			al->idx_asm = notes->nr_asm_entries++;
-			/*
-			 * FIXME: short term bandaid to cope with assembly
-			 * routines that comes with labels in the same column
-			 * as the address in objdump, sigh.
-			 *
-			 * E.g. copy_user_generic_unrolled
- 			 */
-			if (al->offset < (s64)size)
-				notes->offsets[al->offset] = al;
-		} else
-			al->idx_asm = -1;
-	}
-
+	annotation__set_offsets(notes, size);
+	browser.b.width = notes->max_line_len;
 	annotation__mark_jump_targets(notes, sym);
 	annotation__compute_ipc(notes, size);
 
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 330275680a1a..b976e3951662 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2056,6 +2056,34 @@ void annotation__mark_jump_targets(struct annotation *notes, struct symbol *sym)
 	}
 }
 
+void annotation__set_offsets(struct annotation *notes, s64 size)
+{
+	struct annotation_line *al;
+
+	notes->max_line_len = 0;
+
+	list_for_each_entry(al, &notes->src->source, node) {
+		size_t line_len = strlen(al->line);
+
+		if (notes->max_line_len < line_len)
+			notes->max_line_len = line_len;
+		al->idx = notes->nr_entries++;
+		if (al->offset != -1) {
+			al->idx_asm = notes->nr_asm_entries++;
+			/*
+			 * FIXME: short term bandaid to cope with assembly
+			 * routines that comes with labels in the same column
+			 * as the address in objdump, sigh.
+			 *
+			 * E.g. copy_user_generic_unrolled
+ 			 */
+			if (al->offset < size)
+				notes->offsets[al->offset] = al;
+		} else
+			al->idx_asm = -1;
+	}
+}
+
 static void annotation__calc_lines(struct annotation *notes, struct map *map,
 				  struct rb_root *root, u64 start)
 {
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 0c34eb0bd7c8..8a61ec9a5291 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -177,6 +177,7 @@ struct annotation {
 	int			max_jump_sources;
 	int			nr_entries;
 	int			nr_asm_entries;
+	u16			max_line_len;
 	bool			have_cycles;
 	struct annotated_source *src;
 };
@@ -191,6 +192,8 @@ static inline int annotation__pcnt_width(struct annotation *notes)
 	return (notes->options->show_total_period ? 12 : 7) * notes->nr_events;
 }
 
+
+void annotation__set_offsets(struct annotation *notes, s64 size);
 void annotation__compute_ipc(struct annotation *notes, size_t size);
 void annotation__mark_jump_targets(struct annotation *notes, struct symbol *sym);
 
