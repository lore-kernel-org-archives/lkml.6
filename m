Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752144AbeFERvJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:51:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:45566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751852AbeFERvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:51:03 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 07/46] perf annotate: Split allocation of annotated_source struct
Date: Tue,  5 Jun 2018 14:49:51 -0300
Message-Id: <20180605175030.32549-8-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180605175030.32549-1-acme@kernel.org>
References: <20180605175030.32549-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

So that we can allocate just the notes->src->cyc_hist, that, unlike
notes->src->histograms, is not per event, and in paths where we
need to lazily allocate notes->src->cyc_hist we don't have the
number of events handy to also allocate ->histograms.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-tsx7dhxzpi0criyx0sio3pz3@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 10 +++++++---
 tools/perf/util/annotate.h |  6 +++---
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index a7221f9fa504..f0c6941bca6c 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -701,13 +701,17 @@ int symbol__alloc_hist(struct symbol *sym)
 	sizeof_sym_hist = (sizeof(struct sym_hist) + size * sizeof(struct sym_hist_entry));
 
 	/* Check for overflow in zalloc argument */
-	if (sizeof_sym_hist > (SIZE_MAX - sizeof(*notes->src))
-				/ symbol_conf.nr_events)
+	if (sizeof_sym_hist > SIZE_MAX / symbol_conf.nr_events)
 		return -1;
 
-	notes->src = zalloc(sizeof(*notes->src) + symbol_conf.nr_events * sizeof_sym_hist);
+	notes->src = zalloc(sizeof(*notes->src));
 	if (notes->src == NULL)
 		return -1;
+	notes->src->histograms = calloc(symbol_conf.nr_events, sizeof_sym_hist);
+	if (notes->src->histograms == NULL) {
+		zfree(&notes->src);
+		return -1;
+	}
 	notes->src->sizeof_sym_hist = sizeof_sym_hist;
 	notes->src->nr_histograms   = symbol_conf.nr_events;
 	INIT_LIST_HEAD(&notes->src->source);
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index aef9eae4f125..94b60e34c3a7 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -201,7 +201,7 @@ struct cyc_hist {
 
 /** struct annotated_source - symbols with hits have this attached as in sannotation
  *
- * @histogram: Array of addr hit histograms per event being monitored
+ * @histograms: Array of addr hit histograms per event being monitored
  * @lines: If 'print_lines' is specified, per source code line percentages
  * @source: source parsed from a disassembler like objdump -dS
  * @cyc_hist: Average cycles per basic block
@@ -217,7 +217,7 @@ struct annotated_source {
 	int    		   nr_histograms;
 	size_t		   sizeof_sym_hist;
 	struct cyc_hist	   *cycles_hist;
-	struct sym_hist	   histograms[0];
+	struct sym_hist	   *histograms;
 };
 
 struct annotation {
@@ -269,7 +269,7 @@ void annotation__init_column_widths(struct annotation *notes, struct symbol *sym
 
 static inline struct sym_hist *annotation__histogram(struct annotation *notes, int idx)
 {
-	return (((void *)&notes->src->histograms) +
+	return (((void *)notes->src->histograms) +
 	 	(notes->src->sizeof_sym_hist * idx));
 }
 
-- 
2.14.3
