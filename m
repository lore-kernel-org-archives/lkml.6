Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752401AbeCYWNS (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 18:13:18 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51455 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752171AbeCYWNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 18:13:16 -0400
Date: Sun, 25 Mar 2018 15:13:06 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-9f8c2f9aetbibcw33d615y9o@git.kernel.org>
Cc: namhyung@kernel.org, ak@linux.intel.com, linux-kernel@vger.kernel.org,
        hpa@zytor.com, wangnan0@huawei.com, acme@redhat.com, jolsa@kernel.org,
        tglx@linutronix.de, yao.jin@linux.intel.com, dsahern@gmail.com,
        mingo@kernel.org, adrian.hunter@intel.com
Reply-To: namhyung@kernel.org, ak@linux.intel.com,
        linux-kernel@vger.kernel.org, hpa@zytor.com, wangnan0@huawei.com,
        jolsa@kernel.org, acme@redhat.com, tglx@linutronix.de,
        yao.jin@linux.intel.com, dsahern@gmail.com, mingo@kernel.org,
        adrian.hunter@intel.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf annotate: Move jumps_percent_color to
 ui_browser
Git-Commit-ID: 27feb761c7211c6c35350277b6c65989b982b377
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

Commit-ID:  27feb761c7211c6c35350277b6c65989b982b377
Gitweb:     https://git.kernel.org/tip/27feb761c7211c6c35350277b6c65989b982b377
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 15 Mar 2018 15:14:45 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 20 Mar 2018 13:19:28 -0300

perf annotate: Move jumps_percent_color to ui_browser

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
