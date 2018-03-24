Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753513AbeCXUK5 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 16:10:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:37484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753266AbeCXUEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 16:04:12 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9B162183F
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
Subject: [PATCH 23/44] perf annotate: Introduce symbol__annotate2 method
Date: Sat, 24 Mar 2018 17:01:50 -0300
Message-Id: <20180324200211.21326-24-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180324200211.21326-1-acme@kernel.org>
References: <20180324200211.21326-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
-- 
2.14.3
