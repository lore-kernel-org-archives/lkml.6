Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752365AbeFERv0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:51:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:45824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752298AbeFERvX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:51:23 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 14/46] perf annotate: Replace symbol__alloc_hists() with symbol__hists()
Date: Tue,  5 Jun 2018 14:49:58 -0300
Message-Id: <20180605175030.32549-15-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180605175030.32549-1-acme@kernel.org>
References: <20180605175030.32549-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Its a bit shorter, so ditch the old symbol__alloc_hists() function.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-m7tienxk7dijh5ln62yln1m9@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-top.c          |  8 +-------
 tools/perf/ui/browsers/annotate.c |  2 +-
 tools/perf/util/annotate.c        | 21 ++-------------------
 tools/perf/util/annotate.h        |  2 +-
 4 files changed, 5 insertions(+), 28 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index bc71e899096d..04fe04885e99 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -123,14 +123,9 @@ static int perf_top__parse_source(struct perf_top *top, struct hist_entry *he)
 	}
 
 	notes = symbol__annotation(sym);
-	if (notes->src != NULL) {
-		pthread_mutex_lock(&notes->lock);
-		goto out_assign;
-	}
-
 	pthread_mutex_lock(&notes->lock);
 
-	if (symbol__alloc_hist(sym) < 0) {
+	if (!symbol__hists(sym, top->evlist->nr_entries)) {
 		pthread_mutex_unlock(&notes->lock);
 		pr_err("Not enough memory for annotating '%s' symbol!\n",
 		       sym->name);
@@ -140,7 +135,6 @@ static int perf_top__parse_source(struct perf_top *top, struct hist_entry *he)
 
 	err = symbol__annotate(sym, map, evsel, 0, NULL);
 	if (err == 0) {
-out_assign:
 		top->sym_filter_entry = he;
 	} else {
 		char msg[BUFSIZ];
diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 8be40fa903aa..3bfe17e176fe 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -410,7 +410,7 @@ static bool annotate_browser__callq(struct annotate_browser *browser,
 	notes = symbol__annotation(dl->ops.target.sym);
 	pthread_mutex_lock(&notes->lock);
 
-	if (notes->src == NULL && symbol__alloc_hist(dl->ops.target.sym) < 0) {
+	if (!symbol__hists(dl->ops.target.sym, evsel->evlist->nr_entries)) {
 		pthread_mutex_unlock(&notes->lock);
 		ui__warning("Not enough memory for annotating '%s' symbol!\n",
 			    dl->ops.target.sym->name);
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 7c194b04a2da..bcd5d3e17b85 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -689,7 +689,7 @@ static struct annotated_source *annotated_source__new(void)
 	return src;
 }
 
-static void annotated_source__delete(struct annotated_source *src)
+static __maybe_unused void annotated_source__delete(struct annotated_source *src)
 {
 	if (src == NULL)
 		return;
@@ -729,23 +729,6 @@ static int annotated_source__alloc_histograms(struct annotated_source *src,
 	return src->histograms ? 0 : -1;
 }
 
-int symbol__alloc_hist(struct symbol *sym)
-{
-	size_t size = symbol__size(sym);
-	struct annotation *notes = symbol__annotation(sym);
-
-	notes->src = annotated_source__new();
-	if (notes->src == NULL)
-		return -1;
-
-	if (annotated_source__alloc_histograms(notes->src, size, symbol_conf.nr_events) < 0) {
-		annotated_source__delete(notes->src);
-		notes->src = NULL;
-		return -1;
-	}
-	return 0;
-}
-
 /* The cycles histogram is lazily allocated. */
 static int symbol__alloc_hist_cycles(struct symbol *sym)
 {
@@ -868,7 +851,7 @@ static struct cyc_hist *symbol__cycles_hist(struct symbol *sym)
 	return notes->src->cycles_hist;
 }
 
-static struct annotated_source *symbol__hists(struct symbol *sym, int nr_hists)
+struct annotated_source *symbol__hists(struct symbol *sym, int nr_hists)
 {
 	struct annotation *notes = symbol__annotation(sym);
 
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 2a73f9084930..7ad503fbff74 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -292,7 +292,7 @@ int addr_map_symbol__account_cycles(struct addr_map_symbol *ams,
 int hist_entry__inc_addr_samples(struct hist_entry *he, struct perf_sample *sample,
 				 struct perf_evsel *evsel, u64 addr);
 
-int symbol__alloc_hist(struct symbol *sym);
+struct annotated_source *symbol__hists(struct symbol *sym, int nr_hists);
 void symbol__annotate_zero_histograms(struct symbol *sym);
 
 int symbol__annotate(struct symbol *sym, struct map *map,
-- 
2.14.3
