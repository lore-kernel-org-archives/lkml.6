Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752110AbeFERvB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:51:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:45488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751852AbeFERu5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:50:57 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 05/46] perf annotate: Pass perf_evsel instead of just evsel->idx
Date: Tue,  5 Jun 2018 14:49:49 -0300
Message-Id: <20180605175030.32549-6-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180605175030.32549-1-acme@kernel.org>
References: <20180605175030.32549-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The code gets shorter and we'll be able to use evsel->evlist in a
followup patch.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-t0s7vy19wq5kak74kavm8swf@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-annotate.c |  6 +++---
 tools/perf/builtin-report.c   | 17 ++++++++---------
 tools/perf/builtin-top.c      |  6 +++---
 tools/perf/util/annotate.c    | 12 ++++++------
 tools/perf/util/annotate.h    |  4 ++--
 5 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index da5704240239..2b21bbcd70ea 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -162,12 +162,12 @@ static int hist_iter__branch_callback(struct hist_entry_iter *iter,
 	hist__account_cycles(sample->branch_stack, al, sample, false);
 
 	bi = he->branch_info;
-	err = addr_map_symbol__inc_samples(&bi->from, sample, evsel->idx);
+	err = addr_map_symbol__inc_samples(&bi->from, sample, evsel);
 
 	if (err)
 		goto out;
 
-	err = addr_map_symbol__inc_samples(&bi->to, sample, evsel->idx);
+	err = addr_map_symbol__inc_samples(&bi->to, sample, evsel);
 
 out:
 	return err;
@@ -249,7 +249,7 @@ static int perf_evsel__add_sample(struct perf_evsel *evsel,
 	if (he == NULL)
 		return -ENOMEM;
 
-	ret = hist_entry__inc_addr_samples(he, sample, evsel->idx, al->addr);
+	ret = hist_entry__inc_addr_samples(he, sample, evsel, al->addr);
 	hists__inc_nr_samples(hists, true);
 	return ret;
 }
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index ad978e3ee2b8..7a689c933f04 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -136,26 +136,25 @@ static int hist_iter__report_callback(struct hist_entry_iter *iter,
 
 	if (sort__mode == SORT_MODE__BRANCH) {
 		bi = he->branch_info;
-		err = addr_map_symbol__inc_samples(&bi->from, sample, evsel->idx);
+		err = addr_map_symbol__inc_samples(&bi->from, sample, evsel);
 		if (err)
 			goto out;
 
-		err = addr_map_symbol__inc_samples(&bi->to, sample, evsel->idx);
+		err = addr_map_symbol__inc_samples(&bi->to, sample, evsel);
 
 	} else if (rep->mem_mode) {
 		mi = he->mem_info;
-		err = addr_map_symbol__inc_samples(&mi->daddr, sample, evsel->idx);
+		err = addr_map_symbol__inc_samples(&mi->daddr, sample, evsel);
 		if (err)
 			goto out;
 
-		err = hist_entry__inc_addr_samples(he, sample, evsel->idx, al->addr);
+		err = hist_entry__inc_addr_samples(he, sample, evsel, al->addr);
 
 	} else if (symbol_conf.cumulate_callchain) {
 		if (single)
-			err = hist_entry__inc_addr_samples(he, sample, evsel->idx,
-							   al->addr);
+			err = hist_entry__inc_addr_samples(he, sample, evsel, al->addr);
 	} else {
-		err = hist_entry__inc_addr_samples(he, sample, evsel->idx, al->addr);
+		err = hist_entry__inc_addr_samples(he, sample, evsel, al->addr);
 	}
 
 out:
@@ -181,11 +180,11 @@ static int hist_iter__branch_callback(struct hist_entry_iter *iter,
 			     rep->nonany_branch_mode);
 
 	bi = he->branch_info;
-	err = addr_map_symbol__inc_samples(&bi->from, sample, evsel->idx);
+	err = addr_map_symbol__inc_samples(&bi->from, sample, evsel);
 	if (err)
 		goto out;
 
-	err = addr_map_symbol__inc_samples(&bi->to, sample, evsel->idx);
+	err = addr_map_symbol__inc_samples(&bi->to, sample, evsel);
 
 	branch_type_count(&rep->brtype_stat, &bi->flags,
 			  bi->from.addr, bi->to.addr);
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 7a349fcd3864..bc71e899096d 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -188,7 +188,7 @@ static void ui__warn_map_erange(struct map *map, struct symbol *sym, u64 ip)
 static void perf_top__record_precise_ip(struct perf_top *top,
 					struct hist_entry *he,
 					struct perf_sample *sample,
-					int counter, u64 ip)
+					struct perf_evsel *evsel, u64 ip)
 {
 	struct annotation *notes;
 	struct symbol *sym = he->ms.sym;
@@ -204,7 +204,7 @@ static void perf_top__record_precise_ip(struct perf_top *top,
 	if (pthread_mutex_trylock(&notes->lock))
 		return;
 
-	err = hist_entry__inc_addr_samples(he, sample, counter, ip);
+	err = hist_entry__inc_addr_samples(he, sample, evsel, ip);
 
 	pthread_mutex_unlock(&notes->lock);
 
@@ -691,7 +691,7 @@ static int hist_iter__top_callback(struct hist_entry_iter *iter,
 	struct perf_evsel *evsel = iter->evsel;
 
 	if (perf_hpp_list.sym && single)
-		perf_top__record_precise_ip(top, he, iter->sample, evsel->idx, al->addr);
+		perf_top__record_precise_ip(top, he, iter->sample, evsel, al->addr);
 
 	hist__account_cycles(iter->sample->branch_stack, al, iter->sample,
 		     !(top->record_opts.branch_stack & PERF_SAMPLE_BRANCH_ANY));
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 71897689dacf..0f5ed6091e00 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -836,7 +836,7 @@ static struct annotation *symbol__get_annotation(struct symbol *sym, bool cycles
 }
 
 static int symbol__inc_addr_samples(struct symbol *sym, struct map *map,
-				    int evidx, u64 addr,
+				    struct perf_evsel *evsel, u64 addr,
 				    struct perf_sample *sample)
 {
 	struct annotation *notes;
@@ -846,7 +846,7 @@ static int symbol__inc_addr_samples(struct symbol *sym, struct map *map,
 	notes = symbol__get_annotation(sym, false);
 	if (notes == NULL)
 		return -ENOMEM;
-	return __symbol__inc_addr_samples(sym, map, notes, evidx, addr, sample);
+	return __symbol__inc_addr_samples(sym, map, notes, evsel->idx, addr, sample);
 }
 
 static int symbol__account_cycles(u64 addr, u64 start,
@@ -974,15 +974,15 @@ void annotation__compute_ipc(struct annotation *notes, size_t size)
 }
 
 int addr_map_symbol__inc_samples(struct addr_map_symbol *ams, struct perf_sample *sample,
-				 int evidx)
+				 struct perf_evsel *evsel)
 {
-	return symbol__inc_addr_samples(ams->sym, ams->map, evidx, ams->al_addr, sample);
+	return symbol__inc_addr_samples(ams->sym, ams->map, evsel, ams->al_addr, sample);
 }
 
 int hist_entry__inc_addr_samples(struct hist_entry *he, struct perf_sample *sample,
-				 int evidx, u64 ip)
+				 struct perf_evsel *evsel, u64 ip)
 {
-	return symbol__inc_addr_samples(he->ms.sym, he->ms.map, evidx, ip, sample);
+	return symbol__inc_addr_samples(he->ms.sym, he->ms.map, evsel, ip, sample);
 }
 
 static void disasm_line__init_ins(struct disasm_line *dl, struct arch *arch, struct map_symbol *ms)
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 5080b6dd98b8..aef9eae4f125 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -279,14 +279,14 @@ static inline struct annotation *symbol__annotation(struct symbol *sym)
 }
 
 int addr_map_symbol__inc_samples(struct addr_map_symbol *ams, struct perf_sample *sample,
-				 int evidx);
+				 struct perf_evsel *evsel);
 
 int addr_map_symbol__account_cycles(struct addr_map_symbol *ams,
 				    struct addr_map_symbol *start,
 				    unsigned cycles);
 
 int hist_entry__inc_addr_samples(struct hist_entry *he, struct perf_sample *sample,
-				 int evidx, u64 addr);
+				 struct perf_evsel *evsel, u64 addr);
 
 int symbol__alloc_hist(struct symbol *sym);
 void symbol__annotate_zero_histograms(struct symbol *sym);
-- 
2.14.3
