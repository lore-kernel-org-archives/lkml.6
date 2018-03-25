Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752684AbeCYWUP (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 18:20:15 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48355 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751874AbeCYWUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 18:20:07 -0400
Date: Sun, 25 Mar 2018 15:19:57 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-pcs3c7vdy9ucygxflo4nl1o7@git.kernel.org>
Cc: dsahern@gmail.com, mingo@kernel.org, adrian.hunter@intel.com,
        wangnan0@huawei.com, namhyung@kernel.org, ak@linux.intel.com,
        hpa@zytor.com, linux-kernel@vger.kernel.org, acme@redhat.com,
        jolsa@kernel.org, yao.jin@linux.intel.com, tglx@linutronix.de
Reply-To: mingo@kernel.org, adrian.hunter@intel.com, dsahern@gmail.com,
        wangnan0@huawei.com, namhyung@kernel.org, acme@redhat.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com, ak@linux.intel.com,
        jolsa@kernel.org, tglx@linutronix.de, yao.jin@linux.intel.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf annotate: Use a ops table for
 annotation_line__write()
Git-Commit-ID: c298304bd747d6a0b733f0becb470ff07ead0317
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

Commit-ID:  c298304bd747d6a0b733f0becb470ff07ead0317
Gitweb:     https://git.kernel.org/tip/c298304bd747d6a0b733f0becb470ff07ead0317
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 15 Mar 2018 23:14:51 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 20 Mar 2018 15:36:18 -0300

perf annotate: Use a ops table for annotation_line__write()

To simplify the passing of arguments, the --stdio2 code will have to set
all the fields with operations printing to stdout.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-pcs3c7vdy9ucygxflo4nl1o7@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate.c | 32 +++++++++++++++-------------
 tools/perf/util/annotate.c        | 44 ++++++++++++++++++++-------------------
 tools/perf/util/annotate.h        | 19 ++++++++++-------
 3 files changed, 53 insertions(+), 42 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 2b18c462b882..bed647807d37 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -106,25 +106,29 @@ static void annotate_browser__write(struct ui_browser *browser, void *entry, int
 	struct annotate_browser *ab = container_of(browser, struct annotate_browser, b);
 	struct annotation *notes = browser__annotation(browser);
 	struct annotation_line *al = list_entry(entry, struct annotation_line, node);
-	bool current_entry = ui_browser__is_current_entry(browser, row);
-	bool change_color = (!notes->options->hide_src_code &&
-			     (!current_entry || (browser->use_navkeypressed &&
-					         !browser->navkeypressed)));
-	int width = browser->width;
+	struct annotation_write_ops ops = {
+		.first_line		 = row == 0,
+		.current_entry		 = ui_browser__is_current_entry(browser, row),
+		.change_color		 = (!notes->options->hide_src_code &&
+					    (!ops.current_entry ||
+					     (browser->use_navkeypressed &&
+					      !browser->navkeypressed))),
+		.width			 = browser->width,
+		.obj			 = browser,
+		.set_color		 = annotate_browser__set_color,
+		.set_percent_color	 = annotate_browser__set_percent_color,
+		.set_jumps_percent_color = ui_browser__set_jumps_percent_color,
+		.printf			 = annotate_browser__printf,
+		.write_graph		 = annotate_browser__write_graph,
+	};
 
 	/* The scroll bar isn't being used */
 	if (!browser->navkeypressed)
-		width += 1;
+		ops.width += 1;
 
-	annotation_line__write(al, notes, row == 0, current_entry, change_color,
-			       width, browser,
-			       annotate_browser__set_color,
-			       annotate_browser__set_percent_color,
-			       ui_browser__set_jumps_percent_color,
-			       annotate_browser__printf,
-			       annotate_browser__write_graph);
+	annotation_line__write(al, notes, &ops);
 
-	if (current_entry)
+	if (ops.current_entry)
 		ab->selection = al;
 }
 
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 45a52e2658c8..11ad73211538 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -34,10 +34,10 @@
  * FIXME: Using the same values as slang.h,
  * but that header may not be available everywhere
  */
-#define LARROW_CHAR	0x1B
-#define RARROW_CHAR	0x1A
-#define DARROW_CHAR	0x19
-#define UARROW_CHAR	0x18
+#define LARROW_CHAR	((unsigned char)',')
+#define RARROW_CHAR	((unsigned char)'+')
+#define DARROW_CHAR	((unsigned char)'.')
+#define UARROW_CHAR	((unsigned char)'-')
 
 #include "sane_ctype.h"
 
@@ -2210,12 +2210,6 @@ double annotation_line__max_percent(struct annotation_line *al, struct annotatio
 	return percent_max;
 }
 
-static void set_percent_color_stub(void *obj __maybe_unused,
-				   double percent __maybe_unused,
-				   bool current __maybe_unused)
-{
-}
-
 static void disasm_line__write(struct disasm_line *dl, struct annotation *notes,
 			       void *obj, char *bf, size_t size,
 			       void (*obj__printf)(void *obj, const char *fmt, ...),
@@ -2243,14 +2237,15 @@ static void disasm_line__write(struct disasm_line *dl, struct annotation *notes,
 	disasm_line__scnprintf(dl, bf, size, !notes->options->use_offset);
 }
 
-void annotation_line__write(struct annotation_line *al, struct annotation *notes,
-			    bool first_line, bool current_entry, bool change_color, int width,
-			    void *obj,
-			    int  (*obj__set_color)(void *obj, int color),
-			    void (*obj__set_percent_color)(void *obj, double percent, bool current),
-			    int  (*obj__set_jumps_percent_color)(void *obj, int nr, bool current),
-			    void (*obj__printf)(void *obj, const char *fmt, ...),
-			    void (*obj__write_graph)(void *obj, int graph))
+static void __annotation_line__write(struct annotation_line *al, struct annotation *notes,
+				     bool first_line, bool current_entry, bool change_color, int width,
+				     void *obj,
+				     int  (*obj__set_color)(void *obj, int color),
+				     void (*obj__set_percent_color)(void *obj, double percent, bool current),
+				     int  (*obj__set_jumps_percent_color)(void *obj, int nr, bool current),
+				     void (*obj__printf)(void *obj, const char *fmt, ...),
+				     void (*obj__write_graph)(void *obj, int graph))
+
 {
 	double percent_max = annotation_line__max_percent(al, notes);
 	int pcnt_width = annotation__pcnt_width(notes),
@@ -2267,9 +2262,6 @@ void annotation_line__write(struct annotation_line *al, struct annotation *notes
 			show_title = true;
 	}
 
-	if (!obj__set_percent_color)
-		obj__set_percent_color = set_percent_color_stub;
-
 	if (al->offset != -1 && percent_max != 0.0) {
 		int i;
 
@@ -2368,6 +2360,16 @@ void annotation_line__write(struct annotation_line *al, struct annotation *notes
 
 }
 
+void annotation_line__write(struct annotation_line *al, struct annotation *notes,
+			    struct annotation_write_ops *ops)
+{
+	__annotation_line__write(al, notes, ops->first_line, ops->current_entry,
+				 ops->change_color, ops->width, ops->obj,
+				 ops->set_color, ops->set_percent_color,
+				 ops->set_jumps_percent_color, ops->printf,
+				 ops->write_graph);
+}
+
 int symbol__annotate2(struct symbol *sym, struct map *map, struct perf_evsel *evsel,
 		      struct annotation_options *options, struct arch **parch)
 {
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 27fcdacbb497..6fbb34b9bd77 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -125,15 +125,20 @@ void disasm_line__free(struct disasm_line *dl);
 struct annotation_line *
 annotation_line__next(struct annotation_line *pos, struct list_head *head);
 
+struct annotation_write_ops {
+	bool first_line, current_entry, change_color;
+	int  width;
+	void *obj;
+	int  (*set_color)(void *obj, int color);
+	void (*set_percent_color)(void *obj, double percent, bool current);
+	int  (*set_jumps_percent_color)(void *obj, int nr, bool current);
+	void (*printf)(void *obj, const char *fmt, ...);
+	void (*write_graph)(void *obj, int graph);
+};
+
 double annotation_line__max_percent(struct annotation_line *al, struct annotation *notes);
 void annotation_line__write(struct annotation_line *al, struct annotation *notes,
-			    bool first_line, bool current_entry, bool change_color, int width,
-			    void *obj,
-			    int  (*obj__set_color)(void *obj, int color),
-			    void (*obj__set_percent_color)(void *obj, double percent, bool current),
-			    int  (*obj__set_jumps_percent_color)(void *obj, int nr, bool current),
-			    void (*obj__printf)(void *obj, const char *fmt, ...),
-			    void (*obj__write_graph)(void *obj, int graph));
+			    struct annotation_write_ops *ops);
 
 int disasm_line__scnprintf(struct disasm_line *dl, char *bf, size_t size, bool raw);
 size_t disasm__fprintf(struct list_head *head, FILE *fp);
