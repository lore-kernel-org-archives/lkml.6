Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 271C7C43142
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 21:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E387320862
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 21:55:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E387320862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731557AbeG1XXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 19:23:02 -0400
Received: from shelob.surriel.com ([96.67.55.147]:44138 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731349AbeG1XWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 19:22:20 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1fjXA0-0000QZ-Ld; Sat, 28 Jul 2018 17:54:00 -0400
From:   Rik van Riel <riel@surriel.com>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@fb.com, peterz@infradead.org, luto@kernel.org,
        x86@kernel.org, vkuznets@redhat.com, mingo@kernel.org,
        efault@gmx.de, dave.hansen@intel.com, will.daecon@arm.com,
        catalin.marinas@arm.com, benh@kernel.crashing.org,
        Rik van Riel <riel@surriel.com>
Subject: [PATCH 03/10] smp,cpumask: introduce on_each_cpu_cond_mask
Date:   Sat, 28 Jul 2018 17:53:50 -0400
Message-Id: <20180728215357.3249-4-riel@surriel.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180728215357.3249-1-riel@surriel.com>
References: <20180728215357.3249-1-riel@surriel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a variant of on_each_cpu_cond that iterates only over the
CPUs in a cpumask, in order to avoid making callbacks for every single
CPU in the system when we only need to test a subset.

Signed-off-by: Rik van Riel <riel@surriel.com>
---
 include/linux/smp.h |  4 ++++
 kernel/smp.c        | 17 +++++++++++++----
 kernel/up.c         | 14 +++++++++++---
 3 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/include/linux/smp.h b/include/linux/smp.h
index 9fb239e12b82..a56f08ff3097 100644
--- a/include/linux/smp.h
+++ b/include/linux/smp.h
@@ -53,6 +53,10 @@ void on_each_cpu_cond(bool (*cond_func)(int cpu, void *info),
 		smp_call_func_t func, void *info, bool wait,
 		gfp_t gfp_flags);
 
+void on_each_cpu_cond_mask(bool (*cond_func)(int cpu, void *info),
+		smp_call_func_t func, void *info, bool wait,
+		gfp_t gfp_flags, const struct cpumask *mask);
+
 int smp_call_function_single_async(int cpu, call_single_data_t *csd);
 
 #ifdef CONFIG_SMP
diff --git a/kernel/smp.c b/kernel/smp.c
index 2dbc842dd385..f4cf1b0bb3b8 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -667,9 +667,9 @@ EXPORT_SYMBOL(on_each_cpu_mask);
  * You must not call this function with disabled interrupts or
  * from a hardware interrupt handler or from a bottom half handler.
  */
-void on_each_cpu_cond(bool (*cond_func)(int cpu, void *info),
+void on_each_cpu_cond_mask(bool (*cond_func)(int cpu, void *info),
 			smp_call_func_t func, void *info, bool wait,
-			gfp_t gfp_flags)
+			gfp_t gfp_flags, const struct cpumask *mask)
 {
 	cpumask_var_t cpus;
 	int cpu, ret;
@@ -678,7 +678,7 @@ void on_each_cpu_cond(bool (*cond_func)(int cpu, void *info),
 
 	if (likely(zalloc_cpumask_var(&cpus, (gfp_flags|__GFP_NOWARN)))) {
 		preempt_disable();
-		for_each_online_cpu(cpu)
+		for_each_cpu(cpu, mask)
 			if (cond_func(cpu, info))
 				__cpumask_set_cpu(cpu, cpus);
 		on_each_cpu_mask(cpus, func, info, wait);
@@ -690,7 +690,7 @@ void on_each_cpu_cond(bool (*cond_func)(int cpu, void *info),
 		 * just have to IPI them one by one.
 		 */
 		preempt_disable();
-		for_each_online_cpu(cpu)
+		for_each_cpu(cpu, mask)
 			if (cond_func(cpu, info)) {
 				ret = smp_call_function_single(cpu, func,
 								info, wait);
@@ -699,6 +699,15 @@ void on_each_cpu_cond(bool (*cond_func)(int cpu, void *info),
 		preempt_enable();
 	}
 }
+EXPORT_SYMBOL(on_each_cpu_cond_mask);
+
+void on_each_cpu_cond(bool (*cond_func)(int cpu, void *info),
+			smp_call_func_t func, void *info, bool wait,
+			gfp_t gfp_flags)
+{
+	on_each_cpu_cond_mask(cond_func, func, info, wait, gfp_flags,
+				cpu_online_mask);
+}
 EXPORT_SYMBOL(on_each_cpu_cond);
 
 static void do_nothing(void *unused)
diff --git a/kernel/up.c b/kernel/up.c
index 42c46bf3e0a5..ff536f9cc8a2 100644
--- a/kernel/up.c
+++ b/kernel/up.c
@@ -68,9 +68,9 @@ EXPORT_SYMBOL(on_each_cpu_mask);
  * Preemption is disabled here to make sure the cond_func is called under the
  * same condtions in UP and SMP.
  */
-void on_each_cpu_cond(bool (*cond_func)(int cpu, void *info),
-		      smp_call_func_t func, void *info, bool wait,
-		      gfp_t gfp_flags)
+void on_each_cpu_cond_mask(bool (*cond_func)(int cpu, void *info),
+			   smp_call_func_t func, void *info, bool wait,
+			   gfp_t gfp_flags, const struct cpumask *mask)
 {
 	unsigned long flags;
 
@@ -82,6 +82,14 @@ void on_each_cpu_cond(bool (*cond_func)(int cpu, void *info),
 	}
 	preempt_enable();
 }
+EXPORT_SYMBOL(on_each_cpu_cond_mask);
+
+void on_each_cpu_cond(bool (*cond_func)(int cpu, void *info),
+		      smp_call_func_t func, void *info, bool wait,
+		      gfp_t gfp_flags)
+{
+	on_each_cpu_cond_mask(cond_func, func, info, wait, gfp_flags, NULL);
+}
 EXPORT_SYMBOL(on_each_cpu_cond);
 
 int smp_call_on_cpu(unsigned int cpu, int (*func)(void *), void *par, bool phys)
-- 
2.14.4

