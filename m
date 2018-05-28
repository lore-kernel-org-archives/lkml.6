Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162785AbeE1KkT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:40:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:60204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1162749AbeE1KkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:40:10 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 310/329] cpufreq: Reorder cpufreq_online() error code path
Date: Mon, 28 May 2018 12:03:59 +0200
Message-Id: <20180528100306.854309941@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100241.796630982@linuxfoundation.org>
References: <20180528100241.796630982@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Viresh Kumar <viresh.kumar@linaro.org>

[ Upstream commit b24b6478e65f140610ab1ffaadc7bc6bf0be8aad ]

Ideally the de-allocation of resources should happen in the exact
opposite order in which they were allocated. It helps maintain the code
in long term, even if nothing really breaks with incorrect ordering.

That wasn't followed in cpufreq_online() and it has some
inconsistencies.  For example, the symlinks were created from within
the locked region while they are removed only after putting the locks.
Also ->exit() should have been called only after the symlinks are
removed and the lock is dropped, as that was the case when ->init()
was first called.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
[ rjw: Subject ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/cpufreq/cpufreq.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1288,14 +1288,14 @@ static int cpufreq_online(unsigned int c
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
 	cpufreq_policy_free(policy, !new_policy);
 	return ret;
