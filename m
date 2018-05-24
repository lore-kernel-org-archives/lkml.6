Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964957AbeEXG7E (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 02:59:04 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:42508 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750766AbeEXG7B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 02:59:01 -0400
From: Kevin Wangtao <kevin.wangtao@hisilicon.com>
To: <rjw@rjwysocki.net>, <viresh.kumar@linaro.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <gengyanping@hisilicon.com>, <sunzhaosheng@hisilicon.com>,
        Kevin Wangtao <kevin.wangtao@hisilicon.com>
Subject: [PATCH] cpufreq: reinitialize new policy min/max when writing scaling_(max|min)_freq
Date: Thu, 24 May 2018 14:43:54 +0800
Message-ID: <1527144234-96396-1-git-send-email-kevin.wangtao@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.161.152]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

consider such situation, current user_policy.min is 1000000,
current user_policy.max is 1200000, in cpufreq_set_policy,
other driver may update policy.min to 1200000, policy.max to
1300000. After that, If we input "echo 1300000 > scaling_min_freq",
then user_policy.min will be 1300000, and user_policy.max is
still 1200000, because the input value is checked with policy.max
not user_policy.max. if we get all related cpus offline and
online again, it will cause cpufreq_init_policy fail because
user_policy.min is higher than user_policy.max.

The solution is when user space tries to write scaling_(max|min)_freq,
the min/max of new_policy should be reinitialized with min/max
of user_policy, like what cpufreq_update_policy does.

Signed-off-by: Kevin Wangtao <kevin.wangtao@hisilicon.com>
---
 drivers/cpufreq/cpufreq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index b79c532..8b33e08 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -697,6 +697,8 @@ static ssize_t store_##file_name					\
 	struct cpufreq_policy new_policy;				\
 									\
 	memcpy(&new_policy, policy, sizeof(*policy));			\
+	new_policy->min = policy->user_policy.min;			\
+	new_policy->max = policy->user_policy.max;			\
 									\
 	ret = sscanf(buf, "%u", &new_policy.object);			\
 	if (ret != 1)							\
-- 
2.8.1
