Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164174AbeE1Kxl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:53:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:42650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163766AbeE1Kxc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:53:32 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ephraim Park <ephiepark@fb.com>,
        Song Liu <songliubraving@fb.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, jolsa@redhat.com,
        kernel-team@fb.com,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 272/496] perf/cgroup: Fix child event counting bug
Date: Mon, 28 May 2018 12:00:57 +0200
Message-Id: <20180528100331.312543282@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Song Liu <songliubraving@fb.com>

[ Upstream commit c917e0f259908e75bd2a65877e25f9d90c22c848 ]

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
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/events/core.c |   21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -642,9 +642,15 @@ static inline void __update_cgrp_time(st
 
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
@@ -672,6 +678,7 @@ perf_cgroup_set_timestamp(struct task_st
 {
 	struct perf_cgroup *cgrp;
 	struct perf_cgroup_info *info;
+	struct cgroup_subsys_state *css;
 
 	/*
 	 * ctx->lock held by caller
@@ -682,8 +689,12 @@ perf_cgroup_set_timestamp(struct task_st
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
