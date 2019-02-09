Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D91BC282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1765C20643
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549738654;
	bh=v+oN09DiSkrkOetMIaRkfaJZiztWiaCQFig0bpwppPg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=n4W38cYeo1W3hWh21GDKVOdTYsQ7LAFPJTjmz4Khw895sDFVkCfTUu/KP4TdKsngT
	 3Cj/hUSyK8JmgroUF3ocJljc+XiC9Ff29VnNP0xK0lQZdPuFJDyda4o7Inl1QayHqw
	 9hexEe9ooqwPIKLVhThY449yY0W07a7jSp6QVh0M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbfBIS5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 13:57:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:60350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727354AbfBISrq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 13:47:46 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7968A21929;
        Sat,  9 Feb 2019 18:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549738065;
        bh=v+oN09DiSkrkOetMIaRkfaJZiztWiaCQFig0bpwppPg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vDoVZl9U5E7srT0iHJCu47wu9lDRlHGjb59KjQIvuj8tQe5OR0mtklvMR7LdXsu5N
         o28eIQYA6uqjPUJX4cBHGYAU8ikz6GcgPuC7hmaD5LwhlgmM7uPHjtv5OdrWLcT9ZO
         UUtHNIgB5d17rfo7iNV1I0agzE+e0LIj0yHx3czM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 09/42] cpufreq: check if policy is inactive early in __cpufreq_get()
Date:   Sat,  9 Feb 2019 13:47:01 -0500
Message-Id: <20190209184734.125935-9-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190209184734.125935-1-sashal@kernel.org>
References: <20190209184734.125935-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sudeep Holla <sudeep.holla@arm.com>

[ Upstream commit 2f66196208c98b3d1b4294edffb2c5a8197be899 ]

cpuinfo_cur_freq gets current CPU frequency as detected by hardware
while scaling_cur_freq last known CPU frequency. Some platforms may not
allow checking the CPU frequency of an offline CPU or the associated
resources may have been released via cpufreq_exit when the CPU gets
offlined, in which case the policy would have been invalidated already.
If we attempt to get current frequency from the hardware, it may result
in hang or crash.

For example on Juno, I see:

Unable to handle kernel NULL pointer dereference at virtual address 0000000000000188
[0000000000000188] pgd=0000000000000000
Internal error: Oops: 96000004 [#1] PREEMPT SMP
Modules linked in:
CPU: 5 PID: 4202 Comm: cat Not tainted 4.20.0-08251-ga0f2c0318a15-dirty #87
Hardware name: ARM LTD ARM Juno Development Platform/ARM Juno Development Platform
pstate: 40000005 (nZcv daif -PAN -UAO)
pc : scmi_cpufreq_get_rate+0x34/0xb0
lr : scmi_cpufreq_get_rate+0x34/0xb0
Call trace:
 scmi_cpufreq_get_rate+0x34/0xb0
 __cpufreq_get+0x34/0xc0
 show_cpuinfo_cur_freq+0x24/0x78
 show+0x40/0x60
 sysfs_kf_seq_show+0xc0/0x148
 kernfs_seq_show+0x44/0x50
 seq_read+0xd4/0x480
 kernfs_fop_read+0x15c/0x208
 __vfs_read+0x60/0x188
 vfs_read+0x94/0x150
 ksys_read+0x6c/0xd8
 __arm64_sys_read+0x24/0x30
 el0_svc_common+0x78/0x100
 el0_svc_handler+0x38/0x78
 el0_svc+0x8/0xc
---[ end trace 3d1024e58f77f6b2 ]---

So fix the issue by checking if the policy is invalid early in
__cpufreq_get before attempting to get the current frequency.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpufreq/cpufreq.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 7aa3dcad2175..df34a12a388f 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1530,17 +1530,16 @@ static unsigned int __cpufreq_get(struct cpufreq_policy *policy)
 {
 	unsigned int ret_freq = 0;
 
-	if (!cpufreq_driver->get)
+	if (unlikely(policy_is_inactive(policy)) || !cpufreq_driver->get)
 		return ret_freq;
 
 	ret_freq = cpufreq_driver->get(policy->cpu);
 
 	/*
-	 * Updating inactive policies is invalid, so avoid doing that.  Also
-	 * if fast frequency switching is used with the given policy, the check
+	 * If fast frequency switching is used with the given policy, the check
 	 * against policy->cur is pointless, so skip it in that case too.
 	 */
-	if (unlikely(policy_is_inactive(policy)) || policy->fast_switch_enabled)
+	if (policy->fast_switch_enabled)
 		return ret_freq;
 
 	if (ret_freq && policy->cur &&
@@ -1569,10 +1568,7 @@ unsigned int cpufreq_get(unsigned int cpu)
 
 	if (policy) {
 		down_read(&policy->rwsem);
-
-		if (!policy_is_inactive(policy))
-			ret_freq = __cpufreq_get(policy);
-
+		ret_freq = __cpufreq_get(policy);
 		up_read(&policy->rwsem);
 
 		cpufreq_cpu_put(policy);
-- 
2.19.1

