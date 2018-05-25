Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965687AbeEYJs0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 05:48:26 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39351 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965671AbeEYJsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 05:48:21 -0400
Date: Fri, 25 May 2018 02:47:54 -0700
From: tip-bot for Patrick Bellasi <tipbot@zytor.com>
Message-ID: <tip-8ecf04e11283a28ca88b8b8049ac93c3a99fcd2c@git.kernel.org>
Cc: joelaf@google.com, smuckle@google.com, juri.lelli@redhat.com,
        viresh.kumar@linaro.org, dietmar.eggemann@arm.com,
        peterz@infradead.org, rafael.j.wysocki@intel.com, tglx@linutronix.de,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        patrick.bellasi@arm.com, torvalds@linux-foundation.org,
        morten.rasmussen@arm.com, hpa@zytor.com, mingo@kernel.org
Reply-To: mingo@kernel.org, hpa@zytor.com, torvalds@linux-foundation.org,
        morten.rasmussen@arm.com, patrick.bellasi@arm.com,
        linux-kernel@vger.kernel.org, vincent.guittot@linaro.org,
        tglx@linutronix.de, rafael.j.wysocki@intel.com, peterz@infradead.org,
        dietmar.eggemann@arm.com, viresh.kumar@linaro.org, smuckle@google.com,
        juri.lelli@redhat.com, joelaf@google.com
In-Reply-To: <20180524141023.13765-2-patrick.bellasi@arm.com>
References: <20180524141023.13765-2-patrick.bellasi@arm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/cpufreq: Modify aggregate utilization to
 always include blocked FAIR utilization
Git-Commit-ID: 8ecf04e11283a28ca88b8b8049ac93c3a99fcd2c
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

Commit-ID:  8ecf04e11283a28ca88b8b8049ac93c3a99fcd2c
Gitweb:     https://git.kernel.org/tip/8ecf04e11283a28ca88b8b8049ac93c3a99fcd2c
Author:     Patrick Bellasi <patrick.bellasi@arm.com>
AuthorDate: Thu, 24 May 2018 15:10:22 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 25 May 2018 08:04:52 +0200

sched/cpufreq: Modify aggregate utilization to always include blocked FAIR utilization

Since the refactoring introduced by:

   commit 8f111bc357aa ("cpufreq/schedutil: Rewrite CPUFREQ_RT support")

we aggregate FAIR utilization only if this class has runnable tasks.

This was mainly due to avoid the risk to stay on an high frequency just
because of the blocked utilization of a CPU not being properly decayed
while the CPU was idle.

However, since:

   commit 31e77c93e432 ("sched/fair: Update blocked load when newly idle")

the FAIR blocked utilization is properly decayed also for IDLE CPUs.

This allows us to use the FAIR blocked utilization as a safe mechanism
to gracefully reduce the frequency only if no FAIR tasks show up on a
CPU for a reasonable period of time.

Moreover, we also reduce the frequency drops of CPUs running periodic
tasks which, depending on the task periodicity and the time required
for a frequency switch, was increasing the chances to introduce some
undesirable performance variations.

Reported-by: Vincent Guittot <vincent.guittot@linaro.org>
Tested-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Patrick Bellasi <patrick.bellasi@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Joel Fernandes <joelaf@google.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Morten Rasmussen <morten.rasmussen@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rafael J . Wysocki <rafael.j.wysocki@intel.com>
Cc: Steve Muckle <smuckle@google.com>
Link: http://lkml.kernel.org/r/20180524141023.13765-2-patrick.bellasi@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/cpufreq_schedutil.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index e13df951aca7..28592b62b1d5 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -183,22 +183,21 @@ static void sugov_get_util(struct sugov_cpu *sg_cpu)
 static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
 {
 	struct rq *rq = cpu_rq(sg_cpu->cpu);
-	unsigned long util;
 
-	if (rq->rt.rt_nr_running) {
-		util = sg_cpu->max;
-	} else {
-		util = sg_cpu->util_dl;
-		if (rq->cfs.h_nr_running)
-			util += sg_cpu->util_cfs;
-	}
+	if (rq->rt.rt_nr_running)
+		return sg_cpu->max;
 
 	/*
+	 * Utilization required by DEADLINE must always be granted while, for
+	 * FAIR, we use blocked utilization of IDLE CPUs as a mechanism to
+	 * gracefully reduce the frequency when no tasks show up for longer
+	 * periods of time.
+	 *
 	 * Ideally we would like to set util_dl as min/guaranteed freq and
 	 * util_cfs + util_dl as requested freq. However, cpufreq is not yet
 	 * ready for such an interface. So, we only do the latter for now.
 	 */
-	return min(util, sg_cpu->max);
+	return min(sg_cpu->max, (sg_cpu->util_dl + sg_cpu->util_cfs));
 }
 
 static void sugov_set_iowait_boost(struct sugov_cpu *sg_cpu, u64 time, unsigned int flags)
