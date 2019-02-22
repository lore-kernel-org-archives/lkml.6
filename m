Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A48C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 10:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F69E206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 10:39:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbfBVKjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 05:39:51 -0500
Received: from sci-ig2.spreadtrum.com ([222.66.158.135]:31988 "EHLO
        SHSQR01.spreadtrum.com" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbfBVKjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 05:39:51 -0500
Received: from ig2.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
        by SHSQR01.spreadtrum.com with ESMTPS id x1MAbiPf021828
        (version=TLSv1 cipher=AES256-SHA bits=256 verify=NO);
        Fri, 22 Feb 2019 18:37:45 +0800 (CST)
        (envelope-from Chunyan.Zhang@unisoc.com)
Received: from localhost (10.0.93.106) by BJMBX02.spreadtrum.com (10.0.64.8)
 with Microsoft SMTP Server (TLS) id 15.0.847.32; Fri, 22 Feb 2019 18:38:26
 +0800
From:   Chunyan Zhang <chunyan.zhang@unisoc.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
CC:     Vincent Wang <vincent.wang@unisoc.com>,
        Quentin Perret <quentin.perret@arm.com>,
        <linux-kernel@vger.kernel.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [PATCH V4] sched/cpufreq: initialize iowait_boost_max and iowait_boost with cpu capacity
Date:   Fri, 22 Feb 2019 18:37:46 +0800
Message-ID: <1550831866-32749-1-git-send-email-chunyan.zhang@unisoc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.93.106]
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL: SHSQR01.spreadtrum.com x1MAbiPf021828
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Wang <vincent.wang@unisoc.com>

When a task that is in_iowait state is enqueued, cpufreq_update_util()
will be invoked with SCHED_CPUFREQ_IOWAIT flag. In this case,the value
of util and cap, which are parameters used in map_util_freq(), may be
cpu frequency, instead of cpu util and capactiy.

For some 32bit architectures, the size of unsigned long is 32. When
calculating freq, there may be an overflow error in this expression:

freq = (freq + (freq >> 2)) * util / cap;

To fix the issus, a new member min is added into the struct sg_cpu to
store the capacity of policy's min frequency. iowait_boost and
iowait_boost_max will be initialized with capacity instead of frequency.

Signed-off-by: Vincent Wang <vincent.wang@unisoc.com>
Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
---
Changes from V3 (https://lkml.org/lkml/2019/1/29/346):
* Switch to a new method that will not lead in more calculation.

Changes from v2 (https://lkml.org/lkml/2019/1/9/1227):
* Fix for 32bit architectures only.

Changes from V1 (https://lkml.org/lkml/2018/12/24/22):
* Rebased onto v5.0-rc1;
* Addressed comments from Quentin Perret.

---
 kernel/sched/cpufreq_schedutil.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 033ec7c45f13..04eb44a9b550 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -53,6 +53,7 @@ struct sugov_cpu {
 
 	unsigned long		bw_dl;
 	unsigned long		max;
+	unsigned long		min;
 
 	/* The field below is for single-CPU policies only: */
 #ifdef CONFIG_NO_HZ_COMMON
@@ -275,12 +276,11 @@ static unsigned long sugov_get_util(struct sugov_cpu *sg_cpu)
 {
 	struct rq *rq = cpu_rq(sg_cpu->cpu);
 	unsigned long util = cpu_util_cfs(rq);
-	unsigned long max = arch_scale_cpu_capacity(NULL, sg_cpu->cpu);
 
-	sg_cpu->max = max;
 	sg_cpu->bw_dl = cpu_bw_dl(rq);
 
-	return schedutil_freq_util(sg_cpu->cpu, util, max, FREQUENCY_UTIL);
+	return schedutil_freq_util(sg_cpu->cpu, util, sg_cpu->max,
+				   FREQUENCY_UTIL);
 }
 
 /**
@@ -304,7 +304,7 @@ static bool sugov_iowait_reset(struct sugov_cpu *sg_cpu, u64 time,
 		return false;
 
 	sg_cpu->iowait_boost = set_iowait_boost
-		? sg_cpu->sg_policy->policy->min : 0;
+		? sg_cpu->min : 0;
 	sg_cpu->iowait_boost_pending = set_iowait_boost;
 
 	return true;
@@ -351,7 +351,7 @@ static void sugov_iowait_boost(struct sugov_cpu *sg_cpu, u64 time,
 	}
 
 	/* First wakeup after IO: start with minimum boost */
-	sg_cpu->iowait_boost = sg_cpu->sg_policy->policy->min;
+	sg_cpu->iowait_boost = sg_cpu->min;
 }
 
 /**
@@ -398,7 +398,7 @@ static void sugov_iowait_apply(struct sugov_cpu *sg_cpu, u64 time,
 		 * reach the minimum.
 		 */
 		sg_cpu->iowait_boost >>= 1;
-		if (sg_cpu->iowait_boost < sg_cpu->sg_policy->policy->min) {
+		if (sg_cpu->iowait_boost < sg_cpu->min) {
 			sg_cpu->iowait_boost = 0;
 			return;
 		}
@@ -823,6 +823,8 @@ static int sugov_start(struct cpufreq_policy *policy)
 {
 	struct sugov_policy *sg_policy = policy->governor_data;
 	unsigned int cpu;
+	unsigned long max_cap = arch_scale_cpu_capacity(NULL, policy->cpu);
+	unsigned long min_cap = max_cap * policy->min / policy->cpuinfo.max_freq;
 
 	sg_policy->freq_update_delay_ns	= sg_policy->tunables->rate_limit_us * NSEC_PER_USEC;
 	sg_policy->last_freq_update_time	= 0;
@@ -837,7 +839,9 @@ static int sugov_start(struct cpufreq_policy *policy)
 		memset(sg_cpu, 0, sizeof(*sg_cpu));
 		sg_cpu->cpu			= cpu;
 		sg_cpu->sg_policy		= sg_policy;
-		sg_cpu->iowait_boost_max	= policy->cpuinfo.max_freq;
+		sg_cpu->max			= max_cap;
+		sg_cpu->min			= min_cap;
+		sg_cpu->iowait_boost_max	= max_cap;
 	}
 
 	for_each_cpu(cpu, policy->cpus) {
-- 
2.17.1

