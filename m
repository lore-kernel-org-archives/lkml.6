Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752896AbeBFMAx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 07:00:53 -0500
Received: from terminus.zytor.com ([65.50.211.136]:38859 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752246AbeBFMAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 07:00:44 -0500
Date: Tue, 6 Feb 2018 03:56:27 -0800
From: tip-bot for Mel Gorman <tipbot@zytor.com>
Message-ID: <tip-806486c377e33ab662de6d47902e9e2a32b79368@git.kernel.org>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        matt@codeblueprint.co.uk, peterz@infradead.org, efault@gmx.de,
        hpa@zytor.com, tglx@linutronix.de, mgorman@techsingularity.net,
        mingo@kernel.org
Reply-To: mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com, efault@gmx.de,
        mgorman@techsingularity.net, matt@codeblueprint.co.uk,
        peterz@infradead.org, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org
In-Reply-To: <20180130104555.4125-4-mgorman@techsingularity.net>
References: <20180130104555.4125-4-mgorman@techsingularity.net>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:sched/urgent] sched/fair: Do not migrate if the prev_cpu is
 idle
Git-Commit-ID: 806486c377e33ab662de6d47902e9e2a32b79368
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

Commit-ID:  806486c377e33ab662de6d47902e9e2a32b79368
Gitweb:     https://git.kernel.org/tip/806486c377e33ab662de6d47902e9e2a32b79368
Author:     Mel Gorman <mgorman@techsingularity.net>
AuthorDate: Tue, 30 Jan 2018 10:45:54 +0000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 6 Feb 2018 10:20:36 +0100

sched/fair: Do not migrate if the prev_cpu is idle

wake_affine_idle() prefers to move a task to the current CPU if the
wakeup is due to an interrupt. The expectation is that the interrupt
data is cache hot and relevant to the waking task as well as avoiding
a search. However, there is no way to determine if there was cache hot
data on the previous CPU that may exceed the interrupt data. Furthermore,
round-robin delivery of interrupts can migrate tasks around a socket where
each CPU is under-utilised.  This can interact badly with cpufreq which
makes decisions based on per-cpu data. It has been observed on machines
with HWP that p-states are not boosted to their maximum levels even though
the workload is latency and throughput sensitive.

This patch uses the previous CPU for the task if it's idle and cache-affine
with the current CPU even if the current CPU is idle due to the wakup
being related to the interrupt. This reduces migrations at the cost of
the interrupt data not being cache hot when the task wakes.

A variety of workloads were tested on various machines and no adverse
impact was noticed that was outside noise. dbench on ext4 on UMA showed
roughly 10% reduction in the number of CPU migrations and it is a case
where interrupts are frequent for IO competions. In most cases, the
difference in performance is quite small but variability is often
reduced. For example, this is the result for pgbench running on a UMA
machine with different numbers of clients.

                          4.15.0-rc9             4.15.0-rc9
                            baseline              waprev-v1
 Hmean     1     22096.28 (   0.00%)    22734.86 (   2.89%)
 Hmean     4     74633.42 (   0.00%)    75496.77 (   1.16%)
 Hmean     7    115017.50 (   0.00%)   113030.81 (  -1.73%)
 Hmean     12   126209.63 (   0.00%)   126613.40 (   0.32%)
 Hmean     16   131886.91 (   0.00%)   130844.35 (  -0.79%)
 Stddev    1       636.38 (   0.00%)      417.11 (  34.46%)
 Stddev    4       614.64 (   0.00%)      583.24 (   5.11%)
 Stddev    7       542.46 (   0.00%)      435.45 (  19.73%)
 Stddev    12      173.93 (   0.00%)      171.50 (   1.40%)
 Stddev    16      671.42 (   0.00%)      680.30 (  -1.32%)
 CoeffVar  1         2.88 (   0.00%)        1.83 (  36.26%)

Note that the different in performance is marginal but for low utilisation,
there is less variability.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Mike Galbraith <efault@gmx.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Link: http://lkml.kernel.org/r/20180130104555.4125-4-mgorman@techsingularity.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 4c400d7..db45b35 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5700,9 +5700,15 @@ wake_affine_idle(int this_cpu, int prev_cpu, int sync)
 	 * context. Only allow the move if cache is shared. Otherwise an
 	 * interrupt intensive workload could force all tasks onto one
 	 * node depending on the IO topology or IRQ affinity settings.
+	 *
+	 * If the prev_cpu is idle and cache affine then avoid a migration.
+	 * There is no guarantee that the cache hot data from an interrupt
+	 * is more important than cache hot data on the prev_cpu and from
+	 * a cpufreq perspective, it's better to have higher utilisation
+	 * on one CPU.
 	 */
 	if (idle_cpu(this_cpu) && cpus_share_cache(this_cpu, prev_cpu))
-		return this_cpu;
+		return idle_cpu(prev_cpu) ? prev_cpu : this_cpu;
 
 	if (sync && cpu_rq(this_cpu)->nr_running == 1)
 		return this_cpu;
