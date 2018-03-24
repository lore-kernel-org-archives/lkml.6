Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753328AbeCXUE2 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 16:04:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:37628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752842AbeCXUEY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 16:04:24 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F9F72172B
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
Subject: [PATCH 27/44] perf annotate: Finish the generalization of annotate_browser__write()
Date: Sat, 24 Mar 2018 17:01:54 -0300
Message-Id: <20180324200211.21326-28-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180324200211.21326-1-acme@kernel.org>
References: <20180324200211.21326-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We pass some more callbacks and all of annotate_browser__write() seems
to be free of TUI code (except for some arrow constants, will fix).

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-5uo6yvwnxtsbe8y6v0ysaakf@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate.c |  97 +++++---------------------------
 tools/perf/util/annotate.c        | 113 +++++++++++++++++++++++++++++++++++---
 tools/perf/util/annotate.h        |  13 +++--
 3 files changed, 127 insertions(+), 96 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 9b77a016e299..2b18c462b882 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -71,38 +71,20 @@ static int ui_browser__jumps_percent_color(struct ui_browser *browser, int nr, b
 	return HE_COLORSET_NORMAL;
 }
 
-static int ui_browser__set_jumps_percent_color(struct ui_browser *browser, int nr, bool current)
+static int ui_browser__set_jumps_percent_color(void *browser, int nr, bool current)
 {
 	 int color = ui_browser__jumps_percent_color(browser, nr, current);
 	 return ui_browser__set_color(browser, color);
 }
 
-static void disasm_line__write(struct disasm_line *dl, struct ui_browser *browser,
-			       char *bf, size_t size)
+static int annotate_browser__set_color(void *browser, int color)
 {
-	struct annotation *notes = browser__annotation(browser);
-
-	if (dl->ins.ops && dl->ins.ops->scnprintf) {
-		if (ins__is_jump(&dl->ins)) {
-			bool fwd = dl->ops.target.offset > dl->al.offset;
-
-			ui_browser__write_graph(browser, fwd ? SLSMG_DARROW_CHAR :
-							    SLSMG_UARROW_CHAR);
-			SLsmg_write_char(' ');
-		} else if (ins__is_call(&dl->ins)) {
-			ui_browser__write_graph(browser, SLSMG_RARROW_CHAR);
-			SLsmg_write_char(' ');
-		} else if (ins__is_ret(&dl->ins)) {
-			ui_browser__write_graph(browser, SLSMG_LARROW_CHAR);
-			SLsmg_write_char(' ');
-		} else {
-			ui_browser__write_nstring(browser, " ", 2);
-		}
-	} else {
-		ui_browser__write_nstring(browser, " ", 2);
-	}
+	return ui_browser__set_color(browser, color);
+}
 
-	disasm_line__scnprintf(dl, bf, size, !notes->options->use_offset);
+static void annotate_browser__write_graph(void *browser, int graph)
+{
+	ui_browser__write_graph(browser, graph);
 }
 
 static void annotate_browser__set_percent_color(void *browser, double percent, bool current)
@@ -128,68 +110,19 @@ static void annotate_browser__write(struct ui_browser *browser, void *entry, int
 	bool change_color = (!notes->options->hide_src_code &&
 			     (!current_entry || (browser->use_navkeypressed &&
 					         !browser->navkeypressed)));
-	int width = browser->width, printed;
-	int pcnt_width = annotation__pcnt_width(notes),
-	    cycles_width = annotation__cycles_width(notes);
-	char bf[256];
-
-	annotation_line__print_start(al, notes, row == 0, current_entry, browser,
-				     annotate_browser__set_percent_color,
-				     annotate_browser__printf);
+	int width = browser->width;
 
 	/* The scroll bar isn't being used */
 	if (!browser->navkeypressed)
 		width += 1;
 
-	if (!*al->line)
-		ui_browser__write_nstring(browser, " ", width - pcnt_width - cycles_width);
-	else if (al->offset == -1) {
-		if (al->line_nr && notes->options->show_linenr)
-			printed = scnprintf(bf, sizeof(bf), "%-*d ", notes->widths.addr + 1, al->line_nr);
-		else
-			printed = scnprintf(bf, sizeof(bf), "%*s  ", notes->widths.addr, " ");
-		ui_browser__write_nstring(browser, bf, printed);
-		ui_browser__write_nstring(browser, al->line, width - printed - pcnt_width - cycles_width + 1);
-	} else {
-		u64 addr = al->offset;
-		int color = -1;
-
-		if (!notes->options->use_offset)
-			addr += notes->start;
-
-		if (!notes->options->use_offset) {
-			printed = scnprintf(bf, sizeof(bf), "%" PRIx64 ": ", addr);
-		} else {
-			if (al->jump_sources) {
-				if (notes->options->show_nr_jumps) {
-					int prev;
-					printed = scnprintf(bf, sizeof(bf), "%*d ",
-							    notes->widths.jumps,
-							    al->jump_sources);
-					prev = ui_browser__set_jumps_percent_color(browser, al->jump_sources,
-										   current_entry);
-					ui_browser__write_nstring(browser, bf, printed);
-					ui_browser__set_color(browser, prev);
-				}
-
-				printed = scnprintf(bf, sizeof(bf), "%*" PRIx64 ": ",
-						    notes->widths.target, addr);
-			} else {
-				printed = scnprintf(bf, sizeof(bf), "%*s  ",
-						    notes->widths.addr, " ");
-			}
-		}
-
-		if (change_color)
-			color = ui_browser__set_color(browser, HE_COLORSET_ADDR);
-		ui_browser__write_nstring(browser, bf, printed);
-		if (change_color)
-			ui_browser__set_color(browser, color);
-
-		disasm_line__write(disasm_line(al), browser, bf, sizeof(bf));
-
-		ui_browser__write_nstring(browser, bf, width - pcnt_width - cycles_width - 3 - printed);
-	}
+	annotation_line__write(al, notes, row == 0, current_entry, change_color,
+			       width, browser,
+			       annotate_browser__set_color,
+			       annotate_browser__set_percent_color,
+			       ui_browser__set_jumps_percent_color,
+			       annotate_browser__printf,
+			       annotate_browser__write_graph);
 
 	if (current_entry)
 		ab->selection = al;
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 046feda11052..45a52e2658c8 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -27,6 +27,18 @@
 #include <linux/bitops.h>
 #include <linux/kernel.h>
 
+/* FIXME: For the HE_COLORSET */
+#include "ui/browser.h"
+
+/*
+ * FIXME: Using the same values as slang.h,
+ * but that header may not be available everywhere
+ */
+#define LARROW_CHAR	0x1B
+#define RARROW_CHAR	0x1A
+#define DARROW_CHAR	0x19
+#define UARROW_CHAR	0x18
+
 #include "sane_ctype.h"
 
 const char 	*disassembler_style;
@@ -2204,14 +2216,48 @@ static void set_percent_color_stub(void *obj __maybe_unused,
 {
 }
 
-void annotation_line__print_start(struct annotation_line *al, struct annotation *notes,
-				  bool first_line, bool current_entry,
-				  void *obj,
-				  void (*obj__set_percent_color)(void *obj, double percent, bool current),
-				  void (*obj__printf)(void *obj, const char *fmt, ...))
+static void disasm_line__write(struct disasm_line *dl, struct annotation *notes,
+			       void *obj, char *bf, size_t size,
+			       void (*obj__printf)(void *obj, const char *fmt, ...),
+			       void (*obj__write_graph)(void *obj, int graph))
+{
+	if (dl->ins.ops && dl->ins.ops->scnprintf) {
+		if (ins__is_jump(&dl->ins)) {
+			bool fwd = dl->ops.target.offset > dl->al.offset;
+
+			obj__write_graph(obj, fwd ? DARROW_CHAR : UARROW_CHAR);
+			obj__printf(obj, " ");
+		} else if (ins__is_call(&dl->ins)) {
+			obj__write_graph(obj, RARROW_CHAR);
+			obj__printf(obj, " ");
+		} else if (ins__is_ret(&dl->ins)) {
+			obj__write_graph(obj, LARROW_CHAR);
+			obj__printf(obj, " ");
+		} else {
+			obj__printf(obj, "  ");
+		}
+	} else {
+		obj__printf(obj, "  ");
+	}
+
+	disasm_line__scnprintf(dl, bf, size, !notes->options->use_offset);
+}
+
+void annotation_line__write(struct annotation_line *al, struct annotation *notes,
+			    bool first_line, bool current_entry, bool change_color, int width,
+			    void *obj,
+			    int  (*obj__set_color)(void *obj, int color),
+			    void (*obj__set_percent_color)(void *obj, double percent, bool current),
+			    int  (*obj__set_jumps_percent_color)(void *obj, int nr, bool current),
+			    void (*obj__printf)(void *obj, const char *fmt, ...),
+			    void (*obj__write_graph)(void *obj, int graph))
 {
 	double percent_max = annotation_line__max_percent(al, notes);
+	int pcnt_width = annotation__pcnt_width(notes),
+	    cycles_width = annotation__cycles_width(notes);
 	bool show_title = false;
+	char bf[256];
+	int printed;
 
 	if (first_line && (al->offset == -1 || percent_max == 0.0)) {
 		if (notes->have_cycles) {
@@ -2240,14 +2286,12 @@ void annotation_line__print_start(struct annotation_line *al, struct annotation
 			}
 		}
 	} else {
-		int pcnt_width = annotation__pcnt_width(notes);
-
 		obj__set_percent_color(obj, 0, current_entry);
 
 		if (!show_title)
-			obj__printf(obj, "%*s", pcnt_width, " ");
+			obj__printf(obj, "%-*s", pcnt_width, " ");
 		else {
-			obj__printf(obj, "%*s", pcnt_width,
+			obj__printf(obj, "%-*s", pcnt_width,
 					   notes->options->show_total_period ? "Period" :
 					   notes->options->show_nr_samples ? "Samples" : "Percent");
 		}
@@ -2271,6 +2315,57 @@ void annotation_line__print_start(struct annotation_line *al, struct annotation
 	}
 
 	obj__printf(obj, " ");
+
+	if (!*al->line)
+		obj__printf(obj, "%-*s", width - pcnt_width - cycles_width, " ");
+	else if (al->offset == -1) {
+		if (al->line_nr && notes->options->show_linenr)
+			printed = scnprintf(bf, sizeof(bf), "%-*d ", notes->widths.addr + 1, al->line_nr);
+		else
+			printed = scnprintf(bf, sizeof(bf), "%-*s  ", notes->widths.addr, " ");
+		obj__printf(obj, bf);
+		obj__printf(obj, "%-*s", width - printed - pcnt_width - cycles_width + 1, al->line);
+	} else {
+		u64 addr = al->offset;
+		int color = -1;
+
+		if (!notes->options->use_offset)
+			addr += notes->start;
+
+		if (!notes->options->use_offset) {
+			printed = scnprintf(bf, sizeof(bf), "%" PRIx64 ": ", addr);
+		} else {
+			if (al->jump_sources) {
+				if (notes->options->show_nr_jumps) {
+					int prev;
+					printed = scnprintf(bf, sizeof(bf), "%*d ",
+							    notes->widths.jumps,
+							    al->jump_sources);
+					prev = obj__set_jumps_percent_color(obj, al->jump_sources,
+									    current_entry);
+					obj__printf(obj, bf);
+					obj__set_color(obj, prev);
+				}
+
+				printed = scnprintf(bf, sizeof(bf), "%*" PRIx64 ": ",
+						    notes->widths.target, addr);
+			} else {
+				printed = scnprintf(bf, sizeof(bf), "%-*s  ",
+						    notes->widths.addr, " ");
+			}
+		}
+
+		if (change_color)
+			color = obj__set_color(obj, HE_COLORSET_ADDR);
+		obj__printf(obj, bf);
+		if (change_color)
+			obj__set_color(obj, color);
+
+		disasm_line__write(disasm_line(al), notes, obj, bf, sizeof(bf), obj__printf, obj__write_graph);
+
+		obj__printf(obj, "%-*s", width - pcnt_width - cycles_width - 3 - printed, bf);
+	}
+
 }
 
 int symbol__annotate2(struct symbol *sym, struct map *map, struct perf_evsel *evsel,
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 84c99774bfed..27fcdacbb497 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -126,11 +126,14 @@ struct annotation_line *
 annotation_line__next(struct annotation_line *pos, struct list_head *head);
 
 double annotation_line__max_percent(struct annotation_line *al, struct annotation *notes);
-void annotation_line__print_start(struct annotation_line *al, struct annotation *notes,
-				  bool first_line, bool current_entry,
-				  void *obj,
-				  void (*obj__set_percent_color)(void *obj, double percent, bool current),
-				  void (*obj__printf)(void *obj, const char *fmt, ...));
+void annotation_line__write(struct annotation_line *al, struct annotation *notes,
+			    bool first_line, bool current_entry, bool change_color, int width,
+			    void *obj,
+			    int  (*obj__set_color)(void *obj, int color),
+			    void (*obj__set_percent_color)(void *obj, double percent, bool current),
+			    int  (*obj__set_jumps_percent_color)(void *obj, int nr, bool current),
+			    void (*obj__printf)(void *obj, const char *fmt, ...),
+			    void (*obj__write_graph)(void *obj, int graph));
 
 int disasm_line__scnprintf(struct disasm_line *dl, char *bf, size_t size, bool raw);
 size_t disasm__fprintf(struct list_head *head, FILE *fp);
-- 
2.14.3
