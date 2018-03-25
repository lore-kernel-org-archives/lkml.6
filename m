Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752048AbeCYWPK (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 18:15:10 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51179 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751050AbeCYWPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 18:15:05 -0400
Date: Sun, 25 Mar 2018 15:14:56 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-jj3dwswndft5mln8hu9k0idv@git.kernel.org>
Cc: tglx@linutronix.de, acme@redhat.com, yao.jin@linux.intel.com,
        mingo@kernel.org, namhyung@kernel.org, dsahern@gmail.com,
        adrian.hunter@intel.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
        wangnan0@huawei.com, jolsa@kernel.org, ak@linux.intel.com
Reply-To: hpa@zytor.com, jolsa@kernel.org, wangnan0@huawei.com,
        linux-kernel@vger.kernel.org, ak@linux.intel.com,
        adrian.hunter@intel.com, namhyung@kernel.org, dsahern@gmail.com,
        tglx@linutronix.de, acme@redhat.com, mingo@kernel.org,
        yao.jin@linux.intel.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf annotate: Move 'start' to struct annotation
Git-Commit-ID: 0ca693b315aa6893c9d3552fa6a5d536c38b6c4a
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

Commit-ID:  0ca693b315aa6893c9d3552fa6a5d536c38b6c4a
Gitweb:     https://git.kernel.org/tip/0ca693b315aa6893c9d3552fa6a5d536c38b6c4a
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 15 Mar 2018 15:46:22 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 20 Mar 2018 13:19:29 -0300

perf annotate: Move 'start' to struct annotation

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
