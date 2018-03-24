Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753166AbeCXUDq (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 16:03:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:37136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753133AbeCXUDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 16:03:42 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C9682178B
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
Subject: [PATCH 14/44] perf annotate: Move nr_jumps to struct annotation
Date: Sat, 24 Mar 2018 17:01:41 -0300
Message-Id: <20180324200211.21326-15-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180324200211.21326-1-acme@kernel.org>
References: <20180324200211.21326-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

This is another information that will be useful for the --stdio2 mode,
to provide symbol statistics, so move it from the TUI and change the
mark_jump_targets() method to struct annotation.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-kpgle1qxe7thajvrqleuvi80@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate.c | 13 ++++---------
 tools/perf/util/annotate.h        |  1 +
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 6e2eea09a9b0..d05a2f991207 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -44,7 +44,6 @@ struct annotate_browser {
 	u64			    start;
 	int			    nr_asm_entries;
 	int			    nr_entries;
-	int			    nr_jumps;
 	bool			    searching_backwards;
 	u8			    addr_width;
 	u8			    jumps_width;
@@ -965,13 +964,9 @@ int hist_entry__tui_annotate(struct hist_entry *he, struct perf_evsel *evsel,
 	return map_symbol__tui_annotate(&he->ms, evsel, hbt);
 }
 
-static void annotate_browser__mark_jump_targets(struct annotate_browser *browser,
-						size_t size)
+static void annotation__mark_jump_targets(struct annotation *notes, struct symbol *sym)
 {
-	u64 offset;
-	struct map_symbol *ms = browser->b.priv;
-	struct symbol *sym = ms->sym;
-	struct annotation *notes = symbol__annotation(sym);
+	u64 offset, size = symbol__size(sym);
 
 	/* PLT symbols contain external offsets */
 	if (strstr(sym->name, "@plt"))
@@ -1000,7 +995,7 @@ static void annotate_browser__mark_jump_targets(struct annotate_browser *browser
 		if (++blt->jump_sources > notes->max_jump_sources)
 			notes->max_jump_sources = blt->jump_sources;
 
-		++browser->nr_jumps;
+		++notes->nr_jumps;
 	}
 }
 
@@ -1093,7 +1088,7 @@ int symbol__tui_annotate(struct symbol *sym, struct map *map,
 			bpos->idx_asm = -1;
 	}
 
-	annotate_browser__mark_jump_targets(&browser, size);
+	annotation__mark_jump_targets(notes, sym);
 	annotation__compute_ipc(notes, size);
 
 	browser.addr_width = browser.target_width = browser.min_addr_width = hex_width(size);
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index b8aca936ed55..897a84712ab4 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -167,6 +167,7 @@ struct annotation {
 	struct annotation_options *options;
 	struct annotation_line	**offsets;
 	int			nr_events;
+	int			nr_jumps;
 	int			max_jump_sources;
 	bool			have_cycles;
 	struct annotated_source *src;
-- 
2.14.3
