Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752330AbeFERvX (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:51:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:45782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752292AbeFERvU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:51:20 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 13/46] perf annotate: Stop using symbol_conf.nr_events global in symbol__hists()
Date: Tue,  5 Jun 2018 14:49:57 -0300
Message-Id: <20180605175030.32549-14-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180605175030.32549-1-acme@kernel.org>
References: <20180605175030.32549-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Since now we have evsel->evlist->nr_entries in the single place calling
this function, use it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-9mgosbqa977h39j4i9ys8t75@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index f11199f0be27..7c194b04a2da 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -21,6 +21,7 @@
 #include "debug.h"
 #include "annotate.h"
 #include "evsel.h"
+#include "evlist.h"
 #include "block-range.h"
 #include "string2.h"
 #include "arch/common.h"
@@ -867,7 +868,7 @@ static struct cyc_hist *symbol__cycles_hist(struct symbol *sym)
 	return notes->src->cycles_hist;
 }
 
-static struct annotated_source *symbol__hists(struct symbol *sym)
+static struct annotated_source *symbol__hists(struct symbol *sym, int nr_hists)
 {
 	struct annotation *notes = symbol__annotation(sym);
 
@@ -881,7 +882,7 @@ static struct annotated_source *symbol__hists(struct symbol *sym)
 	if (notes->src->histograms == NULL) {
 alloc_histograms:
 		annotated_source__alloc_histograms(notes->src, symbol__size(sym),
-						   symbol_conf.nr_events);
+						   nr_hists);
 	}
 
 	return notes->src;
@@ -895,7 +896,7 @@ static int symbol__inc_addr_samples(struct symbol *sym, struct map *map,
 
 	if (sym == NULL)
 		return 0;
-	src = symbol__hists(sym);
+	src = symbol__hists(sym, evsel->evlist->nr_entries);
 	if (src == NULL)
 		return -ENOMEM;
 	return __symbol__inc_addr_samples(sym, map, src, evsel->idx, addr, sample);
-- 
2.14.3
