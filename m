Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753116AbeCXUDh (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 16:03:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:37026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753093AbeCXUDd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 16:03:33 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D0172178E
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
Subject: [PATCH 11/44] perf annotate tui: Add browser__annotation() helper
Date: Sat, 24 Mar 2018 17:01:38 -0300
Message-Id: <20180324200211.21326-12-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180324200211.21326-1-acme@kernel.org>
References: <20180324200211.21326-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To reduce the boilerplate to get to the symbol being annotated from the
struct browser ->priv area.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-ficdyqhe9esjseflvkriskwn@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate.c | 40 ++++++++++++++++-----------------------
 1 file changed, 16 insertions(+), 24 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 3b030ee4505f..c995d28d1a58 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -55,6 +55,12 @@ struct annotate_browser {
 	char			    search_bf[128];
 };
 
+static inline struct annotation *browser__annotation(struct ui_browser *browser)
+{
+	struct map_symbol *ms = browser->priv;
+	return symbol__annotation(ms->sym);
+}
+
 static inline struct browser_line *browser_line(struct annotation_line *al)
 {
 	void *ptr = al;
@@ -65,8 +71,7 @@ static inline struct browser_line *browser_line(struct annotation_line *al)
 
 static bool disasm_line__filter(struct ui_browser *browser, void *entry)
 {
-	struct map_symbol *ms = browser->priv;
-	struct annotation *notes = symbol__annotation(ms->sym);
+	struct annotation *notes = browser__annotation(browser);
 
 	if (notes->options->hide_src_code) {
 		struct annotation_line *al = list_entry(entry, struct annotation_line, node);
@@ -99,8 +104,7 @@ static int annotate_browser__set_jumps_percent_color(struct annotate_browser *br
 static void disasm_line__write(struct disasm_line *dl, struct ui_browser *browser,
 			       char *bf, size_t size)
 {
-	struct map_symbol *ms = browser->priv;
-	struct annotation *notes = symbol__annotation(ms->sym);
+	struct annotation *notes = browser__annotation(browser);
 
 	if (dl->ins.ops && dl->ins.ops->scnprintf) {
 		if (ins__is_jump(&dl->ins)) {
@@ -128,9 +132,7 @@ static void disasm_line__write(struct disasm_line *dl, struct ui_browser *browse
 static void annotate_browser__write(struct ui_browser *browser, void *entry, int row)
 {
 	struct annotate_browser *ab = container_of(browser, struct annotate_browser, b);
-	struct map_symbol *ms = browser->priv;
-	struct symbol *sym = ms->sym;
-	struct annotation *notes = symbol__annotation(sym);
+	struct annotation *notes = browser__annotation(browser);
 	struct annotation_line *al = list_entry(entry, struct annotation_line, node);
 	struct browser_line *bl = browser_line(al);
 	bool current_entry = ui_browser__is_current_entry(browser, row);
@@ -368,8 +370,7 @@ static void annotate_browser__draw_current_jump(struct ui_browser *browser)
 
 static unsigned int annotate_browser__refresh(struct ui_browser *browser)
 {
-	struct map_symbol *ms = browser->priv;
-	struct annotation *notes = symbol__annotation(ms->sym);
+	struct annotation *notes = browser__annotation(browser);
 	int ret = ui_browser__list_head_refresh(browser);
 	int pcnt_width = annotation__pcnt_width(notes);
 
@@ -438,8 +439,7 @@ static void annotate_browser__set_top(struct annotate_browser *browser,
 static void annotate_browser__set_rb_top(struct annotate_browser *browser,
 					 struct rb_node *nd)
 {
-	struct map_symbol *ms = browser->b.priv;
-	struct annotation *notes = symbol__annotation(ms->sym);
+	struct annotation *notes = browser__annotation(&browser->b);
 	struct browser_line *bpos;
 	struct annotation_line *pos;
 	u32 idx;
@@ -497,8 +497,7 @@ static void annotate_browser__calc_percent(struct annotate_browser *browser,
 
 static bool annotate_browser__toggle_source(struct annotate_browser *browser)
 {
-	struct map_symbol *ms = browser->b.priv;
-	struct annotation *notes = symbol__annotation(ms->sym);
+	struct annotation *notes = browser__annotation(&browser->b);
 	struct annotation_line *al;
 	struct browser_line *bl;
 	off_t offset = browser->b.index - browser->b.top_idx;
@@ -588,9 +587,7 @@ static
 struct disasm_line *annotate_browser__find_offset(struct annotate_browser *browser,
 					  s64 offset, s64 *idx)
 {
-	struct map_symbol *ms = browser->b.priv;
-	struct symbol *sym = ms->sym;
-	struct annotation *notes = symbol__annotation(sym);
+	struct annotation *notes = browser__annotation(&browser->b);
 	struct disasm_line *pos;
 
 	*idx = 0;
@@ -629,9 +626,7 @@ static
 struct annotation_line *annotate_browser__find_string(struct annotate_browser *browser,
 					  char *s, s64 *idx)
 {
-	struct map_symbol *ms = browser->b.priv;
-	struct symbol *sym = ms->sym;
-	struct annotation *notes = symbol__annotation(sym);
+	struct annotation *notes = browser__annotation(&browser->b);
 	struct annotation_line *al = browser->selection;
 
 	*idx = browser->b.index;
@@ -668,9 +663,7 @@ static
 struct annotation_line *annotate_browser__find_string_reverse(struct annotate_browser *browser,
 						  char *s, s64 *idx)
 {
-	struct map_symbol *ms = browser->b.priv;
-	struct symbol *sym = ms->sym;
-	struct annotation *notes = symbol__annotation(sym);
+	struct annotation *notes = browser__annotation(&browser->b);
 	struct annotation_line *al = browser->selection;
 
 	*idx = browser->b.index;
@@ -753,8 +746,7 @@ bool annotate_browser__continue_search_reverse(struct annotate_browser *browser,
 
 static void annotate_browser__update_addr_width(struct annotate_browser *browser)
 {
-	struct map_symbol *ms = browser->b.priv;
-	struct annotation *notes = symbol__annotation(ms->sym);
+	struct annotation *notes = browser__annotation(&browser->b);
 
 	if (notes->options->use_offset)
 		browser->target_width = browser->min_addr_width;
-- 
2.14.3
