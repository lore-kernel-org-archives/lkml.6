Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1424217AbeE1LMy (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:12:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:60376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423949AbeE1LMl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:12:41 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "leilei.lin" <leilei.lin@alibaba-inc.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vince Weaver <vincent.weaver@maine.edu>, brendan.d.gregg@gmail.com,
        eranian@gmail.com, yang_oliver@hotmail.com,
        Ingo Molnar <mingo@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 183/272] perf/core: Fix installing cgroup events on CPU
Date: Mon, 28 May 2018 12:03:36 +0200
Message-Id: <20180528100256.049554911@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100240.256525891@linuxfoundation.org>
References: <20180528100240.256525891@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: "leilei.lin" <leilei.lin@alibaba-inc.com>

[ Upstream commit 33801b94741d6c3be9713c10aa627477216c21e2 ]

There's two problems when installing cgroup events on CPUs: firstly
list_update_cgroup_event() only tries to set cpuctx->cgrp for the
first event, if that mismatches on @cgrp we'll not try again for later
additions.

Secondly, when we install a cgroup event into an active context, only
issue an event reprogram when the event matches the current cgroup
context. This avoids a pointless event reprogramming.

Signed-off-by: leilei.lin <leilei.lin@alibaba-inc.com>
[ Improved the changelog and comments. ]
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Cc: brendan.d.gregg@gmail.com
Cc: eranian@gmail.com
Cc: linux-kernel@vger.kernel.org
Cc: yang_oliver@hotmail.com
Link: http://lkml.kernel.org/r/20180306093637.28247-1-linxiulei@gmail.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/events/core.c |   46 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 35 insertions(+), 11 deletions(-)

--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -948,27 +948,39 @@ list_update_cgroup_event(struct perf_eve
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
+
+	/*
+	 * Since setting cpuctx->cgrp is conditional on the current @cgrp
+	 * matching the event's cgroup, we must do this for every new event,
+	 * because if the first would mismatch, the second would not try again
+	 * and we would leave cpuctx->cgrp unset.
+	 */
+	if (add && !cpuctx->cgrp) {
 		struct perf_cgroup *cgrp = perf_cgroup_from_task(current, ctx);
 
-		list_add(cpuctx_entry, this_cpu_ptr(&cgrp_cpuctx_list));
 		if (cgroup_is_descendant(cgrp->css.cgroup, event->cgrp->css.cgroup))
 			cpuctx->cgrp = cgrp;
-	} else {
-		list_del(cpuctx_entry);
-		cpuctx->cgrp = NULL;
 	}
+
+	if (add && ctx->nr_cgroups++)
+		return;
+	else if (!add && --ctx->nr_cgroups)
+		return;
+
+	/* no cgroup running */
+	if (!add)
+		cpuctx->cgrp = NULL;
+
+	cpuctx_entry = &cpuctx->cgrp_cpuctx_entry;
+	if (add)
+		list_add(cpuctx_entry, this_cpu_ptr(&cgrp_cpuctx_list));
+	else
+		list_del(cpuctx_entry);
 }
 
 #else /* !CONFIG_CGROUP_PERF */
@@ -2328,6 +2340,18 @@ static int  __perf_install_in_context(vo
 		raw_spin_lock(&task_ctx->lock);
 	}
 
+#ifdef CONFIG_CGROUP_PERF
+	if (is_cgroup_event(event)) {
+		/*
+		 * If the current cgroup doesn't match the event's
+		 * cgroup, we should not try to schedule it.
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
