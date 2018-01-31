Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753221AbeAaIiQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 03:38:16 -0500
Received: from mail-ot0-f195.google.com ([74.125.82.195]:45811 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751966AbeAaIiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 03:38:14 -0500
X-Google-Smtp-Source: AH8x227HV7hcJePXJZh16UVQAmsAGwYmHSksvDF7rgkXk928lrGniYzf+RngGXkZfXJdOGKpEy/rLw==
From: linxiulei@gmail.com
To: peterz@infradead.org, jolsa@redhat.com, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, eranian@gmail.com,
        torvalds@linux-foundation.org, linux-perf-users@vger.kernel.org,
        brendan.d.gregg@gmail.com
Cc: yang_oliver@hotmail.com, jinli.zjl@alibaba-inc.com,
        "leilei.lin" <leilei.lin@alibaba-inc.com>
Subject: [PATCH RESEND v3] perf/core: Fix installing cgroup event into cpu
Date: Wed, 31 Jan 2018 16:35:27 +0800
Message-Id: <20180131083527.76989-1-linxiulei@gmail.com>
X-Mailer: git-send-email 2.16.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "leilei.lin" <leilei.lin@alibaba-inc.com>

Do not install cgroup event into the CPU context and schedule it
if the cgroup is not running on this CPU

While there is no task of cgroup running specified CPU, current
kernel still install cgroup event into CPU context that causes
another cgroup event can't be installed into this CPU.

This patch prevent scheduling events at __perf_install_in_context()
and installing events at list_update_cgroup_event() if cgroup isn't
running on specified CPU.

Signed-off-by: leilei.lin <leilei.lin@alibaba-inc.com>
---
 v2: Set cpuctx->cgrp only if the same cgroup is running on this
   CPU otherwise following events couldn't be activated immediately
 v3: Enhance the comments and commit message

 kernel/events/core.c | 49 ++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 36 insertions(+), 13 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 4df5b69..fb5b167 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -933,31 +933,41 @@ list_update_cgroup_event(struct perf_event *event,
 {
 	struct perf_cpu_context *cpuctx;
 	struct list_head *cpuctx_entry;
+	struct perf_cgroup *cgrp;
 
 	if (!is_cgroup_event(event))
 		return;
 
-	if (add && ctx->nr_cgroups++)
-		return;
-	else if (!add && --ctx->nr_cgroups)
-		return;
 	/*
 	 * Because cgroup events are always per-cpu events,
 	 * this will always be called from the right CPU.
 	 */
 	cpuctx = __get_cpu_context(ctx);
-	cpuctx_entry = &cpuctx->cgrp_cpuctx_entry;
-	/* cpuctx->cgrp is NULL unless a cgroup event is active in this CPU .*/
-	if (add) {
-		struct perf_cgroup *cgrp = perf_cgroup_from_task(current, ctx);
+	cgrp = perf_cgroup_from_task(current, ctx);
 
-		list_add(cpuctx_entry, this_cpu_ptr(&cgrp_cpuctx_list));
-		if (cgroup_is_descendant(cgrp->css.cgroup, event->cgrp->css.cgroup))
+	/*
+	 * if only the cgroup is running on this cpu,
+	 * we put/remove this cgroup into cpu context.
+	 * Or it would case mismatch in following cgroup
+	 * events at event_filter_match()
+	 */
+	if (cgroup_is_descendant(cgrp->css.cgroup, event->cgrp->css.cgroup)) {
+		if (add)
 			cpuctx->cgrp = cgrp;
-	} else {
-		list_del(cpuctx_entry);
-		cpuctx->cgrp = NULL;
+		else
+			cpuctx->cgrp = NULL;
 	}
+
+	if (add && ctx->nr_cgroups++)
+		return;
+	else if (!add && --ctx->nr_cgroups)
+		return;
+
+	cpuctx_entry = &cpuctx->cgrp_cpuctx_entry;
+	if (add)
+		list_add(cpuctx_entry, this_cpu_ptr(&cgrp_cpuctx_list));
+	else
+		list_del(cpuctx_entry);
 }
 
 #else /* !CONFIG_CGROUP_PERF */
@@ -2284,6 +2294,7 @@ static int  __perf_install_in_context(void *info)
 	struct perf_event_context *ctx = event->ctx;
 	struct perf_cpu_context *cpuctx = __get_cpu_context(ctx);
 	struct perf_event_context *task_ctx = cpuctx->task_ctx;
+	struct perf_cgroup *cgrp;
 	bool reprogram = true;
 	int ret = 0;
 
@@ -2311,6 +2322,18 @@ static int  __perf_install_in_context(void *info)
 		raw_spin_lock(&task_ctx->lock);
 	}
 
+	if (is_cgroup_event(event)) {
+		/*
+		 * Only care about cgroup events.
+		 *
+		 * If only the task belongs to cgroup of this event,
+		 * we will continue the installment
+		 */
+		cgrp = perf_cgroup_from_task(current, ctx);
+		reprogram = cgroup_is_descendant(cgrp->css.cgroup,
+					event->cgrp->css.cgroup);
+	}
+
 	if (reprogram) {
 		ctx_sched_out(ctx, cpuctx, EVENT_TIME);
 		add_event_to_ctx(event, ctx);
-- 
2.8.4.31.g9ed660f
