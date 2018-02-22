Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752455AbeBVF77 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 00:59:59 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:35744 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750852AbeBVF75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 00:59:57 -0500
X-Google-Smtp-Source: AH8x226txm+ZklbH871icKinQLGeUjYRNlp9W2aD02VH/fyvrqKeglJ8wObxbMs8UuHyOPihJI3mDQ==
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] cpufreq: Reorder cpufreq_online() a bit
Date: Thu, 22 Feb 2018 11:29:43 +0530
Message-Id: <bd8c6133ad0bdd56c936802bcf26878d7cbdb679.1519279148.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.15.0.194.g9af6a3dea062
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ideally the de-allocation of resources should happen in the exact
opposite order in which they were allocated. It helps maintain the code
in long term, even if nothing really breaks with incorrect ordering.

The same wasn't followed in cpufreq_online() and it has some
inconsistencies. For example, the symlinks were created from within the
locked region while they are removed only after putting the locks. Also
->exit() should have been called only after the symlinks are removed and
the lock is dropped, as that was the case when ->init() was first
called.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index de33ebf008ad..8814c572e263 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1327,14 +1327,14 @@ static int cpufreq_online(unsigned int cpu)
 	return 0;
 
 out_exit_policy:
+	for_each_cpu(j, policy->real_cpus)
+		remove_cpu_dev_symlink(policy, get_cpu_device(j));
+
 	up_write(&policy->rwsem);
 
 	if (cpufreq_driver->exit)
 		cpufreq_driver->exit(policy);
 
-	for_each_cpu(j, policy->real_cpus)
-		remove_cpu_dev_symlink(policy, get_cpu_device(j));
-
 out_free_policy:
 	cpufreq_policy_free(policy);
 	return ret;
-- 
2.15.0.194.g9af6a3dea062
