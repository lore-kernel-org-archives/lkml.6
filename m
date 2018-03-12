Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751450AbeCLFcu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 01:32:50 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:55868 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751234AbeCLFct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 01:32:49 -0400
Smtp-Origin-Hostprefix: devbig
From: Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig102.frc2.facebook.com
To: <linux-kernel@vger.kernel.org>, <peterz@infradead.org>,
        <jolsa@redhat.com>
CC: <kernel-team@fb.com>, <ephiepark@fb.com>,
        Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: frc2c02
Subject: [PATCH] perf: update perf_cgroup time for ancestor cgroup(s)
Date: Sun, 11 Mar 2018 22:32:44 -0700
Message-ID: <20180312053244.2593974-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.9.5
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-12_02:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a perf_event is attached to parent cgroup, it should count events
for all children cgroups:

 parent_group   <---- perf_event
   \
    - child_group  <---- process(es)

However, in our tests, we found this perf_event cannot report reliable
results. This is because perf_event->cgrp and cpuctx->cgrp are not
identical, thus perf_event->cgrp are not updated properly.

This patch fixes this by updating perf_cgroup properly for ancestor
cgroup(s).

Signed-off-by: Song Liu <songliubraving@fb.com>
Reported-by: Ephraim Park <ephiepark@fb.com>
---
 kernel/events/core.c | 68 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 67 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 5789810..623d38f 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -722,11 +722,48 @@ static inline void __update_cgrp_time(struct perf_cgroup *cgrp)
 	info->timestamp = now;
 }
 
+static inline void
+update_ancestor_cgroup_time(struct perf_event *event,
+			    struct perf_cgroup *cgrp,
+			    struct perf_cgroup_info *cgrp_info)
+{
+	if (!is_cgroup_event(event))
+		return;
+
+	if (cgroup_is_descendant(cgrp->css.cgroup,
+				 event->cgrp->css.cgroup) &&
+	    event->cgrp != cgrp) {
+		struct perf_cgroup_info *info;
+
+		info = this_cpu_ptr(event->cgrp->info);
+		info->time += cgrp_info->timestamp - info->timestamp;
+		info->timestamp = cgrp_info->timestamp;
+	}
+}
+
 static inline void update_cgrp_time_from_cpuctx(struct perf_cpu_context *cpuctx)
 {
 	struct perf_cgroup *cgrp_out = cpuctx->cgrp;
-	if (cgrp_out)
+
+	if (cgrp_out) {
 		__update_cgrp_time(cgrp_out);
+
+		/* update time for ancestor cgroups */
+		if (cgrp_out->css.cgroup->level > 1) {
+			struct perf_cgroup_info *info
+				= this_cpu_ptr(cgrp_out->info);
+			struct perf_event *event;
+
+			list_for_each_entry(event, &cpuctx->ctx.pinned_groups,
+					    group_entry)
+				update_ancestor_cgroup_time(event, cgrp_out,
+							    info);
+			list_for_each_entry(event, &cpuctx->ctx.flexible_groups,
+					    group_entry)
+				update_ancestor_cgroup_time(event, cgrp_out,
+							    info);
+		}
+	}
 }
 
 static inline void update_cgrp_time_from_event(struct perf_event *event)
@@ -749,6 +786,24 @@ static inline void update_cgrp_time_from_event(struct perf_event *event)
 }
 
 static inline void
+perf_ancestor_cgroup_set_timestamp(struct perf_event *event,
+				   struct perf_cgroup *cgrp,
+				   struct perf_cgroup_info *cgrp_info)
+{
+	if (!is_cgroup_event(event))
+		return;
+
+	if (cgroup_is_descendant(cgrp->css.cgroup,
+				 event->cgrp->css.cgroup) &&
+	    event->cgrp != cgrp) {
+		struct perf_cgroup_info *info
+			= this_cpu_ptr(event->cgrp->info);
+
+		info->timestamp = cgrp_info->timestamp;
+	}
+}
+
+static inline void
 perf_cgroup_set_timestamp(struct task_struct *task,
 			  struct perf_event_context *ctx)
 {
@@ -766,6 +821,17 @@ perf_cgroup_set_timestamp(struct task_struct *task,
 	cgrp = perf_cgroup_from_task(task, ctx);
 	info = this_cpu_ptr(cgrp->info);
 	info->timestamp = ctx->timestamp;
+
+	/* set timestamp for ancestor cgroups */
+	if (cgrp->css.cgroup->level > 1) {
+		struct perf_cgroup_info *info = this_cpu_ptr(cgrp->info);
+		struct perf_event *event;
+
+		list_for_each_entry(event, &ctx->pinned_groups, group_entry)
+			perf_ancestor_cgroup_set_timestamp(event, cgrp, info);
+		list_for_each_entry(event, &ctx->flexible_groups, group_entry)
+			perf_ancestor_cgroup_set_timestamp(event, cgrp, info);
+	}
 }
 
 static DEFINE_PER_CPU(struct list_head, cgrp_cpuctx_list);
-- 
2.9.5
