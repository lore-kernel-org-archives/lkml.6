Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033356AbeE1KVi (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:21:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:40916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033296AbeE1KVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:21:23 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>,
        Shunyong Yang <shunyong.yang@hxt-semitech.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 164/268] cpufreq: CPPC: Initialize shared perf capabilities of CPUs
Date: Mon, 28 May 2018 12:02:18 +0200
Message-Id: <20180528100220.964360811@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100202.045206534@linuxfoundation.org>
References: <20180528100202.045206534@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shunyong Yang <shunyong.yang@hxt-semitech.com>

[ Upstream commit 8913315e9459b146e5888ab5138e10daa061b885 ]

When multiple CPUs are related in one cpufreq policy, the first online
CPU will be chosen by default to handle cpufreq operations. Let's take
cpu0 and cpu1 as an example.

When cpu0 is offline, policy->cpu will be shifted to cpu1. cpu1's perf
capabilities should be initialized. Otherwise, perf capabilities are 0s
and speed change can not take effect.

This patch copies perf capabilities of the first online CPU to other
shared CPUs when policy shared type is CPUFREQ_SHARED_TYPE_ANY.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Shunyong Yang <shunyong.yang@hxt-semitech.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/cpufreq/cppc_cpufreq.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -100,9 +100,19 @@ static int cppc_cpufreq_cpu_init(struct
 	policy->cpuinfo.max_freq = policy->max;
 	policy->shared_type = cpu->shared_type;
 
-	if (policy->shared_type == CPUFREQ_SHARED_TYPE_ANY)
+	if (policy->shared_type == CPUFREQ_SHARED_TYPE_ANY) {
+		int i;
+
 		cpumask_copy(policy->cpus, cpu->shared_cpu_map);
-	else if (policy->shared_type == CPUFREQ_SHARED_TYPE_ALL) {
+
+		for_each_cpu(i, policy->cpus) {
+			if (unlikely(i == policy->cpu))
+				continue;
+
+			memcpy(&all_cpu_data[i]->perf_caps, &cpu->perf_caps,
+			       sizeof(cpu->perf_caps));
+		}
+	} else if (policy->shared_type == CPUFREQ_SHARED_TYPE_ALL) {
 		/* Support only SW_ANY for now. */
 		pr_debug("Unsupported CPU co-ord type\n");
 		return -EFAULT;
