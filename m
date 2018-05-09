Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934701AbeEILpg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 07:45:36 -0400
Received: from mga14.intel.com ([192.55.52.115]:26332 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934376AbeEILpd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 07:45:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,381,1520924400";
   d="scan'208";a="54445928"
From: Adrian Hunter <adrian.hunter@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Jiri Olsa <jolsa@redhat.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH RFC 08/19] perf tools: Fix map_groups__split_kallsyms() for entry trampoline symbols
Date: Wed,  9 May 2018 14:43:37 +0300
Message-Id: <1525866228-30321-9-git-send-email-adrian.hunter@intel.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1525866228-30321-1-git-send-email-adrian.hunter@intel.com>
References: <1525866228-30321-1-git-send-email-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When kernel symbols are derived from /proc/kallsyms only (not using vmlinux
or /proc/kcore) map_groups__split_kallsyms() is used. However that function
makes assumptions that are not true with entry trampoline symbols. For now,
remove the entry trampoline symbols at that point, as they are no longer
needed at that point.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
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
index c3a1a89a61cb..e393f37b273b 100644
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
 
+	x86_64 = machine && machine__is(machine, "x86_64");
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
1.9.1
