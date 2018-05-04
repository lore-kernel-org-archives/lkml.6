Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752033AbeEDNzq (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 09:55:46 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:53656 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751573AbeEDNzn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 09:55:43 -0400
From: Mark Rutland <mark.rutland@arm.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org, aryabinin@virtuozzo.com, dvyukov@google.com,
        mark.rutland@arm.com, mingo@redhat.com, peterz@infradead.org
Subject: [PATCH 1/3] kcov: ensure irq code sees a valid area
Date: Fri,  4 May 2018 14:55:33 +0100
Message-Id: <20180504135535.53744-2-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180504135535.53744-1-mark.rutland@arm.com>
References: <20180504135535.53744-1-mark.rutland@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For kernels built with CONFIG_PREEMPT, some C code may execute before or
after the interrupt handler, while the hardirq count is zero. In these
cases, in_task() can return true.

A task can be interrupted in the middle of a KCOV_DISABLE ioctl while it
resets the task's kcov data via kcov_task_init(). Instrumented code
executed during this period will call __sanitizer_cov_trace_pc(), and as
in_task() returns true, will inspect t->kcov_mode before trying to write
to t->kcov_area.

In kcov_init_task() Since we update t->kcov_{mode,area,size} with plain
stores, which may be re-ordered, torn, etc. Thus
__sanitizer_cov_trace_pc() may see bogus values for any of these fields,
and may attempt to write to memory which is not mapped.

Let's avoid this by using WRITE_ONCE() to set t->kcov_mode, with a
barrier() to ensure this is ordered before we clear t->kov_{area,size}.
This ensures that any code execute while kcov_init_task() is preempted
will either see valid values for t->kcov_{area,size}, or will see that
t->kcov_mode is KCOV_MODE_DISABLED, and bail out without touching
t->kcov_area.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
---
 kernel/kcov.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/kcov.c b/kernel/kcov.c
index 2c16f1ab5e10..5be9a60a959f 100644
--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -241,7 +241,8 @@ static void kcov_put(struct kcov *kcov)
 
 void kcov_task_init(struct task_struct *t)
 {
-	t->kcov_mode = KCOV_MODE_DISABLED;
+	WRITE_ONCE(t->kcov_mode, KCOV_MODE_DISABLED);
+	barrier();
 	t->kcov_size = 0;
 	t->kcov_area = NULL;
 	t->kcov = NULL;
-- 
2.11.0
