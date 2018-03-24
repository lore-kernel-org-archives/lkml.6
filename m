Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753348AbeCXUO3 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 16:14:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:36930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753038AbeCXUDW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 16:03:22 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73E902178B
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
Subject: [PATCH 08/44] perf annotate: Move nr_events from annotate_browser to annotation struct
Date: Sat, 24 Mar 2018 17:01:35 -0300
Message-Id: <20180324200211.21326-9-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180324200211.21326-1-acme@kernel.org>
References: <20180324200211.21326-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Paving the way to move more stuff out of TUI and into the generic
annotation library.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-8vqax6wgfqohelot8j8zsfvs@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate.c | 11 ++++++-----
 tools/perf/util/annotate.h        |  1 +
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 353edff3fdbb..8a110765b328 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -41,7 +41,6 @@ struct annotate_browser {
 	struct rb_node		   *curr_hot;
 	struct annotation_line	   *selection;
 	struct arch		   *arch;
-	int			    nr_events;
 	u64			    start;
 	int			    nr_asm_entries;
 	int			    nr_entries;
@@ -97,7 +96,9 @@ static int annotate_browser__set_jumps_percent_color(struct annotate_browser *br
 
 static int annotate_browser__pcnt_width(struct annotate_browser *ab)
 {
-	return (annotate_browser__opts.show_total_period ? 12 : 7) * ab->nr_events;
+	struct map_symbol *ms = ab->b.priv;
+	struct annotation *notes = symbol__annotation(ms->sym);
+	return (annotate_browser__opts.show_total_period ? 12 : 7) * notes->nr_events;
 }
 
 static void disasm_line__write(struct disasm_line *dl, struct ui_browser *browser,
@@ -145,7 +146,7 @@ static void annotate_browser__write(struct ui_browser *browser, void *entry, int
 	char bf[256];
 	bool show_title = false;
 
-	for (i = 0; i < ab->nr_events; i++) {
+	for (i = 0; i < notes->nr_events; i++) {
 		if (al->samples[i].percent > percent_max)
 			percent_max = al->samples[i].percent;
 	}
@@ -159,7 +160,7 @@ static void annotate_browser__write(struct ui_browser *browser, void *entry, int
 	}
 
 	if (al->offset != -1 && percent_max != 0.0) {
-		for (i = 0; i < ab->nr_events; i++) {
+		for (i = 0; i < notes->nr_events; i++) {
 			ui_browser__set_percent_color(browser,
 						al->samples[i].percent,
 						current_entry);
@@ -1099,7 +1100,7 @@ int symbol__tui_annotate(struct symbol *sym, struct map *map,
 	browser.addr_width = browser.target_width = browser.min_addr_width = hex_width(size);
 	browser.max_addr_width = hex_width(sym->end);
 	browser.jumps_width = width_jumps(browser.max_jump_sources);
-	browser.nr_events = nr_pcnt;
+	notes->nr_events = nr_pcnt;
 	browser.b.nr_entries = browser.nr_entries;
 	browser.b.entries = &notes->src->source,
 	browser.b.width += 18; /* Percentage */
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 21fa5d7cd9e0..5d15cdf22fc9 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -165,6 +165,7 @@ struct annotation {
 	pthread_mutex_t		lock;
 	u64			max_coverage;
 	struct annotation_line	**offsets;
+	int			nr_events;
 	bool			have_cycles;
 	struct annotated_source *src;
 };
-- 
2.14.3
