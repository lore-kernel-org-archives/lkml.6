Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752734AbeFESFY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 14:05:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:45646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752133AbeFERvJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:51:09 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 09/46] perf annotate: Introduce annotated_source__alloc_histograms
Date: Tue,  5 Jun 2018 14:49:53 -0300
Message-Id: <20180605175030.32549-10-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180605175030.32549-1-acme@kernel.org>
References: <20180605175030.32549-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

So that we can call it independently, in contexts were we know we
already have notes->src allocated.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-f5fn7tr1asey6g013wavpn4c@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index f6c9bb29ac84..a6fa49bf879b 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -697,10 +697,9 @@ static void annotated_source__delete(struct annotated_source *src)
 	free(src);
 }
 
-int symbol__alloc_hist(struct symbol *sym)
+static int annotated_source__alloc_histograms(struct annotated_source *src,
+					      size_t size, int nr_hists)
 {
-	struct annotation *notes = symbol__annotation(sym);
-	size_t size = symbol__size(sym);
 	size_t sizeof_sym_hist;
 
 	/*
@@ -720,20 +719,29 @@ int symbol__alloc_hist(struct symbol *sym)
 	sizeof_sym_hist = (sizeof(struct sym_hist) + size * sizeof(struct sym_hist_entry));
 
 	/* Check for overflow in zalloc argument */
-	if (sizeof_sym_hist > SIZE_MAX / symbol_conf.nr_events)
+	if (sizeof_sym_hist > SIZE_MAX / nr_hists)
 		return -1;
 
+	src->sizeof_sym_hist = sizeof_sym_hist;
+	src->nr_histograms   = nr_hists;
+	src->histograms	     = calloc(nr_hists, sizeof_sym_hist) ;
+	return src->histograms ? 0 : -1;
+}
+
+int symbol__alloc_hist(struct symbol *sym)
+{
+	size_t size = symbol__size(sym);
+	struct annotation *notes = symbol__annotation(sym);
+
 	notes->src = annotated_source__new();
 	if (notes->src == NULL)
 		return -1;
-	notes->src->histograms = calloc(symbol_conf.nr_events, sizeof_sym_hist);
-	if (notes->src->histograms == NULL) {
+
+	if (annotated_source__alloc_histograms(notes->src, size, symbol_conf.nr_events) < 0) {
 		annotated_source__delete(notes->src);
 		notes->src = NULL;
 		return -1;
 	}
-	notes->src->sizeof_sym_hist = sizeof_sym_hist;
-	notes->src->nr_histograms   = symbol_conf.nr_events;
 	return 0;
 }
 
-- 
2.14.3
