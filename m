Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752679AbeCYWYW (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 18:24:22 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60787 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751002AbeCYWYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 18:24:10 -0400
Date: Sun, 25 Mar 2018 15:24:00 -0700
From: tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-ycxlg8mm5ueuj21w6gi62l7g@git.kernel.org>
Cc: jolsa@kernel.org, mingo@kernel.org, namhyung@kernel.org,
        ak@linux.intel.com, hpa@zytor.com, adrian.hunter@intel.com,
        dsahern@gmail.com, acme@redhat.com, wangnan0@huawei.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        yao.jin@linux.intel.com
Reply-To: jolsa@kernel.org, mingo@kernel.org, ak@linux.intel.com,
        hpa@zytor.com, namhyung@kernel.org, adrian.hunter@intel.com,
        dsahern@gmail.com, wangnan0@huawei.com, acme@redhat.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        yao.jin@linux.intel.com
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf annotate: No need to calculate notes->start
 twice
Git-Commit-ID: 425859ff0de33a2362bec2a2c7ca486f87c13100
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

Commit-ID:  425859ff0de33a2362bec2a2c7ca486f87c13100
Gitweb:     https://git.kernel.org/tip/425859ff0de33a2362bec2a2c7ca486f87c13100
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Tue, 20 Mar 2018 11:03:30 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 21 Mar 2018 12:53:43 -0300

perf annotate: No need to calculate notes->start twice

Since we already set notes->start to map__rip_2objdump(map, sym->start)
in symbol__annotate2(), no need to calculate that address again in
symbol__calc_lines(), just use notes->start.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: https://lkml.kernel.org/n/tip-ycxlg8mm5ueuj21w6gi62l7g@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index a7111871440e..666f62c58e1a 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2230,7 +2230,7 @@ void annotation__update_column_widths(struct annotation *notes)
 }
 
 static void annotation__calc_lines(struct annotation *notes, struct map *map,
-				  struct rb_root *root, u64 start)
+				  struct rb_root *root)
 {
 	struct annotation_line *al;
 	struct rb_root tmp_root = RB_ROOT;
@@ -2251,8 +2251,8 @@ static void annotation__calc_lines(struct annotation *notes, struct map *map,
 		if (percent_max <= 0.5)
 			continue;
 
-		al->path = get_srcline(map->dso, start + al->offset, NULL,
-				       false, true, start + al->offset);
+		al->path = get_srcline(map->dso, notes->start + al->offset, NULL,
+				       false, true, notes->start + al->offset);
 		insert_source_line(&tmp_root, al);
 	}
 
@@ -2263,9 +2263,8 @@ static void symbol__calc_lines(struct symbol *sym, struct map *map,
 			      struct rb_root *root)
 {
 	struct annotation *notes = symbol__annotation(sym);
-	u64 start = map__rip_2objdump(map, sym->start);
 
-	annotation__calc_lines(notes, map, root, start);
+	annotation__calc_lines(notes, map, root);
 }
 
 int symbol__tty_annotate2(struct symbol *sym, struct map *map,
