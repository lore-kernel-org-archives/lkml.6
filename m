Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 168D7C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 00:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D63D721527
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 00:42:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D63D721527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbeKULO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 06:14:28 -0500
Received: from mga12.intel.com ([192.55.52.136]:16663 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727188AbeKULOH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 06:14:07 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2018 16:42:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,259,1539673200"; 
   d="scan'208";a="251346858"
Received: from skl-02.jf.intel.com ([10.54.74.62])
  by orsmga004.jf.intel.com with ESMTP; 20 Nov 2018 16:42:05 -0800
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
        Greg KH <gregkh@linuxfoundation.org>,
        Dave Stewart <david.c.stewart@intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        stable@vger.kernel.org
Subject: [Patch v7 18/18] x86/smt: Allow disabling of SMT when last SMT is offlined
Date:   Tue, 20 Nov 2018 16:08:57 -0800
Message-Id: <e48e75a70ec4a821caa0cf2393a0554d619afdd0.1542758656.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <cover.1542758656.git.tim.c.chen@linux.intel.com>
References: <cover.1542758656.git.tim.c.chen@linux.intel.com>
In-Reply-To: <cover.1542758656.git.tim.c.chen@linux.intel.com>
References: <cover.1542758656.git.tim.c.chen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently cpu_use_smt_and_hotplug is only set during boot time
to indicate if SMT is in use.

However, CPU topology may change and when the last SMT thread is offlined,
the SMT code path can be skipped.  The sched_smt_present key detects
this condition.

Export sched_smt_present and incorporate it into cpu_use_smt_and_hotplug
to disable SMT code when there are no paired siblings.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 include/linux/cpu.h  | 12 ++++++++++++
 kernel/sched/sched.h |  2 --
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 4fef90a..2fc649d 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -100,6 +100,10 @@ static inline void cpu_maps_update_done(void)
 #endif /* CONFIG_SMP */
 extern struct bus_type cpu_subsys;
 
+#ifdef CONFIG_SCHED_SMT
+extern struct static_key_false sched_smt_present;
+#endif
+
 #ifdef CONFIG_HOTPLUG_CPU
 extern void cpus_write_lock(void);
 extern void cpus_write_unlock(void);
@@ -172,7 +176,15 @@ static inline void cpuhp_report_idle_dead(void) { }
 
 #if defined(CONFIG_SMP) && defined(CONFIG_HOTPLUG_SMT)
 DECLARE_STATIC_KEY_TRUE(cpu_smt_enabled);
+
+#ifdef CONFIG_SCHED_SMT
+#define cpu_use_smt_and_hotplug				\
+	(static_branch_likely(&cpu_smt_enabled) &&	\
+	 static_branch_unlikely(&sched_smt_present))
+#else
 #define cpu_use_smt_and_hotplug	(static_branch_likely(&cpu_smt_enabled))
+#endif
+
 extern void cpu_smt_disable(bool force);
 extern void cpu_smt_check_topology_early(void);
 extern void cpu_smt_check_topology(void);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 618577f..e1e3f09 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -937,8 +937,6 @@ static inline int cpu_of(struct rq *rq)
 
 #ifdef CONFIG_SCHED_SMT
 
-extern struct static_key_false sched_smt_present;
-
 extern void __update_idle_core(struct rq *rq);
 
 static inline void update_idle_core(struct rq *rq)
-- 
2.9.4

