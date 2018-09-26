Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31789C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 03:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2A23214AB
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 03:59:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2A23214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbeIZKJy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 06:09:54 -0400
Received: from shelob.surriel.com ([96.67.55.147]:49930 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbeIZKJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 06:09:53 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <riel@shelob.surriel.com>)
        id 1g50yN-0006sG-To; Tue, 25 Sep 2018 23:58:47 -0400
From:   Rik van Riel <riel@surriel.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, kernel-team@fb.com, will.deacon@arm.com,
        songliubraving@fb.com, mingo@kernel.org, luto@kernel.org,
        hpa@zytor.com, npiggin@gmail.com, Rik van Riel <riel@surriel.com>
Subject: [PATCH 4/7] smp,cpumask: introduce on_each_cpu_cond_mask
Date:   Tue, 25 Sep 2018 23:58:41 -0400
Message-Id: <20180926035844.1420-5-riel@surriel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180926035844.1420-1-riel@surriel.com>
References: <20180926035844.1420-1-riel@surriel.com>
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
index a7d4f9f50a49..163c451af42e 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -669,9 +669,9 @@ EXPORT_SYMBOL(on_each_cpu_mask);
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
@@ -680,7 +680,7 @@ void on_each_cpu_cond(bool (*cond_func)(int cpu, void *info),
 
 	if (likely(zalloc_cpumask_var(&cpus, (gfp_flags|__GFP_NOWARN)))) {
 		preempt_disable();
-		for_each_online_cpu(cpu)
+		for_each_cpu(cpu, mask)
 			if (cond_func(cpu, info))
 				__cpumask_set_cpu(cpu, cpus);
 		on_each_cpu_mask(cpus, func, info, wait);
@@ -692,7 +692,7 @@ void on_each_cpu_cond(bool (*cond_func)(int cpu, void *info),
 		 * just have to IPI them one by one.
 		 */
 		preempt_disable();
-		for_each_online_cpu(cpu)
+		for_each_cpu(cpu, mask)
 			if (cond_func(cpu, info)) {
 				ret = smp_call_function_single(cpu, func,
 								info, wait);
@@ -701,6 +701,15 @@ void on_each_cpu_cond(bool (*cond_func)(int cpu, void *info),
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
2.17.1

