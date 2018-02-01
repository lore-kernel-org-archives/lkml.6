Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752913AbeBAQwj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 11:52:39 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:33709 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752789AbeBAQvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 11:51:21 -0500
X-Google-Smtp-Source: AH8x227Jjz0LBwmTRiyrvwFPGSAXRX+DZLtxyUsBx/1FlnvNqYMWe2UYSx4ziDet7RhLUoEJUj1xpQ==
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: peterz@infradead.org
Cc: lizefan@huawei.com, mingo@redhat.com, rostedt@goodmis.org,
        claudio@evidence.eu.com, bristot@redhat.com,
        tommaso.cucinotta@santannapisa.it, juri.lelli@redhat.com,
        luca.abeni@santannapisa.it, linux-kernel@vger.kernel.org
Subject: [PATCH V2 5/7] cgroup: Constrain the addition of CPUs to a new CPUset
Date: Thu,  1 Feb 2018 09:51:07 -0700
Message-Id: <1517503869-3179-6-git-send-email-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517503869-3179-1-git-send-email-mathieu.poirier@linaro.org>
References: <1517503869-3179-1-git-send-email-mathieu.poirier@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Care must be taken when CPUs are added to a new CPUset.  If an ancestor
of that set has its sched_load_balance flag switch off then the CPUs in
the new CPUset will be added to a new root domain.  If the ancestor also
had DL tasks those will end up covering more than one root domain,
breaking at the same time the DL integrity model.

This patch prevents adding CPUs to a new CPUset if one of its ancestor
had its sched_load_balance flag off and had DL tasks assigned to it.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 kernel/cgroup/cpuset.c | 44 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index daa1b2bc7e11..6ae4ad995e9e 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -481,6 +481,43 @@ static bool cpuset_has_dl_tasks(struct cpuset *cs)
  * Assumes RCU read lock and cpuset_mutex are held.
  */
 static int
+validate_change_cpus(struct cpuset *cur, struct cpuset *trial)
+{
+	int ret = 0;
+
+	/*
+	 * CPUs are being added to a CPUset.  If any parent of @trial has its
+	 * sched_load_balance flag switched off this operation will create a
+	 * new root domain spanning trial->cpus_allowed. At the same time
+	 * if any parent of @trial has a DL task, that task will end up
+	 * spanning more than one root domain and break the deadline integrity
+	 * model.
+	 */
+	if (cpumask_weight(cur->cpus_allowed) <
+	    cpumask_weight(trial->cpus_allowed)) {
+		struct cpuset *parent;
+
+		parent = parent_cs(trial);
+		/* Go up until we reach the top_cpuset */
+		while (parent) {
+			if (cpuset_has_dl_tasks(parent) &&
+			    !is_sched_load_balance(parent)) {
+				ret = -EBUSY;
+				goto out;
+			}
+
+			parent = parent_cs(parent);
+		}
+	}
+
+out:
+	return ret;
+}
+
+/*
+ * Assumes RCU read lock and cpuset_mutex are held.
+ */
+static int
 validate_change_load_balance(struct cpuset *cur, struct cpuset *trial)
 {
 	bool populated = false, dl_tasks = false;
@@ -553,8 +590,13 @@ validate_dl_change(struct cpuset *cur, struct cpuset *trial)
 	/* Check if the sched_load_balance flag has been changed */
 	ret = validate_change_load_balance(cur, trial);
 	if (ret)
-		return ret;
+		goto out;
 
+	ret = validate_change_cpus(cur, trial);
+	if (ret)
+		goto out;
+
+out:
 	return ret;
 }
 
-- 
2.7.4
