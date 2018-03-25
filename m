Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752204AbeCYWNt (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 18:13:49 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58591 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751149AbeCYWNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 18:13:45 -0400
Date: Sun, 25 Mar 2018 15:13:36 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-kpgle1qxe7thajvrqleuvi80@git.kernel.org>
Cc: namhyung@kernel.org, adrian.hunter@intel.com, yao.jin@linux.intel.com,
        dsahern@gmail.com, mingo@kernel.org, wangnan0@huawei.com,
        tglx@linutronix.de, hpa@zytor.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, ak@linux.intel.com, acme@redhat.com
Reply-To: wangnan0@huawei.com, mingo@kernel.org, tglx@linutronix.de,
        jolsa@kernel.org, hpa@zytor.com, namhyung@kernel.org,
        adrian.hunter@intel.com, yao.jin@linux.intel.com, dsahern@gmail.com,
        ak@linux.intel.com, acme@redhat.com, linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf annotate: Move nr_jumps to struct annotation
Git-Commit-ID: 6dcd57e8ae2080bca776d55e6e2b3d529677cae5
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

Commit-ID:  6dcd57e8ae2080bca776d55e6e2b3d529677cae5
Gitweb:     https://git.kernel.org/tip/6dcd57e8ae2080bca776d55e6e2b3d529677cae5
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 15 Mar 2018 15:20:12 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 20 Mar 2018 13:19:29 -0300

perf annotate: Move nr_jumps to struct annotation

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
