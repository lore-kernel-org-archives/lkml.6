Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755322AbeDDCXt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 22:23:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:36848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755221AbeDDCXp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 22:23:45 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13BB72178C
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
Subject: [PATCH 13/17] perf ui browser: Move the extra title lines from the hists browser
Date: Tue,  3 Apr 2018 23:21:54 -0300
Message-Id: <20180404022158.12190-14-acme@kernel.org>
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

This will be useful for the annotate browser as well, that wants to have
extra title lines, i.e. the current ui_browser unconditionally reserves
the first line for a browser title and the last one for status messages.

But some browsers, like the buckets one (hists browser) needs extra
lines to show headers, allowing it to be shown or not, press 'H' in
'perf top' or 'perf report' to see this feature.

So move that logic to the core ui_browser used by the hists_browser
('perf top' and 'perf report' main interface) so that it can be used by
the annotate browser too.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Martin Liška <mliska@suse.cz>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=196935
Link: https://lkml.kernel.org/n/tip-r38xm3ut37ulbg1o5tn5iise@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browser.c        |  8 +++++++-
 tools/perf/ui/browser.h        |  2 ++
 tools/perf/ui/browsers/hists.c | 43 +++++++++++++++++++++++-------------------
 3 files changed, 33 insertions(+), 20 deletions(-)

diff --git a/tools/perf/ui/browser.c b/tools/perf/ui/browser.c
index 9f6ce29b83b4..d7bb2591838e 100644
--- a/tools/perf/ui/browser.c
+++ b/tools/perf/ui/browser.c
@@ -45,11 +45,16 @@ void ui_browser__set_percent_color(struct ui_browser *browser,
 	 ui_browser__set_color(browser, color);
 }
 
-void ui_browser__gotorc(struct ui_browser *browser, int y, int x)
+void ui_browser__gotorc_title(struct ui_browser *browser, int y, int x)
 {
 	SLsmg_gotorc(browser->y + y, browser->x + x);
 }
 
+void ui_browser__gotorc(struct ui_browser *browser, int y, int x)
+{
+	SLsmg_gotorc(browser->y + y + browser->extra_title_lines, browser->x + x);
+}
+
 void ui_browser__write_nstring(struct ui_browser *browser __maybe_unused, const char *msg,
 			       unsigned int width)
 {
@@ -191,6 +196,7 @@ void ui_browser__refresh_dimensions(struct ui_browser *browser)
 {
 	browser->width = SLtt_Screen_Cols - 1;
 	browser->height = browser->rows = SLtt_Screen_Rows - 2;
+	browser->rows -= browser->extra_title_lines;
 	browser->y = 1;
 	browser->x = 0;
 }
diff --git a/tools/perf/ui/browser.h b/tools/perf/ui/browser.h
index 70057178ee34..aa5932e1d62e 100644
--- a/tools/perf/ui/browser.h
+++ b/tools/perf/ui/browser.h
@@ -17,6 +17,7 @@ struct ui_browser {
 	u64	      index, top_idx;
 	void	      *top, *entries;
 	u16	      y, x, width, height, rows, columns, horiz_scroll;
+	u8	      extra_title_lines;
 	int	      current_color;
 	void	      *priv;
 	const char    *title;
@@ -38,6 +39,7 @@ bool ui_browser__is_current_entry(struct ui_browser *browser, unsigned row);
 void ui_browser__refresh_dimensions(struct ui_browser *browser);
 void ui_browser__reset_index(struct ui_browser *browser);
 
+void ui_browser__gotorc_title(struct ui_browser *browser, int y, int x);
 void ui_browser__gotorc(struct ui_browser *browser, int y, int x);
 void ui_browser__write_nstring(struct ui_browser *browser, const char *msg,
 			       unsigned int width);
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index cde9bab5061d..b06afb8f51fb 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -61,6 +61,15 @@ static int hist_browser__get_folding(struct hist_browser *browser)
 	return unfolded_rows;
 }
 
+static void hist_browser__set_title_space(struct hist_browser *hb)
+{
+	struct ui_browser *browser = &hb->b;
+	struct hists *hists = hb->hists;
+	struct perf_hpp_list *hpp_list = hists->hpp_list;
+
+	browser->extra_title_lines = hb->show_headers ? hpp_list->nr_header_lines : 0;
+}
+
 static u32 hist_browser__nr_entries(struct hist_browser *hb)
 {
 	u32 nr_entries;
@@ -81,10 +90,16 @@ static void hist_browser__update_rows(struct hist_browser *hb)
 	struct ui_browser *browser = &hb->b;
 	struct hists *hists = hb->hists;
 	struct perf_hpp_list *hpp_list = hists->hpp_list;
-	u16 header_offset, index_row;
+	u16 index_row;
+
+	if (!hb->show_headers) {
+		browser->rows += browser->extra_title_lines;
+		browser->extra_title_lines = 0;
+		return;
+	}
 
-	header_offset = hb->show_headers ? hpp_list->nr_header_lines : 0;
-	browser->rows = browser->height - header_offset;
+	browser->extra_title_lines = hpp_list->nr_header_lines;
+	browser->rows -= browser->extra_title_lines;
 	/*
 	 * Verify if we were at the last line and that line isn't
 	 * visibe because we now show the header line(s).
@@ -107,17 +122,6 @@ static void hist_browser__refresh_dimensions(struct ui_browser *browser)
  	 *	  changeset.
  	 */
 	ui_browser__refresh_dimensions(browser);
-	hist_browser__update_rows(hb);
-}
-
-static void hist_browser__gotorc(struct hist_browser *browser, int row, int column)
-{
-	struct hists *hists = browser->hists;
-	struct perf_hpp_list *hpp_list = hists->hpp_list;
-	u16 header_offset;
-
-	header_offset = browser->show_headers ? hpp_list->nr_header_lines : 0;
-	ui_browser__gotorc(&browser->b, row + header_offset, column);
 }
 
 static void hist_browser__reset(struct hist_browser *browser)
@@ -732,7 +736,7 @@ static void hist_browser__show_callchain_entry(struct hist_browser *browser,
 	}
 
 	ui_browser__set_color(&browser->b, color);
-	hist_browser__gotorc(browser, row, 0);
+	ui_browser__gotorc(&browser->b, row, 0);
 	ui_browser__write_nstring(&browser->b, " ", offset);
 	ui_browser__printf(&browser->b, "%c", folded_sign);
 	ui_browser__write_graph(&browser->b, show_annotated ? SLSMG_RARROW_CHAR : ' ');
@@ -1248,7 +1252,7 @@ static int hist_browser__show_entry(struct hist_browser *browser,
 		};
 		int column = 0;
 
-		hist_browser__gotorc(browser, row, 0);
+		ui_browser__gotorc(&browser->b, row, 0);
 
 		hists__for_each_format(browser->hists, fmt) {
 			char s[2048];
@@ -1357,7 +1361,7 @@ static int hist_browser__show_hierarchy_entry(struct hist_browser *browser,
 		goto show_callchain;
 	}
 
-	hist_browser__gotorc(browser, row, 0);
+	ui_browser__gotorc(&browser->b, row, 0);
 
 	if (current_entry && browser->b.navkeypressed)
 		ui_browser__set_color(&browser->b, HE_COLORSET_SELECTED);
@@ -1506,7 +1510,7 @@ static int hist_browser__show_no_entry(struct hist_browser *browser,
 		browser->selection = NULL;
 	}
 
-	hist_browser__gotorc(browser, row, 0);
+	ui_browser__gotorc(&browser->b, row, 0);
 
 	if (current_entry && browser->b.navkeypressed)
 		ui_browser__set_color(&browser->b, HE_COLORSET_SELECTED);
@@ -1712,7 +1716,7 @@ static void hists_browser__headers(struct hist_browser *browser)
 		hists_browser__scnprintf_headers(browser, headers,
 						 sizeof(headers), line);
 
-		ui_browser__gotorc(&browser->b, line, 0);
+		ui_browser__gotorc_title(&browser->b, line, 0);
 		ui_browser__set_color(&browser->b, HE_COLORSET_ROOT);
 		ui_browser__write_nstring(&browser->b, headers, browser->b.width + 1);
 	}
@@ -2142,6 +2146,7 @@ void hist_browser__init(struct hist_browser *browser,
 	browser->b.seek			= ui_browser__hists_seek;
 	browser->b.use_navkeypressed	= true;
 	browser->show_headers		= symbol_conf.show_hist_headers;
+	hist_browser__set_title_space(browser);
 
 	if (symbol_conf.report_hierarchy) {
 		struct perf_hpp_list_node *fmt_node;
-- 
2.14.3
