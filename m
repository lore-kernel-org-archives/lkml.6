Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752048AbeEDNzu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 09:55:50 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53680 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751573AbeEDNzr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 09:55:47 -0400
From: Mark Rutland <mark.rutland@arm.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org, aryabinin@virtuozzo.com, dvyukov@google.com,
        mark.rutland@arm.com, mingo@redhat.com, peterz@infradead.org
Subject: [PATCH 3/3] sched/core / kcov: avoid kcov_area during task switch
Date: Fri,  4 May 2018 14:55:35 +0100
Message-Id: <20180504135535.53744-4-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180504135535.53744-1-mark.rutland@arm.com>
References: <20180504135535.53744-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During a context switch, we first switch_mm() to the next task's mm,
then switch_to() that new task. This means that vmalloc'd regions which
had previously been faulted in can transiently disappear in the context
of the prev task.

Functions instrumented by KCOV may try to access a vmalloc'd kcov_area
during this window, and as the fault handling code is instrumented, this
results in a recursive fault.

We must avoid accessing any kcov_area during this window. We can do so
with a new flag in kcov_mode, set prior to switching the mm, and cleared
once the new task is live. Since task_struct::kcov_mode isn't always a
specific enum kcov_mode value, this is made an unsigned int.

The manipulation is hidden behind kcov_{prepare,finish}_switch()
helpers, which are empty for !CONFIG_KCOV kernels.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 include/linux/kcov.h  | 14 ++++++++++++++
 include/linux/sched.h |  2 +-
 kernel/kcov.c         |  2 +-
 kernel/sched/core.c   |  4 ++++
 4 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/include/linux/kcov.h b/include/linux/kcov.h
index 3ecf6f5e3a5f..b76a1807028d 100644
--- a/include/linux/kcov.h
+++ b/include/linux/kcov.h
@@ -22,13 +22,27 @@ enum kcov_mode {
 	KCOV_MODE_TRACE_CMP = 3,
 };
 
+#define KCOV_IN_CTXSW	(1 << 30)
+
 void kcov_task_init(struct task_struct *t);
 void kcov_task_exit(struct task_struct *t);
 
+#define kcov_prepare_switch(t)			\
+do {						\
+	(t)->kcov_mode |= KCOV_IN_CTXSW;	\
+} while (0)
+
+#define kcov_finish_switch(t)			\
+do {						\
+	(t)->kcov_mode &= ~KCOV_IN_CTXSW;	\
+} while (0)
+
 #else
 
 static inline void kcov_task_init(struct task_struct *t) {}
 static inline void kcov_task_exit(struct task_struct *t) {}
+static inline void kcov_prepare_switch(struct task_struct *t) {}
+static inline void kcov_finish_switch(struct task_struct *t) {}
 
 #endif /* CONFIG_KCOV */
 #endif /* _LINUX_KCOV_H */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index b3d697f3b573..3d9edcf57e21 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1078,7 +1078,7 @@ struct task_struct {
 
 #ifdef CONFIG_KCOV
 	/* Coverage collection mode enabled for this task (0 if disabled): */
-	enum kcov_mode			kcov_mode;
+	unsigned int			kcov_mode;
 
 	/* Size of the kcov_area: */
 	unsigned int			kcov_size;
diff --git a/kernel/kcov.c b/kernel/kcov.c
index 3b82f8e258da..f73ab8dc3ba7 100644
--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -58,7 +58,7 @@ struct kcov {
 
 static bool check_kcov_mode(enum kcov_mode needed_mode, struct task_struct *t)
 {
-	enum kcov_mode mode;
+	unsigned int mode;
 
 	/*
 	 * We are interested in code coverage as a function of a syscall inputs,
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5e10aaeebfcc..52078516803a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7,6 +7,8 @@
  */
 #include "sched.h"
 
+#include <linux/kcov.h>
+
 #include <asm/switch_to.h>
 #include <asm/tlb.h>
 
@@ -2632,6 +2634,7 @@ static inline void
 prepare_task_switch(struct rq *rq, struct task_struct *prev,
 		    struct task_struct *next)
 {
+	kcov_prepare_switch(prev);
 	sched_info_switch(rq, prev, next);
 	perf_event_task_sched_out(prev, next);
 	fire_sched_out_preempt_notifiers(prev, next);
@@ -2700,6 +2703,7 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 	finish_task(prev);
 	finish_lock_switch(rq);
 	finish_arch_post_lock_switch();
+	kcov_finish_switch(current);
 
 	fire_sched_in_preempt_notifiers(current);
 	/*
-- 
2.11.0
