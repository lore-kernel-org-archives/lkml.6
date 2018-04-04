Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755358AbeDDCXy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 22:23:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:36892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755307AbeDDCXt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 22:23:49 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 788602178F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        =?UTF-8?q?Martin=20Li=C5=A1ka?= <mliska@suse.cz>,
        Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>
Subject: [PATCH 14/17] perf annotate: Introduce annotation__scnprintf_samples_period() method
Date: Tue,  3 Apr 2018 23:21:55 -0300
Message-Id: <20180404022158.12190-15-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180404022158.12190-1-acme@kernel.org>
References: <20180404022158.12190-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To print a string using the total period (nr_events) and the number of
samples for a given annotation, i.e. for a given symbol, the counterpart
to hists__scnprintf_samples_period(), that is for all the samples in a
session (be it a live session, think 'perf top' or a perf.data file,
think 'perf report').

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Martin Liška <mliska@suse.cz>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=196935
Link: https://lkml.kernel.org/n/tip-goj2wu4fxutc8vd46mw3yg14@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 38 ++++++++++++++++++++++++++++++++++++++
 tools/perf/util/annotate.h | 12 ++++++++++++
 2 files changed, 50 insertions(+)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 3a428d7c59b9..b956bb7eabcf 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -17,6 +17,7 @@
 #include "config.h"
 #include "cache.h"
 #include "symbol.h"
+#include "units.h"
 #include "debug.h"
 #include "annotate.h"
 #include "evsel.h"
@@ -2597,6 +2598,43 @@ int symbol__annotate2(struct symbol *sym, struct map *map, struct perf_evsel *ev
 	return -1;
 }
 
+int __annotation__scnprintf_samples_period(struct annotation *notes,
+					   char *bf, size_t size,
+					   struct perf_evsel *evsel,
+					   bool show_freq)
+{
+	const char *ev_name = perf_evsel__name(evsel);
+	char ref[30] = " show reference callgraph, ";
+	char sample_freq_str[64] = "";
+	unsigned long nr_samples = 0;
+	int nr_members = 1;
+	bool enable_ref = false;
+	u64 nr_events = 0;
+	char unit;
+	int i;
+
+	if (perf_evsel__is_group_event(evsel))
+                nr_members = evsel->nr_members;
+
+	for (i = 0; i < nr_members; i++) {
+		struct sym_hist *ah = annotation__histogram(notes, evsel->idx + i);
+
+		nr_samples += ah->nr_samples;
+		nr_events  += ah->period;
+	}
+
+	if (symbol_conf.show_ref_callgraph && strstr(ev_name, "call-graph=no"))
+		enable_ref = true;
+
+	if (show_freq)
+		scnprintf(sample_freq_str, sizeof(sample_freq_str), " %d Hz,", evsel->attr.sample_freq);
+
+	nr_samples = convert_unit(nr_samples, &unit);
+	return scnprintf(bf, size, "Samples: %lu%c of event%s '%s',%s%sEvent count (approx.): %" PRIu64,
+			 nr_samples, unit, evsel->nr_members > 1 ? "s" : "",
+			 ev_name, sample_freq_str, enable_ref ? ref : " ", nr_events);
+}
+
 #define ANNOTATION__CFG(n) \
 	{ .name = #n, .value = &annotation__default_options.n, }
 
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index ff7e3df31efa..db8d09bea07e 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -151,6 +151,18 @@ double annotation_line__max_percent(struct annotation_line *al, struct annotatio
 void annotation_line__write(struct annotation_line *al, struct annotation *notes,
 			    struct annotation_write_ops *ops);
 
+int __annotation__scnprintf_samples_period(struct annotation *notes,
+					   char *bf, size_t size,
+					   struct perf_evsel *evsel,
+					   bool show_freq);
+
+static inline int annotation__scnprintf_samples_period(struct annotation *notes,
+						       char *bf, size_t size,
+						       struct perf_evsel *evsel)
+{
+	return __annotation__scnprintf_samples_period(notes, bf, size, evsel, true);
+}
+
 int disasm_line__scnprintf(struct disasm_line *dl, char *bf, size_t size, bool raw);
 size_t disasm__fprintf(struct list_head *head, FILE *fp);
 void symbol__calc_percent(struct symbol *sym, struct perf_evsel *evsel);
-- 
2.14.3
