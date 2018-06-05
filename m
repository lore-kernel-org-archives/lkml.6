Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752600AbeFERvq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:51:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:46064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752463AbeFERvo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:51:44 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 21/46] perf annotate: Pass annotation_options to symbol__annotate()
Date: Tue,  5 Jun 2018 14:50:05 -0300
Message-Id: <20180605175030.32549-22-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180605175030.32549-1-acme@kernel.org>
References: <20180605175030.32549-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Now all callers to symbol__disassemble() can hand it the per-tool
annotation_options, which will allow us to remove lots of stuff
from symbol_options, the kitchen sink of perf configs, reducing its
size and getting annotation specific stuff grouped together.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-vpr7ys7ggvs2fzpg8wbjcw7e@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-top.c     | 2 +-
 tools/perf/ui/gtk/annotate.c | 2 +-
 tools/perf/util/annotate.c   | 7 +++++--
 tools/perf/util/annotate.h   | 1 +
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 5e58cd4de90b..2c14ca61c657 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -133,7 +133,7 @@ static int perf_top__parse_source(struct perf_top *top, struct hist_entry *he)
 		return err;
 	}
 
-	err = symbol__annotate(sym, map, evsel, 0, NULL);
+	err = symbol__annotate(sym, map, evsel, 0, &top->annotation_opts, NULL);
 	if (err == 0) {
 		top->sym_filter_entry = he;
 	} else {
diff --git a/tools/perf/ui/gtk/annotate.c b/tools/perf/ui/gtk/annotate.c
index aeeaf15029f0..48428c9acd89 100644
--- a/tools/perf/ui/gtk/annotate.c
+++ b/tools/perf/ui/gtk/annotate.c
@@ -169,7 +169,7 @@ static int symbol__gtk_annotate(struct symbol *sym, struct map *map,
 	if (map->dso->annotate_warned)
 		return -1;
 
-	err = symbol__annotate(sym, map, evsel, 0, NULL);
+	err = symbol__annotate(sym, map, evsel, 0, &annotation__default_options, NULL);
 	if (err) {
 		char msg[BUFSIZ];
 		symbol__strerror_disassemble(sym, map, err, msg, sizeof(msg));
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index abcc7e24c365..502f9d124a44 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1067,6 +1067,7 @@ struct annotate_args {
 	struct arch		*arch;
 	struct map_symbol	 ms;
 	struct perf_evsel	*evsel;
+	struct annotation_options *options;
 	s64			 offset;
 	char			*line;
 	int			 line_nr;
@@ -1803,11 +1804,13 @@ void symbol__calc_percent(struct symbol *sym, struct perf_evsel *evsel)
 
 int symbol__annotate(struct symbol *sym, struct map *map,
 		     struct perf_evsel *evsel, size_t privsize,
+		     struct annotation_options *options,
 		     struct arch **parch)
 {
 	struct annotate_args args = {
 		.privsize	= privsize,
 		.evsel		= evsel,
+		.options	= options,
 	};
 	struct perf_env *env = perf_evsel__env(evsel);
 	const char *arch_name = perf_env__arch(env);
@@ -2409,7 +2412,7 @@ int symbol__tty_annotate(struct symbol *sym, struct map *map,
 	struct dso *dso = map->dso;
 	struct rb_root source_line = RB_ROOT;
 
-	if (symbol__annotate(sym, map, evsel, 0, NULL) < 0)
+	if (symbol__annotate(sym, map, evsel, 0, opts, NULL) < 0)
 		return -1;
 
 	symbol__calc_percent(sym, evsel);
@@ -2655,7 +2658,7 @@ int symbol__annotate2(struct symbol *sym, struct map *map, struct perf_evsel *ev
 	if (perf_evsel__is_group_event(evsel))
 		nr_pcnt = evsel->nr_members;
 
-	err = symbol__annotate(sym, map, evsel, 0, parch);
+	err = symbol__annotate(sym, map, evsel, 0, options, parch);
 	if (err)
 		goto out_free_offsets;
 
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 20f3326cc640..013d414b0e57 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -306,6 +306,7 @@ void symbol__annotate_zero_histograms(struct symbol *sym);
 
 int symbol__annotate(struct symbol *sym, struct map *map,
 		     struct perf_evsel *evsel, size_t privsize,
+		     struct annotation_options *options,
 		     struct arch **parch);
 int symbol__annotate2(struct symbol *sym, struct map *map,
 		      struct perf_evsel *evsel,
-- 
2.14.3
