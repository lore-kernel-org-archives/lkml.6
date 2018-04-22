Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753825AbeDVU1F (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 16:27:05 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33500 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753538AbeDVU1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 16:27:02 -0400
X-Google-Smtp-Source: AIpwx4/wduAyyVbFNAX7EkeXwznY+4EBKGduVYVuwvmtAF4O2PtWSiUsJgpOEKqcAN30W8uQzQ7DEg==
From: Greg Thelen <gthelen@google.com>
To: guro@fb.com, Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>
Cc: Vladimir Davydov <vdavydov.dev@gmail.com>, Tejun Heo <tj@kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, kernel-team@fb.com,
        Linux MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Greg Thelen <gthelen@google.com>
Subject: [RFC PATCH 2/2] memcg: add memory.min
Date: Sun, 22 Apr 2018 13:26:12 -0700
Message-Id: <20180422202612.127760-3-gthelen@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
In-Reply-To: <20180422202612.127760-1-gthelen@google.com>
References: <20180320223353.5673-1-guro@fb.com>
 <20180422202612.127760-1-gthelen@google.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new memory.min limit is similar to memory.low, just no bypassing it
when reclaim is desparate.  Prefer oom kills before reclaim memory below
memory.min.  Sharing more code with memory_cgroup_low() is possible, but
the idea is posted here for simplicity.

Signed-off-by: Greg Thelen <gthelen@google.com>
---
 include/linux/memcontrol.h |  8 ++++++
 mm/memcontrol.c            | 58 ++++++++++++++++++++++++++++++++++++++
 mm/vmscan.c                |  3 ++
 3 files changed, 69 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index c46016bb25eb..22bb4a88653a 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -178,6 +178,7 @@ struct mem_cgroup {
 	struct page_counter tcpmem;
 
 	/* Normal memory consumption range */
+	unsigned long min;
 	unsigned long low;
 	unsigned long high;
 
@@ -281,6 +282,7 @@ static inline bool mem_cgroup_disabled(void)
 	return !cgroup_subsys_enabled(memory_cgrp_subsys);
 }
 
+bool mem_cgroup_min(struct mem_cgroup *root, struct mem_cgroup *memcg);
 bool mem_cgroup_low(struct mem_cgroup *root, struct mem_cgroup *memcg);
 
 int mem_cgroup_try_charge(struct page *page, struct mm_struct *mm,
@@ -726,6 +728,12 @@ static inline void mem_cgroup_event(struct mem_cgroup *memcg,
 {
 }
 
+static inline bool mem_cgroup_min(struct mem_cgroup *root,
+				  struct mem_cgroup *memcg)
+{
+	return false;
+}
+
 static inline bool mem_cgroup_low(struct mem_cgroup *root,
 				  struct mem_cgroup *memcg)
 {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 9668f620203a..b2aaed4003b4 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5058,6 +5058,36 @@ static u64 memory_current_read(struct cgroup_subsys_state *css,
 	return (u64)page_counter_read(&memcg->memory) * PAGE_SIZE;
 }
 
+static int memory_min_show(struct seq_file *m, void *v)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_css(seq_css(m));
+	unsigned long min = READ_ONCE(memcg->min);
+
+	if (min == PAGE_COUNTER_MAX)
+		seq_puts(m, "max\n");
+	else
+		seq_printf(m, "%llu\n", (u64)min * PAGE_SIZE);
+
+	return 0;
+}
+
+static ssize_t memory_min_write(struct kernfs_open_file *of,
+				char *buf, size_t nbytes, loff_t off)
+{
+	struct mem_cgroup *memcg = mem_cgroup_from_css(of_css(of));
+	unsigned long min;
+	int err;
+
+	buf = strstrip(buf);
+	err = page_counter_memparse(buf, "max", &min);
+	if (err)
+		return err;
+
+	memcg->min = min;
+
+	return nbytes;
+}
+
 static int memory_low_show(struct seq_file *m, void *v)
 {
 	struct mem_cgroup *memcg = mem_cgroup_from_css(seq_css(m));
@@ -5288,6 +5318,12 @@ static struct cftype memory_files[] = {
 		.flags = CFTYPE_NOT_ON_ROOT,
 		.read_u64 = memory_current_read,
 	},
+	{
+		.name = "min",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.seq_show = memory_min_show,
+		.write = memory_min_write,
+	},
 	{
 		.name = "low",
 		.flags = CFTYPE_NOT_ON_ROOT,
@@ -5336,6 +5372,28 @@ struct cgroup_subsys memory_cgrp_subsys = {
 	.early_init = 0,
 };
 
+/**
+ * mem_cgroup_min returns true for a memcg below its min limit.  Such memcg are
+ * excempt from reclaim.
+ */
+bool mem_cgroup_min(struct mem_cgroup *root, struct mem_cgroup *memcg)
+{
+	if (mem_cgroup_disabled())
+		return false;
+
+	if (!root)
+		root = root_mem_cgroup;
+
+	if (memcg == root)
+		return false;
+
+	for (; memcg != root; memcg = parent_mem_cgroup(memcg)) {
+		if (page_counter_read(&memcg->memory) <= memcg->min)
+			return true; /* protect */
+	}
+	return false; /* !protect */
+}
+
 /**
  * mem_cgroup_low - check if memory consumption is below the normal range
  * @root: the top ancestor of the sub-tree being checked
diff --git a/mm/vmscan.c b/mm/vmscan.c
index cd5dc3faaa57..15ae19a38ad5 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2539,6 +2539,9 @@ static bool shrink_node(pg_data_t *pgdat, struct scan_control *sc)
 			unsigned long reclaimed;
 			unsigned long scanned;
 
+			if (mem_cgroup_min(root, memcg))
+				continue;
+
 			if (mem_cgroup_low(root, memcg)) {
 				if (!sc->memcg_low_reclaim) {
 					sc->memcg_low_skipped = 1;
-- 
2.17.0.484.g0c8726318c-goog
