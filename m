Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58479C282C4
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2679B21A49
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 18:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549738299;
	bh=xI23ZscH4rvYNVKWdifupQzPBUXWKI8Ygz1ABjPk40g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rugJXXuNhDQhf4qJS0V9dOOtNLMCOBxuTY7JSTrk/AjU/ZlxtqmtS0SfGYRxFKEjy
	 EtABFRdkdAEfUyVe+EA7N/b37L4k7/GvFIX+U5eI8YZtOZXxSbQKkpkJlrhx4jOyCr
	 xvKApe/wJx37nDTOeVnWtVxolUKXM1+sDK2AOwtU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbfBISt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Feb 2019 13:49:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:36028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726977AbfBISt4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Feb 2019 13:49:56 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 883E72192C;
        Sat,  9 Feb 2019 18:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549738195;
        bh=xI23ZscH4rvYNVKWdifupQzPBUXWKI8Ygz1ABjPk40g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZX5AEYHfFGenAjLyl2NzCKvvbYHCTHWwzX+pU0w/QFvXisDqSqd5tIGGjD+nWHRhx
         xQol5REDThi8R3L8U6YTl9/tx8+5znny85i6dIR+KIxY1Ky6/ZS8FXKQ/zNTd9+RY/
         6Ep3etJn7EQcJXAtQp+eM/LLmrvlVq4xuSHiAgqM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 02/12] cpufreq: check if policy is inactive early in __cpufreq_get()
Date:   Sat,  9 Feb 2019 13:49:42 -0500
Message-Id: <20190209184952.127009-2-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190209184952.127009-1-sashal@kernel.org>
References: <20190209184952.127009-1-sashal@kernel.org>
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
 drivers/cpufreq/cpufreq.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index d6d91e8afa9e..61fe4bbc6dc0 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1496,17 +1496,16 @@ static unsigned int __cpufreq_get(struct cpufreq_policy *policy)
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
-- 
2.19.1

