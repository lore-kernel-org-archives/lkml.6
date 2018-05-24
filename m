Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755053AbeEXFj6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 01:39:58 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39299 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751873AbeEXFjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 01:39:47 -0400
Date: Wed, 23 May 2018 22:39:19 -0700
From: tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-4d004365e25251002935fc3843d80934248ad3ed@git.kernel.org>
Cc: dave.hansen@linux.intel.com, peterz@infradead.org, ak@linux.intel.com,
        acme@redhat.com, hpa@zytor.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, luto@kernel.org, jolsa@redhat.com,
        joro@8bytes.org, alexander.shishkin@linux.intel.com,
        adrian.hunter@intel.com, tglx@linutronix.de
Reply-To: adrian.hunter@intel.com, alexander.shishkin@linux.intel.com,
        joro@8bytes.org, tglx@linutronix.de, acme@redhat.com, hpa@zytor.com,
        peterz@infradead.org, ak@linux.intel.com, dave.hansen@linux.intel.com,
        jolsa@redhat.com, luto@kernel.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org
In-Reply-To: <1526986485-6562-7-git-send-email-adrian.hunter@intel.com>
References: <1526986485-6562-7-git-send-email-adrian.hunter@intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf machine: Fix map_groups__split_kallsyms() for
 entry trampoline symbols
Git-Commit-ID: 4d004365e25251002935fc3843d80934248ad3ed
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

Commit-ID:  4d004365e25251002935fc3843d80934248ad3ed
Gitweb:     https://git.kernel.org/tip/4d004365e25251002935fc3843d80934248ad3ed
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Tue, 22 May 2018 13:54:34 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 22 May 2018 10:55:59 -0300

perf machine: Fix map_groups__split_kallsyms() for entry trampoline symbols

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
