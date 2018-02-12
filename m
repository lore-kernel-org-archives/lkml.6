Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753437AbeBLP2F (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 10:28:05 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:32897 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753101AbeBLP1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 10:27:48 -0500
X-IronPort-AV: E=Sophos;i="5.46,501,1511827200";
   d="scan'208";a="707845461"
From: David Woodhouse <dwmw@amazon.co.uk>
To: tglx@linutronix.de, x86@kernel.org, kvm@vger.kernel.org,
        torvalds@linux-foundation.org, pbonzini@redhat.com,
        linux-kernel@vger.kernel.org, arjan.van.de.ven@intel.com,
        dave.hansen@intel.com
Subject: [PATCH 2/2] x86/speculation: Support "Enhanced IBRS" on future CPUs
Date: Mon, 12 Feb 2018 15:27:35 +0000
Message-Id: <1518449255-2182-2-git-send-email-dwmw@amazon.co.uk>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518449255-2182-1-git-send-email-dwmw@amazon.co.uk>
References: <1518449255-2182-1-git-send-email-dwmw@amazon.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original IBRS hack in microcode is horribly slow. For the next
generation of CPUs, as a stopgap until we get a proper fix, Intel
promise an "Enhanced IBRS" which will be fast.

The assumption is that predictions in the BTB/RSB will be tagged with
the VMX mode and ring that they were learned in, and thus the CPU will
avoid consuming unsafe predictions without a performance penalty.

Intel's documentation says that it is still required to set the IBRS bit
in the SPEC_CTRL MSR and ensure that it remains set.

Cope with this by trapping and emulating *all* access to SPEC_CTRL from
KVM guests when the IBRS_ALL feature is present, so it can never be
turned off. Guests who see IBRS_ALL should never do anything except
turn it on at boot anyway. And if they didn't know about IBRS_ALL and
they keep frobbing IBRS on every kernel entry/exit... well the vmexit
for a no-op is probably going to be faster than they were expecting
anyway, so they'll live.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Acked-by: Arjan van de Ven <arjan.van.de.ven@intel.com>
---
 arch/x86/include/asm/nospec-branch.h |  9 ++++++++-
 arch/x86/kernel/cpu/bugs.c           | 16 ++++++++++++++--
 arch/x86/kvm/vmx.c                   | 17 ++++++++++-------
 3 files changed, 32 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 788c4da..524bb86 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -140,9 +140,16 @@ enum spectre_v2_mitigation {
 	SPECTRE_V2_RETPOLINE_MINIMAL_AMD,
 	SPECTRE_V2_RETPOLINE_GENERIC,
 	SPECTRE_V2_RETPOLINE_AMD,
-	SPECTRE_V2_IBRS,
+	SPECTRE_V2_IBRS_ALL,
 };
 
+extern enum spectre_v2_mitigation spectre_v2_enabled;
+
+static inline bool spectre_v2_ibrs_all(void)
+{
+	return spectre_v2_enabled == SPECTRE_V2_IBRS_ALL;
+}
+
 extern char __indirect_thunk_start[];
 extern char __indirect_thunk_end[];
 
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index debcdda..047538a 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -88,12 +88,13 @@ static const char *spectre_v2_strings[] = {
 	[SPECTRE_V2_RETPOLINE_MINIMAL_AMD]	= "Vulnerable: Minimal AMD ASM retpoline",
 	[SPECTRE_V2_RETPOLINE_GENERIC]		= "Mitigation: Full generic retpoline",
 	[SPECTRE_V2_RETPOLINE_AMD]		= "Mitigation: Full AMD retpoline",
+	[SPECTRE_V2_IBRS_ALL]			= "Mitigation: Enhanced IBRS",
 };
 
 #undef pr_fmt
 #define pr_fmt(fmt)     "Spectre V2 : " fmt
 
-static enum spectre_v2_mitigation spectre_v2_enabled = SPECTRE_V2_NONE;
+enum spectre_v2_mitigation spectre_v2_enabled = SPECTRE_V2_NONE;
 
 #ifdef RETPOLINE
 static bool spectre_v2_bad_module;
@@ -237,6 +238,16 @@ static void __init spectre_v2_select_mitigation(void)
 
 	case SPECTRE_V2_CMD_FORCE:
 	case SPECTRE_V2_CMD_AUTO:
+		if (boot_cpu_has(X86_FEATURE_ARCH_CAPABILITIES)) {
+			u64 ia32_cap = 0;
+
+			rdmsrl(MSR_IA32_ARCH_CAPABILITIES, ia32_cap);
+			if (ia32_cap & ARCH_CAP_IBRS_ALL) {
+				mode = SPECTRE_V2_IBRS_ALL;
+				wrmsrl(MSR_IA32_SPEC_CTRL, SPEC_CTRL_IBRS);
+				goto ibrs_all;
+			}
+		}
 		if (IS_ENABLED(CONFIG_RETPOLINE))
 			goto retpoline_auto;
 		break;
@@ -274,6 +285,7 @@ static void __init spectre_v2_select_mitigation(void)
 		setup_force_cpu_cap(X86_FEATURE_RETPOLINE);
 	}
 
+ ibrs_all:
 	spectre_v2_enabled = mode;
 	pr_info("%s\n", spectre_v2_strings[mode]);
 
@@ -306,7 +318,7 @@ static void __init spectre_v2_select_mitigation(void)
 	 * branches. But we don't know whether the firmware is safe, so
 	 * use IBRS to protect against that:
 	 */
-	if (boot_cpu_has(X86_FEATURE_IBRS)) {
+	if (mode != SPECTRE_V2_IBRS_ALL && boot_cpu_has(X86_FEATURE_IBRS)) {
 		setup_force_cpu_cap(X86_FEATURE_USE_IBRS_FW);
 		pr_info("Spectre mitigation: Restricting branch speculation (enabling IBRS) for firmware calls\n");
 	}
diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index 91e3539..d99ba9b 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -3419,13 +3419,14 @@ static int vmx_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 
 		vmx->spec_ctrl = data;
 
-		if (!data)
+		if (!data && !spectre_v2_ibrs_all())
 			break;
 
 		/*
 		 * For non-nested:
 		 * When it's written (to non-zero) for the first time, pass
-		 * it through.
+		 * it through unless we have IBRS_ALL and it should just be
+		 * set for ever.
 		 *
 		 * For nested:
 		 * The handling of the MSR bitmap for L2 guests is done in
@@ -9441,7 +9442,7 @@ static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
 	 * is no need to worry about the conditional branch over the wrmsr
 	 * being speculatively taken.
 	 */
-	if (vmx->spec_ctrl)
+	if (vmx->spec_ctrl && !spectre_v2_ibrs_all())
 		wrmsrl(MSR_IA32_SPEC_CTRL, vmx->spec_ctrl);
 
 	vmx->__launched = vmx->loaded_vmcs->launched;
@@ -9577,11 +9578,13 @@ static void __noclone vmx_vcpu_run(struct kvm_vcpu *vcpu)
 	 * If the L02 MSR bitmap does not intercept the MSR, then we need to
 	 * save it.
 	 */
-	if (!msr_write_intercepted(vcpu, MSR_IA32_SPEC_CTRL))
-		rdmsrl(MSR_IA32_SPEC_CTRL, vmx->spec_ctrl);
+	if (!spectre_v2_ibrs_all) {
+		if (!msr_write_intercepted(vcpu, MSR_IA32_SPEC_CTRL))
+			rdmsrl(MSR_IA32_SPEC_CTRL, vmx->spec_ctrl);
 
-	if (vmx->spec_ctrl)
-		wrmsrl(MSR_IA32_SPEC_CTRL, 0);
+		if (vmx->spec_ctrl)
+			wrmsrl(MSR_IA32_SPEC_CTRL, 0);
+	}
 
 	/* Eliminate branch target predictions from guest mode */
 	vmexit_fill_RSB();
-- 
2.7.4
