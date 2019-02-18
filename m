Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52CD0C10F01
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2211621902
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550497511;
	bh=hNSa5Wm6r7qeZf6tTCegsLJBqXCixmJU4Gn3zEia/O0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=a5mO/VdATzmM2JLg80KQwl/epMY35o/g3yd2uBhXXFYe6GRONBR7uXw75KjfGMl/q
	 0Gv4JJZV75o70vdj2/4Uf0iNPh7XXC4r2W1zr1/94dBnzrGsvsLy+ebDJoiy/P6nkL
	 70X2nqADawA/GfKwJHoxoziTzR0ppzvzncAfbKuk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731245AbfBRNpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:45:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:51084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731222AbfBRNpG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:45:06 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC584217F5;
        Mon, 18 Feb 2019 13:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550497505;
        bh=hNSa5Wm6r7qeZf6tTCegsLJBqXCixmJU4Gn3zEia/O0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yyskbN1k0I19vsUAAA1de+HCUpVWZZDyq6so6uunkgSNi4tVZ92SsCHVmIakwmzYS
         ZAzis/mg90+RbY9jODk98IFwwFU+KIMeXVfSY9Y8SWDrlOG8XRVSGPrHUr1iFW9bJK
         JZmsBVpTwWf+36oMyN8DvYqgR1FSWQUiiPFzus+c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 12/92] cpufreq: check if policy is inactive early in __cpufreq_get()
Date:   Mon, 18 Feb 2019 14:42:15 +0100
Message-Id: <20190218133455.804291561@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133454.668268457@linuxfoundation.org>
References: <20190218133454.668268457@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

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



