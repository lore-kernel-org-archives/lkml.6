Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC5CC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 02:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05F612075B
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 02:27:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05F612075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731234AbeKQMml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 07:42:41 -0500
Received: from mga14.intel.com ([192.55.52.115]:45898 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727116AbeKQMmk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 07:42:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Nov 2018 18:27:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,242,1539673200"; 
   d="scan'208";a="281852614"
Received: from skl-02.jf.intel.com ([10.54.74.62])
  by fmsmga006.fm.intel.com with ESMTP; 16 Nov 2018 18:27:44 -0800
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
Subject: [Patch v5 09/16] x86/smt: Convert cpu_smt_control check to cpu_smt_enabled static key
Date:   Fri, 16 Nov 2018 17:53:52 -0800
Message-Id: <ff3d60388c52043b477a16100b76114c6d8fbaee.1542418937.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <cover.1542418936.git.tim.c.chen@linux.intel.com>
References: <cover.1542418936.git.tim.c.chen@linux.intel.com>
In-Reply-To: <cover.1542418936.git.tim.c.chen@linux.intel.com>
References: <cover.1542418936.git.tim.c.chen@linux.intel.com>
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
 arch/x86/kernel/cpu/bugs.c | 21 +++++++++++++++------
 arch/x86/kvm/vmx.c         |  2 +-
 include/linux/cpu.h        |  8 --------
 kernel/cpu.c               |  9 ++++++++-
 4 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index e4cfc4a..6e1b910 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -356,15 +356,16 @@ void arch_smt_update(void)
 
 	mutex_lock(&spec_ctrl_mutex);
 	mask = x86_spec_ctrl_base;
-	if (cpu_smt_control == CPU_SMT_ENABLED)
+	if (static_branch_likely(&cpu_smt_enabled))
 		mask |= SPEC_CTRL_STIBP;
 	else
 		mask &= ~SPEC_CTRL_STIBP;
 
 	if (mask != x86_spec_ctrl_base) {
-		pr_info("Spectre v2 cross-process SMT mitigation: %s STIBP\n",
-				cpu_smt_control == CPU_SMT_ENABLED ?
-				"Enabling" : "Disabling");
+		if (static_branch_likely(&cpu_smt_enabled))
+			pr_info("Spectre v2 cross-process SMT mitigation: Enabling STIBP\n");
+		else
+			pr_info("Spectre v2 cross-process SMT mitigation: Disabling STIBP\n");
 		x86_spec_ctrl_base = mask;
 		on_each_cpu(update_stibp_msr, NULL, 1);
 	}
@@ -840,6 +841,14 @@ static const char *l1tf_vmx_states[] = {
 	[VMENTER_L1D_FLUSH_NOT_REQUIRED]	= "flush not necessary"
 };
 
+static char *l1tf_show_smt_vulnerable(void)
+{
+	if (static_branch_likely(&cpu_smt_enabled))
+		return "vulnerable";
+	else
+		return "disabled";
+}
+
 static ssize_t l1tf_show_state(char *buf)
 {
 	if (l1tf_vmx_mitigation == VMENTER_L1D_FLUSH_AUTO)
@@ -847,13 +856,13 @@ static ssize_t l1tf_show_state(char *buf)
 
 	if (l1tf_vmx_mitigation == VMENTER_L1D_FLUSH_EPT_DISABLED ||
 	    (l1tf_vmx_mitigation == VMENTER_L1D_FLUSH_NEVER &&
-	     cpu_smt_control == CPU_SMT_ENABLED))
+	     static_branch_likely(&cpu_smt_enabled)))
 		return sprintf(buf, "%s; VMX: %s\n", L1TF_DEFAULT_MSG,
 			       l1tf_vmx_states[l1tf_vmx_mitigation]);
 
 	return sprintf(buf, "%s; VMX: %s, SMT %s\n", L1TF_DEFAULT_MSG,
 		       l1tf_vmx_states[l1tf_vmx_mitigation],
-		       cpu_smt_control == CPU_SMT_ENABLED ? "vulnerable" : "disabled");
+		       l1tf_show_smt_vulnerable());
 }
 #else
 static ssize_t l1tf_show_state(char *buf)
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 4555077..accfd2c 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -11607,7 +11607,7 @@ static int vmx_vm_init(struct kvm *kvm)
 			 * Warn upon starting the first VM in a potentially
 			 * insecure environment.
 			 */
-			if (cpu_smt_control == CPU_SMT_ENABLED)
+			if (static_branch_likely(&cpu_smt_enabled))
 				pr_warn_once(L1TF_MSG_SMT);
 			if (l1tf_vmx_mitigation == VMENTER_L1D_FLUSH_NEVER)
 				pr_warn_once(L1TF_MSG_L1D);
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index b54f085..00af2ae 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -170,15 +170,7 @@ void cpuhp_report_idle_dead(void);
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
 extern void cpu_smt_disable(bool force);
 extern void cpu_smt_check_topology_early(void);
 extern void cpu_smt_check_topology(void);
diff --git a/kernel/cpu.c b/kernel/cpu.c
index e216154..54cf3f6 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -368,8 +368,15 @@ static void lockdep_release_cpus_lock(void)
 #endif	/* CONFIG_HOTPLUG_CPU */
 
 #ifdef CONFIG_HOTPLUG_SMT
+
+enum cpuhp_smt_control {
+        CPU_SMT_ENABLED,
+        CPU_SMT_DISABLED,
+        CPU_SMT_FORCE_DISABLED,
+        CPU_SMT_NOT_SUPPORTED,
+};
+
 enum cpuhp_smt_control cpu_smt_control __read_mostly = CPU_SMT_ENABLED;
-EXPORT_SYMBOL_GPL(cpu_smt_control);
 DEFINE_STATIC_KEY_TRUE(cpu_smt_enabled);
 EXPORT_SYMBOL_GPL(cpu_smt_enabled);
 
-- 
2.9.4

