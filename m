Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753187AbeCXUDw (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 16:03:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:37226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753133AbeCXUDt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 16:03:49 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1C4B2172B
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
Subject: [PATCH 16/44] perf annotate: Nuke struct browser_line
Date: Sat, 24 Mar 2018 17:01:43 -0300
Message-Id: <20180324200211.21326-17-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180324200211.21326-1-acme@kernel.org>
References: <20180324200211.21326-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The information in there are all related to things already moved to
struct annotation, so move those members to struct annotation_line.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-uc2b9c8iocvuuvbl7hyind84@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate.c | 66 ++++++++++++---------------------------
 tools/perf/util/annotate.h        |  2 ++
 2 files changed, 22 insertions(+), 46 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 58be0cecb081..50f8e671644f 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -22,11 +22,6 @@ struct disasm_line_samples {
 	struct sym_hist_entry he;
 };
 
-struct browser_line {
-	u32	idx;
-	int	idx_asm;
-};
-
 static struct annotation_options annotate_browser__opts = {
 	.use_offset	= true,
 	.jump_arrows	= true,
@@ -58,14 +53,6 @@ static inline struct annotation *browser__annotation(struct ui_browser *browser)
 	return symbol__annotation(ms->sym);
 }
 
-static inline struct browser_line *browser_line(struct annotation_line *al)
-{
-	void *ptr = al;
-
-	ptr = container_of(al, struct disasm_line, al);
-	return ptr - sizeof(struct browser_line);
-}
-
 static bool disasm_line__filter(struct ui_browser *browser, void *entry)
 {
 	struct annotation *notes = browser__annotation(browser);
@@ -285,7 +272,6 @@ static void annotate_browser__draw_current_jump(struct ui_browser *browser)
 	struct annotate_browser *ab = container_of(browser, struct annotate_browser, b);
 	struct disasm_line *cursor = disasm_line(ab->selection);
 	struct annotation_line *target;
-	struct browser_line *btarget, *bcursor;
 	unsigned int from, to;
 	struct map_symbol *ms = ab->b.priv;
 	struct symbol *sym = ms->sym;
@@ -327,15 +313,12 @@ static void annotate_browser__draw_current_jump(struct ui_browser *browser)
 		return;
 	}
 
-	bcursor = browser_line(&cursor->al);
-	btarget = browser_line(target);
-
 	if (notes->options->hide_src_code) {
-		from = bcursor->idx_asm;
-		to = btarget->idx_asm;
+		from = cursor->al.idx_asm;
+		to = target->idx_asm;
 	} else {
-		from = (u64)bcursor->idx;
-		to = (u64)btarget->idx;
+		from = (u64)cursor->al.idx;
+		to = (u64)target->idx;
 	}
 
 	width = annotation__cycles_width(notes);
@@ -425,16 +408,11 @@ static void annotate_browser__set_rb_top(struct annotate_browser *browser,
 					 struct rb_node *nd)
 {
 	struct annotation *notes = browser__annotation(&browser->b);
-	struct browser_line *bpos;
-	struct annotation_line *pos;
-	u32 idx;
-
-	pos = rb_entry(nd, struct annotation_line, rb_node);
-	bpos = browser_line(pos);
+	struct annotation_line * pos = rb_entry(nd, struct annotation_line, rb_node);
+	u32 idx = pos->idx;
 
-	idx = bpos->idx;
 	if (notes->options->hide_src_code)
-		idx = bpos->idx_asm;
+		idx = pos->idx_asm;
 	annotate_browser__set_top(browser, pos, idx);
 	browser->curr_hot = nd;
 }
@@ -484,37 +462,35 @@ static bool annotate_browser__toggle_source(struct annotate_browser *browser)
 {
 	struct annotation *notes = browser__annotation(&browser->b);
 	struct annotation_line *al;
-	struct browser_line *bl;
 	off_t offset = browser->b.index - browser->b.top_idx;
 
 	browser->b.seek(&browser->b, offset, SEEK_CUR);
 	al = list_entry(browser->b.top, struct annotation_line, node);
-	bl = browser_line(al);
 
 	if (notes->options->hide_src_code) {
-		if (bl->idx_asm < offset)
-			offset = bl->idx;
+		if (al->idx_asm < offset)
+			offset = al->idx;
 
 		browser->b.nr_entries = browser->nr_entries;
 		notes->options->hide_src_code = false;
 		browser->b.seek(&browser->b, -offset, SEEK_CUR);
-		browser->b.top_idx = bl->idx - offset;
-		browser->b.index = bl->idx;
+		browser->b.top_idx = al->idx - offset;
+		browser->b.index = al->idx;
 	} else {
-		if (bl->idx_asm < 0) {
+		if (al->idx_asm < 0) {
 			ui_helpline__puts("Only available for assembly lines.");
 			browser->b.seek(&browser->b, -offset, SEEK_CUR);
 			return false;
 		}
 
-		if (bl->idx_asm < offset)
-			offset = bl->idx_asm;
+		if (al->idx_asm < offset)
+			offset = al->idx_asm;
 
 		browser->b.nr_entries = browser->nr_asm_entries;
 		notes->options->hide_src_code = true;
 		browser->b.seek(&browser->b, -offset, SEEK_CUR);
-		browser->b.top_idx = bl->idx_asm - offset;
-		browser->b.index = bl->idx_asm;
+		browser->b.top_idx = al->idx_asm - offset;
+		browser->b.index = al->idx_asm;
 	}
 
 	return true;
@@ -1003,7 +979,7 @@ int symbol__tui_annotate(struct symbol *sym, struct map *map,
 	if (perf_evsel__is_group_event(evsel))
 		nr_pcnt = evsel->nr_members;
 
-	err = symbol__annotate(sym, map, evsel, sizeof(struct browser_line), &browser.arch);
+	err = symbol__annotate(sym, map, evsel, 0, &browser.arch);
 	if (err) {
 		char msg[BUFSIZ];
 		symbol__strerror_disassemble(sym, map, err, msg, sizeof(msg));
@@ -1018,15 +994,13 @@ int symbol__tui_annotate(struct symbol *sym, struct map *map,
 	browser.start = map__rip_2objdump(map, sym->start);
 
 	list_for_each_entry(al, &notes->src->source, node) {
-		struct browser_line *bpos;
 		size_t line_len = strlen(al->line);
 
 		if (browser.b.width < line_len)
 			browser.b.width = line_len;
-		bpos = browser_line(al);
-		bpos->idx = browser.nr_entries++;
+		al->idx = browser.nr_entries++;
 		if (al->offset != -1) {
-			bpos->idx_asm = browser.nr_asm_entries++;
+			al->idx_asm = browser.nr_asm_entries++;
 			/*
 			 * FIXME: short term bandaid to cope with assembly
 			 * routines that comes with labels in the same column
@@ -1037,7 +1011,7 @@ int symbol__tui_annotate(struct symbol *sym, struct map *map,
 			if (al->offset < (s64)size)
 				notes->offsets[al->offset] = al;
 		} else
-			bpos->idx_asm = -1;
+			al->idx_asm = -1;
 	}
 
 	annotation__mark_jump_targets(notes, sym);
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index ab4a8b7710a0..2018a47790c7 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -95,6 +95,8 @@ struct annotation_line {
 	u64			 cycles;
 	size_t			 privsize;
 	char			*path;
+	u32			 idx;
+	int			 idx_asm;
 	int			 samples_nr;
 	struct annotation_data	 samples[0];
 };
-- 
2.14.3
