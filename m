Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753039AbeCTLSo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 07:18:44 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54673 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752803AbeCTLSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 07:18:31 -0400
Date: Tue, 20 Mar 2018 04:18:06 -0700
From: tip-bot for Song Liu <tipbot@zytor.com>
Message-ID: <tip-c917e0f259908e75bd2a65877e25f9d90c22c848@git.kernel.org>
Cc: hpa@zytor.com, peterz@infradead.org, mingo@kernel.org,
        vincent.weaver@maine.edu, songliubraving@fb.com, acme@redhat.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, kernel-team@fb.com, eranian@google.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com, ephiepark@fb.com
Reply-To: mingo@kernel.org, vincent.weaver@maine.edu, songliubraving@fb.com,
        hpa@zytor.com, peterz@infradead.org, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com, ephiepark@fb.com, jolsa@redhat.com,
        eranian@google.com, kernel-team@fb.com, acme@redhat.com,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org
In-Reply-To: <20180312165943.1057894-1-songliubraving@fb.com>
References: <20180312165943.1057894-1-songliubraving@fb.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf/cgroup: Fix child event counting bug
Git-Commit-ID: c917e0f259908e75bd2a65877e25f9d90c22c848
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

Commit-ID:  c917e0f259908e75bd2a65877e25f9d90c22c848
Gitweb:     https://git.kernel.org/tip/c917e0f259908e75bd2a65877e25f9d90c22c848
Author:     Song Liu <songliubraving@fb.com>
AuthorDate: Mon, 12 Mar 2018 09:59:43 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 20 Mar 2018 08:58:47 +0100

perf/cgroup: Fix child event counting bug

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

Reported-by: Ephraim Park <ephiepark@fb.com>
Signed-off-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: <jolsa@redhat.com>
Cc: <kernel-team@fb.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Link: http://lkml.kernel.org/r/20180312165943.1057894-1-songliubraving@fb.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/events/core.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 4b838470fac4..709a55b9ad97 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -724,9 +724,15 @@ static inline void __update_cgrp_time(struct perf_cgroup *cgrp)
 
 static inline void update_cgrp_time_from_cpuctx(struct perf_cpu_context *cpuctx)
 {
-	struct perf_cgroup *cgrp_out = cpuctx->cgrp;
-	if (cgrp_out)
-		__update_cgrp_time(cgrp_out);
+	struct perf_cgroup *cgrp = cpuctx->cgrp;
+	struct cgroup_subsys_state *css;
+
+	if (cgrp) {
+		for (css = &cgrp->css; css; css = css->parent) {
+			cgrp = container_of(css, struct perf_cgroup, css);
+			__update_cgrp_time(cgrp);
+		}
+	}
 }
 
 static inline void update_cgrp_time_from_event(struct perf_event *event)
@@ -754,6 +760,7 @@ perf_cgroup_set_timestamp(struct task_struct *task,
 {
 	struct perf_cgroup *cgrp;
 	struct perf_cgroup_info *info;
+	struct cgroup_subsys_state *css;
 
 	/*
 	 * ctx->lock held by caller
@@ -764,8 +771,12 @@ perf_cgroup_set_timestamp(struct task_struct *task,
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
