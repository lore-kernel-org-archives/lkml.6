Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752105AbeC1JcS (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 05:32:18 -0400
Received: from mx01.hxt-semitech.com.96.203.223.in-addr.arpa ([223.203.96.7]:53472
        "EHLO barracuda.hxt-semitech.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751224AbeC1JcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 05:32:14 -0400
X-ASG-Debug-ID: 1522229525-093b7e08d8031b0001-xx1T2L
X-Barracuda-Envelope-From: shunyong.yang@hxt-semitech.com
From: Shunyong Yang <shunyong.yang@hxt-semitech.com>
To: <rjw@rjwysocki.net>
CC: <viresh.kumar@linaro.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Shunyong Yang <shunyong.yang@hxt-semitech.com>,
        Joey Zheng <yu.zheng@hxt-semitech.com>
Subject: [PATCH] cpufreq: cppc_cpufreq: Initialize shared cpu's perf capabilities
Date: Wed, 28 Mar 2018 17:31:54 +0800
X-ASG-Orig-Subj: [PATCH] cpufreq: cppc_cpufreq: Initialize shared cpu's perf capabilities
Message-ID: <1522229514-14377-1-git-send-email-shunyong.yang@hxt-semitech.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.5.21.109]
X-ClientProxiedBy: HXTBJIDCEMVIW02.hxtcorp.net (10.128.0.15) To
 HXTBJIDCEMVIW02.hxtcorp.net (10.128.0.15)
X-Barracuda-Connect: UNKNOWN[10.128.0.15]
X-Barracuda-Start-Time: 1522229526
X-Barracuda-Encrypted: ECDHE-RSA-AES256-SHA
X-Barracuda-URL: https://192.168.50.101:443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.6814 1.0000 1.2321
X-Barracuda-Spam-Score: 1.23
X-Barracuda-Spam-Status: No, SCORE=1.23 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.49375
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When multiple cpus are related in one cpufreq policy, the first online
cpu will be chosen by default to handle cpufreq operations. Let's take
cpu0 and cpu1 as an example.

When cpu0 is offline, policy->cpu will be shifted to cpu1. Cpu1's should
be initialized. Otherwise, perf capabilities are 0s and speed change can
not take effect.

This patch copies perf capabilities of the first online cpu to other
shared cpus when policy shared type is CPUFREQ_SHARED_TYPE_ANY.

Cc: Joey Zheng <yu.zheng@hxt-semitech.com>
Signed-off-by: Shunyong Yang <shunyong.yang@hxt-semitech.com>
---

The original RFC link,
  https://patchwork.kernel.org/patch/10299055/.

This patch solves same issue as RFC above.

Patch name is changed as code is too much different with RFC above.

Remove extra init() per Viresh Kumar's comments and only handle
CPPC CPUFREQ_SHARED_TYPE_ANY case.

---
 drivers/cpufreq/cppc_cpufreq.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 8f7b21a4d537..dc625a93a58e 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -164,8 +164,18 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	policy->cpuinfo.transition_latency = cppc_get_transition_latency(cpu_num);
 	policy->shared_type = cpu->shared_type;
 
-	if (policy->shared_type == CPUFREQ_SHARED_TYPE_ANY)
+	if (policy->shared_type == CPUFREQ_SHARED_TYPE_ANY) {
+		int i;
+
 		cpumask_copy(policy->cpus, cpu->shared_cpu_map);
+
+		for_each_cpu(i, policy->cpus) {
+			if (i != policy->cpu)
+				memcpy(&all_cpu_data[i]->perf_caps,
+				       &cpu->perf_caps,
+				       sizeof(cpu->perf_caps));
+		}
+	}
 	else if (policy->shared_type == CPUFREQ_SHARED_TYPE_ALL) {
 		/* Support only SW_ANY for now. */
 		pr_debug("Unsupported CPU co-ord type\n");
-- 
1.8.3.1
