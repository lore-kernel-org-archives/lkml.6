Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751832AbeCTGSN (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 02:18:13 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37359 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751472AbeCTGSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 02:18:11 -0400
Date: Mon, 19 Mar 2018 23:16:48 -0700
From: tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-4acf6142de3fbc4fc9cc8da0a1aec073f05b724f@git.kernel.org>
Cc: dsahern@gmail.com, peterz@infradead.org, mingo@kernel.org,
        alexander.shishkin@linux.intel.com, acme@redhat.com, hpa@zytor.com,
        jolsa@kernel.org, namhyung@kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
Reply-To: peterz@infradead.org, alexander.shishkin@linux.intel.com,
        mingo@kernel.org, dsahern@gmail.com, acme@redhat.com,
        namhyung@kernel.org, jolsa@kernel.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
In-Reply-To: <20180309101442.9224-3-jolsa@kernel.org>
References: <20180309101442.9224-3-jolsa@kernel.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tools: Add mem2node object
Git-Commit-ID: 4acf6142de3fbc4fc9cc8da0a1aec073f05b724f
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

Commit-ID:  4acf6142de3fbc4fc9cc8da0a1aec073f05b724f
Gitweb:     https://git.kernel.org/tip/4acf6142de3fbc4fc9cc8da0a1aec073f05b724f
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Fri, 9 Mar 2018 11:14:35 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 16 Mar 2018 13:52:37 -0300

perf tools: Add mem2node object

Adding mem2node object to allow the easy lookup of the node for the
physical address.

It has following interface:

  int  mem2node__init(struct mem2node *map, struct perf_env *env);
  void mem2node__exit(struct mem2node *map);
  int  mem2node__node(struct mem2node *map, u64 addr);

The mem2node__toolsinit initialize object from the perf data file
MEM_TOPOLOGY feature data. Following calls to mem2node__node will return
node number for given physical address. The mem2node__exit function
frees the object.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180309101442.9224-3-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/Build      |   1 +
 tools/perf/util/mem2node.c | 134 +++++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/mem2node.h |  19 +++++++
 3 files changed, 154 insertions(+)

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index ea0a452550b0..8052373bcd6a 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -106,6 +106,7 @@ libperf-y += units.o
 libperf-y += time-utils.o
 libperf-y += expr-bison.o
 libperf-y += branch.o
+libperf-y += mem2node.o
 
 libperf-$(CONFIG_LIBBPF) += bpf-loader.o
 libperf-$(CONFIG_BPF_PROLOGUE) += bpf-prologue.o
diff --git a/tools/perf/util/mem2node.c b/tools/perf/util/mem2node.c
new file mode 100644
index 000000000000..c6fd81c02586
--- /dev/null
+++ b/tools/perf/util/mem2node.c
@@ -0,0 +1,134 @@
+#include <errno.h>
+#include <inttypes.h>
+#include <linux/bitmap.h>
+#include "mem2node.h"
+#include "util.h"
+
+struct phys_entry {
+	struct rb_node	rb_node;
+	u64	start;
+	u64	end;
+	u64	node;
+};
+
+static void phys_entry__insert(struct phys_entry *entry, struct rb_root *root)
+{
+	struct rb_node **p = &root->rb_node;
+	struct rb_node *parent = NULL;
+	struct phys_entry *e;
+
+	while (*p != NULL) {
+		parent = *p;
+		e = rb_entry(parent, struct phys_entry, rb_node);
+
+		if (entry->start < e->start)
+			p = &(*p)->rb_left;
+		else
+			p = &(*p)->rb_right;
+	}
+
+	rb_link_node(&entry->rb_node, parent, p);
+	rb_insert_color(&entry->rb_node, root);
+}
+
+static void
+phys_entry__init(struct phys_entry *entry, u64 start, u64 bsize, u64 node)
+{
+	entry->start = start;
+	entry->end   = start + bsize;
+	entry->node  = node;
+	RB_CLEAR_NODE(&entry->rb_node);
+}
+
+int mem2node__init(struct mem2node *map, struct perf_env *env)
+{
+	struct memory_node *n, *nodes = &env->memory_nodes[0];
+	struct phys_entry *entries, *tmp_entries;
+	u64 bsize = env->memory_bsize;
+	int i, j = 0, max = 0;
+
+	memset(map, 0x0, sizeof(*map));
+	map->root = RB_ROOT;
+
+	for (i = 0; i < env->nr_memory_nodes; i++) {
+		n = &nodes[i];
+		max += bitmap_weight(n->set, n->size);
+	}
+
+	entries = zalloc(sizeof(*entries) * max);
+	if (!entries)
+		return -ENOMEM;
+
+	for (i = 0; i < env->nr_memory_nodes; i++) {
+		u64 bit;
+
+		n = &nodes[i];
+
+		for (bit = 0; bit < n->size; bit++) {
+			u64 start;
+
+			if (!test_bit(bit, n->set))
+				continue;
+
+			start = bit * bsize;
+
+			/*
+			 * Merge nearby areas, we walk in order
+			 * through the bitmap, so no need to sort.
+			 */
+			if (j > 0) {
+				struct phys_entry *prev = &entries[j - 1];
+
+				if ((prev->end == start) &&
+				    (prev->node == n->node)) {
+					prev->end += bsize;
+					continue;
+				}
+			}
+
+			phys_entry__init(&entries[j++], start, bsize, n->node);
+		}
+	}
+
+	/* Cut unused entries, due to merging. */
+	tmp_entries = realloc(entries, sizeof(*entries) * j);
+	if (tmp_entries)
+		entries = tmp_entries;
+
+	for (i = 0; i < j; i++) {
+		pr_debug("mem2node %03" PRIu64 " [0x%016" PRIx64 "-0x%016" PRIx64 "]\n",
+			 entries[i].node, entries[i].start, entries[i].end);
+
+		phys_entry__insert(&entries[i], &map->root);
+	}
+
+	map->entries = entries;
+	return 0;
+}
+
+void mem2node__exit(struct mem2node *map)
+{
+	zfree(&map->entries);
+}
+
+int mem2node__node(struct mem2node *map, u64 addr)
+{
+	struct rb_node **p, *parent = NULL;
+	struct phys_entry *entry;
+
+	p = &map->root.rb_node;
+	while (*p != NULL) {
+		parent = *p;
+		entry = rb_entry(parent, struct phys_entry, rb_node);
+		if (addr < entry->start)
+			p = &(*p)->rb_left;
+		else if (addr >= entry->end)
+			p = &(*p)->rb_right;
+		else
+			goto out;
+	}
+
+	entry = NULL;
+out:
+	return entry ? (int) entry->node : -1;
+}
diff --git a/tools/perf/util/mem2node.h b/tools/perf/util/mem2node.h
new file mode 100644
index 000000000000..59c4752a2181
--- /dev/null
+++ b/tools/perf/util/mem2node.h
@@ -0,0 +1,19 @@
+#ifndef __MEM2NODE_H
+#define __MEM2NODE_H
+
+#include <linux/rbtree.h>
+#include "env.h"
+
+struct phys_entry;
+
+struct mem2node {
+	struct rb_root		 root;
+	struct phys_entry	*entries;
+	int			 cnt;
+};
+
+int  mem2node__init(struct mem2node *map, struct perf_env *env);
+void mem2node__exit(struct mem2node *map);
+int  mem2node__node(struct mem2node *map, u64 addr);
+
+#endif /* __MEM2NODE_H */
