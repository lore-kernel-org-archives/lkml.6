Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D47ECDE39
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 18:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26F8621476
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 18:32:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26F8621476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbeJRC3w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 22:29:52 -0400
Received: from mga12.intel.com ([192.55.52.136]:29659 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728348AbeJRC3w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 22:29:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Oct 2018 11:32:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,393,1534834800"; 
   d="scan'208";a="82003891"
Received: from skl-02.jf.intel.com ([10.54.74.62])
  by orsmga007.jf.intel.com with ESMTP; 17 Oct 2018 11:32:56 -0700
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
        Jon Masters <jcm@redhat.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: [Patch v3 05/13] x86/smt: Create cpu_smt_enabled static key for SMT specific code
Date:   Wed, 17 Oct 2018 10:59:33 -0700
Message-Id: <ed49c63227dcfa8fd6e53c492e38ce0e22a5b11f.1539798901.git.tim.c.chen@linux.intel.com>
X-Mailer: git-send-email 2.9.4
In-Reply-To: <cover.1539798901.git.tim.c.chen@linux.intel.com>
References: <cover.1539798901.git.tim.c.chen@linux.intel.com>
In-Reply-To: <cover.1539798901.git.tim.c.chen@linux.intel.com>
References: <cover.1539798901.git.tim.c.chen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create the cpu_smt_enabled static key to indicate if we are
using SMT.  SMT specific code paths are executed only when SMT
code paths are enabled by this key.

Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
---
 arch/x86/kernel/cpu/bugs.c |  2 +-
 arch/x86/kvm/vmx.c         |  2 +-
 include/linux/cpu.h        |  1 +
 kernel/cpu.c               | 12 ++++++++++--
 4 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 6ed82ea..0338fa1 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -358,7 +358,7 @@ void arch_smt_update(void)
 
 	mutex_lock(&spec_ctrl_mutex);
 	mask = x86_spec_ctrl_base;
-	if (cpu_smt_control == CPU_SMT_ENABLED)
+	if (static_branch_likely(&cpu_smt_enabled))
 		mask |= SPEC_CTRL_STIBP;
 	else
 		mask &= ~SPEC_CTRL_STIBP;
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 533a327..8ec0ea3 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -11072,7 +11072,7 @@ static int vmx_vm_init(struct kvm *kvm)
 			 * Warn upon starting the first VM in a potentially
 			 * insecure environment.
 			 */
-			if (cpu_smt_control == CPU_SMT_ENABLED)
+			if (static_branch_likely(&cpu_smt_enabled))
 				pr_warn_once(L1TF_MSG_SMT);
 			if (l1tf_vmx_mitigation == VMENTER_L1D_FLUSH_NEVER)
 				pr_warn_once(L1TF_MSG_L1D);
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 218df7f..b54f085 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -188,5 +188,6 @@ static inline void cpu_smt_disable(bool force) { }
 static inline void cpu_smt_check_topology_early(void) { }
 static inline void cpu_smt_check_topology(void) { }
 #endif
+DECLARE_STATIC_KEY_TRUE(cpu_smt_enabled);
 
 #endif /* _LINUX_CPU_H_ */
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 3adecda..ad28afc 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -349,6 +349,8 @@ EXPORT_SYMBOL_GPL(cpu_hotplug_enable);
 #ifdef CONFIG_HOTPLUG_SMT
 enum cpuhp_smt_control cpu_smt_control __read_mostly = CPU_SMT_ENABLED;
 EXPORT_SYMBOL_GPL(cpu_smt_control);
+DEFINE_STATIC_KEY_TRUE(cpu_smt_enabled);
+EXPORT_SYMBOL_GPL(cpu_smt_enabled);
 
 static bool cpu_smt_available __read_mostly;
 
@@ -364,6 +366,7 @@ void __init cpu_smt_disable(bool force)
 	} else {
 		cpu_smt_control = CPU_SMT_DISABLED;
 	}
+	static_branch_disable(&cpu_smt_enabled);	
 }
 
 /*
@@ -373,8 +376,10 @@ void __init cpu_smt_disable(bool force)
  */
 void __init cpu_smt_check_topology_early(void)
 {
-	if (!topology_smt_supported())
+	if (!topology_smt_supported()) {
 		cpu_smt_control = CPU_SMT_NOT_SUPPORTED;
+		static_branch_disable(&cpu_smt_enabled);	
+	}
 }
 
 /*
@@ -386,8 +391,10 @@ void __init cpu_smt_check_topology_early(void)
  */
 void __init cpu_smt_check_topology(void)
 {
-	if (!cpu_smt_available)
+	if (!cpu_smt_available) {
 		cpu_smt_control = CPU_SMT_NOT_SUPPORTED;
+		static_branch_disable(&cpu_smt_enabled);	
+	}
 }
 
 static int __init smt_cmdline_disable(char *str)
@@ -2072,6 +2079,7 @@ static int cpuhp_smt_enable(void)
 
 	cpu_maps_update_begin();
 	cpu_smt_control = CPU_SMT_ENABLED;
+	static_branch_enable(&cpu_smt_enabled);
 	arch_smt_update();
 	for_each_present_cpu(cpu) {
 		/* Skip online CPUs and CPUs on offline nodes */
-- 
2.9.4

