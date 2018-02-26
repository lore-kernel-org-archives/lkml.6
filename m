Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752892AbeBZMlA (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 07:41:00 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34574 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752700AbeBZMks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 07:40:48 -0500
X-Google-Smtp-Source: AH8x227GuSKEIjukKeHFSDpax3KUNmiVH5Xr9RajJqECqmDAqAusoz+/sXUDKTuTYG2I1luKRevmnQ==
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: dmatlack@google.com
Subject: [PATCH 2/2] KVM: nVMX: expose VMX capabilities for nested hypervisors to userspace
Date: Mon, 26 Feb 2018 13:40:09 +0100
Message-Id: <1519648809-16694-3-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1519648809-16694-1-git-send-email-pbonzini@redhat.com>
References: <1519648809-16694-1-git-send-email-pbonzini@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new MSR feature framework to tell userspace which VMX capabilities
are available for nested hypervisors.  Before, these were only accessible
with the KVM_GET_MSR VCPU ioctl, after VCPUs had been created.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/vmx.c | 19 +++++++++++++++----
 arch/x86/kvm/x86.c | 19 +++++++++++++++++++
 2 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
index e304e92d37db..2da5a060ecf9 100644
--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -957,6 +957,7 @@ enum {
 	u32 cpu_based_2nd_exec_ctrl;
 	u32 vmexit_ctrl;
 	u32 vmentry_ctrl;
+	struct nested_vmx_msrs nested;
 } vmcs_config;
 
 static struct vmx_capability {
@@ -2688,6 +2689,11 @@ static inline bool nested_vmx_allowed(struct kvm_vcpu *vcpu)
  */
 static void nested_vmx_setup_ctls_msrs(struct nested_vmx_msrs *msrs, bool apicv)
 {
+	if (!nested) {
+		memset(msrs, 0, sizeof(*msrs));
+		return;
+	}
+
 	/*
 	 * Note that as a general rule, the high half of the MSRs (bits in
 	 * the control fields which may be 1) should be initialized by the
@@ -2712,13 +2718,11 @@ static void nested_vmx_setup_ctls_msrs(struct nested_vmx_msrs *msrs, bool apicv)
 	msrs->pinbased_ctls_high &=
 		PIN_BASED_EXT_INTR_MASK |
 		PIN_BASED_NMI_EXITING |
-		PIN_BASED_VIRTUAL_NMIS;
+		PIN_BASED_VIRTUAL_NMIS |
+		(apicv ? PIN_BASED_POSTED_INTR : 0);
 	msrs->pinbased_ctls_high |=
 		PIN_BASED_ALWAYSON_WITHOUT_TRUE_MSR |
 		PIN_BASED_VMX_PREEMPTION_TIMER;
-	if (apicv)
-		msrs->pinbased_ctls_high |=
-			PIN_BASED_POSTED_INTR;
 
 	/* exit controls */
 	rdmsr(MSR_IA32_VMX_EXIT_CTLS,
@@ -3231,6 +3235,10 @@ static inline bool vmx_feature_control_msr_valid(struct kvm_vcpu *vcpu,
 static int vmx_get_msr_feature(struct kvm_msr_entry *msr)
 {
 	switch (msr->index) {
+	case MSR_IA32_VMX_BASIC ... MSR_IA32_VMX_VMFUNC:
+		if (!nested)
+			return 1;
+		return vmx_get_vmx_msr(&vmcs_config.nested, msr->index, &msr->data);
 	case MSR_IA32_ARCH_CAPABILITIES:
 		if (!boot_cpu_has(X86_FEATURE_ARCH_CAPABILITIES))
 			return 1;
@@ -3706,6 +3714,7 @@ static __init int setup_vmcs_config(struct vmcs_config *vmcs_conf)
 	u32 _vmexit_control = 0;
 	u32 _vmentry_control = 0;
 
+	memset(vmcs_conf, 0, sizeof(*vmcs_conf));
 	min = CPU_BASED_HLT_EXITING |
 #ifdef CONFIG_X86_64
 	      CPU_BASED_CR8_LOAD_EXITING |
@@ -7099,6 +7108,7 @@ static __init int hardware_setup(void)
 		init_vmcs_shadow_fields();
 
 	kvm_set_posted_intr_wakeup_handler(wakeup_handler);
+	nested_vmx_setup_ctls_msrs(&vmcs_config.nested, enable_apicv);
 
 	kvm_mce_cap_supported |= MCG_LMCE_P;
 
@@ -9830,6 +9840,7 @@ static void __init vmx_check_processor_compat(void *rtn)
 	*(int *)rtn = 0;
 	if (setup_vmcs_config(&vmcs_conf) < 0)
 		*(int *)rtn = -EIO;
+	nested_vmx_setup_ctls_msrs(&vmcs_conf.nested, enable_apicv);
 	if (memcmp(&vmcs_config, &vmcs_conf, sizeof(struct vmcs_config)) != 0) {
 		printk(KERN_ERR "kvm: CPU %d feature inconsistency!\n",
 				smp_processor_id());
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index d4985a94ef98..fe12715ff50d 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1056,6 +1056,25 @@ bool kvm_rdpmc(struct kvm_vcpu *vcpu)
  * can be used by a hypervisor to validate requested CPU features.
  */
 static u32 msr_based_features[] = {
+	MSR_IA32_VMX_BASIC,
+	MSR_IA32_VMX_TRUE_PINBASED_CTLS,
+	MSR_IA32_VMX_PINBASED_CTLS,
+	MSR_IA32_VMX_TRUE_PROCBASED_CTLS,
+	MSR_IA32_VMX_PROCBASED_CTLS,
+	MSR_IA32_VMX_TRUE_EXIT_CTLS,
+	MSR_IA32_VMX_EXIT_CTLS,
+	MSR_IA32_VMX_TRUE_ENTRY_CTLS,
+	MSR_IA32_VMX_ENTRY_CTLS,
+	MSR_IA32_VMX_MISC,
+	MSR_IA32_VMX_CR0_FIXED0,
+	MSR_IA32_VMX_CR0_FIXED1,
+	MSR_IA32_VMX_CR4_FIXED0,
+	MSR_IA32_VMX_CR4_FIXED1,
+	MSR_IA32_VMX_VMCS_ENUM,
+	MSR_IA32_VMX_PROCBASED_CTLS2,
+	MSR_IA32_VMX_EPT_VPID_CAP,
+	MSR_IA32_VMX_VMFUNC,
+
 	MSR_IA32_ARCH_CAPABILITIES,
 	MSR_F10H_DECFG,
 };
-- 
1.8.3.1
