Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934082AbeCGPzv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 10:55:51 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37158 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934001AbeCGPun (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 10:50:43 -0500
From: Jiri Olsa <jolsa@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: [PATCH 09/19] perf tests: Add mem2node object test
Date: Wed,  7 Mar 2018 16:50:10 +0100
Message-Id: <20180307155020.32613-10-jolsa@kernel.org>
In-Reply-To: <20180307155020.32613-1-jolsa@kernel.org>
References: <20180307155020.32613-1-jolsa@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding mem2node object automated test.

The test prepares few artificial node - memory maps and
verifies the mem2node object returns proper node values
to given addresses.

Link: http://lkml.kernel.org/n/tip-17xdxr5k1zfca9o3fymowqa5@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/tests/Build          |  1 +
 tools/perf/tests/builtin-test.c |  4 +++
 tools/perf/tests/mem2node.c     | 73 +++++++++++++++++++++++++++++++++++++++++
 tools/perf/tests/tests.h        |  1 +
 4 files changed, 79 insertions(+)
 create mode 100644 tools/perf/tests/mem2node.c

diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index 87bf3edb037c..45782220ac23 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -47,6 +47,7 @@ perf-y += bitmap.o
 perf-y += perf-hooks.o
 perf-y += clang.o
 perf-y += unit_number__scnprintf.o
+perf-y += mem2node.o
 
 $(OUTPUT)tests/llvm-src-base.c: tests/bpf-script-example.c tests/Build
 	$(call rule_mkdir)
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index fafa014240cd..09071ef4434f 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -271,6 +271,10 @@ static struct test generic_tests[] = {
 		.func = test__unit_number__scnprint,
 	},
 	{
+		.desc = "mem2node",
+		.func = test__mem2node,
+	},
+	{
 		.func = NULL,
 	},
 };
diff --git a/tools/perf/tests/mem2node.c b/tools/perf/tests/mem2node.c
new file mode 100644
index 000000000000..c883607dcd22
--- /dev/null
+++ b/tools/perf/tests/mem2node.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/compiler.h>
+#include <linux/bitmap.h>
+#include "cpumap.h"
+#include "mem2node.h"
+#include "tests.h"
+
+static struct node {
+	int		 node;
+	const char 	*map;
+} test_nodes[] = {
+	{ .node = 0, .map = "0"     },
+	{ .node = 1, .map = "1-2"   },
+	{ .node = 3, .map = "5-7,9" },
+};
+
+#define T TEST_ASSERT_VAL
+
+static unsigned long *get_bitmap(const char *str, int nbits)
+{
+	struct cpu_map *map = cpu_map__new(str);
+	unsigned long *bm = NULL;
+	int i;
+
+	bm = bitmap_alloc(nbits);
+
+	if (map && bm) {
+		bitmap_zero(bm, nbits);
+
+		for (i = 0; i < map->nr; i++) {
+			set_bit(map->map[i], bm);
+		}
+	}
+
+	if (map)
+		cpu_map__put(map);
+	else
+		free(bm);
+
+	return bm && map ? bm : NULL;
+}
+
+int test__mem2node(struct test *t __maybe_unused, int subtest __maybe_unused)
+{
+	struct mem2node map;
+	struct memory_node nodes[3];
+	struct perf_env env = {
+		.memory_nodes    = (struct memory_node *) &nodes[0],
+		.nr_memory_nodes = ARRAY_SIZE(nodes),
+		.memory_bsize    = 0x100,
+	};
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(nodes); i++) {
+		nodes[i].node = test_nodes[i].node;
+		nodes[i].size = 10;
+
+		T("failed: alloc bitmap",
+		  (nodes[i].set = get_bitmap(test_nodes[i].map, 10)));
+	}
+
+	T("failed: mem2node__init", !mem2node__init(&map, &env));
+	T("failed: mem2node__node",  0 == mem2node__node(&map,   0x50));
+	T("failed: mem2node__node",  1 == mem2node__node(&map,  0x100));
+	T("failed: mem2node__node",  1 == mem2node__node(&map,  0x250));
+	T("failed: mem2node__node",  3 == mem2node__node(&map,  0x500));
+	T("failed: mem2node__node",  3 == mem2node__node(&map,  0x650));
+	T("failed: mem2node__node", -1 == mem2node__node(&map,  0x450));
+	T("failed: mem2node__node", -1 == mem2node__node(&map, 0x1050));
+
+	mem2node__exit(&map);
+	return 0;
+}
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 2862b80bc288..2e169819e647 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -102,6 +102,7 @@ int test__clang(struct test *test, int subtest);
 const char *test__clang_subtest_get_desc(int subtest);
 int test__clang_subtest_get_nr(void);
 int test__unit_number__scnprint(struct test *test, int subtest);
+int test__mem2node(struct test *t, int subtest);
 
 bool test__bp_signal_is_supported(void);
 
-- 
2.13.6
