Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753257AbeCXUEI (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 16:04:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:37426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752842AbeCXUEF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 16:04:05 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCB2A2183B
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
Subject: [PATCH 21/44] perf annotate: Move update_column_widths() to the generic lib
Date: Sat, 24 Mar 2018 17:01:48 -0300
Message-Id: <20180324200211.21326-22-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180324200211.21326-1-acme@kernel.org>
References: <20180324200211.21326-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Previous patch left it where it was to ease review, move it to its
right place.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-ikdjr014p7k5kachgyjrgiey@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate.c | 13 -------------
 tools/perf/util/annotate.c        | 13 +++++++++++++
 tools/perf/util/annotate.h        |  1 +
 3 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 07d0d2268008..ab4d004fc184 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -698,19 +698,6 @@ bool annotate_browser__continue_search_reverse(struct annotate_browser *browser,
 	return __annotate_browser__search_reverse(browser);
 }
 
-static void annotation__update_column_widths(struct annotation *notes)
-{
-	if (notes->options->use_offset)
-		notes->widths.target = notes->widths.min_addr;
-	else
-		notes->widths.target = notes->widths.max_addr;
-
-	notes->widths.addr = notes->widths.target;
-
-	if (notes->options->show_nr_jumps)
-		notes->widths.addr += notes->widths.jumps + 1;
-}
-
 static int annotate_browser__run(struct annotate_browser *browser,
 				 struct perf_evsel *evsel,
 				 struct hist_browser_timer *hbt)
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index b976e3951662..8a2fda80a221 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2084,6 +2084,19 @@ void annotation__set_offsets(struct annotation *notes, s64 size)
 	}
 }
 
+void annotation__update_column_widths(struct annotation *notes)
+{
+	if (notes->options->use_offset)
+		notes->widths.target = notes->widths.min_addr;
+	else
+		notes->widths.target = notes->widths.max_addr;
+
+	notes->widths.addr = notes->widths.target;
+
+	if (notes->options->show_nr_jumps)
+		notes->widths.addr += notes->widths.jumps + 1;
+}
+
 static void annotation__calc_lines(struct annotation *notes, struct map *map,
 				  struct rb_root *root, u64 start)
 {
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 0aa77c154fe3..a8bea758490a 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -203,6 +203,7 @@ static inline int annotation__pcnt_width(struct annotation *notes)
 void annotation__set_offsets(struct annotation *notes, s64 size);
 void annotation__compute_ipc(struct annotation *notes, size_t size);
 void annotation__mark_jump_targets(struct annotation *notes, struct symbol *sym);
+void annotation__update_column_widths(struct annotation *notes);
 
 static inline struct sym_hist *annotation__histogram(struct annotation *notes, int idx)
 {
-- 
2.14.3
