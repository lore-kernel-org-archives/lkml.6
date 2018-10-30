Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A1A8C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 19:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A62F2081B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 19:22:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A62F2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbeJaER1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 00:17:27 -0400
Received: from mga11.intel.com ([192.55.52.93]:23880 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728011AbeJaER0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 00:17:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Oct 2018 12:22:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,445,1534834800"; 
   d="scan'208";a="103876764"
Received: from skl-02.jf.intel.com ([10.54.74.62])
  by fmsmga001.fm.intel.com with ESMTP; 30 Oct 2018 12:22:41 -0700
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Casey Schaufler <casey.schaufler@intel.com>,
        Asit Mallick <asit.k.mallick@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Jon Masters <jcm@redhat.com>,
        Waiman Long <longman9394@gmail.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [Patch v4 08/18] sched: Deprecate sched_smt_present and use cpu_smt_enabled static key
Date:   Tue, 30 Oct 2018 11:49:15 -0700
Message-Id: <a3035781690278fdea781f4d718917985994e0af.1540923609.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <cover.1540923609.git.tim.c.chen@linux.intel.com>
References: <cover.1540923609.git.tim.c.chen@linux.intel.com>
In-Reply-To: <cover.1540923609.git.tim.c.chen@linux.intel.com>
References: <cover.1540923609.git.tim.c.chen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cpu_smt_enabled static key serves identical purpose as cpu_smt_enabled
to enable SMT specific code.

This patch replaces sched_smt_present in the scheduler with
cpu_smt_enabled and deprecate sched_smt_present.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 kernel/sched/core.c  | 12 ------------
 kernel/sched/fair.c  |  6 ++----
 kernel/sched/sched.h |  4 +---
 3 files changed, 3 insertions(+), 19 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 625bc98..a06b157 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5739,18 +5739,6 @@ int sched_cpu_activate(unsigned int cpu)
 	struct rq *rq = cpu_rq(cpu);
 	struct rq_flags rf;
 
-#ifdef CONFIG_SCHED_SMT
-	/*
-	 * The sched_smt_present static key needs to be evaluated on every
-	 * hotplug event because at boot time SMT might be disabled when
-	 * the number of booted CPUs is limited.
-	 *
-	 * If then later a sibling gets hotplugged, then the key would stay
-	 * off and SMT scheduling would never be functional.
-	 */
-	if (cpumask_weight(cpu_smt_mask(cpu)) > 1)
-		static_branch_enable_cpuslocked(&sched_smt_present);
-#endif
 	set_cpu_active(cpu, true);
 
 	if (sched_smp_initialized) {
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b39fb59..4899bb1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5839,8 +5839,6 @@ static inline int find_idlest_cpu(struct sched_domain *sd, struct task_struct *p
 }
 
 #ifdef CONFIG_SCHED_SMT
-DEFINE_STATIC_KEY_FALSE(sched_smt_present);
-
 static inline void set_idle_cores(int cpu, int val)
 {
 	struct sched_domain_shared *sds;
@@ -5900,7 +5898,7 @@ static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int
 	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
 	int core, cpu;
 
-	if (!static_branch_likely(&sched_smt_present))
+	if (!static_branch_likely(&cpu_smt_enabled))
 		return -1;
 
 	if (!test_idle_cores(target, false))
@@ -5936,7 +5934,7 @@ static int select_idle_smt(struct task_struct *p, struct sched_domain *sd, int t
 {
 	int cpu;
 
-	if (!static_branch_likely(&sched_smt_present))
+	if (!static_branch_likely(&cpu_smt_enabled))
 		return -1;
 
 	for_each_cpu(cpu, cpu_smt_mask(target)) {
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 4a2e8ca..5adba57 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -928,13 +928,11 @@ static inline int cpu_of(struct rq *rq)
 
 #ifdef CONFIG_SCHED_SMT
 
-extern struct static_key_false sched_smt_present;
-
 extern void __update_idle_core(struct rq *rq);
 
 static inline void update_idle_core(struct rq *rq)
 {
-	if (static_branch_unlikely(&sched_smt_present))
+	if (static_branch_likely(&cpu_smt_enabled))
 		__update_idle_core(rq);
 }
 
-- 
2.9.4

