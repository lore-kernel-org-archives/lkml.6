Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BAA9C46473
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EF512168D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 17:37:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EF512168D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731750AbeHNUZK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 16:25:10 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57836 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731452AbeHNUZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 16:25:09 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2F4E2CBA;
        Tue, 14 Aug 2018 17:36:58 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.14 035/104] sched/smt: Update sched_smt_present at runtime
Date:   Tue, 14 Aug 2018 19:16:49 +0200
Message-Id: <20180814171517.554611924@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180814171515.270692185@linuxfoundation.org>
References: <20180814171515.270692185@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Peter Zijlstra <peterz@infradead.org>

commit ba2591a5993eabcc8e874e30f361d8ffbb10d6d4 upstream

The static key sched_smt_present is only updated at boot time when SMT
siblings have been detected. Booting with maxcpus=1 and bringing the
siblings online after boot rebuilds the scheduling domains correctly but
does not update the static key, so the SMT code is not enabled.

Let the key be updated in the scheduler CPU hotplug code to fix this.

Signed-off-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Acked-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/sched/core.c |   30 ++++++++++++------------------
 kernel/sched/fair.c |    1 +
 2 files changed, 13 insertions(+), 18 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5615,6 +5615,18 @@ int sched_cpu_activate(unsigned int cpu)
 	struct rq *rq = cpu_rq(cpu);
 	struct rq_flags rf;
 
+#ifdef CONFIG_SCHED_SMT
+	/*
+	 * The sched_smt_present static key needs to be evaluated on every
+	 * hotplug event because at boot time SMT might be disabled when
+	 * the number of booted CPUs is limited.
+	 *
+	 * If then later a sibling gets hotplugged, then the key would stay
+	 * off and SMT scheduling would never be functional.
+	 */
+	if (cpumask_weight(cpu_smt_mask(cpu)) > 1)
+		static_branch_enable_cpuslocked(&sched_smt_present);
+#endif
 	set_cpu_active(cpu, true);
 
 	if (sched_smp_initialized) {
@@ -5710,22 +5722,6 @@ int sched_cpu_dying(unsigned int cpu)
 }
 #endif
 
-#ifdef CONFIG_SCHED_SMT
-DEFINE_STATIC_KEY_FALSE(sched_smt_present);
-
-static void sched_init_smt(void)
-{
-	/*
-	 * We've enumerated all CPUs and will assume that if any CPU
-	 * has SMT siblings, CPU0 will too.
-	 */
-	if (cpumask_weight(cpu_smt_mask(0)) > 1)
-		static_branch_enable(&sched_smt_present);
-}
-#else
-static inline void sched_init_smt(void) { }
-#endif
-
 void __init sched_init_smp(void)
 {
 	cpumask_var_t non_isolated_cpus;
@@ -5755,8 +5751,6 @@ void __init sched_init_smp(void)
 	init_sched_rt_class();
 	init_sched_dl_class();
 
-	sched_init_smt();
-
 	sched_smp_initialized = true;
 }
 
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5631,6 +5631,7 @@ find_idlest_cpu(struct sched_group *grou
 }
 
 #ifdef CONFIG_SCHED_SMT
+DEFINE_STATIC_KEY_FALSE(sched_smt_present);
 
 static inline void set_idle_cores(int cpu, int val)
 {


