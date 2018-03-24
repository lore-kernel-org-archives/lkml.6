Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753574AbeCXUIM (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 16:08:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:38036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753434AbeCXUE4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 16:04:56 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE62021839
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
Subject: [PATCH 37/44] perf annotate: No need to calculate notes->start twice
Date: Sat, 24 Mar 2018 17:02:04 -0300
Message-Id: <20180324200211.21326-38-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180324200211.21326-1-acme@kernel.org>
References: <20180324200211.21326-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

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
-- 
2.14.3
