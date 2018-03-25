Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752238AbeCYWTU (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 18:19:20 -0400
Received: from terminus.zytor.com ([198.137.202.136]:35261 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752096AbeCYWTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 18:19:11 -0400
Date: Sun, 25 Mar 2018 15:19:01 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-1o7az1ng55g2g6ppr2jpeuct@git.kernel.org>
Cc: namhyung@kernel.org, ak@linux.intel.com, hpa@zytor.com,
        acme@redhat.com, tglx@linutronix.de, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, dsahern@gmail.com, mingo@kernel.org,
        yao.jin@linux.intel.com, adrian.hunter@intel.com, wangnan0@huawei.com
Reply-To: ak@linux.intel.com, namhyung@kernel.org, dsahern@gmail.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, jolsa@kernel.org,
        acme@redhat.com, hpa@zytor.com, mingo@kernel.org,
        yao.jin@linux.intel.com, adrian.hunter@intel.com, wangnan0@huawei.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf annotate: Introduce
 annotation_line__print_start() out of TUI code
Git-Commit-ID: 2ba5eca10486eeb37030f8bce27cecda3763502f
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

Commit-ID:  2ba5eca10486eeb37030f8bce27cecda3763502f
Gitweb:     https://git.kernel.org/tip/2ba5eca10486eeb37030f8bce27cecda3763502f
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 15 Mar 2018 17:54:36 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 20 Mar 2018 13:19:30 -0300

perf annotate: Introduce annotation_line__print_start() out of TUI code

For the --tui and --stdio2 cases using callbacks for print() and
set_percent_color() end up being the easiest path, real GUI remains as
an exercise.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-1o7az1ng55g2g6ppr2jpeuct@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate.c | 82 ++++++++++-----------------------------
 tools/perf/util/annotate.c        | 75 +++++++++++++++++++++++++++++++++++
 tools/perf/util/annotate.h        |  5 +++
 3 files changed, 101 insertions(+), 61 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 05f79f36e906..9b77a016e299 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -105,6 +105,20 @@ static void disasm_line__write(struct disasm_line *dl, struct ui_browser *browse
 	disasm_line__scnprintf(dl, bf, size, !notes->options->use_offset);
 }
 
+static void annotate_browser__set_percent_color(void *browser, double percent, bool current)
+{
+	ui_browser__set_percent_color(browser, percent, current);
+}
+
+static void annotate_browser__printf(void *browser, const char *fmt, ...)
+{
+	va_list args;
+
+	va_start(args, fmt);
+	ui_browser__vprintf(browser, fmt, args);
+	va_end(args);
+}
+
 static void annotate_browser__write(struct ui_browser *browser, void *entry, int row)
 {
 	struct annotate_browser *ab = container_of(browser, struct annotate_browser, b);
@@ -115,65 +129,13 @@ static void annotate_browser__write(struct ui_browser *browser, void *entry, int
 			     (!current_entry || (browser->use_navkeypressed &&
 					         !browser->navkeypressed)));
 	int width = browser->width, printed;
-	int i, pcnt_width = annotation__pcnt_width(notes),
-	       cycles_width = annotation__cycles_width(notes);
-	double percent_max = annotation_line__max_percent(al, notes);
+	int pcnt_width = annotation__pcnt_width(notes),
+	    cycles_width = annotation__cycles_width(notes);
 	char bf[256];
-	bool show_title = false;
-
-	if ((row == 0) && (al->offset == -1 || percent_max == 0.0)) {
-		if (notes->have_cycles) {
-			if (al->ipc == 0.0 && al->cycles == 0)
-				show_title = true;
-		} else
-			show_title = true;
-	}
-
-	if (al->offset != -1 && percent_max != 0.0) {
-		for (i = 0; i < notes->nr_events; i++) {
-			ui_browser__set_percent_color(browser,
-						al->samples[i].percent,
-						current_entry);
-			if (notes->options->show_total_period) {
-				ui_browser__printf(browser, "%11" PRIu64 " ",
-						   al->samples[i].he.period);
-			} else if (notes->options->show_nr_samples) {
-				ui_browser__printf(browser, "%6" PRIu64 " ",
-						   al->samples[i].he.nr_samples);
-			} else {
-				ui_browser__printf(browser, "%6.2f ",
-						   al->samples[i].percent);
-			}
-		}
-	} else {
-		ui_browser__set_percent_color(browser, 0, current_entry);
-
-		if (!show_title)
-			ui_browser__write_nstring(browser, " ", pcnt_width);
-		else {
-			ui_browser__printf(browser, "%*s", pcnt_width,
-					   notes->options->show_total_period ? "Period" :
-					   notes->options->show_nr_samples ? "Samples" : "Percent");
-		}
-	}
-	if (notes->have_cycles) {
-		if (al->ipc)
-			ui_browser__printf(browser, "%*.2f ", ANNOTATION__IPC_WIDTH - 1, al->ipc);
-		else if (!show_title)
-			ui_browser__write_nstring(browser, " ", ANNOTATION__IPC_WIDTH);
-		else
-			ui_browser__printf(browser, "%*s ", ANNOTATION__IPC_WIDTH - 1, "IPC");
-
-		if (al->cycles)
-			ui_browser__printf(browser, "%*" PRIu64 " ",
-					   ANNOTATION__CYCLES_WIDTH - 1, al->cycles);
-		else if (!show_title)
-			ui_browser__write_nstring(browser, " ", ANNOTATION__CYCLES_WIDTH);
-		else
-			ui_browser__printf(browser, "%*s ", ANNOTATION__CYCLES_WIDTH - 1, "Cycle");
-	}
 
-	SLsmg_write_char(' ');
+	annotation_line__print_start(al, notes, row == 0, current_entry, browser,
+				     annotate_browser__set_percent_color,
+				     annotate_browser__printf);
 
 	/* The scroll bar isn't being used */
 	if (!browser->navkeypressed)
@@ -183,11 +145,9 @@ static void annotate_browser__write(struct ui_browser *browser, void *entry, int
 		ui_browser__write_nstring(browser, " ", width - pcnt_width - cycles_width);
 	else if (al->offset == -1) {
 		if (al->line_nr && notes->options->show_linenr)
-			printed = scnprintf(bf, sizeof(bf), "%-*d ",
-					notes->widths.addr + 1, al->line_nr);
+			printed = scnprintf(bf, sizeof(bf), "%-*d ", notes->widths.addr + 1, al->line_nr);
 		else
-			printed = scnprintf(bf, sizeof(bf), "%*s  ",
-				    notes->widths.addr, " ");
+			printed = scnprintf(bf, sizeof(bf), "%*s  ", notes->widths.addr, " ");
 		ui_browser__write_nstring(browser, bf, printed);
 		ui_browser__write_nstring(browser, al->line, width - printed - pcnt_width - cycles_width + 1);
 	} else {
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 3bd6f9b0147f..046feda11052 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2198,6 +2198,81 @@ double annotation_line__max_percent(struct annotation_line *al, struct annotatio
 	return percent_max;
 }
 
+static void set_percent_color_stub(void *obj __maybe_unused,
+				   double percent __maybe_unused,
+				   bool current __maybe_unused)
+{
+}
+
+void annotation_line__print_start(struct annotation_line *al, struct annotation *notes,
+				  bool first_line, bool current_entry,
+				  void *obj,
+				  void (*obj__set_percent_color)(void *obj, double percent, bool current),
+				  void (*obj__printf)(void *obj, const char *fmt, ...))
+{
+	double percent_max = annotation_line__max_percent(al, notes);
+	bool show_title = false;
+
+	if (first_line && (al->offset == -1 || percent_max == 0.0)) {
+		if (notes->have_cycles) {
+			if (al->ipc == 0.0 && al->cycles == 0)
+				show_title = true;
+		} else
+			show_title = true;
+	}
+
+	if (!obj__set_percent_color)
+		obj__set_percent_color = set_percent_color_stub;
+
+	if (al->offset != -1 && percent_max != 0.0) {
+		int i;
+
+		for (i = 0; i < notes->nr_events; i++) {
+			obj__set_percent_color(obj, al->samples[i].percent, current_entry);
+			if (notes->options->show_total_period) {
+				obj__printf(obj, "%11" PRIu64 " ", al->samples[i].he.period);
+			} else if (notes->options->show_nr_samples) {
+				obj__printf(obj, "%6" PRIu64 " ",
+						   al->samples[i].he.nr_samples);
+			} else {
+				obj__printf(obj, "%6.2f ",
+						   al->samples[i].percent);
+			}
+		}
+	} else {
+		int pcnt_width = annotation__pcnt_width(notes);
+
+		obj__set_percent_color(obj, 0, current_entry);
+
+		if (!show_title)
+			obj__printf(obj, "%*s", pcnt_width, " ");
+		else {
+			obj__printf(obj, "%*s", pcnt_width,
+					   notes->options->show_total_period ? "Period" :
+					   notes->options->show_nr_samples ? "Samples" : "Percent");
+		}
+	}
+
+	if (notes->have_cycles) {
+		if (al->ipc)
+			obj__printf(obj, "%*.2f ", ANNOTATION__IPC_WIDTH - 1, al->ipc);
+		else if (!show_title)
+			obj__printf(obj, "%*s", ANNOTATION__IPC_WIDTH, " ");
+		else
+			obj__printf(obj, "%*s ", ANNOTATION__IPC_WIDTH - 1, "IPC");
+
+		if (al->cycles)
+			obj__printf(obj, "%*" PRIu64 " ",
+					   ANNOTATION__CYCLES_WIDTH - 1, al->cycles);
+		else if (!show_title)
+			obj__printf(obj, "%*s", ANNOTATION__CYCLES_WIDTH, " ");
+		else
+			obj__printf(obj, "%*s ", ANNOTATION__CYCLES_WIDTH - 1, "Cycle");
+	}
+
+	obj__printf(obj, " ");
+}
+
 int symbol__annotate2(struct symbol *sym, struct map *map, struct perf_evsel *evsel,
 		      struct annotation_options *options, struct arch **parch)
 {
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 83484e236f33..84c99774bfed 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -126,6 +126,11 @@ struct annotation_line *
 annotation_line__next(struct annotation_line *pos, struct list_head *head);
 
 double annotation_line__max_percent(struct annotation_line *al, struct annotation *notes);
+void annotation_line__print_start(struct annotation_line *al, struct annotation *notes,
+				  bool first_line, bool current_entry,
+				  void *obj,
+				  void (*obj__set_percent_color)(void *obj, double percent, bool current),
+				  void (*obj__printf)(void *obj, const char *fmt, ...));
 
 int disasm_line__scnprintf(struct disasm_line *dl, char *bf, size_t size, bool raw);
 size_t disasm__fprintf(struct list_head *head, FILE *fp);
