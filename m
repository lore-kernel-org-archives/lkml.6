Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752339AbeB1MPO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 07:15:14 -0500
Received: from foss.arm.com ([217.140.101.70]:48536 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752192AbeB1MPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 07:15:13 -0500
From: Mark Rutland <mark.rutland@arm.com>
To: linux-kernel@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Michal Hocko <mhocko@suse.com>, Peter Zijlstra <peterz@infraded.org>,
        Rik van Riel <riel@redhat.com>, Will Deacon <will.deacon@arm.com>
Subject: [PATCH] Detect early free of a live mm
Date: Wed, 28 Feb 2018 12:14:58 +0000
Message-Id: <20180228121458.2230-1-mark.rutland@arm.com>
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

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Peter Zijlstra <peterz@infraded.org>
Cc: Rik van Riel <riel@redhat.com>
Cc: Will Deacon <will.deacon@arm.com>
---
 kernel/fork.c | 2 ++
 1 file changed, 2 insertions(+)

Hi,

For context, we're seeing an intermittent use-after-free of an mm on
arm64 [1], where it looks like an mm has been freed earlier than
expected. So far KASAN has only caught legitimate mmdrop() uses, where
mm_count is presumably already bogus.

Mark.

[1] https://lkml.kernel.org/r/20180214120254.qq4w4s42ecxio7lu@lakrids.cambridge.arm.com

diff --git a/kernel/fork.c b/kernel/fork.c
index e5d9d405ae4e..6922d93551b8 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -595,6 +595,8 @@ static void check_mm(struct mm_struct *mm)
 void __mmdrop(struct mm_struct *mm)
 {
 	BUG_ON(mm == &init_mm);
+	BUG_ON(mm == current->mm);
+	BUG_ON(mm == current->active_mm);
 	mm_free_pgd(mm);
 	destroy_context(mm);
 	hmm_mm_destroy(mm);
-- 
2.11.0
