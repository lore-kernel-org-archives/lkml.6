Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752832AbeBAQv2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 11:51:28 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:53485 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752782AbeBAQvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 11:51:20 -0500
X-Google-Smtp-Source: AH8x227m5cpMaETYOSE83tsfnHKp3ZS6+sEq2nB0R8RB+20xoW5uVUAtPDG5oyLWh6T6e8EDAS1F8A==
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: peterz@infradead.org
Cc: lizefan@huawei.com, mingo@redhat.com, rostedt@goodmis.org,
        claudio@evidence.eu.com, bristot@redhat.com,
        tommaso.cucinotta@santannapisa.it, juri.lelli@redhat.com,
        luca.abeni@santannapisa.it, linux-kernel@vger.kernel.org
Subject: [PATCH V2 4/7] cgroup: Constrain 'sched_load_balance' flag when DL tasks are present
Date: Thu,  1 Feb 2018 09:51:06 -0700
Message-Id: <1517503869-3179-5-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517503869-3179-1-git-send-email-mathieu.poirier@linaro.org>
References: <1517503869-3179-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch prevents the 'sched_load_balance' flag from being set to 0
when DL tasks are present in a CPUset.  Otherwise we end up with the
DL tasks using CPUs belonging to different root domains, something that
breaks the mathematical model behind DL bandwidth management.

For example on a 4 core system CPUset "set1" has been created and CPUs
0 and 1 assigned to it.  A DL task has also been spun off.  By default
the DL task can use all the CPUs in the default CPUset.

If we set the base CPUset's cpuset.sched_load_balance to 0, CPU 0 and 1
are added to a newly created root domain while CPU 2 and 3 endup in the
default root domain.  But the DL task is still part of the base CPUset and
as such can use CPUs 0 to 3, spanning at the same time more than one root
domain.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 kernel/cgroup/cpuset.c | 104 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 6942c4652f31..daa1b2bc7e11 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -458,6 +458,106 @@ static void free_trial_cpuset(struct cpuset *trial)
 	kfree(trial);
 }
 
+static bool cpuset_has_dl_tasks(struct cpuset *cs)
+{
+	bool dl_tasks = false;
+	struct css_task_iter it;
+	struct task_struct *task;
+
+	/* Go through each task in @cs looking for a DL task */
+	css_task_iter_start(&cs->css, 0, &it);
+
+	while (!dl_tasks && (task = css_task_iter_next(&it))) {
+		if (dl_task(task))
+			dl_tasks = true;
+	}
+
+	css_task_iter_end(&it);
+
+	return dl_tasks;
+}
+
+/*
+ * Assumes RCU read lock and cpuset_mutex are held.
+ */
+static int
+validate_change_load_balance(struct cpuset *cur, struct cpuset *trial)
+{
+	bool populated = false, dl_tasks = false;
+	int ret = -EBUSY;
+	struct cgroup_subsys_state *pos_css;
+	struct cpuset *cs;
+
+	 /* Bail out if nothing has changed. */
+	if (is_sched_load_balance(cur) ==
+	    is_sched_load_balance(trial)) {
+		ret = 0;
+		goto out;
+	}
+
+	/*
+	 * First deal with the generic case that applies when
+	 * cpuset.sched_load_balance gets flipped on a cpuset,
+	 * regardless of the value.
+	 */
+	cpuset_for_each_descendant_pre(cs, pos_css, cur) {
+		if (cpuset_has_dl_tasks(cs))
+			dl_tasks = true;
+
+		/* Skip the top cpuset since it obviously exists */
+		if (cs == cur)
+			continue;
+
+		/* Children without CPUs are not important */
+		if (cpumask_empty(cs->cpus_allowed)) {
+			pos_css = css_rightmost_descendant(pos_css);
+			continue;
+		}
+
+		/* CPUs have been assigned to this cpuset. */
+		populated = true;
+
+		/*
+		 * Go no further if both conditions are true so that we
+		 * don't end up in a situation where a DL task is
+		 * spanning more than one root domain or only assigned
+		 * to a subset of the CPUs in a root domain.
+		 */
+		if (populated && dl_tasks)
+			goto out;
+	}
+
+	/*
+	 * Things get very complicated when dealing with children cpuset,
+	 * resulting in hard to maintain code and low confidence that
+	 * all cases are handled properly.  As such prevent the
+	 * cpuset.sched_load_balance from being modified on children cpuset
+	 * where DL tasks have been assigned (or any of its children).
+	 */
+	if (dl_tasks && parent_cs(cur))
+		goto out;
+
+	ret = 0;
+out:
+	return ret;
+}
+
+/*
+ * Assumes RCU read lock and cpuset_mutex are held.
+ */
+static int
+validate_dl_change(struct cpuset *cur, struct cpuset *trial)
+{
+	int ret = 0;
+
+	/* Check if the sched_load_balance flag has been changed */
+	ret = validate_change_load_balance(cur, trial);
+	if (ret)
+		return ret;
+
+	return ret;
+}
+
 /*
  * validate_change() - Used to validate that any proposed cpuset change
  *		       follows the structural rules for cpusets.
@@ -492,6 +592,10 @@ static int validate_change(struct cpuset *cur, struct cpuset *trial)
 		if (!is_cpuset_subset(c, trial))
 			goto out;
 
+	/* Make sure changes are compatible with deadline scheduling class */
+	if (validate_dl_change(cur, trial))
+		goto out;
+
 	/* Remaining checks don't apply to root cpuset */
 	ret = 0;
 	if (cur == &top_cpuset)
-- 
2.7.4
