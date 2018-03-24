Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753362AbeCXUEh (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 16:04:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:37742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752842AbeCXUEe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 16:04:34 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C5242172B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, David Ahern <dsahern@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 30/44] perf annotate: Introduce the --stdio2 output mode
Date: Sat, 24 Mar 2018 17:01:57 -0300
Message-Id: <20180324200211.21326-31-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180324200211.21326-1-acme@kernel.org>
References: <20180324200211.21326-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

This uses the TUI augmented formatting routines, modulo interactivity.

  # perf annotate --ignore-vmlinux --stdio2 _raw_spin_lock_irqsave
  _raw_spin_lock_irqsave() /proc/kcore
  Event: cycles:ppp

  Percent

              Disassembly of section load0:

              ffffffff9a8734b0 <load0>:
                nop
                push   %rbx
   50.00        pushfq
                pop    %rax
                nop
                mov    %rax,%rbx
                cli
                nop
                xor    %eax,%eax
                mov    $0x1,%edx
   50.00        lock   cmpxchg %edx,(%rdi)
                test   %eax,%eax
              ↓ jne    2b
                mov    %rbx,%rax
                pop    %rbx
              ← retq
          2b:   mov    %eax,%esi
              → callq  queued_spin_lock_slowpath
                mov    %rbx,%rax
                pop    %rbx
              ← retq

Tested-by: Jin Yao <yao.jin@linux.intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-6cte5o8z84mbivbvqlg14uh1@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-annotate.txt |  2 +
 tools/perf/builtin-annotate.c              | 23 +++++---
 tools/perf/util/annotate.c                 | 92 ++++++++++++++++++++++++++++++
 tools/perf/util/annotate.h                 |  5 ++
 4 files changed, 115 insertions(+), 7 deletions(-)

diff --git a/tools/perf/Documentation/perf-annotate.txt b/tools/perf/Documentation/perf-annotate.txt
index 292809c3c0ca..c29c7fc93023 100644
--- a/tools/perf/Documentation/perf-annotate.txt
+++ b/tools/perf/Documentation/perf-annotate.txt
@@ -69,6 +69,8 @@ OPTIONS
 
 --stdio:: Use the stdio interface.
 
+--stdio2:: Use the stdio2 interface, non-interactive, uses the TUI formatting.
+
 --stdio-color=<mode>::
 	'always', 'never' or 'auto', allowing configuring color output
 	via the command line, in addition to via "color.ui" .perfconfig.
diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index ead6ae4549e5..e03f9bea9303 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -40,7 +40,7 @@
 struct perf_annotate {
 	struct perf_tool tool;
 	struct perf_session *session;
-	bool	   use_tui, use_stdio, use_gtk;
+	bool	   use_tui, use_stdio, use_stdio2, use_gtk;
 	bool	   full_paths;
 	bool	   print_line;
 	bool	   skip_missing;
@@ -202,6 +202,11 @@ static int process_branch_callback(struct perf_evsel *evsel,
 	return ret;
 }
 
+static bool has_annotation(struct perf_annotate *ann)
+{
+	return ui__has_annotation() || ann->use_stdio2;
+}
+
 static int perf_evsel__add_sample(struct perf_evsel *evsel,
 				  struct perf_sample *sample,
 				  struct addr_location *al,
@@ -212,7 +217,7 @@ static int perf_evsel__add_sample(struct perf_evsel *evsel,
 	struct hist_entry *he;
 	int ret;
 
-	if ((!ann->has_br_stack || !ui__has_annotation()) &&
+	if ((!ann->has_br_stack || !has_annotation(ann)) &&
 	    ann->sym_hist_filter != NULL &&
 	    (al->sym == NULL ||
 	     strcmp(ann->sym_hist_filter, al->sym->name) != 0)) {
@@ -236,7 +241,7 @@ static int perf_evsel__add_sample(struct perf_evsel *evsel,
 	 */
 	process_branch_stack(sample->branch_stack, al, sample);
 
-	if (ann->has_br_stack && ui__has_annotation())
+	if (ann->has_br_stack && has_annotation(ann))
 		return process_branch_callback(evsel, sample, al, ann, machine);
 
 	he = hists__add_entry(hists, al, NULL, NULL, NULL, sample, true);
@@ -282,8 +287,11 @@ static int hist_entry__tty_annotate(struct hist_entry *he,
 				    struct perf_evsel *evsel,
 				    struct perf_annotate *ann)
 {
-	return symbol__tty_annotate(he->ms.sym, he->ms.map, evsel,
-				    ann->print_line, ann->full_paths, 0, 0);
+	if (!ann->use_stdio2)
+		return symbol__tty_annotate(he->ms.sym, he->ms.map, evsel,
+					    ann->print_line, ann->full_paths, 0, 0);
+	return symbol__tty_annotate2(he->ms.sym, he->ms.map, evsel,
+				     ann->print_line, ann->full_paths);
 }
 
 static void hists__find_annotations(struct hists *hists,
@@ -487,6 +495,7 @@ int cmd_annotate(int argc, const char **argv)
 	OPT_BOOLEAN(0, "gtk", &annotate.use_gtk, "Use the GTK interface"),
 	OPT_BOOLEAN(0, "tui", &annotate.use_tui, "Use the TUI interface"),
 	OPT_BOOLEAN(0, "stdio", &annotate.use_stdio, "Use the stdio interface"),
+	OPT_BOOLEAN(0, "stdio2", &annotate.use_stdio2, "Use the stdio interface"),
 	OPT_STRING('k', "vmlinux", &symbol_conf.vmlinux_name,
 		   "file", "vmlinux pathname"),
 	OPT_BOOLEAN('m', "modules", &symbol_conf.use_modules,
@@ -569,7 +578,7 @@ int cmd_annotate(int argc, const char **argv)
 	if (ret < 0)
 		goto out_delete;
 
-	if (annotate.use_stdio)
+	if (annotate.use_stdio || annotate.use_stdio2)
 		use_browser = 0;
 	else if (annotate.use_tui)
 		use_browser = 1;
@@ -578,7 +587,7 @@ int cmd_annotate(int argc, const char **argv)
 
 	setup_browser(true);
 
-	if (use_browser == 1 && annotate.has_br_stack) {
+	if ((use_browser == 1 || annotate.use_stdio2) && annotate.has_br_stack) {
 		sort__mode = SORT_MODE__BRANCH;
 		if (setup_sorting(annotate.session->evlist) < 0)
 			usage_with_options(annotate_usage, options);
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 11ad73211538..98cf3e5380bc 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1965,6 +1965,72 @@ int symbol__annotate_printf(struct symbol *sym, struct map *map,
 	return more;
 }
 
+static void FILE__set_percent_color(void *fp __maybe_unused,
+				    double percent __maybe_unused,
+				    bool current __maybe_unused)
+{
+}
+
+static int FILE__set_jumps_percent_color(void *fp __maybe_unused,
+					 int nr __maybe_unused, bool current __maybe_unused)
+{
+	return 0;
+}
+
+static int FILE__set_color(void *fp __maybe_unused, int color __maybe_unused)
+{
+	return 0;
+}
+
+static void FILE__printf(void *fp, const char *fmt, ...)
+{
+	va_list args;
+
+	va_start(args, fmt);
+	vfprintf(fp, fmt, args);
+	va_end(args);
+}
+
+static void FILE__write_graph(void *fp, int graph)
+{
+	const char *s;
+	switch (graph) {
+
+	case DARROW_CHAR: s = "↓"; break;
+	case UARROW_CHAR: s = "↑"; break;
+	case LARROW_CHAR: s = "←"; break;
+	case RARROW_CHAR: s = "→"; break;
+	default:		s = "?"; break;
+	}
+
+	fputs(s, fp);
+}
+
+int symbol__annotate_fprintf2(struct symbol *sym, FILE *fp)
+{
+	struct annotation *notes = symbol__annotation(sym);
+	struct annotation_write_ops ops = {
+		.first_line		 = true,
+		.obj			 = fp,
+		.set_color		 = FILE__set_color,
+		.set_percent_color	 = FILE__set_percent_color,
+		.set_jumps_percent_color = FILE__set_jumps_percent_color,
+		.printf			 = FILE__printf,
+		.write_graph		 = FILE__write_graph,
+	};
+	struct annotation_line *al;
+
+	list_for_each_entry(al, &notes->src->source, node) {
+		if (annotation_line__filter(al, notes))
+			continue;
+		annotation_line__write(al, notes, &ops);
+		fputc('\n', fp);
+		ops.first_line = false;
+	}
+
+	return 0;
+}
+
 void symbol__annotate_zero_histogram(struct symbol *sym, int evidx)
 {
 	struct annotation *notes = symbol__annotation(sym);
@@ -2165,6 +2231,32 @@ static void symbol__calc_lines(struct symbol *sym, struct map *map,
 	annotation__calc_lines(notes, map, root, start);
 }
 
+int symbol__tty_annotate2(struct symbol *sym, struct map *map,
+			  struct perf_evsel *evsel, bool print_lines,
+			  bool full_paths)
+{
+	struct dso *dso = map->dso;
+	struct rb_root source_line = RB_ROOT;
+	struct annotation_options opts = {
+		.use_offset	= true,
+	};
+
+	if (symbol__annotate2(sym, map, evsel, &opts, NULL) < 0)
+		return -1;
+
+	if (print_lines) {
+		srcline_full_filename = full_paths;
+		symbol__calc_lines(sym, map, &source_line);
+		print_summary(&source_line, dso->long_name);
+	}
+
+	symbol__annotate_fprintf2(sym, stdout);
+
+	annotated_source__purge(symbol__annotation(sym)->src);
+
+	return 0;
+}
+
 int symbol__tty_annotate(struct symbol *sym, struct map *map,
 			 struct perf_evsel *evsel, bool print_lines,
 			 bool full_paths, int min_pcnt, int max_lines)
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 165845de1243..cf32cbc87930 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -281,6 +281,7 @@ int symbol__strerror_disassemble(struct symbol *sym, struct map *map,
 int symbol__annotate_printf(struct symbol *sym, struct map *map,
 			    struct perf_evsel *evsel, bool full_paths,
 			    int min_pcnt, int max_lines, int context);
+int symbol__annotate_fprintf2(struct symbol *sym, FILE *fp);
 void symbol__annotate_zero_histogram(struct symbol *sym, int evidx);
 void symbol__annotate_decay_histogram(struct symbol *sym, int evidx);
 void annotated_source__purge(struct annotated_source *as);
@@ -291,6 +292,10 @@ int symbol__tty_annotate(struct symbol *sym, struct map *map,
 			 struct perf_evsel *evsel, bool print_lines,
 			 bool full_paths, int min_pcnt, int max_lines);
 
+int symbol__tty_annotate2(struct symbol *sym, struct map *map,
+			  struct perf_evsel *evsel, bool print_lines,
+			  bool full_paths);
+
 #ifdef HAVE_SLANG_SUPPORT
 int symbol__tui_annotate(struct symbol *sym, struct map *map,
 			 struct perf_evsel *evsel,
-- 
2.14.3
