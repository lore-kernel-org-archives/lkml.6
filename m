Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753059AbeEUMJ3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 08:09:29 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:38665 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751614AbeEUMJF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 08:09:05 -0400
From: Yisheng Xie <xieyisheng1@huawei.com>
To: <linux-kernel@vger.kernel.org>
CC: Yisheng Xie <xieyisheng1@huawei.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>, <linux-pm@vger.kernel.org>
Subject: [PATCH 15/33] cpufreq: intel_pstate: use match_string() helper
Date: Mon, 21 May 2018 19:57:52 +0800
Message-ID: <1526903890-35761-16-git-send-email-xieyisheng1@huawei.com>
X-Mailer: git-send-email 1.7.12.4
In-Reply-To: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com>
References: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

match_string() returns the index of an array for a matching string,
which can be used intead of open coded variant.

Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Len Brown <lenb@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
---
 drivers/cpufreq/intel_pstate.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 17e566af..d701e26 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -645,21 +645,18 @@ static ssize_t store_energy_performance_preference(
 {
 	struct cpudata *cpu_data = all_cpu_data[policy->cpu];
 	char str_preference[21];
-	int ret, i = 0;
+	int ret;
 
 	ret = sscanf(buf, "%20s", str_preference);
 	if (ret != 1)
 		return -EINVAL;
 
-	while (energy_perf_strings[i] != NULL) {
-		if (!strcmp(str_preference, energy_perf_strings[i])) {
-			intel_pstate_set_energy_pref_index(cpu_data, i);
-			return count;
-		}
-		++i;
-	}
+	ret = match_string(energy_perf_strings, -1, str_preference);
+	if (ret < 0)
+		return ret;
 
-	return -EINVAL;
+	intel_pstate_set_energy_pref_index(cpu_data, ret);
+	return count;
 }
 
 static ssize_t show_energy_performance_preference(
-- 
1.7.12.4
