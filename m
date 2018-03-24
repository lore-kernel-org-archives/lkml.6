Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753220AbeCXUD7 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 16:03:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:37294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753199AbeCXUDz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 16:03:55 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 530E821839
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
Subject: [PATCH 18/44] perf annotate: Move nr_{asm_}entries to struct annotation
Date: Sat, 24 Mar 2018 17:01:45 -0300
Message-Id: <20180324200211.21326-19-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180324200211.21326-1-acme@kernel.org>
References: <20180324200211.21326-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

More non-TUI stuff.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-yd4g6q0rngq4i49hz6iymtta@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate.c | 23 +++++++++++------------
 tools/perf/util/annotate.h        |  2 ++
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 7ec441f93f7e..00b88349a3c2 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -35,8 +35,6 @@ struct annotate_browser {
 	struct rb_node		   *curr_hot;
 	struct annotation_line	   *selection;
 	struct arch		   *arch;
-	int			    nr_asm_entries;
-	int			    nr_entries;
 	bool			    searching_backwards;
 	u8			    addr_width;
 	u8			    jumps_width;
@@ -470,7 +468,7 @@ static bool annotate_browser__toggle_source(struct annotate_browser *browser)
 		if (al->idx_asm < offset)
 			offset = al->idx;
 
-		browser->b.nr_entries = browser->nr_entries;
+		browser->b.nr_entries = notes->nr_entries;
 		notes->options->hide_src_code = false;
 		browser->b.seek(&browser->b, -offset, SEEK_CUR);
 		browser->b.top_idx = al->idx - offset;
@@ -485,7 +483,7 @@ static bool annotate_browser__toggle_source(struct annotate_browser *browser)
 		if (al->idx_asm < offset)
 			offset = al->idx_asm;
 
-		browser->b.nr_entries = browser->nr_asm_entries;
+		browser->b.nr_entries = notes->nr_asm_entries;
 		notes->options->hide_src_code = true;
 		browser->b.seek(&browser->b, -offset, SEEK_CUR);
 		browser->b.top_idx = al->idx_asm - offset;
@@ -495,10 +493,11 @@ static bool annotate_browser__toggle_source(struct annotate_browser *browser)
 	return true;
 }
 
-static void annotate_browser__init_asm_mode(struct annotate_browser *browser)
+static void ui_browser__init_asm_mode(struct ui_browser *browser)
 {
-	ui_browser__reset_index(&browser->b);
-	browser->b.nr_entries = browser->nr_asm_entries;
+	struct annotation *notes = browser__annotation(browser);
+	ui_browser__reset_index(browser);
+	browser->nr_entries = notes->nr_asm_entries;
 }
 
 #define SYM_TITLE_MAX_SIZE (PATH_MAX + 64)
@@ -854,7 +853,7 @@ static int annotate_browser__run(struct annotate_browser *browser,
 					   browser->b.height,
 					   browser->b.index,
 					   browser->b.top_idx,
-					   browser->nr_asm_entries);
+					   notes->nr_asm_entries);
 		}
 			continue;
 		case K_ENTER:
@@ -997,9 +996,9 @@ int symbol__tui_annotate(struct symbol *sym, struct map *map,
 
 		if (browser.b.width < line_len)
 			browser.b.width = line_len;
-		al->idx = browser.nr_entries++;
+		al->idx = notes->nr_entries++;
 		if (al->offset != -1) {
-			al->idx_asm = browser.nr_asm_entries++;
+			al->idx_asm = notes->nr_asm_entries++;
 			/*
 			 * FIXME: short term bandaid to cope with assembly
 			 * routines that comes with labels in the same column
@@ -1020,12 +1019,12 @@ int symbol__tui_annotate(struct symbol *sym, struct map *map,
 	browser.max_addr_width = hex_width(sym->end);
 	browser.jumps_width = width_jumps(notes->max_jump_sources);
 	notes->nr_events = nr_pcnt;
-	browser.b.nr_entries = browser.nr_entries;
+	browser.b.nr_entries = notes->nr_entries;
 	browser.b.entries = &notes->src->source,
 	browser.b.width += 18; /* Percentage */
 
 	if (notes->options->hide_src_code)
-		annotate_browser__init_asm_mode(&browser);
+		ui_browser__init_asm_mode(&browser.b);
 
 	annotate_browser__update_addr_width(&browser);
 
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 0424c127b004..0c34eb0bd7c8 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -175,6 +175,8 @@ struct annotation {
 	int			nr_events;
 	int			nr_jumps;
 	int			max_jump_sources;
+	int			nr_entries;
+	int			nr_asm_entries;
 	bool			have_cycles;
 	struct annotated_source *src;
 };
-- 
2.14.3
