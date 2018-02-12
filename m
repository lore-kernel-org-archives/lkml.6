Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932653AbeBLO7L (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 09:59:11 -0500
Received: from outbound-smtp01.blacknight.com ([81.17.249.7]:41585 "EHLO
        outbound-smtp01.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932398AbeBLO67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 09:58:59 -0500
From: Mel Gorman <mgorman@techsingularity.net>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Mike Galbraith <efault@gmx.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 4/4] sched/fair: Do not migrate due to a sync wakeup on exit
Date: Mon, 12 Feb 2018 14:58:57 +0000
Message-Id: <20180212145857.8056-5-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180212145857.8056-1-mgorman@techsingularity.net>
References: <20180212145857.8056-1-mgorman@techsingularity.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a task exits, it notifies the parent that it has exited. This is a sync
wakup and the exiting task may pull the parent towards the wakers CPU. For
even simple workloads like using a shell, it was observed that the shell
is pulled across nodes by exiting processes. This is daft as the parent
may be long-lived and properly placed. This patch special cases a sync
wakeup on exit to avoid pulling tasks across nodes. Testing on a range
of workloads and machines showed very little differences in performance
although there was a small 3% boost on some machines running a shellscript
intensive workload (git regression test suite).

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 kernel/sched/fair.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 28c8d9c91955..50442697b455 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5710,8 +5710,14 @@ wake_affine_idle(int this_cpu, int prev_cpu, int sync)
 	if (idle_cpu(this_cpu) && cpus_share_cache(this_cpu, prev_cpu))
 		return idle_cpu(prev_cpu) ? prev_cpu : this_cpu;
 
-	if (sync && cpu_rq(this_cpu)->nr_running == 1)
+	if (sync && cpu_rq(this_cpu)->nr_running == 1) {
+		/* Avoid tasks exiting pulling parents to new nodes */
+		if ((current->flags & PF_EXITING) &&
+		    !cpus_share_cache(this_cpu, prev_cpu))
+			return prev_cpu;
+
 		return this_cpu;
+	}
 
 	return nr_cpumask_bits;
 }
-- 
2.15.1
