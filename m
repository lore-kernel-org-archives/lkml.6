Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753291AbeCXUER (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 16:04:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:37522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752842AbeCXUEP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 16:04:15 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0021F21840
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
Subject: [PATCH 24/44] perf annotate: Introduce annotation_line__max_percent()
Date: Sat, 24 Mar 2018 17:01:51 -0300
Message-Id: <20180324200211.21326-25-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180324200211.21326-1-acme@kernel.org>
References: <20180324200211.21326-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Out of the annotate_browser__write() routine, to be used in the --stdio2
mode.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-0he0wyy4haswqi1qb35x37do@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate.c |  7 +------
 tools/perf/util/annotate.c        | 14 ++++++++++++++
 tools/perf/util/annotate.h        |  3 +++
 3 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index ab21739f27ae..05f79f36e906 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -117,15 +117,10 @@ static void annotate_browser__write(struct ui_browser *browser, void *entry, int
 	int width = browser->width, printed;
 	int i, pcnt_width = annotation__pcnt_width(notes),
 	       cycles_width = annotation__cycles_width(notes);
-	double percent_max = 0.0;
+	double percent_max = annotation_line__max_percent(al, notes);
 	char bf[256];
 	bool show_title = false;
 
-	for (i = 0; i < notes->nr_events; i++) {
-		if (al->samples[i].percent > percent_max)
-			percent_max = al->samples[i].percent;
-	}
-
 	if ((row == 0) && (al->offset == -1 || percent_max == 0.0)) {
 		if (notes->have_cycles) {
 			if (al->ipc == 0.0 && al->cycles == 0)
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 7ad6400a0d4f..3bd6f9b0147f 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2184,6 +2184,20 @@ bool ui__has_annotation(void)
 	return use_browser == 1 && perf_hpp_list.sym;
 }
 
+
+double annotation_line__max_percent(struct annotation_line *al, struct annotation *notes)
+{
+	double percent_max = 0.0;
+	int i;
+
+	for (i = 0; i < notes->nr_events; i++) {
+		if (al->samples[i].percent > percent_max)
+			percent_max = al->samples[i].percent;
+	}
+
+	return percent_max;
+}
+
 int symbol__annotate2(struct symbol *sym, struct map *map, struct perf_evsel *evsel,
 		      struct annotation_options *options, struct arch **parch)
 {
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index f93c805473f9..83484e236f33 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -124,6 +124,9 @@ bool disasm_line__is_valid_jump(struct disasm_line *dl, struct symbol *sym);
 void disasm_line__free(struct disasm_line *dl);
 struct annotation_line *
 annotation_line__next(struct annotation_line *pos, struct list_head *head);
+
+double annotation_line__max_percent(struct annotation_line *al, struct annotation *notes);
+
 int disasm_line__scnprintf(struct disasm_line *dl, char *bf, size_t size, bool raw);
 size_t disasm__fprintf(struct list_head *head, FILE *fp);
 void symbol__calc_percent(struct symbol *sym, struct perf_evsel *evsel);
-- 
2.14.3
