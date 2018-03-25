Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752691AbeCYWUf (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 18:20:35 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46453 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750960AbeCYWUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 18:20:32 -0400
Date: Sun, 25 Mar 2018 15:20:24 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-g0ckz9ajy6unswrv2iy39mxk@git.kernel.org>
Cc: ak@linux.intel.com, linux-kernel@vger.kernel.org, acme@redhat.com,
        yao.jin@linux.intel.com, mingo@kernel.org, jolsa@kernel.org,
        hpa@zytor.com, wangnan0@huawei.com, namhyung@kernel.org,
        adrian.hunter@intel.com, tglx@linutronix.de, dsahern@gmail.com
Reply-To: dsahern@gmail.com, wangnan0@huawei.com, tglx@linutronix.de,
        adrian.hunter@intel.com, namhyung@kernel.org, acme@redhat.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com, jolsa@kernel.org,
        mingo@kernel.org, yao.jin@linux.intel.com, ak@linux.intel.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf annotate: Introduce annotation_line__filter()
Git-Commit-ID: 9b80d1f946ee40923f7bf51c69cb3a6ac6097e4a
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

Commit-ID:  9b80d1f946ee40923f7bf51c69cb3a6ac6097e4a
Gitweb:     https://git.kernel.org/tip/9b80d1f946ee40923f7bf51c69cb3a6ac6097e4a
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Fri, 16 Mar 2018 10:39:24 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 20 Mar 2018 15:36:22 -0300

perf annotate: Introduce annotation_line__filter()

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
