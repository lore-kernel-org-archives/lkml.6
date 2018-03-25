Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752380AbeCYWMy (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 18:12:54 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43055 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751657AbeCYWMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 18:12:50 -0400
Date: Sun, 25 Mar 2018 15:12:39 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-vyggbbqd05k3k4mvv7z9l5px@git.kernel.org>
Cc: dsahern@gmail.com, namhyung@kernel.org, hpa@zytor.com,
        ak@linux.intel.com, adrian.hunter@intel.com, mingo@kernel.org,
        yao.jin@linux.intel.com, acme@redhat.com, jolsa@kernel.org,
        wangnan0@huawei.com, linux-kernel@vger.kernel.org, tglx@linutronix.de
Reply-To: linux-kernel@vger.kernel.org, tglx@linutronix.de,
        yao.jin@linux.intel.com, acme@redhat.com, jolsa@kernel.org,
        wangnan0@huawei.com, adrian.hunter@intel.com, mingo@kernel.org,
        dsahern@gmail.com, namhyung@kernel.org, hpa@zytor.com,
        ak@linux.intel.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf annotate: Move max_jump_sources to struct
 annotation
Git-Commit-ID: bc1c0f3dfa77619ad90f6fed290636cf54629d30
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

Commit-ID:  bc1c0f3dfa77619ad90f6fed290636cf54629d30
Gitweb:     https://git.kernel.org/tip/bc1c0f3dfa77619ad90f6fed290636cf54629d30
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 15 Mar 2018 15:10:28 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 20 Mar 2018 13:19:28 -0300

perf annotate: Move max_jump_sources to struct annotation

This is not useful only for the TUI, we'll want to somehow mark the
--stdio2 lines with the most jump sources too.

And moving this will allow us to change some function signatures from
annotate_browser to ui_browser, reducing boilerplate.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-vyggbbqd05k3k4mvv7z9l5px@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate.c | 11 ++++++-----
 tools/perf/util/annotate.h        |  1 +
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index c995d28d1a58..3bc003fe0b1d 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -44,7 +44,6 @@ struct annotate_browser {
 	u64			    start;
 	int			    nr_asm_entries;
 	int			    nr_entries;
-	int			    max_jump_sources;
 	int			    nr_jumps;
 	bool			    searching_backwards;
 	u8			    addr_width;
@@ -85,9 +84,11 @@ static bool disasm_line__filter(struct ui_browser *browser, void *entry)
 static int annotate_browser__jumps_percent_color(struct annotate_browser *browser,
 						 int nr, bool current)
 {
+	struct annotation *notes = browser__annotation(&browser->b);
+
 	if (current && (!browser->b.use_navkeypressed || browser->b.navkeypressed))
 		return HE_COLORSET_SELECTED;
-	if (nr == browser->max_jump_sources)
+	if (nr == notes->max_jump_sources)
 		return HE_COLORSET_TOP;
 	if (nr > 1)
 		return HE_COLORSET_MEDIUM;
@@ -998,8 +999,8 @@ static void annotate_browser__mark_jump_targets(struct annotate_browser *browser
 			continue;
 
 		blt = browser_line(al);
-		if (++blt->jump_sources > browser->max_jump_sources)
-			browser->max_jump_sources = blt->jump_sources;
+		if (++blt->jump_sources > notes->max_jump_sources)
+			notes->max_jump_sources = blt->jump_sources;
 
 		++browser->nr_jumps;
 	}
@@ -1099,7 +1100,7 @@ int symbol__tui_annotate(struct symbol *sym, struct map *map,
 
 	browser.addr_width = browser.target_width = browser.min_addr_width = hex_width(size);
 	browser.max_addr_width = hex_width(sym->end);
-	browser.jumps_width = width_jumps(browser.max_jump_sources);
+	browser.jumps_width = width_jumps(notes->max_jump_sources);
 	notes->nr_events = nr_pcnt;
 	browser.b.nr_entries = browser.nr_entries;
 	browser.b.entries = &notes->src->source,
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 17cd5d274fe5..b8aca936ed55 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -167,6 +167,7 @@ struct annotation {
 	struct annotation_options *options;
 	struct annotation_line	**offsets;
 	int			nr_events;
+	int			max_jump_sources;
 	bool			have_cycles;
 	struct annotated_source *src;
 };
