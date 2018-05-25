Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965750AbeEYJtM (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 05:49:12 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51985 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965457AbeEYJs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 05:48:57 -0400
Date: Fri, 25 May 2018 02:48:26 -0700
From: tip-bot for Patrick Bellasi <tipbot@zytor.com>
Message-ID: <tip-2539fc82aa9b07d968cf9ba1ffeec3e0416ac721@git.kernel.org>
Cc: smuckle@google.com, viresh.kumar@linaro.org,
        linux-kernel@vger.kernel.org, rafael.j.wysocki@intel.com,
        joelaf@google.com, torvalds@linux-foundation.org,
        morten.rasmussen@arm.com, dietmar.eggemann@arm.com, mingo@kernel.org,
        tglx@linutronix.de, peterz@infradead.org, vincent.guittot@linaro.org,
        juri.lelli@redhat.com, patrick.bellasi@arm.com, hpa@zytor.com
Reply-To: dietmar.eggemann@arm.com, mingo@kernel.org, tglx@linutronix.de,
        peterz@infradead.org, morten.rasmussen@arm.com,
        patrick.bellasi@arm.com, vincent.guittot@linaro.org,
        juri.lelli@redhat.com, hpa@zytor.com, viresh.kumar@linaro.org,
        smuckle@google.com, torvalds@linux-foundation.org, joelaf@google.com,
        linux-kernel@vger.kernel.org, rafael.j.wysocki@intel.com
In-Reply-To: <20180524141023.13765-3-patrick.bellasi@arm.com>
References: <20180524141023.13765-3-patrick.bellasi@arm.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched/fair: Update util_est before updating
 schedutil
Git-Commit-ID: 2539fc82aa9b07d968cf9ba1ffeec3e0416ac721
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

Commit-ID:  2539fc82aa9b07d968cf9ba1ffeec3e0416ac721
Gitweb:     https://git.kernel.org/tip/2539fc82aa9b07d968cf9ba1ffeec3e0416ac721
Author:     Patrick Bellasi <patrick.bellasi@arm.com>
AuthorDate: Thu, 24 May 2018 15:10:23 +0100
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Fri, 25 May 2018 08:04:56 +0200

sched/fair: Update util_est before updating schedutil

When a task is enqueued the estimated utilization of a CPU is updated
to better support the selection of the required frequency.

However, schedutil is (implicitly) updated by update_load_avg() which
always happens before util_est_{en,de}queue(), thus potentially
introducing a latency between estimated utilization updates and
frequency selections.

Let's update util_est at the beginning of enqueue_task_fair(),
which will ensure that all schedutil updates will see the most
updated estimated utilization value for a CPU.

Reported-by: Vincent Guittot <vincent.guittot@linaro.org>
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
Fixes: 7f65ea42eb00 ("sched/fair: Add util_est on top of PELT")
Link: http://lkml.kernel.org/r/20180524141023.13765-3-patrick.bellasi@arm.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 748cb054fefd..e497c05aab7f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5385,6 +5385,14 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	struct cfs_rq *cfs_rq;
 	struct sched_entity *se = &p->se;
 
+	/*
+	 * The code below (indirectly) updates schedutil which looks at
+	 * the cfs_rq utilization to select a frequency.
+	 * Let's add the task's estimated utilization to the cfs_rq's
+	 * estimated utilization, before we update schedutil.
+	 */
+	util_est_enqueue(&rq->cfs, p);
+
 	/*
 	 * If in_iowait is set, the code below may not trigger any cpufreq
 	 * utilization updates, so do it here explicitly with the IOWAIT flag
@@ -5426,7 +5434,6 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	if (!se)
 		add_nr_running(rq, 1);
 
-	util_est_enqueue(&rq->cfs, p);
 	hrtick_update(rq);
 }
 
