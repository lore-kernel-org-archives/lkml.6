Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752139AbeCYWQ3 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 18:16:29 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38607 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750832AbeCYWQ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 18:16:27 -0400
Date: Sun, 25 Mar 2018 15:16:17 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-86h6ftebc62ij1rx8q9zkpwk@git.kernel.org>
Cc: ak@linux.intel.com, namhyung@kernel.org, adrian.hunter@intel.com,
        acme@redhat.com, wangnan0@huawei.com, mingo@kernel.org,
        tglx@linutronix.de, hpa@zytor.com, yao.jin@linux.intel.com,
        jolsa@kernel.org, dsahern@gmail.com, linux-kernel@vger.kernel.org
Reply-To: jolsa@kernel.org, yao.jin@linux.intel.com,
        linux-kernel@vger.kernel.org, dsahern@gmail.com, mingo@kernel.org,
        wangnan0@huawei.com, adrian.hunter@intel.com, acme@redhat.com,
        ak@linux.intel.com, namhyung@kernel.org, hpa@zytor.com,
        tglx@linutronix.de
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf annotate: Move the column widths from the TUI
 to generic lib
Git-Commit-ID: 9761e86e36c0957e76c1b7c328953687a1a38655
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  9761e86e36c0957e76c1b7c328953687a1a38655
Gitweb:     https://git.kernel.org/tip/9761e86e36c0957e76c1b7c328953687a1a38655
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 15 Mar 2018 16:18:21 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 20 Mar 2018 13:19:29 -0300

perf annotate: Move the column widths from the TUI to generic lib

This also will be used in other output formats, such as --stdio2.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-86h6ftebc62ij1rx8q9zkpwk@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate.c | 45 +++++++++++++++++----------------------
 tools/perf/util/annotate.h        |  7 ++++++
 2 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 977c7e9fdadb..07d0d2268008 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -36,11 +36,6 @@ struct annotate_browser {
 	struct annotation_line	   *selection;
 	struct arch		   *arch;
 	bool			    searching_backwards;
-	u8			    addr_width;
-	u8			    jumps_width;
-	u8			    target_width;
-	u8			    min_addr_width;
-	u8			    max_addr_width;
 	char			    search_bf[128];
 };
 
@@ -194,10 +189,10 @@ static void annotate_browser__write(struct ui_browser *browser, void *entry, int
 	else if (al->offset == -1) {
 		if (al->line_nr && notes->options->show_linenr)
 			printed = scnprintf(bf, sizeof(bf), "%-*d ",
-					ab->addr_width + 1, al->line_nr);
+					notes->widths.addr + 1, al->line_nr);
 		else
 			printed = scnprintf(bf, sizeof(bf), "%*s  ",
-				    ab->addr_width, " ");
+				    notes->widths.addr, " ");
 		ui_browser__write_nstring(browser, bf, printed);
 		ui_browser__write_nstring(browser, al->line, width - printed - pcnt_width - cycles_width + 1);
 	} else {
@@ -214,7 +209,7 @@ static void annotate_browser__write(struct ui_browser *browser, void *entry, int
 				if (notes->options->show_nr_jumps) {
 					int prev;
 					printed = scnprintf(bf, sizeof(bf), "%*d ",
-							    ab->jumps_width,
+							    notes->widths.jumps,
 							    al->jump_sources);
 					prev = ui_browser__set_jumps_percent_color(browser, al->jump_sources,
 										   current_entry);
@@ -223,10 +218,10 @@ static void annotate_browser__write(struct ui_browser *browser, void *entry, int
 				}
 
 				printed = scnprintf(bf, sizeof(bf), "%*" PRIx64 ": ",
-						    ab->target_width, addr);
+						    notes->widths.target, addr);
 			} else {
 				printed = scnprintf(bf, sizeof(bf), "%*s  ",
-						    ab->addr_width, " ");
+						    notes->widths.addr, " ");
 			}
 		}
 
@@ -322,12 +317,12 @@ static void annotate_browser__draw_current_jump(struct ui_browser *browser)
 
 	ui_browser__set_color(browser, HE_COLORSET_JUMP_ARROWS);
 	__ui_browser__line_arrow(browser,
-				 pcnt_width + 2 + ab->addr_width + width,
+				 pcnt_width + 2 + notes->widths.addr + width,
 				 from, to);
 
 	if (is_fused(ab, cursor)) {
 		ui_browser__mark_fused(browser,
-				       pcnt_width + 3 + ab->addr_width + width,
+				       pcnt_width + 3 + notes->widths.addr + width,
 				       from - 1,
 				       to > from ? true : false);
 	}
@@ -703,19 +698,17 @@ bool annotate_browser__continue_search_reverse(struct annotate_browser *browser,
 	return __annotate_browser__search_reverse(browser);
 }
 
-static void annotate_browser__update_addr_width(struct annotate_browser *browser)
+static void annotation__update_column_widths(struct annotation *notes)
 {
-	struct annotation *notes = browser__annotation(&browser->b);
-
 	if (notes->options->use_offset)
-		browser->target_width = browser->min_addr_width;
+		notes->widths.target = notes->widths.min_addr;
 	else
-		browser->target_width = browser->max_addr_width;
+		notes->widths.target = notes->widths.max_addr;
 
-	browser->addr_width = browser->target_width;
+	notes->widths.addr = notes->widths.target;
 
 	if (notes->options->show_nr_jumps)
-		browser->addr_width += browser->jumps_width + 1;
+		notes->widths.addr += notes->widths.jumps + 1;
 }
 
 static int annotate_browser__run(struct annotate_browser *browser,
@@ -820,14 +813,14 @@ static int annotate_browser__run(struct annotate_browser *browser,
 			continue;
 		case 'o':
 			notes->options->use_offset = !notes->options->use_offset;
-			annotate_browser__update_addr_width(browser);
+			annotation__update_column_widths(notes);
 			continue;
 		case 'j':
 			notes->options->jump_arrows = !notes->options->jump_arrows;
 			continue;
 		case 'J':
 			notes->options->show_nr_jumps = !notes->options->show_nr_jumps;
-			annotate_browser__update_addr_width(browser);
+			annotation__update_column_widths(notes);
 			continue;
 		case '/':
 			if (annotate_browser__search(browser, delay_secs)) {
@@ -884,7 +877,7 @@ show_sup_ins:
 				notes->options->show_nr_samples = false;
 			else
 				notes->options->show_total_period = true;
-			annotate_browser__update_addr_width(browser);
+			annotation__update_column_widths(notes);
 			continue;
 		case K_LEFT:
 		case K_ESC:
@@ -995,9 +988,9 @@ int symbol__tui_annotate(struct symbol *sym, struct map *map,
 	annotation__mark_jump_targets(notes, sym);
 	annotation__compute_ipc(notes, size);
 
-	browser.addr_width = browser.target_width = browser.min_addr_width = hex_width(size);
-	browser.max_addr_width = hex_width(sym->end);
-	browser.jumps_width = width_jumps(notes->max_jump_sources);
+	notes->widths.addr = notes->widths.target = notes->widths.min_addr = hex_width(size);
+	notes->widths.max_addr = hex_width(sym->end);
+	notes->widths.jumps = width_jumps(notes->max_jump_sources);
 	notes->nr_events = nr_pcnt;
 	browser.b.nr_entries = notes->nr_entries;
 	browser.b.entries = &notes->src->source,
@@ -1006,7 +999,7 @@ int symbol__tui_annotate(struct symbol *sym, struct map *map,
 	if (notes->options->hide_src_code)
 		ui_browser__init_asm_mode(&browser.b);
 
-	annotate_browser__update_addr_width(&browser);
+	annotation__update_column_widths(notes);
 
 	ret = annotate_browser__run(&browser, evsel, hbt);
 
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 8a61ec9a5291..0aa77c154fe3 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -178,6 +178,13 @@ struct annotation {
 	int			nr_entries;
 	int			nr_asm_entries;
 	u16			max_line_len;
+	struct {
+		u8		addr;
+		u8		jumps;
+		u8		target;
+		u8		min_addr;
+		u8		max_addr;
+	} widths;
 	bool			have_cycles;
 	struct annotated_source *src;
 };
