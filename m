Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933070AbeCMMFf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 08:05:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:54398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752330AbeCMMFd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 08:05:33 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0394221783
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 03/31] perf tests: Add mem2node object test
Date: Tue, 13 Mar 2018 09:04:40 -0300
Message-Id: <20180313120508.29327-4-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180313120508.29327-1-acme@kernel.org>
References: <20180313120508.29327-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Adding mem2node object automated test.

The test prepares few artificial nodes - memory maps and verifies the
mem2node object returns proper node values to given addresses.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180309101442.9224-4-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/Build          |  1 +
 tools/perf/tests/builtin-test.c |  4 +++
 tools/perf/tests/mem2node.c     | 75 +++++++++++++++++++++++++++++++++++++++++
 tools/perf/tests/tests.h        |  1 +
 4 files changed, 81 insertions(+)
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
@@ -270,6 +270,10 @@ static struct test generic_tests[] = {
 		.desc = "unit_number__scnprintf",
 		.func = test__unit_number__scnprint,
 	},
+	{
+		.desc = "mem2node",
+		.func = test__mem2node,
+	},
 	{
 		.func = NULL,
 	},
diff --git a/tools/perf/tests/mem2node.c b/tools/perf/tests/mem2node.c
new file mode 100644
index 000000000000..0c3c87f86e03
--- /dev/null
+++ b/tools/perf/tests/mem2node.c
@@ -0,0 +1,75 @@
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
+	for (i = 0; i < ARRAY_SIZE(nodes); i++)
+		free(nodes[i].set);
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
2.14.3
