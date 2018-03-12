Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751660AbeCLOBQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 10:01:16 -0400
Received: from foss.arm.com ([217.140.101.70]:54396 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932279AbeCLOBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 10:01:13 -0400
From: Mark Rutland <mark.rutland@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Michal Hocko <mhocko@suse.com>, Peter Zijlstra <peterz@infradead.org>,
        Rik van Riel <riel@redhat.com>, Will Deacon <will.deacon@arm.com>
Subject: [PATCHv2] Detect early free of a live mm
Date: Mon, 12 Mar 2018 14:01:03 +0000
Message-Id: <20180312140103.19235-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KASAN splats indicate that in some cases we free a live mm, then
continue to access it, with potentially disastrous results. This is
likely due to a mismatched mmdrop() somewhere in the kernel, but so far
the culprit remains elusive.

Let's have __mmdrop() verify that the mm isn't live for the current
task, similar to the existing check for init_mm. This way, we can catch
this class of issue earlier, and without requiring KASAN.

Currently, idle_task_exit() leaves active_mm stale after it switches to
init_mm. This isn't harmful, but will trigger the new assertions, so we
must adjust idle_task_exit() to update active_mm.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rik van Riel <riel@redhat.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 kernel/fork.c       | 2 ++
 kernel/sched/core.c | 1 +
 2 files changed, 3 insertions(+)

Since v1 [1]:
* Use WARN_ON_ONCE()
* Avoid spurious warning in idle_task_exit()

Mark.

[1] https://lkml.kernel.org/r/20180228121458.2230-1-mark.rutland@arm.com

diff --git a/kernel/fork.c b/kernel/fork.c
index e5d9d405ae4e..ac94ce894219 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -595,6 +595,8 @@ static void check_mm(struct mm_struct *mm)
 void __mmdrop(struct mm_struct *mm)
 {
 	BUG_ON(mm == &init_mm);
+	WARN_ON_ONCE(mm == current->mm);
+	WARN_ON_ONCE(mm == current->active_mm);
 	mm_free_pgd(mm);
 	destroy_context(mm);
 	hmm_mm_destroy(mm);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e7c535eee0a6..0ef844abc2da 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5506,6 +5506,7 @@ void idle_task_exit(void)
 
 	if (mm != &init_mm) {
 		switch_mm(mm, &init_mm, current);
+		current->active_mm = &init_mm;
 		finish_arch_post_lock_switch();
 	}
 	mmdrop(mm);
-- 
2.11.0
