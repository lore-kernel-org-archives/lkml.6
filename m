Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932681AbeCLRrj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 13:47:39 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53651 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932231AbeCLRrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 13:47:37 -0400
Date: Mon, 12 Mar 2018 10:47:08 -0700
From: "tip-bot for leilei.lin" <tipbot@zytor.com>
Message-ID: <tip-33801b94741d6c3be9713c10aa627477216c21e2@git.kernel.org>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        alexander.shishkin@linux.intel.com, mingo@kernel.org, hpa@zytor.com,
        leilei.lin@alibaba-inc.com, acme@redhat.com, peterz@infradead.org,
        vincent.weaver@maine.edu, jolsa@redhat.com, tglx@linutronix.de,
        eranian@google.com
Reply-To: alexander.shishkin@linux.intel.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com, mingo@kernel.org,
        jolsa@redhat.com, peterz@infradead.org, vincent.weaver@maine.edu,
        leilei.lin@alibaba-inc.com, acme@redhat.com, eranian@google.com,
        tglx@linutronix.de
In-Reply-To: <20180306093637.28247-1-linxiulei@gmail.com>
References: <20180306093637.28247-1-linxiulei@gmail.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf/core: Fix installing cgroup events on CPU
Git-Commit-ID: 33801b94741d6c3be9713c10aa627477216c21e2
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

Commit-ID:  33801b94741d6c3be9713c10aa627477216c21e2
Gitweb:     https://git.kernel.org/tip/33801b94741d6c3be9713c10aa627477216c21e2
Author:     leilei.lin <leilei.lin@alibaba-inc.com>
AuthorDate: Tue, 6 Mar 2018 17:36:37 +0800
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 12 Mar 2018 15:28:51 +0100

perf/core: Fix installing cgroup events on CPU

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
---
 kernel/events/core.c | 46 +++++++++++++++++++++++++++++++++++-----------
 1 file changed, 35 insertions(+), 11 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index f98c0f88cc94..969f865f9f1c 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -937,27 +937,39 @@ list_update_cgroup_event(struct perf_event *event,
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
@@ -2489,6 +2501,18 @@ static int  __perf_install_in_context(void *info)
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
