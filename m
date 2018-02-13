Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965868AbeBMUdK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 15:33:10 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:44530 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965789AbeBMUdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 15:33:06 -0500
X-Google-Smtp-Source: AH8x2265U4qR0VZWu00OX01Rb7BrFt2m/6/lvVK7GdMRnj15avbKNWeklJui2gVBNEtiuRngKdezlA==
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: peterz@infradead.org
Cc: lizefan@huawei.com, mingo@redhat.com, rostedt@goodmis.org,
        claudio@evidence.eu.com, bristot@redhat.com,
        tommaso.cucinotta@santannapisa.it, juri.lelli@redhat.com,
        luca.abeni@santannapisa.it, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 09/10] sched/core: Don't change the affinity of DL tasks
Date: Tue, 13 Feb 2018 13:32:46 -0700
Message-Id: <1518553967-20656-10-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518553967-20656-1-git-send-email-mathieu.poirier@linaro.org>
References: <1518553967-20656-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we mandate that on creation, the ->cpus_allowed mask of a future
DL task has to be equal to the rd->span of the root domain it will be
associated with, changing the affinity of a DL task doesn't make sense
anymore.

Indeed, if we set the task to a smaller affinity set then we may be running
out of CPU cycle.  If we try to increase the size of the affinity set the
new CPUs are necessarily part of another root domain where DL utilisation
for the task won't be accounted for.

As such simply refuse to change the affinity set of a DL task.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 kernel/sched/core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b930857f4d14..7a265478d873 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4773,15 +4773,15 @@ long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
 	cpumask_and(new_mask, in_mask, cpus_allowed);
 
 	/*
-	 * Since bandwidth control happens on root_domain basis,
-	 * if admission test is enabled, we only admit -deadline
-	 * tasks allowed to run on all the CPUs in the task's
-	 * root_domain.
+	 * Since bandwidth control happens on root_domain basis, if admission
+	 * test is enabled we don't allow the task' CPUs to change.  If
+	 * @new_mask is smaller than we risk running out of cycles.  If it is
+	 * bigger than we may be using DL bandwidth allocated to other CPUs.
 	 */
 #ifdef CONFIG_SMP
 	if (task_has_dl_policy(p) && dl_bandwidth_enabled()) {
 		rcu_read_lock();
-		if (!cpumask_subset(task_rq(p)->rd->span, new_mask)) {
+		if (!cpumask_equal(task_rq(p)->rd->span, new_mask)) {
 			retval = -EBUSY;
 			rcu_read_unlock();
 			goto out_free_new_mask;
-- 
2.7.4
