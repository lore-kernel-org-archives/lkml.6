Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753131AbeCXUDj (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 16:03:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:37068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753098AbeCXUDg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 16:03:36 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 479732178B
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
Subject: [PATCH 12/44] perf annotate: Move max_jump_sources to struct annotation
Date: Sat, 24 Mar 2018 17:01:39 -0300
Message-Id: <20180324200211.21326-13-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180324200211.21326-1-acme@kernel.org>
References: <20180324200211.21326-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
-- 
2.14.3
