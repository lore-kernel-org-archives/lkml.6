Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753290AbeCFJjP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 04:39:15 -0500
Received: from mail-ot0-f193.google.com ([74.125.82.193]:39447 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750836AbeCFJjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 04:39:12 -0500
X-Google-Smtp-Source: AG47ELvnMW/ni3k+fTGUibSUuZPZaUewKniFOiNgQxKWGwwaaH41b5Qz3yTb30uki9jSEbAmNVhonQ==
From: linxiulei@gmail.com
To: peterz@infradead.org, jolsa@redhat.com, mingo@redhat.com,
        acme@kernel.org, alexander.shishkin@linux.intel.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, eranian@gmail.com,
        torvalds@linux-foundation.org, linux-perf-users@vger.kernel.org,
        brendan.d.gregg@gmail.com
Cc: yang_oliver@hotmail.com, "leilei.lin" <leilei.lin@alibaba-inc.com>
Subject: [PATCH RESEND v5] perf/core: Fix installing arbitrary cgroup event into cpu
Date: Tue,  6 Mar 2018 17:36:37 +0800
Message-Id: <20180306093637.28247-1-linxiulei@gmail.com>
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
 v4: Adjust to config
 v5: Clear cpuctx->cgrp only when no cgroup event exists

 kernel/events/core.c | 54 +++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 41 insertions(+), 13 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 4df5b69..f3ffa70 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -933,31 +933,45 @@ list_update_cgroup_event(struct perf_event *event,
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
+
+	/*
+	 * if only the cgroup is running on this cpu
+	 * and cpuctx->cgrp == NULL (otherwise it would've
+	 * been set with running cgroup), we put this cgroup
+	 * into cpu context. Or it would case mismatch in
+	 * following cgroup events at event_filter_match()
+	 */
+	if (add && !cpuctx->cgrp &&
+			cgroup_is_descendant(cgrp->css.cgroup,
+			event->cgrp->css.cgroup)) {
+		cpuctx->cgrp = cgrp;
+	}
+
+	if (add && ctx->nr_cgroups++)
+		return;
+	else if (!add && --ctx->nr_cgroups)
+		return;
 
+	/* no cgroup running */
+	if (!add)
+		cpuctx->cgrp = NULL;
+
+	cpuctx_entry = &cpuctx->cgrp_cpuctx_entry;
+	if (add)
 		list_add(cpuctx_entry, this_cpu_ptr(&cgrp_cpuctx_list));
-		if (cgroup_is_descendant(cgrp->css.cgroup, event->cgrp->css.cgroup))
-			cpuctx->cgrp = cgrp;
-	} else {
+	else
 		list_del(cpuctx_entry);
-		cpuctx->cgrp = NULL;
-	}
 }
 
 #else /* !CONFIG_CGROUP_PERF */
@@ -2311,6 +2325,20 @@ static int  __perf_install_in_context(void *info)
 		raw_spin_lock(&task_ctx->lock);
 	}
 
+#ifdef CONFIG_CGROUP_PERF
+	if (is_cgroup_event(event)) {
+		/*
+		 * Only care about cgroup events.
+		 *
+		 * If only the task belongs to cgroup of this event,
+		 * we will continue the installment
+		 */
+		struct perf_cgroup *cgrp = perf_cgroup_from_task(current, ctx);
+		reprogram = cgroup_is_descendant(cgrp->css.cgroup,
+					event->cgrp->css.cgroup);
+	}
+#endif
+
 	if (reprogram) {
 		ctx_sched_out(ctx, cpuctx, EVENT_TIME);
 		add_event_to_ctx(event, ctx);
-- 
2.8.4.31.g9ed660f
