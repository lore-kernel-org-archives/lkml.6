Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751896AbeCYWQ7 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 18:16:59 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42357 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750960AbeCYWQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 18:16:58 -0400
Date: Sun, 25 Mar 2018 15:16:47 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-ikdjr014p7k5kachgyjrgiey@git.kernel.org>
Cc: yao.jin@linux.intel.com, linux-kernel@vger.kernel.org,
        dsahern@gmail.com, hpa@zytor.com, jolsa@kernel.org,
        namhyung@kernel.org, adrian.hunter@intel.com, tglx@linutronix.de,
        wangnan0@huawei.com, acme@redhat.com, ak@linux.intel.com,
        mingo@kernel.org
Reply-To: linux-kernel@vger.kernel.org, yao.jin@linux.intel.com, hpa@zytor.com,
        dsahern@gmail.com, jolsa@kernel.org, adrian.hunter@intel.com,
        tglx@linutronix.de, namhyung@kernel.org, wangnan0@huawei.com,
        acme@redhat.com, mingo@kernel.org, ak@linux.intel.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf annotate: Move update_column_widths() to the
 generic lib
Git-Commit-ID: 7232bf7a8954e4f6558e6b74fb6a2403e7a3b7be
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

Commit-ID:  7232bf7a8954e4f6558e6b74fb6a2403e7a3b7be
Gitweb:     https://git.kernel.org/tip/7232bf7a8954e4f6558e6b74fb6a2403e7a3b7be
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 15 Mar 2018 16:19:59 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 20 Mar 2018 13:19:29 -0300

perf annotate: Move update_column_widths() to the generic lib

Previous patch left it where it was to ease review, move it to its
right place.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-ikdjr014p7k5kachgyjrgiey@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate.c | 13 -------------
 tools/perf/util/annotate.c        | 13 +++++++++++++
 tools/perf/util/annotate.h        |  1 +
 3 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index 07d0d2268008..ab4d004fc184 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -698,19 +698,6 @@ bool annotate_browser__continue_search_reverse(struct annotate_browser *browser,
 	return __annotate_browser__search_reverse(browser);
 }
 
-static void annotation__update_column_widths(struct annotation *notes)
-{
-	if (notes->options->use_offset)
-		notes->widths.target = notes->widths.min_addr;
-	else
-		notes->widths.target = notes->widths.max_addr;
-
-	notes->widths.addr = notes->widths.target;
-
-	if (notes->options->show_nr_jumps)
-		notes->widths.addr += notes->widths.jumps + 1;
-}
-
 static int annotate_browser__run(struct annotate_browser *browser,
 				 struct perf_evsel *evsel,
 				 struct hist_browser_timer *hbt)
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index b976e3951662..8a2fda80a221 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2084,6 +2084,19 @@ void annotation__set_offsets(struct annotation *notes, s64 size)
 	}
 }
 
+void annotation__update_column_widths(struct annotation *notes)
+{
+	if (notes->options->use_offset)
+		notes->widths.target = notes->widths.min_addr;
+	else
+		notes->widths.target = notes->widths.max_addr;
+
+	notes->widths.addr = notes->widths.target;
+
+	if (notes->options->show_nr_jumps)
+		notes->widths.addr += notes->widths.jumps + 1;
+}
+
 static void annotation__calc_lines(struct annotation *notes, struct map *map,
 				  struct rb_root *root, u64 start)
 {
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 0aa77c154fe3..a8bea758490a 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -203,6 +203,7 @@ static inline int annotation__pcnt_width(struct annotation *notes)
 void annotation__set_offsets(struct annotation *notes, s64 size);
 void annotation__compute_ipc(struct annotation *notes, size_t size);
 void annotation__mark_jump_targets(struct annotation *notes, struct symbol *sym);
+void annotation__update_column_widths(struct annotation *notes);
 
 static inline struct sym_hist *annotation__histogram(struct annotation *notes, int idx)
 {
