Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965033AbeBMNhi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 08:37:38 -0500
Received: from outbound-smtp02.blacknight.com ([81.17.249.8]:43307 "EHLO
        outbound-smtp02.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S964846AbeBMNhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 08:37:32 -0500
From: Mel Gorman <mgorman@techsingularity.net>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>, Mike Galbraith <efault@gmx.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 4/6] sched/fair: Do not migrate due to a sync wakeup on exit
Date: Tue, 13 Feb 2018 13:37:28 +0000
Message-Id: <20180213133730.24064-5-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180213133730.24064-1-mgorman@techsingularity.net>
References: <20180213133730.24064-1-mgorman@techsingularity.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

When a task exits, it notifies the parent that it has exited. This is a
sync wakeup and the exiting task may pull the parent towards the wakers
CPU. For simple workloads like using a shell, it was observed that the
shell is pulled across nodes by exiting processes. This is daft as the
parent may be long-lived and properly placed. This patch special cases a
sync wakeup on exit to avoid pulling tasks across nodes. Testing on a range
of workloads and machines showed very little differences in performance
although there was a small 3% boost on some machines running a shellscript
intensive workload (git regression test suite).

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 28c8d9c91955..e5bbcbefd01b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6350,7 +6350,7 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int sd_flag, int wake_f
 	int cpu = smp_processor_id();
 	int new_cpu = prev_cpu;
 	int want_affine = 0;
-	int sync = wake_flags & WF_SYNC;
+	int sync = (wake_flags & WF_SYNC) && !(current->flags & PF_EXITING);
 
 	if (sd_flag & SD_BALANCE_WAKE) {
 		record_wakee(p);
-- 
2.15.1
