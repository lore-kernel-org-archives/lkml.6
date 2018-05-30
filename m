Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753484AbeE3Nqv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 09:46:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39520 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750757AbeE3Nqs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 09:46:48 -0400
From: Waiman Long <longman@redhat.com>
To: Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
Cc: cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kernel-team@fb.com, pjt@google.com,
        luto@amacapital.net, Mike Galbraith <efault@gmx.de>,
        torvalds@linux-foundation.org, Roman Gushchin <guro@fb.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH] cpuset: Enforce that a child's cpus must be a subset of the parent
Date: Wed, 30 May 2018 09:46:31 -0400
Message-Id: <1527687991-1431-1-git-send-email-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was found that the cpuset.cpus could contain CPUs that are not listed
in their parent's cpu list as shown by the command sequence below:

  # echo "+cpuset" >cgroup.subtree_control
  # mkdir g1
  # echo 0-5 >g1/cpuset.cpus
  # mkdir g1/g11
  # echo "+cpuset" > g1/cgroup.subtree_control
  # echo 6-11 >g1/g11/cpuset.cpus
  # grep -R . g1 | grep "\.cpus"
  g1/cpuset.cpus:0-5
  g1/cpuset.cpus.effective:0-5
  g1/g11/cpuset.cpus:6-11
  g1/g11/cpuset.cpus.effective:0-5

As the intersection of g11's cpus and that of g1 is empty, the effective
cpus of g11 is just that of g1. The check in update_cpumask() is now
corrected to make sure that cpus in a child cpus must be a subset of
its parent's cpus. The error "write error: Invalid argument" will now
be reported in the above case.

Reported-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 kernel/cgroup/cpuset.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 71fb2d0..ceec438 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -1185,12 +1185,17 @@ static int update_cpumask(struct cpuset *cs, struct cpuset *trialcs,
 	if (!*buf) {
 		cpumask_clear(trialcs->cpus_allowed);
 	} else {
+		struct cpuset *parent = parent_cs(cs);
+
 		retval = cpulist_parse(buf, trialcs->cpus_allowed);
 		if (retval < 0)
 			return retval;
 
+		/*
+		 * The cpu list must be a subset of the parent.
+		 */
 		if (!cpumask_subset(trialcs->cpus_allowed,
-				    top_cpuset.cpus_allowed))
+				    parent->cpus_allowed))
 			return -EINVAL;
 	}
 
-- 
1.8.3.1
