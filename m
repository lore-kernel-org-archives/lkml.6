Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752203AbeCYWJe (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 18:09:34 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54523 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751032AbeCYWJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 18:09:29 -0400
Date: Sun, 25 Mar 2018 15:09:20 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-yftvybgx1s8sevs6kp1an0ft@git.kernel.org>
Cc: ak@linux.intel.com, mingo@kernel.org, acme@redhat.com,
        namhyung@kernel.org, jolsa@kernel.org, tglx@linutronix.de,
        dsahern@gmail.com, wangnan0@huawei.com, yao.jin@linux.intel.com,
        linux-kernel@vger.kernel.org, adrian.hunter@intel.com, hpa@zytor.com
Reply-To: wangnan0@huawei.com, namhyung@kernel.org, jolsa@kernel.org,
        dsahern@gmail.com, tglx@linutronix.de, mingo@kernel.org,
        acme@redhat.com, ak@linux.intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org, adrian.hunter@intel.com,
        yao.jin@linux.intel.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf annotate tui: Move have_cycles to struct
 annotation
Git-Commit-ID: 0e83a7e9e592cdf60696076071b2629adc569826
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

Commit-ID:  0e83a7e9e592cdf60696076071b2629adc569826
Gitweb:     https://git.kernel.org/tip/0e83a7e9e592cdf60696076071b2629adc569826
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 15 Mar 2018 10:35:04 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 20 Mar 2018 13:19:28 -0300

perf annotate tui: Move have_cycles to struct annotation

This is to pave the way to have more functions shared between TUI, stdio
and the upcoming stdio2 formatting, that will use the __scnprintf
functions used by --tui in a --stdio fashion.

This partially addresses the comments added in cset 30e863bb6f70 ("perf
annotate: Compute IPC and basic block cycles"):

/*
 * This should probably be in util/annotate.c to share with the tty
 * annotate, but right now we need the per byte offsets arrays,
 * which are only here.
 */

The following patches will address the rest.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-yftvybgx1s8sevs6kp1an0ft@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate.c | 20 +++++++++-----------
 tools/perf/util/annotate.h        |  6 ++++++
 2 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 0f84a52b4088..0dd64707125a 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -49,7 +49,6 @@ struct annotate_browser {
 	int			    max_jump_sources;
 	int			    nr_jumps;
 	bool			    searching_backwards;
-	bool			    have_cycles;
 	u8			    addr_width;
 	u8			    jumps_width;
 	u8			    target_width;
@@ -102,11 +101,6 @@ static int annotate_browser__pcnt_width(struct annotate_browser *ab)
 	return (annotate_browser__opts.show_total_period ? 12 : 7) * ab->nr_events;
 }
 
-static int annotate_browser__cycles_width(struct annotate_browser *ab)
-{
-	return ab->have_cycles ? ANNOTATION__IPC_WIDTH + ANNOTATION__CYCLES_WIDTH : 0;
-}
-
 static void disasm_line__write(struct disasm_line *dl, struct ui_browser *browser,
 			       char *bf, size_t size)
 {
@@ -136,6 +130,9 @@ static void disasm_line__write(struct disasm_line *dl, struct ui_browser *browse
 static void annotate_browser__write(struct ui_browser *browser, void *entry, int row)
 {
 	struct annotate_browser *ab = container_of(browser, struct annotate_browser, b);
+	struct map_symbol *ms = browser->priv;
+	struct symbol *sym = ms->sym;
+	struct annotation *notes = symbol__annotation(sym);
 	struct annotation_line *al = list_entry(entry, struct annotation_line, node);
 	struct browser_line *bl = browser_line(al);
 	bool current_entry = ui_browser__is_current_entry(browser, row);
@@ -144,7 +141,7 @@ static void annotate_browser__write(struct ui_browser *browser, void *entry, int
 					         !browser->navkeypressed)));
 	int width = browser->width, printed;
 	int i, pcnt_width = annotate_browser__pcnt_width(ab),
-	       cycles_width = annotate_browser__cycles_width(ab);
+	       cycles_width = annotation__cycles_width(notes);
 	double percent_max = 0.0;
 	char bf[256];
 	bool show_title = false;
@@ -155,7 +152,7 @@ static void annotate_browser__write(struct ui_browser *browser, void *entry, int
 	}
 
 	if ((row == 0) && (al->offset == -1 || percent_max == 0.0)) {
-		if (ab->have_cycles) {
+		if (notes->have_cycles) {
 			if (al->ipc == 0.0 && al->cycles == 0)
 				show_title = true;
 		} else
@@ -189,7 +186,7 @@ static void annotate_browser__write(struct ui_browser *browser, void *entry, int
 					   annotate_browser__opts.show_nr_samples ? "Samples" : "Percent");
 		}
 	}
-	if (ab->have_cycles) {
+	if (notes->have_cycles) {
 		if (al->ipc)
 			ui_browser__printf(browser, "%*.2f ", ANNOTATION__IPC_WIDTH - 1, al->ipc);
 		else if (!show_title)
@@ -307,6 +304,7 @@ static void annotate_browser__draw_current_jump(struct ui_browser *browser)
 	unsigned int from, to;
 	struct map_symbol *ms = ab->b.priv;
 	struct symbol *sym = ms->sym;
+	struct annotation *notes = symbol__annotation(sym);
 	u8 pcnt_width = annotate_browser__pcnt_width(ab);
 	int width;
 
@@ -355,7 +353,7 @@ static void annotate_browser__draw_current_jump(struct ui_browser *browser)
 		to = (u64)btarget->idx;
 	}
 
-	width = annotate_browser__cycles_width(ab);
+	width = annotation__cycles_width(notes);
 
 	ui_browser__set_color(browser, HE_COLORSET_JUMP_ARROWS);
 	__ui_browser__line_arrow(browser,
@@ -1033,7 +1031,7 @@ static void annotate__compute_ipc(struct annotate_browser *browser, size_t size,
 			al = browser->offsets[offset];
 			if (al && ch->num_aggr)
 				al->cycles = ch->cycles_aggr / ch->num_aggr;
-			browser->have_cycles = true;
+			notes->have_cycles = true;
 		}
 	}
 	pthread_mutex_unlock(&notes->lock);
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 0407234b5157..23d2f32b7bf0 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -164,9 +164,15 @@ struct annotated_source {
 struct annotation {
 	pthread_mutex_t		lock;
 	u64			max_coverage;
+	bool			have_cycles;
 	struct annotated_source *src;
 };
 
+static inline int annotation__cycles_width(struct annotation *notes)
+{
+	return notes->have_cycles ? ANNOTATION__IPC_WIDTH + ANNOTATION__CYCLES_WIDTH : 0;
+}
+
 static inline struct sym_hist *annotation__histogram(struct annotation *notes, int idx)
 {
 	return (((void *)&notes->src->histograms) +
