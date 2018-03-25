Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752050AbeCYWSz (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 18:18:55 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38511 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750960AbeCYWSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 18:18:49 -0400
Date: Sun, 25 Mar 2018 15:17:40 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-e2x8wuf6gvdhzdryo229vj4i@git.kernel.org>
Cc: ak@linux.intel.com, namhyung@kernel.org, yao.jin@linux.intel.com,
        wangnan0@huawei.com, adrian.hunter@intel.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, jolsa@kernel.org, acme@redhat.com,
        mingo@kernel.org, dsahern@gmail.com, hpa@zytor.com
Reply-To: dsahern@gmail.com, hpa@zytor.com, acme@redhat.com, mingo@kernel.org,
        adrian.hunter@intel.com, wangnan0@huawei.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, jolsa@kernel.org,
        yao.jin@linux.intel.com, namhyung@kernel.org, ak@linux.intel.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf annotate: Introduce symbol__annotate2 method
Git-Commit-ID: ecda45bd6cfe0badda0e8215c5a008eaf7647716
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

Commit-ID:  ecda45bd6cfe0badda0e8215c5a008eaf7647716
Gitweb:     https://git.kernel.org/tip/ecda45bd6cfe0badda0e8215c5a008eaf7647716
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 15 Mar 2018 16:54:11 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 20 Mar 2018 13:19:30 -0300

perf annotate: Introduce symbol__annotate2 method

That does all the extended boilerplate the TUI browser did, leaving the
symbol__annotate() function to be used by the old --stdio output mode.

Now the upcoming --stdio2 output mode should just use this one to set
things up.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-e2x8wuf6gvdhzdryo229vj4i@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate.c | 28 +---------------------------
 tools/perf/util/annotate.c        | 39 +++++++++++++++++++++++++++++++++++++++
 tools/perf/util/annotate.h        |  4 ++++
 3 files changed, 44 insertions(+), 27 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 06ad5ecaa67a..ab21739f27ae 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -910,7 +910,6 @@ int symbol__tui_annotate(struct symbol *sym, struct map *map,
 			 struct hist_browser_timer *hbt)
 {
 	struct annotation *notes = symbol__annotation(sym);
-	size_t size;
 	struct map_symbol ms = {
 		.map = map,
 		.sym = sym,
@@ -926,28 +925,14 @@ int symbol__tui_annotate(struct symbol *sym, struct map *map,
 		},
 	};
 	int ret = -1, err;
-	int nr_pcnt = 1;
 
 	if (sym == NULL)
 		return -1;
 
-	size = symbol__size(sym);
-
 	if (map->dso->annotate_warned)
 		return -1;
 
-	notes->options = &annotate_browser__opts;
-
-	notes->offsets = zalloc(size * sizeof(struct annotation_line *));
-	if (notes->offsets == NULL) {
-		ui__error("Not enough memory!");
-		return -1;
-	}
-
-	if (perf_evsel__is_group_event(evsel))
-		nr_pcnt = evsel->nr_members;
-
-	err = symbol__annotate(sym, map, evsel, 0, &browser.arch);
+	err = symbol__annotate2(sym, map, evsel, &annotate_browser__opts, &browser.arch);
 	if (err) {
 		char msg[BUFSIZ];
 		symbol__strerror_disassemble(sym, map, err, msg, sizeof(msg));
@@ -955,18 +940,9 @@ int symbol__tui_annotate(struct symbol *sym, struct map *map,
 		goto out_free_offsets;
 	}
 
-	symbol__calc_percent(sym, evsel);
-
 	ui_helpline__push("Press ESC to exit");
 
-	notes->start = map__rip_2objdump(map, sym->start);
-
-	annotation__set_offsets(notes, size);
 	browser.b.width = notes->max_line_len;
-	annotation__mark_jump_targets(notes, sym);
-	annotation__compute_ipc(notes, size);
-	annotation__init_column_widths(notes, sym);
-	notes->nr_events = nr_pcnt;
 	browser.b.nr_entries = notes->nr_entries;
 	browser.b.entries = &notes->src->source,
 	browser.b.width += 18; /* Percentage */
@@ -974,8 +950,6 @@ int symbol__tui_annotate(struct symbol *sym, struct map *map,
 	if (notes->options->hide_src_code)
 		ui_browser__init_asm_mode(&browser.b);
 
-	annotation__update_column_widths(notes);
-
 	ret = annotate_browser__run(&browser, evsel, hbt);
 
 	annotated_source__purge(notes->src);
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 9c05b534f428..7ad6400a0d4f 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2183,3 +2183,42 @@ bool ui__has_annotation(void)
 {
 	return use_browser == 1 && perf_hpp_list.sym;
 }
+
+int symbol__annotate2(struct symbol *sym, struct map *map, struct perf_evsel *evsel,
+		      struct annotation_options *options, struct arch **parch)
+{
+	struct annotation *notes = symbol__annotation(sym);
+	size_t size = symbol__size(sym);
+	int nr_pcnt = 1, err;
+
+	notes->offsets = zalloc(size * sizeof(struct annotation_line *));
+	if (notes->offsets == NULL)
+		return -1;
+
+	if (perf_evsel__is_group_event(evsel))
+		nr_pcnt = evsel->nr_members;
+
+	err = symbol__annotate(sym, map, evsel, 0, parch);
+	if (err)
+		goto out_free_offsets;
+
+	notes->options = options;
+
+	symbol__calc_percent(sym, evsel);
+
+	notes->start = map__rip_2objdump(map, sym->start);
+
+	annotation__set_offsets(notes, size);
+	annotation__mark_jump_targets(notes, sym);
+	annotation__compute_ipc(notes, size);
+	annotation__init_column_widths(notes, sym);
+	notes->nr_events = nr_pcnt;
+
+	annotation__update_column_widths(notes);
+
+	return 0;
+
+out_free_offsets:
+	zfree(&notes->offsets);
+	return -1;
+}
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index c4528e03a031..f93c805473f9 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -233,6 +233,10 @@ void symbol__annotate_zero_histograms(struct symbol *sym);
 int symbol__annotate(struct symbol *sym, struct map *map,
 		     struct perf_evsel *evsel, size_t privsize,
 		     struct arch **parch);
+int symbol__annotate2(struct symbol *sym, struct map *map,
+		      struct perf_evsel *evsel,
+		      struct annotation_options *options,
+		      struct arch **parch);
 
 enum symbol_disassemble_errno {
 	SYMBOL_ANNOTATE_ERRNO__SUCCESS		= 0,
