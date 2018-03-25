Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752201AbeCYWOR (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 18:14:17 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37281 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751241AbeCYWOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 18:14:14 -0400
Date: Sun, 25 Mar 2018 15:14:03 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-v827xec8z3hxrmgp7bwa6ohs@git.kernel.org>
Cc: hpa@zytor.com, linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
        tglx@linutronix.de, yao.jin@linux.intel.com, acme@redhat.com,
        namhyung@kernel.org, ak@linux.intel.com, jolsa@kernel.org,
        mingo@kernel.org, dsahern@gmail.com, wangnan0@huawei.com
Reply-To: hpa@zytor.com, linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
        tglx@linutronix.de, yao.jin@linux.intel.com, acme@redhat.com,
        ak@linux.intel.com, namhyung@kernel.org, mingo@kernel.org,
        dsahern@gmail.com, jolsa@kernel.org, wangnan0@huawei.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf annotate: Move mark_jump_targets from the TUI
 to the annotation library
Git-Commit-ID: 0db45bcfac8586c6f5b732f114f456f2f788b19f
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

Commit-ID:  0db45bcfac8586c6f5b732f114f456f2f788b19f
Gitweb:     https://git.kernel.org/tip/0db45bcfac8586c6f5b732f114f456f2f788b19f
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 15 Mar 2018 15:31:56 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 20 Mar 2018 13:19:29 -0300

perf annotate: Move mark_jump_targets from the TUI to the annotation library

This also is not TUI specific, should be used in the upcoming --stdio2
mode.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-v827xec8z3hxrmgp7bwa6ohs@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate.c | 54 +++------------------------------------
 tools/perf/util/annotate.c        | 44 +++++++++++++++++++++++++++++++
 tools/perf/util/annotate.h        |  4 +++
 3 files changed, 51 insertions(+), 51 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index d05a2f991207..58be0cecb081 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -25,7 +25,6 @@ struct disasm_line_samples {
 struct browser_line {
 	u32	idx;
 	int	idx_asm;
-	int	jump_sources;
 };
 
 static struct annotation_options annotate_browser__opts = {
@@ -132,7 +131,6 @@ static void annotate_browser__write(struct ui_browser *browser, void *entry, int
 	struct annotate_browser *ab = container_of(browser, struct annotate_browser, b);
 	struct annotation *notes = browser__annotation(browser);
 	struct annotation_line *al = list_entry(entry, struct annotation_line, node);
-	struct browser_line *bl = browser_line(al);
 	bool current_entry = ui_browser__is_current_entry(browser, row);
 	bool change_color = (!notes->options->hide_src_code &&
 			     (!current_entry || (browser->use_navkeypressed &&
@@ -228,13 +226,13 @@ static void annotate_browser__write(struct ui_browser *browser, void *entry, int
 		if (!notes->options->use_offset) {
 			printed = scnprintf(bf, sizeof(bf), "%" PRIx64 ": ", addr);
 		} else {
-			if (bl->jump_sources) {
+			if (al->jump_sources) {
 				if (notes->options->show_nr_jumps) {
 					int prev;
 					printed = scnprintf(bf, sizeof(bf), "%*d ",
 							    ab->jumps_width,
-							    bl->jump_sources);
-					prev = ui_browser__set_jumps_percent_color(browser, bl->jump_sources,
+							    al->jump_sources);
+					prev = ui_browser__set_jumps_percent_color(browser, al->jump_sources,
 										   current_entry);
 					ui_browser__write_nstring(browser, bf, printed);
 					ui_browser__set_color(browser, prev);
@@ -263,17 +261,6 @@ static void annotate_browser__write(struct ui_browser *browser, void *entry, int
 		ab->selection = al;
 }
 
-static bool disasm_line__is_valid_jump(struct disasm_line *dl, struct symbol *sym)
-{
-	if (!dl || !dl->ins.ops || !ins__is_jump(&dl->ins)
-	    || !disasm_line__has_offset(dl)
-	    || dl->ops.target.offset < 0
-	    || dl->ops.target.offset >= (s64)symbol__size(sym))
-		return false;
-
-	return true;
-}
-
 static bool is_fused(struct annotate_browser *ab, struct disasm_line *cursor)
 {
 	struct disasm_line *pos = list_prev_entry(cursor, al.node);
@@ -964,41 +951,6 @@ int hist_entry__tui_annotate(struct hist_entry *he, struct perf_evsel *evsel,
 	return map_symbol__tui_annotate(&he->ms, evsel, hbt);
 }
 
-static void annotation__mark_jump_targets(struct annotation *notes, struct symbol *sym)
-{
-	u64 offset, size = symbol__size(sym);
-
-	/* PLT symbols contain external offsets */
-	if (strstr(sym->name, "@plt"))
-		return;
-
-	for (offset = 0; offset < size; ++offset) {
-		struct annotation_line *al = notes->offsets[offset];
-		struct disasm_line *dl;
-		struct browser_line *blt;
-
-		dl = disasm_line(al);
-
-		if (!disasm_line__is_valid_jump(dl, sym))
-			continue;
-
-		al = notes->offsets[dl->ops.target.offset];
-
-		/*
- 		 * FIXME: Oops, no jump target? Buggy disassembler? Or do we
- 		 * have to adjust to the previous offset?
- 		 */
-		if (al == NULL)
-			continue;
-
-		blt = browser_line(al);
-		if (++blt->jump_sources > notes->max_jump_sources)
-			notes->max_jump_sources = blt->jump_sources;
-
-		++notes->nr_jumps;
-	}
-}
-
 static inline int width_jumps(int n)
 {
 	if (n >= 100)
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index d737c33c87d0..330275680a1a 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2012,6 +2012,50 @@ size_t disasm__fprintf(struct list_head *head, FILE *fp)
 	return printed;
 }
 
+
+bool disasm_line__is_valid_jump(struct disasm_line *dl, struct symbol *sym)
+{
+	if (!dl || !dl->ins.ops || !ins__is_jump(&dl->ins) ||
+	    !disasm_line__has_offset(dl) || dl->ops.target.offset < 0 ||
+	    dl->ops.target.offset >= (s64)symbol__size(sym))
+		return false;
+
+	return true;
+}
+
+void annotation__mark_jump_targets(struct annotation *notes, struct symbol *sym)
+{
+	u64 offset, size = symbol__size(sym);
+
+	/* PLT symbols contain external offsets */
+	if (strstr(sym->name, "@plt"))
+		return;
+
+	for (offset = 0; offset < size; ++offset) {
+		struct annotation_line *al = notes->offsets[offset];
+		struct disasm_line *dl;
+
+		dl = disasm_line(al);
+
+		if (!disasm_line__is_valid_jump(dl, sym))
+			continue;
+
+		al = notes->offsets[dl->ops.target.offset];
+
+		/*
+		 * FIXME: Oops, no jump target? Buggy disassembler? Or do we
+		 * have to adjust to the previous offset?
+		 */
+		if (al == NULL)
+			continue;
+
+		if (++al->jump_sources > notes->max_jump_sources)
+			notes->max_jump_sources = al->jump_sources;
+
+		++notes->nr_jumps;
+	}
+}
+
 static void annotation__calc_lines(struct annotation *notes, struct map *map,
 				  struct rb_root *root, u64 start)
 {
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 897a84712ab4..ab4a8b7710a0 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -90,6 +90,7 @@ struct annotation_line {
 	s64			 offset;
 	char			*line;
 	int			 line_nr;
+	int			 jump_sources;
 	float			 ipc;
 	u64			 cycles;
 	size_t			 privsize;
@@ -116,6 +117,8 @@ static inline bool disasm_line__has_offset(const struct disasm_line *dl)
 	return dl->ops.target.offset_avail;
 }
 
+bool disasm_line__is_valid_jump(struct disasm_line *dl, struct symbol *sym);
+
 void disasm_line__free(struct disasm_line *dl);
 struct annotation_line *
 annotation_line__next(struct annotation_line *pos, struct list_head *head);
@@ -184,6 +187,7 @@ static inline int annotation__pcnt_width(struct annotation *notes)
 }
 
 void annotation__compute_ipc(struct annotation *notes, size_t size);
+void annotation__mark_jump_targets(struct annotation *notes, struct symbol *sym);
 
 static inline struct sym_hist *annotation__histogram(struct annotation *notes, int idx)
 {
