Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753202AbeCXUDz (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 16:03:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:37268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753180AbeCXUDw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 16:03:52 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 286842178B
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
Subject: [PATCH 17/44] perf annotate: Move 'start' to struct annotation
Date: Sat, 24 Mar 2018 17:01:44 -0300
Message-Id: <20180324200211.21326-18-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180324200211.21326-1-acme@kernel.org>
References: <20180324200211.21326-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Another field that is not TUI specific.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-jj3dwswndft5mln8hu9k0idv@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate.c | 5 ++---
 tools/perf/util/annotate.h        | 1 +
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 50f8e671644f..7ec441f93f7e 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -35,7 +35,6 @@ struct annotate_browser {
 	struct rb_node		   *curr_hot;
 	struct annotation_line	   *selection;
 	struct arch		   *arch;
-	u64			    start;
 	int			    nr_asm_entries;
 	int			    nr_entries;
 	bool			    searching_backwards;
@@ -208,7 +207,7 @@ static void annotate_browser__write(struct ui_browser *browser, void *entry, int
 		int color = -1;
 
 		if (!notes->options->use_offset)
-			addr += ab->start;
+			addr += notes->start;
 
 		if (!notes->options->use_offset) {
 			printed = scnprintf(bf, sizeof(bf), "%" PRIx64 ": ", addr);
@@ -991,7 +990,7 @@ int symbol__tui_annotate(struct symbol *sym, struct map *map,
 
 	ui_helpline__push("Press ESC to exit");
 
-	browser.start = map__rip_2objdump(map, sym->start);
+	notes->start = map__rip_2objdump(map, sym->start);
 
 	list_for_each_entry(al, &notes->src->source, node) {
 		size_t line_len = strlen(al->line);
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 2018a47790c7..0424c127b004 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -169,6 +169,7 @@ struct annotated_source {
 struct annotation {
 	pthread_mutex_t		lock;
 	u64			max_coverage;
+	u64			start;
 	struct annotation_options *options;
 	struct annotation_line	**offsets;
 	int			nr_events;
-- 
2.14.3
