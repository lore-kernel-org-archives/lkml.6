Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752369AbeCHTwx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 14:52:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:60912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932141AbeCHTws (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 14:52:48 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0330921796
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
Subject: [PATCH 46/54] perf tools: Add MEM_TOPOLOGY feature to perf data file
Date: Thu,  8 Mar 2018 16:50:21 -0300
Message-Id: <20180308195029.14991-47-acme@kernel.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180308195029.14991-1-acme@kernel.org>
References: <20180308195029.14991-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Adding MEM_TOPOLOGY feature to perf data file,
that will carry physical memory map and its
node assignments.

The format of data in MEM_TOPOLOGY is as follows:

  0 - version          | for future changes
  8 - block_size_bytes | /sys/devices/system/memory/block_size_bytes
 16 - count            | number of nodes

 For each node we store map of physical indexes for
 each node:

 32 - node id          | node index
 40 - size             | size of bitmap
 48 - bitmap           | bitmap of memory indexes that belongs to node
                       | /sys/devices/system/node/node<NODE>/memory<INDEX>

The MEM_TOPOLOGY could be displayed with following
report command:

  $ perf report --header-only -I
  ...
  # memory nodes (nr 1, block size 0x8000000):
  #    0 [7G]: 0-23,32-69

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180307155020.32613-8-jolsa@kernel.org
[ Rename 'index' to 'idx', as this breaks the build in rhel5, 6 and other systems where this is used by glibc headers ]
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/linux/bitmap.h |   2 +-
 tools/perf/util/env.h        |   9 ++
 tools/perf/util/header.c     | 305 +++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/header.h     |   1 +
 4 files changed, 316 insertions(+), 1 deletion(-)

diff --git a/tools/include/linux/bitmap.h b/tools/include/linux/bitmap.h
index ca160270fdfa..63440cc8d618 100644
--- a/tools/include/linux/bitmap.h
+++ b/tools/include/linux/bitmap.h
@@ -98,7 +98,7 @@ static inline int test_and_set_bit(int nr, unsigned long *addr)
 
 /**
  * bitmap_alloc - Allocate bitmap
- * @nr: Bit to set
+ * @nbits: Number of bits
  */
 static inline unsigned long *bitmap_alloc(int nbits)
 {
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index bf970f57dce0..c4ef2e523367 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -27,6 +27,12 @@ struct numa_node {
 	struct cpu_map	*map;
 };
 
+struct memory_node {
+	u64		 node;
+	u64		 size;
+	unsigned long	*set;
+};
+
 struct perf_env {
 	char			*hostname;
 	char			*os_release;
@@ -43,6 +49,7 @@ struct perf_env {
 	int			nr_sibling_cores;
 	int			nr_sibling_threads;
 	int			nr_numa_nodes;
+	int			nr_memory_nodes;
 	int			nr_pmu_mappings;
 	int			nr_groups;
 	char			*cmdline;
@@ -54,6 +61,8 @@ struct perf_env {
 	struct cpu_cache_level	*caches;
 	int			 caches_cnt;
 	struct numa_node	*numa_nodes;
+	struct memory_node	*memory_nodes;
+	unsigned long long	 memory_bsize;
 };
 
 extern struct perf_env perf_env;
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index e0c3cad0fd8d..e14b3f7c7212 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -17,6 +17,7 @@
 #include <sys/stat.h>
 #include <sys/utsname.h>
 #include <linux/time64.h>
+#include <dirent.h>
 
 #include "evlist.h"
 #include "evsel.h"
@@ -37,6 +38,7 @@
 #include "asm/bug.h"
 #include "tool.h"
 #include "time-utils.h"
+#include "units.h"
 
 #include "sane_ctype.h"
 
@@ -131,6 +133,25 @@ int do_write(struct feat_fd *ff, const void *buf, size_t size)
 	return __do_write_buf(ff, buf, size);
 }
 
+/* Return: 0 if succeded, -ERR if failed. */
+static int do_write_bitmap(struct feat_fd *ff, unsigned long *set, u64 size)
+{
+	u64 *p = (u64 *) set;
+	int i, ret;
+
+	ret = do_write(ff, &size, sizeof(size));
+	if (ret < 0)
+		return ret;
+
+	for (i = 0; (u64) i < BITS_TO_U64(size); i++) {
+		ret = do_write(ff, p + i, sizeof(*p));
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
 /* Return: 0 if succeded, -ERR if failed. */
 int write_padded(struct feat_fd *ff, const void *bf,
 		 size_t count, size_t count_aligned)
@@ -243,6 +264,38 @@ static char *do_read_string(struct feat_fd *ff)
 	return NULL;
 }
 
+/* Return: 0 if succeded, -ERR if failed. */
+static int do_read_bitmap(struct feat_fd *ff, unsigned long **pset, u64 *psize)
+{
+	unsigned long *set;
+	u64 size, *p;
+	int i, ret;
+
+	ret = do_read_u64(ff, &size);
+	if (ret)
+		return ret;
+
+	set = bitmap_alloc(size);
+	if (!set)
+		return -ENOMEM;
+
+	bitmap_zero(set, size);
+
+	p = (u64 *) set;
+
+	for (i = 0; (u64) i < BITS_TO_U64(size); i++) {
+		ret = do_read_u64(ff, p + i);
+		if (ret < 0) {
+			free(set);
+			return ret;
+		}
+	}
+
+	*pset  = set;
+	*psize = size;
+	return 0;
+}
+
 static int write_tracing_data(struct feat_fd *ff,
 			      struct perf_evlist *evlist)
 {
@@ -1196,6 +1249,176 @@ static int write_sample_time(struct feat_fd *ff,
 			sizeof(evlist->last_sample_time));
 }
 
+
+static int memory_node__read(struct memory_node *n, unsigned long idx)
+{
+	unsigned int phys, size = 0;
+	char path[PATH_MAX];
+	struct dirent *ent;
+	DIR *dir;
+
+#define for_each_memory(mem, dir)					\
+	while ((ent = readdir(dir)))					\
+		if (strcmp(ent->d_name, ".") &&				\
+		    strcmp(ent->d_name, "..") &&			\
+		    sscanf(ent->d_name, "memory%u", &mem) == 1)
+
+	scnprintf(path, PATH_MAX,
+		  "%s/devices/system/node/node%lu",
+		  sysfs__mountpoint(), idx);
+
+	dir = opendir(path);
+	if (!dir) {
+		pr_warning("failed: cant' open memory sysfs data\n");
+		return -1;
+	}
+
+	for_each_memory(phys, dir) {
+		size = max(phys, size);
+	}
+
+	size++;
+
+	n->set = bitmap_alloc(size);
+	if (!n->set) {
+		closedir(dir);
+		return -ENOMEM;
+	}
+
+	bitmap_zero(n->set, size);
+	n->node = idx;
+	n->size = size;
+
+	rewinddir(dir);
+
+	for_each_memory(phys, dir) {
+		set_bit(phys, n->set);
+	}
+
+	closedir(dir);
+	return 0;
+}
+
+static int memory_node__sort(const void *a, const void *b)
+{
+	const struct memory_node *na = a;
+	const struct memory_node *nb = b;
+
+	return na->node - nb->node;
+}
+
+static int build_mem_topology(struct memory_node *nodes, u64 size, u64 *cntp)
+{
+	char path[PATH_MAX];
+	struct dirent *ent;
+	DIR *dir;
+	u64 cnt = 0;
+	int ret = 0;
+
+	scnprintf(path, PATH_MAX, "%s/devices/system/node/",
+		  sysfs__mountpoint());
+
+	dir = opendir(path);
+	if (!dir) {
+		pr_warning("failed: can't open node sysfs data\n");
+		return -1;
+	}
+
+	while (!ret && (ent = readdir(dir))) {
+		unsigned int idx;
+		int r;
+
+		if (!strcmp(ent->d_name, ".") ||
+		    !strcmp(ent->d_name, ".."))
+			continue;
+
+		r = sscanf(ent->d_name, "node%u", &idx);
+		if (r != 1)
+			continue;
+
+		if (WARN_ONCE(cnt >= size,
+			      "failed to write MEM_TOPOLOGY, way too many nodes\n"))
+			return -1;
+
+		ret = memory_node__read(&nodes[cnt++], idx);
+	}
+
+	*cntp = cnt;
+	closedir(dir);
+
+	if (!ret)
+		qsort(nodes, cnt, sizeof(nodes[0]), memory_node__sort);
+
+	return ret;
+}
+
+#define MAX_MEMORY_NODES 2000
+
+/*
+ * The MEM_TOPOLOGY holds physical memory map for every
+ * node in system. The format of data is as follows:
+ *
+ *  0 - version          | for future changes
+ *  8 - block_size_bytes | /sys/devices/system/memory/block_size_bytes
+ * 16 - count            | number of nodes
+ *
+ * For each node we store map of physical indexes for
+ * each node:
+ *
+ * 32 - node id          | node index
+ * 40 - size             | size of bitmap
+ * 48 - bitmap           | bitmap of memory indexes that belongs to node
+ */
+static int write_mem_topology(struct feat_fd *ff __maybe_unused,
+			      struct perf_evlist *evlist __maybe_unused)
+{
+	static struct memory_node nodes[MAX_MEMORY_NODES];
+	u64 bsize, version = 1, i, nr;
+	int ret;
+
+	ret = sysfs__read_xll("devices/system/memory/block_size_bytes",
+			      (unsigned long long *) &bsize);
+	if (ret)
+		return ret;
+
+	ret = build_mem_topology(&nodes[0], MAX_MEMORY_NODES, &nr);
+	if (ret)
+		return ret;
+
+	ret = do_write(ff, &version, sizeof(version));
+	if (ret < 0)
+		goto out;
+
+	ret = do_write(ff, &bsize, sizeof(bsize));
+	if (ret < 0)
+		goto out;
+
+	ret = do_write(ff, &nr, sizeof(nr));
+	if (ret < 0)
+		goto out;
+
+	for (i = 0; i < nr; i++) {
+		struct memory_node *n = &nodes[i];
+
+		#define _W(v)						\
+			ret = do_write(ff, &n->v, sizeof(n->v));	\
+			if (ret < 0)					\
+				goto out;
+
+		_W(node)
+		_W(size)
+
+		#undef _W
+
+		ret = do_write_bitmap(ff, n->set, n->size);
+		if (ret < 0)
+			goto out;
+	}
+
+out:
+	return ret;
+}
+
 static void print_hostname(struct feat_fd *ff, FILE *fp)
 {
 	fprintf(fp, "# hostname : %s\n", ff->ph->env.hostname);
@@ -1543,6 +1766,35 @@ static void print_sample_time(struct feat_fd *ff, FILE *fp)
 	fprintf(fp, "# sample duration : %10.3f ms\n", d);
 }
 
+static void memory_node__fprintf(struct memory_node *n,
+				 unsigned long long bsize, FILE *fp)
+{
+	char buf_map[100], buf_size[50];
+	unsigned long long size;
+
+	size = bsize * bitmap_weight(n->set, n->size);
+	unit_number__scnprintf(buf_size, 50, size);
+
+	bitmap_scnprintf(n->set, n->size, buf_map, 100);
+	fprintf(fp, "#  %3" PRIu64 " [%s]: %s\n", n->node, buf_size, buf_map);
+}
+
+static void print_mem_topology(struct feat_fd *ff, FILE *fp)
+{
+	struct memory_node *nodes;
+	int i, nr;
+
+	nodes = ff->ph->env.memory_nodes;
+	nr    = ff->ph->env.nr_memory_nodes;
+
+	fprintf(fp, "# memory nodes (nr %d, block size 0x%llx):\n",
+		nr, ff->ph->env.memory_bsize);
+
+	for (i = 0; i < nr; i++) {
+		memory_node__fprintf(&nodes[i], ff->ph->env.memory_bsize, fp);
+	}
+}
+
 static int __event_process_build_id(struct build_id_event *bev,
 				    char *filename,
 				    struct perf_session *session)
@@ -2205,6 +2457,58 @@ static int process_sample_time(struct feat_fd *ff, void *data __maybe_unused)
 	return 0;
 }
 
+static int process_mem_topology(struct feat_fd *ff,
+				void *data __maybe_unused)
+{
+	struct memory_node *nodes;
+	u64 version, i, nr, bsize;
+	int ret = -1;
+
+	if (do_read_u64(ff, &version))
+		return -1;
+
+	if (version != 1)
+		return -1;
+
+	if (do_read_u64(ff, &bsize))
+		return -1;
+
+	if (do_read_u64(ff, &nr))
+		return -1;
+
+	nodes = zalloc(sizeof(*nodes) * nr);
+	if (!nodes)
+		return -1;
+
+	for (i = 0; i < nr; i++) {
+		struct memory_node n;
+
+		#define _R(v)				\
+			if (do_read_u64(ff, &n.v))	\
+				goto out;		\
+
+		_R(node)
+		_R(size)
+
+		#undef _R
+
+		if (do_read_bitmap(ff, &n.set, &n.size))
+			goto out;
+
+		nodes[i] = n;
+	}
+
+	ff->ph->env.memory_bsize    = bsize;
+	ff->ph->env.memory_nodes    = nodes;
+	ff->ph->env.nr_memory_nodes = nr;
+	ret = 0;
+
+out:
+	if (ret)
+		free(nodes);
+	return ret;
+}
+
 struct feature_ops {
 	int (*write)(struct feat_fd *ff, struct perf_evlist *evlist);
 	void (*print)(struct feat_fd *ff, FILE *fp);
@@ -2263,6 +2567,7 @@ static const struct feature_ops feat_ops[HEADER_LAST_FEATURE] = {
 	FEAT_OPN(STAT,		stat,		false),
 	FEAT_OPN(CACHE,		cache,		true),
 	FEAT_OPR(SAMPLE_TIME,	sample_time,	false),
+	FEAT_OPR(MEM_TOPOLOGY,	mem_topology,	true),
 };
 
 struct header_print_data {
diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index 942bdec6d70d..90d4577a92dc 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -36,6 +36,7 @@ enum {
 	HEADER_STAT,
 	HEADER_CACHE,
 	HEADER_SAMPLE_TIME,
+	HEADER_MEM_TOPOLOGY,
 	HEADER_LAST_FEATURE,
 	HEADER_FEAT_BITS	= 256,
 };
-- 
2.14.3
