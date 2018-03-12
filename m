Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932536AbeCLQ7y (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 12:59:54 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:39830 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932190AbeCLQ7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 12:59:52 -0400
Smtp-Origin-Hostprefix: devbig
From: Song Liu <songliubraving@fb.com>
Smtp-Origin-Hostname: devbig102.frc2.facebook.com
To: <linux-kernel@vger.kernel.org>, <peterz@infradead.org>,
        <jolsa@redhat.com>
CC: <kernel-team@fb.com>, <ephiepark@fb.com>,
        Song Liu <songliubraving@fb.com>
Smtp-Origin-Cluster: frc2c02
Subject: [PATCH v2] perf: update perf_cgroup time for ancestor cgroup(s)
Date: Mon, 12 Mar 2018 09:59:43 -0700
Message-ID: <20180312165943.1057894-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.9.5
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-12_09:,,
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
results. Here is an example case:

  # create cgroups
  mkdir -p /sys/fs/cgroup/p/c
  # start perf for parent group
  perf stat -e instructions -G "p"

  # on another console, run test process in child cgroup:
  stressapptest -s 2 -M 1000 & echo $! > /sys/fs/cgroup/p/c/cgroup.procs

  # after the test process is done, stop perf in the first console shows

       <not counted>      instructions              p

The instruction should not be "not counted" as the process runs in the
child cgroup.

We found this is because perf_event->cgrp and cpuctx->cgrp are not
identical, thus perf_event->cgrp are not updated properly.

This patch fixes this by updating perf_cgroup properly for ancestor
cgroup(s).

Signed-off-by: Song Liu <songliubraving@fb.com>
Reported-by: Ephraim Park <ephiepark@fb.com>
---
 kernel/events/core.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 5789810..6f015ff 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -724,9 +724,14 @@ static inline void __update_cgrp_time(struct perf_cgroup *cgrp)
 
 static inline void update_cgrp_time_from_cpuctx(struct perf_cpu_context *cpuctx)
 {
-	struct perf_cgroup *cgrp_out = cpuctx->cgrp;
-	if (cgrp_out)
-		__update_cgrp_time(cgrp_out);
+	struct perf_cgroup *cgrp = cpuctx->cgrp;
+	struct cgroup_subsys_state *css;
+
+	if (cgrp)
+		for (css = &cgrp->css; css; css = css->parent) {
+			cgrp = container_of(css, struct perf_cgroup, css);
+			__update_cgrp_time(cgrp);
+		}
 }
 
 static inline void update_cgrp_time_from_event(struct perf_event *event)
@@ -754,6 +759,7 @@ perf_cgroup_set_timestamp(struct task_struct *task,
 {
 	struct perf_cgroup *cgrp;
 	struct perf_cgroup_info *info;
+	struct cgroup_subsys_state *css;
 
 	/*
 	 * ctx->lock held by caller
@@ -764,8 +770,12 @@ perf_cgroup_set_timestamp(struct task_struct *task,
 		return;
 
 	cgrp = perf_cgroup_from_task(task, ctx);
-	info = this_cpu_ptr(cgrp->info);
-	info->timestamp = ctx->timestamp;
+
+	for (css = &cgrp->css; css; css = css->parent) {
+		cgrp = container_of(css, struct perf_cgroup, css);
+		info = this_cpu_ptr(cgrp->info);
+		info->timestamp = ctx->timestamp;
+	}
 }
 
 static DEFINE_PER_CPU(struct list_head, cgrp_cpuctx_list);
-- 
2.9.5
