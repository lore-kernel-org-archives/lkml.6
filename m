Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70BEEC64EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3524521479
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 15:00:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3524521479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbeJIWRa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 18:17:30 -0400
Received: from terminus.zytor.com ([198.137.202.136]:53791 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbeJIWR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 18:17:29 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w99Exmrx1081065
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 9 Oct 2018 07:59:48 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w99Exl5R1081062;
        Tue, 9 Oct 2018 07:59:47 -0700
Date:   Tue, 9 Oct 2018 07:59:47 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Rik van Riel <tipbot@zytor.com>
Message-ID: <tip-7d49b28a80b830c3ca876d33bedc58d62a78e16f@git.kernel.org>
Cc:     riel@surriel.com, hpa@zytor.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, tglx@linutronix.de, peterz@infradead.org
Reply-To: linux-kernel@vger.kernel.org, tglx@linutronix.de,
          mingo@kernel.org, peterz@infradead.org, riel@surriel.com,
          hpa@zytor.com
In-Reply-To: <20180926035844.1420-5-riel@surriel.com>
References: <20180926035844.1420-5-riel@surriel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/mm] smp,cpumask: introduce on_each_cpu_cond_mask
Git-Commit-ID: 7d49b28a80b830c3ca876d33bedc58d62a78e16f
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  7d49b28a80b830c3ca876d33bedc58d62a78e16f
Gitweb:     https://git.kernel.org/tip/7d49b28a80b830c3ca876d33bedc58d62a78e16f
Author:     Rik van Riel <riel@surriel.com>
AuthorDate: Tue, 25 Sep 2018 23:58:41 -0400
Committer:  Peter Zijlstra <peterz@infradead.org>
CommitDate: Tue, 9 Oct 2018 16:51:11 +0200

smp,cpumask: introduce on_each_cpu_cond_mask

Introduce a variant of on_each_cpu_cond that iterates only over the
CPUs in a cpumask, in order to avoid making callbacks for every single
CPU in the system when we only need to test a subset.

Cc: npiggin@gmail.com
Cc: mingo@kernel.org
Cc: will.deacon@arm.com
Cc: songliubraving@fb.com
Cc: kernel-team@fb.com
Cc: hpa@zytor.com
Cc: luto@kernel.org
Signed-off-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180926035844.1420-5-riel@surriel.com
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
