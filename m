Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5588FC04EBB
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 00:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1BAA21479
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 00:34:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1BAA21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727671AbeKULGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 06:06:23 -0500
Received: from mga14.intel.com ([192.55.52.115]:30246 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727100AbeKULFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 06:05:19 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2018 16:33:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,259,1539673200"; 
   d="scan'208";a="93650208"
Received: from skl-02.jf.intel.com ([10.54.74.62])
  by orsmga008.jf.intel.com with ESMTP; 20 Nov 2018 16:33:24 -0800
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
Subject: [Patch v6 07/16] x86/smt: Convert cpu_smt_control check to cpu_smt_enabled static key
Date:   Tue, 20 Nov 2018 15:59:59 -0800
Message-Id: <d928244ca07ab3cc3a9858dbfc11d5d6e2c5f683.1542757030.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <cover.1542757030.git.tim.c.chen@linux.intel.com>
References: <cover.1542757030.git.tim.c.chen@linux.intel.com>
In-Reply-To: <cover.1542757030.git.tim.c.chen@linux.intel.com>
References: <cover.1542757030.git.tim.c.chen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The checks to cpu_smt_control outside of kernel/cpu.c can be converted
to use cpu_smt_enabled key to run SMT specific code.

Save the export of cpu_smt_control and convert usage of cpu_smt_control
to cpu_smt_enabled outside of kernel/cpu.c.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 arch/x86/kernel/cpu/bugs.c | 13 +++++++------
 arch/x86/kvm/vmx.c         |  2 +-
 include/linux/cpu.h        | 12 +++---------
 kernel/cpu.c               | 11 +++++++++--
 4 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index a63456a..3e5ae2c 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -353,15 +353,16 @@ void arch_smt_update(void)
 
 	mutex_lock(&spec_ctrl_mutex);
 	mask = x86_spec_ctrl_base;
-	if (cpu_smt_control == CPU_SMT_ENABLED)
+	if (cpu_use_smt_and_hotplug)
 		mask |= SPEC_CTRL_STIBP;
 	else
 		mask &= ~SPEC_CTRL_STIBP;
 
 	if (mask != x86_spec_ctrl_base) {
-		pr_info("Spectre v2 cross-process SMT mitigation: %s STIBP\n",
-				cpu_smt_control == CPU_SMT_ENABLED ?
-				"Enabling" : "Disabling");
+		if (cpu_use_smt_and_hotplug)
+			pr_info("Spectre v2 cross-process SMT mitigation: Enabling STIBP\n");
+		else
+			pr_info("Spectre v2 cross-process SMT mitigation: Disabling STIBP\n");
 		x86_spec_ctrl_base = mask;
 		on_each_cpu(update_stibp_msr, NULL, 1);
 	}
@@ -844,13 +845,13 @@ static ssize_t l1tf_show_state(char *buf)
 
 	if (l1tf_vmx_mitigation == VMENTER_L1D_FLUSH_EPT_DISABLED ||
 	    (l1tf_vmx_mitigation == VMENTER_L1D_FLUSH_NEVER &&
-	     cpu_smt_control == CPU_SMT_ENABLED))
+	     cpu_use_smt_and_hotplug))
 		return sprintf(buf, "%s; VMX: %s\n", L1TF_DEFAULT_MSG,
 			       l1tf_vmx_states[l1tf_vmx_mitigation]);
 
 	return sprintf(buf, "%s; VMX: %s, SMT %s\n", L1TF_DEFAULT_MSG,
 		       l1tf_vmx_states[l1tf_vmx_mitigation],
-		       cpu_smt_control == CPU_SMT_ENABLED ? "vulnerable" : "disabled");
+		       cpu_use_smt_and_hotplug ? "vulnerable" : "disabled");
 }
 #else
 static ssize_t l1tf_show_state(char *buf)
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 4555077..6c71d4c 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -11607,7 +11607,7 @@ static int vmx_vm_init(struct kvm *kvm)
 			 * Warn upon starting the first VM in a potentially
 			 * insecure environment.
 			 */
-			if (cpu_smt_control == CPU_SMT_ENABLED)
+			if (cpu_use_smt_and_hotplug)
 				pr_warn_once(L1TF_MSG_SMT);
 			if (l1tf_vmx_mitigation == VMENTER_L1D_FLUSH_NEVER)
 				pr_warn_once(L1TF_MSG_L1D);
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index ce8267e..6f43024 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -170,20 +170,14 @@ void cpuhp_report_idle_dead(void);
 static inline void cpuhp_report_idle_dead(void) { }
 #endif /* #ifdef CONFIG_HOTPLUG_CPU */
 
-enum cpuhp_smt_control {
-	CPU_SMT_ENABLED,
-	CPU_SMT_DISABLED,
-	CPU_SMT_FORCE_DISABLED,
-	CPU_SMT_NOT_SUPPORTED,
-};
-
 #if defined(CONFIG_SMP) && defined(CONFIG_HOTPLUG_SMT)
-extern enum cpuhp_smt_control cpu_smt_control;
+DECLARE_STATIC_KEY_TRUE(cpu_smt_enabled);
+#define cpu_use_smt_and_hotplug	(static_branch_likely(&cpu_smt_enabled))
 extern void cpu_smt_disable(bool force);
 extern void cpu_smt_check_topology_early(void);
 extern void cpu_smt_check_topology(void);
 #else
-# define cpu_smt_control		(CPU_SMT_ENABLED)
+#define cpu_use_smt_and_hotplug	false
 static inline void cpu_smt_disable(bool force) { }
 static inline void cpu_smt_check_topology_early(void) { }
 static inline void cpu_smt_check_topology(void) { }
diff --git a/kernel/cpu.c b/kernel/cpu.c
index e216154..f846416 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -368,8 +368,15 @@ static void lockdep_release_cpus_lock(void)
 #endif	/* CONFIG_HOTPLUG_CPU */
 
 #ifdef CONFIG_HOTPLUG_SMT
-enum cpuhp_smt_control cpu_smt_control __read_mostly = CPU_SMT_ENABLED;
-EXPORT_SYMBOL_GPL(cpu_smt_control);
+
+enum cpuhp_smt_control {
+	CPU_SMT_ENABLED,
+	CPU_SMT_DISABLED,
+	CPU_SMT_FORCE_DISABLED,
+	CPU_SMT_NOT_SUPPORTED,
+};
+
+static enum cpuhp_smt_control cpu_smt_control __read_mostly = CPU_SMT_ENABLED;
 DEFINE_STATIC_KEY_TRUE(cpu_smt_enabled);
 EXPORT_SYMBOL_GPL(cpu_smt_enabled);
 
-- 
2.9.4

