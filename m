Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753148AbeCXUDm (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 16:03:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:37092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753133AbeCXUDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 16:03:39 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71FF52172B
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
Subject: [PATCH 13/44] perf annotate: Move jumps_percent_color to ui_browser
Date: Sat, 24 Mar 2018 17:01:40 -0300
Message-Id: <20180324200211.21326-14-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180324200211.21326-1-acme@kernel.org>
References: <20180324200211.21326-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Since all it needs is in ui_browser and annotation structs members.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-9f8c2f9aetbibcw33d615y9o@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 3bc003fe0b1d..6e2eea09a9b0 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -81,12 +81,11 @@ static bool disasm_line__filter(struct ui_browser *browser, void *entry)
 	return false;
 }
 
-static int annotate_browser__jumps_percent_color(struct annotate_browser *browser,
-						 int nr, bool current)
+static int ui_browser__jumps_percent_color(struct ui_browser *browser, int nr, bool current)
 {
-	struct annotation *notes = browser__annotation(&browser->b);
+	struct annotation *notes = browser__annotation(browser);
 
-	if (current && (!browser->b.use_navkeypressed || browser->b.navkeypressed))
+	if (current && (!browser->use_navkeypressed || browser->navkeypressed))
 		return HE_COLORSET_SELECTED;
 	if (nr == notes->max_jump_sources)
 		return HE_COLORSET_TOP;
@@ -95,11 +94,10 @@ static int annotate_browser__jumps_percent_color(struct annotate_browser *browse
 	return HE_COLORSET_NORMAL;
 }
 
-static int annotate_browser__set_jumps_percent_color(struct annotate_browser *browser,
-						     int nr, bool current)
+static int ui_browser__set_jumps_percent_color(struct ui_browser *browser, int nr, bool current)
 {
-	 int color = annotate_browser__jumps_percent_color(browser, nr, current);
-	 return ui_browser__set_color(&browser->b, color);
+	 int color = ui_browser__jumps_percent_color(browser, nr, current);
+	 return ui_browser__set_color(browser, color);
 }
 
 static void disasm_line__write(struct disasm_line *dl, struct ui_browser *browser,
@@ -237,8 +235,8 @@ static void annotate_browser__write(struct ui_browser *browser, void *entry, int
 					printed = scnprintf(bf, sizeof(bf), "%*d ",
 							    ab->jumps_width,
 							    bl->jump_sources);
-					prev = annotate_browser__set_jumps_percent_color(ab, bl->jump_sources,
-											 current_entry);
+					prev = ui_browser__set_jumps_percent_color(browser, bl->jump_sources,
+										   current_entry);
 					ui_browser__write_nstring(browser, bf, printed);
 					ui_browser__set_color(browser, prev);
 				}
-- 
2.14.3
