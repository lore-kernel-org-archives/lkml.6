Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752852AbeE3LQv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:16:51 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60685 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751479AbeE3LHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:07:22 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Ingo Molnar" <mingo@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        "Peter Zijlstra" <a.p.zijlstra@chello.nl>,
        "Frederic Weisbecker" <fweisbec@gmail.com>,
        "K.Prasad" <Prasad.Krishnan@gmail.com>,
        "Edjunior Barbosa Machado" <emachado@linux.vnet.ibm.com>
Date: Wed, 30 May 2018 11:52:41 +0100
Message-ID: <lsq.1527677561.878002863@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 025/153] perf/hwpb: Invoke __perf_event_disable() if
 interrupts are already  disabled
In-Reply-To: <lsq.1527677560.486731940@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.2.102-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: "K.Prasad" <Prasad.Krishnan@gmail.com>

commit 500ad2d8b01390c98bc6dce068bccfa9534b8212 upstream.

While debugging a warning message on PowerPC while using hardware
breakpoints, it was discovered that when perf_event_disable is invoked
through hw_breakpoint_handler function with interrupts disabled, a
subsequent IPI in the code path would trigger a WARN_ON_ONCE message in
smp_call_function_single function.

This patch calls __perf_event_disable() when interrupts are already
disabled, instead of perf_event_disable().

Reported-by: Edjunior Barbosa Machado <emachado@linux.vnet.ibm.com>
Signed-off-by: K.Prasad <Prasad.Krishnan@gmail.com>
[naveen.n.rao@linux.vnet.ibm.com: v3: Check to make sure we target current task]
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Acked-by: Frederic Weisbecker <fweisbec@gmail.com>
Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Link: http://lkml.kernel.org/r/20120802081635.5811.17737.stgit@localhost.localdomain
[ Fixed build error on MIPS. ]
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 include/linux/perf_event.h    |  2 ++
 kernel/events/core.c          |  2 +-
 kernel/events/hw_breakpoint.c | 11 ++++++++++-
 3 files changed, 13 insertions(+), 2 deletions(-)

--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1140,6 +1140,7 @@ extern int perf_swevent_get_recursion_co
 extern void perf_swevent_put_recursion_context(int rctx);
 extern void perf_event_enable(struct perf_event *event);
 extern void perf_event_disable(struct perf_event *event);
+extern int __perf_event_disable(void *info);
 extern void perf_event_task_tick(void);
 #else
 static inline void
@@ -1178,6 +1179,7 @@ static inline int  perf_swevent_get_recu
 static inline void perf_swevent_put_recursion_context(int rctx)		{ }
 static inline void perf_event_enable(struct perf_event *event)		{ }
 static inline void perf_event_disable(struct perf_event *event)		{ }
+static inline int __perf_event_disable(void *info)			{ return -1; }
 static inline void perf_event_task_tick(void)				{ }
 #endif
 
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1344,7 +1344,7 @@ retry:
 /*
  * Cross CPU call to disable a performance event
  */
-static int __perf_event_disable(void *info)
+int __perf_event_disable(void *info)
 {
 	struct perf_event *event = info;
 	struct perf_event_context *ctx = event->ctx;
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -453,7 +453,16 @@ int modify_user_hw_breakpoint(struct per
 	int old_type = bp->attr.bp_type;
 	int err = 0;
 
-	perf_event_disable(bp);
+	/*
+	 * modify_user_hw_breakpoint can be invoked with IRQs disabled and hence it
+	 * will not be possible to raise IPIs that invoke __perf_event_disable.
+	 * So call the function directly after making sure we are targeting the
+	 * current task.
+	 */
+	if (irqs_disabled() && bp->ctx && bp->ctx->task == current)
+		__perf_event_disable(bp);
+	else
+		perf_event_disable(bp);
 
 	bp->attr.bp_addr = attr->bp_addr;
 	bp->attr.bp_type = attr->bp_type;
