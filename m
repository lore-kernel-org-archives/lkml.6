Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934936AbeEWUVw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 16:21:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:33952 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934411AbeEWUVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 16:21:40 -0400
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Jiri Olsa <jolsa@redhat.com>,
        Joerg Roedel <joro@8bytes.org>, Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 06/18] perf machine: Fix map_groups__split_kallsyms() for entry trampoline symbols
Date: Wed, 23 May 2018 17:20:54 -0300
Message-Id: <20180523202106.17286-7-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180523202106.17286-1-acme@kernel.org>
References: <20180523202106.17286-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

When kernel symbols are derived from /proc/kallsyms only (not using
vmlinux or /proc/kcore) map_groups__split_kallsyms() is used. However
that function makes assumptions that are not true with entry trampoline
symbols. For now, remove the entry trampoline symbols at that point, as
they are no longer needed at that point.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: x86@kernel.org
Link: http://lkml.kernel.org/r/1526986485-6562-7-git-send-email-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/map.h    |  8 ++++++++
 tools/perf/util/symbol.c | 13 +++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index f1afe1ab6ff7..fafcc375ed37 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -8,6 +8,7 @@
 #include <linux/rbtree.h>
 #include <pthread.h>
 #include <stdio.h>
+#include <string.h>
 #include <stdbool.h>
 #include <linux/types.h>
 #include "rwsem.h"
@@ -239,4 +240,11 @@ static inline bool __map__is_kmodule(const struct map *map)
 
 bool map__has_symbols(const struct map *map);
 
+#define ENTRY_TRAMPOLINE_NAME "__entry_SYSCALL_64_trampoline"
+
+static inline bool is_entry_trampoline(const char *name)
+{
+	return !strcmp(name, ENTRY_TRAMPOLINE_NAME);
+}
+
 #endif /* __PERF_MAP_H */
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 701144094183..929058da6727 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -737,12 +737,15 @@ static int map_groups__split_kallsyms(struct map_groups *kmaps, struct dso *dso,
 	struct rb_root *root = &dso->symbols;
 	struct rb_node *next = rb_first(root);
 	int kernel_range = 0;
+	bool x86_64;
 
 	if (!kmaps)
 		return -1;
 
 	machine = kmaps->machine;
 
+	x86_64 = machine__is(machine, "x86_64");
+
 	while (next) {
 		char *module;
 
@@ -790,6 +793,16 @@ static int map_groups__split_kallsyms(struct map_groups *kmaps, struct dso *dso,
 			 */
 			pos->start = curr_map->map_ip(curr_map, pos->start);
 			pos->end   = curr_map->map_ip(curr_map, pos->end);
+		} else if (x86_64 && is_entry_trampoline(pos->name)) {
+			/*
+			 * These symbols are not needed anymore since the
+			 * trampoline maps refer to the text section and it's
+			 * symbols instead. Avoid having to deal with
+			 * relocations, and the assumption that the first symbol
+			 * is the start of kernel text, by simply removing the
+			 * symbols at this point.
+			 */
+			goto discard_symbol;
 		} else if (curr_map != initial_map) {
 			char dso_name[PATH_MAX];
 			struct dso *ndso;
-- 
2.14.3
