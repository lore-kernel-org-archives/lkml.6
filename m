Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752148AbeCMGWg (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 02:22:36 -0400
Received: from mga04.intel.com ([192.55.52.120]:52838 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752096AbeCMGWf (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 02:22:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,464,1515484800";
   d="scan'208";a="25162166"
From: Jin Yao <yao.jin@linux.intel.com>
To: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com
Cc: Linux-kernel@vger.kernel.org, ak@linux.intel.com, kan.liang@intel.com,
        yao.jin@intel.com, Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v1 1/4] perf browser: Add a new 'dump' flag
Date: Tue, 13 Mar 2018 22:16:51 +0800
Message-Id: <1520950614-22082-2-git-send-email-yao.jin@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520950614-22082-1-git-send-email-yao.jin@linux.intel.com>
References: <1520950614-22082-1-git-send-email-yao.jin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have a new requirement to provide the TUI output option for
non-interactive mode. For example, write the TUI output to stdio directly.

This patch creates a new flag 'dump' in struct ui_browser. Once it's on,
for the formatted buffer, we just print it on stdio.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/ui/browser.c | 38 +++++++++++++++++++++++++++++++++-----
 tools/perf/ui/browser.h |  1 +
 2 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/tools/perf/ui/browser.c b/tools/perf/ui/browser.c
index 63399af..3534c6c 100644
--- a/tools/perf/ui/browser.c
+++ b/tools/perf/ui/browser.c
@@ -41,8 +41,13 @@ int ui_browser__set_color(struct ui_browser *browser, int color)
 void ui_browser__set_percent_color(struct ui_browser *browser,
 				   double percent, bool current)
 {
-	 int color = ui_browser__percent_color(browser, percent, current);
-	 ui_browser__set_color(browser, color);
+	int color;
+
+	if (browser->dump)
+		return;
+
+	color = ui_browser__percent_color(browser, percent, current);
+	ui_browser__set_color(browser, color);
 }
 
 void ui_browser__gotorc(struct ui_browser *browser, int y, int x)
@@ -50,10 +55,27 @@ void ui_browser__gotorc(struct ui_browser *browser, int y, int x)
 	SLsmg_gotorc(browser->y + y, browser->x + x);
 }
 
+static void write_nstring(const char *msg, unsigned int width)
+{
+	unsigned int len = strlen(msg);
+	unsigned int i = 0;
+
+	while (i < len && i < width) {
+		putchar(msg[i]);
+		i++;
+	}
+
+	while (i++ < width)
+		putchar(' ');
+}
+
 void ui_browser__write_nstring(struct ui_browser *browser __maybe_unused, const char *msg,
 			       unsigned int width)
 {
-	slsmg_write_nstring(msg, width);
+	if (browser->dump)
+		write_nstring(msg, width);
+	else
+		slsmg_write_nstring(msg, width);
 }
 
 void ui_browser__printf(struct ui_browser *browser __maybe_unused, const char *fmt, ...)
@@ -61,7 +83,10 @@ void ui_browser__printf(struct ui_browser *browser __maybe_unused, const char *f
 	va_list args;
 
 	va_start(args, fmt);
-	slsmg_vprintf(fmt, args);
+	if (browser->dump)
+		vprintf(fmt, args);
+	else
+		slsmg_vprintf(fmt, args);
 	va_end(args);
 }
 
@@ -496,7 +521,10 @@ unsigned int ui_browser__list_head_refresh(struct ui_browser *browser)
 
 	list_for_each_from(pos, head) {
 		if (!browser->filter || !browser->filter(browser, pos)) {
-			ui_browser__gotorc(browser, row, 0);
+			if (!browser->dump)
+				ui_browser__gotorc(browser, row, 0);
+			else if (row > 0)
+				printf("\n");
 			browser->write(browser, pos, row);
 			if (++row == browser->rows)
 				break;
diff --git a/tools/perf/ui/browser.h b/tools/perf/ui/browser.h
index 03e1734..66d9405 100644
--- a/tools/perf/ui/browser.h
+++ b/tools/perf/ui/browser.h
@@ -28,6 +28,7 @@ struct ui_browser {
 	u32	      nr_entries;
 	bool	      navkeypressed;
 	bool	      use_navkeypressed;
+	bool	      dump;
 };
 
 int  ui_browser__set_color(struct ui_browser *browser, int color);
-- 
2.7.4
