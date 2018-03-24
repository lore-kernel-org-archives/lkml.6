Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753344AbeCXUEd (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 16:04:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:37700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752842AbeCXUEb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 16:04:31 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4FA72178E
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
Subject: [PATCH 29/44] perf annotate: Introduce annotation_line__filter()
Date: Sat, 24 Mar 2018 17:01:56 -0300
Message-Id: <20180324200211.21326-30-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180324200211.21326-1-acme@kernel.org>
References: <20180324200211.21326-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Out of the TUI logic that allows toggling the presentation of source
code lines.

Will be used in the upcoming --stdio2 mode.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-g0ckz9ajy6unswrv2iy39mxk@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate.c | 19 +++++++------------
 tools/perf/util/annotate.h        |  4 ++++
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index bed647807d37..74a26f4e9b06 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -48,14 +48,8 @@ static inline struct annotation *browser__annotation(struct ui_browser *browser)
 static bool disasm_line__filter(struct ui_browser *browser, void *entry)
 {
 	struct annotation *notes = browser__annotation(browser);
-
-	if (notes->options->hide_src_code) {
-		struct annotation_line *al = list_entry(entry, struct annotation_line, node);
-
-		return al->offset == -1;
-	}
-
-	return false;
+	struct annotation_line *al = list_entry(entry, struct annotation_line, node);
+	return annotation_line__filter(al, notes);
 }
 
 static int ui_browser__jumps_percent_color(struct ui_browser *browser, int nr, bool current)
@@ -268,6 +262,7 @@ static void disasm_rb_tree__insert(struct rb_root *root, struct annotation_line
 static void annotate_browser__set_top(struct annotate_browser *browser,
 				      struct annotation_line *pos, u32 idx)
 {
+	struct annotation *notes = browser__annotation(&browser->b);
 	unsigned back;
 
 	ui_browser__refresh_dimensions(&browser->b);
@@ -277,7 +272,7 @@ static void annotate_browser__set_top(struct annotate_browser *browser,
 	while (browser->b.top_idx != 0 && back != 0) {
 		pos = list_entry(pos->node.prev, struct annotation_line, node);
 
-		if (disasm_line__filter(&browser->b, &pos->node))
+		if (annotation_line__filter(pos, notes))
 			continue;
 
 		--browser->b.top_idx;
@@ -440,7 +435,7 @@ struct disasm_line *annotate_browser__find_offset(struct annotate_browser *brows
 	list_for_each_entry(pos, &notes->src->source, al.node) {
 		if (pos->al.offset == offset)
 			return pos;
-		if (!disasm_line__filter(&browser->b, &pos->al.node))
+		if (!annotation_line__filter(&pos->al, notes))
 			++*idx;
 	}
 
@@ -477,7 +472,7 @@ struct annotation_line *annotate_browser__find_string(struct annotate_browser *b
 
 	*idx = browser->b.index;
 	list_for_each_entry_continue(al, &notes->src->source, node) {
-		if (disasm_line__filter(&browser->b, &al->node))
+		if (annotation_line__filter(al, notes))
 			continue;
 
 		++*idx;
@@ -514,7 +509,7 @@ struct annotation_line *annotate_browser__find_string_reverse(struct annotate_br
 
 	*idx = browser->b.index;
 	list_for_each_entry_continue_reverse(al, &notes->src->source, node) {
-		if (disasm_line__filter(&browser->b, &al->node))
+		if (annotation_line__filter(al, notes))
 			continue;
 
 		--*idx;
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 6fbb34b9bd77..165845de1243 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -215,6 +215,10 @@ static inline int annotation__pcnt_width(struct annotation *notes)
 	return (notes->options->show_total_period ? 12 : 7) * notes->nr_events;
 }
 
+static inline bool annotation_line__filter(struct annotation_line *al, struct annotation *notes)
+{
+	return notes->options->hide_src_code && al->offset == -1;
+}
 
 void annotation__set_offsets(struct annotation *notes, s64 size);
 void annotation__compute_ipc(struct annotation *notes, size_t size);
-- 
2.14.3
